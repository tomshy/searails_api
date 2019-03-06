# frozen_string_literal: true

class Blog < ApplicationRecord
  belongs_to :user
  has_many :articles
  validates :name, presence: true
end
