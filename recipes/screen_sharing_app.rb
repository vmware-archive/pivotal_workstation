unless File.exists?("/Applications/Screen Sharing.app")

  ruby_block "Copy Screen Sharing to /Applications" do
    block do
      FileUtils.cp_r("/System/Library/CoreServices/Screen\ Sharing.app","/Applications/",:preserve => true)
    end
  end

  ruby_block "assure that /Applications/Screen Sharing.app was successfully created" do
    block do
      raise "Copying /Applications/Screen Sharing.app to /System/Library/CoreServices/Screen Sharing.app failed." unless File.exists?("/Applications/Screen Sharing.app")
    end
  end
end
