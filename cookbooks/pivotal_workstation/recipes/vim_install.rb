vim_version  = version_string_for("vim")
::VIM_HOME = "#{WS_HOME}/.vim"

run_unless_marker_file_exists(marker_version_string_for("vim")) do
  directory VIM_HOME do
    owner WS_USER
  end
  
  execute "get vim source" do
    cmd = "curl ftp://ftp.vim.org/pub/vim/unix/vim-#{vim_version}.tar.bz2 | bunzip2 | tar -xf - -C #{VIM_HOME}"
    puts cmd
    command cmd
    user WS_USER
  end

  execute "configure vim" do
    command "cd #{VIM_HOME}/vim72 && ./configure --with-features=large --enable-rubyinterp"
    user WS_USER
  end
  
  ruby_block "fix up vim for snow leopard with ruby interp" do
    block do
      file_name = "#{VIM_HOME}/vim72/src/auto/config.mk"
      new_contents = ""
      File.open(file_name, "r") do |file|
        new_contents = file.read.gsub("-arch i386", "")
      end
      File.open(file_name, "w") do |file|
        file.write(new_contents)
      end
    end
  end
  
  execute "make and install" do
    command "cd #{VIM_HOME}/vim72 && make && make install"
  end

  execute "symlink vi to vim" do
    command "ln -sf /usr/local/bin/vim /bin/vi"
  end
end

brew_install "macvim"