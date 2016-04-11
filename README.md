# Lumberjack::Application

A web facility for the Lumberjack logging framework

## Synopsis

```
	# In some shell start the lumberjack standalone application
	# on port 8898 and mirroring log messages to the console

	lumberjack-application --port=8898 --console
```
Meanwhile in some other application:

```perl6

	use Lumberjack;
	use Lumberjack::Dispatcher::Proxy;

	# Add the proxy dispatcher
	Lumberjack.dispatchers.append: Lumberjack::Dispatcher::Proxy.new(url => 'http://localhost:8898/log');

	# Now all logging messages will be sent to the server application as well
	# as any other dispatchers that may be configured. The logs will be displayed
	# at a Websocket application that you can point your browser at.

```

## Description

This is actually more a collection of related
modules than a single module. It comprises a
[Lumberjack](https://github.com/jonathanstowe/Lumberjack) dispatcher
that sends the logging messages encoded as JSON to a web server,
A [P6SGI](https://github.com/zostay/P6SGI) application module that
handles the JSON messages, deserialising them back to the appropriate
objects and re-transmitting them to the local Lumberjack object, and a
Websocket app module that will re-transmit the messages as JSON to one
or more connected websockets.  There are one or two convenience helpers
to tie all this together.

These components together can be combined in various ways to make for
example, a log aggregator for a larger system, a web log monitoring tool,
or simply perform logging to a service which is not on the local machine.

This should probably be considered more as a proof of concept, experiment
or demonstration than a polished application.  Please feel free to take
the parts you need and do what you want with them.

## Installation

Assuming you have a working installation of Rakudo Perl 6 with "panda"
then you can simply do:

	panda install Lumberjack::Application

Or if you have a local copy of this distribution:

	panda install .

Though I haven't tested it I can see no reason why this shouldn't work
equally well with "zef" or some similarly capable package manager that
may come along in the future.

## Support

This is quite experimental and depends on things that are themselves
probably fairly experimental, but it it works and I hope you find it
useful in some way, that said I'll be interested in enhancements,
fixes and suggestions at https://github.com/jonathanstowe/Lumberjack-Application/issues

## License and Copyright

This free software, please see the LICENSE file in the distribution
directory.

© Jonathan Stowe, 2016

