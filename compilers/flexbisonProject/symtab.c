#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symtab.h"

void init_hash_table(){
	int i; 
	hash_table = malloc(SIZE * sizeof(list_t*));
	for(i = 0; i < SIZE; i++) hash_table[i] = NULL;
}

unsigned int hash(char *key){
	unsigned int hashval = 0;
	for(;*key!='\0';key++) hashval += *key;
	hashval += key[0] % 11 + (key[0] << 3) - key[0];
	return hashval % SIZE;
}

void insert(char *name, int len, int type, int lineno){
	unsigned int hashval = hash(name);
	list_t *l = hash_table[hashval];
	
	while ((l != NULL) && (strcmp(name,l->st_name) != 0)) l = l->next;
	
	/* variable not yet in table */
	if (l == NULL){
		l = (list_t*) malloc(sizeof(list_t));
		strcpy(l->st_name, name);  
		/* add to hashtable */
		l->st_type = type;
		l->lines = (RefList*) malloc(sizeof(RefList));
		l->lines->lineno = lineno;
		l->lines->next = NULL;
		l->next = hash_table[hashval];
		hash_table[hashval] = l; 
		printf("Inserted %s for the first time with linenumber %d!\n", name, lineno); // error checking
	}
	/* found in table, so just add line number */
	else{
		RefList *t = l->lines;
		while (t->next != NULL) t = t->next;
		/* add linenumber to reference list */
		t->next = (RefList*) malloc(sizeof(RefList));
		t->next->lineno = lineno;
		t->next->next = NULL;
		printf("Found %s again at line %d!\n", name, lineno);
	}
}

list_t *lookup(char *name){ /* return symbol if found or NULL if not found */
	unsigned int hashval = hash(name);
	list_t *l = hash_table[hashval];
	while ((l != NULL) && (strcmp(name,l->st_name) != 0)) l = l->next;
	return l; // NULL is not found
}

void set_type(char* name, int inf_type, int st_type, int const_type) {
	list_t* l = lookup(name);
	l->inf_type = inf_type;
	l->st_type = st_type;
	l->const_type = const_type;

}

int get_type(char* name) {
	list_t* l = lookup(name);
	return l->st_type;

}

int get_const(char* name) {
	list_t* l = lookup(name);
	return l->const_type;

}


void set_value(char* name, int inf_type, int st_type, int array_size, int const_type) {
	list_t* l = lookup(name);
	l->inf_type = inf_type;
	l->st_type = st_type;

}


/* print to stdout by default */ 
void symtab_dump(){  
  int i;
  printf("------------ ------ ------------\n");
  printf("Name         Type   Line Numbers\n");
  printf("------------ ------ -------------\n");
  for (i=0; i < SIZE; ++i){ 
	if (hash_table[i] != NULL){ 
		list_t *l = hash_table[i];
		while (l != NULL){ 
			RefList *t = l->lines;
			printf("%-12s ",l->st_name);
			if (l->st_type == INT_TYPE) printf("%-7s","int");
			else if (l->st_type == FLOAT_TYPE) printf("%-7s","float");
			else if (l->st_type == STR_TYPE) printf("%-7s","string");
			else if (l->st_type == ARRAY_TYPE){
				printf("array of ");
				if (l->inf_type == INT_TYPE) 		   printf("%-7s","int");
				else if (l->inf_type  == FLOAT_TYPE)    printf("%-7s","float");
				else if (l->inf_type  == STR_TYPE) 	   printf("%-7s","string");
				else printf("%s","undef");
			}
			else printf("%s","undef"); // if UNDEF or 0
			while (t != NULL){
				printf("%4d ",t->lineno);
			t = t->next;
			}
			printf("\n");
			l = l->next;
		}
    }
  }
}

