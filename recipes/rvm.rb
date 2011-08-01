include_recipe "pivotal_workstation::java"
include_recipe "pivotal_workstation::bash_profile"
include_recipe "pivotal_workstation::git"

rvm_git_revision_hash  = version_string_for("rvm")

::RVM_HOME = "#{WS_HOME}/.rvm"
::RVM_COMMAND = "#{::RVM_HOME}/bin/rvm"

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
  
  bash_profile_include("rvm")
  
  execute "check rvm" do
    command "#{RVM_COMMAND} --version | grep Wayne"
    user WS_USER
  end
  
  execute "HACK the rvm openssl install script.  ./Configure was failing with 'target already defined'.  we've filed a bug about this" do
    command "perl -pi -e 's/os\\/compiler darwin/darwin/g' #{::RVM_HOME}/scripts/package"
  end
  
  execute "gem install soloist for default rvm" do
    command "bash -c 'source ~/.bash_profile_includes/rvm.sh; gem install soloist'"
    user WS_USER
  end
  
  %w{readline autoconf openssl zlib}.each do |rvm_package|
    execute "install rvm package: #{rvm_package}" do
      command "#{::RVM_COMMAND} package install #{rvm_package}"
      user WS_USER
    end
  end
end

node["rvm"]["rubies"].each do |ruby_version_string|
  rvm_ruby_install(ruby_version_string)
end

run_unless_marker_file_exists("rvm_default_to_1.9.2") do
  if node["rvm"]["default_ruby"]
    execute "making 1.9.2 with rvm the default" do
      command "#{::RVM_COMMAND} --default #{node["rvm"]["default_ruby"]}"
      user WS_USER
    end
  end
end
