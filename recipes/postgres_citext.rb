include_recipe "pivotal_workstation::postgres"

postgres_databases = `psql -U postgres -c '\\list' | cut -d' ' -f 2 | grep -v '^template' | tail +4`.split("\n")

# the last 4 lines are noise from psql
postgres_databases[0...-4].each do |database|
  execute "install the citext module into #{database}" do
    command "/usr/local/bin/psql -U postgres -d #{database} -c 'CREATE EXTENSION citext'"
    user WS_USER
    not_if "/usr/local/bin/psql -U postgres -d #{database} -c '\\dT' | grep -i citext"
  end
end
