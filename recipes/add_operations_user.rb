#password_hash = node[:users][:operations][:password_hash] || "!NOLOGIN"
#password_hash = "!NOLOGIN"

# Find the first available uid > 500
uids = `dscl . -list /Users UniqueID`.split("\n").collect { |pair| pair.squeeze(" ").split(" ").last.to_i }
uid = 501
while ( uids.include?(uid) ) do
  uid += 1
end

username="santa"
user username do
  comment username.capitalize
  gid 20
  uid uid
  home "/Users/#{username}"
  shell "/bin/bash"
  not_if Kernel.system("id santa").to_s
end

group "admin" do
  members [username]
  append true
end
