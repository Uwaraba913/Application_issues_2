class BooksController < ApplicationController
  before_action :check_user, only: [:edit, :update, :destroy]

  def show
    @book = Book.find(params[:id])
    @new_book = Book.new
    impressionist(@book, nil, unique: [:ip_address])
    @book_comment = BookComment.new
  end

  def index
    if params[:latest]
      @books = Book.latest
    elsif params[:high_rate]
      @books = Book.high_rate
    else
      @books = Book.includes(:favorites).sort {|a,b| b.favorites.size <=> a.favorites.size}
    end
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end



  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.delete
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :category, :rate)
  end

  def check_user
    unless Book.find(params[:id]).user == current_user
    redirect_to books_path
    end
  end

end
