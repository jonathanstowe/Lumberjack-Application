use v6.c;

use Lumberjack;

class Lumberjack::Application does Callable {
    use Lumberjack::Application::PSGI;
    use Lumberjack::Application::WebSocket;
    use Lumberjack::Application::Index;
    use Lumberjack::Dispatcher::Supply;

    use HTTP::Server::Tiny;
    use Crust::Builder;

    has Int $.port = 8898;

    has &.app;

    method CALL-ME(%env) {
        self.app.(%env)
    }

    method app() returns Callable {

        if not &!app.defined {
            my $supply  = Lumberjack::Dispatcher::Supply.new;
            Lumberjack.dispatchers.append: $supply;

            my &ws-app  = Lumberjack::Application::WebSocket.new(supply => $supply.Supply);
            my &log-app = Lumberjack::Application::PSGI.new;
            my &ind-app = Lumberjack::Application::Index.new(ws-url => 'socket');

            &!app = builder {
                mount '/socket', &ws-app;
                mount '/log', &log-app;
                mount '/', &ind-app;
            };
        }
        &!app;
    }

    method run() {
        my $s = HTTP::Server::Tiny.new(port => 8898);
        $s.run(self.app)
    }
}
# vim: expandtab shiftwidth=4 ft=perl6
