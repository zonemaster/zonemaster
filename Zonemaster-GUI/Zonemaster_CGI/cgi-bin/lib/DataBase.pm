package DataBase;
use strict;
use warnings;
use Carp;

sub new {
    my $this  = shift;
    my $class = ref($this) || $this;
    my $self  = {};
    $self->{env} = shift;
    croak 'Invalid environment passed'
      unless ( defined( $self->{env} ) && ref( $self->{env} ) );
    croak 'Failed database connection'
          unless ( $self->{env}->db
            && ref( $self->{env}->db )
            && $self->{env}->db->ping );
    bless $self, $class;
}

sub all {
    my $self       = shift;
    my $table_name = shift;
    &_validate_parameters( $self, $table_name );
    $table_name =~ s/^\s+|\s+$//sg;
    my $tag = @_ ? shift : '';
    my $query = $self->db->prepare( "SELECT * FROM \`$table_name\` " . $tag );
    $query->execute;
    my @resulting_array;

    while ( my $hashref = $query->fetchrow_hashref ) {
        push @resulting_array, $hashref;
    }
    return @resulting_array if wantarray;
    return \@resulting_array;
}

sub find {
    my $self       = shift;
    my $table_name = shift;
    &_validate_parameters( $self, $table_name );
    $table_name =~ s/^\s+|\s+$//sg;
    my $id = shift;
    $id =~ s/^\s+|\s+$//sg;
    return unless length($id);
    my $query;

    unless (@_) {
        $query = $self->db->prepare(
            "SELECT * FROM \`$table_name\` WHERE id=\'" . $id . "\'" );
    }
    else {
        my $key = $id;     # two parameters passed fieldname, fieldvalue
        my $val = shift;
        $val =~ s/^\s+|\s+$//sg;
        my $extra_conditions = '';
        while (@_) {
            my $ky = shift;
            $ky =~ s/^\s+|\s+$//sg;
            my $vl = shift;
            croak 'Odd number of parameters hash' unless defined($vl);
            $vl =~ s/^\s+|\s+$//sg;
            $extra_conditions .= " AND \`$ky\`=\'$vl\'";
        }

        $query =
          $self->db->prepare( "SELECT * FROM \`$table_name\` WHERE \`$key\`=\'"
              . $val
              . "\' $extra_conditions LIMIT 1" );
    }
    $query->execute;
    return $query->fetchrow_hashref;
}

sub select {
    my $self       = shift;
    my $table_name = shift;
    &_validate_parameters( $self, $table_name );
    $table_name =~ s/^\s+|\s+$//sg;
    my $query_string = shift;
    croak 'Select method accepts exactly two parameters' if @_;
    $query_string =~ s/^\s+|\s+$//sg;
    unless ( $query_string =~ m/^where /i ) {
        $query_string = 'WHERE ' . $query_string;
    }
    my $query =
      $self->db->prepare( "SELECT * FROM \`$table_name\` " . $query_string );
    $query->execute;
    my @resulting_array;
    while ( my $hashref = $query->fetchrow_hashref ) {
        push @resulting_array, $hashref;
    }
    return @resulting_array if wantarray;
    return \@resulting_array;
}

sub insert {
    my $self       = shift;
    my $table_name = shift;
    &_validate_parameters( $self, $table_name );
    $table_name =~ s/^\s+|\s+$//sg;
    my ( @keys, @values, @arrayed_values );
    while (@_) {
        my $key = shift;
        croak 'Odd number of parameters' unless @_;
        my $val = shift;
        my $vals;
        $key =~ s/^\s+|\s+$//sg;
        push @keys, $key;
        unless ( ref($val) ) {
            $val =~ s/^\s+|\s+$//sg;
            push @values, $val;
        }
        else {
            push @arrayed_values, $val;
        }
    }
    my $keys = join "\`,\`", @keys;
    my $values;
    if (@values) {
        $values = join "\',\'", @values;
        $values = "(\'$values\')";
    }
    elsif (@arrayed_values) {
        for ( my $j = 0 ; $j < scalar @{ $arrayed_values[0] } ; $j++ ) {
            my @vals;
            for ( my $k = 0 ; $k < @keys ; $k++ ) {
                croak 'Each column must contain equal amount of elements'
                  unless defined( $arrayed_values[$k]->[$j] );
                push @vals, $arrayed_values[$k]->[$j];
            }
            my $vals = join "\',\'", @vals;
            $values .= "(\'" . $vals . "\'),";
        }
        $values =~ s/,$//;
    }
    else {
        croak 'Invalid values passed to insert';
    }
    $self->db->do("INSERT INTO \`$table_name\` (\`$keys\`) VALUES $values");
    my $query = $self->db->prepare('SELECT LAST_INSERT_ID()');
    $query->execute;
    my $return_hashref = $query->fetchrow_hashref;
    return
      unless ( defined($return_hashref)
        && $return_hashref->{'LAST_INSERT_ID()'} );
    return $return_hashref->{'LAST_INSERT_ID()'};
}

sub update {
    my $self       = shift;
    my $table_name = shift;
    &_validate_parameters( $self, $table_name );
    $table_name =~ s/^\s+|\s+$//sg;
    my $new_values = shift;
    croak 'Hash reference expected for new values'
      unless ( defined($new_values) && ref($new_values) eq 'HASH' );
    my $update_string = ' SET ';
    foreach ( keys %$new_values ) {
        $update_string .= "\`" . $_ . "\`=\'" . $new_values->{$_} . "\',";
    }
    $update_string =~ s/,$/ /;
    my $query_string = shift;
    if ( defined($query_string) ) {
        $query_string =~ s/^\s+|\s+$//sg;
        if ( $query_string =~ m/^[0-9a-zA-Z\-]+$/ ) {
            $query_string = "WHERE \`id\`=\'" . $query_string . "\'";
        }
        elsif ( $query_string !~ m/^where /i ) {
            $query_string = 'WHERE ' . $query_string;
        }
    }
    $query_string = '' unless defined($query_string) && length($query_string);
    $self->db->do( "UPDATE \`$table_name\`" . $update_string . $query_string );
}

sub delete {
    my $self       = shift;
    my $table_name = shift;
    &_validate_parameters( $self, $table_name );
    $table_name =~ s/^\s+|\s+$//sg;
    my $query_string = shift;
    if ( defined($query_string) ) {
        $query_string =~ s/^\s+|\s+$//sg;
        if ( $query_string =~ m/^[0-9a-zA-Z\-]+$/ ) {
            $query_string = "WHERE \`id\`=\'" . $query_string . "\'";
        }
        elsif ( $query_string !~ m/^where /i ) {
            $query_string = 'WHERE ' . $query_string;
        }
    }
    $query_string = '' unless defined($query_string) && length($query_string);
    $self->db->do( "DELETE FROM \`$table_name\` " . $query_string );
}

sub db {
    my $self = shift;
    croak 'Invalid object' unless ( defined($self) && ref($self) );
    return $self->env->db;
}

sub env {
    my $self = shift;
    croak 'Invalid object' unless ( defined($self) && ref($self) );
    return $self->{env};
}

sub _validate_parameters {
    my $self = shift;
    croak 'Invalid object' unless ( defined($self) && ref($self) );
    croak 'Invalid database connection'
      unless ( defined( $self->{env}->{db} ) && ref( $self->{env}->{db} ) );
    my $table_name = shift;
    croak 'Invalid table name'
      unless ( defined($table_name) && $table_name =~ m/\w/ );
}

1;
