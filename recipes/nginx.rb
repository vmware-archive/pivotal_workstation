include_recipe "pivotal_workstation::homebrew"
include_recipe "pivotal_workstation::ssl_certificate"

run_unless_marker_file_exists("nginx") do

  execute "uninstall nginx" do
    only_if "brew list | grep nginx"
    command "sudo brew remove nginx"
  end

  brew "nginx"

  plist_path = File.expand_path('org.nginx.nginx.plist', File.join('~', 'Library', 'LaunchAgents'))
  if File.exists?(plist_path)
    log "nginx plist found at #{plist_path}"
    execute "unload the plist (shuts down the daemon)" do
      command %'launchctl unload -w #{plist_path}'
      user "root"
    end
  else
    log "Did not find plist at #{plist_path} don't try to unload it"
  end

  launch_agents_path = File.expand_path('.', File.join('~', 'Library', 'LaunchAgents'))
  directory launch_agents_path do
    action :create
    recursive true
    owner WS_USER
  end

  template plist_path do
    source "org.nginx.nginx.plist.erb"
    owner "root"
  end

  execute "start the daemon" do
    command %'sudo launchctl load -w #{plist_path}'
  end
end

template "/usr/local/etc/nginx/nginx.conf" do
  source "nginx.conf.erb"
  owner WS_USER
end
