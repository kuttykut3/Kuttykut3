.model small
.stack 100h
.data
   msg1 db 10,13,"Nhap vao so nguyen n: $"
   msg2 db 10,13,"Gia tri n! = $"
   n dw ?  
   gt dw ?
.code 
    main proc
   mov ax,data
   mov ds,ax
   
   nhap:          
       mov ah,9
       lea dx,msg1
       int 21h
   
        mov ah,1
        int 21h
        
        cmp al, '-'
        je nhap
        sub al,30h
        mov ah,0
        mov n,ax
        
        mov ax,1
        mov bx,1
        calc:
            mul bx
            inc bx
            dec n
            cmp n,0
            jne calc
            jmp done
            
            done:
                mov gt,ax
                mov ah,9
                lea dx,msg2
                int 21h
                
                call print    
     main endp
    
    
    print proc
        mov bx,10
        mov cx,0
        mov ax,gt
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
                    mov ah,2
                    int 21h
                    loop hienthi
        
    print endp
end