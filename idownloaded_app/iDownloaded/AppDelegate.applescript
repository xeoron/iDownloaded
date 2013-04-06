(*
 AppDelegate.applescript
 iDownloaded
 
 Created by Jason Campisi on 3/6/13.
 Copyright (c) 2013 ACK Geek. All rights reserved.
 *)
 
script AppDelegate
	property parent : class "NSObject"
	property textField : missing value
    property labelCount : missing value
    property labelText : "File History"
    property cmdGetList : "sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'select LSQuarantineDataURLString from LSQuarantineEvent' | awk 'NF'"
    property cmdGetListSorted : "sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'select LSQuarantineDataURLString from LSQuarantineEvent' | awk 'NF' | sort -g"
    property cmdGetListCount : "sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'select LSQuarantineDataURLString from LSQuarantineEvent' | grep -v '^$' | wc -l | cut -c 7-100000000"
    property cmdDeleteList : "sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"
    
    
    on saveList_(sender)
        (*
         --save a file
         set new_file to POSIX file "/Users/hanaan/Documents/notes.txt"
         tell application "TextEdit"
         save document 1 in new_file end tell
         *)
        display alert "saving not setup yet" -- with title "Alert: Saving!" -- with title failes in CoCoa Applescript
        return
    end saveList_
    
    on labelCountUpdate_()
        -- count & display the number of files in the download list
        try
            set myCount to (do shell script cmdGetListCount) as number
            if myCount is 0 then
                labelCountReset_()
                else
                labelCount's setStringValue_(labelText & " (" & myCount & ")")
            end if
            on error StrError
            display alert "Error: not able to count the list!\n"
        end try
    end labelCountUpdate_
    
    on labelCountReset_()
        -- remove the list-count from being displayed
        try
            labelCount's setStringValue_(labelText)
            on error StrError
            display alert "Error: not able to count the list!\n"
        end try
    end labelCountReset_
    
    on listButtonClicked_(sender)
        (*) display downloaded filename\location list
         https://discussions.apple.com/thread/4195893?start=0&tstart=0
         *)
        try
            (*
            textField's setString_(do shell script cmdGetList)
            set x to textField's textStorage(sender)
            log x -- this will log the text from the text view
            *)
            textField's setString_(do shell script cmdGetList)
            labelCountUpdate_()
            on error StrError
            display alert "Error: Unable to find useraccounts ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV file\n" & StrError
        end try
    end listButtonClicked_
    
    
    on listSortedButtonClicked_(sender)
        (*) display downloaded filename\location list as a numerically sorted list
         *)
        try
            (*
             textField's setString_(do shell script cmdGetList)
             set x to textField's textStorage(sender)
             log x -- this will log the text from the text view
             *)
            textField's setString_(do shell script cmdGetListSorted)
            labelCountUpdate_()
            on error StrError
            display alert "Error: Unable to find useraccounts ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV file\n" & StrError
        end try
    end listSortedButtonClicked_
   
    on clearDisplay_(sender)
        (* remove all data feedback being displayed
         -count list
         -file listed in the text box
         *)

        try
            textField's setString_("")
            set x to textField's textStorage(sender)
            log x -- this will log the text from the text view
            labelCountReset_()
            on error StrError
            display alert "Error:\n" & StrError
        end try
    end clearDisplay_
    
    on rmButtonClicked_(sender)
        -- wipe the downloaded filename list and clear the textbox listing of filenames
        try
            textField's setString_(do shell script cmdDeleteList)
            set x to textField's textStorage(sender)
            log x -- this will log the text from the text view
            labelCountUpdate_()
            on error StrError
            display alert "Error: Unable to find useraccounts ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* file\n" & StrError
        end try
    end rmButtonClicked_
    
	on applicationWillFinishLaunching_(aNotification)
        -- Insert code here to initialize your application before any files are opened
        listButtonClicked_(aNotification)
        --filenameGrabExample_("foo")
	end applicationWillFinishLaunching_
	
	on applicationShouldTerminate_(sender)
		-- Insert code here to do any housekeeping before your application quits
		return current application's NSTerminateNow
	end applicationShouldTerminate_
	
end script