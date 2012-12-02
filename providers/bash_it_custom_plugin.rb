action :create do
  include_recipe "pivotal_workstation::bash_it"

  bash_it_custom_dir = ::File.join(::BASH_IT_DIR, "custom")

  template ::File.expand_path(custom_script, bash_it_custom_dir) do
    source custom_script
    owner WS_USER
    only_if { custom_script =~ /\.bash$/ && ::File.directory?(bash_it_custom_dir) }
  end
end
