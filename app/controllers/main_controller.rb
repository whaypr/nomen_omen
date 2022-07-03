require 'net/http'
require 'json'

class MainController < ApplicationController
  def index  
    @gender = Hash.new
    @age = Hash.new
    @nationality = Hash.new

    return if params[:name] == nil or params[:name] == ""
    params[:country_code] = "US" if params[:country_code] == ""

    params[:country_code] = params[:country_code].upcase

    # get gender
    response = Net::HTTP.get_response(
      URI("https://api.genderize.io?name=#{params[:name]}&country_id=#{params[:country_code]}")
    )
    @gender = JSON.parse(response.body)

    # get age
    response = Net::HTTP.get_response(
      URI("https://api.agify.io?name=#{params[:name]}&country_id=#{params[:country_code]}")
    )
    @age = JSON.parse(response.body)

    # get nationality
    response = Net::HTTP.get_response(
      URI("https://api.nationalize.io?name=#{params[:name]}&country_id=#{params[:country_code]}")
    )
    @nationality = JSON.parse(response.body)
  end
end
