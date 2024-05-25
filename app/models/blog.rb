# app/models/blog.rb
class Blog < ApplicationRecord
    validates :title, presence: true
    validates :body, presence: true
  end
  