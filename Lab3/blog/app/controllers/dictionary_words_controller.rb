class DictionaryWordsController < ApplicationController
  def spellcheck
  	input_word = params[:term]
  	print "we want to check the word " + input_word
  end
end
