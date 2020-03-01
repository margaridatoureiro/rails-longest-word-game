# frozen_string_literal: true

require 'set'
require 'json'
require 'open-uri'
# top-level
class GamesController < ApplicationController
  def new
    lenght = rand(1..15)
    @letters = ('A'..'Z').to_a.sample(lenght)
  end

  def score
    word = params[:word]
    @answer = params[:word].upcase.chars.to_set
    letters = params[:letters].chars.to_set
    if @answer.subset?(letters) == true
      response = open("https://wagon-dictionary.herokuapp.com/#{word}").read
      validate = JSON.parse(response)
      validate['found'] ? @result = "Congrats! #{word} is a valid English word"
      : @result = "We're sorry! #{word} is not a valid English word :("
    else
      @result = "Sorry, but #{word} can't be built out of the original grid :("
    end
  end
end
