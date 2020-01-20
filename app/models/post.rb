# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  validates_presence_of :content, length: { maximum: 140, minimum: 10 }
end
