class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :year
      t.string :rated
      t.string :genre
      t.string :write
      t.string :actors
      t.string :awards
      t.string :runtime
      t.string :plot
      t.string :poster
      t.string :ratings
      t.integer :user_id

      t.timestamps
    end
  end
end
