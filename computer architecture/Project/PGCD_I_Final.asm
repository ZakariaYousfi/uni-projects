
;realiser par yousfi zakaria matricule: 171732026950  et messili islem matricule : 181832024108

data segment
    
    op1 db 8      ; initialisation de membre gauche du calcul

    op2 db 32     ; initialisation de membre droite du calcul

    oldip dw ?    ; pour contenir l'address ip du retour a le program principale

    ancien_ip dw ?     ; la precedente valeur du ip d'intrupption 0

    ancien_cs dw ?      ; la precedente valeur du cs d'intrupption 0

    message_1 db "fin du calcul du PGCD de $"  ; pour l'affichage du message

    message_2 db " et $"                     ; //

    saut db 10,13,"$"                        ; //

    Message db 20 dup (?)         ; utiliser pour l'affichage

data ends 

stack segment 
    
    dw   128  dup(0)      ; reservation espace pour la pile
     
    tos label word          ; sommet de pile
    
stack ends


code segment
    
Assume cs:code, ds:data, ss:stack 

;les procedures

PGCD_I PROC    ;procedure pgcd_i

    pop oldip     ; mettre lip du retour dans oldip pour ne pas le perdre

    pop bx       ; retirer op2 du la pile

    pop ax      ; retirer op1 du la pile

    cmp ax, bx    ; comparer ax et bx

    jl exchange    ; si ax<bx cad op1 < op2 aller a exchange pour echanger les valeurs
    
    etiq0: div bl ; ax/bl -> ah = reste

    mov al, bl   ; al = nv op1

    mov bl, ah  ; bl = nv op2 

    xor ah, ah  ; mettre ah a zero

    jmp etiq0  ; retourner vers etiq0 pour effectuer une autre operation

    exchange: 

    xchg ax,bx  ; echanger ax et bx
    
    jmp etiq0     ; retourner pour faire les operations 
      
    etiq:   ; l'ettiquette qui la routine d'interruption va brancher vers

    push ax     ; empiler le pgcd dans la pile

    push oldip    ; empiler l'adress de retour pour que la ret le depile pour retourner au prog principal

    Ret  

PGCD_I ENDP 

LireVecteurDivZero proc ; procedure qui permer de lire vecteur d'it div pas zero et sauvegarder le ancien ip et cs        
        
         mov ah, 35h
         
         mov al, 0 
         
         int 21h   
         
         mov ancien_ip, bx
         
         mov ancien_cs, es
         
         ret
         
LireVecteurDivZero endp
    
deroutement proc ; procedure qui fait le deroutement de la routine d'it div par zero
        
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
    
        new_routine: ; la nouvelle routine d'it 
        
        push ax                 ; la sauvegarde de ax dans la pile pour ne pas le perdre   
        
        mov ax, seg message_1                                                             
        
        mov ds, ax                                                                         
        
        mov dx, offset message_1                                                       
        
        call afficherChaine      ; affichage de la chaine message_1                    
        
        mov ax, 0                                            
        
        mov al, byte ptr op1       ; mettre op1 dans al  
        
        call AFFICHAGE              ; appele a la procedure AFFICHAGE pour afficher op1    
        
        mov ax, seg message_2 
        
        mov ds, ax    
        
        mov dx, offset message_2
         
        call afficherChaine         ; affichage de la chaine message_2 
        
        mov ax, 0                                   
        
        mov al, byte ptr op2    ; mettre op2 dans al     
        
        call AFFICHAGE          ; affichage de op2   
        
        pop ax                 ;depilage de ax  
        
        pop dx                 ;depilage du ip retour a pgcd_I 
        
        lea dx, etiq          ; dx <- offset etiq
         
        push dx               ; empiler l'adress de etiq pour que iret retourner en branchment vers elle    
        
        iret    
                    
    
afficherChaine proc       ; procedure pour l'affichage d'une chaine
    
        mov ah,9
        
        int 21h 
         
        ret 
        
afficherChaine endp
            
restaurerVecteurDivZero proc  ; procedure pour restaurer le vecteur div par zero
        
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
     
AFFICHAGE PROC     ; procedure pour l'affichage d'un nombre quelconque en decimal
    
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
    
    afficher:    
    
    Mov ah, 9h  
    
    Mov dx, si  
    
    Int 21h  
     
    ret 
    
AFFICHAGE ENDP

;main prog  

start:

     mov ax, data  
                 
     mov ds, ax       ; intialisation du segment ds
      
     mov ax, stack
     
     mov ss, ax       ; intialisation du segement de pile
    
     mov sp, offset tos      ; intialisation du sommet pile

     call LireVecteurDivZero   ; lecture du ip et cs du l'it div zero
      
     call deroutement           ; appel a deroutement pour faire derouter l'it div zero vers new_routine
     
     xor dx, dx                ; mettre dx a zero
     
     mov dl, op1              ; mettre op1 dans dl
     
     push dx                   ; empiler dx qui contient op1 
     
     mov dl, op2             ; mettre op2 dans dl
     
     push dx                  ; empiler dx qui contient op2
     
     call PGCD_I    ; appel a PGCD_I 
     
     call restaurerVecteurDivZero ; pour restaurer lip et cs de l'it div zero par les valeurs precedente
     
     pop di  ; pour le test  
     
     mov ax, 4c00h ; exit to operating system.
    
     int 21h
    
code ends

end start




