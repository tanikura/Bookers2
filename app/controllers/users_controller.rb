class UsersController < ApplicationController

  before_action :ensure_current_user, only: [:edit, :update]

  def ensure_current_user
    if current_user.id != params[:id].to_i
      redirect_to user_path(current_user.id)
    end
  end


  def show
    @user = User.find(params[:id])
    @book_new = Book.new
    @books = @user.books
  end

  def index
    @user = current_user
    @users = User.all
    @book = Book.new
    @books = Book.all

  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to user_path(current_user.id)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def update
    @user = User.find(params[:id])
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

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end

end
