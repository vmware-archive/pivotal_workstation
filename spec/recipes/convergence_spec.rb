require 'spec_helper'

describe "Recipes" do
  let(:fusion) { FusionHelper.new }
  let(:vm) { Lobot::Sobo.new("192.168.116.128", '~/.ssh/id_apple_orchard', 'ci') }

  before do
    fusion.revert_to('soloist')
    Godot.new("192.168.116.128", 22, :interval => 60).wait!
  end

  Dir.chdir(File.expand_path("../../../recipes", __FILE__))
  Dir["*"].map{ |d| d.chomp('.rb') }.each do |recipe|
    it "the #{recipe} recipe converges when run by itself" do
      cookbook_path = File.expand_path("../../..", __FILE__)
      vm.upload(cookbook_path, 'cookbooks/')
      vm.system!('cd cookbooks; git clone https://github.com/opscode-cookbooks/dmg')
      vm.system!('( gem list | grep "soloist " ) || sudo gem install soloist')
      vm.system!('printf "cookbook_paths:\n- cookbooks/\n" > soloistrc')
      vm.system!("soloist pivotal_workstation::#{recipe}")
    end
  end
end