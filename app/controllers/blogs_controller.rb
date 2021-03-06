class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :need_admin, except: [:show, :update]
  before_action :need_moderator, only: [:show, :update, :edit]

  def need_admin
    redirect_to '/' unless current_user.is_admin?
  end

  def need_moderator
    redirect_to '/' unless current_user.has_role? :moderator, @blog.camp
  end

  # GET /blogs
  # GET /blogs.json
  def index
    @blogs = Blog.all.includes(:camp)
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
    @blogs_url = "http://blog.jabby.fr/"
    @posts = @blog.posts
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
    @camp_list = Camp.all.map{|c| [c.name, c.id]}
  end

  # GET /blogs/1/edit
  def edit
    @camp_list = Camp.all.map{|c| [c.name, c.id]}
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = Blog.new(blog_params)

    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: 'Blog was successfully created.' }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: 'Blog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.where(id: params[:id]).includes({:posts =>:images}).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:url, :content, :name, :camp_id)
    end
end
