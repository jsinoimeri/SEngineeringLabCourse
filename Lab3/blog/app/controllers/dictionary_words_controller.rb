require "#{Rails.root}/app/models/Web_spellchecker.rb"

class DictionaryWordsController < ApplicationController
  def spellcheck
  	input_word = params[:term]
  	#render text => "we want to check the word " + input_word
  	
  	webchecker = Web_Spellchecker.new
  	
  	webcheck = Hash.new
  	webcheck = {"term" => input_word, "known" => webchecker.correct(input_word), "suggestions" => webchecker.correct(input_word)}
  	
  	render json: webcheck
  
  end
end
