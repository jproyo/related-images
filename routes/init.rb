require 'sinatra'
require 'net/http'
require 'uri'
require 'json'
require_relative '../scrapper/scrapper'

set :views, settings.root + '/../views'

get '/search_related' do
  content_type :json
  url = params[:url]
  if not url
	status 500
	"Parameter url cannot be null".to_json
  else
  	generate_urls(params[:url]).to_json
  end
end

post '/search_related' do
  @urls = generate_urls params[:url]
  erb :index
end

def generate_urls(url)
  RelatedImageScrapper.scrapp(url)
end

get '/' do
  erb :index
end

