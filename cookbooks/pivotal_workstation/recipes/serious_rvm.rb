include_recipe "pivotal_workstation::rvm"

raise "to use this recipe, you must define a mapping in your json of ruby => rvm ruby version and/or jruby => rvm ruby version" unless node[:serious_rvm]

ruby_type_to_symlink_info = {
  "ruby" => [
    {:symlink_name => "ruby", :rvm_prefix => ""},
    {:symlink_name => "gem", :rvm_prefix => "gem-"},
    {:symlink_name => "irb", :rvm_prefix => "irb-"},
    {:symlink_name => "rake", :rvm_prefix => "rake-"},
    {:symlink_name => "ri", :rvm_prefix => "ri-"},
    {:symlink_name => "rdoc", :rvm_prefix => "rdoc-"},
    {:symlink_name => "erb", :rvm_prefix => "erb-"}
  ],
  "jruby" => [
    {:symlink_name => "jruby", :rvm_prefix => ""},
    {:symlink_name => "jgem", :rvm_prefix => "gem-"},
    {:symlink_name => "jirb", :rvm_prefix => "irb-"},
    {:symlink_name => "jrake", :rvm_prefix => "rake-"},
    {:symlink_name => "jri", :rvm_prefix => "ri-"},
    {:symlink_name => "jrdoc", :rvm_prefix => "rdoc-"},
    {:symlink_name => "jerb", :rvm_prefix => "erb-"}
  ]
}


["ruby", "jruby"].each do |ruby_type|
  if node[:serious_rvm]["rubies"][ruby_type]
    rvm_ruby_version_to_symlink_to = node[:serious_rvm]["rubies"][ruby_type]
    
    ruby_type_to_symlink_info[ruby_type].each do |link_info|
      
      from_rvm_file = "#{::RVM_HOME}/bin/#{link_info[:rvm_prefix]}#{rvm_ruby_version_to_symlink_to}"
      
      #this is a classic case were you have to have the chef run model in your head
      #if you just did a File.exists? on this outside this block, 
      #you'd cause chef to fail before the included rvm install had a chance to run.
      execute "check for #{from_rvm_file} (fail if it doesn't exist)" do
        command "file #{from_rvm_file}"
      end
      
      (node[:serious_rvm]["target_paths"] || ["/usr/local/bin"]).each do |target_path|
        to_file = File.join(target_path, link_info[:symlink_name])

        link to_file do
          to from_rvm_file
          owner WS_USER
        end
      end
      
    end
  end
end