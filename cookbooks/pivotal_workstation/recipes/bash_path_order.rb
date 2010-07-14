run_unless_marker_file_exists("bash_path_order") do
  ruby_block "put /usr/local/bin first in path" do
    block do
      new_contents = ""
      File.open("/etc/paths", "r") do |file|
        new_contents = "/usr/local/bin\n"+file.read.gsub("/usr/local/bin\n", "")
      end
      File.open("/etc/paths", "w") do |file|
        file.write(new_contents)
      end
    end
  end
end