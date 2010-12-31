#http://solutions.treypiepmeier.com/2010/02/28/installing-mysql-on-snow-leopard-using-homebrew/

DEFAULT_PIVOTAL_MYSQL_PASSWORD = "password"

include_recipe "pivotal_workstation::homebrew"

run_unless_marker_file_exists("mysql_install") do
  brew_install "mysql"

  directory "/Users/#{WS_USER}/Library/LaunchAgents" do
    owner WS_USER
    action :create
  end

  execute "copy mysql plist to ~/Library/LaunchAgents" do
    command "cp /usr/local/Cellar/mysql/5.1.54/com.mysql.mysqld.plist ~/Library/LaunchAgents/"
    user WS_USER
  end

  execute "mysql_install_db" do
    command "mysql_install_db"
    user WS_USER
  end

  execute "load the mysql plist into the mac daemon startup thing" do
    command "launchctl load -w ~/Library/LaunchAgents/com.mysql.mysqld.plist; sleep 5"
    user WS_USER
  end

  execute "set the root password to the default" do
    command "mysqladmin -uroot password #{DEFAULT_PIVOTAL_MYSQL_PASSWORD}"
    not_if "mysql -uroot -p#{DEFAULT_PIVOTAL_MYSQL_PASSWORD} -e 'show databases'"
  end
end
