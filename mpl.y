%{
  #include <stdio.h>
  #include <string.h>
  #include <stdlib.h>
  extern int yylineno;
  extern int yylex();
  void yyerror(char *s);
%}
%token GE LE IS ISNT
%token AND OR NOT
%token REAL ALPHA NUMBER
%token UNTIL DO END_LOOP IF ELSE_IF DEFUALT THEN END_IF
%token IDENTIFIER
%token NUMBERVAL ALPHAVAL REALVAL
%token END
%nonassoc LOWER_ELSE
%nonassoc DEFAULT
%right GE LE '<' '>' IS ISNT
%left NOT
%left OR
%left AND
%left '+' '-'
%left '*' '/'
%%
program: stmt
    | program stmt 
    ;

stmt:    ','
    | exp ','
    | ifStruct
    | loopStruct
    | END {printf("--------------------------------------------------------\nPROGRAM EXECUTED WITH NO ERRORS NUMBER OF LINES >> %d\n",yylineno);exit(0);}
    ;

exp:
    | IDENTIFIER
    | literal
    | declartion
    | exp IS exp    
    | exp ISNT exp    
    | exp '+' exp
    | exp '-' exp
    | exp '*' exp
    | exp '/' exp
    | exp LE exp
    | exp GE exp
    | exp OR exp
    | exp AND exp
    | exp NOT exp
    | exp '>' exp
    | exp '<' exp
    | '(' exp ')'
    ;

declartion: REAL IDENTIFIER
          | ALPHA IDENTIFIER
          | NUMBER IDENTIFIER
          ;

ifStruct: IF exp THEN stmt %prec LOWER_ELSE 
        | IF exp THEN stmt DEFAULT THEN stmt
        ;
    
loopStruct: UNTIL exp DO stmt END_LOOP
          ;

literal: NUMBERVAL
       | ALPHAVAL
       | REALVAL
       ;

%%

void yyerror(char *s) {
    fprintf(stderr, "Error | Line: %d >> %s\n",yylineno,s);
    exit(0);
}
int main(){
printf(" _____                    _                           _       \n");
printf("|  __ \\                  | |                         | |      \n");
printf("| |__) |__  ___ _   _  __| | ___ ______ ___ _   _  __| | ___  \n");
printf("|  ___/ __|/ _ \\ | | |/ _` |/ _ \\______/ __| | | |/ _` |/ _ \\ \n");
printf("| |   \\__ \\  __/ |_| | (_| | (_) |     \\__ \\ |_| | (_| | (_) |\n");
printf("|_|   |___/\\___|\\__,_|\\__,_|\\___/      |___/\\__,_|\\__,_|\\___/ \n");
printf("\n\tWELCOME PLEASE START WRITING CODE AND TO END JUST TYPE END\n--------------------------------------------------------\n");
    yyparse();
    return 0;
}
