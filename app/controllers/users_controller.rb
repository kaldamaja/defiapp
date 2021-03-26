class UsersController < ApplicationController
  def index

  end

  
  def show
  	@user = User.find(params[:id])

  	@posts = @user.posts.order('created_at desc').paginate(page: params[:page], per_page: 1)
    @posts = @posts.includes(:comments, :likes)
    @posts = @posts.includes(image_attachment: :blob)

  	@rel = @user.followers.find_by(follower: current_user)
  end

  def followers
  end

  def top
    @users = User.includes(:posts, avatar_attachment: :blob ).limit(10).sort_by { |p| p.received_likes}.reverse!
  end


end
