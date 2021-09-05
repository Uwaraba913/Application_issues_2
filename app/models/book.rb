class Book < ApplicationRecord
	belongs_to :user
	has_many :book_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	is_impressionable counter_cache: true

	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
	validates :category, presence: true, length: {maximum: 20}

	validates :rate, numericality: {
		less_than_or_equal_to: 5,
		greater_than_or_equal_to: 1}, presence: true

	scope :latest, -> {order(created_at: :desc)}
	scope :high_rate, -> {order(rate: :desc)}

	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end

end
