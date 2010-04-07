<?php
/*! 
	$Id: phpstub.php,v 1.4 2006-03-24 08:25:34 brian Exp $
	@header index.php Copyright (c) 2001 by Brian Manning
	@abstract Main PHP page for demoing php-stream ideas/code
	@discussion this is a script that does something
	@version $Revision: 1.4 $
	   This program is free software; you can redistribute it and/or modify
	   it under the terms of the GNU General Public License as published
	   by the Free Software Foundation; version 2 dated June, 1991.

	   This program is distributed in the hope that it will be useful,
	   but WITHOUT ANY WARRANTY; without even the implied warranty of
	   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	   GNU General Public License for more details.
	
	   You should have received a copy of the GNU General Public License
	   along with this program;  if not, write to the Free Software
	   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111, USA.

*/

	include("somefile.inc.php"); // a file with functions

// session variables need to be declared before the HTML starts
session_start(); 
    session_register(somevariable);
	
/*!
    @var somevariable some variable that does something
*/

// ===== begin HTML content =====
?>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<meta name="Author" content="Brian">
	<meta name="GENERATOR" content="vim">
	<title>Insert Page Title Here</title>
	<?php include("styles.css"); // simple stylesheet ?>
</head>
<body>

<!-- put page content here -->


<?php
// DEBUG section
    if (DEBUG) {
		// some debugging info can go here, but not at the top of the page
		// where it would look like ass
    } # if (DEBUG)
?>

</body>
<?php // vi: set ft=php sw=4 ts=4 cin: ?>
</html>
