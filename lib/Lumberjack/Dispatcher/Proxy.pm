use v6.c;

use Lumberjack:ver<0.0.3>;
use Lumberjack::Message::JSON;

use HTTP::UserAgent;


class Lumberjack::Dispatcher::Proxy does Lumberjack::Dispatcher {
    use HTTP::Request::Common;

    has HTTP::UserAgent     $!ua;
    has Str                 $.username;
    has Str                 $.password;
    has Str                 $.url       is required;
    has Bool                $.quiet = False;

    method log(Lumberjack::Message $message) {
        if not $!ua.defined {
            $!ua = HTTP::UserAgent.new;

            if $!username.defined && $!password.defined {
                $!ua.auth($!username, $!password);
            }
        }

        $message does Lumberjack::Message::JSON;

        my $req = POST($!url, content => $message.to-json, Content-Type => "application/json");

        my $res = try $!ua.request($req);

        if not $!quiet {
            if not $res.defined {
                # This is likely to be because the
                # server went away beneath us
                $*ERR.say: "proxy-dispatch failed";
            }
            elsif not $res.is-success {
                $*ERR.say: "proxy-dispatch failed : ", $res.status-line;
            }
        }
    }



}
# vim: expandtab shiftwidth=4 ft=perl6
