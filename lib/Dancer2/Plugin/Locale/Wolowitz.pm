package Dancer2::Plugin::Locale::Wolowitz;

use 5.010;
use strict;
use warnings;

use Dancer2;
use Dancer2::FileUtils;
use Dancer2::Plugin;
use Locale::Wolowitz;

our $VERSION = '0.01';

my $wolowitz;
my $conf;

=head1 NAME

Dancer2::Plugin::Locale::Wolowitz - Dancer2's plugin for Locale::Wolowitz

=head1 DESCRIPTION

This plugin give you the L<Locale::Wolowitz> support. It's a blatant copy of
L<Dancer::Plugin::Locale::Wolowitz> and should be a drop in replacement
for Dancer2 projects.

=head1 SYNOPSIS

    use Dancer2;
    use Dancer2::Plugin::Locale::Wolowitz;

    # in your templates
    get '/' => sub {
        template 'index';
    }

    # or directly in code
    get '/logout' => sub {
        template 'logout', {
            bye => loc('Bye');
        }
    }

... meanwhile, in a nearby template file called index.tt

    <% l('Welcome') %>

=head1 CONFIGURATION

   plugins:
     Locale::Wolowitz:
       lang_session: "lang"
       locale_path_directory: "i18n"

=cut


on_plugin_import {
    my $dsl = shift;

    $dsl->app->add_hook(
        Dancer2::Core::Hook->new(
            name => 'before_template',
            code => sub {
                my $tokens = shift;
                $tokens->{l} = sub { _loc($dsl, @_); };
            }
        )
    );
};

=head1 KEYWORDS

=head2 loc

The C<loc> keyword can be used in code to look up the correct translation. In
templates you can use the C<l('')> function

=cut

register loc => \&_loc;

sub _loc {
    my ($dsl, $str, $args) = @_;

    $wolowitz ||= Locale::Wolowitz->new(_path_directory_locale($dsl));
    my $lang    = _lang($dsl);

    return $wolowitz->loc($str, $lang, @$args);
};

sub _path_directory_locale {
    my $dsl = shift;

    $conf ||= plugin_setting();
    return $conf->{locale_path_directory}
           // Dancer2::FileUtils::path($dsl->setting('appdir'), 'i18n');
}

sub _lang {
    my $dsl = shift;

    $conf ||= plugin_setting();
    my $lang_session = $conf->{lang_session} || 'lang';

    if( $dsl->setting('session') ) {
        my $session_language = $dsl->session( $lang_session );

        if( !$session_language ) {
            $session_language = _detect_lang_from_browser($dsl);

            $dsl->session( $lang_session => $session_language );
        }

        return $session_language;
    } else {
        return _detect_lang_from_browser($dsl);
    }
}

sub _detect_lang_from_browser {
    my $dsl = shift;

    my $lang = $dsl->request->accept_language || return;
       $lang =~ s/-\w+//g;
       $lang = (split(/,\s*/,$lang))[0];

    return $lang;
}

=head1 AUTHOR

Menno Blom, C<< <blom at cpan.org> >>

=head1 BUGS / CONTRIBUTING

This module is developed on Github at:
L<http://github.com/b10m/p5-Dancer-Plugin-Locale-Wolowitz>

=head1 ACKNOWLEDGEMENTS

Many thanks go out to L<HOBBESTIG|https://metacpan.org/author/HOBBESTIG> for
writing the Dancer 1 version of this plugin (L<Dancer::Plugin::Locale::Wolowitz>).

And obviously thanks to L<IDOPEREL|https://metacpan.org/author/IDOPEREL> for
creating the main code we're using in this plugin! (L<Locale::Wolowitz>).


=head1 LICENSE AND COPYRIGHT

Copyright 2014 Menno Blom.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

register_plugin for_versions => [ 2 ] ;

1; # End of Dancer2::Plugin::Locale::Wolowitz
