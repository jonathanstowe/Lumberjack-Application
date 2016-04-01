# Lumberjack::Application

A web facility for the Lumberjack logging framework

## Synopsis

```


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

