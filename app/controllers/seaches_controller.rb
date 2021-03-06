class SeachesController < ApplicationController
  def search
    @model = params["model"]
    @content = params["content"]
    @method = params["method"]
    @records = seach_for(@model, @content, @method)
  end

  private

  def seach_for(model, content, method)
    if model == 'user'
      if method == 'perfect'
        User.where(name: content)
      elsif method == 'partial'
        User.where('name LIKE?', '%'+content+'%')
      elsif method == 'forward'
        User.where('name LIKE?', content+'%')
      else
        User.where('name LIKE?', '%'+content)
      end
    elsif model == 'book'
      if method == 'perfect'
        Book.where(title: content)
      elsif method == 'partial'
        Book.where('title LIKE ?', '%'+content+'%')
      elsif method == 'forward'
        Book.where('title LIKE ?', content+'%')
      else
        Book.where('title LIKE ?', '%'+content)
      end
    elsif model == 'category'
      if method == 'perfect'
        Book.where(category: content)
      elsif method == 'partial'
        Book.where('category LIKE ?', '%'+content+'%')
      elsif method == 'forward'
        Book.where('category LIKE ?', content+'%')
      else
        Book.where('category LIKE ?', '%'+content)
      end
    end
  end
end
