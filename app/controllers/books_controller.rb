class BooksController < ApplicationController
  def index
    @books = Book.all
    @book = Book.first

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @books }
    end
  end

  def show
    @book = Book.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @book }
    end
  end

  def new
    @book = Book.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @book }
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def lookup
    uri_string = "http://www.amazon.com/s/ref=nb_sb_noss?url=search-alias%3Dstripbooks&field-keywords=#{params[:title]}&x=20&y=18"
    
    require "net/http"
    require "uri"
    uri = URI.parse(uri_string)
    response = Net::HTTP.get_response(uri)
    response_tree = Nokogiri::HTML(response.body)
    results = response_tree.css "#atfResults"
    puts results
    
    
    render :text => results.to_s
  end
  
  def create
    @book = Book.new(params[:book])

    respond_to do |format|
      if @book.save
        format.html { redirect_to :books, notice: 'Book was successfully created.' }
        format.json { render json: @book, status: :created, location: @book }
      else
        format.html { render action: "new" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @book = Book.find(params[:id])

    respond_to do |format|
      if @book.update_attributes(params[:book])
        format.html { redirect_to books_url, notice: 'Book was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url }
      format.json { head :ok }
    end
  end
end