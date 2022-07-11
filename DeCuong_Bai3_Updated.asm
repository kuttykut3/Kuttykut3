.model small
.stack 100h
.data
   msg1 db "Nhap vao chuoi so(vd -2 3 10): $"
   msg2 db 10,13,"So cac so nguyen to trong chuoi la: $"
   str db 100 dup('$')
   dem dw ?
   am dw ?
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
    
    mov cx,0
    mov cl,[str+1]
    lea si,[str+2]
    
    mov bx,10
    mov ax,0
    calc:
        mov dx,[si]
        cmp dl,'-'
        je next1
        mov dx,[si]
        cmp dl, 20h
        je next2
        mul bx
        mov dx,[si]
        mov dh,0
        sub dl,30h
        add ax,dx
        mov tmp,ax
        jmp nextLoop
        
        next1:
            inc am
            jmp nextLoop
            
        next2:
            cmp am,0
            jne reset
            cmp tmp,1
            je reset
            mov bx,1
            chia:
            mov dx,0
            mov ax,tmp
            inc bx
            div bx
            cmp dl,0
            jne chia
            cmp bx,tmp
            mov ax,0
            je tangDem
            jmp nextLoop
            
            reset:
                mov am,0
                mov tmp,0 
                mov ax,0
                jmp nextLoop
                
            tangDem:
                inc dem
                jmp nextLoop
         
        nextLoop:
            mov bx,10
            inc si
            loop calc
            
            cmp am,0
            jne done
            mov bx,1
            chia2:
            mov dx,0
            mov ax,tmp
            inc bx
            div bx
            cmp dl,0
            jne chia2
            cmp bx,tmp
            mov ax,0
            je tangDem2
            jmp done
            
            tangDem2:
                inc dem
                jmp done
        
            done: 
             
        mov ah,9
        lea dx,msg2
        int 21h     
         
        call print
        
        mov ah,4Ch
        int 21h 
            
      main endp
    
      print proc
            mov bx,10
            mov cx,0
            mov ax,dem
            chia10:
                mov dx,0
                div bx
                push dx
                inc cx
                cmp ax,0
                jne chia10
                jmp hienthi
                    hienthi:
                        pop dx
                        add dl, 30h
                        mov ah,2
                        int 21h
                        loop hienthi  
      print endp 
        
    
end
