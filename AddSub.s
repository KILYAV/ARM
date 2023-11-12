// friend _float operator- (_float, _float);
.global _Zmi6_floatS_
_Zmi6_floatS_:
	eor r1, #0x80000000

// friend _float operator+ (_float, _float);
.global _Zpl6_floatS_
_Zpl6_floatS_:
// compare && swap ( min & max )
	ror r0, #31
	ror r2, r1, #31
	cmp r0, r2
	mov r1, r2
	itt lo
	movlo r1, r0
	movlo r0, r2

// test ( nan || inf )
	bic r2, r0, #1
	cmp r2, #0xff000000
	bhi _addf32_nan_exit
	beq _addf32_inf

// test zero
	cmp r1, #2
	blo _addf32_zero_exit

// sigma second number
	lsl r2, r0, #31
	eor r1, r1, r2, ror #31

// denorm/denorm
	tst r0, #0xff000000
	beq _addf32_denorm

// offset
	lsr r2, r0, #24
	tst r1, #0xff000000
	iteee eq
	subeq r2, #1
	subne r2, r2, r1, lsr #24
	bicne r1, #0xff000000
	orrne r1, #0x01000000
	cmp r2, #25
	bhs _addf32_zero_exit

// switch sub/add
	rors r1, #1
	lsl r1, #1
	lsr r1, r2
	lsl r2, r0, #31
	bic r0, #1
	bmi _addf32sub

// add
	add r0, r1
	add r0, #1
	cmp r0, #0xff000000
	lsr r0, #1
	itt hi
	lsrhi r0, #23
	lslhi r0, #23
	orr r0, r2
	bx lr

_addf32sub:
// sub
	orr r2, r2, r0, lsr #24
	bic r0, #0xff000000
	orr r0, #0x01000000
	subs r0, r1
	it eq
	bxeq lr

// normal
	clz r1, r0
	sub r1, #7
	cmp r1, r2
	itt vs
	orrvs r1, #0x80000000
	cmpvs r1, r2
	itte hs
	subhs r1, r2, #1
	andhs r2, #0x80000000
	sublo r2, r1

	lsl r0, r1
	bic r0, #0x01000000
	orr r0, r0, r2, lsl #24
	bic r0, #1
	orr r0, r0, r2, lsr #31
	ror r0, #1
	bx lr

_addf32_denorm:
	rors r1, #1
	lsl r1, #1
	ite pl
	addpl r0, r1
	submi r0, r1
	ror r0, #1
	bx lr

_addf32_inf:
	ror r2, r0, #1
	cmp r1, #0xff000000
	itte eq
	orreq r1, #1
	cmpeq r0, r1
	bxne lr
	movt r0, #0xff80
_addf32_inf_exit:
_addf32_nan_exit:
_addf32_zero_exit:
	ror r0, #1
	bx lr
