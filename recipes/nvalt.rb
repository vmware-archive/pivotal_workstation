unless File.exists?("/Applications/nvalt.app")
  remote_file "#{Chef::Config[:file_cache_path]}/nvalt.zip" do
    source "http://abyss.designheresy.com/nvaltb/files/nvalt2.2b101.zip"
    owner WS_USER
    checksum "0692a426fb3f58697878e4d360472423cb6f27402fa300e775f252cc68d94e29"
  end

  execute "unzip nvalt" do
    command "unzip #{Chef::Config[:file_cache_path]}/nvalt.zip -x '__MACOSX*' -d #{Chef::Config[:file_cache_path]}/"
    user WS_USER
  end

  execute "copy nvalt to /Applications" do
    command "mv #{Chef::Config[:file_cache_path]}/nvALT.app #{Regexp.escape("/Applications/nvALT.app")}"
    user WS_USER
    group "admin"
  end

  ruby_block "test to see if nvALT.app was installed" do
    block do
      raise "nvALT.app was not installed" unless File.exists?("/Applications/nvALT.app")
    end
  end
end



