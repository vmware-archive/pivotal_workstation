include_recipe "pivotal_workstation::user_owns_usr_local"

node.default["textmate"]["url"] = "https://github.com/downloads/textmate/textmate/TextMate_r9333.tbz"
node.default["textmate"]["shasum"] = "c0387b12fb6b827b05d90345a560dd790a5ceebe"

unless File.exists?("/Applications/TextMate.app")
  directory Chef::Config[:file_cache_path] do
    action :create
    recursive true
  end

  remote_file "#{Chef::Config[:file_cache_path]}/textmate.zip" do
    source node["textmate"]["url"]
    checksum node["textmate"]["shasum"]
    owner WS_USER
  end

  execute "extract text mate to /Applications" do
    command "tar -xvf #{Chef::Config[:file_cache_path]}/textmate.zip -C /Applications/"
    user WS_USER

    # This is required to unzip into Applications
    group "admin"
  end

  execute "link textmate" do
    command "ln -s /Applications/TextMate.app/Contents/Resources/mate /usr/local/bin/mate"
    not_if "test -e /usr/local/bin/mate"
  end

  ruby_block "test to see if TextMate was installed" do
    block do
      raise "TextMate install failed" unless File.exists?("/Applications/TextMate.app")
    end
  end
end

execute "link textmate" do
  command "ln -s /Applications/TextMate.app/Contents/Resources/mate /usr/local/bin/mate"
  not_if "test -e /usr/local/bin/mate"
end
