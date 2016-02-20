
http://rubyquiz.com/quiz44.html

###Orginal Specification
Word Chains (#44)
Our own Dave Thomas has also posted some Ruby code challenges on his blog in the past. There are several interesting problems there:

CodeKata

This week's Ruby Quiz is one of my favorite problems posted by Dave.

Given two words of equal length as command-line arguments, build a chain of words connecting the first to the second. Each word in the chain must be in the dictionary and every step along the chain changes exactly one letter from the previous word.

Again, your program should accept input as two command-line arguments. Your program should also allow a -d command-line switch followed by a dictionary file to use, but feel free to choose a sensible default for your system. The result should be a word chain starting with the first word and ending with the last printed to STDOUT, one word per line. Print an error message if a chain cannot be found.

Bonus points for finding the shortest chain and/or a small execution time.

Here's an example:

$ time ruby -d word_chain.rb duck ruby
	Loading dictionary...
	Building chain...
	duck
	ruck
	rusk
	ruse
	rube
	ruby

	real    0m27.551s
	user    0m27.402s
	sys     0m0.113s


###Extended Spec

stage_1