/* $Id: JavaApplet.java,v 1.4 2006-03-24 08:25:34 brian Exp $
 * Copyright (c) 200x Brian Manning
 * @author brian at antlinux dot com
 * @version $Revision: 1.4 $
 * 
 * a sample password dialog
 *
 *    This program is free software; you can redistribute it and/or modify
 *    it under the terms of the GNU General Public License as published by
 *    the Free Software Foundation; version 2 dated June, 1991.
 * 
 *    This program is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *    GNU General Public License for more details.
 * 
 *    You should have received a copy of the GNU General Public License
 *    along with this program;  if not, write to the Free Software
 *    Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111, USA.
 *
*/

// external objects that will be used
//import java.applet.*; 
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class JavaApplet extends JApplet implements ActionListener
{
	
	// classwide objects and variables
	// which assignment we're doing
	char assignment = 'a';

	// two panels for other controls
	JPanel radioButtonPanel = new JPanel();
	JPanel passwordPanel = new JPanel();
	JPanel buttonPanel = new JPanel();
	JPanel statusPanel = new JPanel();

	// controls for the radioButtonPanel
	JLabel l_SelectAssignment = new JLabel(
						"Please select an assignment to run");
	ButtonGroup radioGroup = new ButtonGroup();
	JRadioButton r_2a = new JRadioButton("2a");
	JRadioButton r_2b = new JRadioButton("2b");
	JRadioButton r_2c = new JRadioButton("2c");
	JLabel l_SelectWarn = new JLabel(
						"Selecting a new assignment will clear all controls");
	
	// a separator
	JSeparator breakit = new JSeparator();
	
	// controls for the passwordPanel
	JLabel l_Greeting = new JLabel("Please Enter A Password:");
	JButton b_Enter = new JButton("Enter");
	JButton b_Clear = new JButton("Clear");
	// empty text field, 10 characters in width
	JTextField t_Password = new JPasswordField(10);
	JLabel l_Status = new JLabel("");

	// use flow layout
	FlowLayout flow = new FlowLayout();

	// ******************* init method *******************  
	public void init () 
	{ 
		// create a canvas for adding widgets
		Container f_pass = getContentPane();
		
		// set flow layout for f_pass
		f_pass.setLayout(flow);
		
		// add the radioButtonPanel panel and components
		radioButtonPanel.add(r_2a);
		radioButtonPanel.add(r_2b);
		radioButtonPanel.add(r_2c);
	
		
		// add the radio controls to a group
		radioGroup.add(r_2a);
		radioGroup.add(r_2b);
		radioGroup.add(r_2c);
		r_2a.setSelected(true);

		// register listeners
		r_2a.addActionListener(this);
		r_2b.addActionListener(this);
		r_2c.addActionListener(this);

		// add the whole panel to the container
		f_pass.add(l_SelectAssignment);
		f_pass.add(radioButtonPanel);
		f_pass.add(l_SelectWarn);		
		f_pass.add(breakit);

		// now add the passwordPanel controls to the panel
		passwordPanel.add(l_Greeting);			
		passwordPanel.add(t_Password);

		// register listeners
		b_Enter.addActionListener(this);
		b_Clear.addActionListener(this);

		// add the panel to the container
		f_pass.add(passwordPanel);
		buttonPanel.add(b_Enter);
		buttonPanel.add(b_Clear);
		f_pass.add(buttonPanel);
		f_pass.add(breakit);
		statusPanel.add(l_Status);
		f_pass.add(statusPanel);

		// then set focus to the text field
		t_Password.requestFocus();

	} // public void init
	
	// ******************* actionPerformed method *******************  
	public void actionPerformed (ActionEvent anEvent)
	{ 
		// @param anEvent the event that triggered this method
		// @return doesn't return anything I think 	
		
		// who called us?
		Object source = anEvent.getSource();
		if ( source == b_Enter ) {
			// check the password
			System.out.println("Would have checked the password");
			comparestring = t_Password.getText();
			switch (assignment) {
				case 'a':
					if ( comparestring.compareTo("Rosebud") == 0 ) {
						l_Status.setForeground(Color.GREEN);
						l_Status.setText("Access Granted");
					} else {
						l_Status.setForeground(Color.RED);
						l_Status.setText("Access Denied");
					} // if (comparestring.compareTo("Rosebud")
					break; // case 'a'
				case 'b':
					if ( comparestring.compareToIgnoreCase("rosebud") == 0 ) {
						l_Status.setForeground(Color.GREEN);
						l_Status.setText("Access Granted");
					} else {
						l_Status.setForeground(Color.RED);
						l_Status.setText("Access Denied");
					} // if (comparestring.compareTo("Rosebud")
					break; // case 'b'
				case 'c':
					String checkpw[] = { "Rosebud", "redrum", "Jason", 
										"Surrender", "Dorothy"};
					int x;
					for (x = 0; x < checkpw.length; ++x) {
						System.out.println("c: checking " + checkpw[x] + 
										" against " + comparestring);
						if ( comparestring.compareTo(checkpw[x]) == 0 ) {
							// found a match, set the status box then boogie
							l_Status.setForeground(Color.GREEN);
							l_Status.setText("Access Granted");
							System.out.println("c: matched " + checkpw[x] +
												"; breaking...");
							break;
						} else {
							l_Status.setForeground(Color.RED);
							l_Status.setText("Access Denied");
						} // if ( comparestring.compareTo(checkpw[x]) == 0 )
					} // for (int x = 0; x == checkpw.length(); ++x)
			} // switch (assignment)

		} else if ( source == b_Clear ) {
			// change code behaivor
			System.out.println("clearing t_Password");
			t_Password.setText("");
			l_Status.setText("");
			t_Password.requestFocus();
		} else if ( source == r_2a ) {
			// change code behaivor
			System.out.println("switching to 2a behaivor");
			// reset the text fields
			t_Password.setText("");
			l_Status.setText("");
			t_Password.requestFocus();
			// reset the assignment variable
			assignment = 'a';
		} else if ( source == r_2b ) {
			// change code behaivor
			System.out.println("switching to 2b behaivor");
			// reset the text fields
			t_Password.setText("");
			l_Status.setText("");
			t_Password.requestFocus();
			// reset the assignment variable
			assignment = 'b';
		} else if ( source == r_2c ) {
			// change code behaivor
			System.out.println("switching to 2c behaivor");
			// reset the text fields
			t_Password.setText("");
			l_Status.setText("");
			t_Password.requestFocus();
			// reset the assignment variable
			assignment = 'c';
		} // if ( source == b_Enter )	

	} // public void actionPerformed

} // public class JavaApplet

// vi: set ft=java sw=4 ts=4 cin:
