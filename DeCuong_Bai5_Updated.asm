.model small
.stack 100h
.data   
   msg1 db 10,13, "Nhap vao chuoi so (vd -12 23 34): $"
   msg2 db 10,13, "So luong phan tu am trong chuoi la: $"
   msg3 db 10,13, "So luong phan tu duong trong chuoi la: $"
   str db 100 dup('$')
   demAm dw ? 
   demDuong dw ? 
   so0 dw ?
   tmp dw ?
.code
   main proc
    mov ax,data
    mov ds,ax

    mov ah,9
    lea dx,msg1
    int 21h
    
    mov ah,0Ah
    lea dx,str
    int 21h
    
    mov ah,9
    lea dx,msg2
    int 21h
    
    mov cx,0
    mov cl,[str+1]
    lea si,[str+2]
    
    mov bx,10
    mov ax,0
    
    loop1:
        mov dx,[si]
        cmp dl, '-'
        je next1     
        mov dx,[si]
        cmp dl, 20h
        je next2
        mul bx
        mov dx,[si]
        mov dh,0
        sub dl,30h
        add ax,dx 
        jmp nextLoop
        
        next1:
            mov tmp,1
            jmp nextLoop
    
        next2:    
            cmp tmp,1 
            je tangAm
            cmp ax,0
            jne tangDuong
            jmp nextLoop
            
            tangAm:
                inc demAm
                mov tmp,0
                jmp nextLoop
                
            tangDuong:
                inc demDuong
                mov ax,0 
                jmp nextLoop
                   
        nextLoop:
            inc si
            loop loop1    

            cmp tmp,1
            je tangAm2
            cmp ax,0 
            jne tangDuong2 
            jmp done
             
            tangAm2:
                inc demAm
                jmp done  
            
            tangDuong2:
                inc demDuong 
                jmp done
            done:
            
         mov ax,demAm
         call print
         
         mov ah,9
         lea dx,msg3
         int 21h
         
         mov ax,demDuong
         call print
            
       mov ah,4Ch
       int 21h     
                   
   main endp   
   
   print proc 
        mov bx,10
        mov cx,0
  
        chia:
            mov dx,0
            div bx
            push dx
            inc cx
            cmp ax,0
            jne chia
            jmp hienthi
            
            hienthi:
                pop dx
                add dl,30h
                mov ah,02
                int 21h
                loop hienthi 
                
            ret
   print endp
end