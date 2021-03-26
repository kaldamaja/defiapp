class HeartsController < ApplicationController

		before_action :authenticate_user!


	def save_heart
		@heart = Heart.new(comment_id: params[:comment_id], user_id: current_user.id)
		@comment_id = params[:comment_id]
		existing_heart = Heart.where(comment_id: params[:comment_id], user_id: current_user.id)


		respond_to do |format|
			format.js {
				if existing_heart.exists?
				# like already exists for post by this user
				existing_heart.first.destroy
					@success = false
				elsif @heart.save
					@success = true
				else
					@success = false
				end


				@comment_hearts = Comment.find(@comment_id).hearts.size
				render "comments/heart"
			}
		end
	end


end
