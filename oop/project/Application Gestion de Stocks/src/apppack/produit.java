package apppack;

public class produit {
	   
	   
	
	   private String id_produit;

	   private String nom_produit;

	   private String categorie;

	   private int quantite;
	   
	   private float prix;
	   
	   private final static float tva = (float) 0.07;
	  
	   
       public produit(String id_produit, String nom_produit, String categorie, int quantite, float prix) {
    	   
    	   this.id_produit=id_produit;

    	   this.nom_produit=nom_produit;

    	   this.categorie=categorie;

    	   this.quantite=quantite;
    	   
    	   this.prix=prix;
    	   
    	   
       }
	   //Accesseurs

	   public String getId_produit() {

	       return this.id_produit;

	   }

	   public String getNom_produit() {

	       return this.nom_produit;

	   }

	   public String getCategorie() {

	       return this.categorie;

	   }

	   public int getQuantite() {

	       return this.quantite;

	   }
	   
	   public float getPrix() {

	       return this.prix;

	   }

	   //Modificateur

	   public void setId_produit(String id_produit) {

	     this.id_produit = id_produit;

	   }

	   public void setNom_produit(String nom_produit) {

	       this.nom_produit = nom_produit;

	   }

	   public void setCategorie(String categorie) {

	       this.categorie = categorie;

	   }

	   public void setQuantite(int quantite) {

	       this.quantite = quantite;

	   }
	   
	   public void setPrix(float prix) {

	       this.prix = prix;

	   }
	   
	   public String toString()
	   {
	   	return "[ id_produit: " +this.id_produit + " nom_produit: "+ this.nom_produit + " categorie: "+this.categorie + " quantite: "+ this.quantite + " prix: " + this.prix+" ]";
	                    }
	   
	   public float prix_Aprestva() {
		   return (prix*tva);
	   }
	   
}
