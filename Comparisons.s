// friend bool operator<= (_float, _float);
.global _Zle6_floatS_
_Zle6_floatS_:
	mov r2, r1
	mov r1, r0
	mov r0, r2
	
// friend bool operator>= (_float, _float);
.global _Zge6_floatS_
_Zge6_floatS_:
	cmp r0, r1
	bne _Zgt6_floatS_
	mov r2, #0xff000000
	add r2, #1
	rsb r0, r2, r0, lsl #1
	lsl r0, #31
	bx lr

// friend bool operator< (_float, _float);
.global _Zlt6_floatS_
_Zlt6_floatS_:
	mov r2, r1
	mov r1, r0
	mov r0, r2

// friend bool operator> (_float, _float);
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
