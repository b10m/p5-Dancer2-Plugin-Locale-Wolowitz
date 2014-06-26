use 5.0010;
use strict;
use warnings FATAL => 'all';
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'Dancer2::Plugin::Locale::Wolowitz',
    AUTHOR           => q{Menno Blom <blom@cpan.org>},
    VERSION_FROM     => 'lib/Dancer2/Plugin/Locale/Wolowitz.pm',
    ABSTRACT_FROM    => 'lib/Dancer2/Plugin/Locale/Wolowitz.pm',
    LICENSE          => 'Artistic_2_0',
    PL_FILES         => {},
    MIN_PERL_VERSION => 5.0010,
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 0,
    },
    BUILD_REQUIRES => {
        'Test::More' => "0.96",
        'Test::TCP'  => "0",
    },
    PREREQ_PM => {
        'Dancer2'          => "0",
        'Locale::Wolowitz' => "0",
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'Dancer2-Plugin-Locale-Wolowitz-*' },
    META_MERGE => {
        resources => {
            repository => 'https://github.com/b10m/p5-Dancer2-Plugin-Locale-Wolowitz',
        },
    },
);
