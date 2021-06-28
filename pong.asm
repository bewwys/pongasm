org 0x7C00

;;draw:
;;	mov byte [es:bx], 0x0F
;;	inc bx
;;	cmp bx, WIDTH
;;	jb draw
;;	jmp $

%define ROW    100
%define WIDTH  320
%define HEIGHT 200

%define RECT_WIDTH  360 ;; in pixel
%define RECT_HEIGHT 260 ;; in pixel

;;section .data

	;; TODO(mohamed): Prove that dw can influence the program if not care is taken.

	x_pos: dw 0
	y_pos: dw 0

	count_i: dw 0
	count_j: dw 0

	pixel_location: dw 0

;;section .text
	; VGA mode 0x13
	; 320x200 256 colors
	mov ah, 0x00
	mov al, 0x13
	int 0x10


	;; Set video buffer location
	mov ax, 0xA000
	mov es, ax

get_row:
	;; Get the right row
	mov ax, [count_j]
	mov sp, WIDTH
	mul sp
	
draw_rect:
	mov bx, ax
	add bx, [count_i]
	mov byte [es:bx], 0x0F
	inc word [count_i]
	cmp word [count_i], RECT_WIDTH
	jle draw_rect

	mov word [count_i], 0
	inc word [count_j]
	cmp word [count_j], RECT_HEIGHT
	jle get_row

	jmp $

	times 510 - ($-$$) db 0
magic_number:
	dw 0xaa55