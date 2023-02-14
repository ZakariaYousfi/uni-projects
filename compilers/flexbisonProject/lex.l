%{
  #include "syn.tab.h"
  #include "symtab.c"
  #include <string.h>
  #include <stdlib.h>

 
  extern int nb_line;
  extern YYSTYPE yylval;
  extern int nb_column;
  char* temp;
  
%}

letter            [a-zA-Z]
uc_letter         [A-Z]
lc_letter         [a-z]
number            [0-9]
IDF               {uc_letter}({lc_letter}|{number})*
int               ({number}+|(\([+-]{number}+\)))
float             ({number}+,{number}+|(\([+-]{number}+"."{number}+\)))
char              '.'
str               \"[^\"]*\"

%%
PROGRAM-ID        nb_column += yyleng; return kw_program;
DIVISION          nb_column += yyleng; return kw_division;
SECTION           nb_column += yyleng; return kw_section;
IDENTIFICATION    nb_column += yyleng; return kw_identification;
DATA              nb_column += yyleng; return kw_data;
WORKING-STORAGE   nb_column += yyleng; return kw_ws;
PROCEDURE         nb_column += yyleng; return kw_procedure;
LINE              nb_column += yyleng; return kw_line;
SIZE              nb_column += yyleng; return kw_size;
STOP[ ]RUN        nb_column += yyleng; return kw_sr;
											  
ACCEPT            nb_column += yyleng; return f_accept;
DISPLAY           nb_column += yyleng; return f_display;
											 
IF                nb_column += yyleng; return kw_if;
ELSE              nb_column += yyleng; return kw_else;
MOVE              nb_column += yyleng; return kw_move;
TO                nb_column += yyleng; return kw_to;
END               nb_column += yyleng; return kw_end;

INTEGER           nb_column += yyleng; return kw_int; 
FLOAT             nb_column += yyleng; return kw_float;
CHAR              nb_column += yyleng; return kw_char;
STRING            nb_column += yyleng; return kw_str;
CONST             nb_column += yyleng; return kw_const;

AND               nb_column += yyleng; return lo_and;
OR                nb_column += yyleng; return lo_or;
NOT               nb_column += yyleng; return lo_not;

#.*\!             nb_column += yyleng;

{IDF}             { if(yyleng <= 9){
											insert(yytext, strlen(yytext), UNDEF, nb_line);
											yylval.chaine=malloc(yyleng* sizeof(char));
											return idf;
																} 
										else{printf(" IDF too long on line %d and column %d. \n",nb_line, nb_column);}
											nb_column += yyleng;
					}
{int}             {
										nb_column += yyleng;
										if(yytext[0] == '('){
											yytext = yytext + 1;
											yytext[strlen(yytext)-1] = '\0';}

				   					if(atoi(yytext)<32768 && atoi(yytext)>-32769) {
				          		yylval.integer=atoi(yytext);
				          		return t_int;
				            }
	 		       				else printf("Oversized integer.\n"); 
	 		       			}
				   
{float}           { 
										if(yytext[0] == '('){
											yytext = yytext + 1;
											yytext[strlen(yytext)-1] = '\0';}

										nb_column += yyleng;
										yylval.real=atof(yytext);
										return t_float;
									}


{char}						{
										nb_column += yyleng;
										yylval.character=yytext[1];	
										return t_char;
									} 

{str}             { 
										nb_column += yyleng;
										yylval.chaine=malloc(yyleng* sizeof(char));
										strcpy(yylval.chaine, yytext);
										return t_str;
					
					}

"="  		   			  nb_column += yyleng; return equal;
":"               nb_column += yyleng; return colon;
";"               nb_column += yyleng; return semicolon;
","							  nb_column += yyleng; return verg;
"|"               nb_column += yyleng; return bar;
"+"               nb_column += yyleng; return plus;
"-"               nb_column += yyleng; return minus;
"*"               nb_column += yyleng; return multi;
"/"               nb_column += yyleng; return division;
"("               nb_column += yyleng; return ob;
")"               nb_column += yyleng; return cb;
"@"			    		  nb_column += yyleng; return at;
".G."             nb_column += yyleng; return co_g;
".L."             nb_column += yyleng; return co_l;
".GE."            nb_column += yyleng; return co_ge;
".LE."            nb_column += yyleng; return co_le;
".EQ."            nb_column += yyleng; return co_eq;
".DI."            nb_column += yyleng; return co_diff;
"."               nb_column += yyleng; return dot;

[ \t]             nb_column += yyleng;
\n                nb_line++; nb_column = 1;
.                 printf(" Lexical Error at: Line %d and column %d. \n",nb_line, nb_column); nb_column += yyleng;
