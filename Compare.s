//	friend bool operator== (_float, _float);
.global _Zeq6_floatS_
_Zeq6_floatS_:
	cmp r0, r1
	itt ne
	eorne r0, r0
	bxne lr

	lsl r2, r0, #1
	cmp r2, #0xff000000
	ite hi
	eorhi r0, r0
	movls r0, #1
	bx lr

//	friend bool operator!= (_float, _float);
.global _Zne6_floatS_
_Zne6_floatS_:
	mov r2, #0xff000000
	cmp r2, r1, lsl #1
	ittt lo
	cmplo r2, r1, lsl #1
	movlo r0, #1
	bxlo lr

	cmp r0, r1
	ite eq
	eoreq r0, r0
	movne r0, #1
	bx lr
