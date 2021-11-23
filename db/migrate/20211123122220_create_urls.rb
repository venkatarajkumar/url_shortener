class CreateUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :urls do |t|
      t.string :url_name
      t.string :long_url
      t.string :short_url

      t.timestamps
    end
  end
end
