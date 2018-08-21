class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.string :image
      t.string :slug
      t.boolean :published, default: false
      t.timestamps
    end

    add_index :articles, :slug
  end
end
