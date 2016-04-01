use v6;

use Lumberjack::Message::JSON;
use WebSocket::P6SGI;


class Lumberjack::Application::WebSocket does Callable {
    has Supply $.supply is required;

    method CALL-ME(%env) {
        self.call(%env);
    }

    method call(%env) {
        my $tap;
        my $supply = $!supply;
        ws-psgi(%env,
                on-ready => -> $ws {
                    $tap = $supply.tap(-> $got {
                        if $got !~~ Lumberjack::Message::JSON {
                            $got does Lumberjack::Message::JSON;
                        }
                        $ws.send-text( $got.to-json );
                    });
                },
                on-text => -> $ws, $txt {
                    # Not expecting anything back
                },
                on-binary => -> $ws, $binary {
                    # Not expecting anything back
                },
                on-close => -> $ws {
                        $tap.close if $tap;
                },
        );
    }
}
# vim: expandtab shiftwidth=4 ft=perl6
