#nailing rvm to this revision, for no reason other than consistency
rvm_git_revision_hash  = "7d8b51b47f1cd29b7dc6a7bde87507a5f8e56603"

RVM_HOME = "#{$HOME}/.rvm"

run_unless_marker_file_exists("rvm-#{rvm_git_revision_hash}") do
  
  [RVM_HOME, "#{RVM_HOME}/src/rvm"].each do |dir|
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
  end
  
  ruby_block "check rvm" do
    block do
      result = `rvm --version`
      raise("rvm not working: #{result}") unless result.include?("Wayne")
    end
  end
  
end

