%{
#include <string.h>
#include "y.tab.h"
%}

%%

[ \t]                   ;
;\n|;|\n                {return ';';}
[\[\]<>,\(\)]           {return yytext[0];}
\{([ \t\n]+)?           {return '{';}
\}                      {return '}';}
\+\+|\+|\-\-|\-|\*|\/|=~|\.\.|= {yylval.string = strdup(yytext); return OP;}
[0-9]+                  {yylval.integer = atoi(yytext); return INT;} 
\"([^\"]|\\\")+\"       {yylval.string = strdup(yytext); return STRING;}
\/([^\/]|\\\/)+\/       {yylval.string = strdup(yytext); return REGEX;}
[a-zA-Z0-9_]+:          {yylval.string = strdup(yytext); return LABEL;}
\$?[a-zA-Z0-9_]+        {yylval.string = strdup(yytext); return NAME;}
.                       {ECHO; yyerror("unexpected character");}

%%

int yywrap() {return 1;}

