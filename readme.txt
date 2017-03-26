This is my attempt at a Brainfuck interpreter in Ruby. As far as I know, it's fully functional.

To run a program, store the Brainfuck code in a string and call Brainfuck::run on it. Here's an example:

Brainfuck::run("++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++.") # code from Wikipedia

prints Hello World!

The code is currently pretty messy, but I will be working on cleaning it up shortly. I first wanted to get the basic algorithm working.
