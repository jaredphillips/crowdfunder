class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :projects
  has_many :pledges

  attr_accessor :password, :password_confirmation

  validates :first_name, presence: true
end
