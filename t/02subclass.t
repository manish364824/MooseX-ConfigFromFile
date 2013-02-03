use strict;
use warnings;

use Test::More tests => 3;
use Test::Fatal;
use Test::NoWarnings 1.04 ':early';

{
    package A;
    use Moose;
    with qw(MooseX::ConfigFromFile);

    sub get_config_from_file { }
}

{
    package B;
    use Moose;
    extends qw(A);
}

ok(B->does('MooseX::ConfigFromFile'), 'B does ConfigFromFile');
is(exception { B->new_with_config() }, undef, 'B->new_with_config lives');

