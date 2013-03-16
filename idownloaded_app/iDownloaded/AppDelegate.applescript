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
    property cmdGetList : "sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'select LSQuarantineDataURLString from LSQuarantineEvent'"
    property cmdGetListCount : "sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'select LSQuarantineDataURLString from LSQuarantineEvent' | wc -l | cut -c 7-100000000"
    property cmdDeleteList : "sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"
    
    on printList_(sender)
        (*
         --print
         tell application "TextEdit"
         activate
         print document 1 with properties ¬
         {target printer:"Office Printer", pages across:2, pages down:2} ¬ with print dialog
         end tell
         *)
        return
    end printList_
    
    on saveList_(sender)
        (*
         --save a file
         set new_file to POSIX file "/Users/hanaan/Documents/notes.txt"
         tell application "TextEdit"
         save document 1 in new_file end tell
         *)
        return
    end saveList_
    
    on labelCountUpdate_()
        -- count & display the number of files in the download list
        set isZero to "9"
        try
            set myCount to (do shell script cmdGetListCount) as number
            if myCount is 0 then
                labelCountReset_()
            else
                labelCount's setStringValue_(labelText & " (" & myCount & ")")
            end if
        on error StrError
            display alert "Error:\n" & StrError
        end try
    end labelCountUpdate_
    
    on labelCountReset_()
        -- remove the list-count from being displayed
        try
            labelCount's setStringValue_(labelText)
            on error StrError
            display alert "Error:\n" & StrError
        end try
    end labelCountReset_
    
    on listButtonClicked_(sender)
        -- display downloaded filename\location list
        try
            textField's setString_(do shell script cmdGetList)
            set x to textField's textStorage(sender)
            log x -- this will log the text from the text view
            labelCountUpdate_()
        on error StrError
            display alert "Error:\n" & StrError
        end try
    end listButtonClicked_

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
            display alert "Error:\n" & StrError
        end try
    end rmButtonClicked_
    
	on applicationWillFinishLaunching_(aNotification)
        -- Insert code here to initialize your application before any files are opened
        listButtonClicked_(aNotification)
	end applicationWillFinishLaunching_
	
	on applicationShouldTerminate_(sender)
		-- Insert code here to do any housekeeping before your application quits 
		return current application's NSTerminateNow
	end applicationShouldTerminate_
	
end script