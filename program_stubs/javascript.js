/*  $Id: javascript.js,v 1.2 2006-03-24 08:25:34 brian Exp $
    @header javascript.js Copyright (c) 2005 by Brian Manning
    <brian {at} antlinux.com>
    @abstract JavaScript stub page
    @discussion this is a script that does something
    @version $Revision: 1.2 $
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

/* TODO 
- write a function that enables/disables boxes around elements in a stylesheet.
  Give a list of elements to be enabled/disabled to the script, or have them
  built into the script itself.
*/

/* change the CSS border color for one or more elements */
function cssBorder(changeClass) {
    // some local variables
    // list of classes in the document to change 
    var allClasses = new Array('leftside', 'rightside', 'topnav', 'bottomnav');
    
    switch ( changeClass ) {
        case 'leftside':
            document.div['leftside'].style.borderColor = "black";
        case 'rightside':
        case 'topnav':
        case 'bottomnav':
        case 'all':
                        
        // walk the list of text boxes, create a list of empties
        for (whichStyle in boxlist) {
            if (document.form_cc.elements[whichbox].value == "") {
                blankfields.push(whichbox);
            } // if (document.form_verifytest.cc_expire_year.value != "")
        } // for (whichbox in boxlist)
    } // switch ( changeClass )
} // function cssBorder(changeClass)

function CheckAll(boxstate) {
    // WARNING: this is DOM specific and may not work with IE
    // combined CheckAll and UncheckAll into one function
    var inputelements = new Array(); // something to ieterate over 'document'
    // now traverse all 'input' elements in the document tree
    inputelements = document.getElementsByTagName("input");
    for (var x in inputelements ) {
        if ( inputelements[x].type == "checkbox" && boxstate == true ) {
            inputelements[x].checked = true;
        } else if ( inputelements[x].type == "checkbox" && 
                    boxstate == false ) { 
            inputelements[x].checked = false;
        } // if ( inputelements[x].type == "checkbox" && boxstate.value == true
    } // for (var oneinput in inputelements )
} // function checkAll()

function UncheckAll() {
    // just call CheckAll with a value of false
    CheckAll(false);
} // function checkAll()

// vi: set ft=javascript sw=4 ts=4 cin:
