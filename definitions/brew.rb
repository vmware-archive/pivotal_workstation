define :brew, :action => :install do
  include_recipe "pivotal_workstation::homebrew"
  package = params[:package] || params[:name]

  case params[:action]
  when :install

    outdated = system("brew outdated 2>/dev/null | grep -q #{package}")
    Chef::Log.debug("brew package #{package} " + (outdated ? "IS" : "IS NOT") + " outdated.")

    multiple_versions_installed = system("brew list #{package} 2>/dev/null | grep -q '#{package} has multiple installed versions'")
    Chef::Log.debug("brew package #{package} " + (multiple_versions_installed ? "HAS" : "does NOT HAVE") + " multiple versions.")

    already_installed = brew_installed?(package)
    if already_installed && (outdated || multiple_versions_installed)
      execute "brew remove outdated #{package} and then install" do
        only_if params[:only_if] if params[:only_if]
        not_if params[:not_if] if params[:not_if]
        user params[:user] || WS_USER
        command "brew remove --force #{package} && brew install #{package} #{params[:options]}"
      end
    end

    unless already_installed
      execute "brew install #{package}" do
        only_if params[:only_if] if params[:only_if]
        not_if params[:not_if] if params[:not_if]

        user params[:user] || WS_USER
        command "brew install #{package} #{params[:options]}"
      end
    end
  when :remove, :uninstall
    execute "brew uninstall #{package}" do
      only_if params[:only_if] || "brew list | grep #{package}"
      not_if params[:not_if] if params[:not_if]
      user params[:user] || WS_USER
      command "brew remove #{package}"
    end
  when :upgrade
    execute "brew upgrade #{package}" do
      only_if params[:only_if] || "brew outdated | grep #{package}"
      not_if params[:not_if] if params[:not_if]
      user params[:user] || WS_USER
      command "brew upgrade #{package}"
    end
  when :update
    execute "brew update" do
      only_if params[:only_if] if params[:only_if]
      not_if params[:not_if] if params[:not_if]
      user params[:user] || WS_USER
      command "brew update"
    end
  end
end

