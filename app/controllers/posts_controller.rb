class PostsController < ApplicationController
    before_action :authenticate_trainer!
    before_action :ensure_correct_trainer, only: [:edit, :update, :destroy]

  def show
    @post = Post.find(params[:id])
    # @user = Trainer.find_by(id: @post.trainer_id)
  end

  def index
    @posts = Post.all
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.trainer_id = current_trainer.id
    if @post.save
      redirect_to posts_path(@post), notice: "You have created book successfully."
    else
      @posts = Post.all
      render 'index'
    end
  end

  def edit
    @post = Post.find(params[:id])
    @trainer = trainer.new
    if @post.trainer.id != current_trainer.id
      redirect_to post_path
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @post.destroy
    redirect_to post_path
  end
  
   def search
    maps = Map.where(latitude: params[:lat]).where(longitude: params[:lng])
    @marker_arr =[]
    maps.each do |map|
            #pushメソッドは配列に値を入れるメソッド
      @marker_arr.push(map.post)
    end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def ensure_correct_trainer
    @post = Post.find(params[:id])
    unless @post.trainer == current_trainer
      redirect_to posts_path
    end
  end

  # def ensure_correct_trainer
  # @post = Post.find_by(id: params[:id])
  # if @post.user_id != @current_user.id
  # flash[:notice] = "権限がありません"
  # redirect_to("/posts/index")
  # end
  # end
end
