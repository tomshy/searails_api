class Article < ApplicationRecord
	belongs_to :blog
	has_many :comments
	validates :title, :body, presence: true
end
