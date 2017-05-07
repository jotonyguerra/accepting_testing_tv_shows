require 'sinatra'
require 'sinatra/flash'
require 'pry'
require 'csv'
require_relative "app/models/television_show"
enable :sessions

set :bind, '0.0.0.0'  # bind to all interfaces
set :views, File.join(File.dirname(__FILE__), "app/views")

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
  attr_reader :title, :network
  @tv = CSV.read('television-shows.csv', headers: true)

  @title = params["Title"]
  @network = params["Network"]
  @starting_year = params["Starting Year"]
  @synopsis = params["Synopsis"]
  # how to select from GENRES? use .include? do i store it?
  # @genre = params["Genre"]#GENRES.select #GENRES.include?()
  if @tv.
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
    else
      CSV.open('television-shows.csv', 'a') do |show|
        show << [@title,@network,@starting_year,@synopsis,@genre]
      end
    redirect '/television_shows'
    end
  end
  erb :index
end
