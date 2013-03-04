rubymine_preferences_dir = "#{WS_HOME}/Library/Preferences/RubyMine50"
preferences_git_repo_location =  "#{Chef::Config[:file_cache_path]}/Pivotal-Preferences-RubyMine"

git preferences_git_repo_location do
  repository "https://github.com/pivotal/Pivotal-Preferences-RubyMine.git"
  revision node['rubymine']['pivotal_preferences_hash']
  action :sync
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
