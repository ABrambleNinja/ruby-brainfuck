module Brainfuck
  CHARS = %w{< > . , + - [ ]}
  MEMORY_SIZE = 30_000

  class Cell
    attr_reader :bit_size
    attr_accessor :value

    def initialize (bit_size)
      @value = 0
      @bit_size = bit_size
      @max_value = (2 ** bit_size) - 1
    end

    def increment
      @value += 1
      if @value > @max_value
        @value -= @max_value + 1 # 256 should overflow to 0
      end
      value
    end

    def decrement
      @value -= 1
      if @value < 0
        @value += @max_value + 1 # -1 should underflow to 255
      end
      value
    end

  end

  def self.run (brainfuck_code)
    code = brainfuck_code.split("") # split commands into arrays
    memory = (1..MEMORY_SIZE/8).map { Cell.new(8) } # initialize memory to represent MEMORY_SIZE number of "bytes"
    pointer = 0 # index of memory that the pointer is currently at

    code_pointer = 0 # start at beginning
    while code_pointer < code.length # until we've reached the end
      command = code[code_pointer] # grab the current command
      pointer, memory, new_code_pointer = process_command(command, pointer, memory, code.join, code_pointer) # process it
      code_pointer = new_code_pointer if new_code_pointer # if we're supposed to jump, do it
      code_pointer += 1 # move to next character
    end
    nil
  end
  private
  def self.process_command(command, pointer, memory, code, code_pointer)
    new_index = nil
    case command
    when ">"
      pointer += 1
    when "<"
      pointer -= 1
    when "."
      print memory[pointer].value.chr
    when ","
      char = STDIN.getch
      memory[pointer].value = char.ord
      print char # STDIN.getch does not show you what you have typed, so this imitates that
    when "+"
      memory[pointer].increment
    when "-"
      memory[pointer].decrement
    when "["
      new_index = find_corresponding_bracket(code_pointer, code) if memory[pointer].value == 0 # jump to matching ] if we're at a 0 cell
    when "]"
      new_index = find_corresponding_bracket(code_pointer, code) if memory[pointer].value != 0 # jump to matching [ unless we're at a 0 cell
    end
    return [pointer, memory, new_index] # returns modified? memory, pointer and also new index or nil if it stays the same
  end
  def self.find_corresponding_bracket(code_pointer, code) # pointer should point to either a [ or ]
    if code[code_pointer] == '['
      num_new_brackets = 0
      code[code_pointer+1..-1].each_char.with_index do |char, index| # scan from after the pointer to the end of the string
        num_new_brackets += 1 if char == '[' # if we find a new bracket, we don't want to find its matching bracket
        if char == ']'
          return code_pointer + index + 1 if num_new_brackets == 0 # if there
          num_new_brackets -= 1
        end
      end
      raise "Unmatched bracket at index #{code_pointer}"
    elsif code[code_pointer] == ']'
      num_new_brackets = 0
      code[0..code_pointer-1].reverse.each_char.with_index do |char, index|
        num_new_brackets += 1 if char == ']'
        if char == '['
          return code_pointer - index - 1 if num_new_brackets == 0
          num_new_brackets -= 1
        end
      end
      raise "Unmatched bracket at index #{code_pointer}"
    end
  end
end
