# Load the Module::Install bundled in ./inc/
use inc::Module::Install 0.75;

name 'MooseX-ConfigFromFile';
all_from 'lib/MooseX/ConfigFromFile.pm';

test_requires 'Test::More' => '0.42';
test_requires 'Test::Fatal';

requires 'Moose'                      => '0.35';
requires 'MooseX::Types::Path::Class' => '0.04';
requires 'Try::Tiny';

# Rebuild README for maintainers
system("pod2text lib/MooseX/ConfigFromFile.pm >README") if $Module::Install::AUTHOR;

auto_provides;
auto_install;
WriteAll;
