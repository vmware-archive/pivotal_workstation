inputrc_location = "#{WS_HOME}/.inputrc"

unless File.exists?(inputrc_location)
  template inputrc_location do
    owner WS_USER
    source "inputrc.erb"
  end
end