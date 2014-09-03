package sockets;

sub new {
  return bless({},'sockets');
}

sub run {

	my $self = shift;

    return sub {
        my $socket = shift;

        $socket->on('connect' => sub {
          print("Client: connect\n");
        });

        $socket->on('error' => sub {
          print("Client: error\n");
          $socket->socket->reconnect();
        });
        $socket->on('message' => sub {
                my $sender = shift;
                my ( $message ) = @_;

                #$sender->broadcast->emit( 'message', $message );
                #$sender->sockets->emit( 'message', { text => $message } );
            });
    }
}

1;
