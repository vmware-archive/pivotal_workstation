rubymine_version  = "#{node[:rubymine][:major]}#{node[:rubymine][:minor]}"

run_unless_marker_file_exists("#{marker_version_string_for("Pivotal-Preferences-RubyMine")}-#{rubymine_version}") do
  download_dir = "#{Chef::Config[:file_cache_path]}/Pivotal-Preferences-RubyMine"
  rubymine_preferences_dir = "#{WS_HOME}/Library/Preferences/RubyMine#{rubymine_version}"

  execute "reset dir" do
    command "rm -rf #{download_dir} && mkdir -p #{download_dir}"
    user WS_USER
  end

  execute "get Pivotal-Preferences-RubyMine" do
    command "curl -Lsf http://github.com/pivotal/Pivotal-Preferences-RubyMine/tarball/#{node[:rubymine][:pivotal_preferences_hash]} | tar xvz -C#{download_dir} --strip 1"
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


["keymaps/pivotal.xml", "templates/jasmine.xml"].each do |file|
  link "#{rubymine_preferences_dir}/#{file}" do
    to "#{preferences_git_repo_location}/#{file}"
  end
end
