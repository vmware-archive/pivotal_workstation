actions :set

attribute :name,  :kind_of => String, :name_attribute => true
attribute :value, :kind_of => String

def initialize(name, run_context=nil)
  super
  @action = :set
end
