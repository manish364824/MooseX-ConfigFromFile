use strict;
use warnings;

use Test::More tests => 5;
use Test::NoWarnings 1.04 ':early';
use Path::Tiny 'path';
use Path::Class 'file';

{
    package Generic;
    use Moose;
    with 'MooseX::SimpleConfig';
    sub get_config_from_file { }
}

{
    my $obj = Generic->new(configfile => path('i/do/not_exist'));
    is($obj->configfile, 'i/do/not_exist', 'stringification returns path');
    isa_ok($obj->configfile, 'Path::Tiny');
}

{
    my $obj = Generic->new(configfile => file('i/do/not_exist'));
    is($obj->configfile, 'i/do/not_exist', 'stringification returns path');
    isa_ok($obj->configfile, 'Path::Tiny');
}

