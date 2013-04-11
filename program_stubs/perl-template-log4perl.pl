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
 -v|--verbose       Verbose script execution
 -h|--help          Shows this help text

 Other script options:
 -c|--catalog       Catalog spreadsheet file
 -d|--dumpdir       Dump file objects to this directory (Create if needed)
 --show-empty       Show empty cells (cells containing only whitespace)
 --show-tables      Show all parts tables worksheets
 --show-diagrams    Show all diagram worksheets
 --show-groups      Show all group worksheets
 --show-all         Show all worksheets

 Example usage:

 # list the structure of an XLS file
 perl-template-log4perl.pl --catalog /path/to/UralCatalog.xls \

You can view the full C<POD> documentation of this file by calling C<perldoc
perl-template-log4perl.pl>.

=cut

our @options = (
    # script options
    q(verbose|v+),
    q(help|h),
    # other options
    q(catalog|c=s),
    q(dumpdir|dir|dump|d=s),
    q(show-empty|empty),
    q(show-tables|tables),
    q(show-groups|groups),
    q(show-diagrams|diagrams),
    q(show-all|all),
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
} # sub new

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
} # sub get

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
    } # if ( exists $args{$key} )
    return undef;
} # sub get

=item get_args( )

Returns a hash containing the parsed script arguments.

=cut

sub get_args {
    my $self = shift;
    # hash-ify the return arguments
    return %{$self->{_args}};
} # get_args

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

my %pps_type = (
    1   => q|'Directory'|,
    2   => q|'File (Data)'|,
    5   => q|'Root'|,
);

    binmode(STDOUT, ":utf8");
    #my $catalog_file = q(/srv/www/purl/html/Ural_Catalog/UralCatalog.xls);
    # create a logger object
    my $config = Template::Config->new();

    # set up the logger
    #my $log_conf = qq(log4perl.rootLogger = WARN, Screen\n);
    my $log_conf = qq(log4perl.rootLogger = INFO, Screen\n);
#    if ( ! -t STDOUT ) {
#        $log_conf .= qq(log4perl.appender.Screen = )
#            . qq(Log::Log4perl::Appender::Screen\n);
#    } else {
        $log_conf .= qq(log4perl.appender.Screen = )
            . qq(Log::Log4perl::Appender::ScreenColoredLevels\n);
#    } # if ( $Config->get(q(o_colorlog)) )

    $log_conf .= qq(log4perl.appender.Screen.stderr = 1\n)
        . qq(log4perl.appender.Screen.utf8 = 1\n)
        . qq(log4perl.appender.Screen.layout = PatternLayout\n)
        #. q(log4perl.appender.Screen.layout.ConversionPattern = %d %p %m%n)
        . q(log4perl.appender.Screen.layout.ConversionPattern )
        . qq(= %d{HH.mm.ss} %p -> %m%n\n);
    # create a logger object, and prime the logfile for this session
    Log::Log4perl::init( \$log_conf );
    my $log = get_logger("");

    $log->logdie(qq(Missing '--catalog' spreadsheet file argument))
        unless ( defined $config->get(q(catalog)) );
    $log->logdie(qq(Can't read catalog file ) . $config->get(q(catalog)) )
        unless ( -r $config->get(q(catalog)) );

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
