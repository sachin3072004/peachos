ORG 0
BITS 16

_start:

	cli
	mov ax, 0x7c0
	mov ds, ax
	mov es, ax
	mov ax, 0x00
	mov ss, ax
	mov sp, 0x7c00
	sti
	mov ah, 2
	mov al, 1
	mov ch, 0
	mov cl, 2
	mov dh, 0
	mov bx,buffer	
	int 0x13
	jc error 
	mov si, buffer
	call print
	jmp $
	jmp  print1

error:
	mov si, error_message
	call print
	jmp $
handle_zero:
	mov ah, 0eh
	mov al,'A'
	int 0x10
	iret

handle_one:
	mov ah, 0eh
	mov al,'B'
	int 0x10
	iret

print1:
	mov ah, 0eh
	mov al,'Z'
	int 0x10

	mov word[ss:0x00], handle_zero
	mov word[ss:0x02], 0x7c0
	
	mov ax,0x00
	div ax

	mov word[ss:0x04], handle_one
	mov word[ss:0x06], 0x7c0
	int 1

	mov si, message
	call print
	jmp $
print:
	.loop:
		lodsb
		cmp al,0
		je .done
		call print_char
		jmp .loop
	.done:
		ret
		
	print_char:
	mov ah, 0eh
	int 0x10
	ret
error_message: db 'Failed to load sector',0
message: db 'Hello World!',0
times 510 - ($ - $$) db 0	
dw 0xAA55
buffer:
