actions :install

attribute :source, :kind_of => String
attribute :destination, :kind_of => String
attribute :owner, :kind_of => String

def initialize(name, run_context=nil)
  super
  @action = :install
end
