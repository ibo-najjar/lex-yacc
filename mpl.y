%{
  #include <stdio.h>  
  #include <string.h>  
  #include <stdlib.h>
  
  int yylex();
  void yyerror(char *message);
  extern yylineno;
 
%}

%locations
%start PROGRAM 
%token startProgram endProgram
%token greaterEqual lessEqual isEqual notEqual  
%token logicOp_and logicOp_or logicOp_not
%token floatType charType intType 
%token loop end_loop if_statement elif_statement default_statement logStatment 
%token identifier floatVal integerVal charVal

%nonassoc elif_statement
%nonassoc default_statement
%right greaterEqual lessEqual
%right greater less
%right isEqual notEqual
%left '+' '-'
%left '*' '/'
%right not
%right and 
%right or



%%
PROGRAM: startProgram line
       ;

line: stmt
    | line stmt
    ;

stmt:    ';'
    | endProgram {printf("PROGRAM ENDED NUMBER OF LINES >> %d",yylineno);}
    | conditions ';'
    | ifStruct 
    | loopStruct
    | logStatment '(' conditions ')'';' 
    | assignment ';'
    | declartion ';'
    ;

declartion: intType identifier
          | charType identifier
          | floatType identifier
          ;

conditions: expr 
          | conditions isEqual expr 
          | conditions notEqual expr 
          | conditions greater expr 
          | conditions less expr 
          | conditions greaterEqual expr 
          | conditions lessEqual expr 
          ;

expr: term 
    | '-' term 
    | expr '+' term 
    | expr '-' term 
    ;
    
term: factor 
    | term '*' factor 
    | term '/' factor 
    | term '%' factor 
    ;

factor: integerVal 
      | floatVal 
      | charVal
      | '(' conditions ')'
      ;

assignment: declartion '=' conditions
          | identifier '=' conditions 
          ;


ifStruct: 
        if_statement '(' conditions ')' ':' stmt              %prec elif_statement
        | if_statement '(' conditions ')' ':' stmt default_statement ':' stmt
        ;

loopStruct: loop '(' conditions ')' ':' line end_loop '(' conditions ')' ';'




%%

int main(void){
/*
printf("⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣷⣦⠀⠀⠀⠀⠀⠀⠀⠀\n")⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
printf("⠀⠀⠀⠀⠀⠀⠀⣀⣶⣿⣿⣿⣿⣿⣿⣷⣶⣶⣶⣦⣀⡀⠀⢀⣴⣇⠀⠀⠀⠀\n")
printf("⠀⠀⠀⠀⠀⢠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀\n")
printf("⠀⠀⠀⠀⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀\n")
printf("⠀⠀⠀⣴⣿⣿⣿⣿⠛⣿⣿⣿⣿⣿⣿⣿⣿⡿⣿⣿⣿⣿⣿⣿⣿⣿⣄⠀⠀⠀\n")
printf("⠀⠀⣾⣿⣿⣿⣿⣿⣶⣿⣯⣭⣬⣉⣽⣿⣿⣄⣼⣿⣿⣿⣿⣿⣿⣿⣿⣷⡀⠀\n")
printf("⠀⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄\n")
printf("⢸⣿⣿⣿⣿⠟⠋⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠁⣿⣿⣿⣿⡿⠛⠉⠉⠉⠉⠁\n")
printf("⠘⠛⠛⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠛⠛⠛⠃⠀⠀⠀")
printf("\n------------------------------\nWELCOME TO OUR LEX-YACC PROGRAM\n>> THE PROGRAM SHOULD START WITH (>>)\n>> PROGRAM ENDS WITH (<<)\n>> WE KNOW HOW FRUSTRATING IT IS TO WRITE CODE IN CASE SENSITIVE PROGRAMS SO GUESS WHAT MPL IS CASE-INSENSITIVE!!\n");*/

    yyparse();
    printf("YOU ARE A SMOOTH DUDE !!\nCODE COMPILED WITH NO ERRORS");
}

void yyerror(char *message) {
    fprintf(stderr, "Error | Line: %d >> %s\n",yylineno,message);
    exit(0);
}
