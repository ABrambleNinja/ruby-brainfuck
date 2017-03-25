require 'pry'

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
        @value += @max_value + 1 # -1 should overflow to 255
      end
      value
    end

  end

  def self.run (brainfuck_code)
    code = brainfuck_code.split("").delete_if {|character| !CHARS.include? character } # split commands into arrays and remove all ignored characters
    memory = (1..MEMORY_SIZE/8).map { Cell.new(8) } # initialize memory to represent MEMORY_SIZE number of "bytes"
    pointer = 0 # index of memory that the pointer is currently at
    loop_start_indices = []

    code.each do |command|
      process_command(command, pointer, memory)
    end
    nil
  end

  private
  def self.process_command(command, pointer, memory)
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
    when "]"
    end
  end
end
require './print_string_brainfuck'
binding.pry
