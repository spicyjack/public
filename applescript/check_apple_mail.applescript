tell application "Mail"
	check for new mail
	-- give Mail time to process any downloaded messages with rules and the like
	delay 5
	set inboxUnread to unread count of mailbox "Inbox" of account "Mail Account"
	if inboxUnread is greater than 0 then
		-- this should raise/unhide the window; 
		-- when you're done, minimize/hide again
		activate
	end if
end tell
