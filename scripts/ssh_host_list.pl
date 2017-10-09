#!/usr/bin/env perl

# script to print a list of hostname/IP address pairs from a '~/.ssh/config'
# file
use strict;
use warnings;
use 5.010;

# 'cat' the SSH config file containing the SSH Host blocks to this script for
# parsing.

my ($hostname, $host_addr, $username);
my %hosts;

# read in each line of the config file, and parse
foreach my $line ( <STDIN> ) {
   # skip comments
   next if ( $line =~ /^#/ );
   # look for blocks that start with the 'Host' SSH config param
   if ( $line =~ /Host (.*)/i ) {
      # save the existing host block, if defined
      if ( defined $hostname ) {
         # warn before overwriting an existing host
         warn qq(WARNING: Host $hostname exists twice in SSH config\n)
            if ( exists($hosts{$hostname}) );
         # set up an array for the given hostname key
         $hosts{$hostname} = [ $host_addr, $username ];
      }
      # the hostname should be the first capture
      $hostname = $1;
      # reset the host address and username
      $host_addr = undef;
      $username = undef;
   }
   if ( $line =~ /Hostname (.*)/i ) {
      $host_addr = $1;
   }
   if ( $line =~ /User (.*)/i ) {
      $username = $1;
   }
}

# one last check of $hostname
if ( defined $hostname ) {
   # warn before overwriting an existing host key
   warn qq(WARNING: Host $hostname exists twice in SSH config\n)
      if ( exists($hosts{$hostname}) );
   # set up an array for the given hostname key
   $hosts{$hostname} = [ $host_addr, $username ];
}

foreach my $hostkey ( sort(keys(%hosts)) ) {
   # "cast" the hash key into separate variables
   my ($this_addr, $this_user) = @{$hosts{$hostkey}};
   $this_addr = q() unless ( defined $this_addr );
   $this_user = q() unless ( defined $this_user );

format HOST_BLOCK =
  @>>>>>>>>>>>>>>>>  ->  @<<<<<<<<<<<<<< (^*)
  $hostkey, $this_addr, $this_user
.

   # set the output format name
   $~ = 'HOST_BLOCK';
   # write the format block
   write;
}
