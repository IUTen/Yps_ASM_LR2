use16
org 0x100

mov ax, 0xb800
mov es, ax

mov di, 0xae0		
mov si, message

mov cx, 13
lp:
	movsw
	loop lp


mov ax,0
int 16h
int 20h

message:
	dw 0x8E53, 0x8E41, 0x8E4D, 0x8E53, 0x8E4F, 0x8E4E, 0x8E4F, 0x8E56, 0x8E20, 0x8e45, 0x8e47, 0x8e4F, 0x8e52