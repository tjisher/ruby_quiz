
http://rubyquiz.com/quiz78.html

###Orginal Specification
Bracket Packing (#78)
by Ross Bamford

The BigCo Bracket Company, one of the world's largest suppliers of brackets, hinges and fittings, has lately been experiencing problems in it's manufacturing division, with a large number or brackets lost or broken in transit owing to faulty packaging at the end of the line.

Investigations into the cause of the problem have led engineers to an ancient COBOL program controlling the packaging machinery. This program is responsible for selecting the type of packaging a given bracket should be shipped in, based on input from an array of sensors on the production line. It then sends a description of the package to the packager itself, which packs the bracket and sends it on to shipping. The description is a simple text string, made up of brackets with the following format:

	(B)     - Bracket in a soft wrapping
	[B]     - Bracket in a cardboard box
	{B}     - Bracket in a wooden box

Often, brackets have multiple layers of packaging for protection, for example:

	{(B)}   - Soft-wrapped bracket in a wooden box
	[{B}]   - Wooden-boxed bracket with cardboard outer

	[{(B)}{(B)(B)}] - Wooden boxed single and double bracket packs with soft
	                  inner wrap, in cardboard outer. 

Now, the problem is that this venerable program has for some reason begun to output malformed packaging descriptions, occasionally missing off a bracket, for example:

	[{(B}{(B)(B)}]

or:

	{(B)}{(B)(B)}]

After a fruitless search for someone with the skills to fix this problem, the engineers changed tack and called you in to fix the problem from the outside.

	What needs to be done?
	======================

Basically, the plan is to insert another computer between the controller and the packer, upon which will run your program. The engineers can handle the integration with their systems - they just need you to write a slick bit of Ruby code to validate the packaging descriptions as they're passed in. You've been given two choices:

	* Check the description, and return exitcode indicating it's okay (0)
	  or bad (1). If correct, you should also print the description to stdout.
	  If it's bad, the system can then force the controller to try again.

	* Fix the description, if possible, and print it to stdout. The system
	  will then pass the fixed code to the packer.


###Extended Spec

stage_1