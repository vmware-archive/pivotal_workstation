class Chef::Recipe
  def zip_app_install(options)
    raise ArgumentError.new("Options must include :app") unless options[:app]
    raise ArgumentError.new("Options must include :uri") unless options[:uri]

    if options[:force]
      execute ":force is true, removing marker file for '#{options[:app]}'" do
        command "rm -f #{File.join(MARKER_DIR, options[:app])}"
        user WS_USER
      end
    end

    run_unless_marker_file_exists(options[:app]) do
      download_dir = "/tmp/#{options[:app]}"
      downloaded_zip_file = "#{download_dir}/#{options[:app]}.zip"

      execute "delete/(re)create download dir (#{options[:app]})" do
        command "rm -rf #{download_dir}"
        command "mkdir -p #{download_dir}"
        user WS_USER
      end

      remote_file downloaded_zip_file do
        source options[:uri]
        owner WS_USER
        group "staff"
      end

      execute "uncompress application (#{options[:app]})" do
        # unzip doesn't respct MacOS resource forks
        # => http://xahlee.org/UnixResource_dir/macosx.html
        command "ditto -xk '#{downloaded_zip_file}' #{download_dir}/"
        user WS_USER
      end

      install_applications(download_dir)

      execute "delete download dir (#{options[:app]})" do
        command "rm -rf #{download_dir}"
        user WS_USER
      end
    end
  end

  def dmg_app_install(options)
    raise ArgumentError.new("Options must include :app") unless options[:app]
    raise ArgumentError.new("Options must include :uri") unless options[:uri]

    run_unless_marker_file_exists(options[:app]) do
      downloaded_file = "/tmp/#{options[:app]}.dmg"
      mount_point = "/Volumes/#{options[:app]}"

      remote_file downloaded_file do
        source options[:uri]
        owner WS_USER
        group "staff"
      end

      execute "mount dmg (#{options[:app]})" do
        command "hdiutil attach -mountpoint #{mount_point} #{downloaded_file}"
        user WS_USER
      end

      install_applications(mount_point)

      execute "unmount dmg  (#{options[:app]})" do
        command "hdiutil detach #{mount_point}"
        user WS_USER
      end

      execute "delete downloaded dmg (#{options[:app]})" do
        command "rm -rf #{downloaded_file}"
        user WS_USER
      end
    end
  end

  private

  def install_applications(source_dir)
    installable_apps = `\cd #{source_dir}/ && \ls -d1 #{source_dir}/*.app`.split("\n")

    unless installable_apps.empty?
      execute "remove any existing .app(s) from /Applications/ (#{installable_apps.join(",")})" do
        apps_to_remove = installable_apps.map{|a| "'/Applications/#{a}'" }.join(" ")
        command "rm -rf #{apps_to_remove}"
        user WS_USER
      end

      execute "copy .app(s) into /Applications/ (#{installable_apps.join(",")})" do
        apps_to_install = installable_apps.map{|a| "'#{source_dir}/#{a}'" }.join(" ")
        command "cp -Rf #{apps_to_install} /Applications/"
        user WS_USER
      end
    end
  end
end
