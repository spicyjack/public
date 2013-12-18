#!/usr/bin/perl

# pasted into #gtk-perl on 2013-12-17 @ 18:19PST by <leahcim>
use strict;

use Glib qw/TRUE FALSE/;
use Gtk2;

init Gtk2;

my $notebook = new Gtk2::Notebook;
$notebook->set_size_request (700, 400);

my $window = new Gtk2::Window 'toplevel';
$window->signal_connect('delete_event' => sub { Gtk2->main_quit; });
$window->add ($notebook);
$window->show_all; # $rxvtsock->window->get_xid will fail otherwise

foreach my $tab (qw/zero one two three/) {

    my $rxvtsock = new Gtk2::Socket;
    $notebook->append_page($rxvtsock,"tab $tab");
    $notebook->set_tab_reorderable($rxvtsock,1);
    
    my $xid = $rxvtsock->window->get_xid;
    system "rxvt -title title-$tab -embed $xid &";
}

$window->show_all;

main Gtk2;
