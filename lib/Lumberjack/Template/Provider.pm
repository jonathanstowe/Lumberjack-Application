use v6.c;

use Template6::Provider;

class Lumberjack::Template::Provider does Template6::Provider {

    method fetch ($name) {
        my Str $template;
        if %.templates{$name}:exists {
            $template =  %.templates{$name};
        }
        else {
            for @!include-path -> $path {
                my $file = "$path/$name" ~ ($name.ends-with($.ext) ?? '' !! $.ext);
                if %?RESOURCES{$file}.e {
                    $template = %?RESOURCES{$file}.slurp;
                    %.templates{$name} = $template;
                    last;
                }
            }
        }
        return $template;
    }
}

# vim: expandtab shiftwidth=4 ft=perl6
