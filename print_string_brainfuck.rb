def to_brainfuck (string)
  buffer = ""
  string.split("").each do |character|
    buffer << Array.new(character.ord, "+").join << ".>"
  end
  buffer
end
