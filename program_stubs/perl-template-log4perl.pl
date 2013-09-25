#!/usr/bin/perl -w

# Copyright (c) 2013 by Brian Manning <brian at xaoc dot org>

# For support with this file, please file an issue on the GitHub issue tracker
# for this project: https://github.com/spicyjack/public/issues

=head1 NAME

B<perl-template-log4perl.pl> - A Perl script template that uses the
L<Log::Log4perl> logging module.

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

 perl perl-template-log4perl.pl [OPTIONS]

 Script options:
 -h|--help          Shows this help text
 -d|--debug         Debug script execution
 -v|--verbose       Verbose script execution
 -c|--colorize      Always colorize script output

 Other script options:
 -o|--option        A script option
 --some-option      Another script option

 Example usage:

 # list the structure of an XLS file
 perl-template-log4perl.pl --option /path/to/a/file \

You can view the full C<POD> documentation of this file by calling C<perldoc
perl-template-log4perl.pl>.

=cut

our @options = (
    # script options
    q(debug|d),
    q(verbose|v),
    q(help|h),
    q(colorize|c), # always colorize output
    # other options

    q(option|o=s),
    q(some-option),
);

=head1 DESCRIPTION

B<perl-template-log4perl.pl> - A Perl script template that uses the
L<Log::Log4perl> logging module.

=head1 OBJECTS

=head2 Template::Config

An object used for storing configuration data.

=head3 Object Methods

=cut

#############################
# Template::Config #
#############################
package Template::Config;
use strict;
use warnings;
use Getopt::Long;
use Log::Log4perl;
use Pod::Usage;
use POSIX qw(strftime);

=over

=item new( )

Creates the L<Template::Config> object, and parses out options using
L<Getopt::Long>.

=cut

sub new {
    my $class = shift;

    my $self = bless ({}, $class);

    # script arguments
    my %args;

    # parse the command line arguments (if any)
    my $parser = Getopt::Long::Parser->new();

    # pass in a reference to the args hash as the first argument
    $parser->getoptions( \%args, @options );

    # assign the args hash to this object so it can be reused later on
    $self->{_args} = \%args;

    # dump and bail if we get called with --help
    if ( $self->get(q(help)) ) { pod2usage(-exitstatus => 1); }

    # return this object to the caller
    return $self;
}

=item get($key)

Returns the scalar value of the key passed in as C<key>, or C<undef> if the
key does not exist in the L<Template::Config> object.

=cut

sub get {
    my $self = shift;
    my $key = shift;
    # turn the args reference back into a hash with a copy
    my %args = %{$self->{_args}};

    if ( exists $args{$key} ) { return $args{$key}; }
    return undef;
}

=item set( key => $value )

Sets in the L<Template::Config> object the key/value pair passed in as
arguments.  Returns the old value if the key already existed in the
L<Template::Config> object, or C<undef> otherwise.

=cut

sub set {
    my $self = shift;
    my $key = shift;
    my $value = shift;
    # turn the args reference back into a hash with a copy
    my %args = %{$self->{_args}};

    if ( exists $args{$key} ) {
        my $oldvalue = $args{$key};
        $args{$key} = $value;
        $self->{_args} = \%args;
        return $oldvalue;
    } else {
        $args{$key} = $value;
        $self->{_args} = \%args;
    }
    return undef;
}

=item defined($key)

Returns "true" (C<1>) if the value for the key passed in as C<key> is
C<defined>, and "false" (C<0>) if the value is undefined, or the key doesn't
exist.

=cut

sub defined {
    my $self = shift;
    my $key = shift;
    # turn the args reference back into a hash with a copy
    my %args = %{$self->{_args}};

    # Can't use Log4perl here, since it hasn't been set up yet
    if ( exists $args{$key} ) {
        #warn qq(exists: $key\n);
        if ( defined $args{$key} ) {
            #warn qq(defined: $key; ) . $args{$key} . qq(\n);
            return 1;
        }
    }
    return 0;
}

=item get_args( )

Returns a hash containing the parsed script arguments.

=cut

sub get_args {
    my $self = shift;
    # hash-ify the return arguments
    return %{$self->{_args}};
}

################
# package main #
################
package main;
use 5.010;
use strict;
use warnings;
use utf8;
use Carp;
use Log::Log4perl qw(get_logger :no_extra_logdie_message);
use Log::Log4perl::Level;

    binmode(STDOUT, ":utf8");
    #my $catalog_file = q(/srv/www/purl/html/Ural_Catalog/UralCatalog.xls);
    # create a logger object
    my $cfg = Template::Config->new();

    # Start setting up the Log::Log4perl object
    my $log4perl_conf = qq(log4perl.rootLogger = WARN, Screen\n);
    if ( $cfg->defined(q(verbose)) && $cfg->defined(q(debug)) ) {
        die(q(Script called with --debug and --verbose; choose one!));
    } elsif ( $cfg->defined(q(debug)) ) {
        $log4perl_conf = qq(log4perl.rootLogger = DEBUG, Screen\n);
    } elsif ( $cfg->defined(q(verbose)) ) {
        $log4perl_conf = qq(log4perl.rootLogger = INFO, Screen\n);
    }

    # Use color when outputting directly to a terminal, or when --colorize was
    # used
    if ( -t STDOUT || $cfg->get(q(colorize)) ) {
        $log4perl_conf .= q(log4perl.appender.Screen )
            . qq(= Log::Log4perl::Appender::ScreenColoredLevels\n);
    } else {
        $log4perl_conf .= q(log4perl.appender.Screen )
            . qq(= Log::Log4perl::Appender::Screen\n);
    }

    $log_conf .= qq(log4perl.appender.Screen.stderr = 1\n)
        . qq(log4perl.appender.Screen.utf8 = 1\n)
        . qq(log4perl.appender.Screen.layout = PatternLayout\n)
        . q(log4perl.appender.Screen.layout.ConversionPattern )
        # %r: number of milliseconds elapsed since program start
        # %p{1}: first letter of event priority
        # %4L: line number where log statement was used, four numbers wide
        # %M{1}: Name of the method name where logging request was issued
        # %m: message
        # %n: newline
        . qq|= [%8r] %p{1} %4L (%M{1}) %m%n\n|;
        #. qq( = %d %p %m%n\n)
        #. qq(= %d{HH.mm.ss} %p -> %m%n\n);

    # create a logger object, and prime the logfile for this session
    Log::Log4perl::init( \$log_conf );
    my $log = get_logger("");

    $log->logdie(qq(Missing '--option' file argument))
        unless ( $cfg->defined(q(option)) );
    $log->logdie(qq(Can't read option file ) . $cfg->get(q(option)) )
        unless ( -r $cfg->get(q(option)) );

    # print a nice banner
    $log->info(qq(Starting perl-template-log4perl.pl, version $VERSION));
    $log->info(qq(My PID is $$));

    # FIXME script guts go here

=cut

=back

=head1 AUTHOR

Brian Manning, C<< <brian at xaoc dot org> >>

=head1 BUGS

Please report any bugs or feature requests to the GitHub issue tracker for
this project:

C<< <https://github.com/spicyjack/public/issues> >>.

=head1 SUPPORT

You can find documentation for this script with the perldoc command.

    perldoc perl-template-log4perl.pl

=head1 COPYRIGHT & LICENSE

Copyright (c) 2013 Brian Manning, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

# fin!
# vim: set shiftwidth=4 tabstop=4
