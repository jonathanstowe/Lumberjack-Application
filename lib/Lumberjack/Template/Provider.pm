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
        say "checking $name";
        my Str $template;
        if %.templates{$name}:exists {
            say "got cached";
            $template =  %.templates{$name};
        }
        else {
            say "going to look in paths  : ", @!include-path.perl;
            for @!include-path -> $path {
                my $file = "$path/$name" ~ ($name.ends-with($.ext) ?? '' !! $.ext);
                say "checking for $file";
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
