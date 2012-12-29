# Usage:
# pivotal_workstation_bash_it_enable "plugins/foo"

action :create do
  type, name  = new_resource.name.split("/")
  # TODO: complain if type is not in [aliases, completion, plugins]

  def script_type(type)
    (type == 'plugins') ? 'plugin' : type
  end

  type_dir            = ::File.expand_path(type, node['bash_it']['dir'])
  enabled_dir         = ::File.expand_path("enabled", type_dir)
  available_dir       = ::File.expand_path("available", type_dir)

  script_name         = "#{name}.#{script_type(type)}.bash"
  enabled_script_path = ::File.expand_path(script_name, enabled_dir)

  directory enabled_dir do
    recursive true
    user WS_USER
    not_if { ::File.directory?(enabled_dir) }
  end

  link enabled_script_path do
    to ::File.expand_path(script_name, available_dir)
    user WS_USER
    not_if { ::File.symlink?(enabled_script_path) }
  end
end
