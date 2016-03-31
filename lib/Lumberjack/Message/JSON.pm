use v6.c;

use Lumberjack:ver<0.0.3>;
use JSON::Class;

role Lumberjack::Message::JSON does JSON::Class {

    has Bool $!been-monkeyed;

    sub marshal-class($v) {
        if $v ~~ Lumberjack::Logger {
            {
                name => $v.^name,
                log-level => $v.log-level.Int,
                is-logger    => True
            };
        }
        else {
            {
                name => $v.^name,
                log-level => Lumberjack.default-level.Int,
                is-logger    => False
            };
        }
    }

    sub unmarshal-class($v) {
        my $class = (try require ::($v<name>));
        if ::($v<name>) ~~ Failure {
            $class := Metamodel::ClassHOW.new_type(name => $v<name>);
            $class.^add_parent(Any);
            if $v<is-logger> {
                $class.^add_role(Lumberjack::Logger);
            }
            $class.^compose;
        }
        if $class ~~ Lumberjack::Logger {
            $class.log-level = Lumberjack::Level($v<log-level>);
        }
        $class;
    }


    method !add-marshallers() {
        my $when = self.^attributes.grep({$_.name eq '$!when'}).first;
        trait_mod:<is>($when, marshalled-by => 'Str');
        trait_mod:<is>($when, unmarshalled-by => -> $v { DateTime.new($v) });
        my $class = self.^attributes.grep({$_.name eq '$!class'}).first;
        trait_mod:<is>($class, marshalled-by => &marshal-class);
        trait_mod:<is>($class, unmarshalled-by => &unmarshal-class);
        my $level = self.^attributes.grep({ $_.name eq '$!level' }).first;
        trait_mod:<is>($level, marshalled-by => -> $v { $v.Int });
        trait_mod:<is>($level, unmarshalled-by => -> $v { Lumberjack::Level($v) });
    }

    method to-json() {
        self does JSON::Class;    
        self!add-marshallers;
        self.JSON::Class::to-json;
    }
    method from-json($json) {
        self!add-marshallers;
        (self but JSON::Class).JSON::Class::from-json($json);
    }
}

# vim: expandtab shiftwidth=4 ft=perl6
