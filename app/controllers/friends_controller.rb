class FriendsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index # GET /friends or root
    if user_signed_in?
      @friends = current_user.friends
    else
      @friends = nil
    end
  end

  def show
    @friend = Friend.find(params[:id])
  end

  def new
   @friend = current_user.friends.build
  end

  def create
    @friend = current_user.friends.build(friend_params)
    if @friend.save
      redirect_to @friend
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @friend = Friend.find(params[:id])
  end

  def update
    @friend = Friend.find(params[:id])

    if @friend.update(friend_params)
      redirect_to @friend
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @friend = Friend.find(params[:id])
    @friend.destroy

    redirect_to friends_path
  end

  def correct_user
    @friends = current_user.friends.find_by(id: params[:id])
    redirect_to friends_path, notice: "Not Authorized To Edit Friend" if @friends.nil?
  end

  private
    def friend_params
      params.require(:friend).permit(:first_name, :last_name, :email, :phone, :twitter_handle, :user_id)
    end
end
