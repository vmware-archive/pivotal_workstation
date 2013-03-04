define :rbenv_ruby_install do
  ruby_version = params[:version] || params[:name]
  options = params[:options] || {}

  include_recipe "pivotal_workstation::rbenv"

  install_cmd = "#{RBENV_COMMAND} install #{ruby_version} #{options[:command_line_options]}"

  execute "installing #{ruby_version} with RBENV: #{install_cmd}" do
    only_if params[:only_if] if params[:only_if]
    not_if params[:not_if] || "test -e #{::RBENV_HOME}/versions/#{ruby_version}/bin/ruby"
    command install_cmd
    user params[:user] || WS_USER
    ignore_failure true # rbenv install appears to return 1 on completion for an unknown reason at this time
    env params[:options][:env]
  end

  execute "check #{ruby_version}" do
    command "#{RBENV_COMMAND} versions | grep #{ruby_version}"
    user params[:user] || WS_USER
  end
end

