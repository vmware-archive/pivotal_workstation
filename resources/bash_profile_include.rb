actions :create

attribute :name, :kind_of => String, :name_attribute => true


def initialize(name, run_context=nil)
  super
  @action = :create
end
