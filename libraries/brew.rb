class Chef::Recipe
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
end
