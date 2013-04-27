class EntitiesTypeRenamedToEntityType < ActiveRecord::Migration
  def up
    rename_column :entities, :type, :entity_type
  end

  def down
    rename_column :entities, :entity_type, :type
  end
end
