package Giraffa::Util v0.0.1;

use 5.14.2;
use parent 'Exporter';

use Giraffa;
use Giraffa::DNSName;

our @EXPORT = qw[ ns info config name ];

sub ns {
    return Giraffa->ns( @_ );
}

sub info {
    my ( $tag, $argref ) = @_;

    return Giraffa->logger->add( $tag, $argref );
}

sub config {
    return Giraffa->config->get;
}

sub name {
    my ( $name ) = @_;

    return Giraffa::DNSName->new( $name );
}

1;
