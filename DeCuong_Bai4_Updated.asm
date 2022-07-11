; dem so luong so chia het cho 5 trong chuoi so
.model small
.stack 100h
.data 
   
   msg1 db 10,13, "Nhap vao chuoi so (vd -12 23 34): $"
   msg2 db 10,13, "So luong so chia het cho 5 la: $"
   str db 60 dup ("$")
   dem dw ?
.code
    main proc
   mov ax,data
   mov ds,ax
   
   ;in tb nhap chuoi
   mov ah,09h
   lea dx,msg1
   int 21h
   
   ;nhap chuoi
   mov ah,0Ah
   lea dx,str
   int 21h
   
   ;xu ly:
   mov cx,0
   mov cl, [str+1]
   lea si, [str+2]
   mov bx,10
   mov ax,0
   mov dem,ax
   loop1:
    mov dx,[si]
    cmp dl,'-'
    je soAm
    mov dx,[si]
    cmp dl,20h
    je next1
    mul bx
    mov dx,[si]
    mov dh,0
    sub dl,30h
    add ax,dx
    jmp next2
    
        soAm:
            jmp next2
            
        next1:
        mov dx,0
        mov bx,5
        div bx
        cmp dx,0
        je tangDem
        mov ax,0
        mov bx,10
        jmp next2
        tangDem:
            inc dem
        
        next2:
        inc si
        loop loop1
        
        mov dx,0
        mov bx,5
        div bx
        cmp dx,0
        je tangDem2
        jmp next3
        tangDem2:
            inc dem
        
        next3:
        ;in tb kq
        mov ah,09h
        lea dx,msg2
        int 21h
        
        call print
        
        mov ah,4Ch
        int 21h
        
   main endp
   
   print proc
        mov cx,0
        mov bx,10
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
                add dl,30h
                mov ah,02h
                int 21h
                dec cx
                cmp cx,0
                jne hienthi
                ret
    
   print endp 
end