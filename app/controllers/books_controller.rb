class BooksController < ApplicationController

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      flash.now[:alert] = "Failed to created book."
      render :index
    end
  end

  def show
    @book = Book.find(params[:id])
    @user = @book
    @user = @book.user
  end

  def edit
    is_matching_login_user
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      flash.now[:alert] = "Failed to updated book."
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def is_matching_login_user
    book = Book.find(params[:id])
    user = book.user
    unless user == current_user
      redirect_to books_path
    end
  end  
end
