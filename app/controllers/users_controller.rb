class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
    @book_new = Book.new
    @books = @user.books
  end

  def index
    @user = current_user
    @users = User.all
    @book_new = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have updated user successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def update
    @user = user.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def is_matching_login_user
    user_id = params[:id].to_i
    unless user_id == current_user.id
      redirect_to books_path
    end
  end

end
