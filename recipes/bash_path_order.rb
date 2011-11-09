ruby_block "put /usr/local/bin first in path" do
  block do
    ENV['PATH']="/usr/local/bin:#{ENV['PATH']}"
    new_contents = ""
    File.open("/etc/paths", "r") do |file|
      new_contents = "/usr/local/bin\n"+file.read.gsub("/usr/local/bin\n", "")
    end
    File.open("/etc/paths", "w") do |file|
      file.write(new_contents)
    end
  end
end
