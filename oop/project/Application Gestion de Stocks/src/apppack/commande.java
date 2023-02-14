package apppack;

import java.util.ArrayList;

public class commande {
  
	   private int num_commande;

	   private client cmd_client;
	   
	   private ArrayList<produit> cmd_Listp ;
	   
	   private String date_cmd; 

	   private float montant_cmd;
	   
	   

	   //Accesseurs

	   public int getNum_Commande() {

	       return this.num_commande;

	   }

	   public client getCmd_client() {

	      return this.cmd_client;

	   }

	   public ArrayList<produit> get_Cmd_Listp() {

	       return this.cmd_Listp;

	   }

	   public String getDate_cmd() {

	       return this.date_cmd;

	   }
       
	   public float getMontant_cmd() {

	       return this.montant_cmd;

	   }
	   //Modificateurs

	   public void setNum_commande(int num_commande) {

	       this.num_commande = num_commande;

	   }

	   public void setCmd_client(client cmd_client) {


	 
	       this.cmd_client = cmd_client;

	   }

	   public void set_Cmd_Listp(ArrayList<produit> cmd_Listp ) {
	      this.cmd_Listp = cmd_Listp;

	   }

	   public void setDate_cmd(String date_cmd) {

	       this.date_cmd = date_cmd;

	   }
       
	   public void getMontant_cmd(float montant_cmd) {

	       this.montant_cmd = montant_cmd;

	   }

	   public commande(int num_commande, client cmd_client, ArrayList<produit> cmd_Listp, String date_cmd){
		   this.num_commande = num_commande;
		   this.cmd_client = cmd_client;
		   this.cmd_Listp = cmd_Listp;
		   this.date_cmd = date_cmd;
		   this.montant_cmd = 0;
	   }
	   
	   public String toString()
	   {
	   	return "[ num_commande: " +this.num_commande + " cmd_client: \n"+ this.cmd_client + "\n cmd_Listp: \n"+this.cmd_Listp + "\n date_cmd: "+ this.date_cmd + " montant_cmd: " + this.montant_cmd+" ]";
	                    }
	   
	   public float calcule_Montant_cmd() {
		   for (produit prd : cmd_Listp){
			   montant_cmd = montant_cmd + prd.prix_Aprestva() ;
			         }
		   return montant_cmd;
	   }
}
