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

  execute "install vim" do
    command "cd #{VIM_HOME}/vim72 && ./configure --with-features=huge --enable-rubyinterp && make && make install"
    user WS_USER
  end

  execute "symlink vi to vim" do
    command "ln -sf /usr/local/bin/vim /bin/vi"
  end
end

brew_install "macvim"