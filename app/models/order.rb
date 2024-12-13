class Order < ApplicationRecord
  has_many :order_products

  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
