include_recipe "pivotal_workstation::workspace_directory"

node.git_projects.each do |repo_name, repo_address|
  execute "clone #{repo_name}" do
    command "git clone #{repo_address} #{repo_name}"
    user WS_USER
    cwd "#{WS_HOME}/#{node['workspace_directory']}/"
    not_if { ::File.exists?("#{WS_HOME}/#{node['workspace_directory']}/#{repo_name}") }
  end

  execute "track origin master" do
    command "git branch --set-upstream master origin/master"
    cwd "#{WS_HOME}/#{node['workspace_directory']}/#{repo_name}"
    user WS_USER
  end

  execute "git submodule init for #{repo_name}" do
    command "git submodule init"
    cwd "#{WS_HOME}/#{node['workspace_directory']}/#{repo_name}"
    user WS_USER
  end

  execute "git submodule update for #{repo_name}" do
    command "git submodule update"
    cwd "#{WS_HOME}/#{node['workspace_directory']}/#{repo_name}"
    user WS_USER
  end
end

