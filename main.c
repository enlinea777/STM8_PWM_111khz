#include <stm8s.h>
#include <iostm8s103.h>

 //CODIGO PARA GENERAR UN PWM de 111Khz

// Función para configurar el temporizador TIM2 con una frecuencia PWM deseada
void setup_timer2_for_pwm(uint32_t pwm_frequency_hz) {
    uint32_t timer_clock = 16000000; // Frecuencia del reloj del temporizador (16 MHz)
    uint16_t arr_value;

    // Calcula el valor de ARR para alcanzar la frecuencia deseada
    arr_value = timer_clock / pwm_frequency_hz;

    *TIM2_PSCR = 0x00;          // Prescaler en 1 (PSC + 1 = 1)
    *TIM2_ARRH = (arr_value >> 8) & 0xFF;  // Parte alta de ARR
    *TIM2_ARRL = arr_value & 0xFF;         // Parte baja de ARR

    // Configura un duty cycle del 50%
    *TIM2_CCR1H = 0x00;
    *TIM2_CCR1L = (arr_value / 2) & 0xFF;

    *TIM2_CCMR1 = 0x60;         // Modo PWM1 (modo 6 en CCMR)
    *TIM2_CCER1 |= (uint8_t)0x01; // Habilita la salida en el canal 1 (OC1) en modo activo

    *TIM2_CR1 |= (uint8_t)0x01; // Inicia el temporizador TIM2
}

void main() {
    // Configura PD4 como salida
    *PD_DDR |= (uint8_t)(1 << 4);  // Configura el pin PD4 como salida
    *PD_CR1 |= (uint8_t)(1 << 4);  // Configura PD4 como push-pull

    // Llama a la función con la frecuencia deseada en Hz
    setup_timer2_for_pwm(939900); // Aquí puedes cambiar la frecuencia deseada

    while (1) {
        // Bucle infinito
    }
}



//  sdcc -lstm8 -mstm8 --opt-code-size --out-fmt-elf --out-fmt-ihx --all-callee-saves --debug --verbose --stack-auto --fverbose-asm --std-sdcc99 --nogcse  --float-reent --no-peep -I./ -I./stm8s-sdcc/inc/ -DSTM8S003 ./main.c
//  sdcc -mstm8 --out-fmt-elf --all-callee-saves --debug --verbose --stack-auto --fverbose-asm  --float-reent --no-peep -I./ -I./stm8s-sdcc/inc/ -D STM8S003 ./main.c

// carga       stm8flash -c stlinkv2 -p stm8s103f3 -w main.ihx

// CODIGO PARA CARGA
//  sdcc -lstm8 -mstm8 --opt-code-size --out-fmt-elf --out-fmt-ihx --all-callee-saves --debug --verbose --stack-auto --std-sdcc99 --nogcse  --float-reent --no-peep -I./ -I/archivos/stm8/stm8s-sdcc/inc/ -DSTM8S003 ./main.c && stm8flash -c stlinkv2 -p stm8s103f3 -w main.ihx