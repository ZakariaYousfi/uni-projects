package apppack;

import java.util.ArrayList;
import java.util.Scanner;

public class List_commande implements client_produit {

	
	 
	 private Scanner sc = new Scanner(System.in);
	 private int num_cmd;
	 private String date_cmd;
	 private String id_c;
	 private String id_p;
	 private client client_cmd;
	 private ArrayList<produit> Listp_produit;
	 
	 
	
	public List_commande()
	  {
		
	     }
	
  
	public boolean Ajoute_commande(){
		
		System.out.println("*********Ajoute une commande...**********\n");
		
		System.out.println("Saisir le id du client:");
		
		id_c = sc.next();
		
		for (client clt : Listc){
			
        	if(id_c.equalsIgnoreCase(clt.getId_client())) {
        		
        		client_cmd = clt;
        		break;
        		
        	     }
	         }
		
		if(client_cmd==null) return false;
		
		System.out.println("Saisir le numero de la commande:");
		num_cmd = sc.nextInt();
		
	
		
		
		System.out.println("Saisir  les id's des produits acheter par le client et (*) pour arreter:");
		id_p = sc.next();
		Listp_produit=new ArrayList<produit>();
		while(!id_p.equals("*")) {
			
			
			for (produit prd : Listp){
				
	            if(id_p.equalsIgnoreCase(prd.getId_produit())) {
	        
	            	Listp_produit.add(prd);
	        		break;
	        		
	        	     }
		         } 
			
			id_p = sc.next();
		}
		
		
		System.out.println("Saisir  la date de la commande:");
		date_cmd = sc.next();
		
	
		
		
		commande nvcmd = new commande(num_cmd,client_cmd,Listp_produit,date_cmd);
		Listcmd.add(nvcmd);
	    return true;
			
	   }
	
	public boolean Supp_commande(int numcmd) {
		System.out.println("*********Suppression de la commande...**********\n\n\n");
		
	      for (commande cmd : Listcmd){
	         if (numcmd == cmd.getNum_Commande()){
	        	 Listcmd.remove(cmd);
	        	 System.out.println("*********Commande supprimer**********\n\n\n");
	        	 return true;
	         }
	      }
	      return false;
	}
	
	public boolean Modifier_commande(int num_cmd){
	    
	    System.out.println("*********Modification de commande:**********\n");
	    
	    System.out.println("Saisir  le id du nv client:");
	    
	    client_cmd = null;
	    
	    id_c = sc.next();
		
		for (client clt : Listc){
			
        	if(id_c.equalsIgnoreCase(clt.getId_client())) {
        		
        		client_cmd = clt;
        		break;
        		
        	     }
	         }
		
		if(client_cmd==null) return false;
	    
	    System.out.println("Saisir le nv numero de commande:");
	    
		this.num_cmd = sc.nextInt();
		
		
		System.out.println("Saisir  les id's des produits acheter par le client et (*) pour arreter:");
		id_p = sc.next();
		Listp_produit=new ArrayList<produit>();
		while(!id_p.equals("*")) {
			
			for (produit prd : Listp){
				
	            if(id_p.equalsIgnoreCase(prd.getId_produit())) {
	        		
	            	Listp_produit.add(prd);
	        		break;
	        		
	        	     }
		         } 
			
			id_p = sc.next();
		}
		
		System.out.println("Saisir  la nv date du commande:");
		date_cmd = sc.next();
		
	
		for (commande cmd : Listcmd){
	         if (num_cmd==cmd.getNum_Commande()){
	        	 cmd.setNum_commande(this.num_cmd);
	        	 cmd.setCmd_client(client_cmd);
	        	 cmd.set_Cmd_Listp(Listp_produit);
	        	 cmd.setDate_cmd(date_cmd);
	        	 System.out.println("*********Propriétés du commande modifier**********\n");
	        	 return true;
	         }
	      }
	      return false;
	}
	
	public void Afficher_List_commande() {
		
      System.out.println("*********Affichage des commandes:**********\n");
      
      for (commande cmd : Listcmd){
      	System.out.println(cmd);
	         } 
	   }
	
	
	
}
