include_recipe "pivotal_workstation::git"
pivotal_workstation_bash_it_custom_plugin "git-export_editor.bash"

template "#{WS_HOME}/.gitignore_global" do
  source "gitignore_global.erb"
  owner WS_USER
  variables(:ignore_idea => node[:git_global_ignore_idea])
end

execute "set global git ignore" do
  command "git config --global core.excludesfile #{WS_HOME}/.gitignore_global"
  user WS_USER
  only_if "[ -z `git config --global core.excludesfile` ]"
end

execute "make the pager prettier" do
  # When paging to less:
  # * -x2 Tabs appear as two spaces
  # * -S Chop long lines
  # * -F Don't require interaction if paging less than a full screen
  # * -X No scren clearing
  # * -R Raw, i.e. don't escape the control characters that produce colored output
  command %{git config --global core.pager "less -FXRS -x2"}
  user WS_USER
end

aliases =<<EOF
st status
di diff
co checkout
ci commit
br branch
sta stash
llog \"log --date=local\"
flog \"log --pretty=fuller --decorate\"
lg \"log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative\"
lol \"log --graph --decorate --oneline\"
lola \"log --graph --decorate --oneline --all\"
blog \"log origin/master... --left-right\"
ds \"diff --staged\"
fixup \"commit --fixup\"
squash \"commit --squash\"
unstage \"reset HEAD\"
rum rebase master@{u}
EOF

aliases.split("\n").each do |alias_string|
  abbrev = alias_string.split[0]
  execute "set alias #{abbrev}" do
    command "git config --global alias.#{alias_string}"
    user WS_USER
    only_if "[ -z `git config --global alias.#{abbrev}` ]"
  end
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

execute "set rebase autosquash=true" do
  command "git config --global rebase.autosquash true"
  user WS_USER
end
