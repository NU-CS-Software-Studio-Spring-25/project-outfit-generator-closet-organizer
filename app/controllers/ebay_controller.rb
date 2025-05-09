require 'net/http'
require 'json'

class EbayController < ApplicationController
  def search_form
  end

  skip_before_action :verify_authenticity_token

  def deletion
    render plain: 'outfit_generator_verification_token'  # exactly what you typed into eBay's field
  end
  
  def results
    query = params[:query]
    endpoint = URI("https://api.ebay.com/buy/browse/v1/item_summary/search?q=#{URI.encode_www_form_component(query)}&limit=10")

    http = Net::HTTP.new(endpoint.host, endpoint.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(endpoint)
    request["Authorization"] = "Bearer #{ENV['EBAY_OAUTH_TOKEN']}"

    response = http.request(request)
    @items = JSON.parse(response.body)["itemSummaries"] rescue []
  end
end
