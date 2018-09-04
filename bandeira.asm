org 0x7c00 
jmp 0x0000:start

start:
	; nunca se esqueca de zerar o ds, pois apartir dele que o processador busca os dados utilizados no programa.
	xor ax, ax
	mov ds, ax

	;Início do seu código

    mov ah, 0               ;numero da chamada 
    mov bh, 13h             ;modo video
    int 10h                 ;interrupção de video

    mov ah, 0xb             ;numero da chamada
    mov bh, 0               ;ID da paleta de cores
    mov bl, 2               ;cor desejada: amarelo
    int 10h

    mov ah, 0xb             ;numero da chamada
    mov bh, 0               ;ID da paleta de cores
    mov bl, 6               ;cor desejada: verde
    int 10h

    mov ah, 0xb             ;numero da chamada
    mov bh, 0               ;ID da paleta de cores
    mov bl, 1               ;cor desejada: azul
    int 10h
	

jmp $
times 510-($-$$) db 0       ; preenche o resto do setor com zeros 
dw 0xaa55                   ; coloca a assinatura de boot no final
                            ; do setor (x86 : little endian)

