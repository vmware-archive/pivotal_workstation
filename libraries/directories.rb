class Chef::Recipe
  # Chef has a bug (http://tickets.opscode.com/browse/CHEF-1327)
  # When the "directory" command is used with "recursive = true",
  # only the deepest directory obtains the ownership specified
  # by the block.  For example,
  #   directory "a/b/c" do
  #     owner "foo"
  #     recursive true
  #   end
  # creates directories "a" and "a/b" owned by root, and "a/b/c"
  # owned by "foo".
  # To avoid this, the following command takes a
  # list of implicitly nested directories, and creates each one
  # individually.  For example,
  #   recursive_directories ['a', 'b', 'c'] do
  #     owner "foo"
  #   end
  # Will create the directories "a", "a/b" and "a/b/c", each
  # owned by "foo".
  def recursive_directories(dirs, &block)
    dirs.each_index do |i|
      directory(File.join(dirs[0..i]), &block)
    end
  end
end
