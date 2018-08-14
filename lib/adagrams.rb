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

def uses_available_letters?(input, letters_in_hand)
  input_array = input.upcase.chars
  input_array.each do |letter|
    if letters_in_hand.include? letter
      letters_in_hand.delete_at(letters_in_hand.index(letter))
    else
      return false
    end
  end
  return true
end

def score_word(word)

  score = 0

  word.downcase.each_char do |letter|

    case letter
    when "a", "e", "i", "o", "u", "l", "n", "r", "s", "t"
      score += 1
    when "d", "g"
      score += 2
    when "b", "c", "m", "p"
      score += 3
    when "f", "h", "v", "w", "y"
      score += 4
    when "k"
      score += 5
    when "j", "x"
      score += 8
    when "q", "z"
      score += 10
    end

  end

  if word.length >= 7
    score += 8
  end

  return score

end

def highest_score_from(words)

  # best_score = 0
  # best_words = []

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

  # insert some tie-breaker code here
  best_by_length = best_word[:word].min_by do |word|
    word.length
  end

  best_by_10 = best_word[:word].select do |word|
    word.length == 10
  end

  if best_by_10.empty?
    best_word[:word] = best_by_length
  else
    best_word[:word] = best_by_10[0]
  end

  return best_word

end
