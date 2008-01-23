# Load the Module::Install bundled in ./inc/
use inc::Module::Install 0.65;

name 'MooseX-ConfigFromFile';
all_from 'lib/MooseX/ConfigFromFile.pm';

test_requires 'Test::More' => '0.42';

requires 'Moose'                      => '0.35';
requires 'MooseX::Types::Path::Class' => '0.04';

# Rebuild README for maintainers
system("pod2text lib/MooseX/ConfigFromFile.pm >README") if -e 'MANIFEST.SKIP';

auto_provides;
auto_install;
WriteAll;
