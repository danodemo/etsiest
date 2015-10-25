require "etsiest/version"
require "sinatra/base"
require "etsy"
require "pry"
require "tilt/erb"


module Etsiest
  class Search < Sinatra::Base
    include Etsy
    set :logging, true
    set :auth_key, "#{ENV["AUTH_KEY"]}"

      get "/" do
        Etsy.api_key = "#{settings.auth_key}"
        list = Etsy::Request.get('/listings/active', :includes => ['Images', 'Shop'], :keywords => 'whiskey')
        results = list.result
        #binding.pry
        erb :index, locals: {results: results}
      end
      run! if app_file == $0
    end
  end



=begin
require "sinatra/base"
require "httparty"
require "json"
require "etsy"
require "pry"
require "tilt/erb"

require "etsiest/version"
require "etsiest/etsyape"

Etsy.api_key = ENV['ETSY_KEY']

module Myhub
  class App < Sinatra::Base
    set :logging, true
  # Your code goes here...
    get "/search"  do 
      api = EtsyApe.new
      @results = Array.new
      api.getresults do |result|
        result = {
          url: result['url'],
          title: result['title'],
          price: result['price'],
          currency_code: result['currencry_code'],
          shop: result['Shop']['shop_name'],
          image: result['Images'][0]["url_175x135"],        
        }
          @results.push(result)
          binding.pry
      end
      erb :index, locals: { results: @results }
    end

    run! if app_file == $0
  end
end
=end

#ETSY_KEY=8ib98p3dy6dmwj7mpmvza6tc bundle exec ruby lib/etsiest.rb