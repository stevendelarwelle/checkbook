class Ledger < ActiveRecord::Base

	belongs_to :user
	validates :user_id ,presence: true
	validates :description, presence: true
	validates :amount, presence: true,  numericality: true
end
