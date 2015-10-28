#!/usr/bin/env php

<?php
/**
 * FILENAME:
 * php-cli.php
 *
 * DESCRIPTION:
 * Sample CLI PHP script
 *
 */

$scriptName = basename($argv[0], ".php");

###### BEGIN SCRIPT ######
define('LOCK_FILE', __DIR__ . "{$scriptName}.lock");
$scriptPID = getmypid();

// set a default timezone
date_default_timezone_set("America/Los_Angeles");

// this will exit() if --help is called
$cmdOptions = handleGetOpts();

$verbose = FALSE;
if ( key_exists("v", $cmdOptions) || key_exists("verbose", $cmdOptions) ) {
   $verbose = TRUE;
   printf("=== %s -> PID: %s ===\n", $scriptName, $scriptPID);
   print "-> Verbose execution requested\n";
}

// SCRIPT GUTS GO HERE

// remove the lockfile
unlink(LOCK_FILE);

// end script
exit;

function handleGetOpts()
{
   global $argv;
   // set up parsing of commandline options
   $shortOpts = '';
   $longOpts = array();

   // SCRIPT OPTIONS
   // show help output
   $shortOpts .= 'h';
   $longOpts[] = 'help';
   // input filename
   $shortOpts .= 'f:';
   $longOpts[] = 'file:';
   // output filename
   $shortOpts .= 'o:';
   $longOpts[] = 'output:';

   // parse command line options
   $optionsArray = getopt($shortOpts, $longOpts);

   // handle request for script help
   if ( key_exists("h", $optionsArray) || key_exists("help", $optionsArray) ) {
      print "{$argv[0]} - Options:\n\n";
      print "  -h|--help      Show this help\n";
      print "  -f|--file      Input filename\n";
      print "  -o|--output    Output filename\n";
      print "\n";
      exit(0);
   }

   return $optionsArray;
}

function getLock()
{
   // taken from: http://us2.php.net/manual/en/function.getmypid.php
   // If lock file exists, check if stale.  If exists and is not stale, return
   // TRUE Else, create lock file and return FALSE.

   // the @ in front of 'symlink' is to suppress the NOTICE you get if the
   // LOCK_FILE exists
   if (@symlink("/proc/" . getmypid(), LOCK_FILE) !== FALSE) 
      return TRUE;

   // link already exists; check if it's stale
   if (is_link(LOCK_FILE) && !is_dir(LOCK_FILE))
   {
      unlink(LOCK_FILE);
      # try to lock again
      return getLock();
   }

   return FALSE;
}
# vim: filetype=php shiftwidth=3 tabstop=3
