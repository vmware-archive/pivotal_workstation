include_recipe "pivotal_workstation::git"
include_recipe "pivotal_workstation::apple_gcc42"

rvm_git_revision_hash  = version_string_for("rvm")

::RVM_HOME = "#{WS_HOME}/.rvm"
::RVM_COMMAND = "#{::RVM_HOME}/bin/rvm"

pivotal_workstation_bash_it_enable_feature "plugins/rvm"

run_unless_marker_file_exists(marker_version_string_for("rvm")) do
  recursive_directories [RVM_HOME, 'src', 'rvm'] do
    owner WS_USER
    recursive true
  end

  [
    "curl -Lsf http://github.com/wayneeseguin/rvm/tarball/#{rvm_git_revision_hash} | tar xvz -C#{RVM_HOME}/src/rvm --strip 1",
    "cd #{RVM_HOME}/src/rvm; ./install",
    "#{RVM_COMMAND} --version | grep Wayne"
  ].each do |rvm_cmd|
    execute rvm_cmd do
      user WS_USER
    end
  end

  %w{readline autoconf openssl zlib}.each do |rvm_pkg|
    execute "install rvm pkg: #{rvm_pkg}" do
      command "#{::RVM_COMMAND} pkg install --verify-downloads 1 #{rvm_pkg}"
      user WS_USER
    end
  end
end

node["rvm"]["rubies"].each do |version, options|
  rvm_ruby_install version do
    options options
  end
end

execute "making #{node["rvm"]["default_ruby"]} with rvm the default" do
  not_if { node["rvm"]["default_ruby"].nil? }
  command "#{::RVM_COMMAND} alias create default #{node["rvm"]["default_ruby"]}"
  user WS_USER
end
