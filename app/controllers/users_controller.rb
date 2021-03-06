class UsersController < ApplicationController
  include Common
  before_action :set_search_window
  before_action :ensure_correct_user, only: [:update, :edit]

  def show
    @user = User.find(params[:id])
    #ページネーション追加
    @books = @user.books.page(params[:page])
    @book = Book.new
    #投稿数関連のデータ取得
    @post_books_cnt = User.find(params[:id]).post_books_count
    # binding.pry
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :title)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
