# Código para Generar un PWM de 111 kHz

Este documento describe cómo compilar y cargar el código en un microcontrolador STM8S para generar un PWM de 111 kHz.

## Compilación del Código

Para compilar el código, usa uno de los siguientes comandos con `sdcc`:

```bash
# Opción 1
sdcc -lstm8 -mstm8 --opt-code-size --out-fmt-elf --out-fmt-ihx --all-callee-saves --debug --verbose --stack-auto --fverbose-asm --std-sdcc99 --nogcse --float-reent --no-peep -I./ -I./stm8s-sdcc/inc/ -DSTM8S003 ./main.c

# Opción 2
sdcc -mstm8 --out-fmt-elf --all-callee-saves --debug --verbose --stack-auto --fverbose-asm --float-reent --no-peep -I./ -I./stm8s-sdcc/inc/ -D STM8S003 ./main.c


# Cargar el Código
stm8flash -c stlinkv2 -p stm8s103f3 -w main.ihx


# Compilar y Cargar en un Solo Comando
sdcc -lstm8 -mstm8 --opt-code-size --out-fmt-elf --out-fmt-ihx --all-callee-saves --debug --verbose --stack-auto --std-sdcc99 --nogcse --float-reent --no-peep -I./ -I/archivos/stm8/stm8s-sdcc/inc/ -DSTM8S003 ./main.c && stm8flash -c stlinkv2 -p stm8s103f3 -w main.ihx

