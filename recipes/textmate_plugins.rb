run_unless_marker_file_exists("textmate_plugins_0") do
  execute "download ProjectPlus to temp dir" do
    command "curl -o /tmp/projectplus.dmg http://ciaranwal.sh/projectplus-files/ProjectPlus-1.3.dmg"
    user WS_USER
  end

  execute "mount dmg" do
    command "hdid /tmp/projectplus.dmg"
    user WS_USER
  end

  execute "clear out the existing plugin if it's there" do
    command "rm -rf '#{WS_HOME}/Library/Application Support/TextMate/PlugIns/ProjectPlus.tmplugin'"
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
