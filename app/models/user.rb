class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :projects
  has_many :pledges
  has_many :images, through: :projects
  attr_accessor :password, :password_confirmation

  validates :first_name, presence: true
end
