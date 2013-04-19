Chef::Log.warn 'Please use https://github.com/pivotal-sprout/sprout instead'

# See http://willbryant.net/software/mac_os_x/postgres_initdb_fatal_shared_memory_error_on_leopard

pivotal_workstation_sysctl "increase shared memory allocation size" do
  name "kern.sysv.shmall"
  value "65536"
end

pivotal_workstation_sysctl "increase shared memory max" do
  name "kern.sysv.shmmax"
  value "16777216"
end
