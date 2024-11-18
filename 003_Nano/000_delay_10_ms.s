;specify equivalent symbols
.equ SREG, 0x3F		;Status register, address 0x3F. See datasheet, P.11
.equ DDRB, 0x04		;DDRB - Data Direction Register
.equ PORTB, 0x05		;PORTB - PORTB register
.equ DDRC, 0x07
.equ PORTC, 0x08
.equ DDRD, 0x0A
.equ PORTD, 0x0B

;specify the start address
.org 0x00
;reset system status
main:
	ldi r16, 0x00	;set register r16 to zero
	out SREG, r16	;copy contents of r16 to SREG, i.e: clear SREG

	;ldi r16, 0x20	;0b00100000 - set bit 5 of DDRB as output
	ldi r16, 0x0F	;0b00001111 - set PORTB3 - PORTB0 as output
	out DDRB, r16
	ldi r16, 0xF2	;0b11110010 - set PORTD7-PORTD4 on PORTD as output
			;PIND0 - rx - input | PORTD1 - tx - output
	out DDRD, r16
	

mainloop:
	ldi r16, 0x0F
	out PORTB, r16
	ldi r16, 0xF0
	out PORTD, r16

	call delay_1_second

	ldi r16, 0xF0
	out PORTB, r16
	ldi r16, 0x0F
	out PORTD, r16

	call delay_1_second

	rjmp mainloop	;jump back to mainloop address


display_k_number:

display_initials:

delay_1_second:
	ldi r19, 99		;
delay_10_milliseconds:		;MCU_frequency = 16MHz, 1 cycle = 62.5 nanosecond
				;1 microsecond = 1000 nanoseconds = 16 cycles 
				;1 millisecond = 1000 microseconds = 16,000 cycles
				;10 milliseconds = 160,000 cycles
	ldi r18, 160		;1 second = 1000 milliseconds = 16,000,000 cycles
loop_1000_cycles:		;acturally 1000 + 1 = 1001 cycles
	ldi r17, 250
loop_4_cycles:			;4 cycles
	nop
	dec r17
	cpi r17, 0
	brne loop_4_cycles

	dec r18
	;cpi r18, 0
	brne loop_1000_cycles

	dec r19
	;cpi r19, 0
	brne delay_10_milliseconds

	ret
