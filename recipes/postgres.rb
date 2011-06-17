include_recipe "pivotal_workstation::homebrew"

run_unless_marker_file_exists("postgres_" + marker_version_string_for("postgres")) do

  execute "unload the plist (shuts down the daemon)" do
    command %'launchctl unload -w ~/Library/LaunchAgents/org.postgresql.postgres.plist'
    user WS_USER
  end

#    blow away default image's data directory
  directory "/usr/local/var/postgres" do
    action :delete
    recursive true
  end

  brew_remove "postgresql"
  brew_update
  brew_install "postgresql"

  execute "create the database" do
    command %'initdb -U #{node["postgres_settings"]["name"]} --encoding=utf8 --locale=en_US /usr/local/var/postgres'
    user WS_USER
  end

  directory "~/Library/LaunchAgents" do
    action :create
    recursive true
    owner WS_USER
  end

  execute "copy over the plist" do
    command %'cp /usr/local/Cellar/postgresql/9.0.4/org.postgresql.postgres.plist ~/Library/LaunchAgents/'
    user WS_USER
  end

  execute "start the daemon" do
    command %'launchctl load -w ~/Library/LaunchAgents/org.postgresql.postgres.plist'
    user WS_USER
  end

end

