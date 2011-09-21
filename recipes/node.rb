brew_install "node"

execute "install npm" do
  command "curl http://npmjs.org/install.sh | clean=no sh"
end
