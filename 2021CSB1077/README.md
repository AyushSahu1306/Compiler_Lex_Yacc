Contributors: -
Ayush Sahu 2021CSB1077
Sushil Kumar 2021CSB1136

This is a compiler for B-- programming language implemented using Lex and Yacc. 

To compile the compiler, run the following commands:

flex BMM_Scanner.l
bison -d BMM_Parser.y
gcc lex.yy.c BMM_Parser.tab.c
.\a.exe

The B-- compiler code is organized into the following files:
BMM_Parser.y: The Yacc parser specification file.
BMM_Scanner.l: The Lex scanner specification file.
CorrectSample.bmm: Contains correct code for B-- language.
InCorrectSample.bmm: Contains incorrect code for B-- language.

