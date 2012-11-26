node.default["rvm"]= {
  "rubies" => {
      # gcc-4.2 is available from the osx-gcc project on github. We dont install it
      # as it overwrites later versions of files provided by xcode.
    #"ree-1.8.7-2012.02" => { :env => "CC=gcc-4.2" },
    #"ruby-1.8.7-p358" => { :env => "CC=gcc-4.2" },
    #"ruby-1.9.2-p290" => { :env => "CC=gcc-4.2" },
    "ruby-1.9.3-p194" => { :command_line_options => "--with-gcc=clang" },
  },
  "default_ruby" => "ruby-1.9.3-p194"
}
