class Entity < ActiveRecord::Base
  attr_accessible :name, :entity_type

  def to_s
    "#{name} (#{entity_type})"
  end
end
