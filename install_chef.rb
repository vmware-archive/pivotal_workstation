#!/usr/bin/ruby

#assume that we're in the project directory
require "fileutils"

raise "don't run this using sudo" if ENV["USER"] == "root"

module Kernel
  def system!(cmd)
    system(cmd) || raise("FAILED: #{cmd}")
  end
end

system!("sudo sh -c 'gem update --system && gem install bundler -v 0.9.26 --no-rdoc --no-ri'")

FileUtils.mkdir_p("vendor/bundle")
system!("bundle install vendor/bundle")
