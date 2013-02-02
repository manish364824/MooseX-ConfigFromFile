# Load the Module::Install bundled in ./inc/
use inc::Module::Install 0.75;

use Module::Install::ReadmeFromPod;
use Module::Install::AutoLicense;

name 'MooseX-ConfigFromFile';
all_from        'lib/MooseX/ConfigFromFile.pm';
readme_from     'lib/MooseX/ConfigFromFile.pm';
auto_license;

test_requires 'Test::More' => '0.42';
test_requires 'Test::Fatal';
test_requires 'Test::Requires';
test_requires 'Test::NoWarnings'      => '1.04';
test_requires 'Test::Without::Module';

requires 'Moose'                      => '0.35';
requires 'MooseX::Types::Path::Tiny';
requires 'Try::Tiny';
requires 'namespace::autoclean';

resources repository => 'git://git.moose.perl.org/MooseX-ConfigFromFile.git';

WriteAll;
