class ApplicationController < ActionController::Base
 before_action :configure_permitted_parameters, if: :devise_controller?
 before_action :set_last_seen_at, if: -> { user_signed_in? && (current_user.last_seen_at.nil? || current_user.last_seen_at < 5.minutes.ago) }
 before_action :top_post_today


protected

  # Tänase päeva 2 top postitust, mis näitab side-menüüs.
	def top_post_today
	@top_post = Post.includes(image_attachment: :blob).where("created_at >= ?", 1.day.ago).order("likes_count DESC").limit(1)
	end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password])
      devise_parameter_sanitizer.permit(:account_update, keys: [:username, :avatar, :bio])
    end

    def set_last_seen_at
    	current_user.touch(:last_seen_at)
    end


end
