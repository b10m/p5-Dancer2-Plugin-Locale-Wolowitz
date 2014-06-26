# NAME

Dancer2::Plugin::Locale::Wolowitz - Dancer2's plugin for Locale::Wolowitz

# DESCRIPTION

This plugin give you the [Locale::Wolowitz](https://metacpan.org/pod/Locale::Wolowitz) support. It's a blatant copy of
[Dancer::Plugin::Locale::Wolowitz](https://metacpan.org/pod/Dancer::Plugin::Locale::Wolowitz) and should be a drop in replacement
for Dancer2 projects.

# SYNOPSIS

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

# CONFIGURATION

    plugins:
      Locale::Wolowitz:
        lang_session: "lang"
        locale_path_directory: "i18n"

# KEYWORDS

## loc

The `loc` keyword can be used in code to look up the correct translation. In
templates you can use the `l('')` function

# AUTHOR

Menno Blom, `<blom at cpan.org>`

# BUGS / CONTRIBUTING

This module is developed on Github at:
[http://github.com/b10m/p5-Dancer-Plugin-Locale-Wolowitz](http://github.com/b10m/p5-Dancer-Plugin-Locale-Wolowitz)

# ACKNOWLEDGEMENTS

Many thanks go out to [HOBBESTIG](https://metacpan.org/author/HOBBESTIG) for
writing the Dancer 1 version of this plugin ([Dancer::Plugin::Locale::Wolowitz](https://metacpan.org/pod/Dancer::Plugin::Locale::Wolowitz)).

And obviously thanks to [IDOPEREL](https://metacpan.org/author/IDOPEREL) for
creating the main code we're using in this plugin! ([Locale::Wolowitz](https://metacpan.org/pod/Locale::Wolowitz)).

# LICENSE AND COPYRIGHT

Copyright 2014 Menno Blom.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

[http://www.perlfoundation.org/artistic\_license\_2\_0](http://www.perlfoundation.org/artistic_license_2_0)

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
