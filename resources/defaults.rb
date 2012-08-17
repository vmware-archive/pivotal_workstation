=begin

A resource/provider to call to MacOS's plist 'defaults' command line tool.

Syntax:

pivotal_workstation_defaults "set key repeat rate" do
  domain "/Users/#{WS_USER}/Library/Preferences/.GlobalPreferences"
  key "KeyRepeat"
  integer 2
end

Supports the attribute types below.

TODO List:

* Remaining params that need to be supported:
  -data <hex_digits>
  -date <date_rep>
  -array <value1> <value2> ...
  -array-add <value1> <value2> ...
  -dict <key1> <value1> <key2> <value2> ...
  -dict-add <key1> <value1> ..
* Should support notifies
* Should support overrides of not_if with a more complex block

=end

actions :write

attribute :description, :kind_of => String, :name_attribute => true
attribute :domain, :kind_of => String, :default => nil
attribute :key, :kind_of => String, :default => nil

attribute :integer, :kind_of => Integer, :default => nil
attribute :string, :kind_of => String, :default => nil
attribute :boolean, :kind_of => [ TrueClass, FalseClass ], :default => nil
attribute :float, :kind_of => [Float, Integer], :default => nil
attribute :array, :kind_of => [Array, String, Integer], :defaults => nil

def initialize(name, run_context=nil)
  super
  @action = :write
end
