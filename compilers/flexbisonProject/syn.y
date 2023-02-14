%{
#include <string.h>
#include<stdlib.h>
#include<stdio.h>
int nb_line = 1;
int nb_column=1;

#define UNDEF 0
#define INT_TYPE 1
#define FLOAT_TYPE 2
#define CHAR_TYPE 3
#define STR_TYPE 4

#define VAR_TYPE 0
#define ARRAY_TYPE 1

char* p;
char* q;

int temp;

%}

%union{
int integer;
char* chaine;
char* str;
double real;
char character;
}

%token <integer>kw_int <integer>kw_float <integer>kw_str <integer>kw_char

%token kw_program kw_division kw_section kw_identification kw_data kw_ws kw_procedure kw_line kw_size kw_sr f_accept f_display kw_if kw_else kw_move kw_to kw_end 
%token kw_const lo_and lo_or lo_not at
%token <str>idf <integer>t_int <real>t_float <character>t_char <str>t_str equal dot colon semicolon verg bar plus minus multi division ob cb co_g co_l co_ge co_le co_eq co_diff

%left lo_or
%left lo_and
%left co_g co_l co_ge co_le co_eq co_diff 
%left plus minus lo_not
%left multi division

%type <integer> TYPE
%start S

%%
S: HEAD DATA PROC kw_sr {printf("all good dawg\n"); YYACCEPT; }
;
HEAD: kw_identification kw_division dot kw_program dot idf dot 
;
DATA: kw_data kw_division dot kw_ws kw_section dot DEC
;
PROC: kw_procedure kw_division dot INST
;

DEC:	VARLISTE dot DEC
	 	| idf kw_line t_int verg kw_size t_int TYPE dot DEC
	 	| kw_const idf TYPE dot DEC
	 	| kw_const idf equal CST dot DEC
	 	|
;

VARLISTE: 	idf bar VARLISTE {symtab_dump(); set_type(yylval.chaine, VAR_TYPE, temp, 0);}
			| idf TYPE {symtab_dump(); set_type(yylval.chaine, VAR_TYPE, temp, 0);}
;

TYPE:	kw_int 		{temp = INT_TYPE;}
		| kw_float	{temp = FLOAT_TYPE;}
		| kw_char	{temp = CHAR_TYPE;}
		| kw_str	{temp = STR_TYPE;}
;

CST:	t_int {printf("%d\n", yylval.integer);}
		| t_float {printf("%.2f\n", yylval.real);}
		| t_char
		| t_str
;

INST: 	idf equal EXP dot INST
		| f_accept ob t_str colon at idf cb dot INST
		| f_display ob t_str FORM cb dot INST
		| kw_if COND colon INST ELSE kw_end dot INST
		| kw_move EXP kw_to EXP INST kw_end dot INST
		|
;

ELSE: 	kw_else colon INST
		|
;

EXP:	EXP ARITH EXPU 
		| EXPU
;

EXPU:	CST 
		| idf
		| ob EXP cb
;

FORM:	colon at idf FORMU
		| 
;

FORMU:	verg  at idf FORMU
		|
;

COND: 	COND LO CONDU 
		| CONDU
;

CONDU:	ob EXP CO EXP cb
		| lo_not ob COND cb
		| ob COND cb
;

ARITH: 	plus
		| minus
		| multi
		| division
;

LO:		lo_and
		| lo_or
;

CO:		co_g
		| co_l
		| co_ge
		| co_le
		| co_eq
		| co_diff

%%

main ()
{ 

	// initialize symbol table
    init_hash_table();
 

	yyparse();

	// symbol table dump
    symtab_dump();


 }
yywrap () {}

int yyerror(char* msg)
{
	printf("Erreur Syntaxique à la ligne %d \n", nb_line);
}