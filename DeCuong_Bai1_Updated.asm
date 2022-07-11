.model small
.stack 100h
.data
    msg1 db "Nhap so n : $"
    msg2 db 10,13, " n! = $"  
    msg3 db 10,13, "Vui long nhap trong khoang 0<n<9! Nhap lai:  $"
    x dw ?
    y dw ?
    
.code  
    main proc
    mov ax,data
    mov ds,ax
 
    ;in thong bao nhap so n:
    mov ah,9
    lea dx, msg1
    int 21h
    
    ;goi ham nhap
    call nhap
    
    ;tinh giai thua  
    ; chi tinh dung giai thua <= 8 do thanh ghi chi co 16 bit
    mov ah,09h
    lea dx,msg2
    int 21h
    
    mov bx,x
    mov ax,1
    giaithua:
        mul bx
        dec bx
        cmp bx,0
        je xong
        jmp giaithua
    xong:
        mov x,ax
        call print
    
    ; ket thuc chuong trinh
    mov ah, 4Ch
    int 21h 
    
    main endp
    
    nhap proc
        mov x,0
        mov y,0
        mov bx,10
        
        nhaplientuc:
        mov ah,1h   ;nhap 1 ky tu, ket qua luu vao AL
        int 21h
        cmp al,13   ; so sanh ky tu vua nhap voi phim Enter
        je nhap_xong    ; neu trung` chuyen den ham
        cmp al,'-'
        je nhaplai
        sub al,30h    ;gia tri nhap vao theo bang ma ascii, tru di 30 de ve gia tri so
        xor ah,ah     ; dua ah ve = 0, khi nay AX = AL = gia tri nhap vao
        mov y,ax      ; chuyen gia tri vua nhap vao y
        mov ax,x      ; khoi dau vong lap, cho ax = 0, o cac lan lap sau ax = x
        mul bx        ; nhan bx voi ax
        add ax,y      ; cong y vao ax
        mov x,ax      ; luu gia tri vao bien x
        jmp nhaplientuc  ; tiep tuc vong lap
        
        nhap_xong:
            cmp x,9
            jae nhaplai
            
            ret
        nhaplai: 
            mov ah,9
            lea dx,msg3
            int 21h 
            jmp nhap
            
    nhap endp
    
    print proc
        mov ax,x
        mov bx,10
        mov cx,0  ; bien dem
        chia:
            mov dx,0
            div bx ; ax = ax / bx ; dx = ax % bx
            push dx  ;lay du cua phep chia cho vao stack
            inc cx   ; tang bien dem len 1
            cmp ax,0
            je hienthi
            jmp chia
            
            hienthi:
                pop dx  ; lay dx tu stack
                add dl,30h  ;them 30h de in ra ky tu theo bang ma ascii
                mov ah,2  ; in 1 ky tu
                int 21h
                dec cx    ; giam bien dem
                cmp cx,0
                jne hienthi
                ret
     print endp
    
end
                                                       
                                                       