unless File.exists?("/Applications/Screen Sharing.app")

  execute "create symbolic link in /Applications" do
    command "ln -s /System/Library/CoreServices/Screen\\ Sharing.app /Applications/"
    user WS_USER
  end

  ruby_block "assure the link /Applications/Screen Sharing.app was successfully created" do
    block do
      raise "Linking /Applications/Screen Sharing.app to /System/Library/CoreServices/Screen Sharing.app failed." unless File.exists?("/Applications/Screen Sharing.app")
    end
  end
end
