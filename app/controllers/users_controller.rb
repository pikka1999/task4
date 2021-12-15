class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :correct_user,only: [:edit]

  def correct_user
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end


  def index
    @user = current_user
    @users= User.all
    @book = Book.new
    @book.user_id = current_user.id
  end

  def show
    @user = User.find(params[:id])
    @books = Book.where(user_id: @user.id)
    @book= Book.new
  end
  def edit
    @user = User.find(params[:id])

  end
  def update
    @user = User.find(params[:id])
     if @user.update(user_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to user_path(@user.id)
     else
      render :edit
     end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction ,:profile_image)
  end
end
