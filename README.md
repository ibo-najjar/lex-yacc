# lex-yacc

      lex mpl.l
      yacc -d mpl.y
      cc lex.yy.c y.tab.c -o filename

### to only test the lex file use

        cc lex.yy.c -o -ll

