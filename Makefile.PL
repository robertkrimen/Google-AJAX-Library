use inc::Module::Install;

name 'Google-AJAX-Library';
all_from 'lib/Google/AJAX/Library.pm';

build_requires 'Test::More';

auto_install;

WriteAll;

