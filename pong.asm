org 0x7C00

%define VIDEO_BUFFER_LOCATION 0xA000

%define WIDTH  320
%define HEIGHT 260

%define RECT_WIDTH  5 ;; in pixel
%define RECT_HEIGHT 5 ;; in pixel

;;%UNSIGNED_SHORT_MAX 0xFFFF
;;%NUMBER_OF_PIXELS 0x16DA0



;;section .data

	;; TODO(): Prove that dw can influence the program if not care is taken.

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

main_loop:
	mov ch, 0x0F
	call draw_rect
	call sleep
	mov ch, 0x0
	call draw_rect
	;; Set next rect position
	mov word [count_j], 0
	inc word [y_pos]
	cmp word [y_pos], HEIGHT

	jmp main_loop

;; TODO(): Ok my logic here is a bit crapy but it's work. Maybe refactor a little bit ???

draw_rect:
	;; Get the right row
	mov ax, [count_j]
	add ax, [y_pos]
	mov dx, WIDTH
	mul dx
	
draw_rect_i:
	mov bx, ax
	add bx, [count_i]
	mov byte [es:bx], ch
	inc word [count_i]
	cmp word [count_i], RECT_WIDTH
	jle draw_rect_i

draw_rect_j:
	mov word [count_i], 0
	inc word [count_j]
	cmp word [count_j], RECT_HEIGHT
	jle draw_rect

	mov word [count_j], 0x0
	ret

sleep:
	;;WAIIIIIIIIIIIT !!!
	mov al, 0
	mov ah, 0x86
	mov cx, 0x0
	mov dx, 0x3E80
	int 0x15
	ret
	
	times 510 - ($-$$) db 0
magic_number:
	dw 0xaa55