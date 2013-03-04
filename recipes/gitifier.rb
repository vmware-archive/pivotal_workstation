unless File.exists?("/Applications/Gitifier.app")
  remote_file "#{Chef::Config[:file_cache_path]}/Gitifier.zip" do
    source "http://github.com/downloads/jsuder/Gitifier/Gitifier-1.3.zip"
    checksum "b199743bdae2305db99d9d3a247f9c8846031d1fbb19201ea81262b25e629d2f"
    owner WS_USER
  end
  execute "unzip Gitifier" do
    command "unzip #{Chef::Config[:file_cache_path]}/Gitifier.zip -d #{Chef::Config[:file_cache_path]}/"
    user WS_USER
  end

  execute "copy Gitifier to /Applications" do
    command "mv #{Chef::Config[:file_cache_path]}/Gitifier.app #{Regexp.escape("/Applications/Gitifier.app")}"
    user WS_USER
    group "admin"
  end

  ruby_block "test to see if Gitifier.app was installed" do
    block do
      raise "Gitifier.app was not installed" unless File.exists?("/Applications/Gitifier.app")
    end
  end

end
