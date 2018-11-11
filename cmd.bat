flex lexical.l
bison -d sy.y --report=state
gcc lex.yy.c sy.tab.c -lfl -ly -o com