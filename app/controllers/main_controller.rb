require 'net/http'
require 'json'

class MainController < ApplicationController
  def index  
    @name = ""
    @country_code = ""
    @gender = Hash.new
    @age = Hash.new
    @nationality = Hash.new

    return if params[:name] == nil or params[:name] == ""
    params[:country_code] = "CZ" if params[:country_code] == ""

    @name = params[:name]
    @country_code = params[:country_code]

    # get gender
    response = Net::HTTP.get_response(
      URI("https://api.genderize.io?name=#{@name}&country_id=#{@country_code}")
    )
    @gender = JSON.parse(response.body)

    # get age
    response = Net::HTTP.get_response(
      URI("https://api.agify.io?name=#{@name}&country_id=#{@country_code}")
    )
    @age = JSON.parse(response.body)

    # get nationality
    response = Net::HTTP.get_response(
      URI("https://api.nationalize.io?name=#{@name}&country_id=#{@country_code}")
    )
    @nationality = JSON.parse(response.body)
  end
end
