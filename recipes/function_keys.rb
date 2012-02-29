node.default['function_keys']['use_function_keys_as_function_keys'] = true

as_fn_keys = node.default['function_keys']['use_function_keys_as_function_keys'] ? "0" : "1"

execute "Fix Function Keys" do
  applescript %{
    tell application "System Preferences"
      set current pane to pane "com.apple.preference.keyboard"
    end tell
    tell application "System Events"
      tell application process "System Preferences"
        click radio button "Keyboard" of tab group 1 of window "Keyboard"
        if value of checkbox "Use all F1, F2, etc. keys as standard function keys" of tab group 1 of window "Keyboard" is #{as_fn_keys} then
          click checkbox "Use all F1, F2, etc. keys as standard function keys" of tab group 1 of window "Keyboard"
        end if
      end tell
      quit application "System Preferences"
    end tell
  }
end
