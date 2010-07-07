mvim_version  = version_string_for("mvim")

::MVIM_HOME = "#{WS_HOME}/.mvim"

run_unless_marker_file_exists(marker_version_string_for("mvim")) do
  recursive_directories [MVIM_HOME, 'src', 'mvim'] do
    owner WS_USER
    recursive true
  end
  
  # refactor to use remote_file?
  execute "download mvim" do
    command "curl -Lsf http://macvim.googlecode.com/files/MacVim-#{mvim_version}.tbz | tar xv --use-compress-program bzip2 -C#{MVIM_HOME}/src/mvim --strip 1"
    user WS_USER
  end
  
  execute "install mvim" do
    cwd "#{MVIM_HOME}/src/mvim"
    command <<-EOC
      cp MacVim.app /Applications
      cp mvim /usr/local/bin
    EOC
    user WS_USER
  end

  execute "check mvim" do
    command "mvim --version | grep 'Bjorn Winckler'"
    user WS_USER
  end
end
