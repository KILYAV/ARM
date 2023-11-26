// _float(float);
.global _ZN6_floatC1Ef
_ZN6_floatC1Ef:
// _float::_float(float f) : number(f) {};
	str r1, [r0]
	bx lr

// operator float ();
.global _ZN6_floatcvfEv
_ZN6_floatcvfEv:
// _float::operator float() { return number; };
	ldr r0, [r0]
	bx lr
