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
