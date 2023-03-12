#include <time.h>
#include <stdio.h>
clock_t debut;

void Hanoi(int n, char depart, char intermediaire, char arrivee){

    if(n == 1){ /* Condition d'arrêt: S'il reste un seul disque, on le déplace vers la tour d'arrivée et on termine */

        printf("Deplacer le disque %d de %c a %c\n", n, depart, arrivee);
        return; /*Sortir de la fonction récursive*/
    }
    /* On déplace les (n-1) premiers disques de la tour départ à arrivée, en utilisant passant par la tour intermédiaire */

    Hanoi(n-1, depart, arrivee, intermediaire);//On déplace les disques de la tour départ vers intermédiaire*/
    printf("Deplacer le disque %d de %c vers %c\n", n, depart, arrivee);
    Hanoi(n-1, intermediaire, depart, arrivee); //On déplace les disques de la tour intermédiaire vers arrivée*/
}

int main() {

 int n;
 double temps;
 printf("Donnez le nombre de disques : ");
 //On lit le nombre de disques
 scanf("%d",&n);
 printf("Liste des deplacements necéssaires pour mettre les %d disque sur la 3eme tour:\n\n", n);
 //on enregistre le temps du début de l'exécution dans debut
 debut=clock();
 //On fait appel à la fonction récursive d'Hanoi (A= tour de départ, B=tour intermédiaire, C=tour d'arrivée)
 Hanoi(n,'A','B','C');
 //on calcule le temps d'exécution qui est égale au temps actuel(fin d'exécution) - debut
 temps=(float)(clock()-debut)/CLOCKS_PER_SEC;

 printf("\nLe temps d'execution pour %d disques est : %f\n", n, temps);

 return 0;

}

