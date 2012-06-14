run_unless_marker_file_exists("textmate_plugins_0") do
  ["curl -o #{Chef::Config[:file_cache_path]}/projectplus.dmg http://ciaranwal.sh/projectplus-files/ProjectPlus-1.3.dmg",
   "hdiutil mount #{Chef::Config[:file_cache_path]}/projectplus.dmg",
   "rm -rf '#{WS_HOME}/Library/Application Support/TextMate/PlugIns/ProjectPlus.tmplugin'",
  ].each do |tmate_cmd|
    execute tmate_cmd do
      user WS_USER
    end
  end

  execute "make textmate plugins directory" do
    command "mkdir -p '#{WS_HOME}/Library/Application Support/TextMate/PlugIns'"
    user WS_USER
    not_if { File.exists?("#{WS_HOME}/Library/Application Support/TextMate/PlugIns") }
  end

  execute "copy to TextMate" do
    command "cp -Rf /Volumes/ProjectPlus/ProjectPlus.tmplugin '#{WS_HOME}/Library/Application Support/TextMate/PlugIns'"
    user WS_USER
  end

  execute "unmount dmg" do
    command "hdiutil detach  /Volumes/ProjectPlus"
    user WS_USER
  end
end
