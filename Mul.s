// void operator*= (_float);
.global _ZN6_floatmLES_
_ZN6_floatmLES_:
	push {r0, lr}
	ldr r0, [r0]
	bl _Zml6_floatS_
	pop {r1, lr}
	str r0, [r1]
	bx lr

// friend _float operator* (_float, _float);
.global _Zml6_floatS_
_Zml6_floatS_:
// compare && swap -> min & max
	ror r0, #31
	ror r2, r1, #31
	cmp r0, r2
	mov r1, r2
	itt lo
	movlo r1, r0
	movlo r0, r2

// sigma second number
	lsl r2, r1, #31
	eor r0, r0, r2, lsr #31
	bic r1, #1

// test nan
	bics r2, r0, #1
	cmp r2, #0xff000000
	bhi _mul32_nan_exit_first

// test ( nan || inf )
	it eq
	cmpeq r1, #0
	bhs _mul32_nan_exit_second

// compare ( zero || denorm )
	tst r1, r1
	beq _mul32_zero_exit
	tst r0, #0xff000000
	beq _mul32_zero_exit

// exp
	lsrs r2, r1, #24
	itt ne
	bicne r1, #0xff000000
	orrne r1, #0x01000000

	clz r3, r1
	sub r3, #7
	lsl r1, r3
	sub r2, r3

	add r2, r2, r0, lsr #24
	bic r0, #0xff000000
	orr r0, #0x01000000

// negative result exp
	subs r2, #0x7f
	it mi
	cmpmi r2, #-25
	bmi _mul32_zero_exit

// inf exp
	cmp r2, #0xff
	bge _mul32_inf_exit

// calculation
	lsl r3, r0, #31
	bic r0, #1
	umull r1, r0, r1, r0
	lsl r0, #8
	orr r0, r0, r1, lsr #24
	add r0, #1
	lsr r0, #1

// increment exponent
	cmp r0, #0x01000000
	itt hs
	addhs r2, #1
	lsrhs r0, #1

// test infinite anf clear mantissa
	cmp r2, #0xff
	it eq
	lsreq r0, #24

// checking the exponent and shifting the mantissa to the right if the exponent is negative
	cmp r2, #0
	it ge
	bicge r0, #0x00800000
	itttt lt
	mvnlt r2, r2
	addlt r2, #1
	lsrlt r0, r2
	eorlt r2, r2

// added exponent and sign to the final result
	orr r0, r0, r2, lsl #23
	orr r0, r0, r3
	bx lr

_mul32_zero_exit:
	eor r0, r0
	bx lr

_mul32_inf_exit:
	and r0, #1
	orr r0, #0xff000000
	ror r0, #1
	bx lr

_mul32_nan_exit_second:
	orr r0, #0x00800000
_mul32_nan_exit_first:
	ror r0, #1
	bx lr
