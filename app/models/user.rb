# frozen_string_literal: true

class User < ApplicationRecord
  has_many :blogs
  has_many :articles
  has_many :comments
  validates :name, :password, :username, presence: true
end
