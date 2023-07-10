%{
	#include<stdio.h>
    #include<string.h>
    #include <math.h>
    #include <stdlib.h>
    #include <ctype.h>
    int yylex();
    int yywrap(void);
    void yyerror(char const *);
    extern FILE *yyin,*yyout,*lexout;
%}

%union{
    int number;
    float decimal;
    char *str;
}


%token NEWLN COMA SEMICO LEFTP RIGHTP RIGHT_SQBR LEFT_SQBR MINUS ADD MULTIP DIVIDE EXPO XOR OR AND NOT LET PRINT DEF END STEP STOP RETURN FN REM INPUT THEN TO IF GOTO GOSUB NEXT FOR DIM DATA NE EQ GE LE GT LT STRING TYPE_ID 

%left MINUS ADD MULTIP DIVIDE EXPO XOR OR AND NOT LEFTP RIGHTP LEFT_SQBR RIGHT_SQBR NE EQ GE LE GT LT

%token <str> ID
%token <int> C_INT
%token <decimal> NUM

%%

programs:program
    |programs program
    ;

program:C_INT LET ID EQ expr            
    |C_INT LET TYPE_ID EQ expr          
    |C_INT DIM dec                      
    |C_INT ID                           
    |C_INT IF bool THEN C_INT      
    |C_INT TYPE_ID                      
    |C_INT INPUT inputv                 
    |C_INT DEF FN x                     
    |C_INT GOSUB C_INT                  
    |C_INT GOTO C_INT                   
    |C_INT PRINT                 
    |C_INT PRINT exprint                
    |C_INT REM                          
    |C_INT RETURN                      
    |C_INT DATA dat                     
    |C_INT STOP                         
    |C_INT FOR ID EQ expr TO expr 
    |C_INT FOR ID EQ expr TO expr STEP expr
    |C_INT NEXT ID
    |C_INT END                           
    ;


exprint:expr delimiter exprint
    |expr delimiter
    |expr
    ;

delimiter: COMA | SEMICO
         ;






inputv:ID
    |TYPE_ID
    |ID LEFTP C_INT RIGHTP 
    |TYPE_ID LEFTP C_INT RIGHTP 
    |ID LEFTP C_INT RIGHTP COMA inputv
    |TYPE_ID LEFTP C_INT RIGHTP COMA inputv
    |ID COMA inputv
    |TYPE_ID COMA inputv
    |inputv COMA ID LEFTP C_INT RIGHTP 
    |inputv COMA ID
    ;



x:
    EQ fnexpr
    |LEFTP para RIGHTP EQ fnexpr
    ;
fnexpr:
    MINUS fnterm
    |fnterm                                  
    |fnterm ADD fnexpr                        
    |fnterm MINUS fnexpr                      
    ;
fnterm:
    fnfactor                                
    |fnfactor MULTIP fnterm                 
    |fnfactor DIVIDE fnterm                 
    ;
fnfactor:
    fnext
    |fnext EXPO fnfactor
    ;
fnext:
    NUM
    |para
    |LEFTP fnexpr RIGHTP
    ;
para:
    ID
    |TYPE_ID
    ;

dec:
    dec1
    |dec2
    |dec1 COMA dec
    |dec2 COMA dec
    ;
dec1:
    ID LEFTP C_INT RIGHTP
    |TYPE_ID LEFTP C_INT RIGHTP
    ;
dec2:
    ID LEFTP C_INT COMA C_INT RIGHTP
    |TYPE_ID LEFTP C_INT COMA C_INT RIGHTP
    ;

 expression:expr1
              |expression ADD expr1
              |expression MINUS expr1;

    expr1:expr2
         |expr1 MULTIP expr2
         |expr1 DIVIDE expr2;

    expr2:expr3
         |MINUS expr2;

    expr3:expr4
          |expr3 EXPO expr4;

    expr4:NUM
         |C_INT
         |STRING
         |ID
         |TYPE_ID
         |LEFTP expression RIGHTP
         |ID LEFTP expression RIGHTP
         ;

         
    bool:expression EQ expression
        |expression NE expression
        |expression LT expression
        |expression GT expression
        |expression LE expression
        |expression GE expression
        |bool AND bool
        | NOT expression
        |bool OR bool
        |expression
        ;


expr:loexpr
    |loexpr OR expr
    |loexpr NOT expr
    |loexpr XOR expr
    |loexpr AND expr
    ;

loexpr:reexpr
    |reexpr LT loexpr
    |reexpr LE loexpr
    |reexpr GT loexpr
    |reexpr GE loexpr
    |reexpr NE loexpr
    |reexpr EQ loexpr
    ;

reexpr:term                                
    |MINUS term                        
    |term ADD reexpr                       
    |term MINUS reexpr                      
    ;
term:factor                                
    |factor MULTIP term                   
    |factor DIVIDE term                   
    ;
factor:
    ext
    |ext EXPO factor
    ;
ext:
    NUM
    |STRING
    |C_INT
    |ID
    |TYPE_ID
    |LEFTP expr RIGHTP
    ;  

dat: var
    |var COMA dat
    ;
var: C_INT
    |NUM
    |STRING
    ;
%%

int main(int argc,char **argv)
{
    //yyin=fopen("CorrectSample.bmm","r");
    yyin=fopen("InCorrectSample.bmm","r");
    if (yyin == NULL) {
        printf("Error: Unable to open file\n");
        return 1;
    }
    
    lexout =fopen("lexer.txt","w");
    yyparse();
    return 0;
}

void yyerror(char const *s)
{   
   
    fprintf(stderr,"%s\n",s);
}