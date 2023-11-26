// static _float Inf();
.global _ZN6_float3InfEv
_ZN6_float3InfEv:
// _float::Inf() { return std::numeric_limits<float>::infinity(); };
	mov r0, #0x7f800000
	bx lr

// static _float SNan();
.global _ZN6_float4SNanEv
_ZN6_float4SNanEv:
// _float::SNan() { return std::numeric_limits<float>::signaling_NaN(); };
	mov r0, #1
	movt r0, #0x7f80
	bx lr

// static _float QNan();
.global _ZN6_float4QNanEv
_ZN6_float4QNanEv:
// _float::QNan() { return std::numeric_limits<float>::quiet_NaN(); };
	mov r0, #0
	movt r0, #0x7fc0

// static _float Hex(uint32_t);
.global _ZN6_float3HexEm
_ZN6_float3HexEm:
// _float _float::Hex(uint32_t h) { return static_cast<float>(h); };
	bx lr
