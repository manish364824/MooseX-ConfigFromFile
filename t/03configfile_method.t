#!/usr/bin/env perl 
use strict;
use Test::More;
use Test::Fatal;
{
    package A;
    use Moose;
    with qw(MooseX::ConfigFromFile);

    sub configfile { 'moo' }

    sub get_config_from_file { {} }
}

{
    package B;
    use Moose;
    extends qw(A);

    sub configfile { die; }
    has configfile => ( is => 'bare', default => 'bar' );

}

is(exception { A->new_with_config() }, undef, 'A->new_with_config lives');
is(exception { B->new_with_config() }, undef, 'B->new_with_config lives');

done_testing();
