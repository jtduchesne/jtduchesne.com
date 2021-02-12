class Admin::PostsController < Admin::ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  layout 'application'

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.includes(:tags).all.reverse_order
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to url_for(action: 'show', id: @post), notice: f(@post) }
        format.json { render :show, status: :created, location: url_for(action: 'show', id: @post) }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to url_for(action: 'show', id: @post), notice: f(@post) }
        format.json { render :show, status: :ok, location: url_for(action: 'show', id: @post) }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to url_for(action: 'index'), notice: f(@post) }
      format.json { head :no_content }
    end
  end

private
  def set_post
    @post = Post.find(params[:id])
  end
  
  def post_params
    params.require(:post).permit(:slug, :language, :translated, :title, :preview, :published_on, :tag_names, :content)
  end
end
