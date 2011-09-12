pivotal_rubymine_git_revision_hash  = version_string_for("Pivotal-Preferences-RubyMine")
rubymine_version_string  = version_string_for("RubyMine-VersionString")

run_unless_marker_file_exists("#{marker_version_string_for("Pivotal-Preferences-RubyMine")}-#{rubymine_version_string}") do
  download_dir = "/tmp/Pivotal-Preferences-RubyMine"
  rubymine_preferences_dir = "#{WS_HOME}/Library/Preferences/RubyMine#{rubymine_version_string}"

  execute "reset dir" do
    command "rm -rf #{download_dir} && mkdir -p #{download_dir}"
    user WS_USER
  end

  execute "get Pivotal-Preferences-RubyMine" do
    command "curl -Lsf http://github.com/pivotal/Pivotal-Preferences-RubyMine/tarball/#{pivotal_rubymine_git_revision_hash} | tar xvz -C#{download_dir} --strip 1"
    user WS_USER
  end

  [
    [rubymine_preferences_dir, "keymaps"],
    [rubymine_preferences_dir, "templates"],
  ].each do |dirs|
    recursive_directories dirs do
      owner WS_USER
      mode "0755"
      recursive true
    end
  end

  ["cp #{download_dir}/keymaps/* #{rubymine_preferences_dir}/keymaps/",
   "cp #{download_dir}/templates/* #{rubymine_preferences_dir}/templates/"].each do |copy_command|
     execute "copy: #{copy_command}" do
       command copy_command
       user WS_USER
     end
  end
end
