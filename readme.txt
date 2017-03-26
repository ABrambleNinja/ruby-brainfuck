This is the beginning of my attempt at a Brainfuck interpreter in Ruby. Currently, it only supports the commands <>.,+-, but I aim to eventually support loops as well.

Here's some sample code:
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.
This prints out the letter 'd'.

At this point in development, the program creates a module called Brainfuck that has a method, run, that takes a string of Brainfuck code and evaluates it. If you simply run the ruby file, it will open up pry, which is similar to irb but embeddable in the code, for testing purposes.

This code is released under the MIT license <abrambleninja.mit-license.org>
