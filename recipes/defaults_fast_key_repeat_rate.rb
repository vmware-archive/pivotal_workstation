# Requires logout to take effect

key_repeat_rate_lower_is_faster = 2
initital_repeat_delay_lower_is_shorter = 15

execute "set key repeat rate to fast" do
  command "defaults write ~/Library/Preferences/.GlobalPreferences KeyRepeat -int #{key_repeat_rate_lower_is_faster}"
  user WS_USER
  not_if "defaults read ~/Library/Preferences/.GlobalPreferences KeyRepeat | grep '^#{key_repeat_rate_lower_is_faster}$'"
end

execute "set key initial repeat delay to short" do
  command "defaults write ~/Library/Preferences/.GlobalPreferences InitialKeyRepeat -int #{initital_repeat_delay_lower_is_shorter}"
  user WS_USER
  not_if "defaults read ~/Library/Preferences/.GlobalPreferences InitialKeyRepeat | grep ^#{initital_repeat_delay_lower_is_shorter}$"
end

