class Chef::Recipe
  def brew_install(package, opts={})
    include_recipe "pivotal_workstation::homebrew"

    if brew_installed?(package) && (brew_outdated?(package) || brew_has_multiple_versions_installed?(package))
      execute "brew remove --force #{package} && brew install #{package} #{opts[:brew_args]}" do
        user WS_USER
      end
    end

    unless brew_installed?(package)
      execute "brew install #{package} #{opts[:brew_args]}" do
        user WS_USER
      end
    end
  end

  def brew_outdated?(package)
    outdated=system("brew outdated | grep -q #{package}")
    Chef::Log.debug("brew package #{package} " + (outdated ? "IS" : "IS NOT") + " outdated.")
    outdated
  end

  def brew_installed?(package)
    include_recipe "pivotal_workstation::homebrew"

    installed=(system("brew list #{package} > /dev/null") || brew_has_multiple_versions_installed?(package))
    Chef::Log.debug("brew package #{package} " + (installed ? "IS" : "IS NOT") + " installed.")
    installed
  end

  def brew_has_multiple_versions_installed?(package)
    multiple=system("brew list #{package} | grep -q '#{package} has multiple installed versions'")
    Chef::Log.debug("brew package #{package} " + (multiple ? "HAS" : "does NOT HAVE") + " multiple versions.")
    multiple
  end

  def brew_remove(package)
    include_recipe "pivotal_workstation::homebrew"

    brew_installed = `brew list | grep #{package}`
    unless brew_installed.empty?
      execute "brew remove #{package}" do
        user WS_USER
        command "brew remove #{package}"
      end
    end
  end

  def brew_update
    include_recipe "pivotal_workstation::homebrew"

    execute "brew update" do
      user WS_USER
      command "brew update"
    end
  end
end
