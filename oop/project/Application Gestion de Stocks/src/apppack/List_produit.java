package apppack;
import java.util.Scanner;
//import java.util.Iterator;


public class List_produit implements client_produit{
	
	 //private ArrayList<produit> Listp ;
	 //private Iterator<produit> iterp = Listp.iterator();
	 private Scanner sc = new Scanner(System.in);
	 private String idp,nomp,catp;
	 private int qtep;
	 private float prixp;
	 
	
	public List_produit()
	  {
		//Listp = new ArrayList<produit>();
	     }
	
    
	public boolean Ajout_produit(){
		
		System.out.println("*********Ajoute de produit...**********");
		
		System.out.println("Saisir le id du produit:");
		idp = sc.next();
		System.out.println("Saisir  le nom du produit:");
		nomp = sc.next();
		System.out.println("Saisir  la categorie du produit:");
		catp = sc.next();
		System.out.println("Saisir la quantite du produit:");
		qtep = sc.nextInt();  
		System.out.println("Saisir le prix du produit:");
		prixp = sc.nextInt();
       
		produit prod = new produit(idp,nomp,catp,qtep,prixp);
	    Listp.add(prod);
	    return true;
			
	   }
	
	public boolean Supp_produit(String Id_prod) {
		System.out.println("*********Suppression de produit...**********");
	      for (produit element : Listp){
	         if (Id_prod.equalsIgnoreCase(element.getId_produit())){
	        	 Listp.remove(element);
	        	 System.out.println("*********Produit supprimer**********");
	        	 return true;
	         }
	      }
	      return false;
	}
	
	public boolean Modifier_produit(String Id_prod){
	    
	    System.out.println("*********Modification de produit:**********");
	    
		System.out.println("Saisir le nouveau id du produit:");
		idp = sc.next();
		System.out.println("Saisir  le nouveau nom du produit:");
		nomp = sc.next();
		System.out.println("Saisir  la nouvelle categorie du produit:");
		catp = sc.next();
		System.out.println("Saisir la nouvelle quantite du produit:");
		qtep = sc.nextInt(); 
		System.out.println("Saisir le nouveau prix du produit:");
		prixp = sc.nextInt(); 
       
	
		for (produit element : Listp){
	         if (Id_prod.equalsIgnoreCase(element.getId_produit())){
	        	 element.setId_produit(idp);
	        	 element.setNom_produit(nomp);
	        	 element.setCategorie(catp);
	        	 element.setQuantite(qtep);
	        	 element.setPrix(prixp);
	        	 System.out.println("*********Produit modifier**********");
	        	 return true;
	         }
	      }
	      return false;
	}
	
	public void Afficher_List_Produit() {
		
        System.out.println("*********Affichage des produits Disponibles:**********");
        
        for (produit element : Listp){
        	System.out.println(element);
	         } 
	   }
public void Afficher_List_Produit_type(String catp) {
		
        System.out.println("*********Affichage des produits Par type = '"+catp+"'**********\n");
        
        for (produit element : Listp){
        	
        	if(element.getCategorie().equalsIgnoreCase(catp)) System.out.println(element);
        	System.out.println("");
	         } 
	   }
}
