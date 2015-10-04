ActiveRecord::Schema.define(version: 0) do

  create_table :tests, force: true do |t|
    t.string :name
    t.text :data
  end

end
