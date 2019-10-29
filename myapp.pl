#!/usr/bin/env perl
use Mojolicious::Lite;

plugin 'Config';
plugin 'ReverseProxyWithPath';

get '/' => 'index';
get '/internal';
get '/color/:color' => {color => ''} => sub {
  my $c = shift;
  $c->param('color') ? $c->session(color => $c->param('color')) : delete $c->session->{color};
  $c->redirect_to($c->req->headers->referrer);
} => 'color';

app->start;
