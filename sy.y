%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
char sauvType[50]; 
char IDDF[50];
char *yytext;
extern char typpe[20];
char typpe2[20];
int nbligne=1;
int taille=1;
extern int tail;
int inst=0;
int yylex();
int yyerror(char *s);
%}
%union {
	int _entier;
	float _reelle;
	 char chaine[12];
	}

%token mc_pgm mc_integer mc_real mc_const mc_if mc_while mc_exec       bib_calcul bib_tab bib_boucle       sb_eg sb_diff sb_inf sb_infeg sb_sup sb_supeg
%token       sb_aff sp_var
%token <_entier>_entiere <_reelle>_reelle <chaine>id
%token       '{' '}' ',' ';' '+' '*' '/' '-' '[' ']' '(' ')'

%%

S : BIBL mc_pgm id '{'  DEC  INST '}' { printf("\nLe programme marche correctement\n"); }
;

BIBL : bib_calcul BIBL     
     | bib_tab BIBL        
     | bib_boucle BIBL 
     | 
;


DEC : TYPE {inst=0;} NVAR ';'{setEntite( sauvType,taille); taille=1;inst=1;} MOREDEC 
     | mc_const NVAR ';'MOREDEC 
;

MOREDEC : DEC 
	|  
;

NVAR : VAR MOREVAR 
;

MOREVAR : sp_var NVAR 
	|  
;

VAR : id '[' _entiere ']' {taille=$3;if(inst==1){getTaille(IDDF);if(tail>1){if(tail<taille){printf("Depassement De La Taille Du Tableau\n");}}else{ printf("Ce N'est Pas Un Tableau\n");}}}
     |id ',' {/*setEntite(sauvType,taille)*/;strcpy(IDDF,"");} VAR 
     |id
;



TYPE : mc_integer {strcpy(sauvType,"Entier");}
     | mc_real	 {strcpy(sauvType,"Reel"); }
;

CST : _entiere {if(inst==1){getSymbol(IDDF);if(strcmp(typpe,"Entier")!=0){ printf("Non comptabilité du type ! \n");}}}
    | _reelle {if(inst==1){getSymbol(IDDF);if(strcmp(typpe,"Reel")!=0){ printf("Non comptabilité du type ! \n");}}}
;


INST : INST_AFF MOREINST 
     | INST_IF MOREINST 
     | INST_WHL MOREINST 
;

MOREINST : INST 
	 | 
;

INST_AFF: VAR sb_aff EXP1 ';' 
;

EXP1 : EXP2 '+' EXP1 
     | EXP2 '-' EXP1 
     | EXP2 
;

EXP2 : EXP3 '*' EXP2 
     | EXP3 '/' EXP2 
     | EXP3 
;

EXP3 : VAR  
     | CST 
;

INST_IF : mc_exec INST mc_if '(' COND ')' 
;

INST_WHL : mc_while '(' COND ')' '{' INST '}'
;

COND : EXP1 COMPARATEUR EXP1
;

COMPARATEUR : sb_eg
	    | sb_diff
	    | sb_inf
	    | sb_infeg
	    | sb_sup
	    | sb_supeg
;
      
%%
int main()

{yyparse();
}

int yywrap()
{return 1;}

int yyerror(char *msg) 
{printf("\nERREUR SYNTAXIQUE : a la ligne %d\n",nbligne);	return 1;}
