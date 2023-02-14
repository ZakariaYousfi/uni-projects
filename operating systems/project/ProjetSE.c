//Importation de bibliothèque
#include <unistd.h>  
#include <sys/types.h> 
#include <sys/wait.h> 
#include <stdlib.h> 
#include <stdio.h> 
#include <signal.h>

// variables global
int pf=0 ;//Pour distingue entre les deux processus fis et processus  le père
int mes=1 ;//Indique la mesure en cours
int boucle=0 ;//Indique la boucle entraine d’exécuter boucle par l’appel de alarm() (attente de 2mn et 1mn)
int debut=0 ;// Pour manipuler la suspention ou la continuation de prises des mesures (combinaison ctrl+z)
arret=0;//Compteur pour calculer le nombre de click sur la combinaison ctrl+c

pid_t pid1,pid2; // Variables pour contenir les pid des 2 fils 

//Un handler qui traite la suspention ou la continuation de prises des mesures par ctrl+z (signal SIGTSTP)
void handtstp(int sig) { 


if(debut==0) {
	debut = 1;
	if (pf == 0) kill(pid1, SIGUSR1);
	}

else if (debut == 1) {
			debut = 2;
			if(pf == 0) {
					kill(pid1, SIGSTOP);//suspendre fis1 
					kill(pid2, SIGSTOP); //suspendre fis2
				}}
else{
		debut = 1;
		kill(pid1, SIGCONT);//remise fis1
		kill(pid2, SIGCONT);//remise fis2
		}

}
//Un handler qui traite l’arrêt de tout les processus et la sortie de system (ctrl+c X 3)
void handint(int sig) {
	if(pf == 0) {
		arret++;
		if(arret == 3) {
			printf("\nTerminison avec succes\n");
			kill(pid1, SIGKILL);//terminaison fis1
			kill(pid2, SIGKILL);//terminaison fis 2
			exit(0);
			}   }   }
// handler qui traite le signal SIGALRM
void handalrm(int sig) { 

if(pf==0) kill(pid1, SIGUSR1);
if(pf==1){
	if(mes==2){//la messeur 2
		printf("processus1_pid = %d: mesure2\n",getpid());
		kill(pid2, SIGUSR2);//envoi de signal SIGUSR2 au fis 1
		mes=1;
	}
else if(mes==1){// la messeur 1
	printf("\nprocessus1_pid = %d: mesure1\n",getpid());
	alarm(5);
	mes=2;
		}
	}
	if(pf==2){
		if(boucle == 1) {
			kill(getppid(), SIGALRM);// envoi de signal SIGALRM au pere			boucle = 0;
}
   else {
   	printf("processus2_pid = %d: mesure\n",getpid());
   	boucle = 1;
   	kill(getpid(), SIGUSR2);// envoi de signal SIGUSR2 au fis 2
		}   }   }
// handler qui traite le signal SIGUSER1 de fis 1
void handusr1(int sig) { alarm(1);}

// handler handler qui traite le signal SIGUSER2 de fis 2
void handusr2(int sig){ 
	if(boucle==0) alarm(10);
	if(boucle==1) alarm(5);
}

int main(){ // prog du principal

	printf("Bienvenue!\n");
	//Assignation des handler avec leurs signaux 
	signal(SIGTSTP, handtstp); 
	signal(SIGINT, handint);
	signal(SIGALRM, handalrm);
	signal(SIGUSR1, handusr1);
	signal(SIGUSR2, handusr2);

	pid2=fork(); // création fils 2 (processus 2)

	if (pid2 == -1) printf("erreur de fork()\n");

	else if (pid2 == 0) {

		pf=2;
		printf("Le deuxième fis a été créé !\n");
		while(1) {}

		}

		pid1 = fork(); // création fils 1 (processus 1)

		if(pid1 == -1 ) printf("erreur de fork()\n");

		else if (pid1 == 0) {
		pf=1;
		printf("Le premier fis a été créé  \n");
		while(1){}
		}
	else {
		printf("Ici c’est le père x2\n");
		while(1){// programme de fonds
		}
	}

	printf("Ici c’est le père x3\n");
}
