class Task < ApplicationRecord
  validates :name, length: { minimum: 3 }
  validates :description, length: { minimum: 7 }
  belongs_to :user
  enum :importance => [:high, :middle, :low]
end
