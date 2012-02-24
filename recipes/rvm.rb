include_recipe "pivotal_workstation::java"
include_recipe "pivotal_workstation::bash_profile"
include_recipe "pivotal_workstation::git"

rvm_git_revision_hash  = version_string_for("rvm")

::RVM_HOME = "#{WS_HOME}/.rvm"
::RVM_COMMAND = "#{::RVM_HOME}/bin/rvm"

bash_profile_include("rvm")

run_unless_marker_file_exists(marker_version_string_for("rvm")) do
  recursive_directories [RVM_HOME, 'src', 'rvm'] do
    owner WS_USER
    recursive true
  end

  execute "download rvm" do
    command "curl -Lsf http://github.com/wayneeseguin/rvm/tarball/#{rvm_git_revision_hash} | tar xvz -C#{RVM_HOME}/src/rvm --strip 1"
    user WS_USER
  end

  execute "install rvm" do
    cwd "#{RVM_HOME}/src/rvm"
    command "./install"
    user WS_USER
  end

  execute "check rvm" do
    command "#{RVM_COMMAND} --version | grep Wayne"
    user WS_USER
  end

  %w{readline autoconf openssl zlib}.each do |rvm_pkg|
    execute "install rvm pkg: #{rvm_pkg}" do
      command "#{::RVM_COMMAND} pkg install #{rvm_pkg}"
      user WS_USER
    end
  end
end

node["rvm"]["rubies"].each do |ruby_version_string, options|
  rvm_ruby_install(ruby_version_string,options)
end

if node["rvm"]["default_ruby"]
  execute "making 1.9.2 with rvm the default" do
    command "#{::RVM_COMMAND} --default #{node["rvm"]["default_ruby"]}"
    user WS_USER
  end
end
