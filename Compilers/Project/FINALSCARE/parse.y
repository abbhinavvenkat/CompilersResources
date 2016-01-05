%{
/* Authors:
 *	Abbhinav Venkat (201302063)
 *	Gaurav Mittal (201301149)
 */
#include <cstdio>
#include <iostream>
#include <string.h>
#include <fstream>
using namespace std;

extern "C" int yylex();
extern "C" int yyparse();
extern "C" FILE *yyin;

void yyerror(const char *s);

ofstream outfile;
%}

%union {
	int ival;
	float fval;
	char *sval;
	bool bval;
}

%token <bval> BOOLEAN
%token <sval> CALLOUT
%token <sval> CLASS
%token <sval> FALSE
%token <sval> TRUE 
%token <sval> INT 
%token <sval> ID
%token <ival> INT_LITERAL
%token <ival> HEXA_LITERAL
%token <sval> CHAR
%token <sval> ASSIGN_OP
%token <sval> STR_LITERAL
%token <sval> CHAR_LITERAL
%token <sval> VOID_DECL
%token <sval> CURLY_OPEN
%token <sval> CURLY_CLOSE
%token <sval> SQUARE_OPEN
%token <sval> SQUARE_CLOSE
%token <sval> CIRCLE_OPEN
%token <sval> CIRCLE_CLOSE
%token <sval> COLON
%token <sval> COMMA

%left <sval> EQ_OP
%left <sval> COND_OP
%left <sval> LOWERARITH_OP
%left <sval> HIGHERARITH_OP
%left <sval> REL_OP
%left <sval> NOT_OP

%start program

%%
program :
	CLASS ID CURLY_OPEN fielddecl st CURLY_CLOSE	{
														if(strcmp("Program", $2)==0){
															outfile << "PROGRAM ENCOUNTERED\n";	
														}
														else{
															yyerror("Error");
														}
														
													}
	;

fielddecl :
	type var COLON fielddecl	{}
	|							{}
	;
								
type :
	INT 		{outfile<<"INT ";}
	|BOOLEAN	{outfile<<"BOOLEAN ";}
	;

var :
	ID COMMA var 											{}
	| ID SQUARE_OPEN INT_LITERAL SQUARE_CLOSE COMMA var 	{}
	| ID 													{outfile<<"DECLARATION ENCOUNTERED. ID="<< $1 << "\n";}
	| ID SQUARE_OPEN INT_LITERAL SQUARE_CLOSE 				{outfile<<"DECLARATION ENCOUNTERED. ID="<< $1 << " SIZE=" << $3 << "\n";}
	;

//More to be added later
st :
	newst st 				{}
	| methodcall COLON st 	{}
	|
	;

newst:
	location ASSIGN_OP expr COLON {outfile << "ASSIGNMENT OPERATION ENCOUNTERED\n"; }
	;

location :
	ID 									{outfile << "LOCATION ENCOUNTERED=" << $1 << "\n";}
	| ID SQUARE_OPEN expr SQUARE_CLOSE	{outfile << "LOCATION ENCOUNTERED=" << $1 << "\n";}
	;

expr :
	relop						{}
	;

relop:
	relop REL_OP lowerarith 	{	if ( strcmp($2, ">") == 0 )
										outfile << "GREATER THAN ENCOUNTERED\n";
									else if ( strcmp($2, "<") == 0 )
										outfile << "LESS THAN ENCOUNTERED\n";
								}
	| lowerarith 				{}
	;

lowerarith:
	lowerarith LOWERARITH_OP higherarith
					{	if ( strcmp($2, "+") == 0 )
							outfile << "ADDITION ENCOUNTERED\n";
						else if ( strcmp($2, "-") == 0 )
							outfile << "SUBTRACTION ENCOUNTERED\n";
					}
	| higherarith 	{}
	;

higherarith:
	higherarith HIGHERARITH_OP notop
				{	if ( strcmp($2, "*") == 0 )
						outfile << "MULTIPLICATION ENCOUNTERED\n";
					else if ( strcmp($2, "/") == 0 )
						outfile << "DIVISION ENCOUNTERED\n";
					else if ( strcmp($2, "%") == 0 )
						outfile << "MOD ENCOUNTERED\n";
				}
	| notop 	{}
	;

notop:
	NOT_OP unary 	{}
	| unary 		{}

unary:
	LOWERARITH_OP brac 	{}
	| brac 				{}
	;

brac:
	CIRCLE_OPEN expr CIRCLE_CLOSE	{}
	| literal						{}
	| location						{}
	| methodcall					{}
	;


methodcall :
	methodname CIRCLE_OPEN z CIRCLE_CLOSE				{}
	| CALLOUT CIRCLE_OPEN STR_LITERAL q CIRCLE_CLOSE 	{outfile<<"CALLOUT TO " << $3 << " ENCOUNTERED\n";}
	;

literal :
	  int_literal 	{}	
	| char_literal 	{}
	| bool_literal 	{}
	;

int_literal:
	INT_LITERAL 	{outfile<<"INT ENCOUNTERED=" << $1 << "\n";}
	| HEXA_LITERAL	{}
	;

char_literal: CHAR_LITERAL {outfile<<"CHAR ENCOUNTERED="<< $1 <<"\n";}
	;

bool_literal:
	TRUE		{outfile<<"BOOLEAN ENCOUNTERED="<< $1 <<"\n";}
	| FALSE		{outfile<<"BOOLEAN ENCOUNTERED="<< $1 <<"\n";}
	;

z :
	ztemp			{}
	|				{}
	;

ztemp : 
	expr COMMA ztemp 	{}
	| expr

q :
	COMMA qtemp 		{}
	|					{}
	;

qtemp :
	calloutarg COMMA qtemp 		{}
	| calloutarg 				{}
	;

calloutarg :
	expr 				{}
	| STR_LITERAL 		{outfile<<"LOCATION ENCOUNTERED" << $1 << "\n";}
	;

methodname :
	ID 		{}
	;

%%

int main(int argc, char *argv[]) {

	if (argc == 1){
		cout << "No Input File Given\n";
		exit(-1);	
	}
	
	FILE *myfile = fopen(argv[1], "r");
	
	if (!myfile) {
		cout << "I can't open the file!" << endl;
		return -1;
	}

	outfile.open("bison_output.txt");

	yyin = myfile;
	
	do {
		yyparse();
	} while (!feof(yyin));

	cout << "Success" << endl;
	
}

void yyerror(const char *s) {
	cout << "Syntax Error" << endl;
	exit(-1);
}