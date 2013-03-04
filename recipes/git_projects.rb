# Recipe to clone git repositories into the users workspace_directory
#
# Repositories should be defined as an array in the node_attributes section of
# your `soloistrc` file. eg:
#
# node_attributes:
#   git_projects:
#     -
#       - repository-name (folder to be checked out into within your workspace folder)
#       - repository-url (source url)
#     -
#       - rails
#       - git@github.com:rails/rails.git
#     -
#       - hubot
#       - git@github.com:github/hubot.git
#

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

  [ "git branch --set-upstream master origin/master",  "git submodule update --init --recursive" ].each do |git_cmd|
    execute "#{repo_name} - #{git_cmd}" do
      command git_cmd
      cwd "#{WS_HOME}/#{repo_dir}/#{repo_name}"
      user WS_USER
      not_if { ::File.exists?("#{WS_HOME}/#{repo_dir}/#{repo_name}") }
    end
  end
end

