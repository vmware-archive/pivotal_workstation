#Installs PostgreSQL on a Mac using http://postgresapp.com/
unless File.exists?("/Applications/Postgres.app")
  remote_file "#{Chef::Config[:file_cache_path]}/PostgresApp.zip" do
    source "http://postgres-app.s3.amazonaws.com/PostgresApp-9-2-2-0.zip"
    owner WS_USER
    checksum "933f05df440e1a66eb0d7f609197d0802c0bb28c9db10c8974b3b3b2f9a087be"
  end

  execute "unzip PostgresApp.zip" do
    command "unzip #{Chef::Config[:file_cache_path]}/PostgresApp.zip -d #{Chef::Config[:file_cache_path]}/"
    user WS_USER
  end

  execute "copy Postgres.app to /Applications" do
    command "mv #{Chef::Config[:file_cache_path]}/Postgres.app #{Regexp.escape("/Applications/Postgres.app")}"
    user WS_USER
    group "admin"
  end

  ruby_block "test to see if Postgres.app was installed" do
    block do
      raise "Postgres.app was not installed" unless File.exists?("/Applications/Postgres.app")
    end
  end
end
