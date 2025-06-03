class CreateMotivationalQuotes < ActiveRecord::Migration[8.0]
  def change
    create_table :motivational_quotes do |t|
      t.string :content

      t.timestamps
    end
  end
end
