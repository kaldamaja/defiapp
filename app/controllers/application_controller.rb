class ApplicationController < ActionController::Base
 before_action :configure_permitted_parameters, if: :devise_controller?
 before_action :set_last_seen_at, if: -> { user_signed_in? && (current_user.last_seen_at.nil? || current_user.last_seen_at < 5.minutes.ago) }
 before_action :top_post_today
 before_action :promoted_post


protected

  # Tänase päeva 1 top postitus widgetis.
	def top_post_today
	@top_post = Post.includes(image_attachment: :blob).joins("LEFT OUTER JOIN Likes ON likes.post_id = posts.id 
                     AND likes.created_at BETWEEN '#{DateTime.now.beginning_of_day}' AND '#{DateTime.now.end_of_day}'")
                    .group("posts.id").order("COUNT(likes.id) DESC").limit(1)
	end

  # Promoted postitused widgetis.
  def promoted_post
  @promoted_post = Post.includes(image_attachment: :blob).where(sticky: true).limit(2)
  end



    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password])
      devise_parameter_sanitizer.permit(:account_update, keys: [:username, :avatar, :bio])
    end

    def set_last_seen_at
    	current_user.touch(:last_seen_at)
    end

end
