class Post < ApplicationRecord
  validates :title, presence: true , length: {maximum: 40}

  has_rich_text :content
  belongs_to :user

  has_many :comments

  enum genre: { worry: 0, skill: 1, foreign: 2 }
end
