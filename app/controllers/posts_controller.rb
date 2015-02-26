class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @post_attachments = @post.post_attachments
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
     if @post.save
        params[:images].each do |image|
        @post_attachment = @post.post_attachments.create!(:avatar => image, :post_id => @post.id)
      end
    redirect_to(@post, notice: 'Post was successfully created.')
     else
        render 'new'
     end
  end

  def destroy
    @post = Post.find params[:id]
    @post.destroy
    redirect_to posts_url
  end

  def update
      if @post.update_attributes post_params
        redirect_to(@post, notice: 'Post was successfully updated.')
      else
        render :edit
      end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end
    
    def post_params
       params.require(:post).permit(:title)
    end
  end
