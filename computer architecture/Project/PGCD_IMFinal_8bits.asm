
;realiser par yousfi zakaria matricule: 171732026950  et messili islem matricule : 181832024108

data segment

pgcdF dw ?      ; variable qui va contenir le pgcd

oldip dw ?    ; variable pour stocker l'ip du retour a la procedure call_IM

oldiprincip dw ?        ; pour stocker l'ip du retour au program principal

ancien_ip dw ?         ; stocker ip original de div par zero

ancien_cs dw ?        ; stocker cs original de div par zero

tab db 8,32,16,4,2      ; intialisation du tableau

maxtab dw 5             ; intialisation du nombre d'element du tableau

Message db 20 dup (?)    ; utiliser pour afficher les nombre en decimal

saut db 10,13,"$"        ; pour faire des saut de lignes

N db " N=$"                ; pour l'affichage

tabaff db "Tab=$"            ; pour l'affichage

pgcd db "PGCD=$"            ; pour l'affichage

Jsamedi db "Samedi$"         ; pour afficher les jours

Jdimanche db "Dimanche$"  

Jlundi db "Lundi$"       

Jmardi db "Mardi$"        

Jmercredi db "Mercredi$"   

Jjeudi db "Jeudi$"        

Jvendredi db "Vendredi$"

data ends 

stack segment            ; declaration de la pile
    
    dw   128  dup(0)
     
    tos label word
    
ends


code segment
    
Assume cs:code, ds:data, ss:stack 

;les procedures


PGCD_I PROC    ;procedure pgcd_i meme travaille comme dans le fichier pgcd_I

    pop oldip
    
    pop bx
    
    pop ax
    
    cmp ax, bx
    
    jl exchange
        
    etiq0: div bl
    
    mov al, bl   
    
    mov bl, ah   
    
    xor ah, ah
    
    jmp etiq0
    
    exchange: 
    
    mov dx,ax
    
    mov ax,bx
    
    mov bx,dx
    
    jmp etiq0
          
    etiq: 
    
    push ax
    
    push oldip
    
    Ret  

PGCD_I ENDP 



PGCD_IN PROC   ; procedure pgcd_in
     
     pop oldiprincip       ; depiler lip de retour pour le stocker
     
     mov si, offset tab    ; si pointe vers le premier element du tableau
     
     mov di, offset tab   ; di pointe vers le premier element du tableau
     
     add di, maxtab       ; ajouter a di le nombre d'element du tableau di pointe maintenant vers la premier case apres le tableau

     xor dx, dx          ; dx <- 0 
     
     mov dl, [si]      ; mettre le premier element du tableau dans dl
     
     xor dh,dh      ; dh <- 0
     
     push dx        ; empiler le premier element
        
     inc si          ; incrementer si
     
next:mov dl, [si]    ; boucle pour traverser le tableau dl <- l'elemement suivant du tableau
     
     xor dh,dh        ; dh <- 0
     
     push dx        ; empiler l'element
     
     call PGCD_I     ; appele a pgcd_i le pgcd est contenu dans la pile
     
     inc si        ; incrementer si
     
     cmp si, di   ; comparer si avec di 
     
     jnz next   ; si si != di brancher vers next
     
     push oldiprincip  ; sinon  empiler ip principal pour retourner
     
     ret
     
      
PGCD_IN ENDP

 
LireVecteurDivZero proc ; procedure qui lit et sauvegarde lip et cs de l'it div par zero , vue dans le dernier tp        
        
         mov ah, 35h 
         
         mov al, 0 
         
         int 21h  
         
         mov ancien_ip, bx 
         
         mov ancien_cs, es 
         
         ret
         
LireVecteurDivZero endp
    
deroutement proc    ; procedure qui fait le deroutment de l'it div par zero , vue dans le dernier tp
        
         mov dx, offset new_routine 
         
         mov ax, seg new_routine  
         
         mov ds, ax         
         
         mov al, 0         
         
         mov ah, 25h     
         
         int 21h      
         
         mov ax, data  
         
         mov ds, ax  
         
         ret          
                   
deroutement endp 

    
new_routine: ; la nouvelle routine d'it div par zero
        
    pop dx    ; depiler ip retour
        
    lea dx, etiq   ; dx <- l'address vers etiq
        
    push dx    ; empiler dx maintement le retour se fait vers etiq
        
    iret 
                  
    
afficherChaine proc ; pour afficher les chaines
    
        mov ah,9 
        
        int 21h 
         
        ret
        
afficherChaine endp
            
restaurerVecteurDivZero proc  ; procedure qui restore l'it div par zero , vue dans le dernier tp
        
         mov dx, ancien_ip 
         
         mov ax, ancien_cs 
          
         mov ds, ax 
         
         mov al, 0 
         
         mov ah, 25h
         
         int 21h
         
         mov ax, data
         
         mov ds, ax
        
         ret   
         
restaurerVecteurDivZero endp
     
AFFICHAGE PROC     ; procedure pour afficher les nombres en decimal, donne dans l'annexe A du projet tp
    
        Mov bx, 10  
        
        Lea si, Message [19]
        
        Mov [si], '$'
        
        Decomposer:
        
        Dec si    
        
        Xor dx, dx 
        
        Div bx  
        
        Add dl, 48    
        
        Mov [si], dl  
        
        Cmp ax, 0  
        
        Jne Decomposer  
        
        cmp cl, 10    
        
        jae afficher  
        
        ;dec si        
        
        ;mov [si], '0' 
        
        afficher:   
        
        Mov ah, 9h  
        
        Mov dx, si 
        
        Int 21h   
        
        ret 
    
AFFICHAGE ENDP

AFFICHERCURSOR PROC    ; procedure pour appeler la fonction qui met le cursor a l'endroit volu
    
    mov ah, 2
    
    mov bh, 0 
    
    int 10h 
    
    ret
    
AFFICHERCURSOR ENDP

SAUT0 PROC     ; procedure pour faire un saut de ligne
    
    lea dx, saut 
    
    mov ah,9h  
    
    int 21h  
    
    ret

SAUT0 ENDP

AFFICHERTAB PROC    ; proc qui affiche les elements du tableau
    
    mov cx, maxtab   ; cx <- nb element du tableau
    
    lea di, tab      ; di = l'adress du premier element du tableau 
    
    mov al, [di]     ; al <- le premier element a afficher
    
    mov ah, 0        ; ah <- 0
    
    call AFFICHAGE      ; affichage du premier element du tabeau
    
    inc di               ; di <- di + 1
    
    dec cx              ; cx <- cx - 1
    
    afftab:            ; boucle pour afficher les autres elements un par un 
    
    call AFFVERGULE    ; afficher la vergule
    
    mov al, [di]     ; al  <- l'element pointer par di
    
    inc di             ; incrementer di 
    
    mov ah, 0        ; ah <-  0
    
    call AFFICHAGE   ; afficher le nombre   
    
    loop afftab  ; cx <- cx - 1 si cx != 0 brancher vers afftab
    
    ret

AFFICHERTAB ENDP 

AFFVERGULE PROC ; pour l'affichage de la vergule
    
    mov ah,2 
    
    mov dl,','
             
    int 21h 
    
    ret
    
AFFVERGULE ENDP    

AFFSLASH PROC  ; pour l'affichage du /
         
    mov ah,2 
    
    mov dl,'/'
    
    int 21h 
    
    ret

AFFSLASH ENDP

GETDATE PROC ; procedure pour avoir la date
    
    mov ax, 0
    
    mov ah, 2Ah
    
    int 21h 
       
    ret
    
GETDATE ENDP

AFFICHERDATE PROC   ; procedure qui affiche la date

    mov dh, 1 ;ligne de l'ecran
    
    mov dl, 64 ;colonne de l'ecran
    
    call AFFICHERCURSOR ; pour mettre le cursor a lendroi voulu
    
    mov ax,0   ; ax <- 0 
        
    call GETDATE   ; apelle a la procedure qui prend la date actuel
    
    cmp al, 0    ; faire des comparation avec al pour choisir la chaine a afficher de le jour actuel
    
    jz dimanche 
    
    cmp al, 1 
    
    jz lundi  
    
    cmp al, 2 
    
    jz mardi 
    
    cmp al, 3 
    
    jz mercredi  
    
    cmp al, 4   
    
    jz jeudi      
    
    cmp al, 5   
    
    jz vendredi   
    
    lea dx, Jsamedi  
    
    jmp affiche    
    
    dimanche: lea dx, Jdimanche 
    
    jmp affiche                
    
    lundi: lea dx, Jlundi     
    
    jmp affiche   
    
    mardi: lea dx, Jmardi   
    
    jmp affiche           
    
    mercredi: lea dx, Jmercredi 
    
    jmp affiche             
                                                    
    jeudi: lea dx, Jjeudi 
    
    jmp affiche 
    
    vendredi: lea dx, Jvendredi
    
    affiche: 
    
    call afficherchaine ; affichage du jour de la semaine
    
    call AFFVERGULE      ;affichage de la vergule   
         
    call GETDATE          ; prendre la date actuel
    
    mov ax,0              ; ax <- 0
    
    mov al, dl          ; al <- le jour de mois actuel
    
    call AFFICHAGE       ;afficher le jour du mois
    
    call GETDATE          ; prendre la date actuel
    
    call AFFSLASH       ; affichage de le /
                                   
    mov ax, 0       ; ax <- 0
    
    mov al, dh         ;al<- le mois actuel
    
    call AFFICHAGE     ; affichage du mois
         
         
    call AFFSLASH        ; affichage du /
    
    mov ax,cx            ; ax <- l'annee actuel
    
    call AFFICHAGE       ; affichage de l'annee
    
    ret
     
AFFICHERDATE ENDP     

AFFICHERTEMP PROC 
    
    Mov ah, 2ch 
    
    Int 21h         ; prendre le temp actuel
    
    Mov ax, 0  
    
    Mov al, ch ; al <- l'heure courant
    
        call AFFICHAGE         ; afficher les heurs

    mov ah,2  
    
    mov dl,'h' 
    
    int 21h        ; afficher le caractere h

    
    Mov ax, 0  
    
    Mov al, cl  ; al <- les minutes courant
    
        call AFFICHAGE    ; afficher les minutes     
        
    ret 
        
AFFICHERTEMP ENDP

;main prog  

start:

    mov ax, data
    
    mov ds, ax  ; intialisation du segment ds
    
    mov ax, stack
    
    mov ss, ax   ; intialisation de la pile
    
    mov sp, offset tos   ; sp <- tete de la pile

        call LireVecteurDivZero  ; lire et stocker l'ip et cs d'it div par zero
      
        call deroutement ; derouter l'int div par zero   
     
        call PGCD_IN    ; appel a pgcd_IN pour retourner le pgcd du tableau
     
    pop pgcdF  ; mettre le pgcd dans la variable pgcdF
     
        call AFFICHERDATE     ; afficher la date
     
    mov dh, 2 ;ligne de l'écran 
    
    mov dl, 74 ;colonne de l'écran 
    
        call AFFICHERCURSOR  ; mettre le cursor a lendroi voulu 
        
        call AFFICHERTEMP  ; afficher le temp
    
        call SAUT0         ; faire un saut de ligne

    lea dx, N  
    
        call afficherchaine ; affichage de N=

    Mov ax, 0   
    
    Mov al,byte ptr maxtab   
    
        call AFFICHAGE    ; afichage du nombre d'element du tableau

    mov dh, 3  
    
    mov dl, 30 
    
        call AFFICHERCURSOR   ; mettre le cursor a l'endroi voulu 
    
    lea dx, Tabaff        
    
        call afficherchaine   ; affichage de tab=..  

        call AFFICHERTAB   ;affichage des elements de tab

    mov dh, 4 
    
    mov dl, 35 
    
        call AFFICHERCURSOR  ; mettre le cursor a l'endroi voulu
    
    lea dx, pgcd        
    
        call afficherchaine      ;affichage de PGCD=   
        
    mov ax, pgcdF  ; ax <- le pgcd du tableau
    
        call AFFICHAGE      ; affichage du pgcd
        
    call restaurerVecteurDivZero   ; restauration de l'ip et cs de lit div par zero
  
    mov ax, 4c00h ; exit to operating system.
    
    int 21h
    
code ends

end start



