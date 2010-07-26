Core Goals
==========

- Decomposed / modular - As much as is possible / makes sense, you should be able to pick and choose and mix and match recipes.
- Unobtrusive - Should play nicely with the rest of the box, and not prevent things outside of workstation chef from working.
- Reusable - Recipes can be developed within a project and then pushed up into workstation chef when they are useful to others.
- Documentation - A workstation should not become a collection of magic bits, it should be hardware which can be swapped out with insignificant interruption in work.


Chef Theory
===========

Chef is declarative - You don't run a configuration script which repeats the same steps, you run a command that brings your machine up to the configuration specified.  This approximates "rake db:migrate" - take me from where I am to the current schema.

Usage
=====

Before Getting Started:
-----------------------

Install Xcode from apple
Install git from google code: http://code.google.com/p/git-osx-installer/downloads/list?can=3


Getting Started(the simple way):
--------------------------------

> cd ~
> git clone http://github.com/pivotalexperimental/wschef.git
> cd wschef
> ruby install_chef.rb
> cp all.json to workstation.json
> edit workstation.json (by default it will install everything. This probably isn't what you want)
> edit cookbooks/workstation/attributes
> ./run

Getting started(the right way):
-------------------------------

> cd ~
> git clone http://github.com/pivotalexperimental/wschef.git
> cd wschef
> ruby install_chef.rb
> cd YOUR_PROJECT_DIR (or anywhere else that's version controlled)
> mkdir -p chef/pivotal_workstation/recipes
> create and edit chef/pivotal_workstation/recipes/linked_project_recipe.rb 
> (see a sample project cookbook here: http://github.com/mkocher/project_cookbook)
> ln -s YOUR_PROJECT_DIR/chef   ~/wschef/cookbook_links/project_cookbook
> cd ~/wschef
> ./run