.model small
.stack 100h
.data
   msg1 db 10,13, "Nhap ma sinh vien: $"
   maSV db 100 dup('$')
   ktra db "AT160437$"
   msg2 db 10,13, "Ten va MSV cua ban la: $"
   ten db "Nguyen Tai Phuc $"
   
.code
   mov ax,data
   mov ds,ax
   mov es,ax
   
   mov ah,9
   lea dx,msg1
   int 21h
   
   mov ah,0Ah
   lea dx,maSV
   int 21h
   
   xuly:
   cld  ; chon chieu xu ly chuoi
   mov cx, 8    ; so ky tu/so byte can so sanh
   lea si, [maSV+2]  ; dia chi chuoi nguon
   lea di, ktra   ;dia chi chuoi dich
   repe cmpsb  ; so sanh tung ky tu/byte
   je  khop
   jmp nhaplai
   
   khop:
        mov ah,9
        lea dx,msg2
        int 21h

        lea dx, ten
        int 21h 
        
        lea dx,[maSV+2]
        int 21h

        jmp done
   
   nhaplai:
       mov ah,9
       lea dx,msg1
       int 21h
       
       mov ah,0Ah
       lea dx,maSV
       int 21h
       
       jmp xuly
   
   done:
        mov ah,4Ch
        int 21h
end