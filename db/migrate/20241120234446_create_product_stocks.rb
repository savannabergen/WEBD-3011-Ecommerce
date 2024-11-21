class CreateProductStocks < ActiveRecord::Migration[7.2]
  def change
    create_table :product_stocks do |t|
      t.timestamps
    end
  end
end
