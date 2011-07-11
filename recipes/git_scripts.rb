run_unless_marker_file_exists("git_scripts") do
  execute "put git-scripts in /usr/local/bin" do
    command "cd /usr/local/bin && curl -L http://github.com/pivotal/git_scripts/tarball/master | gunzip | tar xvf - --strip=2"
    user WS_USER
  end
end

template "#{WS_HOME}/.pairs" do
  owner WS_USER
  source "git_scripts_pairs.erb"
end