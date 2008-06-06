#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Google::AJAX::Library' );
}

diag( "Testing Google::AJAX::Library $Google::AJAX::Library::VERSION, Perl $], $^X" );
