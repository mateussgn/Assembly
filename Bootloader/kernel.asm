org 0x7e00
jmp 0x0000:start
pos times 90 db 0;
var resb 0;

start:
    xor ax, ax
    mov ds, ax
    mov es, ax

    mov dx, 10
    call inserirBomba

    mov dx, 15
    call inserirBomba

    mov dx, 0
    call inserirBomba

    call config_tela
    call printarMapa

done:

inserirBomba:
    mov si, pos
    add si, dx
    
    mov di, si
    mov al, 'b'

    stosb

ret

fazer_leitura:
    mov ah, 0       ;numero da chamada
    int 16h         ;faz a leitura do tecxado e atribui em al

ret

config_tela:
    mov ah, 0       ;modo de video
    mov bh, 12h     ;modo de vga (360x200)
    int 10h

    mov ah, 0xb     ;modo da cor da tela
    mov bh, 0       ;ID paleta de cores
    mov bl, 1h      ;Cor desejada //  azul
    int 10h

ret

printarTela:
    mov ah, 2h
                ;dh vai ser a linha impressa
                ;dl vai ser a coluna impressa
    int 10h

    mov ah, 0xe    ;chamada para printar
    mov bh, 0      ;numero da pagina eh definido por bh 
    mov bl, 7h     ;cor da fonte
    int 10h        ;imprimi o conteudo eh defenido por al

ret

printarMapa:
    xor cx, cx     ;percorrer elemento por elemento

    .inicialprintarMapa:
    cmp cx, 90
        je .endprintarMapa
        
        call printarElemento
    jmp .inicialprintarMapa
    .endprintarMapa:
ret

printarElemento:
    mov si, pos
    add si, cx

    lodsb   ;al carrega a informação da posicao especifica
    
    cmp cx, 9
        jl .coluna0 

    cmp cx, 18
        jl .coluna1

    cmp cx, 27
        jl .coluna2

    cmp cx, 36
        jl .coluna3

    cmp cx, 45
        jl .coluna4

    cmp cx, 54
        jl .coluna5

    cmp cx, 63
        jl .coluna6

    cmp cx, 72
        jl .coluna7

    cmp cx, 81
        jl .coluna8

    cmp cx, 90
        jl .coluna9

ret

.coluna0:
    mov [var], cx
    mov dh, [var]

    mov dl, 0   ;dl vai representar o coluna impressa
    call printarTela
    
    inc cx;

ret

.coluna1:
    cmp cx, 9
        jl .endcoluna1

    sub cx, 9

    mov [var], cx

    mov dh, [var]
    mov dl, 1
    
    call printarTela
    add cx, 10

    .endcoluna1:
ret

.coluna2:
    cmp cx, 18
        jl .endcoluna2

    sub cx, 18

    mov [var], cx

    mov dh, [var]
    mov dl, 2
    
    call printarTela
    add cx, 19

    .endcoluna2:
ret

.coluna3:
    cmp cx, 27
        jl .endcoluna3

    sub cx, 27

    mov [var], cx

    mov dh, [var]
    mov dl, 3
    
    call printarTela
    add cx, 28

    .endcoluna3:
ret

.coluna4:
    cmp cx, 36
        jl .endcoluna4

    sub cx, 36

    mov [var], cx

    mov dh, [var]
    mov dl, 4
    
    call printarTela
    add cx, 37

    .endcoluna4:
ret

.coluna5:
    cmp cx, 45
        jl .endcoluna5

    sub cx, 45

    mov [var], cx

    mov dh, [var]
    mov dl, 5
    
    call printarTela
    add cx, 46

    .endcoluna5:
ret

.coluna6:
    cmp cx, 54
        jl .endcoluna6

    sub cx, 54

    mov [var], cx

    mov dh, [var]
    mov dl, 6
    
    call printarTela
    add cx, 55

    .endcoluna6:
ret

.coluna7:
    cmp cx, 63
        jl .endcoluna7

    sub cx, 63

    mov [var], cx

    mov dh, [var]
    mov dl, 7
    
    call printarTela
    add cx, 64

    .endcoluna7:
ret

.coluna8:
    cmp cx, 72
        jl .endcoluna8

    sub cx, 72

    mov [var], cx

    mov dh, [var]
    mov dl, 8
    
    call printarTela
    add cx, 73

    .endcoluna8:
ret

.coluna9:
    cmp cx, 81
        jl .endcoluna9

    sub cx, 81

    mov [var], cx

    mov dh, [var]
    mov dl, 9
    
    call printarTela
    add cx, 82

    .endcoluna9:
ret


    jmp $