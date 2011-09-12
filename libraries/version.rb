class Chef::Recipe
  def marker_version_string_for(application_name)
    application_name + "-" + version_string_for(application_name)
  end

  def version_string_for(application_name)
    node[:versions][application_name] || raise("you must define a version for #{application_name} in attributes.")
  end
end