use v6.c;

class Lumberjack::Template::Provider {

    has @.include-path;
    has %.templates;
    has $.ext is rw = '.tt';


    submethod BUILD (:@path, *%args) {
        if @path {
            @!include-path.splice(@!include-path.elems, 0, @path);
        }
    }

    method add-path ($path) {
        @.include-path.append: $path;
    }

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

    method store ($name, $template) {
        %.templates{$name} = $template;
    }
}

# vim: expandtab shiftwidth=4 ft=perl6
