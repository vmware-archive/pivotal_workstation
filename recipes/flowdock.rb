unless File.exists?("/Applications/Flowdock.app")
    
    remote_file "#{Chef::Config[:file_cache_path]}/flowdock.zip" do
        source "https://d2ph5hv9wbwvla.cloudfront.net/mac/Flowdock_v1_0_8.zip"
        checksum "a6c06d75ccdddaf230d6c6c7fb7887a455ca3c3585f29124a8a09778824b9bfd"
        owner WS_USER
    end
    
    execute "unzip flowdock" do
        command "unzip #{Chef::Config[:file_cache_path]}/flowdock.zip -d #{Chef::Config[:file_cache_path]}/"
        user WS_USER
    end
    
    execute "copy flowdock to /Applications" do
        command "mv #{Chef::Config[:file_cache_path]}/Flowdock.app #{Regexp.escape("/Applications/Flowdock.app")}"
        user WS_USER
        group "admin"
    end
    
    ruby_block "test to see if Flowdock.app was installed" do
        block do
            raise "Flowdock.app was not installed" unless File.exists?("/Applications/Flowdock.app")
        end
    end
    
end
