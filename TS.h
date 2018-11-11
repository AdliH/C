#include<string.h>
typedef struct
{
	char nomEntite[20];
	char codeEntite[50];
	char type[20];
	int taille;
	int Valeurr;
} TypeTS;

typedef struct ListeTS ListeTS;
struct ListeTS
{
	ListeTS *suiv;
	TypeTS info;
};
typedef struct ListeV ListeV;
char typpe[20];
int tail=0;
struct ListeV
{
	ListeV *suiv;
	char info[20];
	char Typ[50];
};

ListeV *T;
ListeTS *teteTS;
extern int nbligne;
extern int nbcolonne;

void  getSymbol(char * entite){
	ListeTS *temp=teteTS;
	
	while(temp!=NULL){
		if(strcmp(temp->info.nomEntite,entite)==0)
		{
		
		strcpy(typpe,temp->info.type);
		}
				temp=temp->suiv;
	}
	//printf("NOT FOUND");
	
}
void  getTaille(char * entite){
	ListeTS *temp=teteTS;

	while(temp!=NULL){
		if(strcmp(temp->info.nomEntite,entite)==0)
		{
			
	tail=temp->info.taille;
	
		}
				temp=temp->suiv;
	}
	//printf("NOT FOUND");
	
}



ListeTS * rechercher(char * entite){
	ListeTS *temp=teteTS;
	while(temp!=NULL){
		if(strcmp(temp->info.nomEntite,entite)==0){
			return temp;
		}
		temp=temp->suiv;
	}
	return NULL;
}

int dejaDeclare(char * entite){
	if(rechercher(entite)==NULL){
		return 0;
	}
	return 1;
}
void AjoutIDF(char * idf)
{
	if(T==NULL){
				T=(ListeV*)malloc(sizeof(ListeV));
		strcpy((*T).info,strdup(idf));
		(*T).suiv=NULL;
		//printf("La Tete est %s",(*T).info);
	}
	else{
	ListeV *temp=T;
	
			while((*temp).suiv!=NULL){
			
				temp=(*temp).suiv;
				
			}
				
			(*temp).suiv=(ListeV*)malloc(sizeof(ListeV));
			//printf("Arrivé");	
			strcpy((*((*temp).suiv)).info,strdup(idf));
			(*((*temp).suiv)).suiv=NULL;
			
			
		
	}
		
	
}
void inserer(char * entite, char * code){
	
		
	if(teteTS==NULL){
		teteTS=(ListeTS*) malloc(sizeof(ListeTS));
		strcpy((*teteTS).info.nomEntite,strdup(entite));
		strcpy((*teteTS).info.codeEntite,strdup(code));
		strcpy((*teteTS).info.type,"?");
		(*teteTS).info.taille=0;
		(*teteTS).suiv=NULL;
	}else{
		ListeTS *temp=teteTS;
		if(rechercher(entite)==NULL){
			while((*temp).suiv!=NULL){
				temp=(*temp).suiv;
			}
			(*temp).suiv=(ListeTS*) malloc(sizeof(ListeTS));
			strcpy((*((*temp).suiv)).info.nomEntite,strdup(entite));
			strcpy((*((*temp).suiv)).info.codeEntite,strdup(code));
			strcpy((*((*temp).suiv)).info.type,"?");
			(*((*temp).suiv)).info.taille=0;
			(*((*temp).suiv)).suiv=NULL;
		}
	}
	nbcolonne++;
	
}

void setEntite(char * type, int  taille){
	while (T!=NULL)
	{
			ListeTS * temp = rechercher(T->info);
	strcpy(temp->info.type,strdup(type));
	(*temp).info.taille=taille;
	T=T->suiv;	
	}
	//**************************************A re Voir ************************************
}


void afficher(){
	ListeTS *temp=teteTS;
	printf("\n/!!!!!!!!!!!!!!!!!!!!! Table des symboles !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!/\n");
	printf("\t********************************************************************************\n");
	printf("\t| Nom d'entite        | Code d'entite            | Type        | Taille        |\n");
	printf("\t********************************************************************************\n");
	while(temp!=NULL){
		printf("\t|%20s |%25s |%12s |%12d |\n",(*temp).info.nomEntite,(*temp).info.codeEntite,(*temp).info.type,temp->info.taille);
		temp=temp->suiv;
	}
	printf("\t********************************************************************************\n");
}
void insereVal(char * entite, int val)
{
ListeTS *temp=rechercher(entite);
if (temp!=NULL)
{ 


(*temp).info.Valeurr=val;
printf("\n insere  dans %s Valeur Inserer %d",entite,val);

}
}
