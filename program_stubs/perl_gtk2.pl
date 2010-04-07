#!/usr/bin/env perl

# $Id: perl_gtk2.pl,v 1.2 2009-09-19 08:27:49 brian Exp $
# Copyright (c)2001 by Brian Manning
#
# perl script that does something

=head1 NAME

SomeScript

=head1 DESCRIPTION

B<SomeScript> does I<Something>

=head1 FUNCTIONS 

=head2 SomeFunction()

SomeFunction() is a function that does something.  

=cut

################
# SomeFunction #
################
sub SomeFunction {
} # sub SomeFunction
				
package main;
# slice up the CVS Keyword to get the revision number
$main::VERSION = (q$Revision: 1.2 $ =~ /(\d+)/g)[0];
use strict;
use warnings;
# Gtk2->init; works if you don't use -init on use
use Gtk2 -init;

# create the window, with an Gtk2::WindowType argument (see Gtk2::Window POD
# page for the list of enumerated types)
my $window = Gtk2::Window->new (q(toplevel));
# create the button with the button text; use underline characters to denote
# shortcuts
my $button = Gtk2::Button->new (q(_Quit));
# connect the button's 'click' signal to an action
$button->signal_connect (clicked => sub { Gtk2->main_quit });
# add the button to the window
$window->add ($button);
# show the window
$window->show_all;
# yield to Gtk2 and wait for user input
Gtk2->main;

=pod

=head1 CONTROLS

=over 5

=item B<Description of Controls>

=over 5

=item B<A Control Here>

This is a description about A Control.

=item B<Another Control>

This is a description of Another Control

=back 

=back

=head1 VERSION

The CVS version of this file is $Revision: 1.2 $. See the top of this file for the
author's version number.

=head1 AUTHOR

Brian Manning E<lt>elspicyjack at gmail dot comE<gt>

=cut

### begin license blurb
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



# vi: set ft=perl sw=4 ts=4:
# end of line
1;
