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
    command %'initdb -U #{WS_USER} --encoding=utf8 --locale=en_US /usr/local/var/postgres'
    user WS_USER
  end

  launch_agents_path = File.expand_path('.', File.join('~','Library', 'LaunchAgents'))
  directory launch_agents_path do
    action :create
    recursive true
    owner WS_USER
  end


  execute "copy over the plist" do
    command %'cp /usr/local/Cellar/postgresql/9.*/org.postgresql.postgres.plist ~/Library/LaunchAgents/'
    user WS_USER
  end

  execute "start the daemon" do
    command %'launchctl load -w ~/Library/LaunchAgents/org.postgresql.postgres.plist'
    user WS_USER
  end

  ruby_block "wait four seconds for the database to start" do
    block do
      sleep 4
    end
  end

  execute "create the database" do
    command "createdb"
    user WS_USER
  end
end

# An Apple Upgrade (e.g. 10.7.2) may re-introduce the executables we
# so painstakingly moved aside.  So we need to check if the files
# exist and move them out of the way AGAIN.
ruby_block "rename Apple's stock postgres commands to avoid confusion" do
  block do
    new_dir="/usr/bin/postgres-orig"
    if ! ( File.exists?(new_dir) && File.directory?(new_dir) )
      Dir.mkdir(new_dir)
    end
    ["clusterdb", "createdb", "createlang", "createuser", "dropdb", "droplang", "dropuser", "ecpg", "initdb", "oid2name", "pg_archivecleanup", "pg_config", "pg_controldata", "pg_ctl", "pg_dump", "pg_dumpall", "pg_resetxlog", "pg_restore", "pg_standby", "pg_upgrade", "pgbench", "postgres", "postmaster", "psql", "reindexdb", "vacuumdb", "vacuumlo"].each do |pg_cmd|
      if File.exists?("/usr/bin/#{pg_cmd}")
        File.rename("/usr/bin/#{pg_cmd}","/usr/bin/postgres-orig/#{pg_cmd}")
      end
    end
  end
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
    `sudo -u #{WS_USER} psql < /dev/null`
    if $?.to_i != 0
      raise "I couldn't invoke postgres!"
    end
  end
end
