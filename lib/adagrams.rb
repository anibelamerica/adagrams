require 'csv'

# returns an array of 10 letters
def draw_letters
  letter_frequencies =
  {
    "A" => 9,
    "B" => 2,
    "C" => 2,
    "D" => 4,
    "E" => 12,
    "F" => 2,
    "G" => 3,
    "H" => 2,
    "I" => 9,
    "J" => 1,
    "K" => 1,
    "L" => 4,
    "M" => 2,
    "N" => 6,
    "O" => 8,
    "P" => 2,
    "Q" => 1,
    "R" => 6,
    "S" => 4,
    "T" => 6,
    "U" => 4,
    "V" => 2,
    "W" => 2,
    "X" => 1,
    "Y" => 2,
    "Z" => 1,
  }

  pool_of_letters = []

  letter_frequencies.each do |letter, freq|

    freq.times do
      pool_of_letters << letter
    end

  end

  return pool_of_letters.sample(10)

end


# Boolean method that verifies input is valid
def uses_available_letters?(input, letters_in_hand)

  input_array = input.upcase.chars

  letters_in_hand.each do |letter|

    if input_array.include? letter
      index = input_array.index(letter)
      input_array.delete_at(index)
    end
  end

  return input_array.length == 0

end


# returns word score based on letter value and word length
def score_word(word)

  score = 0

  word.upcase.each_char do |letter|

    case letter
    when "A", "E", "I", "O", "U", "L", "N", "R", "S", "T"
      score += 1
    when "D", "G"
      score += 2
    when "B", "C", "M", "P"
      score += 3
    when "F", "H", "V", "W", "Y"
      score += 4
    when "K"
      score += 5
    when "J", "X"
      score += 8
    when "Q", "Z"
      score += 10
    end

  end

  if word.length >= 7
    score += 8
  end

  return score

end


# returns hash of highest scoring word and its score
# applies rules for breaking ties
def highest_score_from(words)

  best_word = {
    word: [],
    score: 0
  }

  words.each do |word|

    score = score_word(word)

    if score > best_word[:score]
      best_word[:word].clear
      best_word[:word] << word
      best_word[:score] = score
    end

    if score == best_word[:score]
      best_word[:word] << word
    end

  end

  # applies rules for ties:
  # - shortest word wins unless there is a 10 letter word
  # - if multiple 10 letter words, the first word wins
  shortest_word = best_word[:word].min_by do |word|
    word.length
  end

  all_tiles_words = best_word[:word].select do |word|
    word.length == 10
  end

  if all_tiles_words.empty?
    best_word[:word] = shortest_word
  else
    best_word[:word] = all_tiles_words[0]
  end

  return best_word

end


# Boolean method that verifies word is in game dictionary
def is_in_english_dict?(input)

  CSV.read('assets/dictionary-english.csv', headers: true).each do |word|

    if input.downcase == word[0]
      return true
    end

  end

  return false

end
