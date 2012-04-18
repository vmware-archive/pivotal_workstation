define :bash_profile_include, :cookbok => "pivotal_workstation" do
  include_recipe "pivotal_workstation::bash_profile"
  bash_file = params[:name]
  template "#{BASH_INCLUDES_SUBDIR}/#{bash_file}.sh" do
    only_if params[:only_if] if params[:only_if]
    not_if params[:not_if] if params[:not_if]
    source params[:source] || "bash_profile-#{bash_file}.sh.erb"
    owner params[:owner] || WS_USER
    backup params[:backup] || false
    mode params[:mode] || "0755"
  end
end
