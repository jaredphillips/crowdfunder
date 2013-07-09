class Pledge < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  validates :user, :project, presence: true
  validates :amount,
  	presence: true,
  	numericality: true

  validate :validate_amount_greater_than_zero

  protected

  		def validate_amount_greater_than_zero
				if amount && amount < 0
					errors.add :amount, "must be greater than 0"
				end
			end
end
