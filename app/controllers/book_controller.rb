class BookController < ApplicationController
  def list
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new #Empty book entry. What's the need??
    @subjects = Subject.all
  end


  def create
    # Create a new book entry with parameters
    @book = Book.new(book_params)

    if @book.save #Check successfull book entry

      #Check redirect and render functionality
      redirect_to :action => 'list'
    else
      @subjects = Subject.all
      render :action => 'new'
    end
  end

  def book_params
    # Require necessitates availability of key in params
    # permit copies over the keys white listed from the params object
    # Question: What will be under the :books key here??
    params.require(:books).permit(:title, :price, :subject_id, :description)
  end


  def edit
    @book = Book.find(params[:id])
    @subjects = Subject.all
  end


  def update
    @book = Book.find(params[:id])

    if @book.update_attributes(book_param)
      redirect_to :action => 'show', :id => @book
    else
      @subjects = Subject.all
      render :action => 'edit'
    end
  end

  def book_param
   params.require(:book).permit(:title, :price, :subject_id, :description)
  end


  def delete
    Book.find(params[:id]).destroy
    redirect_to :action => list
  end

  def show_subjects
   @subjects = Subject.all
  end
end
