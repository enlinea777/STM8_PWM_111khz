;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.2.0 #13081 (Linux)
;--------------------------------------------------------
	.module main
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _setup_timer2_for_pwm
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
;--------------------------------------------------------
; Stack segment in internal ram
;--------------------------------------------------------
	.area	SSEG
__start__stack:
	.ds	1

;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area DABS (ABS)

; default segment ordering for linker
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area CONST
	.area INITIALIZER
	.area CODE

;--------------------------------------------------------
; interrupt vector
;--------------------------------------------------------
	.area HOME
__interrupt_vect:
	int s_GSINIT ; reset
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
__sdcc_init_data:
; stm8_genXINIT() start
	ldw x, #l_DATA
	jreq	00002$
00001$:
	clr (s_DATA - 1, x)
	decw x
	jrne	00001$
00002$:
	ldw	x, #l_INITIALIZER
	jreq	00004$
00003$:
	ld	a, (s_INITIALIZER - 1, x)
	ld	(s_INITIALIZED - 1, x), a
	decw	x
	jrne	00003$
00004$:
; stm8_genXINIT() end
	.area GSFINAL
	jp	__sdcc_program_startup
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
__sdcc_program_startup:
	jp	_main
;	return from main will return to caller
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
	Smain$setup_timer2_for_pwm$0 ==.
;	./main.c: 5: void setup_timer2_for_pwm(uint32_t pwm_frequency_hz) {
;	-----------------------------------------
;	 function setup_timer2_for_pwm
;	-----------------------------------------
_setup_timer2_for_pwm:
	Smain$setup_timer2_for_pwm$1 ==.
	Smain$setup_timer2_for_pwm$2 ==.
;	./main.c: 10: arr_value = timer_clock / pwm_frequency_hz;
	ldw	x, (0x05, sp)
	pushw	x
	Smain$setup_timer2_for_pwm$3 ==.
	ldw	x, (0x05, sp)
	pushw	x
	Smain$setup_timer2_for_pwm$4 ==.
	push	#0x00
	Smain$setup_timer2_for_pwm$5 ==.
	push	#0x24
	Smain$setup_timer2_for_pwm$6 ==.
	push	#0xf4
	Smain$setup_timer2_for_pwm$7 ==.
	push	#0x00
	Smain$setup_timer2_for_pwm$8 ==.
	call	__divulong
	addw	sp, #8
	Smain$setup_timer2_for_pwm$9 ==.
	Smain$setup_timer2_for_pwm$10 ==.
;	./main.c: 12: *TIM2_PSCR = 0x00;          // Prescaler en 1 (PSC + 1 = 1)
	mov	0x530e+0, #0x00
	Smain$setup_timer2_for_pwm$11 ==.
;	./main.c: 13: *TIM2_ARRH = (arr_value >> 8) & 0xFF;  // Parte alta de ARR
	ld	a, xh
	ld	0x530f, a
	Smain$setup_timer2_for_pwm$12 ==.
;	./main.c: 14: *TIM2_ARRL = arr_value & 0xFF;         // Parte baja de ARR
	ld	a, xl
	ld	0x5310, a
	Smain$setup_timer2_for_pwm$13 ==.
;	./main.c: 17: *TIM2_CCR1H = 0x00;
	mov	0x5311+0, #0x00
	Smain$setup_timer2_for_pwm$14 ==.
;	./main.c: 18: *TIM2_CCR1L = (arr_value / 2) & 0xFF;
	srlw	x
	ld	a, xl
	ld	0x5312, a
	Smain$setup_timer2_for_pwm$15 ==.
;	./main.c: 20: *TIM2_CCMR1 = 0x60;         // Modo PWM1 (modo 6 en CCMR)
	mov	0x5307+0, #0x60
	Smain$setup_timer2_for_pwm$16 ==.
;	./main.c: 21: *TIM2_CCER1 |= (uint8_t)0x01; // Habilita la salida en el canal 1 (OC1) en modo activo
	ld	a, 0x530a
	or	a, #0x01
	ld	0x530a, a
	Smain$setup_timer2_for_pwm$17 ==.
;	./main.c: 23: *TIM2_CR1 |= (uint8_t)0x01; // Inicia el temporizador TIM2
	ld	a, 0x5300
	or	a, #0x01
	ld	0x5300, a
00101$:
	Smain$setup_timer2_for_pwm$18 ==.
;	./main.c: 24: }
	ldw	x, (1, sp)
	addw	sp, #6
	Smain$setup_timer2_for_pwm$19 ==.
	jp	(x)
	Smain$setup_timer2_for_pwm$20 ==.
	Smain$main$21 ==.
;	./main.c: 26: void main() {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
	Smain$main$22 ==.
	Smain$main$23 ==.
;	./main.c: 28: *PD_DDR |= (uint8_t)(1 << 4);  // Configura el pin PD4 como salida
	ld	a, 0x5011
	or	a, #0x10
	ld	0x5011, a
	Smain$main$24 ==.
;	./main.c: 29: *PD_CR1 |= (uint8_t)(1 << 4);  // Configura PD4 como push-pull
	ld	a, 0x5012
	or	a, #0x10
	ld	0x5012, a
	Smain$main$25 ==.
;	./main.c: 32: setup_timer2_for_pwm(939900); // Aquí puedes cambiar la frecuencia deseada
	push	#0x7c
	Smain$main$26 ==.
	push	#0x57
	Smain$main$27 ==.
	push	#0x0e
	Smain$main$28 ==.
	push	#0x00
	Smain$main$29 ==.
	call	_setup_timer2_for_pwm
	Smain$main$30 ==.
	Smain$main$31 ==.
;	./main.c: 34: while (1) {
00102$:
	jp	00102$
00104$:
	Smain$main$32 ==.
;	./main.c: 37: }
	Smain$main$33 ==.
	XG$main$0$0 ==.
	ret
	Smain$main$34 ==.
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
