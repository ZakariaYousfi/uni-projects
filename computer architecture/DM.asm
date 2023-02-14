
data segment
    
tab db '0123456789ABCDEF'  

nextline db 10, 13, '$'    

counter db 0

csip db 10,13,"  CS:IP",10,13,'$'

message db "pour afficher un autre bloc entrer le caractere 'y'$"

data ends
 



code segment
    
Assume cs:code, ds:data

                          ; la Procedure qui affiche 
affichageCSiIPi proc        
    
mov bp, sp

mov dx, [bp+2] ; 
      
lea bx, tab 
   
mov al, dh   

shr al, 4    
      
xlat        
      
mov ah, 0eh 
      
int 10h

mov al, dh

and al, 0fh  
      
xlat           
      
mov ah, 0eh 
      
int 10h     
  
mov al, dl

shr al, 4    

xlat        

mov ah, 0eh 

int 10h
 
mov al, dl

and al, 0fh  

xlat            

mov ah, 0eh 

int 10h    

mov ah, 2h

mov dl,':'

int 21h
            
mov dx, [bp+4] 
                
mov al, dh
     
shr al, 4   

xlat        

mov ah, 0eh  

int 10h

mov al, dh

and al, 0fh  

xlat        

mov ah, 0eh  

int 10h     
        
mov al, dl

shr al, 4   

xlat          

mov ah, 0eh  

int 10h

mov al, dl

and al, 0fh  

xlat       

mov ah, 0eh  

int 10h    
  
lea dx, nextline
     
mov ah, 9h
     
int 21h 
  
ret
    
affichageCSiIPi endp
                    
                    
                    ; Programme Principale

start: mov ax, data 

mov ds, ax
  

i10vect:mov cx, 10 

mov ah, 9h

lea dx, csip

int 21h
                                   
nextvector: 

mov al, counter 

mov ah, 35h
       
int 21h
           
push bx

push es
        
call affichageCSiIPi   
           
inc counter

loop nextvector
       
mov ah, 9h

lea dx, nextline

int 21h

mov ah, 9h

lea dx, message

int 21h 
 
MOV ah, 9h

lea dx, nextline 

int 21h
   
mov ah, 7h
 
int 21h   
   
cmp al, 'y'

jnz endprog

lea dx, nextline

mov ah, 9h 

int 21h

jmp i10vect
    
endprog: mov ah, 4ch 

int 21h

code ends

end start






