class Web_Spellchecker < Spellchecker
	def initialize()
	end
	
	def known(word_list)
		DictionaryWord.where('words in(:word_list)', list: word_list).order(count :word_list).pluck(:word_list)
	end
end