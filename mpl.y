%{
  #include <stdio.h>
  #include <string.h>
  #include <stdlib.h>

  extern int yylex();
  void yyerror(char *s);
  extern int yylineno;

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


line: stmt
    | line stmt 
    ;

stmt:    ','
    | exp ','
    | exp IS exp ','
    | exp ISNT exp ','
    | ifStruct
    | loopStruct
    | END {printf("-------------\nPROGRAM ENDED NUMBER OF LINES >> %d\n",yylineno);exit(0);}
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
    yyparse();
    printf("WOWOWOOWOWOWWW");
    return 0;
}
