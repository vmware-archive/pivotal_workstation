unless File.exists?("/Applications/Screen Sharing.app")
  
  link "/Applications/Screen\ Sharing.app" do
    to "/System/Library/CoreServices/Screen\ Sharing.app"
  end

  ruby_block "test to see if Screen Sharing was installed" do
    block do
      raise "Screen Sharing install failed" unless File.exists?("/Applications/Screen Sharing.app")
    end
  end
end
