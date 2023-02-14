package apppack;
import java.util.Scanner;

public class Run_App {

	public static void main(String[] args) {
		Scanner read = new Scanner(System.in);
		String element;

		
		List_produit Mylistp = new List_produit();
		List_client Mylistc = new List_client();
		List_commande Mylistcmd = new List_commande();
		/*
		 
						produit prod1 = new produit("tl001","marks","tel",145);
						produit prod2 = new produit("ph001","condor","pho",112);
						produit prod3 = new produit("elm001","bico","elm",48);
						produit prod4 = new produit("acc001","support","acc",75);
		Mylist.Ajout_produit();
		Mylist.Ajout_produit();
		Mylist.Ajout_produit();
		Mylist.Ajout_produit();
		
		Mylist.Supp_produit("55");
		
		Mylist.Modifier_produit("10");
		
		
		Mylist.Afficher_List_Produit();*/
		
		
		
		
		while(true) {
			System.out.println("\n1. Gestion des produits\r\n"
					+ "2. Gestion des clients\r\n"
					+ "3. Gestion des commandes\r\n"
					+ "4. Quitter\n");
			String menu = read.next();
			
			if(menu.equals("4")) break;
			
			if(menu.equals("1")) {	
				while(true) {			
	   System.out.println("\n1. Créer une liste de produits\n"
						+ "2. Ajouter produit\n"
						+ "3. Supprimer produit\n"
						+ "4. Modifier produit\n"
						+ "5. Afficher la liste Produit par type de produit\n"
						+ "6. Quitter");
						String menu1 = read.next();
						if (menu1.equals("6")) break;
						switch(menu1) {
						case "1": {System.out.println("\n**********Création de la liste faites**********");
						//initialisation des clients
						break;
						}
						case "2": {
							if(Mylistp.Ajout_produit()) {System.out.println("\n**********Produit Ajouter avec success*********"); 
							break;}
							else System.out.println("\n**********erreur Ajoute du produit***********");
							
						}
						case "3": {
							System.out.println("\ndonner moi l'id du l'élément a supprimer");
							element=read.next();
							if(Mylistp.Supp_produit(element)) System.out.println("\n*********produit supprimer*********");
							else System.out.println("produit n'existe pas dans la liste");
							break;
						}
						case "4": {
							System.out.println("\ndonner moi l'id du produit a modifier");
							element=read.next();
							if(Mylistp.Modifier_produit(element)) System.out.println("\n*********produit modifier*********");
							else System.out.println("produit n'existe pas dans la liste");
							break;
						}
						case "5": {
							System.out.println("\ndonner moi le type des produits a afficher");
							element = read.next();
							Mylistp.Afficher_List_Produit_type(element);
							break;
						}
						default: {System.out.println("\nveuillez entrer le nombre qui correspond à l'operation souhaité\n"); break;}
						}
							 }
									}
			
			if(menu.equals("2")) {
				while(true) {
	   System.out.println("\n1. Créer une liste de clients\n"
						+ "2. Ajouter client\n"
						+ "3. Supprimer client\n"
						+ "4. Modifier client\n"
						+ "5. Afficher la liste Client\n"
						+ "6. Afficher l’état de fidélisation des clients\n"
						+ "7. Quitter");
	   					String menu2 = read.next();
	   					if (menu2.equals("7")) break;
						switch(menu2) {
						case "1": {
							System.out.println("\n**********Création de la liste faites**********");
							// intialisation des clients
							break;
						}
						case "2": {
							if(Mylistc.Ajout_client()) System.out.println("\n**********Client ajouter**********");
							break;
						}
						case "3": {
							if(Mylistc.Supp_client(read.next())) System.out.println("\n**********le client a été supprimé***********");
							else System.out.println("\nle client n'existe pas dans la liste");
							break;
						}
						case "4": {
							element=read.next();
							if(Mylistc.Modifier_client(element)) System.out.println("\n***********le client a été modifier***********");
							else System.out.println("\n le client n'existe pas dans la liste");
							break;
						}
						case "5": {
							Mylistc.Afficher_List_client();
							break;
						}
						case "6": {
							
						}
						default: {System.out.println("\nveuillez entrer le nombre qui correspond à l'operation souhaité\n"); break;}
						}
							}
									}
			
			if(menu.equals("3")) {
				while(true) {
	   System.out.println("\n1. Créer une liste de commandes\n"
						+ "2. Ajouter une commande\n"
						+ "3. Supprimer une commande\n"
						+ "4. Modifier une commande\n"
						+ "5. Afficher la liste des commandes satisfaites\n"
						+ "6. Afficher la liste des commandes en instance (réservées)\n"
						+ "7. Afficher le produit le plus commercialisé sur une période donnée\n"
						+ "8. Afficher le produit le moins commercialisé sur une période donnée\n"
						+ "9. Achats d’un produit donné sur une période donné\n"
						+ "10. Achats d’un produit donné sur une période donnée, par ville\n"
						+ "11. Quitter");
	   					String menu3 = read.next();
	   					if (menu3.equals("11")) break;
						switch(menu3) {
						case "1": {
							
							break;
						}
						case "2": {
							if(Mylistcmd.Ajoute_commande()) System.out.println("\n**********La commande a été ajouter**********");
							else System.out.println("\nle client n'existe pas, il faut le crée");
							break;
						}
						case "3": {
							System.out.println("\ndonner moi le numero de la commande");
							if(Mylistcmd.Supp_commande(read.nextInt())) System.out.println("********La commande a été supprimé********");
							else System.out.println("la commande n'existe pas");
							break;
						}
						case "4": {
							System.out.println("\ndonner moi le numero de la commande");
							if(Mylistcmd.Modifier_commande(read.nextInt())) System.out.println("*********la commande a été changé********");
							else System.out.println("\nle client entrér n'existe pas, il faut l'ajouter");
							
							break;
						}
						case "5": {
							Mylistcmd.Afficher_List_commande();
							break;
						}
						case "6": {
							
							break;
						}
						case "7": {
							
							break;
						}
						case "8": {
							
							break;
						}
						case "9": {
							
							break;
						}
						case "10": {
							
							break;
						}
						default: {System.out.println("\nveuillez entrer le nombre qui correspond à l'operation souhaité\n"); break;}
						}
							}
									}
			}
			read.close();	
		}
	    }


