include_recipe "pivotal_workstation::postgres"

execute "install the citext module" do
  command "/usr/local/bin/psql -U postgres -c 'CREATE EXTENSION citext'"
  user WS_USER
  not_if "/usr/local/bin/psql -U postgres -c '\\dT' | grep -i citext"
end
