requires 'Dancer2';
requires 'I18N::AcceptLanguage';
requires 'Locale::Wolowitz';
requires 'perl', '5.001';

on build => sub {
    requires 'Test::More', '0.96';
    requires 'Test::TCP';
};
