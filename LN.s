// 	_float _float::Ln();
.global _ZN6_float2LnEv
_ZN6_float2LnEv:
	cmp r0, #0x80000000
	bhs _ln_nan_exit
	tst r0, r0
	beq _ln_nan_exit

	cmp r0, #0x7f800000
	it hs
	bxhs lr

	lsrs r3, r0, #23
	beq _ln_neg_inf_exit

	eors r0, r0, r3, lsl #23
	beq _ln_exp_exit

// (x - 1) / (x + 1)
	lsls r0, #9
	add r3, r3, r0, lsr #31
	push {r3-r6}
	lsr r5, r0, #31

	asr r0, #1
	lsr r1, r0, #8
	orr r1, #0x01000000
	itt mi
	mvnmi r0, r0
	addmi r0, #1

	clz r4, r0
	lsl r0, r4

	cmp r0, r1, lsl #7
	ite pl
	lsrpl r0, #1
	addmi r4, #1
	eor r3, r3

_ln_div:
	udiv r2, r0, r1
	orr r3, r2, r3, lsl #7
	mul r2, r2, r1
	sub r0, r2
	rsbs r2, r1, r0, lsl #1
	it mi
	lslmi r2, r0, #1
	lsl r0, r2, #7
	adcs r3, r3
	bpl _ln_div

// argument & argument^2
	push {r3-r5}
	ldr r1, _ln_cons + 16
	cmp r4, #15
	bhs _ln_add_mul

	umull r1, r0, r3, r3
	clz r2, r0
	lsl r0, r2
	add r4, r2, r4, lsl #1
//	orrpl r0, r0, r1, lsr #31

	adr r6, _ln_cons
	ldr r5, [r6], #4
	ldr r1, [r6], #4
_ln_mul_add:
	umull r2, r1, r1, r0
	add r3, r4, r5
	uxtb r3, r3
	lsr r1, r3
	ldr r2, [r6], #4
	add r1, r2
	lsrs r5, #8
	bne _ln_mul_add

_ln_add_mul:
	pop {r0, r2-r4}
	sub r2, #2
	umull r1, r0, r1, r0
	subs r4, #0x7f
	lsr r5, r4, #31
	itt mi
	mvnmi r4, r4
	addmi r4, #1

	clz r6, r4
	lsl r4, r6
	rsb r6, #32
	ittee ne
	lsrne r0, r6
	lsrne r0, r2
	moveq r5, r3
	subeq r6, r2

	eors r3, r5
	ite ne
	subne r0, r4, r0
	addeq r0, r4, r0

	ldr r1, _ln_cons + 20
	umull r1, r0, r1, r0
	clz r1, r0
	lsl r0, r1
	sub r6, r1
 	sub r6, #1
	asr r0, #6
	lsr r0, #2
	add r0, r0, r6, lsl #23
	orr r0, r0, r5, lsl #31
	pop {r4-r6}
	bx lr

.align(2)
_ln_cons:
	.word 0x00020001
	.word 0xe0cecb00
	.word 0x938ea900
	.word 0xf638ab00
	.word 0xb8aa3b00
	.word 0xb17217f8

_ln_exp_exit:
	bx lr

_ln_neg_inf_exit:
	mov r0, #0
	movt r0, #0xff80
	bx lr

_ln_nan_exit:
	mov r0, #0
	movt r0, #0x7fc0
	bx lr
