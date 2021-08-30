class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @comment = BookComment.new(book_comment_params)
    @comment.user_id = current_user.id
    @comment.book_id = @book.id
    @book_comment = BookComment.new
    if @comment.save
      render :comment
    else
      render request.referer
    end
  end

  def destroy
    @book_comment = BookComment.find(params[:id])
    if @book_comment.user != current_user
      render request.referer
    else
      @book_comment.destroy
      @book = Book.find(params[:book_id])
      render :comment
    end
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
