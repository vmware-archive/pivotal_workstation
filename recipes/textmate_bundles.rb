bundle_dir = "#{WS_HOME}/Library/Application Support/TextMate/Bundles"
filename = "Pivotal.tmbundle"
tarfile = "#{filename}.tar.gz"
unless File.exists?("#{bundle_dir}/#{filename}")
  execute "make textmate bundles directory" do
    command "mkdir -p '#{bundle_dir}'"
    user WS_USER
    not_if { File.exists?(bundle_dir) }
  end

  remote_file "#{bundle_dir}/#{tarfile}" do
    source "http://cheffiles.pivotallabs.com/#{tarfile}"
    owner WS_USER
    :create_if_missing
  end

  execute "cd \"#{bundle_dir}\"; tar xzf #{tarfile}; rm #{tarfile}"
end
