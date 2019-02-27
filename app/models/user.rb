class User < ApplicationRecord
	has_many :blogs
	has_many :articles
	has_many :comments
	validates :name, presence: true
end
