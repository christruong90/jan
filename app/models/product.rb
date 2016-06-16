class Product < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :price, presence: true
  validates :sale_price, presence: true, numericality: {less_than_or_equal_to: :price}

  has_many :reviews, dependent: :destroy

  def on_sale?
    if :sale_price < :price
      true
    else
      return false
    end
  end

end
