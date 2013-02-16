include_recipe "pivotal_workstation::workspace_directory"

node['git_projects'].each do |repo_name, repo_address, repo_dir|

  # Allow the user to override the working directory
  repo_dir ||= node['workspace_directory']

  execute "clone #{repo_name}" do
    command "git clone #{repo_address} #{repo_name}"
    user WS_USER
    cwd "#{WS_HOME}/#{repo_dir}/"
    not_if { ::File.exists?("#{WS_HOME}/#{repo_dir}/#{repo_name}") }
  end

  [ "git branch --set-upstream master origin/master",  "git submodule init", "git submodule update" ].each do |git_cmd|
    execute "#{repo_name} - #{git_cmd}" do
      command git_cmd
      cwd "#{WS_HOME}/#{repo_dir}/#{repo_name}"
      user WS_USER
      not_if { ::File.exists?("#{WS_HOME}/#{repo_dir}/#{repo_name}") }
    end
  end
end

