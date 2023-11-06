.global _ZN6_float3InfEv
_ZN6_float3InfEv:
	mov r0, #0x7f800000
	bx lr

.global _ZN6_float4SNanEv
_ZN6_float4SNanEv:
	mov r0, #0x7f800000
	orr r0, #1
	bx lr

.global _ZN6_float4QNanEv
_ZN6_float4QNanEv:
	eor r0, r0
	movt r0, #0x7fc0

.global _ZN6_float3HexEm
_ZN6_float3HexEm:
	bx lr
