class Chef::Recipe
  def brew_install(package, opts={})
    brew package do
      action :install
      options opts[:brew_args]
    end
  end

  def brew_installed?(package)
    include_recipe "pivotal_workstation::homebrew"
    installed=(system("brew list #{package} > /dev/null 2>&1") || brew_has_multiple_versions_installed?(package))
    Chef::Log.debug("brew package #{package} " + (installed ? "IS" : "IS NOT") + " installed.")
    installed
  end

  def brew_has_multiple_versions_installed?(package)
    multiple=system("brew list #{package} 2>/dev/null | grep -q '#{package} has multiple installed versions'")
    Chef::Log.debug("brew package #{package} " + (multiple ? "HAS" : "does NOT HAVE") + " multiple versions.")
    multiple
  end

  def brew_remove(package)
    brew package do
      action :remove
    end
  end

  def brew_update
    brew do
      action :update
    end
  end
end
