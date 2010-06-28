include_recipe "pivotal_workstation::rvm"


#rvm_install(:mri_187, "ruby-1.8.7#{level}")

level = node[:rvm_mri_187_patchlevel] ? "-p#{node[:rvm_mri_187_patchlevel]}" : ""
id = "ruby-1.8.7#{level}"

#don't use the marker file system for this.  we guess that people are likely to be installing rubies by hand using rvm.
  #...that guess might be wrong.
unless File.exists?("#{::RVM_HOME}/bin/#{id}")

  execute "installing MRI 1.8.7 with RVM" do
    command "#{RVM_COMMAND} install #{id}"
    user WS_USER
  end

  execute "check MRI 1.8.7" do
    command "#{RVM_COMMAND} list | grep #{id}"
    user WS_USER
  end
  
end