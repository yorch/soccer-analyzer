class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :source
      t.string :original_id
      t.datetime :date
      t.string :url
      t.string :title
      t.text :content
      t.hstore :data
      t.hstore :extra_data

      t.timestamps
    end
    add_index :articles, :original_id
    add_hstore_index :articles, :data
  end
end
