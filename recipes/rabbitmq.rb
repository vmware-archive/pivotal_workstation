directory "/usr/local/sbin" do
  owner WS_USER
  recursive true
end

brew_install "rabbitmq"
