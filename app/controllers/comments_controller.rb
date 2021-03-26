class CommentsController < ApplicationController
	before_action :set_post
	before_action :authenticate_user!


  def create
  	@comment = @post.comments.new(comment_params)
  	@comment.user = current_user
    @comment.save

  end

  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(parent_id: params[:parent_id])
  end

  def destroy
  	@comment = @post.comments.find(params[:id])

    if @comment.user_id == current_user.id || @post.user == current_user
    	@comment.destroy
    else
        flash[:notice] = 'Viga! Antud kommentaar ei ole Teie loodud!'
        redirect_to post_path(@post)
    end

  end


  private
  def comment_params
  	params.require(:comment).permit(:body, :post_id, :parent_id)
  end

  def set_post
  	@post = Post.find(params[:post_id])
  end
end
