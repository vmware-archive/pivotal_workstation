unless File.exists?("/Applications/Arq.app")

  remote_file "#{Chef::Config[:file_cache_path]}/arq.zip" do
    source "http://www.haystacksoftware.com/arq/Arq.zip"
    owner WS_USER
    #checksum "56aef138f06fc92d641c424742bc40887cd19e6029f20409ec06ad5514b8cff1"
  end

  execute "unzip arq" do
    command "unzip #{Chef::Config[:file_cache_path]}/arq.zip -d #{Chef::Config[:file_cache_path]}/"
    user WS_USER
  end

  execute "copy Arq to /Applications" do
    command "mv #{Chef::Config[:file_cache_path]}/Arq.app #{Regexp.escape("/Applications/Arq.app")}"
    user WS_USER
    group "admin"
  end

  ruby_block "test to see if Arq.app was installed" do
    block do
      raise "Arq.app was not installed" unless File.exists?("/Applications/Arq.app")
    end
  end

end



