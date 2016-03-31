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

    method log(Lumberjack::Message $message) {
        if not $!ua.defined {
            $!ua = HTTP::UserAgent.new;

            if $!username.defined && $!password.defined {
                $!ua.auth($!username, $!password);
            }
        }

        $message does Lumberjack::Message::JSON;

        my $req = POST($!url, content => $message.to-json, Content-Type => "application/json");

        my $res = $!ua.request($req);

        if not $res.is-success {
            $*ERR.say: "proxy-dispatch failed : ", $res.status-line;
        }
    }



}
# vim: expandtab shiftwidth=4 ft=perl6
