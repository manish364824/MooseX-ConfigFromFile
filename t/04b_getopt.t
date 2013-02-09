use strict;
use warnings FATAL => 'all';

use Test::Requires 'MooseX::Getopt';    # skip all if not installed
use Test::More tests => 3;
use Test::NoWarnings 1.04 ':early';

{
    package Foo::Options;

    use Moose;
    with qw(MooseX::Getopt MooseX::ConfigFromFile);
    sub get_config_from_file { }
}

{
    package Foo::NoOptions;

    use Moose;
    with qw(MooseX::ConfigFromFile);
    sub get_config_from_file { }
}

ok(
    Foo::Options->meta->find_attribute_by_name('configfile')->does('MooseX::Getopt::Meta::Attribute::Trait'),
    'classes with MooseX::Getopt have the Getopt attr trait added',
);

ok(
    Foo::NoOptions->meta->find_attribute_by_name('configfile')->does('MooseX::Getopt::Meta::Attribute::Trait'),
    'when MooseX::Getopt is loaded, the Getopt attr trait is still added',
);

