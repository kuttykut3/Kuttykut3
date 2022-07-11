.model small
.stack 100
.data 
    msg1 db 10,13, "Nhap chuoi so(vd: '-12 23 44'): $"
    msg2 db 10,13, "Tong cac phan tu trong chuoi so: $"
    str db 100 dup("$")
    tmp dw ?
    sum dw ?
 
.code
    main proc
        mov ax, data
        mov ds, ax       
        
        ; in thong bao nhap chuoi so
        mov ah,09h
        lea dx, msg1
        int 21h
        ; nhap chuoi so 
        mov ah, 0Ah
        lea dx, str
        int 21h
        ;in thong bao tong chuoi so
        mov ah, 09h
        lea dx, msg2
        int 21h
        
        ;tinh tong chuoi so
        mov cx, 0
        mov cl, [str + 1]  ; chuyen do dai cua chuoi vao cl
        lea si, [str + 2]  ; lay dia chi ky tu dau tien luu vao si
        mov bx, 10
        mov ax, 0
        mov sum, ax 
        
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
        jmp nextLoop
        
        next1:
            inc tmp
            jmp nextLoop
            
        next2:
            cmp tmp,0
            jne tru
            jmp cong
            
            tru:
                mov tmp,0 
                sub sum, ax
                mov ax,0
                jmp nextLoop  
           
            cong:
                add sum,ax
                mov ax,0
                jmp nextLoop    
                

        nextLoop:     
            inc si
            loop calc
            
            cmp tmp,0
            jne tru2
            jmp cong2
            
            tru2:
                sub sum, ax
                jmp done  
           
            cong2:
                add sum,ax
                jmp done  
        
            done: 
        
        mov ax,sum
        call print     
        
        mov ah, 4ch
        int 21h
    main endp
    
   print proc
        mov bx, 10
        mov cx, 0
        chia10:
        mov dx, 0
        div bx    ; ax = ax / bx, dx = dx % bx
        push dx   ; day dx vao stack
        inc cx
        cmp ax, 0
        je hienthi
        jmp chia10
            hienthi:
                pop dx     ; lay dx tu stack
                add dl, 30h
                mov ah, 2
                int 21h
                dec cx
                cmp cx,0
                jne hienthi
                ret
        
    print endp
end