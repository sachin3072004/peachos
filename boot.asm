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
	jmp  print1

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


	mov word[ss:0x04], handle_one
	mov word[ss:0x06], 0x7c0
	int 1

	mov si, message
	call print
	jmp $
print:
	.loop:
		lodsb
		cmp al,1
		je .done
		call print_char
		jmp .loop
	.done:
		ret
		
	print_char:
	mov ah, 0eh
	int 0x10
	ret
message: db 'Hello World!',1
times 510 - ($ - $$) db 0	
dw 0xAA55
