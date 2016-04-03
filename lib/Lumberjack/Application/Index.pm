use v6.c;

use Template6;
use Lumberjack::Template::Provider;

class Lumberjack::Application::Index does Callable {
    has Template6 $!template;
    has Str       $.ws-url;

    submethod BUILD(:$!ws-url) {
        $!template = Template6.new;
        my $provider = Lumberjack::Template::Provider.new;
        $provider.add-path('templates');
        $!template.add-provider('resources', $provider);
        $!template.add-path('templates');
    }

    method call(%env) {
        say %env;
        my $html = $!template.process('index', ws-url => $!ws-url);
        return 200, [Content-Type => 'text/html'], [$html];
    }

    method CALL-ME(%env) {
        self.call(%env);
    }
}
# vim: expandtab shiftwidth=4 ft=perl6
