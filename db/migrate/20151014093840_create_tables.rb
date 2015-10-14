class CreateTables < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string   :name
      t.string   :email
      t.datetime :created_at
    end

    create_table :lists do |t|
      t.integer  :user_id
      t.string   :name
      t.datetime :created_at
    end

    create_table :items do |t|
      t.integer  :list_id
      t.string   :name
      t.datetime :created_at
      t.datetime :due_at
      t.datetime :completed_at
    end
  end
end
