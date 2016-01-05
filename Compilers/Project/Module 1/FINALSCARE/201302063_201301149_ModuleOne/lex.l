%{
/* Authors:
 *	Abbhinav Venkat (201302063)
 *	Gaurav Mittal (201301149)
 */
#include <iostream>
#include <fstream>
#include "parse.tab.h"
using namespace std;
#define YY_DECL extern "C" int yylex()
ofstream flexfile;
%}

%%

[ \t\n]         		;
"class"						{
								flexfile.open("flex_output.txt");
								flexfile << "CLASS\n";
								yylval.sval = strdup(yytext);
								return CLASS;
							}
"callout"					{
								flexfile << "CALLOUT\n";
								yylval.sval = strdup(yytext);
								return CALLOUT;
							}
"true"						{
								flexfile << "BOOLEAN: true\n";
								yylval.sval = strdup(yytext);
								return TRUE;
							}
"false"						{
								flexfile << "BOOLEAN: false\n";
								yylval.sval = strdup(yytext);
								return FALSE;
							}
"boolean"					{
								flexfile << "BOOLEAN_DECLARATION\n";
								yylval.sval = strdup(yytext);
								return BOOLEAN;
							}
"int"						{
								flexfile << "INT_DECLARATION\n";
								yylval.sval = strdup(yytext);
								return INT;
							}
"void"						{ 	
								flexfile << "VOID_DECLARATION\n";
								yylval.sval = strdup(yytext);
								return VOID_DECL;
							}
[0-9]+						{
								flexfile << "INT: " << yytext << "\n";
								yylval.ival = atoi(yytext);
								return INT_LITERAL;
							}
"0x"[a-fA-F0-9][a-fA-F0-9]*	{
								flexfile << "INT: "<< yytext << "\n";
								return HEXA_LITERAL;
							}
[a-zA-Z][a-zA-Z0-9]*    	{
								flexfile << "ID: " << yytext << "\n";
								yylval.sval = strdup(yytext);
								return ID;
							}
";"							{
								yylval.sval = strdup(yytext);
								return COLON;
							}
","							{
								yylval.sval = strdup(yytext);
								return COMMA;
							}
\"(\\.|[^\\"])*\"			{
								flexfile << "STRING: " << yytext << "\n";
								yylval.sval = strdup(yytext); 
								return STR_LITERAL;
							}
\'(\\.|[^\\"])\'			{
								flexfile << "CHAR: " << yytext << "\n";
								yylval.sval = strdup(yytext);
								return CHAR_LITERAL;
							}
"{"							{
								yylval.sval = strdup(yytext);
								return CURLY_OPEN;
							}
"}"							{
								yylval.sval = strdup(yytext);
								return CURLY_CLOSE;
							}
"["							{
								yylval.sval = strdup(yytext);
								return SQUARE_OPEN;
							}
"]"							{
								yylval.sval = strdup(yytext);
								return SQUARE_CLOSE;
							}
"("							{
								yylval.sval = strdup(yytext);
								return CIRCLE_OPEN;
							}
")"							{
								yylval.sval = strdup(yytext);
								return CIRCLE_CLOSE;
							}
"+="|"-="|"=" 				{
								yylval.sval = strdup(yytext);
								return ASSIGN_OP;
							}
"*"|"/"|"%"					{
								yylval.sval = strdup(yytext);
								return HIGHERARITH_OP;
							}
"+"|"-"						{
								yylval.sval = strdup(yytext);
								return LOWERARITH_OP;
							}
">="|"<="|">"|"<"			{
								yylval.sval = strdup(yytext);
								return REL_OP;
							}
"=="|"!="					{
								yylval.sval = strdup(yytext);
								return EQ_OP;
							}
"!"							{
								yylval.sval = strdup(yytext);
								return NOT_OP;
							}
"&&"|"||"					{
								yylval.sval = strdup(yytext);
								return COND_OP;
							}
.							;
%%
