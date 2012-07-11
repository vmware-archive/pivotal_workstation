include_recipe "pivotal_workstation::enable_assistive_devices"

ruby_block "Remove Expose Keyboard Shortcuts" do
  block do
    system(
    "osascript -e '
      tell application \"System Preferences\"
      	set current pane to pane \"com.apple.preference.expose\"
      end tell

      tell application \"System Events\"
      	tell application process \"System Preferences\"
      	  click pop up button 1 of group 1 of window \"Mission Control\"
      	  delay 1
      		keystroke \"-\"
      		delay 1
      		keystroke return

  			  click pop up button 2 of group 1 of window \"Mission Control\"
      	  delay 1
      		keystroke \"-\"
      		delay 1
      		keystroke return

          click pop up button 3 of group 1 of window \"Mission Control\"
          delay 1
          keystroke \"-\"
          delay 1
          keystroke return

          click pop up button 4 of group 1 of window \"Mission Control\"
          delay 1
          keystroke \"-\"
          delay 1
          keystroke return
      	end tell
      	quit application \"System Preferences\"
      end tell'"
    )
  end
end
