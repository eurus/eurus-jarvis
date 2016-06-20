class AddContentHtmlToArtical < ActiveRecord::Migration
  def change
    add_column :articals, :content_html, :text
    remove_column :articals, :origin
  end
end
