ruby_block "Show User Home In Sidebar" do
  block do
    system(
    "osascript -e '
      tell application \"Finder\"
      	activate
      	delay 1
      	set user_home to folder \"nctx\" of folder \"Users\" of Startup disk
      	select user_home
      	delay 1
      	tell application \"System Events\" to tell process \"Finder\" to keystroke \"t\" using command down
      	close window 1
      end tell'"
    )
  end
end
