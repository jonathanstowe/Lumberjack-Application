use v6.c;

use Lumberjack;
use Lumberjack::Message::JSON;

class Lumberjack::Application::PSGI does Callable {


    constant JSONMessage = ( Lumberjack::Message but Lumberjack::Message::JSON );

    method CALL-ME(%env) {
        self.call(%env);
    }

    method call(%env) {
        if %env<REQUEST_METHOD> eq 'POST' {
	        my $c = %env<p6sgi.input>.slurp-rest;
            my $mess = JSONMessage.from-json($c);
            Lumberjack.log($mess);
	        return 200, [ Content-Type => 'application/json' ], [ '{ "status" : "OK" }' ];
        }
        else {
            return 405, [Allow => 'POST', Content-Type => 'application/json' ], ['{ "status" : "Only POST method allowed" }'];
        }
    }
}
# vim: expandtab shiftwidth=4 ft=perl6
