%{
#include <iostream>
#include "mytokens.h"
using namespace std;
#define YY_DECL extern "C" int yylex()
%}

%%

[ \t\n]         		;
";"							{ return COLON; }
"void"						{ return VOID_DECL; }
"class"						{ return CLASS; }
"callout"					{ return CALLOUT; }
"true"						{ return TRUE; }
"false"						{ return FALSE; }
"boolean"					{ return BOOLEAN; }
"int"						{ return INT; }
"char"						{ return CHAR; }
"string"					{ return STRING; }
"\""						{ return STRING_SEP; }
"\'"						{ return CHAR_SEP; }
[0-9]+						{ return INT_LITERAL; }
"0x"[a-fA-F0-9][a-fA-F0-9]*	{ return INT_LITERAL; }
[a-zA-Z][a-zA-Z0-9]*    	{ return ID; }
"+="|"-="|"=" 				{ return ASSIGN_OP; }
"*"|"/"|"+"|"-"|"%"			{ return ARITH_OP; }
">="|"<="|">"|"<"			{ return REL_OP; }
"=="|"!="					{ return EQ_OP; }
"&&"|"||"					{ return COND_OP; }
","							{ return -1; }

%%

int main(int, char**) {
	// lex through the input:
	int a=100;
	int flagStr, flagChar;
	flagStr = 0;
	flagChar = 0;
	//FILE *myfile = fopen("../test_file/test_program", "r");
	//yyin = myfile;
	while (a != 0) {
		a = yylex();
		if (a == 12) {
			flagStr = 1 - flagStr;
			if (flagStr == 0)
				cout << STR_LITERAL << endl;
		} else if (a == 24) {
			flagChar = 1 - flagChar;
			if (flagChar == 0)
				cout << CHAR_LITERAL << endl;
		} else if ((flagStr == 0) && (flagChar == 0)){
			if (a != -1)
				cout <<  a << endl;
		}
	}
}