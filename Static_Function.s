// static _float Inf();
.global _ZN6_float3InfEv
_ZN6_float3InfEv:
	mov r0, #0x7f800000
	bx lr

// static _float SNan();
.global _ZN6_float4SNanEv
_ZN6_float4SNanEv:
	mov r0, #1
	movt r0, #0x7f80
	bx lr

// static _float QNan();
.global _ZN6_float4QNanEv
_ZN6_float4QNanEv:
	mov r0, #0
	movt r0, #0x7fc0

// static _float Hex(uint32_t);
.global _ZN6_float3HexEm
_ZN6_float3HexEm:
	bx lr
