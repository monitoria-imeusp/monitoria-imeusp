class AddOrderToAdvises < ActiveRecord::Migration
  def up
    add_column :advises, :order, :integer
    i = 0
    Advise.all.each do |advise|
      advise.order = i
      advise.save
      i += 1
    end
  end
  def down
    change_table :advises do |t|
      t.remove :order
    end
  end
end
