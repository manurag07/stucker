# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_presence_of :time_zone

  has_many :connections, dependent: :destroy
  has_many :posts, dependent: :destroy

  def twitter
    connections.where(provider: 'twitter').first
  end

  def facebook
    connections.where(provider: 'facebook').first
  end
end
