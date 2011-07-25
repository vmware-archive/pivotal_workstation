include_recipe "pivotal_workstation::homebrew"

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

  brew_remove "postgresql"
  brew_install "postgresql"

  execute "create the database" do
    command %'initdb -U #{node["postgres_settings"]["name"]} --encoding=utf8 --locale=en_US /usr/local/var/postgres'
    user WS_USER
  end

  launch_agents_path = File.expand_path('.', File.join('~','Library', 'LaunchAgents'))
  directory launch_agents_path do
    action :create
    recursive true
    owner WS_USER
  end

  ruby_block "rename Apple's stock postgres commands to avoid confusion" do 
    block do
      ["clusterdb", "createdb", "createlang", "createuser", "dropdb", "droplang", "dropuser", "ecpg", "initdb", "oid2name", "pg_archivecleanup", "pg_config", "pg_controldata", "pg_ctl", "pg_dump", "pg_dumpall", "pg_resetxlog", "pg_restore", "pg_standby", "pg_upgrade", "pgbench", "postgres", "postmaster", "psql", "reindexdb", "vacuumdb", "vacuumlo"].each do |pg_cmd| 
	if File.exists?("/usr/bin/#{pg_cmd}")
	  `mv /usr/bin/#{pg_cmd} /usr/bin/#{pg_cmd}.orig`
	end
      end
    end
  end

  execute "copy over the plist" do
    command %'cp /usr/local/Cellar/postgresql/9.*/org.postgresql.postgres.plist ~/Library/LaunchAgents/'
    user WS_USER
  end

  execute "start the daemon" do
    command %'launchctl load -w ~/Library/LaunchAgents/org.postgresql.postgres.plist'
    user WS_USER
  end

end

ruby_block "test to see if postgres is running" do
  block do
    sleep 2
    require 'socket'
    postgres_port = 5432
    begin
      s = TCPSocket.open('localhost',postgres_port)
    rescue => e
      raise "postgres is not running: " << e
    end
    s.close
  end
end
