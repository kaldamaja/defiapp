class Heart < ApplicationRecord
	belongs_to :comment, counter_cache: true
	belongs_to :user

	validates_uniqueness_of :comment_id, scope: :user_id

	private


end
