class BooksController < ApplicationController
    before_action :authenticate_user!
    before_action :correct_book,only: [:edit]

  def correct_book
    @book = Book.find(params[:id])
    unless @book.user.id == current_user.id
      redirect_to books_path
    end
  end


  def new
    @book=Book.new
  end

  def create
    @book=Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      @user = current_user
      @books=Book.all
      render :index
    end
  end

  def edit
    @book=Book.find(params[:id])
  end

  def index
    @book=Book.new
    @books=Book.all
    @user= current_user
  end

  def show
    @book=Book.find(params[:id])
    @books = Book.all
    @user= @book.user
    @book_comment = BookComment.new
    @book_comments = @book.book_comments
  end

  def update
    @book=Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book=Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

    def book_params
      params.require(:book).permit(:title,:body)
    end
end
