unless File.exists?("/Applications/Screen Sharing.app")
  
  link "/Applications/Screen\ Sharing.app" do
    to "/System/Library/CoreServices/Screen\ Sharing.app"
  end

  ruby_block "assure the link /Applications/Screen Sharing.app was successfully created" do
    block do
      raise "Linking /Applications/Screen Sharing.app to /System/Library/CoreServices/Screen Sharing.app failed." unless File.exists?("/Applications/Screen Sharing.app")
    end
  end
end
