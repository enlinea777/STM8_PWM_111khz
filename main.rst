                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.2.0 #13081 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module main
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _main
                                     12 	.globl _setup_timer2_for_pwm
                                     13 ;--------------------------------------------------------
                                     14 ; ram data
                                     15 ;--------------------------------------------------------
                                     16 	.area DATA
                                     17 ;--------------------------------------------------------
                                     18 ; ram data
                                     19 ;--------------------------------------------------------
                                     20 	.area INITIALIZED
                                     21 ;--------------------------------------------------------
                                     22 ; Stack segment in internal ram
                                     23 ;--------------------------------------------------------
                                     24 	.area	SSEG
      000001                         25 __start__stack:
      000001                         26 	.ds	1
                                     27 
                                     28 ;--------------------------------------------------------
                                     29 ; absolute external ram data
                                     30 ;--------------------------------------------------------
                                     31 	.area DABS (ABS)
                                     32 
                                     33 ; default segment ordering for linker
                                     34 	.area HOME
                                     35 	.area GSINIT
                                     36 	.area GSFINAL
                                     37 	.area CONST
                                     38 	.area INITIALIZER
                                     39 	.area CODE
                                     40 
                                     41 ;--------------------------------------------------------
                                     42 ; interrupt vector
                                     43 ;--------------------------------------------------------
                                     44 	.area HOME
      008000                         45 __interrupt_vect:
      008000 82 00 80 07             46 	int s_GSINIT ; reset
                                     47 ;--------------------------------------------------------
                                     48 ; global & static initialisations
                                     49 ;--------------------------------------------------------
                                     50 	.area HOME
                                     51 	.area GSINIT
                                     52 	.area GSFINAL
                                     53 	.area GSINIT
      008007                         54 __sdcc_init_data:
                                     55 ; stm8_genXINIT() start
      008007 AE 00 00         [ 2]   56 	ldw x, #l_DATA
      00800A 27 07            [ 1]   57 	jreq	00002$
      00800C                         58 00001$:
      00800C 72 4F 00 00      [ 1]   59 	clr (s_DATA - 1, x)
      008010 5A               [ 2]   60 	decw x
      008011 26 F9            [ 1]   61 	jrne	00001$
      008013                         62 00002$:
      008013 AE 00 00         [ 2]   63 	ldw	x, #l_INITIALIZER
      008016 27 09            [ 1]   64 	jreq	00004$
      008018                         65 00003$:
      008018 D6 80 23         [ 1]   66 	ld	a, (s_INITIALIZER - 1, x)
      00801B D7 00 00         [ 1]   67 	ld	(s_INITIALIZED - 1, x), a
      00801E 5A               [ 2]   68 	decw	x
      00801F 26 F7            [ 1]   69 	jrne	00003$
      008021                         70 00004$:
                                     71 ; stm8_genXINIT() end
                                     72 	.area GSFINAL
      008021 CC 80 04         [ 2]   73 	jp	__sdcc_program_startup
                                     74 ;--------------------------------------------------------
                                     75 ; Home
                                     76 ;--------------------------------------------------------
                                     77 	.area HOME
                                     78 	.area HOME
      008004                         79 __sdcc_program_startup:
      008004 CC 80 65         [ 2]   80 	jp	_main
                                     81 ;	return from main will return to caller
                                     82 ;--------------------------------------------------------
                                     83 ; code
                                     84 ;--------------------------------------------------------
                                     85 	.area CODE
                           000000    86 	Smain$setup_timer2_for_pwm$0 ==.
                                     87 ;	./main.c: 5: void setup_timer2_for_pwm(uint32_t pwm_frequency_hz) {
                                     88 ;	-----------------------------------------
                                     89 ;	 function setup_timer2_for_pwm
                                     90 ;	-----------------------------------------
      008024                         91 _setup_timer2_for_pwm:
                           000000    92 	Smain$setup_timer2_for_pwm$1 ==.
                           000000    93 	Smain$setup_timer2_for_pwm$2 ==.
                                     94 ;	./main.c: 10: arr_value = timer_clock / pwm_frequency_hz;
      008024 1E 05            [ 2]   95 	ldw	x, (0x05, sp)
      008026 89               [ 2]   96 	pushw	x
                           000003    97 	Smain$setup_timer2_for_pwm$3 ==.
      008027 1E 05            [ 2]   98 	ldw	x, (0x05, sp)
      008029 89               [ 2]   99 	pushw	x
                           000006   100 	Smain$setup_timer2_for_pwm$4 ==.
      00802A 4B 00            [ 1]  101 	push	#0x00
                           000008   102 	Smain$setup_timer2_for_pwm$5 ==.
      00802C 4B 24            [ 1]  103 	push	#0x24
                           00000A   104 	Smain$setup_timer2_for_pwm$6 ==.
      00802E 4B F4            [ 1]  105 	push	#0xf4
                           00000C   106 	Smain$setup_timer2_for_pwm$7 ==.
      008030 4B 00            [ 1]  107 	push	#0x00
                           00000E   108 	Smain$setup_timer2_for_pwm$8 ==.
      008032 CD 80 84         [ 4]  109 	call	__divulong
      008035 5B 08            [ 2]  110 	addw	sp, #8
                           000013   111 	Smain$setup_timer2_for_pwm$9 ==.
                           000013   112 	Smain$setup_timer2_for_pwm$10 ==.
                                    113 ;	./main.c: 12: *TIM2_PSCR = 0x00;          // Prescaler en 1 (PSC + 1 = 1)
      008037 35 00 53 0E      [ 1]  114 	mov	0x530e+0, #0x00
                           000017   115 	Smain$setup_timer2_for_pwm$11 ==.
                                    116 ;	./main.c: 13: *TIM2_ARRH = (arr_value >> 8) & 0xFF;  // Parte alta de ARR
      00803B 9E               [ 1]  117 	ld	a, xh
      00803C C7 53 0F         [ 1]  118 	ld	0x530f, a
                           00001B   119 	Smain$setup_timer2_for_pwm$12 ==.
                                    120 ;	./main.c: 14: *TIM2_ARRL = arr_value & 0xFF;         // Parte baja de ARR
      00803F 9F               [ 1]  121 	ld	a, xl
      008040 C7 53 10         [ 1]  122 	ld	0x5310, a
                           00001F   123 	Smain$setup_timer2_for_pwm$13 ==.
                                    124 ;	./main.c: 17: *TIM2_CCR1H = 0x00;
      008043 35 00 53 11      [ 1]  125 	mov	0x5311+0, #0x00
                           000023   126 	Smain$setup_timer2_for_pwm$14 ==.
                                    127 ;	./main.c: 18: *TIM2_CCR1L = (arr_value / 2) & 0xFF;
      008047 54               [ 2]  128 	srlw	x
      008048 9F               [ 1]  129 	ld	a, xl
      008049 C7 53 12         [ 1]  130 	ld	0x5312, a
                           000028   131 	Smain$setup_timer2_for_pwm$15 ==.
                                    132 ;	./main.c: 20: *TIM2_CCMR1 = 0x60;         // Modo PWM1 (modo 6 en CCMR)
      00804C 35 60 53 07      [ 1]  133 	mov	0x5307+0, #0x60
                           00002C   134 	Smain$setup_timer2_for_pwm$16 ==.
                                    135 ;	./main.c: 21: *TIM2_CCER1 |= (uint8_t)0x01; // Habilita la salida en el canal 1 (OC1) en modo activo
      008050 C6 53 0A         [ 1]  136 	ld	a, 0x530a
      008053 AA 01            [ 1]  137 	or	a, #0x01
      008055 C7 53 0A         [ 1]  138 	ld	0x530a, a
                           000034   139 	Smain$setup_timer2_for_pwm$17 ==.
                                    140 ;	./main.c: 23: *TIM2_CR1 |= (uint8_t)0x01; // Inicia el temporizador TIM2
      008058 C6 53 00         [ 1]  141 	ld	a, 0x5300
      00805B AA 01            [ 1]  142 	or	a, #0x01
      00805D C7 53 00         [ 1]  143 	ld	0x5300, a
      008060                        144 00101$:
                           00003C   145 	Smain$setup_timer2_for_pwm$18 ==.
                                    146 ;	./main.c: 24: }
      008060 1E 01            [ 2]  147 	ldw	x, (1, sp)
      008062 5B 06            [ 2]  148 	addw	sp, #6
                           000040   149 	Smain$setup_timer2_for_pwm$19 ==.
      008064 FC               [ 2]  150 	jp	(x)
                           000041   151 	Smain$setup_timer2_for_pwm$20 ==.
                           000041   152 	Smain$main$21 ==.
                                    153 ;	./main.c: 26: void main() {
                                    154 ;	-----------------------------------------
                                    155 ;	 function main
                                    156 ;	-----------------------------------------
      008065                        157 _main:
                           000041   158 	Smain$main$22 ==.
                           000041   159 	Smain$main$23 ==.
                                    160 ;	./main.c: 28: *PD_DDR |= (uint8_t)(1 << 4);  // Configura el pin PD4 como salida
      008065 C6 50 11         [ 1]  161 	ld	a, 0x5011
      008068 AA 10            [ 1]  162 	or	a, #0x10
      00806A C7 50 11         [ 1]  163 	ld	0x5011, a
                           000049   164 	Smain$main$24 ==.
                                    165 ;	./main.c: 29: *PD_CR1 |= (uint8_t)(1 << 4);  // Configura PD4 como push-pull
      00806D C6 50 12         [ 1]  166 	ld	a, 0x5012
      008070 AA 10            [ 1]  167 	or	a, #0x10
      008072 C7 50 12         [ 1]  168 	ld	0x5012, a
                           000051   169 	Smain$main$25 ==.
                                    170 ;	./main.c: 32: setup_timer2_for_pwm(939900); // Aquí puedes cambiar la frecuencia deseada
      008075 4B 7C            [ 1]  171 	push	#0x7c
                           000053   172 	Smain$main$26 ==.
      008077 4B 57            [ 1]  173 	push	#0x57
                           000055   174 	Smain$main$27 ==.
      008079 4B 0E            [ 1]  175 	push	#0x0e
                           000057   176 	Smain$main$28 ==.
      00807B 4B 00            [ 1]  177 	push	#0x00
                           000059   178 	Smain$main$29 ==.
      00807D CD 80 24         [ 4]  179 	call	_setup_timer2_for_pwm
                           00005C   180 	Smain$main$30 ==.
                           00005C   181 	Smain$main$31 ==.
                                    182 ;	./main.c: 34: while (1) {
      008080                        183 00102$:
      008080 CC 80 80         [ 2]  184 	jp	00102$
      008083                        185 00104$:
                           00005F   186 	Smain$main$32 ==.
                                    187 ;	./main.c: 37: }
                           00005F   188 	Smain$main$33 ==.
                           00005F   189 	XG$main$0$0 ==.
      008083 81               [ 4]  190 	ret
                           000060   191 	Smain$main$34 ==.
                                    192 	.area CODE
                                    193 	.area CONST
                                    194 	.area INITIALIZER
                                    195 	.area CABS (ABS)
