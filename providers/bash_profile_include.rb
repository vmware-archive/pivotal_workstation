action :create do

  directory "#{node["bash_includes_subdir"]}" do
    owner WS_USER
  end

  template "#{node["bash_bashrc"]}" do
    source "bash_profile.erb"
    cookbook 'pivotal_workstation'
    owner WS_USER
    mode "0755"
    variables({
      :subdir => "#{node["bash_includes_subdir"]}"
      })
  end

  template "#{node["bash_includes_subdir"]}/#{new_resource.name}.sh" do
    source "bash_profile-#{new_resource.name}.sh.erb"
    owner WS_USER
    mode "0755"
  end
end
