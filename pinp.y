%{
#include <stdio.h>
void yyerror(const char *s);
%}

%union {char * string; int integer;}
%start LINE
%token <string>   OP STRING REGEX LABEL NAME
%token <integer>  INT
/*%type  <string> LINE BLOCK*/

%%

LINE   : EXPR ';' LINE
       | LABEL EXPR ';' LINE
       | ';'
       | /* nothing */
       ;
EXPR   : NAME ARGS BLOCK
       | '{' NAME ARGS BLOCK '}' NAME ARGS BLOCK /* XXX */
       | NAME OP EXPR
       | '(' EXPR ')'
       | VALUE
       ;
BLOCK  : '{' LINE '}'
       | /* nothing */
       ;
ARGS   : '(' EARGS ')'
       | AARGS /* XXX */
       ;
AARGS  : ARG ',' AARGS
       | ARG
       | /* nothing */
       ;
ARG    : NAME
       | VALUE
       ;
EARGS  : EXPR ',' EARGS
       | EXPR
       | /* nothing */
       ;
VALUE  : STRING
       | INT
       | REGEX
       | '[' VALUE ']'
       | '<' NAME '>'
       | '<' '>'
       ;
%%

int main() {return yyparse();}

void yyerror(const char *s) {fprintf(stderr, "%s\n", s);}
