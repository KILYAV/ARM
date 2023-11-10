//	friend bool operator== (_float, _float);
.global _Zeq6_floatS_
_Zeq6_floatS_:
	cmp r0, r1
	itt ne
	eorne r0, r0
	bxne lr

	mov r2, #0xff000000
	cmp r2, r0, lsl #1
	itte lo
	cmplo r2, r1, lsl #1
	movlo r0, #0
	movhs r0, #1
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

//	friend bool operator>= (_float, _float);
.global _Zge6_floatS_
_Zge6_floatS_:
	mov r2, r1
	mov r1, r0
	mov r0, r2

//	friend bool operator<= (_float, _float);
.global _Zle6_floatS_
_Zle6_floatS_:
	cmp r0, r1
	bne _Zlt6_floatS_
	bic r0, #0x80000000
	cmp r0, #0x7f800000
	eor r0, r0
	it ls
	orrls r0, #1
	bx lr

//	friend bool operator< (_float, _float);
.global _Zlt6_floatS_
_Zlt6_floatS_:
	mov r2, r1
	mov r1, r0
	mov r0, r2

//	friend bool operator> (_float, _float);
.global _Zgt6_floatS_
_Zgt6_floatS_:
	mov r2, #0xff000000
	cmp r2, r0, lsl #1
	itee hs
	cmphs r2, r1, lsl #1
	movlo r0, #0
	bxlo lr

	teq r0, r1
	itt mi
	lsrmi r0, r1, #31
	bxmi lr

	tst r0, r1
	ite pl
	subpl r0, r1, r0
	submi r0, r1
	lsr r0, #31
	bx lr
