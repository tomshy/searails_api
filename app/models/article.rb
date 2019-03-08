# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :blog
  has_many :comments
  validates :title, :body, presence: true, allow_blank: false
end
