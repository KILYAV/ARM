negative result exp
	adds r2, #0x7f
	it mi
	cmpmi r2, #-25
	bmi _div32_zero_exit

// inf exp
	cmp r2, #0xff
	bge _div32_inf_exit_second

// stage-1
	push {r2-r3}
	lsl r0, #8
	udiv r2, r0, r1
	mul r3, r2, r1
	sub r0, r3
	lsl r0, #8

// stage-2
	udiv r3, r0, r1
	orr r2, r3, r2, lsl #8
	mul r3, r3, r1
	sub r0, r3
	lsl r0, #8

// stage-3 plus one bit
	udiv r3, r0, r1
	orr r2, r3, r2, lsl #8
	mul r3, r3, r1
	sub r0, r3
	lsl r0, #1
	subs r0, r1
	adc r0, r2, r2
	add r0, #1
	lsr r0, #1
	pop {r2-r3}

//
	cmp r0, #0x01000000
	ite hs
	lsrhs r0, #1
	sublo r2, #1

//
	cmp r2, #0
	it gt
	bicgt r0, #0x00800000
	itttt le
	mvnle r2, r2
	addle r2, #2
	lsrle r0, r2
	eorle r2, r2

	orrs r0, r0, r2, lsl #23
	it eq
	orreq r0, r0, r3, lsl #31
	bx lr

_div32_nan_exit_fourth:
	mov r1, #0x7f800000
_div32_nan_exit_third:
	orr r1, #0x00400000
_div32_nan_exit_second:
	mov r0, r1
_div32_inf_exit_first:
_div32_nan_exit_first:
	bx lr

_div32_zero_exit:
	eor r0, r0
	bx lr

_div32_inf_exit_second:
	mov r0, #0x7f800000
	orr r0, r0, r3, lsl #31
	bx lr
