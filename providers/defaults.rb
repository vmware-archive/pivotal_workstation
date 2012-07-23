action :write do
  execute "#{new_resource.description} - #{new_resource.plist} - #{new_resource.key}"  do
    command "defaults write #{new_resource.plist} #{new_resource.key} #{type_flag} #{value}"
    user WS_USER
    not_if "defaults read #{new_resource.plist} #{new_resource.key} | grep ^#{value}$"
  end
end

def type_flag
  return '-int' if new_resource.integer
  return '-string' if new_resource.string
end

def value
  new_resource.integer || new_resource.string
end
