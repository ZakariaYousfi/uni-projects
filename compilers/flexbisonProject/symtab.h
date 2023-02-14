/* maximum size of hash table */
#define SIZE 211

/* maximum size of tokens-identifiers */
#define MAXTOKENLEN 40

/* token types */
#define UNDEF 0
#define INT_TYPE 1
#define FLOAT_TYPE 2
#define CHAR_TYPE 3
#define STR_TYPE 4

#define VAR_TYPE 0
#define ARRAY_TYPE 1

/* a linked list of references (lineno's) for each variable */
typedef struct RefList{ 
    int lineno;
    struct RefList *next;
    int type;
}RefList;

// struct that represents a list node
typedef struct list_t{
	char st_name[MAXTOKENLEN];
    int st_size;
    RefList *lines;
	// to store value and sometimes more information
	int st_ival; double st_fval; char *st_sval;
	// type
    int st_type;
	int inf_type; // for arrays (info type) and functions (return type)
	// array stuff
	int array_size;
	// pointer to next item in the list
	int const_type;
	struct list_t *next;
}list_t;

/* the hash table */
static list_t **hash_table;

// Function Declarations
void init_hash_table(); // initialize hash table
unsigned int hash(char *key); // hash function 
void insert(char *name, int len, int type, int lineno); // insert entry
void set_type(char* name, int inf_type, int st_type, int const_type);
int get_type(char* name);
int get_const(char* name);
void set_value(char* name, int inf_type, int st_type, int array_size, int const_type);
list_t *lookup(char *name); // search for entry
void symtab_dump(); // dump file

