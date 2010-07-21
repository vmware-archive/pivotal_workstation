## Recipies in later entries in the cookbook array override earlier entries 
cookbooks  = [File.expand_path("cookbooks")]
cookbooks << File.expand_path("cookbook_links/project_cookbook") if File.exists?("cookbook_links/project_cookbook")
cookbooks << File.expand_path("cookbook_links/workstation_cookbook") if File.exists?("cookbook_links/workstation_cookbook")
cookbook_path cookbooks