user="operations"
real_name="Pivotal Operations"
ruby_block "adding user '#{user}'" do
  block do
    system("dscl . -create /Users/#{user}")
    system("dscl . -create /Users/#{user} UserShell /bin/bash")
    system("dscl . -create /Users/#{user} RealName \"#{real_name}\"")
    #check for next sequential unused UID
    uids = `dscl . -list /Users UniqueID`.split("\n").collect { |pair| pair.squeeze(" ").split(" ").last.to_i }
    uid = 501
    while ( uids.include?(uid) ) do
      uid += 1
    end
    puts "I'm gonna use UID #{uid}"
    system("dscl . -create /Users/#{user} UniqueID \"#{uid}\"")
    system("dscl . -create /Users/#{user} PrimaryGroupID 20")
    system("dscl . -create /Users/#{user} NFSHomeDirectory /Users/#{user}")
    system("dscl . -passwd /Users/#{user} password")
    system("dscl . -append /Groups/admin GroupMembership #{user}")
    system("mkdir /Users/#{user}")
    system("chown #{user}:staff /Users/#{user}")
  end
end
