
if File.exists?("/usr/local/bin/composer")

    bash "update_composer" do
        user "root"
        cwd "/tmp"
        code <<-EOH
            /usr/local/bin/composer self-update
        EOH
    end

else

    bash "install_composer" do
        user "root"
        cwd "/tmp"
        code <<-EOH
            curl -s https://getcomposer.org/installer | php
            mv composer.phar /usr/local/bin/composer
        EOH
    end

end
