use inc::Module::Install;

name 'Google-AJAX-Library';
all_from 'lib/Google/AJAX/Library.pm';

build_requires 'Test::More';
build_requires 'File::Temp';

requires qw/Carp::Clan::Share/;
requires qw/HTML::Declare/;
requires qw/LWP::UserAgent/;
requires qw/Moose/;
requires qw/Path::Class/;
requires qw/URI/;

auto_install;

WriteAll;

