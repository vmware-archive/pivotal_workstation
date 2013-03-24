unless File.exists?("/Library/Fonts/SourceCodePro-Black.otf")
  remote_file "#{Chef::Config[:file_cache_path]}/source_code_pro.zip" do
    source "http://sourceforge.net/projects/sourcecodepro.adobe/files/SourceCodePro_FontsOnly-1.017.zip/download"
    owner WS_USER
    checksum "8136b4686309c428ef073356ab178c2f7e8f7b6fadd5a6c61b6a20646377b21f"
  end

  execute "unzip source code pro" do
    command "unzip -o #{Chef::Config[:file_cache_path]}/source_code_pro.zip '*.otf' -d #{Chef::Config[:file_cache_path]}/"
    user WS_USER
  end

  execute "copy source code pro fonts to /Library/Fonts" do
    command "mv #{Chef::Config[:file_cache_path]}/SourceCodePro_FontsOnly-1.017/OTF/*.otf #{Regexp.escape("/Library/Fonts/")}"
    user WS_USER
    group "admin"
  end

  ruby_block "test to see if source code pro fonts were installed" do
    block do
      raise "Source Code Pro font was not installed" unless File.exists?("/Library/Fonts/SourceCodePro-Black.otf")
    end
  end
end
