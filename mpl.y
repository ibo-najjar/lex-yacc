%{
  #include <stdio.h>  
  #include <string.h>  
  #include <stdlib.h>
  
  
  extern yylineno;
  int yylex(void);
  void yyerror(char *message);
 
%}


%locations
%token int integerVal
%token char charVal
%token float floatVal
%token greaterEqual lessEqual isEqual notEqual log_stm 
%token logicOp_and logicOp_or logicOp_not loop end_loop if_statement elif_statement default_statement identifier
%token dataType
%right '='
%left '*' '/'
%left '+' '-'
%right not
%right and 
%right or



%%

line        : stmt
            | line stmt
            ;
            
ifstruct    : if_statement '(' condition ')' stmt ';' 
            | if_statement '(' condition ')' stmt ';' default_statement stmt ';' 
            | if_statement '(' condition ')' ifstruct ';' 
            | if_statement '(' condition ')' ifstruct ';' default_statement ifstruct ';'
            | if_statement '(' condition ')' stmt ';' default_statement ifstruct ';'
            | if_statement '(' condition ')' ifstruct ';' default_statement stmt ';'
            | ifstruct ifstruct
            ;

stmt        :        
            ';'
            | expr ';'
            | assignment expr ';'
            | declaration '=' expr ';'
            | declaration ';'
            | ifstruct 
            | assignment ';'
            ;

condition   : expr isEqual expr       {$$ = $1 == $3;}
            | expr notEqual expr      {$$ = $1 != $3;}
            | expr greaterEqual expr  
            | expr lessEqual expr
            | expr '>' expr
            | expr '<' expr
            | expr
            ;


expr        : integerVal        {$$ = $1;}
            | floatVal          {$$ = $1;}         
            | identifier 
            | expr '-' expr     {$$ = $1 - $3;}
            | expr '+' expr     {$$ = $1 + $3;}
            | expr '*' expr     {$$ = $1 * $3;}
            | expr '/' expr     {if($3)$$= $1 / $3; else yyerror("DIVISION BY 0");}
            | expr '=' expr     {$$ = $1;}
            | expr logicOp_or expr {$1 | $3;}
            | expr logicOp_and expr {$1 & $3;}
            ;

assignment  : identifier '=' expr
            | declaration '=' expr
            ;
          
declaration : int identifier
            | float identifier
            | char identifier
            ;


%%
void yyerror(char *msg) {
    fprintf(stderr, "Error | Line: %d\n%s >> %s\n",yylineno,str,msg);
    exit(0);
}
int main(){
    printf("\t\twelcome to my dope lexical analayzer and parser\t\t\n>> please enter code *~* :\n")
    yyparse();
    printf("YOU ARE A SMOOTH DUDE !!\nCODE COMPILED WITH NO ERRORS");
}
