node.default["rvm"] ||= {}
node.default["rvm"]["rubies"] = {
  # "ree-1.8.7-2012.02" => { :env => "CC=gcc-4.2" },
  # "ruby-1.8.7-p358" => { :env => "CC=gcc-4.2" },
  # "ruby-1.9.2-p290" => { :env => "CC=gcc-4.2" },
  # "ruby-1.9.3-p194" => { :command_line_options => "--with-gcc=clang" }
  "ruby-1.9.3-p392" => { :command_line_options => "--verify-downloads 1" }
}

node.default["rvm"]["default_ruby"] = "ruby-1.9.3-p392"
