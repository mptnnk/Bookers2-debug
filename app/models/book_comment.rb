class BookComment < ApplicationRecord
  belongs_to :user
  belongs_to :book_params
  
  validates :comment, presence: true
end
