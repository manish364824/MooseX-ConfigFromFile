# NAME

MooseX::ConfigFromFile - An abstract Moose role for setting attributes from a configfile

# SYNOPSIS

    ########
    ## A real role based on this abstract role:
    ########

    package MooseX::SomeSpecificConfigRole;
    use Moose::Role;

    with 'MooseX::ConfigFromFile';

    use Some::ConfigFile::Loader ();

    sub get_config_from_file {
      my ($class, $file) = @_;

    my $options_hashref = Some::ConfigFile::Loader->load($file);

      return $options_hashref;
    }



    ########
    ## A class that uses it:
    ########
    package Foo;
    use Moose;
    with 'MooseX::SomeSpecificConfigRole';

    # optionally, default the configfile:
    sub _get_default_configfile { '/tmp/foo.yaml' }

    # ... insert your stuff here ...

    ########
    ## A script that uses the class with a configfile
    ########

    my $obj = Foo->new_with_config(configfile => '/etc/foo.yaml', other_opt => 'foo');

# DESCRIPTION

This is an abstract role which provides an alternate constructor for creating
objects using parameters passed in from a configuration file.  The
actual implementation of reading the configuration file is left to
concrete sub-roles.

It declares an attribute `configfile` and a class method `new_with_config`,
and requires that concrete roles derived from it implement the class method
`get_config_from_file`.

Attributes specified directly as arguments to `new_with_config` supersede those
in the configfile.

[MooseX::Getopt](http://search.cpan.org/perldoc?MooseX::Getopt) knows about this abstract role, and will use it if available
to load attributes from the file specified by the command line flag `--configfile`
during its normal `new_with_options`.

# Attributes

## configfile

This is a [Path::Tiny](http://search.cpan.org/perldoc?Path::Tiny) object which can be coerced from a regular path
string or any object that supports stringification.
This is the file your attributes are loaded from.  You can add a default
configfile in the consuming class and it will be honored at the appropriate
time; see below at ["\_get\_default\_configfile"](#\_get\_default\_configfile).

If you have [MooseX::Getopt](http://search.cpan.org/perldoc?MooseX::Getopt) installed, this attribute will also have the
`Getopt` trait supplied, so you can also set the configfile from the
command line.

# Class Methods

## new\_with\_config

This is an alternate constructor, which knows to look for the `configfile` option
in its arguments and use that to set attributes.  It is much like [MooseX::Getopts](http://search.cpan.org/perldoc?MooseX::Getopts)'s
`new_with_options`.  Example:

    my $foo = SomeClass->new_with_config(configfile => '/etc/foo.yaml');

Explicit arguments will override anything set by the configfile.

## get\_config\_from\_file

This class method is not implemented in this role, but it is required of all
classes or roles that consume this role.
Its two arguments are the class name and the configfile, and it is expected to return
a hashref of arguments to pass to `new()` which are sourced from the configfile.

## \_get\_default\_configfile

This class method returns nothing by default, but can and should be redefined
in a consuming class to return the default value of the configfile (if not
passed into the constructor explicitly).

# COPYRIGHT

Copyright (c) - the MooseX::ConfigFromFile "AUTHOR" and "CONTRIBUTORS" as listed below.

# AUTHOR

Brandon L. Black, <blblack@gmail.com>

# CONTRIBUTORS

- Tomas Doran
- Karen Etheridge
- Chris Prather
- Zbigniew Lukasiak

# LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
