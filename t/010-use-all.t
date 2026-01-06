#!raku

use v6;

use Test;

use-ok "Lumberjack::Template::Provider" , "lib/Lumberjack/Template/Provider.rakumod";
use-ok "Lumberjack::Dispatcher::Proxy"  , "lib/Lumberjack/Dispatcher/Proxy.rakumod";
use-ok "Lumberjack::Dispatcher::Supply" , "lib/Lumberjack/Dispatcher/Supply.rakumod";
use-ok "Lumberjack::Application" , "lib/Lumberjack/Application.rakumod";
use-ok "Lumberjack::Application::Index" , "lib/Lumberjack/Application/Index.rakumod";
use-ok "Lumberjack::Application::WebSocket" , "lib/Lumberjack/Application/WebSocket.rakumod";
use-ok "Lumberjack::Application::PSGI" , "lib/Lumberjack/Application/PSGI.rakumod";


done-testing;
# vim: expandtab shiftwidth=4 ft=raku
