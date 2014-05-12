package Zonemaster::CLI;

use 5.014002;
use warnings;

our $VERSION = '0.01';

use Moose;
with 'MooseX::Getopt';

use Zonemaster;
use Zonemaster::Logger::Entry;
use Zonemaster::Translator;
use Zonemaster::Util qw[pod_extract_for];
use JSON::XS;

our %numeric = Zonemaster::Logger::Entry->levels;
my $json = JSON::XS->new;

STDOUT->autoflush( 1 );

has 'version' => (
    is            => 'ro',
    isa           => 'Bool',
    default       => 0,
    required      => 0,
    documentation => 'Print version information and exit.',
);

has 'level' => (
    is            => 'ro',
    isa           => 'Str',
    required      => 0,
    default       => 'NOTICE',
    documentation => 'The minimum severity level to display'
);

has 'lang' => (
    is            => 'ro',
    isa           => 'Str',
    required      => 0,
    default       => 'tech',
    documentation => 'The language to show messages in. Can be tech, raw, json or any installed translation.',
);

has 'time' => (
    is            => 'ro',
    isa           => 'Bool',
    documentation => 'Print timestamp on entries.',
    default       => 1,
);

has 'show_level' => (
    is            => 'ro',
    isa           => 'Bool',
    documentation => 'Print level on entries.',
    default       => 1,
);

has 'ns' => (
    is            => 'ro',
    isa           => 'ArrayRef',
    documentation => 'A name/ip string giving a nameserver for undelegated tests. Can be given multiple times.',
);

has 'ds' => (
    is  => 'ro',
    isa => 'ArrayRef',
    documentation =>
      'A DS record in presentation format for undelegated tests (not yet implemented). Can be given multiple times.'
);

has 'save' => (
    is            => 'ro',
    isa           => 'Str',
    required      => 0,
    documentation => 'Name of a file to save DNS data to after running tests.',
);

has 'restore' => (
    is            => 'ro',
    isa           => 'Str',
    required      => 0,
    documentation => 'Name of a file to restore DNS data from before running test.',
);

has 'ipv4' => (
    is            => 'ro',
    isa           => 'Bool',
    default       => 1,
    documentation => 'Flag to permit or deny queries being sent via IPv4.',
);

has 'ipv6' => (
    is            => 'ro',
    isa           => 'Bool',
    default       => 1,
    documentation => 'Flag to permit or deny queries being sent via IPv6.',
);

has 'list_tests' => (
    is            => 'ro',
    isa           => 'Bool',
    default       => 0,
    documentation => 'Instead of running a test, list all available tests.',
);

has 'test' => (
    is       => 'ro',
    isa      => 'ArrayRef',
    required => 0,
    documentation =>
'Specify test to run. Should be either the name of a module, or the name of a module and the name of a method in that module separated by a "/" character (Example: "Basic/basic1"). The method specified must be one that takes a zone object as its single argument. This switch can be repeated.'
);

has 'stop_level' => (
    is            => 'ro',
    isa           => 'Str',
    required      => 0,
    documentation => 'As soon as a message at this level or higher is logged, execution will stop.'
);

has 'config' => (
    is            => 'ro',
    isa           => 'Str',
    required      => 0,
    documentation => 'Name of configuration file to load.',
);

has 'policy' => (
    is            => 'ro',
    isa           => 'Str',
    required      => 0,
    documentation => 'Name of policy file to load.',
);

sub run {
    my ( $self ) = @_;
    my @accumulator;

    if ( $self->version ) {
        print_versions();
        exit;
    }

    if ( $self->list_tests ) {
        my %methods = Zonemaster->all_methods;
        foreach my $module ( sort keys %methods ) {
            say $module;
            my $doc = pod_extract_for( $module );
            foreach my $method ( sort @{ $methods{$module} } ) {
                print "\t$method";
                if ( $doc and $doc->{$method} ) {
                    print "\t" . $doc->{$method};
                }
                print "\n";
            }
        }
        exit( 0 );
    }

    my ( $domain ) = @{ $self->extra_argv };
    if ( not $domain ) {
        die "Must give the name of a domain to test.\n";
    }

    if ( $self->stop_level and not defined( $numeric{ $self->stop_level } ) ) {
        die "Failed to recognize stop level '" . $self->stop_level . "'.\n";
    }

    Zonemaster->config->get->{net}{ipv4} = $self->ipv4;
    Zonemaster->config->get->{net}{ipv6} = $self->ipv6;

    my $translator;
    $translator = Zonemaster::Translator->new( { lang => $self->lang } )
      unless ( $self->lang eq 'raw' or $self->lang eq 'json' );
    eval { $translator->data } if $translator;    # Provoke lazy loading of translation data
    if ( $@ ) {
        if ( $@ =~ /Cannot read translation file/ ) {
            say "Cannot find a translation for language " . $self->lang . ".";
            exit( 1 );
        }
        else {
            die "Oops: $@";
        }
    }

    if ( $self->restore ) {
        Zonemaster->preload_cache( $self->restore );
    }

    # Callback defined here so it closes over the setup above.
    Zonemaster->logger->callback(
        sub {
            my ( $entry ) = @_;

            print_spinner();

            if ( $numeric{ uc $entry->level } >= $numeric{ uc $self->level } ) {

                if ( $translator ) {
                    if ( $self->time ) {
                        printf "%7.2f ", $entry->timestamp;
                    }

                    if ( $self->show_level ) {
                        printf "%-9s ", $entry->level;
                    }

                    say $translator->translate_tag( $entry );
                }
                elsif ( $self->lang eq 'json' ) {
                    push @accumulator,
                      {
                        timestamp => $entry->timestamp,
                        module    => $entry->module,
                        tag       => $entry->tag,
                        args      => $entry->args,
                      };
                }
                else {
                    printf "%7.2f %-9s %s\n", $entry->timestamp, $entry->level, $entry->string;
                }
            } ## end if ( $numeric{ uc $entry...})
            exit( 0 ) if ( $self->stop_level and $numeric{ uc $entry->level } >= $numeric{ uc $self->stop_level } );
        }
    );

    if ( $self->policy ) {
        say "Loading policy from " . $self->policy;
        Zonemaster->config->load_policy_file( $self->policy );
    }

    if ( $self->config ) {
        say "Loading configuration from " . $self->config;
        Zonemaster->config->load_config_file( $self->config );
    }

    if ( $self->config or $self->policy ) {
        print "\n";    # Cosmetic
    }

    if ( $translator ) {
        if ( $self->time ) {
            print 'Seconds ';
        }
        if ( $self->show_level ) {
            print 'Level     ';
        }
        say 'Message';

        if ( $self->time ) {
            print '======= ';
        }
        if ( $self->show_level ) {
            print '========= ';
        }
        say '=======';
    }

    if ( $self->ns and @{ $self->ns } > 0 ) {
        $self->add_fake_delegation( $domain );
    }

    # Actually run tests!
    if ( $self->test and @{ $self->test } > 0 ) {
        foreach my $t ( @{ $self->test } ) {
            my ( $module, $method ) = split( '/', $t, 2 );
            if ( $method ) {
                Zonemaster->test_method( $module, $method, Zonemaster->zone( $domain ) );
            }
            else {
                Zonemaster->test_module( $module, $domain );
            }
        }
    }
    else {
        Zonemaster->test_zone( $domain );
    }

    if ( $self->lang eq 'json' ) {
        say $json->encode( \@accumulator );
    }

    if ( $self->save ) {
        Zonemaster->save_cache( $self->save );
    }

    return;
} ## end sub run

sub add_fake_delegation {
    my ( $self, $domain ) = @_;
    my %data;

    foreach my $pair ( @{ $self->ns } ) {
        my ( $name, $ip ) = split( '/', $pair, 2 );
        push @{ $data{$name} }, $ip;
    }

    Zonemaster->add_fake_delegation( $domain => \%data );

    return;
}

sub print_versions {
    say 'CLI version:    ' . $VERSION;
    say 'Engine version: ' . $Zonemaster::VERSION;
    say "\nTest module versions:";

    my %methods = Zonemaster->all_methods;
    foreach my $module ( sort keys %methods ) {
        my $mod = "Zonemaster::Test::$module";
        say "\t$module: " . $mod->version;
    }
}

my @spinner_strings = ( '  | ', '  / ', '  - ', '  \\ ' );

sub print_spinner {
    state $counter = 0;

    printf "%s\r", $spinner_strings[ $counter++ % 4 ];
}

1;
