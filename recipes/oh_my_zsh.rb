include_recipe "pivotal_workstation::git"

execute "oh my zsh install" do
  command "curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh"
  user WS_USER
  not_if { File.exist?("#{WS_HOME}/.oh-my-zsh") }
end
