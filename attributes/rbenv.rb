unless node["rbenv"]
  node.default["rbenv"]= {
    "rubies" => {
        "ree-1.8.7-2012.01" => {},
        "1.8.7-p352" => {},
        "1.9.2-p290" => {},
        "1.9.3-p125" => { :env => {"CC" => "clang"}}
      },
    "default_ruby" => "1.9.3-p125"
  }
end