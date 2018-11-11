%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "sy.tab.h"
#include "TS.h"
extern YYSTYPE yylval;
extern  int nbligne;
int nbcolonne=1;
extern  int nbmot;
extern char opp[10];
extern YYSTYPE yylval;
extern char *yytext;
extern int erreurL;
extern int inst;
extern char IDDF[12];
int i=0;
%}
chiffre0 [0-9]
chiffre1 [1-9]
_idf [A-Z][A-Za-z0-9]*
_entier {chiffre1}{chiffre0}*|0
_decimal {chiffre0}+\.{chiffre0}+
_comment "//".*"//"
_aff ":="
_sp "||"
_eg "=="
_diff "!="
_sup ">"
_supeg ">="
_inf "<"
_infeg "=<"
multil_comment "//"([^//]*("*"+[^*/])*)+"//"
type _entier
%%
[{},;+*/-] return yytext[0];
\[ return yytext[0];
\] return yytext[0];
\( return yytext[0];
\) return yytext[0];
[ \t] 
\n {nbligne++; printf("\n%d: ",nbligne);}
TS  afficher();
#CALCUL 	{ nbcolonne=nbcolonne+yyleng; return bib_calcul;}
#TAB 		{ nbcolonne=nbcolonne+yyleng; return bib_tab;}
#BOUCLE 	{ nbcolonne=nbcolonne+yyleng; return bib_boucle;}
CONSTANT 	{ nbcolonne=nbcolonne+yyleng; return mc_const;}
EXECUTE 	{ nbcolonne=nbcolonne+yyleng; return mc_exec;}
IF 			{ nbcolonne=nbcolonne+yyleng; return mc_if;}
WHILE 		{ nbcolonne=nbcolonne+yyleng; return mc_while;}
PROGRAMME 	{ nbcolonne=nbcolonne+yyleng; return mc_pgm;}
INTEGER 	{ nbcolonne=nbcolonne+yyleng; return mc_integer;}
REAL 		{ nbcolonne=nbcolonne+yyleng; return mc_real;}



{_decimal} { nbcolonne=nbcolonne+yyleng; return _reelle; }
{_entier} 	{yylval._entier=atoi(yytext);nbcolonne=nbcolonne+yyleng; return _entiere; }
{_aff} 	{ nbcolonne=nbcolonne+yyleng; return sb_aff; }
{_eg} 		{ nbcolonne=nbcolonne+yyleng; return sb_eg; }
{_diff} 	{ nbcolonne=nbcolonne+yyleng; return sb_diff; }
{_sup} 	{ nbcolonne=nbcolonne+yyleng; return sb_sup; }
{_supeg} 	{ nbcolonne=nbcolonne+yyleng; return sb_supeg; }
{_inf} 	{ nbcolonne=nbcolonne+yyleng; return sb_inf; }
{_infeg} 	{ nbcolonne=nbcolonne+yyleng; return sb_infeg; }
{_sp} 		{ nbcolonne=nbcolonne+yyleng; return sp_var; }
{_comment} {nbcolonne=nbcolonne+yyleng;}
{_idf}		{ {if(inst==0){if(yyleng<=12) {if(dejaDeclare(yytext)==1) {printf("IDF Double Declare");}else{strcpy(IDDF,yytext);AjoutIDF(IDDF);if(i==0){i++ ;inserer(yytext,"IDF");setEntite("IDF_PROG",0);} else {inserer(yytext,"IDF");}return(id);}} else {printf("Erreur lexicale dans ligne: %d, colone: %d \n Depassement De Taille !",nbligne,nbcolonne);}
}else
{if(dejaDeclare(yytext)==0) printf("\nIDF Non Declare\n");else{strcpy(IDDF,yytext);nbcolonne=nbcolonne+yyleng; return id; }
}
}
}
{multil_comment} {int i = 0;
	while (i < yyleng)
	{
		if (yytext[i] == '\n'){ nbligne++;
        printf("\n%d: ",nbligne);
        }
		i++;
	}}
. printf("\nERREUR LEXICALE: caractere inconnu : %s ! LIGNE : %d COLONNE : %d\n",yytext,nbligne,nbcolonne);

%%
