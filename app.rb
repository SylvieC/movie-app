
require "sinatra"
require "sinatra/reloader"
require 'typhoeus'
require 'json'
require 'pry'


get '/' do
  @page_title = "Movies Searcher"
  erb :index
end


post '/result' do
  @page_title = "Movie Results"
 search_str = params[:movie]
 response = Typhoeus.get("www.omdbapi.com/", :params => {:s => search_str})
 result = JSON.parse(response.body)
 @sorted_by_year = result["Search"].sort_by{ |movie_hash| movie_hash["Year"]}
 erb :result
end


get '/result/:imdb' do |imdb_id|
  @page_title = "Movie Poster"
  id = params[:imdb]
  answer = Typhoeus.get("www.omdbapi.com/", :params => {:i => id})
  @result = JSON.parse(answer.body)
 
  erb :poster
end



