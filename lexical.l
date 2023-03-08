%option noyywrap
%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "parser.tab.h"
char* ValToString();
%}

delim [\t ]
digit [0-9]
letter [A-Za-z]
pharan [()]
number {digit}+(.{digit}+)?
id {letter}({letter}|{digit})*
newline [\n]

%%
{number}|{id}               { yylval.word = ValToString(); return VALUE; }
":D:"|":M:"|":S:"|":A:"     { return yytext[1]; }
"="                         { return yytext[0]; }
{pharan}                    { return yytext[0]; }
{delim}                     ;
{newline}                   { return 0; }

%%

char* ValToString() {
    char* StringNum = (char *)malloc(100);
    strcpy(StringNum, yytext);
    return StringNum;  
}