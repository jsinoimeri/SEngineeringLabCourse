require 'set'

class Spellchecker

  
  ALPHABET = 'abcdefghijklmnopqrstuvwxyz'

  #constructor.
  #text_file_name is the path to a local file with text to train the model (find actual words and their #frequency)
  #verbose is a flag to show traces of what's going on (useful for large files)
  def initialize(text_file_name)
    #read file text_file_name
    #extract words from string (file contents) using method 'words' below.
    #put in dictionary with their frequency (calling train! method)
    file = File.open(text_file_name, "rb")
   	file_content = file.read
   	file.close
   	
   	word_list = words(file_content)
    train!(word_list)
  end

  def dictionary
    #getter for instance attribute
    @dictonary
  end
  
  #returns an array of words in the text.
  def words (text)
    return text.downcase.scan(/[a-z]+/) #find all matches of this simple regular expression
  end

  #train model (create dictionary)
  def train!(word_list)
    #create @dictionary, an attribute of type Hash mapping words to their count in the text {word => count}. Default count should be 0 (argument of Hash constructor).
    @dictonary = Hash.new(0)
    frequency = 0
    
    word_list.each do |word|
    	if (@dictonary.has_key?(word))
    		@dictonary[word] = lookup(word) + 1
    	end
  	end
    
  end

  #lookup frequency of a word, a simple lookup in the @dictionary Hash
  def lookup(word)
  	return @dictonary[word]
  end
  
  #generate all correction candidates at an edit distance of 1 from the input word.
  def edits1(word)
    
    deletes    = []
    #all strings obtained by deleting a letter (each letter)
    for i in 0...word.length
    	new_word = word.slice!(i)
    	if (@dictonary.has_key?(new_word))
    		deletes.push(new_word)
    	end
    end

    
    transposes = []
    #all strings obtained by switching two consecutive letters
    for i in 1...word.length
    	letter = word.clone
    	letter_1 = letter[i-1]
    	letter[i-1] = letter[i]
    	letter[i] = letter_1
    	if (@dictonary.has_key?(letter))
    		transposes.push(letter)
    	end
    end
    
  	
    
    inserts = []
    # all strings obtained by inserting letters (all possible letters in all possible positions)
    for i in 0...word.length
    	ALPHABET.each_char do |letter|
    		word1 = word.clone
    		word1.insert(i, letter)
    		if(@dictonary.has_key?(word1))
    			inserts.push(word1)
    		end
    	end
  	end
    
    replaces = []
    #all strings obtained by replacing letters (all possible letters in all possible positions)
    for i in 0...word.length
    	ALPHABET.each_char do |letter|
    		word1 = word.clone
    		word1[i] = letter
    		if(@dictonary.has_key?(word1))
    			replaces.push(word1)
    		end
    	end
  	end

		#puts(deletes + transposes + replaces + inserts).to_set.to_a
    return (deletes + transposes + replaces + inserts).to_set.to_a #eliminate duplicates, then convert back to array
  end
  

  # find known (in dictionary) distance-2 edits of target word.
  def known_edits2 (word)
    # get every possible distance - 2 edit of the input word. Return those that are in the dictionary.
    
  end

  #return subset of the input words (argument is an array) that are known by this dictionary
  def known(words)
    return words.find_all {true} #find all words for which condition is true,
                                    #you need to figure out this condition
    
  end


  # if word is known, then
  # returns [word], 
  # else if there are valid distance-1 replacements, 
  # returns distance-1 replacements sorted by descending frequency in the model
  # else if there are valid distance-2 replacements,
  # returns distance-2 replacements sorted by descending frequency in the model
  # else returns nil
  def correct(word)
  #candidates = known([word]) or known(edits1(word)) or known(edits2(word))
  #return max(candidates, key = NWORDS.get)
     
	end
end