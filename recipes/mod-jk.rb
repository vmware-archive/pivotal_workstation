
unless File.exists?("/usr/libexec/apache2/mod_jk.so")

  remote_file "#{Chef::Config[:file_cache_path]}/tomcat-connectors-1.2.37-src.tar.gz" do
    source "http://www.apache.org/dist/tomcat/tomcat-connectors/jk/tomcat-connectors-1.2.37-src.tar.gz"
    owner WS_USER
  end

  execute "extract tomcat-connectors" do
    command "tar vxzf #{Chef::Config[:file_cache_path]}/tomcat-connectors-1.2.37-src.tar.gz -C #{Chef::Config[:file_cache_path]}/"
    user WS_USER
  end

  bash "install_program" do
    user "root"
    cwd "#{Chef::Config[:file_cache_path]}/tomcat-connectors-1.2.37-src/native"
    code <<-EOH
        ln -s /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain /Applications/Xcode.app/Contents/Developer/Toolchains/OSX10.8.xctoolchain
        ./configure --with-apxs=/usr/sbin/apxs
        make
        make install
        /usr/sbin/apxs -a -e -n "jk" mod_jk.so
    EOH
  end

end
