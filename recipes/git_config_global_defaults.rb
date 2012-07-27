include_recipe "pivotal_workstation::git"
pivotal_workstation_bash_profile_include "git_vim"

template "#{WS_HOME}/.gitignore_global" do
  source "gitignore_global.erb"
  owner WS_USER
  variables(
    :ignore_idea => node[:git_global_ignore_idea]
  )
end

execute "set global git ignore" do
  command "git config --global core.excludesfile #{WS_HOME}/.gitignore_global"
  user WS_USER
  not_if "git config --global core.excludesfile | grep -q .gitignore_global"
end

execute "set alias st=status" do
  command "git config --global alias.st status"
  user WS_USER
end

execute "set alias di=diff" do
  command "git config --global alias.di diff"
  user WS_USER
end

execute "set alias co=checkout" do
  command "git config --global alias.co checkout"
  user WS_USER
end

execute "set alias ci=commit" do
  command "git config --global alias.ci commit"
  user WS_USER
end

execute "set alias br=branch" do
  command "git config --global alias.br branch"
  user WS_USER
end

execute "set alias sta=stash" do
  command "git config --global alias.sta stash"
  user WS_USER
end

execute "set alias llog=log --date=local" do
  command "git config --replace-all --global alias.llog 'log --date=local'"
  user WS_USER
end

execute "set apply whitespace=nowarn" do
  command "git config --global apply.whitespace nowarn"
  user WS_USER
end

execute "set color branch=auto" do
  command "git config --global color.branch auto"
  user WS_USER
end

execute "set color diff=auto" do
  command "git config --global color.diff auto"
  user WS_USER
end

execute "set color interactive=auto" do
  command "git config --global color.interactive auto"
  user WS_USER
end

execute "set color status=auto" do
  command "git config --global color.status auto"
  user WS_USER
end

execute "set color ui=auto" do
  command "git config --global color.ui auto"
  user WS_USER
end

execute "set branch autosetupmerge=true" do
  command "git config --global branch.autosetupmerge true"
  user WS_USER
end
