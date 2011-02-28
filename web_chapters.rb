require "erb"
require "rubygems"
require "sinatra"
require "./simple_dbc.rb"

dbc = SimpleDBC.new("127.0.0.1")

get "/" do
  @books = dbc.books
  erb :index
end

get "/books/:id" do
  @book = dbc.book(params[:id])
  erb :book
end

get "/books/:bid/chapters/:id" do
  @book = dbc.book(params[:bid])
  @chapter = dbc.chapter(params[:id])
  erb :chapter
end
