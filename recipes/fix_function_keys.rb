run_unless_marker_file_exists("fix_function_keys") do
  execute "Fix Function Keys" do
    applescript %{
      tell application "System Preferences"
      set current pane to pane "com.apple.preference.keyboard"
      end tell
      tell application "System Events"
      tell application process "System Preferences"
      click radio button "Keyboard" of tab group 1 of window "Keyboard"
      click checkbox "Use all F1, F2, etc. keys as standard function keys" of tab group 1 of window "Keyboard"
      end tell
      quit application "System Preferences"
      end tell
    }
    action :run
  end
end
