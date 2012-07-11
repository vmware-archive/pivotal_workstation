include_recipe "pivotal_workstation::workspace_directory"

node['git_projects'].each do |repo_name, repo_address|
  execute "clone #{repo_name}" do
    command "git clone #{repo_address} #{repo_name}"
    user WS_USER
    cwd "#{WS_HOME}/#{node['workspace_directory']}/"
    not_if { ::File.exists?("#{WS_HOME}/#{node['workspace_directory']}/#{repo_name}") }
  end

  [ "git branch --set-upstream master origin/master",  "git submodule init", "git submodule update" ].each do |git_cmd|
    execute "#{repo_name} - #{git_cmd}" do
      command git_cmd
      cwd "#{WS_HOME}/#{node['workspace_directory']}/#{repo_name}"
      user WS_USER
      not_if { ::File.exists?("#{WS_HOME}/#{node['workspace_directory']}/#{repo_name}") }
    end
  end
end