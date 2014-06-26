use strict;
use warnings;

use Test::More 0.96 import => ['!pass'];
use Test::TCP;

use Dancer2;
use Dancer2::Plugin::Locale::Wolowitz;
use LWP::UserAgent;

test_tcp(
  client => sub {
    my $port = shift;
    my $url = "http://localhost:$port";

    my $ua = LWP::UserAgent->new( cookie_jar => {} );
    my $res;

    $res = $ua->get($url . "/?lang=en");
    is $res->content, 'Welcome', 'check simple key english';

    $res = $ua->get($url . "/tmpl");
    is $res->content, 'Welcome', 'check simple key english (tmpl)';

    $res = $ua->get($url . "/no_key");
    is $res->content, 'hello', 'check no key found english';

    $res = $ua->get($url . "/tmpl/no_key");
    is $res->content, 'hello', 'check no key found english (tmpl)';

    my $path = setting('appdir');
    $res = $ua->get($url . '/complex_key');
    is $res->content,  "$path not found", 'check complex key english';

    $res = $ua->get($url . '/tmpl/complex_key');
    is $res->content,  "$path not found", 'check complex key english (tmpl)';

    # and now for something completely different
    $res = $ua->get($url . "/?lang=fr");
    is $res->content, 'Bienvenue', 'check simple key french';

    $res = $ua->get($url . "/tmpl");
    is $res->content, 'Bienvenue', 'check simple key french (tmpl)';

    $res = $ua->get($url . "/no_key");
    is $res->content, 'hello', 'check no key found french';

    $res = $ua->get($url . "/tmpl/no_key");
    is $res->content, 'hello', 'check no key found french (tmpl)';

    $res = $ua->get($url . '/complex_key');
    is $res->content,  "Repertoire $path non trouve", 'check complex key french';

    $res = $ua->get($url . '/tmpl/complex_key');
    is $res->content,  "Repertoire $path non trouve", 'check complex key french (tmpl)';

  },

  server => sub {
    my $port = shift;

    set confdir  => '.';
    set port     => $port, startup_info => 0;
    set template => 'template_toolkit';
    #set views => path( '.', 't', 'views' );

    Dancer2->runner->server->port($port);
    @{engine('template')->config}{qw(start_tag end_tag)} = qw(<% %>);


    set session => 'Simple';

    get '/' => sub {
        session lang => param('lang');
        my $tr = loc('welcome');
        return $tr;
    };

    get '/tmpl' => sub {
        template 'index', {}, { layout => undef };;
    };

    get '/no_key' => sub {
        my $tr = loc('hello');
        return $tr;
    };

    get '/tmpl/no_key' => sub {
        template 'no_key';
    };

    get '/complex_key' => sub {
        my $tr = loc('path_not_found %1', [setting('appdir')]);
        return $tr;
    };

    get '/tmpl/complex_key' => sub {
        template 'complex_key', { appdir => setting('appdir') };
    };

    start;
  },
);

done_testing;
