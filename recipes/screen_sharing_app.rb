unless File.exists?("/Applications/Screen Sharing.app")

  execute "create symbolic link in /Applications" do
    command "ln -s /System/Library/CoreServices/Screen\\ Sharing.app /Applications/"
    user WS_USER
  end

  ruby_block "test to see if Screen Sharing was installed" do
    block do
      raise "Screen Sharing install failed" unless File.exists?("/Applications/Screen Sharing.app")
    end
  end
end
