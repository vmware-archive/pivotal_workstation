include_recipe "pivotal_workstation::user_owns_usr_local"

execute "put git-scripts in /usr/local/bin" do
  command "cd /usr/local/bin && curl -L http://github.com/pivotal/git_scripts/tarball/master | gunzip | tar xvf - --strip=2"
  user WS_USER
  not_if "which git-pair"
end

template "#{WS_HOME}/.pairs" do
  owner WS_USER
  source "git_scripts_pairs.erb"
end

ruby_block "test that git pair works" do
  block do
    raise "git pair doesn't work" if `which git-pair`.empty?
  end
end

