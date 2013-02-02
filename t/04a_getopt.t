use strict;
use warnings;

use Test::More tests => 2;
use Test::NoWarnings 1.04 ':early';

use Test::Without::Module 'MooseX::Getopt';

{
    package Foo::NoOptions;

    use Moose;
    with qw(MooseX::ConfigFromFile);
    sub get_config_from_file { }
}

ok(
    !Foo::NoOptions->meta->find_attribute_by_name('configfile')->does('MooseX::Getopt::Meta::Attribute::Trait'),
    'the Getopt attr trait is not added if not installed',
);

