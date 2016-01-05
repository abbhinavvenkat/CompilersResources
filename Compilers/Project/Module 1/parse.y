%{
#include <cstdio>
#include <iostream>
using namespace std;

// stuff from flex that bison needs to know about:
extern "C" int yylex();
extern "C" int yyparse();
extern "C" FILE *yyin;
 
void yyerror(const char *s);
%}

// Bison fundamentally works by asking flex to get the next token, which it
// returns as an object of type "yystype".  But tokens could be of any
// arbitrary data type!  So we deal with that in Bison by defining a C union
// holding each of the types of tokens that Flex could return, and have Bison
// use that union instead of "int" for the definition of "yystype":
%union {
	int ival;
	float fval;
	char *sval;
	bool bval;
}

// define the "terminal symbol" token types I'm going to use (in CAPS
// by convention), and associate each with a field of the union:
%token <bval> BOOLEAN
%token <sval> CALLOUT
%token <sval> CLASS
%token <bval> FALSE
%token <bval> TRUE 
%token <sval> INT 
%token <sval> ID 
%token <ival> INT_LITERAL
%token <sval> CHAR_LITERAL
%token <sval> STR_LITERAL
%token <sval> STRING_SEP
%token <sval> CHAR
%token <sval> STRING
%token <sval> COLON
%token <sval> CHAR_SEP
%token <sval> ARITH_OP
%token <sval> REL_OP
%token <sval> ASSIGN_OP
%token <sval> EQ_OP
%token <sval> COND_OP

%start program

%%
// this is the actual grammar that bison will parse, but for right now it's just
// something silly to echo to the screen what bison gets from flex.  We'll
// make a real one shortly:
program :
	CLASS ID '{' fielddecl methoddecl'}'	{cout<<"Program Completed\n";}
	;

fielddecl :
	|							{}
	| type var ';' fielddecl	{}
	;

type :
	INT 		{}
	|BOOLEAN	{}
	;

var :
	id ',' var 							{}
	| id '[' INT_LITERAL ']' ',' var 	{}
	| id 								{}
	| id '[' INT_LITERAL ']' 			{}
	;

methoddecl :
	mtemp methoddecl {}
	|				 {}
	;

mtemp :
	type ID '(' x ')' block		{}
	| VOID_DECL ID '(' x ')' block 					{}
	;

x :
	tempx		{}
	|			{}
	;	

tempx : 
	type ID ',' tempx 	{}
	| type ID 			{}
	;

block :
	'{' vardecl st '}' 	{}
	;	

vardecl :
	type l ';' vardecl 		{}
	| 						{}
	;

l :
	ID ',' l 	{}
	| ID 		{}
	;

//More to be added later
st :
	location assignop expr ';'	{}
	;

assignop :
	=		{}
	| +=	{}
	| -=	{}
	;

location :
	ID 					{}
	| ID '[' expr ']'	{}
	;

expr :
	location						{}
	| methodcall					{}
	| literal 						{}
	| expr binop expr				{}
	| '-' expr						{}
	| '!' expr 						{}
	| '{' expr '}'					{}
	;

methodcall :
	methodname '(' z ')'				{}
	| CALLOUT '(' STRING_LITERAL q ')' 	{}
	;

z :
	ztemp			{}
	|				{}
	;

ztemp : 
	expr ',' ztemp 	{}
	| expr

q :
	',' qtemp 		{}
	|				{}
	;

qtemp :
	calloutarg ',' qtemp 		{}
	| calloutarg 				{}
	;

calloutarg :
	expr 				{}
	| STRING_LITERAL 	{}
	;

methodname :
	ID 		{}
	;

binop :
	ARITH_OP 	{}
	| REL_OP	{}
	| COND_OP	{}
	| EQ_OP		{}

%%

int main(int, char**) {
	// open a file handle to a particular file:
	FILE *myfile = fopen("testprog.decaf", "r");
	// make sure it is valid:
	if (!myfile) {
		cout << "I can't open a.snazzle.file!" << endl;
		return -1;
	}
	// set flex to read from it instead of defaulting to STDIN:
	yyin = myfile;
	
	// parse through the input until there is no more:
	do {
		yyparse();
	} while (!feof(yyin));
	
}

void yyerror(const char *s) {
	cout << "EEK, parse error!  Message: " << s << endl;
	// might as well halt now:
	exit(-1);
}