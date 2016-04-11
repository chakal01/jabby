class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :toggle_active]
  before_action :set_blog

  # GET /blogs/:blog_id//posts
  # GET /blogs/:blog_id//posts.json
  def index
    @posts = Post.all
  end

  # GET /blogs/:blog_id/posts/:id/toggle_active
  def toggle_active
    @post.update_attributes({active: !@post.active});
    render json: {} 
  end

  # GET /blogs/:blog_id/posts/1
  # GET /blogs/:blog_id/posts/1.json
  def show
  end

  # GET /blogs/:blog_id/posts/new
  def new
    @post = Post.new
    @placeholder_date = DateTime.now().strftime("%m-%d")
  end

  # GET /blogs/:blog_id/posts/1/edit
  def edit
  end

  # POST /blogs/:blog_id/posts
  # POST /blogs/:blog_id/posts.json
  def create
    url = post_params[:date].gsub(' ', '')
    @post = Post.new(post_params.merge({blog_id: @blog.id, views: 0, active: false, ordre: @blog.posts.count, url: url}))

    respond_to do |format|
      if @post.save
        format.html { redirect_to blog_path(@blog), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/:blog_id/posts/1
  # PATCH/PUT /blogs/:blog_id/posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/:blog_id/posts/1
  # DELETE /blogs/:blog_id/posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def set_blog
      @blog = Blog.find(params[:blog_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:url, :content, :active, :title, :date, :ordre, :blog_id)
    end
end
