class CreateArticleEntities < ActiveRecord::Migration
  def change
    create_table :article_entities do |t|
      t.references :article
      t.references :entity
      t.float :sentiment

      t.timestamps
    end
    add_index :article_entities, :article_id
    add_index :article_entities, :entity_id
  end
end
