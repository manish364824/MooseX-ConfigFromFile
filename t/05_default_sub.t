use strict;
use warnings;

use Test::Requires 'MooseX::SimpleConfig';      # skip all if not reuqired
use Test::More tests => 10;
use Test::Fatal;
use Test::Deep '!blessed';
use Test::NoWarnings 1.04 ':early';
use Scalar::Util 'blessed';

my %loaded_file;
my %default_sub;


# nothing special going on here
{
    package Generic;
    use Moose;
    with 'MooseX::SimpleConfig';
    sub get_config_from_file { }
}

is(
    exception {
        my $obj = Generic->new_with_config;
        is($obj->configfile, undef, 'no configfile set');
    },
    undef,
    'no exceptions',
);


# this is a classic legacy usecase from old documentation that we must
# continue to support
{
    package OverriddenDefault;
    use Moose;
    with 'MooseX::SimpleConfig';
    sub get_config_from_file
    {
        my ($class, $file) = @_;
        $loaded_file{$file}++;
        +{}
    }
    has '+configfile' => (
        default => 'OverriddenDefault file',
    );
}

is(
    exception {
        my $obj = OverriddenDefault->new_with_config;
        is($obj->configfile, blessed($obj) . ' file', 'configfile set via overridden default');
        is($loaded_file{blessed($obj) . ' file'}, 1, 'correct file was loaded from');
    },
    undef,
    'no exceptions',
);


# "reader" method is overridden to provide for configfile default
{
    package OverriddenMethod;
    use Moose;
    with 'MooseX::SimpleConfig';
    sub get_config_from_file {
        my ($class, $file) = @_;
        $loaded_file{$file}++;
        +{}
    }

    around configfile => sub {
        my $class = blessed($_[1]) || $_[1];
        $default_sub{$class}++;
        $class . ' file'
    };
}

is(
    exception {
        my $obj = OverriddenMethod->new_with_config;
        is($obj->configfile, blessed($obj) . ' file', 'configfile set via overridden sub');
        ok($default_sub{blessed($obj)}, 'default sub was called');
        is($loaded_file{blessed($obj) . ' file'}, 1, 'correct file was loaded from');
    },
    undef,
    'no exceptions',
);


