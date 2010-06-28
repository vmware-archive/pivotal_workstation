include_recipe "pivotal_workstation::bash_profile"

#http://greg.nokes.name/2010/03/26/rooting-with-rvm/

#nailing rvm to this revision, for no reason other than consistency
rvm_git_revision_hash  = "c83d53c3d0100cde8f61"

::RVM_HOME = "#{WS_HOME}/.rvm"
::RVM_COMMAND = "source #{RVM_HOME}/scripts/rvm || rvm"
  #explanation of the '||': sourcing the rvm stuff returns 1 sometimes, we don't know why, but it doesn't appear to be harmful.

run_unless_marker_file_exists("rvm-#{rvm_git_revision_hash}") do
  [RVM_HOME, "#{RVM_HOME}/src/", "#{RVM_HOME}/src/rvm"].each do |dir|
    directory dir do
      owner WS_USER
      recursive true
    end
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
  
  template "#{BASH_INCLUDES_SUBDIR}/rvm" do
    source "bash_profile_rvm.erb"
    owner WS_USER
  end
  
  execute "check rvm" do
    command "#{RVM_COMMAND} --version | grep Wayne"
    user WS_USER
  end
  
end