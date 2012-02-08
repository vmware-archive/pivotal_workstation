execute "create SSH key pair for Github" do
  command "ssh-keygen -N '' -f #{WS_HOME}/.ssh/id_github_#{node["github_project"]}"
  user WS_USER
  not_if "test -e #{WS_HOME}/.ssh/id_github_#{node["github_project"]}"
end

execute "symlink Github key for git-project" do
  command "ln -nfs #{WS_HOME}/.ssh/id_github_{#{node["github_project"]},current}"
  user WS_USER
end

execute "make sure .ssh/config is owned by the user" do
  only_if "test -e #{WS_HOME}/.ssh/config"
  command "chown #{WS_USER} #{WS_HOME}/.ssh/config"
end

execute "add Github configuration to .ssh/config" do
  config = "\n\nHost github.com\n  User git\n  IdentityFile #{WS_HOME}/.ssh/id_github_current"
  command "echo '#{config}' >> #{WS_HOME}/.ssh/config"
  not_if "grep 'id_github_current' #{WS_HOME}/.ssh/config"
  user WS_USER
end
