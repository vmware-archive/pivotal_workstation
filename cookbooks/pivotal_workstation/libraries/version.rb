class Chef::Recipe
  def marker_version_string_for(thing)
    thing + "-" + version_string_for(thing)
  end

  def version_string_for(thing)
    node[:versions][thing] || raise("you must define a version for #{thing} in your json.\ne.g. versions: [''#{thing}': '1.1.4']")
  end
end