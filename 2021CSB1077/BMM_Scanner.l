%{

#include <stdio.h>
#include <string.h>
#include <math.h>
#include "BMM_Parser.tab.h"
FILE *lexout;

%}


%%

" "*                { /* ignore whitespace */ }
\n                  { fprintf (lexout,"NEWLN\n "); }
(\".*\")            { fprintf (lexout,"STRING : %s\n",yytext); return STRING; }
[0-9]+              { fprintf (lexout,"INTEGER :%d\n",yylval.number = atoi(yytext)); return C_INT; }
[0-9]*\.[0-9]+      { fprintf (lexout,"DECIMAL: %f\n",yylval.decimal = atof(yytext)); return NUM; }
REM.*\n             {fprintf (lexout,"REM\n"); return REM; }
[A-Z]+[0-9]*[$%#!]  {fprintf (lexout,"TYPE_ID\n"); return TYPE_ID; }
"LET"               {fprintf (lexout,"LET\n"); return LET; }
"PRINT"             {fprintf (lexout,"PRINT\n"); return PRINT; }
"IF"                {fprintf (lexout,"IF\n"); return IF; }
"THEN"              {fprintf (lexout,"THEN\n"); return THEN; }
"GOTO"              {fprintf (lexout,"GOTO\n"); return GOTO; }
"GOSUB"             {fprintf (lexout,"GOSUB\n"); return GOSUB; }
"END"               {fprintf (lexout,"END\n"); return END; }
"DATA"              {fprintf (lexout,"DATA\n"); return DATA; }
"DEF"               {fprintf (lexout,"DEF\n"); return DEF; }
"FN"[A-Z]           {fprintf (lexout,"FN\n"); return FN; }
"FOR"               {fprintf (lexout,"FOR\n"); return FOR; }
"TO"                {fprintf (lexout,"TO\n"); return TO; }
"STOP"              {fprintf (lexout,"STOP\n"); return STOP; }
"STEP"              {fprintf (lexout,"STEP\n"); return STEP; }
"NEXT"              {fprintf (lexout,"NEXT\n");return NEXT; }
"XOR"               {fprintf (lexout,"XOR\n"); return XOR; }
"OR"                {fprintf (lexout,"OR\n"); return OR; }
"NOT"               { fprintf (lexout,"NOT\n");return NOT; }
"AND"               {fprintf (lexout,"AND\n"); return AND; }
"DIM"               {fprintf (lexout,"DIM\n"); return DIM; }
"INPUT"             {fprintf (lexout,"INPUT\n"); return INPUT; }
"RETURN"            {fprintf (lexout,"RETURN\n");return RETURN;} 

[\(]                {fprintf (lexout,"LEFTP\n"); return LEFTP; }
[\)]                {fprintf (lexout,"RIGHTP\n"); return RIGHTP; }
[\[]                {fprintf (lexout,"LEFT_SQBR\n"); return LEFT_SQBR;}
[\]]                {fprintf (lexout,"RIGHTSQBR\n"); return RIGHT_SQBR;}
"^"		            {fprintf (lexout,"EXPO\n");return EXPO;}
"/"                 {fprintf (lexout,"DIVIDE\n"); return DIVIDE; }
"*"                 {fprintf (lexout,"MULTIP\n"); return MULTIP; }
"+"                 {fprintf (lexout,"ADD\n"); return ADD; }
"-"                 {fprintf (lexout,"MINUS\n"); return MINUS; }
";"		            {fprintf (lexout,"SEMICO\n");return SEMICO;}
","		            {fprintf (lexout,"COMA\n");return COMA;}
"<"                 {fprintf (lexout,"LT\n"); return LT; }
">"                 {fprintf (lexout,"GT\n"); return GT; }
"<="                {fprintf (lexout,"LE\n"); return LE; }
">="                {fprintf (lexout,"GE\n");return GE; }
"="                 {fprintf (lexout,"EQ\n");return EQ; }
"<>"                {fprintf (lexout,"NE\n");return NE; }

[A-Z]+[0-9]*        {fprintf (lexout,"IDENTIFIER %s\n",yylval.str = strdup(yytext)); return ID; }
.                   {printf("Invalid character: %s\n", yytext); }

%%


int yywrap(){
    return 1;
}

