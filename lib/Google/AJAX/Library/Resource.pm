package Google::AJAX::Library::Resource;

use Moose;
use Google::AJAX::Library::Carp;

use URI;

use constant BASE => 'http://ajax.googleapis.com/ajax/libs';
use constant LATEST_VERSION => {qw/
    jquery 1
    prototype 1
    scriptaculous 1
    mootools 1
    dojo 1
/};

has uri => qw/is ro/;
has version => qw/is ro/;
has file => qw/is ro/;
has name => qw/is ro/;

sub BUILD {
    my $self = shift;
    my $given = shift;
    
    my $uri;
    if ($uri = $given->{uri}) {
    }
    else {
        my $name = $given->{name} or croak "Wasn't given a library name (e.g. jquery, mootools, etc.)";
        my $file = $given->{file};
        ($name, $file) = $self->_name_file($name, $given) unless $file;

        my $base = $given->{base} || BASE;
        my $version = $given->{version} || LATEST_VERSION->{$name} or croak "Wasn't given a library version for $name";

        $uri = join "/", $base, $name, $version, $file;

        $self->{version} = $version;
        $self->{file} = $file;
        $self->{name} = $name;
    }

    $self->{uri} = URI->new($uri);
}

sub _name_file {
    my $self = shift;
    my $name = shift;
    my $extra = shift;

    croak "Wasn't given a library name (e.g. jquery, mootools, etc.)" unless $name;

    my $uncompressed = $extra->{uncompressed} || 0;
    $uncompressed = $uncompressed =~ m/^\s*(?:f(?:alse)?|(?:no?))\s*$/ ? 0 : $uncompressed;
    $uncompressed = $uncompressed ? 1 : 0;
    my $compact = $uncompressed ? 0 : 1;

    $name =~ s/\.js\s*$//i; # Just in case

    my $file;
    if      ($name =~ m/^\s*jquery\s*$/i) {
        $name = "jquery";
        $file = $compact ? "$name.min.js" : "$name.js";
    }
    elsif   ($name =~ m/^\s*script\.?aculo\.?us\s*$/i) {
        $name = "scriptaculous";
        $file = "$name.js";
    }
    elsif   ($name =~ m/^\s*prototype\s*$/i) {
        $name = "prototype";
        $file = "$name.js";
    }
    elsif   ($name =~ m/^\s*mootools\s*$/i) {
        $name = "mootools";
        $file = $compact ? "$name-yui-compressed.js" : "$name.js";
    }
    elsif   ($name =~ m/^\s*dojo\s*$/i) {
        $name = "dojo";
        $file = $compact ? "$name.xd.js" : "$name.xd.js.uncompressed.js";
    }
    else {
        croak "Don't understand library name ($name)";
    }

    return ($name, $file);
}

1;

__END__

has version => qw/is ro required 1 isa Str default 0/;
has name => qw/is ro required 1 isa Str/;
has extra => qw/is ro required 1 lazy 1 isa HashRef/, default => sub { {} };
has file => qw/

sub BUILD {
    my $self = shift;
}

1;
