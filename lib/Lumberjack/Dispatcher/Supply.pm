use v6.c;

use Lumberjack;

class Lumberjack::Dispatcher::Supply does Lumberjack::Dispatcher {
    has Supplier $!supplier = Supplier.new;
    has Supply   $.Supply;

    method Supply() returns Supply handles <tap> {
        if not $!Supply.defined {
            $!Supply = $!supplier.Supply;
        }
    }

    method log(Lumberjack::Message $message) {
        $!supplier.emit($message);
    }
}
# vim: expandtab shiftwidth=4 ft=perl6
