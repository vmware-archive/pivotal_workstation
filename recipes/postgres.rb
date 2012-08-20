include_recipe "pivotal_workstation::homebrew"
include_recipe "pivotal_workstation::increase_shared_memory"
include_recipe "pivotal_workstation::user_owns_usr_local"

run_unless_marker_file_exists("postgres") do

  plist_path = File.expand_path('org.postgresql.postgres.plist', File.join('~', 'Library', 'LaunchAgents'))
  if File.exists?(plist_path)
    log "postgres plist found at #{plist_path}"
    execute "unload the plist (shuts down the daemon)" do
      command %'launchctl unload -w #{plist_path}'
      user WS_USER
    end
  else
    log "Did not find plist at #{plist_path} don't try to unload it"
  end

#    blow away default image's data directory
  directory "/usr/local/var/postgres" do
    action :delete
    recursive true
  end

  if node["kernel"]["release"] == "12.0.0"
    brew_install("postgresql",:brew_args =>  "--without-ossp-uuid")
  else
    brew_install "postgresql"
  end

  execute "create the database" do
    command %'initdb -U postgres --encoding=utf8 --locale=en_US /usr/local/var/postgres'
    user WS_USER
  end

  launch_agents_path = File.expand_path('.', File.join('~','Library', 'LaunchAgents'))
  directory launch_agents_path do
    action :create
    recursive true
    owner WS_USER
  end


  execute "copy over the plist" do
    command %'cp /usr/local/Cellar/postgresql/9.*/homebrew.mxcl.postgresql.plist ~/Library/LaunchAgents/'
    user WS_USER
  end

  execute "start the daemon" do
    command %'launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist'
    user WS_USER
  end

  ruby_block "wait four seconds for the database to start" do
    block do
      sleep 4
    end
  end

  execute "create the database" do
    command "createdb -U postgres"
    user WS_USER
  end
  # "initdb /tmp/junk.$$" will fail unless you modify sysctl variables
  # Michael Sofaer says that these are probably the right settings:
  #   kern.sysv.shmall=65535
  #   kern.sysv.shmmax=16777216
  #not_if File.exists?("/etc/sysctl.conf") do
  # check if the sysctl variables are big enough
  #   if not, set them
  # check if /etc/sysctl.conf exists
  #   if so, check if kern.sysv.{shmall,shmmax} are set
  #     if so, check that they're set large enough
  #       if so, go on
  #   otherwise
  #     modify /etc/sysctl.conf to make them big enough
  # otherwise
  #   create /etc/sysctl.conf & make these settings big enough
  #

end

ruby_block "test to see if postgres is running" do
block do
    require 'socket'
    postgres_port = 5432
    begin
      s = TCPSocket.open('localhost',postgres_port)
    rescue => e
      raise "postgres is not running: " << e
    end
    s.close
    `sudo -u #{WS_USER} psql -U postgres < /dev/null`
    if $?.to_i != 0
      raise "I couldn't invoke postgres!"
    end
  end
end


