pivotal_rubymine_git_revision_hash  = version_string_for("Pivotal-Preferences-RubyMine")

run_unless_marker_file_exists(marker_version_string_for("Pivotal-Preferences-RubyMine")) do
  download_dir = "/tmp/Pivotal-Preferences-RubyMine"
  
  execute "reset dir" do
    command "rm -rf #{download_dir} && mkdir -p #{download_dir}"
    user WS_USER
  end
  
  execute "get Pivotal-Preferences-RubyMine" do
    command "curl -Lsf http://github.com/pivotal/Pivotal-Preferences-RubyMine/tarball/#{pivotal_rubymine_git_revision_hash} | tar xvz -C#{download_dir} --strip 1"
    user WS_USER
  end
  
  ["#{WS_HOME}/Library/Preferences/RubyMine20/keymaps", "#{WS_HOME}/Library/Preferences/RubyMine20/templates"].each do |dir|
    directory dir do
      owner WS_USER
      mode "0755"
      recursive true
    end
  end
  
  execute "clean up dir owndership slop" do
    command "chown -R #{WS_USER} #{WS_HOME}/Library/Preferences/RubyMine20"
  end     
  
  ["cp #{download_dir}/keymaps/* #{WS_HOME}/Library/Preferences/RubyMine20/keymaps/",
   "cp #{download_dir}/templates/* #{WS_HOME}/Library/Preferences/RubyMine20/templates/"].each do |copy_command|
     execute "copy: #{copy_command}" do
       command copy_command
       user WS_USER
     end     
  end
end

