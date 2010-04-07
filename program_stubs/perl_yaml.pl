#!/usr/bin/perl

# $Id: perl_yaml.pl,v 1.1 2009-09-19 07:47:00 brian Exp $
# Copyright (c)2007 by Brian Manning
#
# perl script that parses a YAML file, then does something

#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; version 2 dated June, 1991.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program;  if not, write to the Free Software
#   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111, USA.

use strict;
use warnings;

use Log::Log4perl qw(get_logger :levels);
use Data::Dumper;
use Getopt::Long;
use Time::Local;
use Pod::Usage;

=pod

=head1 NAME

ip_services.pl

=head1 SYNOPSIS

ip_services.pl [OPTIONS]

General Options

  [-h|--help]             Shows script help information
  [-y|-ya|-yamlfile]      YAML file containing information sks
  [-o|-od|-output-dir]    Output file for tasklist info (Default: STDOUT) 

Debugging Options
  [-D|-DEBUG]             Turn on debugging
  [-nocolorlog]           Don't colorize log output       
=cut

# for use with getoptions() call below
my ($DEBUG, $output_dir, $yaml_file);
my $colorlog = 1;

my $goparse = Getopt::Long::Parser->new();
$goparse->getoptions(   q(DEBUG|D)                  => \$DEBUG,
                        q(help|h)                   => \&ShowHelp,
                        q(output-dir|od|o=s)        => \$output_dir,
                        q(yamlfile|ya|y=s)          => \$yaml_file,
                        q(colorlog!)                => \$colorlog,
                    ); # $goparse->getoptions

# set up the logger
my $logger_conf = qq(log4perl.rootLogger = INFO, Screen\n);
if ( $colorlog ) {
    $logger_conf .= qq(log4perl.appender.Screen = )
        . qq(Log::Log4perl::Appender::ScreenColoredLevels\n);
} else {
    $logger_conf .= qq(log4perl.appender.Screen = )
        . qq(Log::Log4perl::Appender::Screen\n);
} # if ( $Config->get(q(colorlog)) )

$logger_conf .= qq(log4perl.appender.Screen.stderr = 1\n)
    . qq(log4perl.appender.Screen.layout = PatternLayout\n)
    . q(log4perl.appender.Screen.layout.ConversionPattern = %d %p %m%n)
    . qq(\n);
#log4perl.appender.Screen.layout.ConversionPattern = %d %p> %F{1}:%L %M - %m%n
# create the logger object
Log::Log4perl::init( \$logger_conf );
my $logger = get_logger("");
if ( defined $DEBUG ) {
    $logger->level($DEBUG);
} else {
    $logger->level($INFO);
} # if ( defined $DEBUG )

my $yamlfile = IP::Services::YAMLFile->new(filename => $yaml_file);

exit 0;

# simple help subroutine
sub ShowHelp {
# shows the POD documentation (short or long version)
    my $whichhelp = shift;  # retrieve what help message to show
    shift; # discard the value

    # call pod2usage and have it exit non-zero
    # if if one of the 2 shorthelp options were not used, call longhelp
    if ( ($whichhelp eq q(help))  || ($whichhelp eq q(h)) ) {
        pod2usage(-exitstatus => 1);
    } else {
        pod2usage(-exitstatus => 1, -verbose => 2);
    }

} # sub ShowHelp

### common script functions
package IP::Services::Common;
use strict;
use warnings;
use Log::Log4perl qw(get_logger :levels);

sub dump {
    my $self = shift;
    my $dumpval = shift;
    my $logger = get_logger();
    # create a Data::Dumper object
    my $dd = Data::Dumper->new([$dumpval]);

    $logger->info(qq(Dumping data:));
    $logger->info($dd->Dump());
} # sub _dump

# a YAML file of some kind
package IP::Services::YAMLFile;
use strict;
use warnings;
use IO::YAML;
use Log::Log4perl qw(get_logger :levels);

@IP::Services::YAMLFile::ISA = qw(IP::Services::Common);

sub new {
    my $class = shift;
    my %args = @_;
    my $self = bless ({}, $class);
    my $logger = get_logger();

    my $filename = $args{filename};
    # verify the input file is set
    if ( defined $filename ) {
        if ( -r $filename ) {
            # create a YAML object by reading the YAML file
            # default is to open the file read-only
            my $yamlobj = IO::YAML->new( 
                            'path' => $filename, 
                            'auto_load' => 1 );
            my $yamlref;
            # read the data stream
            while ( not $yamlobj->eof() ) {
                $yamlref = <$yamlobj>;
            } # while ( not $yamlobj->eof() )
            return $yamlref;
        } else {
            $logger->logcroak(
                qq(ERROR: '$filename' not available/not readable));
        } # if ( -r q(tasklist.yaml) )
    } # if ( defined $filename )
} # sub new

### end package Tasklist::YAMLFile

# Loads tasklist from file, stores tasklist internally, runs queries against
# OffTime object to build list for outputting to screen/file
package Tasklist;
use strict;
use warnings;
use Log::Log4perl qw(get_logger :levels);

@Tasklist::ISA = qw(Tasklist::Common);

{ # begin private variables and methods
    my $_tasklist;

    sub _set_tasklist { my $self = shift; $_tasklist = shift; }

    sub _get_tasklist { return $_tasklist; }
    
} # end private variables and methods

sub new {
    my $class = shift;
    my %args = @_;
    my $self = bless ({}, $class);

    return $self;
} # sub new

sub get_tasklist {
# get a copy of the tasklist object
    my $self = shift;
    return $self->_get_tasklist();
} # sub get_tasklist

sub get_taskkeys {
# return a list of task fields in order
    return qw(scheduled_release percent_complete task_duration 
        task_title task_description );
} # sub get_taskkeys

sub get_taskkeys_pretty {
# return a list of task fields in order
    return qw(Scheduled_Release Percent_Complete Task_Duration 
        Task_Title Task_Description );
} # sub get_taskkeys

sub load_yaml {
# read data from a YAML file, and store the YAML object that's created as part
# of this object for later retreival; for the tasklist, it's up to the client
# to deserialize it and do something useful
    my $self = shift;
    my %args = @_;
  
    # set a filename if one didn't get passed in
    # defines performs autovivification
    if ( ! defined $args{filename} ) { $args{filename} = q(tasklist.yaml); }
    # add it to this object for later retrieval
    $self->_set_tasklist(Tasklist::YAMLFile->new(filename => $args{filename}));
    return $self->get_tasklist();
} # sub load_yaml
### end package Tasklist

# an object that holds all of the vacation/holiday/weekend dates for querying
package OffTime;
use strict;
use warnings;
use Log::Log4perl qw(get_logger :levels);

@OffTime::ISA = qw(Tasklist::Common);

{ # begin private variables and methods
    my %_lookup; # storage container for holidays/weekends/vacation days

    # a count of how many entries exist in %_lookup
    sub _lookup_count { return scalar(keys(%_lookup)); }

    # see if something exists in the lookup hash 
    sub _lookup {
        my $self = shift;
        my $key = shift;
        my $logger = get_logger();

        $logger->debug(ref($self) . qq(->_lookup: entering with key $key)); 
        # return the value if the key exists, otherwise, return undef
        if ( exists $_lookup{$key} ) {
            $logger->debug(ref($self) . qq(->_lookup: returning: ) 
                . $_lookup{$key});
            return $_lookup{$key}
        } else {
            return undef;
        } # if ( exists $_lookup{$key} ) 
    } # sub _lookup

    # add an entry
    sub _lookup_add { 
        my $self = shift;
        my %args = @_;
        
        if ( ! exists $_lookup{$args{key}} ) {
            $_lookup{$args{key}} = $args{value};
        } else {
            $_lookup{$args{key}} = $_lookup{$args{key}} . q(; ) . $args{value};
        } # if ( ! exists $lookup
    } # sub _lookup_add
    
    # remove an entry
    sub _lookup_delete { }
    
    # generate a list of weekends for a given year
    sub _generate_weekends {
        my $self = shift;
        my %args = @_;
        my $dc = $args{dateconvert};
        my $current_year = $args{year};
        my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst);

        if ( ! defined $current_year ) {
            # what's the first weekend of this year?
            ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = 
                $dc->get_localtime();
            $current_year = $year + 1900;
        } # if ( ! defined $current_year )

        # loop across each day of the year, and check the '$wday' variable to
        # see if the current day is one of the two weekend days
        foreach my $yeardate ( 1 .. 366 ) {
            # get the epoch time for date '$yeardate' of the current year
            my $checkepoch = $dc->convert_timevals_to_epoch(
                                year => $current_year, monthday => $yeardate );
            # then split it back up so we can test for a saturday/sunday
            ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)
                = $dc->get_localtime($checkepoch);

            my $lookup_date = sprintf("%02d",$mday)
                . $dc->convert_month_to_string($mon) . $current_year;
            if ( $wday == 0 ) {
                $_lookup{$lookup_date} = q(Sunday);
            } elsif ( $wday == 6 ) {
                $_lookup{$lookup_date} = q(Saturday);
            } # if ( $wday == 0 )
            if ( exists $_lookup{$lookup_date} ) {
                #warn(qq(Day $lookup_date is a ) . $_lookup{$lookup_date} );
            } # if ( exists $_lookup{$lookup_date} )
        } # foreach my $yeardate ( 0 .. 365 )
    } # sub _generate_weekends

    sub _lookup_dump {
        my $self = shift;
        my $logger = get_logger();

        my @lookup_keys = sort(keys(%_lookup));
        $logger->info(qq(The lookup table currently holds:));
        foreach my $key ( @lookup_keys ) {
            $logger->info(qq(\t$key -> ) . $_lookup{$key});
        } # foreach $key ( @lookup_keys )
    } # sub _lookup_dump

} # end private variables and methods

sub new {
    my $class = shift;
    my %args = @_;
    my $self = bless ({}, $class);

    # grab a DateConvert object so we can do some funny stuff with dates
    my $dc = DateConvert->new();
    # figure out the weekends for the current year and add to the lookup table
    # what's the first weekend of this year?
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) 
        = $dc->get_localtime();
    my $current_year = $year + 1900;
    $self->_generate_weekends(dateconvert => $dc, year => $current_year);

    return $self;
} # sub new

sub dump {
    my $self = shift;
    $self->_lookup_dump();
} # sub dump

sub lookup {
# see if the key exists; return the value if it does, return undef if it does
# not
    my $self = shift;
    my $key = shift;

    return $self->_lookup($key);
} # sub lookup

sub lookup_count {
    my $self = shift;
    return $self->_lookup_count();
} # sub lookup_count

sub load_yaml {
# read data from a YAML file, and add it to the %_lookup database
# since the YAML file is in a specific serial format, we have to make sure it
# gets read correctly so that we get useful information back out of it
    my $self = shift;
    my %args = @_;
    my $logger = get_logger();

    # verify a filename was passed in, set a filename if none exists
    # the defined function performs autovivification if 'filename' doesn't
    # already exist
    #if ( ! defined $args{filename} ) { 
    #    $args{filename} = q(holidays.yaml); 
    #} else {
    #    $logger->info(ref($self) . q(->load_yaml: filename is ) 
    #        . $args{filename});
    #} # if ( ! exists $args{filename} || ! defined $args{filename} )
    #$logger->info(q(calling yamlfile from offtime->load_yaml));
    my $yamlfile = Tasklist::YAMLFile->new(filename => $args{filename});

    # assign the top level to a hash; we need to do this to get to the objects
    # on the second level of the data structure
    my %yamlhash = %$yamlfile; 
    # loop through all of the year keys in order to extract the data underneath
    # them
    foreach my $year ( keys(%yamlhash) ) {
        my %yearref = %{$yamlhash{$year}};
        foreach my $yearkeys ( keys(%yearref) ) {
            # FIXME add something here that looks for a dash '-' in the key,
            # and then adds dates in between the start/ending dates inclusive
            # as indicated by the dash character
            $self->_lookup_add(key => $yearkeys . $year, 
                value => $yearref{$yearkeys}); 
        } # foreach my $yearkeys ( keys(%$year) )
    } # foreach my $year ( @$yamlref )
} # sub load_yaml

# an object that builds a list of weekend dates for looking up
package DateConvert;
use strict;
use warnings;
use Time::Local q(timelocal_nocheck);
use Log::Log4perl qw(get_logger :levels);

@DateConvert::ISA = qw(Tasklist::Common);



{ # begin private variables and methods

#my @day_abbr = qw(Sun Mon Tue Wed Thu Fri Sat);
    my $_default_time;
    sub _set_default_time { my $self = shift; $_default_time = shift; }
    sub _get_default_time { return $_default_time; }

} # end private variables and methods

sub new {
    my $class = shift;
    my %args = @_;
    my $self = bless ({}, $class);

    # set a default time value in case the user doesn't pass one in
    if ( exists $args{timeval} ) {
        $self->_set_default_time($args{timeval});    
    } else {
        $self->_set_default_time(time);
    } # if ( exists $args{timeval} )

    return $self;
} # sub new

sub stat_file_mtime {
    my $self = shift;
    my %args = @_;

    my ($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,
        $atime,$mtime,$ctime,$blksize,$blocks) = stat($args{filename}); 
    
    return $mtime;
} # sub stat_file_mtime

sub convert_month_to_string {
    my $self = shift;
    my $month = shift;
    my @month_abbr = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);

    if ( $month >= 0 && $month <= 11 ) {
        return $month_abbr[$month];
    } else {
        warn(ref($self) . qq(->_convert_month_to_string\n)
            . qq(\tHmmm, can't convert '$month' into a string\n));
        return undef;
    } # if ( $month >= 0 && $month <= 11 )
} # sub convert_month_to_string

sub convert_string_to_month {
    my $self = shift;
    my $string = shift;
    my @month_abbr = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);

    my $month_count = 0;
    foreach my $month_check ( @month_abbr ) {
        if ( $month_check eq $string ) { return $month_count; }
        $month_count++;
    } # foreach $month_check ( @_abbr )
    warn(ref($self) . qq(->_convert_string_to_month\n)
        . qq(\tHmmm, can't convert '$string' into a number\n));
    return undef;
} # sub convert_month_to_string

sub get_default_time {
    my $self = shift;
    return $self->_get_default_time();
} # sub get_default_time

sub set_default_time {
    my $self = shift;
    my $timeval = shift;
    return $self->_set_default_time($timeval);
} # sub get_default_time

sub get_localtime {
    my $self = shift;
    my $epoch = shift;

    if ( ! defined $epoch ) {
        $epoch = $self->_get_default_time();
    } # if ( ! defined $epoch )
    return localtime($epoch);
} # sub get_localtime

sub convert_epoch_to_human {
    my $self = shift;
    my $epoch = shift;

    if ( ! defined $epoch ) {
        $epoch = $self->_get_default_time();
    } # if ( ! defined $epoch )
    #warn(qq(convert_epoch_to_human: epoch is $epoch));
    my $epoch_max = 2**32;
    # verify that epoch is really a time value
    if ( $epoch =~ /\d/ && $epoch < $epoch_max ) {
        my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) 
            = localtime($epoch);

        my $human_time = sprintf(q(%02u:%02u:%02u %02u),
            $hour, $min, $sec, $mday);
        $human_time .= $self->convert_month_to_string($mon);
        $human_time .= sprintf(q(%04u), $year + 1900);
        return $human_time;
    } else {
        warn(ref($self) . qq(->convert_epoch_to_human:\n)
            . qq(\tTime value '$epoch' is not a valid value\n));
        return undef;
    } # if ( $epoch ~= /\d/ && $epoch < 2^32 )
} # sub convert_epoch_to_human

sub convert_human_to_epoch {
    my $self = shift;
    my %args = @_;

    my $monthnum = $self->convert_string_to_month($args{month});
    return $self->convert_timevals_to_epoch( 
                second => $args{second}, minute => $args{minute},
                hour => $args{hour}, monthday => $args{monthday}, 
                month => $monthnum, year => $args{year});

} # sub convert_human_to_epoch

sub convert_timevals_to_epoch {
    my $self = shift;
    my %args = @_;

    # make sure all of the values of %args exist prior to calling localtime()
    foreach my $timeval ( qw(second minute hour monthday month year) ) {
        if ( ! exists $args{$timeval} ) { $args{$timeval} = 0; }
#        print qq($timeval:) . $args{$timeval} . q(;);
    } # foreach my $timeval ( qq(second minute hour monthday month year) )
#print qq(\n);

    return timelocal_nocheck (   $args{second}, $args{minute}, $args{hour},
                        $args{monthday}, $args{month}, $args{year});
} # sub convert_timevals_to_epoch

### end package Dateconvert

package TextOut;
use strict;
use warnings;
use Log::Log4perl qw(get_logger :levels);

{ # begin private variables and methods

    # output filehandle, could either be STDOUT or a regular file
    my $_OUTFH;
    sub _set_output_fh { my $self = shift; $_OUTFH = shift; }
    sub _get_output_fh { return $_OUTFH; }

    # whether or not to output in HTML or plain text
    my $_html_flag;
    sub _html_flag { 
        my $self = shift; 
        my $html_flag = shift; 
        if ( defined $html_flag ) {
            $_html_flag = 1
        } # if ( defined $html_flag )
        return $_html_flag;
    } # sub _html_flag

    my $_row_color;
    sub _row_color_toggle {
        # this changes the color flag to 1 if it's undef, and undef if it's 1
        $_row_color = ! $_row_color;
        return $_row_color;
    } #  sub _row_color_toggle

    sub _get_row_color { return $_row_color; }
} # end private variables and methods

sub new {
    my $class = shift;
    my %args = @_;
    my $self = bless ({}, $class);

    if ( defined $args{output_file} ) {
        open(FH, "> " . $args{output_file}) 
            or die qq(Unable to open output file) . $args{output_file}
                . qq(: $!);
        $self->_set_output_fh(*FH);
    } else {
        $self->_set_output_fh(*STDOUT);
    } # if ( defined $args{output_file} )
        
    if ( defined $args{html_flag} ) {
        $self->_html_flag($args{html_flag});
    } # if ( defined $args{html_flag} )
    return $self;
} # sub new
    
sub write_title {
    my $self = shift;
    my $write_string = shift;

    my $FH = $self->_get_output_fh();

    if ( $self->_html_flag() ) {
        print $FH qq(<h3>$write_string</h3>\n);
    } else {
        print $FH qq($write_string\n);
    } # if ( $self->_html_flag() )

    # warm fuzzies
    return 1;
} # sub write_title

sub write_offtime {
    my $self = shift;
    my %args = @_;

    my $FH = $self->_get_output_fh();

    if ( $self->_html_flag() ) {
        print $FH qq(</tr><tr style="background: #c2ffc2">\n)
            . q(<td class="text-align: left">) . $args{date} . qq(</td>\n) 
            . q(<td colspan="4">) . $args{desc} . qq(</td></tr>\n);
    } # if ( $self->_html_flag() )

    # warm fuzzies
    return 1;
} # sub write_offtime

sub write_task {
    my $self = shift;
    my %args = @_;

    # grab the filehandle to write out to
    my $FH = $self->_get_output_fh();

    # if we're outputting HTML, add HTML tags to all of the content
    if ( $self->_html_flag() ) {
        if ( $args{title} eq q(task_description) ) {
            my $row_color;
            if ( $self->_get_row_color ) { 
                $row_color = q(#abeaea);
            } else {
                $row_color = q(#ffffff);
            } # if ( $self->_get_row_color )
            print $FH qq(</tr><tr style="background: $row_color">\n)
                . qq(<td class="text-align: left">)
                . qq(<em>Task_Description</em></td>\n) 
                . qq(<td colspan="4">) . $args{desc} . qq(</td>\n);
        } else {
            if ( $args{title} eq q(task_title) 
                || $args{title} eq qq(completion_date) ) {
                print $FH q(<td style="text-align: left">) 
                    . $args{desc} . qq(</td>\n);
            } else {
                print $FH q(<td style="text-align: center">) 
                    . $args{desc} . qq(</td>\n);
            } # if ( $args{title} eq q(task_title) ) 
        } # if ( $args{title} eq q(task_description) ) 
    } else {
        print $FH qq(\t) . $args{title} . q(: ) . $args{desc} . qq(\n);
    } # if ( $self->_html_flag() )

    # warm fuzzies
    return 1;
} # sub write_task

sub table_start {
    my $self = shift;
    my $FH = $self->_get_output_fh();

    if ( $self->_html_flag() ) {
        print $FH qq(<table width="100%">\n);
    } # if ( $self->_html_flag() )
    # warm fuzzies
    return 1;
} # sub table_start

sub table_end {
    my $self = shift;
    my $FH = $self->_get_output_fh();

    if ( $self->_html_flag() ) {
        print $FH qq(</table>\n);
    } # if ( $self->_html_flag() )
    # warm fuzzies
    return 1;
} # sub table_end

sub table_row_header {
    my $self = shift;
    my @header_text = @_;
    my $FH = $self->_get_output_fh();

    if ( $self->_html_flag() ) {
        print $FH qq(<tr style="text-align:center; background: #8a8aFF;">\n);
        foreach my $header ( @header_text ) {
            if ( $header ne q(Task_Description) ) {
                if ( $header eq q(Task_Title) ) { 
                    print $FH qq(<th width="40%" style="text-align: left">)
                        . $header . qq(</th>\n);
                } else {
                    print $FH qq(<th>$header</th>\n);
                } # if ( $header eq q(Task_Title) )
            } # if ( $header ne q(Task_Description) )
        } # foreach my $header ( @header_text )
        print $FH qq(</tr>\n);
    } # if ( $self->_html_flag() )
    # warm fuzzies
    return 1;
} # sub table_row_header

sub table_row_start {
    my $self = shift;
    my $FH = $self->_get_output_fh();

    if ( $self->_html_flag() ) {
        my $row_color;
        if ( $self->_get_row_color ) { 
            $row_color = q(#abeaea);
        } else {
            $row_color = q(#ffffff);
        } # if ( $self->_get_row_color )

        print $FH qq(<tr style="background: $row_color">\n);
    } # if ( $self->_html_flag() )
    # warm fuzzies
    return 1;
} # sub table_row_start

sub table_row_end {
    my $self = shift;
    my $FH = $self->_get_output_fh();

    if ( $self->_html_flag() ) {
        print $FH qq(</tr>\n);
    } # if ( $self->_html_flag() )
    # warm fuzzies
    return 1;
} # sub table_row_start

sub row_color_toggle { my $self = shift; $self->_row_color_toggle(); }

sub html_body_start {
    my $self = shift;
    my $FH = $self->_get_output_fh();

    if ( $self->_html_flag() ) {
        print $FH qq(<html>\n)
            . q(<body style="font-family: sans-serif">)
            . qq(\n);
            #. q(<body style="font-family: 'Trebuchet MS', sans-serif">)
    } # if ( $self->_html_flag() )
    # warm fuzzies
    return 1;
} # sub table_row_end

sub html_body_end {
    my $self = shift;
    my $FH = $self->_get_output_fh();

    if ( $self->_html_flag() ) {
        print $FH qq(</body>\n</html>\n);
    } # if ( $self->_html_flag() )
    # warm fuzzies
    return 1;
} # sub table_row_start

sub last_updated_date {
    my $self = shift;
    my %args = @_;
    my $FH = $self->_get_output_fh();

    if ( $self->_html_flag() ) {
        print $FH qq(<p>This file last updated: ) 
            . $args{dateconvert}->convert_epoch_to_human() . qq(; )
            . qq(The original tasklist file was last updated: ) 
            . $args{dateconvert}->convert_epoch_to_human($args{tasklist_mtime}) 
            . qq(</p>\n);
    } # if ( $self->_html_flag() )
    # warm fuzzies
    return 1;
} # sub table_row_start

### end package TextOut

=head1 VERSION

The CVS version of this file is $Revision: 1.1 $. See the top of this file for the
author's version number.

=head1 AUTHOR

Brian Manning

=cut

# vi: set sw=4 ts=4 cin:
# end of line

# end of line
