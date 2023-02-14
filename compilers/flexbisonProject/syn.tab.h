
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

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
     kw_int = 258,
     kw_float = 259,
     kw_str = 260,
     kw_char = 261,
     kw_program = 262,
     kw_division = 263,
     kw_section = 264,
     kw_identification = 265,
     kw_data = 266,
     kw_ws = 267,
     kw_procedure = 268,
     kw_line = 269,
     kw_size = 270,
     kw_sr = 271,
     f_accept = 272,
     f_display = 273,
     kw_if = 274,
     kw_else = 275,
     kw_move = 276,
     kw_to = 277,
     kw_end = 278,
     kw_const = 279,
     lo_and = 280,
     lo_or = 281,
     lo_not = 282,
     at = 283,
     idf = 284,
     t_int = 285,
     t_float = 286,
     t_char = 287,
     t_str = 288,
     equal = 289,
     dot = 290,
     colon = 291,
     semicolon = 292,
     verg = 293,
     bar = 294,
     plus = 295,
     minus = 296,
     multi = 297,
     division = 298,
     ob = 299,
     cb = 300,
     co_g = 301,
     co_l = 302,
     co_ge = 303,
     co_le = 304,
     co_eq = 305,
     co_diff = 306
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 24 "syn.y"

int integer;
char* chaine;
char* str;
double real;
char character;



/* Line 1676 of yacc.c  */
#line 113 "syn.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


