require 'fileutils'
class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :toggle_active, :delete_img]
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
    @cta = "Créer"
    @url = "/blogs/#{@blog.id}/posts"
    @placeholder_date = DateTime.now().strftime("%m-%d")
  end

  # GET /blogs/:blog_id/posts/1/edit
  def edit
    @url = "/blogs/#{@blog.id}/posts/#{@post.id}"
    @cta = "Sauver"
  end

  # POST /blogs/:blog_id/posts
  # POST /blogs/:blog_id/posts.json
  def create
    url = post_params[:date].gsub(' ', '')
    @post = Post.new(post_params.merge({blog_id: @blog.id, views: 0, active: false, ordre: @blog.posts.count, url: url}))

    respond_to do |format|
      if @post.save
        save_images(params)
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
    url = post_params[:date].gsub(' ', '')

    respond_to do |format|
      save_images(params)
      if @post.update(post_params.merge( {active: false, url: url } ) )
        format.html { redirect_to blog_path(@blog), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def save_images(params)
    return if params[:post][:images].nil?
    FileUtils.mkpath(@post.path) unless File.directory?(@post.path)
    params[:post][:images].each do |file|
      File.open("./app/assets/images/posts/#{@post.id}/#{file.original_filename}", "wb") do |f|
        f.write(file.tempfile.read)
      end
      img = Image.create(
        file: file.original_filename,
        post_id: @post.id
      )
      end
  end

  def delete_img
    Image.where(id: params[:img_id]).destroy_all
    render json: {}
  end


  # DELETE /blogs/:blog_id/posts/1
  # DELETE /blogs/:blog_id/posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to blog_path(@blog), notice: 'Post was successfully destroyed.' }
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
      params.require(:post).permit(:url, :content, :active, :title, :date, :ordre, :images, :blog_id)
    end
end
