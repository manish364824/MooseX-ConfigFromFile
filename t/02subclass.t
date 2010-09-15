#!/usr/bin/env perl 
use strict;
use Test::More;
use Test::Exception;
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
lives_ok { B->new_with_config() } 'B->new_with_config lives';

done_testing();
