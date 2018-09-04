org 0x7c00 
jmp 0x0000:start


putchar:
    mov ah, 0x0e    ;
    int 10h         ;interrupção de vídeo
    ret


start:
	; nunca se esqueca de zerar o ds, pois apartir dele que o processador busca os dados utilizados no programa.
	xor ax, ax
	mov ds, ax

	;Início do seu código

    mov bl, 2       ;a
    mov bh, 2       ;b --> 2/2
    mov cl, 2       ;c
    mov ch, 2       ;d --> 2/2

    mov al, bl      ;movendo bl para al, para realizar a multiplicacao
    mul ch          ;a*d [al(bl)*ch]
    mov dl, al      ;resultado de a*d em bl

    mov al, bh
    mul cl          ;b*c [al(bh)*cl]
    mov dh, al      ;resultado de b*c em ch

    add dl, dh      ;resultado de (a*d)+(b*c) em dl

    mov al, bh
    mul ch          ;b*d [al(bh)*ch]
    mov dh, al      ;resultado de b*d em dh

    add dl, 48      ;colocando em ascii
    add dh, 48      ;colocando em ascii

    mov al, dl
    call putchar
    mov al, "/"
    call putchar
    mov al, dh
    call putchar


jmp $
times 510-($-$$) db 0       ; preenche o resto do setor com zeros 
dw 0xaa55                   ; coloca a assinatura de boot no final
                            ; do setor (x86 : little endian)

