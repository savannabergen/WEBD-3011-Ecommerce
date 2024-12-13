class Product < ApplicationRecord
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_limit: [ 50, 50 ]
    attachable.variant :medium, resize_to_limit: [ 250, 250 ]
  end

  has_many :order_products, dependent: :destroy
  has_many :stocks, dependent: :destroy
  belongs_to :category

  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 10, maximum: 500 }
end
