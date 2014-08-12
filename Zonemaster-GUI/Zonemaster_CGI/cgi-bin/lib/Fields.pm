package Fields;
use strict;
use warnings;
use Carp;

use constant DatabaseFields => {
    Session     => [
        qw/ language function last_ip created last_updated parameters /]
};

sub get_table_fields {
    my $this  = shift;
    my $table = shift;
    croak 'Invalid table passed' unless ( defined($table) && $table =~ m/\w/ );
    return unless DatabaseFields->{$table};
    return @{ DatabaseFields->{$table} } if wantarray;
    return DatabaseFields->{$table};
}

1;
