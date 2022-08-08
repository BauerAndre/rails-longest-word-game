require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @word = params[:word]
    if !@word.nil?
      response = URI.open("https://wagon-dictionary.herokuapp.com/#{@word}").read
      parsed = JSON.parse(response)
      @true_false = parsed['found']

    if params[:word].chars.all? {|char| params[:letters].include? char }
      case @true_false
      when false
        @answer = " Sorry but #{params[:word]} does not seem to be a valis English word... "
      when true
        @answer = " Congratulations! #{params[:word]} is a valid English word! "
      end
    else
      @answer = " Sorry but #{params[:word]} can't be built out of #{params[:letters]} "
    end

    end
  end
end
