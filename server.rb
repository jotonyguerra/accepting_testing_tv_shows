require 'sinatra'
require 'sinatra/flash'
require 'pry'
require 'csv'
require_relative "app/models/television_show"
enable :sessions

set :bind, '0.0.0.0'  # bind to all interfaces
set :views, File.join(File.dirname(__FILE__), "app/views")

def alread_exist?
  tv = CSV.read('television-shows.csv', headers: true)
  tv.each do |show|
    if show[0] == @title
      return true
    end
  end
  return false
end

get '/' do
  redirect "/television_shows"
  erb :index
end

get '/television_shows' do
  @tv = CSV.read('television-shows.csv', headers: true)
  erb :index
end

get '/television_shows/new' do
  @tv = CSV.read('television-shows.csv', headers: true)
  erb :index
end

post '/television_shows' do
  @title = params["Title"]
  @network = params["Network"]
  @starting_year = params["Starting Year"]
  @synopsis = params["Synopsis"]
  @genre = params["Genre"]
  #could create methods for this
  if @title == ""
    flash[:error]="Please fill in all required fields"
    redirect '/television_shows'
  elsif @network == ""
    flash[:error]="Please fill in all required fields"
    redirect '/television_shows'
  elsif @starting_year == ""
    flash[:error]="Please fill in all required fields"
    redirect '/television_shows'
  elsif @synopsis == ""
    flash[:error]="Please fill in all required fields"
    redirect '/television_shows'
  elsif alread_exist?
    flash[:error]="That shows already added"
    redirect '/television_shows'
  else
    CSV.open('television-shows.csv', 'a') do |show|
      show << [@title,@network,@starting_year,@synopsis,@genre]
    end
    redirect '/television_shows'
  end
  erb :index
end
