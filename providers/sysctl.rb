action :set do
  def sysctl_conf
    ::File.open("/etc/sysctl.conf").read.split("\n")
  rescue Errno::ENOENT
    []
  end

  def flush_sysctl_conf(settings)
    ::File.open("/etc/sysctl.conf", "w+") do |file|
      file.write(settings.join("\n"))
    end
  end

  def line_contains_name(line, name)
    line =~ /^#{name}=/
  end

  def set_value_in_sysctl(name, value)
    changed = false
    sysctl = sysctl_conf.map do |line|
      if line_contains_name(line, name)
        line.gsub!(/=.*/,"=#{value}")
        changed = true
      end
      line
    end

    sysctl << "#{name}=#{value}" unless changed
    flush_sysctl_conf(sysctl)
  end

  execute "set #{new_resource.name}=#{new_resource.value}" do
    command "/usr/sbin/sysctl -w #{new_resource.name}=#{new_resource.value}"
  end

  ruby_block "setting #{new_resource.name}=#{new_resource.value} in /etc/sysctl.conf" do
    block do
      set_value_in_sysctl(new_resource.name, new_resource.value)
    end
  end
end
