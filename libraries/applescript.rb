class Chef::Resource::Execute
  def applescript(script)
    command "osascript -e \"#{script.gsub('"', '\\"')}\""
  end
end
