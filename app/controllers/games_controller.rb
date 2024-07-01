require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    @included = included
    @english_word = english_word
  end

  private

  def included
    @word.chars.sort.all? { |letter| @letters.include?(letter) }
  end

  def english_word
    response = URI.open("https://dictionary.lewagon.com/#{@word}")
    json = JSON.parse(response.read)
    @word['found']
  end
end
