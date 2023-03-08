%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#define HASHSIZE 101


extern int yylex();
int tmpCount = 1, res_status = 1;
void yyerror(char *str);
struct nlist *lookup(char *s);
char *strduplicate(char *);
unsigned hash(char *s);
static struct nlist *hashtab[HASHSIZE];
struct nlist *install(char *name, char *defn, float value);
char* concatenateFOPF(char* factor1, char *operand, char* factor2);
float result = 0.0;
struct nlist {
    struct nlist *next;
    char *name;
    char *defn;
    float value;
};
char *assign, *finalVAR;

%}

%union{
    char* word;
    struct  {
                int status;
                char * val;
            }
    type;
}

%type<type> S E T F
%token<word> VALUE

%%
Q   :VALUE '=' S    { 
                        assign = malloc(100); strcpy(assign ,$1);
                        char* finalText = malloc(30);
                        printf("%s = %s", assign, finalVAR);
                        if (res_status) printf("\nResult of %s = %f", assign, result);
                    }
    ;

S   :E              { $$.status = $1.status; $$.val = $1.val; finalVAR = malloc(30); strcpy(finalVAR, $$.val); if($1.status) res_status = 0; }
    ;

E   :T 'A' E        { $$.status = 0; $$.val = concatenateFOPF($3.val, "+", $1.val); }
    |T 'S' E        { $$.status = 0; $$.val = concatenateFOPF($3.val, "-", $1.val); }
    |T              { $$.status = $1.status; strcpy($$.val, $1.val); }
    ;
    
T   :F 'D' T        { $$.status = 0; $$.val = concatenateFOPF($3.val, "/", $1.val); }
    |F 'M' T        { $$.status = 0; $$.val = concatenateFOPF($3.val, "*", $1.val); }
    |F              { $$.status = $1.status; strcpy($$.val ,$1.val); }
    ;
     
F   : '(' E ')'     { $$.status = $2.status; $$.val = $2.val; }
    |VALUE          { $$.status = 1; $$.val = malloc(100); strcpy($$.val ,$1); }
    ;

%%
int main(){
    yyparse();
    return 0;
}

void yyerror(char *str)  {
    fprintf(stderr,"\n%s\n", str);
    exit(1);
}

 char* concatenateFOPF(char* factor1, char *operand, char* factor2) {
        char* text = malloc(30);
        char* regName = malloc(30);
        snprintf(text, 9, "t%d", tmpCount++);
        snprintf(regName, 9, "t%d", tmpCount - 1);
        int tmpRes;
        printf("%s = %s %s %s\n", text, factor1 , operand, factor2);
        float f1, f2;
        if(lookup(factor1))
            f1 = lookup(factor1)->value;
        else if (isalpha(factor1[0])){
            res_status = 0;
            return text;
        }   
        else
            f1 = atof(factor1);

        if(lookup(factor2))
            f2 = lookup(factor2)->value;
        else if (isalpha(factor2[0])){
            res_status = 0;
            return text;
        } 
        else 
            f2 = atof(factor2);

        result = (*operand == '+')? (f1 + (float)f2):
                    (*operand == '-')? (f1 - (float)f2):
                    (*operand == '*')? (f1 * (float)f2):
                    (*operand == '/')? (f1 / (float)f2): (float)0;
        tmpRes = result;
        install(regName, regName, tmpRes);
        return text;
    }



// ------------- dictionary implimentation -------------

/*
* Refrence: https://stackoverflow.com/questions/4384359/quick-way-to-implement-dictionary-in-c
*/

/* hash: form hash value for string s */
unsigned hash(char *s)
{
    unsigned hashval;
    for (hashval = 0; *s != '\0'; s++)
      hashval = *s + 31 * hashval;
    return hashval % HASHSIZE;
}

/* lookup: look for s in hashtab */
struct nlist *lookup(char *s)
{
    struct nlist *np;
    for (np = hashtab[hash(s)]; np != NULL; np = np->next)
        if (strcmp(s, np->name) == 0)
          return np; /* found */
    return NULL; /* not found */
}

/* install: put (name, defn) in hashtab */
struct nlist *install(char *name, char *defn, float value)
{
    struct nlist *np;
    unsigned hashval;
    if ((np = lookup(name)) == NULL) { /* not found */
        np = (struct nlist *) malloc(sizeof(*np));
        if (np == NULL || (np->name = strduplicate(name)) == NULL)
          return NULL;
        hashval = hash(name);
        np->next = hashtab[hashval];
        np->value = value;
        hashtab[hashval] = np;
    } else /* already there */
        free((void *) np->defn); /*free previous defn */
    if ((np->defn = strduplicate(defn)) == NULL)
       return NULL;
    return np;
}

char *strduplicate(char *s) /* make a duplicate of s */
{
    char *p;
    p = (char *) malloc(strlen(s)+1); /* +1 for ’\0’ */
    if (p != NULL)
       strcpy(p, s);
    return p;
}



