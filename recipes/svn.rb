unless system("svn --version | grep 'svn version' > /dev/null")
  include_recipe "pivotal_workstation::homebrew"
    
  execute "brew install svn" do
    user WS_USER
    command "brew install svn"
  end
end