#include <time.h>
#include <stdio.h>
clock_t debut;

void Hanoi(int n, char depart, char intermediaire, char arrivee){

    if(n == 1){ /* Condition d'arr�t: S'il reste un seul disque, on le d�place vers la tour d'arriv�e et on termine */

        printf("Deplacer le disque %d de %c a %c\n", n, depart, arrivee);
        return; /*Sortir de la fonction r�cursive*/
    }
    /* On d�place les (n-1) premiers disques de la tour d�part � arriv�e, en utilisant passant par la tour interm�diaire */

    Hanoi(n-1, depart, arrivee, intermediaire);//On d�place les disques de la tour d�part vers interm�diaire*/
    printf("Deplacer le disque %d de %c vers %c\n", n, depart, arrivee);
    Hanoi(n-1, intermediaire, depart, arrivee); //On d�place les disques de la tour interm�diaire vers arriv�e*/
}

int main() {

 int n;
 double temps;
 printf("Donnez le nombre de disques : ");
 //On lit le nombre de disques
 scanf("%d",&n);
 printf("Liste des deplacements nec�ssaires pour mettre les %d disque sur la 3eme tour:\n\n", n);
 //on enregistre le temps du d�but de l'ex�cution dans debut
 debut=clock();
 //On fait appel � la fonction r�cursive d'Hanoi (A= tour de d�part, B=tour interm�diaire, C=tour d'arriv�e)
 Hanoi(n,'A','B','C');
 //on calcule le temps d'ex�cution qui est �gale au temps actuel(fin d'ex�cution) - debut
 temps=(float)(clock()-debut)/CLOCKS_PER_SEC;

 printf("\nLe temps d'execution pour %d disques est : %f\n", n, temps);

 return 0;

}

