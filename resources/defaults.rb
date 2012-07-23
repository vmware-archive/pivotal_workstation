=begin
pivotal_workstation_defaults "set key repeat rate" do
  file "/Users/#{WS_USER}/Library/Preferences/.GlobalPreferences"
  key "KeyRepeat"
  integer 2
end
=end

actions :write

attribute :description, :kind_of => String, :name_attribute => true
attribute :plist, :kind_of => String, :default => nil
attribute :key, :kind_of => String, :default => nil
attribute :integer, :kind_of => Integer, :default => nil
attribute :string, :kind_of => String, :default => nil

def initialize(name, run_context=nil)
  super
  @action = :write
end