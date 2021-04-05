class PostsController < ApplicationController
  before_action :set_post, only: [ :show, :edit, :update, :destroy ]
  before_action :authenticate_user!, except: [:index, :show, :hot, :top, :newposts, :search]
  before_action :post_omanik, only: [:edit, :update, :destroy]

  # GET /posts or /posts.json
  def index
    @posts = Post.top.includes(user: :avatar_attachment).paginate(page: params[:page], per_page: 4)
    @posts = @posts.includes(:comments, :likes)
    @posts = @posts.includes(image_attachment: :blob)


  end

  def hot
    @posts = Post.hot.includes(user: :avatar_attachment).paginate(page: params[:page], per_page: 4)
    @posts = @posts.hot.includes(:comments, :likes)
    @posts = @posts.hot.includes(image_attachment: :blob)
    render action: :index

  end

  def top
    @posts = Post.top.includes(user: :avatar_attachment).paginate(page: params[:page], per_page: 4)
    @posts = @posts.top.includes(:comments, :likes)
    @posts = @posts.top.includes(image_attachment: :blob)
    render action: :index
  end

  def newposts
    @posts = Post.newposts.includes(user: :avatar_attachment).paginate(page: params[:page], per_page: 4)
    @posts = @posts.newposts.includes(:comments, :likes)
    @posts = @posts.newposts.includes(image_attachment: :blob)
    render action: :index
  end

  def widget_top

  end

  # GET /posts/1 or /posts/1.json
  def show
    @comment = Comment.new
    @comments = if params[:comment]
                  @post.comments.where(id: params[:comment])
                else
                  @post.comments.where(parent_id: nil)
                end

    @comments = @comments.order('created_at asc').paginate(page: params[:page], per_page: 2)

  end


  def search

    @posts = Post.ransack(title_cont: params[:q]).result(distinct: true)
    
    respond_to do |format|
      format.html {}
      format.json {
        @posts = @posts.limit(7)
      }
    end
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  def hide_new_form

  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Postitus edukalt loodud!" }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def post_omanik
    @post = Post.find(params[:id])
      unless @post.user_id == current_user.id
        flash[:notice] = 'Viga! Antud postitus ei ole Teie loodud!'
      redirect_to posts_path
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Postitus edukalt uuendatud!" }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Postitus edukalt kustutatud!" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body, :image, :website)
    end
end
