package apppack;


import java.util.Scanner;

public class List_client implements client_produit{
    
	 //private ArrayList<client> Listc ;
	 //private Iterator<produit> iterp = Listp.iterator();
	 private Scanner sc = new Scanner(System.in);
	 private String idc,nomc,adrc,telc;
	 private int nbra_c;
	 
	
	public List_client()
	  {
		//Listc = new ArrayList<client>();
	     }
	
   
	public boolean Ajout_client(){
		
		System.out.println("*********Ajoute d'un client**********\n");
		
		System.out.println("Saisir le id du client:");
		idc = sc.next();
		System.out.println("Saisir  le nom du client:");
		nomc = sc.next();
		System.out.println("Saisir  l'adresse du client:");
		adrc = sc.next();
		System.out.println("Saisir le numero de telephone du client:");
		telc = sc.next();
		System.out.println("Saisir le nombre d'achat du client:");
		nbra_c = sc.nextInt(); 
		
		client nvclient = new client(idc,nomc,adrc,telc,nbra_c);
	    Listc.add(nvclient);
	    return true;
			
	   }
	
	public boolean Supp_client(String Id_client) {
		System.out.println("*********Suppression du client**********\n");
	      for (client clt : Listc){
	         if (Id_client.equalsIgnoreCase(clt.getId_client())){
	        	 Listc.remove(clt);
	        	 System.out.println("*********client supprimer**********\n");
	        	 return true;
	         }
	      }
	      return false;
	}
	
	public boolean Modifier_client(String Id_client){
	    
	    System.out.println("*********Modification du client:**********\n");
	    
	    System.out.println("Saisir le id du client:");
		idc = sc.next();
		System.out.println("Saisir  le nom du client:");
		nomc = sc.next();
		System.out.println("Saisir  l'adresse du client:");
		adrc = sc.next();
		System.out.println("Saisir le numero de telephone du client:");
		telc = sc.next();
		System.out.println("Saisir le nombre d'achat du client:");
		nbra_c = sc.nextInt(); 
      
	
		for (client clt : Listc){
	         if (Id_client.equalsIgnoreCase(clt.getId_client())){
	        	 clt.setId_client(idc);
	        	 clt.setNom_client(nomc);
	        	 clt.setAddresse_client(adrc);
	        	 clt.setTel_client(telc);
	        	 clt.setNbr_achat(nbra_c);
	        	 System.out.println("*********Propriétés du Client modifier**********\n");
	        	 return true;
	         }
	      }
	      return false;
	}
	
	public void Afficher_List_client() {
		
       System.out.println("*********Affichage des clients inscrit:**********\n");
       
       for (client clt : Listc){
       	System.out.println(clt);
	         } 
	   }
	public client Existe_client(String Id_client) {
		for(client clt : Listc) {
			if (clt.getId_client().equals(Id_client)) return clt;		
		}
		return null;
	}
}
