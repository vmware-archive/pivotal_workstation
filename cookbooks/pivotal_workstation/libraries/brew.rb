class Chef::Recipe
  def brew_install(package)
    execute "brew install #{package}" do
      user WS_USER
      command "brew install #{package}"
    end
  end
end