# Gtk3 Codex #

How to use Perl Gtk3, for the compleat newb to the Gtk2-Perl veteran. 

## Metaquestions ##
- How to structure the document?
  - Talk about GTK first, or Perl, or Gtk-Perl, or ??
  - Follow the format of existing tutorials?
- What to write the document in?
  - `asciidoc`?
    - Can `ascidooc` do code blocks?

## What to talk about? ##
- What's different about Gtk3
  - https://developer.gnome.org/gtk3/stable/gtk-migrating-2-to-3.html
  - No more GDK for drawing, use Cairo
  - Theming
  - Multiple backends can be enabled at compile time
- Converting scripts from Gtk2 to Gtk3
- Use GTK+3 docs, and outline ideas from GTK+2 tutorial
  - http://gtk2-perl.sourceforge.net/doc/intro/
  - http://www.gtk.org/features.php
  - https://developer.gnome.org/gtk-tutorial/stable/ 
  - http://python-gtk-3-tutorial.readthedocs.org/en/latest/
  - http://pygtk.org/pygtk2tutorial/
- Project culture
- Cookbook
  - Show as many examples of the `Gtk-Perl` API and widgets as possible

## How to build Gtk3 ##
- Distro install instructions
- Building by hand using Homebrew/Perlbrew

## Learing Gtk3 ##
- See also `gtk-perl-notes.git/todos.md`
- How to find documentation
  - How to navigate the `Gtk-Perl` documentation tree/structure
    - How widgets inherit from each other, and what this means as far as
      widget methods/attributes
- How widgets are laid out (packing)
- Controls in Gtk3
- How to skin/theme controls (using CSS)

## Demos ##

vim: filetype=markdown shiftwidth=2 tabstop=2
