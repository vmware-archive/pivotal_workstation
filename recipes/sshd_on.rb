execute "turn on ssh" do
  command "systemsetup -setremotelogin on"
end

ruby_block "test to see if sshd is running" do
  block do
    require 'socket'
    ssh_port = 22
    begin
      s = TCPSocket.open('localhost',ssh_port)
    rescue => e
      raise "sshd is not running: " << e
    end
    s.close
  end
end
