# frozen_string_literal: true

# this is my class controller
class GamesController < ApplicationController
  def new
    @letters = random_letters
  end

  def score
    @message = params[:message]
  end

  def calc_score
    letters = params[:letters].split
    word = params[:word].upcase
    answer = check_word(word, letters)
    redirect_to score_path(message: answer)
  end

  private

  def random_letters
    ret = []
    10.times do
      ret << ('A'..'Z').to_a.sample
    end
    ret
  end

  def check_word(word, letters)
    if wrong_letters(word, letters)
      return "Sorry but #{word} can't be built out of #{letters}"
    end

    unless english_word(word)
      return "Sorry but #{word} does not seem to be an english word..."
    end

    "Congratulations, #{word} is a valid english word!"
  end

  def wrong_letters(word, letters)
    bad_letters = word.chars.reject do |char|
      letters.include?(char)
    end
    bad_letters.length.positive?
  end

  def english_word(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    response_serialized = open(url).read
    response = JSON.parse(response_serialized)
    response['found']
  end
end
