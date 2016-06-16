class Review < ActiveRecord::Base
  belongs_to :product

    validates :star_count, presence: true, inclusion: {in: 1..5, message: "product must be rated from 1 to 5"}
    validates :body, presence: true 

end
