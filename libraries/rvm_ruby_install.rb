class Chef::Recipe
  def rvm_ruby_install(ruby_version, env_override)
    include_recipe "pivotal_workstation::rvm"

    #don't use the marker file system for this.  we guess that people are likely to be installing rubies by hand using rvm.
      #...that guess might be wrong.
    unless File.exists?("#{::RVM_HOME}/bin/#{ruby_version}")

      execute "clean out the archive and src directories each time.  bad downloads cause problems with rvm" do
        command "rm -rf #{::RVM_HOME}/archives/*; rm -rf #{::RVM_HOME}/src/*"
        user WS_USER
      end

      install_cmd = "#{env_override} #{RVM_COMMAND} install #{ruby_version}"

      #this fixes an rvm problem with openssl when installing an mri version
      install_cmd << " -C --with-openssl-dir=#{::RVM_HOME}/usr" if ruby_version =~ /^ruby-/

      #| (! grep 'error') : if we see rvm errors in stderr, fail
      #this is due to an rvm bug (we've notified the author).  as soon as curl error cause rvm to exit nonzero,
      #we can get rid of this
      install_cmd << " 2>&1 | (! grep error)"

      execute "installing #{ruby_version} with RVM: #{install_cmd}" do
        command install_cmd
        user WS_USER
      end

      execute "check #{ruby_version}" do
        command "#{RVM_COMMAND} list | grep #{ruby_version}"
        user WS_USER
      end

    end
  end
end
