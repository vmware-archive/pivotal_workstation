dmg_package "OmniGraffle Professional 5" do
    volumes_dir "OmniGrafflePro"
    accept_eula true
    source "http://www.omnigroup.com/download/latest/omnigrafflepro"
    action :install
    owner WS_USER
end

gtemplate = "#{WS_HOME}/Library/Application Support/OmniGraffle/Templates/Konigi-UX-Template.gtemplate"
unless File.exists?(gtemplate)
    directory "#{WS_HOME}/Library/Application Support/OmniGraffle/Templates" do
        owner WS_USER
        mode 0755
        action :create
        recursive true
    end

    remote_file "#{Chef::Config[:file_cache_path]}/Konigi-UX-Template-2-5-1.gtemplate.zip" do
        source "http://media.konigi.com/tools/og-ux-template/Konigi-UX-Template-2-5-1.gtemplate.zip"
        owner WS_USER
    end

    execute "unzip Konigi-UX-Template-2-5-1.gtemplate.zip" do
        command "unzip #{Chef::Config[:file_cache_path]}/Konigi-UX-Template-2-5-1.gtemplate.zip -d #{Chef::Config[:file_cache_path]}/"
        user WS_USER
    end

    execute "move Konigi-UX-Template.gtemplate" do
        command "mv #{Chef::Config[:file_cache_path]}/Konigi-UX-Template.gtemplate #{Regexp.escape(gtemplate)}"
        user WS_USER
    end
end

gdiagramstyle = "#{WS_HOME}/Library/Application Support/OmniGraffle/Diagram Styles/Konigi.gdiagramstyle"
unless File.exists?(gdiagramstyle)
    directory "#{WS_HOME}/Library/Application Support/OmniGraffle/Diagram Styles" do
        owner WS_USER
        mode 0755
        action :create
        recursive true
    end

    remote_file "#{Chef::Config[:file_cache_path]}/Konigi.gdiagramstyle.zip" do
        source "http://media.konigi.com/tools/og-ux-template/Konigi.gdiagramstyle.zip"
        owner WS_USER
    end

    execute "unzip Konigi.gdiagramstyle.zip" do
        command "unzip #{Chef::Config[:file_cache_path]}/Konigi.gdiagramstyle.zip -d #{Chef::Config[:file_cache_path]}/"
        user WS_USER
    end

    execute "move Konigi.gdiagramstyle" do
        command "mv #{Chef::Config[:file_cache_path]}/Konigi.gdiagramstyle #{Regexp.escape(gdiagramstyle)}"
        user WS_USER
    end
end

stencils = "#{WS_HOME}/Library/Application Support/OmniGraffle/Stencils/Konigi Wireframe Stencils v3"
unless File.exists?(stencils)
    directory "#{WS_HOME}/Library/Application Support/OmniGraffle/Stencils" do
        owner WS_USER
        mode 0755
        action :create
        recursive true
    end

    remote_file "#{Chef::Config[:file_cache_path]}/Konigi-Wireframe-Stencils-v3-02.zip" do
        source "http://media.konigi.com/tools/og-wireframe-stencil/Konigi-Wireframe-Stencils-v3-02.zip"
        owner WS_USER
    end

    execute "unzip Konigi-Wireframe-Stencils-v3-02.zip" do
        command "unzip #{Chef::Config[:file_cache_path]}/Konigi-Wireframe-Stencils-v3-02.zip -d #{Chef::Config[:file_cache_path]}/"
        user WS_USER
    end

    execute "move Konigi.gdiagramstyle" do
        command "mv #{Chef::Config[:file_cache_path]}/#{Regexp.escape("Konigi Wireframe Stencils v3")} #{Regexp.escape("#{WS_HOME}/Library/Application Support/OmniGraffle/Stencils/")}"
        user WS_USER
    end
end
