/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     BOOLEAN = 258,
     CALLOUT = 259,
     CLASS = 260,
     FALSE = 261,
     TRUE = 262,
     INT = 263,
     ID = 264,
     INT_LITERAL = 265,
     HEXA_LITERAL = 266,
     CHAR = 267,
     ASSIGN_OP = 268,
     STR_LITERAL = 269,
     CHAR_LITERAL = 270,
     VOID_DECL = 271,
     CURLY_OPEN = 272,
     CURLY_CLOSE = 273,
     SQUARE_OPEN = 274,
     SQUARE_CLOSE = 275,
     CIRCLE_OPEN = 276,
     CIRCLE_CLOSE = 277,
     COLON = 278,
     COMMA = 279,
     EQ_OP = 280,
     COND_OP = 281,
     LOWERARITH_OP = 282,
     HIGHERARITH_OP = 283,
     REL_OP = 284,
     NOT_OP = 285
   };
#endif
/* Tokens.  */
#define BOOLEAN 258
#define CALLOUT 259
#define CLASS 260
#define FALSE 261
#define TRUE 262
#define INT 263
#define ID 264
#define INT_LITERAL 265
#define HEXA_LITERAL 266
#define CHAR 267
#define ASSIGN_OP 268
#define STR_LITERAL 269
#define CHAR_LITERAL 270
#define VOID_DECL 271
#define CURLY_OPEN 272
#define CURLY_CLOSE 273
#define SQUARE_OPEN 274
#define SQUARE_CLOSE 275
#define CIRCLE_OPEN 276
#define CIRCLE_CLOSE 277
#define COLON 278
#define COMMA 279
#define EQ_OP 280
#define COND_OP 281
#define LOWERARITH_OP 282
#define HIGHERARITH_OP 283
#define REL_OP 284
#define NOT_OP 285




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 22 "./parse.y"
{
	int ival;
	float fval;
	char *sval;
	bool bval;
}
/* Line 1529 of yacc.c.  */
#line 116 "parse.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

