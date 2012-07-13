# See http://willbryant.net/software/mac_os_x/postgres_initdb_fatal_shared_memory_error_on_leopard

# Make memory setting persist across reboots...
cookbook_file "/etc/sysctl.conf" do
  source "sysctl.conf"
  mode "0644"
  owner "root"
end

# ...and also change them for this session.
execute "sysctl -w kern.sysv.shmall=65536"
execute "sysctl -w kern.sysv.shmmax=16777216"