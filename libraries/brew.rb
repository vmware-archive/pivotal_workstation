class Chef::Recipe
  def brew_install(package)
    include_recipe "pivotal_workstation::homebrew"
    
    execute "brew install #{package}" do
      user WS_USER
      command "brew install #{package}"
    end
  end
end