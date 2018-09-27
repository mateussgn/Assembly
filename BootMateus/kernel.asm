org 0x7e00
jmp 0x0000:start

bemVindo db 'Seja Bem Vindo!', 13
iniciarJogo db '>Iniciar Jogo<', 13
titulo db 'Campo Minado', 13
perdeuOJogo db 'Game Over!!!', 13
reiniciarJogo db 'Jogar Novamente?[s/n]', 13


start:
	xor ax, ax
	mov ds, ax
	mov es, ax

	;DEFININDO MODO DE VÍDEO
	mov ah, 0
	mov al, 13h
	int 10h

	mov ah, 0xb
	xor bh, bh
	mov bl, 7
	int 10h

	call preencherCampos
	call cabecalho
	call tabuleiroInicial
	call gameOver
	call menu

	
done:
	jmp $

cabecalho:
	mov dh, 1 ;linha
	mov dl, 14 ;coluna
	call setarCursor
	mov si, titulo
	call imprimeString
ret

imprimeString:
	lodsb
	mov ah, 0xe
	xor bh, bh
	mov bl, 0xf
	int 10h
	cmp al, 13
	jne imprimeString
ret

tabuleiroInicial:
	;montando colunas
	mov cx, 91
	coluna:
	mov dx, 27
		desenhaColuna:
		mov al, 0xf ;cor
		call desenharPixel	
		inc dx
		cmp dx, 187
		jne desenhaColuna
	add cx, 16
	cmp cx, 251
	jne coluna
	;montando linhas
	mov dx, 27
	linha:
	mov cx, 91
		desenhaLinha:
		mov al, 0xf ;cor
		call desenharPixel
		int 10h	
		inc cx
		cmp cx, 235
		jne desenhaLinha
	add dx, 16
	cmp dx, 203
	jne linha
ret

desenharPixel:
	mov ah, 0Ch
	xor bh, bh
	int 10h
ret

preencherCampos:
    mov al, 'B'
	mov dh, 4 ;linha
	colunaCampo:
	mov dl, 12 ;coluna
		linhaCampo:
			call setarCursor
			call escreverNaTela
			add dl, 2
			cmp dl, 30
			jne linhaCampo;
	add dh, 2
	cmp dh, 24
	jne colunaCampo
ret

setarCursor:
	mov ah, 02h
	xor bh, bh
	int 10h
ret

escreverNaTela:
	mov ah, 09h
	xor bh, bh
	mov cx, 1
	int 10h
ret

limparTela:
	mov al, 4
	mov dx, 0
	comprimento:
		mov cx, 0
		largura:
			mov al, 0
			call desenharPixel
			inc cx
			cmp cx, 320
			jne largura
	inc dx
	cmp dx, 200
	jne comprimento
ret

gameOver:
	call limparTela

	mov dh, 7
	mov dl, 14
	call setarCursor
	mov si, perdeuOJogo
	call imprimeString

	mov dh, 12
	mov dl, 10
	call setarCursor
	mov si, reiniciarJogo
	call imprimeString
ret

menu:
	call limparTela

	mov dh, 7
	mov dl, 13
	call setarCursor
	mov si, bemVindo
	call imprimeString

	mov dh, 12
	mov dl, 14
	call setarCursor
	mov si, iniciarJogo
	call imprimeString
ret