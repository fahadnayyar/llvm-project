; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -verify-machineinstrs --show-mc-encoding -mtriple=x86_64-unknown-unknown -mattr=+avx512fp16,avx512vl    | FileCheck %s --check-prefixes=CHECK

declare half @llvm.maxnum.f16(half, half)
declare <2 x half> @llvm.maxnum.v2f16(<2 x half>, <2 x half>)
declare <4 x half> @llvm.maxnum.v4f16(<4 x half>, <4 x half>)
declare <8 x half> @llvm.maxnum.v8f16(<8 x half>, <8 x half>)
declare <16 x half> @llvm.maxnum.v16f16(<16 x half>, <16 x half>)
declare <32 x half> @llvm.maxnum.v32f16(<32 x half>, <32 x half>)

define half @test_intrinsic_fmaxh(half %x, half %y) {
; CHECK-LABEL: test_intrinsic_fmaxh:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmaxsh %xmm0, %xmm1, %xmm2 # encoding: [0x62,0xf5,0x76,0x08,0x5f,0xd0]
; CHECK-NEXT:    vcmpunordsh %xmm0, %xmm0, %k1 # encoding: [0x62,0xf3,0x7e,0x08,0xc2,0xc8,0x03]
; CHECK-NEXT:    vmovsh %xmm1, %xmm0, %xmm2 {%k1} # encoding: [0x62,0xf5,0x7e,0x09,0x10,0xd1]
; CHECK-NEXT:    vmovaps %xmm2, %xmm0 # EVEX TO VEX Compression encoding: [0xc5,0xf8,0x28,0xc2]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %z = call half @llvm.maxnum.f16(half %x, half %y) readnone
  ret half %z
}

define <2 x half> @test_intrinsic_fmax_v2f16(<2 x half> %x, <2 x half> %y) {
; CHECK-LABEL: test_intrinsic_fmax_v2f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmaxph %xmm0, %xmm1, %xmm2 # encoding: [0x62,0xf5,0x74,0x08,0x5f,0xd0]
; CHECK-NEXT:    vcmpunordph %xmm0, %xmm0, %k1 # encoding: [0x62,0xf3,0x7c,0x08,0xc2,0xc8,0x03]
; CHECK-NEXT:    vmovdqu16 %xmm1, %xmm2 {%k1} # encoding: [0x62,0xf1,0xff,0x09,0x6f,0xd1]
; CHECK-NEXT:    vmovdqa %xmm2, %xmm0 # EVEX TO VEX Compression encoding: [0xc5,0xf9,0x6f,0xc2]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %z = call <2 x half> @llvm.maxnum.v2f16(<2 x half> %x, <2 x half> %y) readnone
  ret <2 x half> %z
}

define <4 x half> @test_intrinsic_fmax_v4f16(<4 x half> %x, <4 x half> %y) {
; CHECK-LABEL: test_intrinsic_fmax_v4f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmaxph %xmm0, %xmm1, %xmm2 # encoding: [0x62,0xf5,0x74,0x08,0x5f,0xd0]
; CHECK-NEXT:    vcmpunordph %xmm0, %xmm0, %k1 # encoding: [0x62,0xf3,0x7c,0x08,0xc2,0xc8,0x03]
; CHECK-NEXT:    vmovdqu16 %xmm1, %xmm2 {%k1} # encoding: [0x62,0xf1,0xff,0x09,0x6f,0xd1]
; CHECK-NEXT:    vmovdqa %xmm2, %xmm0 # EVEX TO VEX Compression encoding: [0xc5,0xf9,0x6f,0xc2]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %z = call <4 x half> @llvm.maxnum.v4f16(<4 x half> %x, <4 x half> %y) readnone
  ret <4 x half> %z
}

define <8 x half> @test_intrinsic_fmax_v8f16(<8 x half> %x, <8 x half> %y) {
; CHECK-LABEL: test_intrinsic_fmax_v8f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmaxph %xmm0, %xmm1, %xmm2 # encoding: [0x62,0xf5,0x74,0x08,0x5f,0xd0]
; CHECK-NEXT:    vcmpunordph %xmm0, %xmm0, %k1 # encoding: [0x62,0xf3,0x7c,0x08,0xc2,0xc8,0x03]
; CHECK-NEXT:    vmovdqu16 %xmm1, %xmm2 {%k1} # encoding: [0x62,0xf1,0xff,0x09,0x6f,0xd1]
; CHECK-NEXT:    vmovdqa %xmm2, %xmm0 # EVEX TO VEX Compression encoding: [0xc5,0xf9,0x6f,0xc2]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %z = call <8 x half> @llvm.maxnum.v8f16(<8 x half> %x, <8 x half> %y) readnone
  ret <8 x half> %z
}

define <16 x half> @test_intrinsic_fmax_v16f16(<16 x half> %x, <16 x half> %y) {
; CHECK-LABEL: test_intrinsic_fmax_v16f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmaxph %ymm0, %ymm1, %ymm2 # encoding: [0x62,0xf5,0x74,0x28,0x5f,0xd0]
; CHECK-NEXT:    vcmpunordph %ymm0, %ymm0, %k1 # encoding: [0x62,0xf3,0x7c,0x28,0xc2,0xc8,0x03]
; CHECK-NEXT:    vmovdqu16 %ymm1, %ymm2 {%k1} # encoding: [0x62,0xf1,0xff,0x29,0x6f,0xd1]
; CHECK-NEXT:    vmovdqa %ymm2, %ymm0 # EVEX TO VEX Compression encoding: [0xc5,0xfd,0x6f,0xc2]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %z = call <16 x half> @llvm.maxnum.v16f16(<16 x half> %x, <16 x half> %y) readnone
  ret <16 x half> %z
}

define <32 x half> @test_intrinsic_fmax_v32f16(<32 x half> %x, <32 x half> %y) {
; CHECK-LABEL: test_intrinsic_fmax_v32f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmaxph %zmm0, %zmm1, %zmm2 # encoding: [0x62,0xf5,0x74,0x48,0x5f,0xd0]
; CHECK-NEXT:    vcmpunordph %zmm0, %zmm0, %k1 # encoding: [0x62,0xf3,0x7c,0x48,0xc2,0xc8,0x03]
; CHECK-NEXT:    vmovdqu16 %zmm1, %zmm2 {%k1} # encoding: [0x62,0xf1,0xff,0x49,0x6f,0xd1]
; CHECK-NEXT:    vmovdqa64 %zmm2, %zmm0 # encoding: [0x62,0xf1,0xfd,0x48,0x6f,0xc2]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %z = call <32 x half> @llvm.maxnum.v32f16(<32 x half> %x, <32 x half> %y) readnone
  ret <32 x half> %z
}

define <4 x half> @maxnum_intrinsic_nnan_fmf_f432(<4 x half> %a, <4 x half> %b) {
; CHECK-LABEL: maxnum_intrinsic_nnan_fmf_f432:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmaxph %xmm1, %xmm0, %xmm0 # encoding: [0x62,0xf5,0x7c,0x08,0x5f,0xc1]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %r = tail call nnan <4 x half> @llvm.maxnum.v4f16(<4 x half> %a, <4 x half> %b)
  ret <4 x half> %r
}

define half @maxnum_intrinsic_nnan_attr_f16(half %a, half %b) #0 {
; CHECK-LABEL: maxnum_intrinsic_nnan_attr_f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmaxsh %xmm1, %xmm0, %xmm0 # encoding: [0x62,0xf5,0x7e,0x08,0x5f,0xc1]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %r = tail call half @llvm.maxnum.f16(half %a, half %b)
  ret half %r
}

define half @test_maxnum_const_op1(half %x) {
; CHECK-LABEL: test_maxnum_const_op1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmaxsh {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0 # encoding: [0x62,0xf5,0x7e,0x08,0x5f,0x05,A,A,A,A]
; CHECK-NEXT:    # fixup A - offset: 6, value: {{\.?LCPI[0-9]+_[0-9]+}}-4, kind: reloc_riprel_4byte
; CHECK-NEXT:    retq # encoding: [0xc3]
  %r = call half @llvm.maxnum.f16(half 1.0, half %x)
  ret half %r
}

define half @test_maxnum_const_op2(half %x) {
; CHECK-LABEL: test_maxnum_const_op2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmaxsh {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0 # encoding: [0x62,0xf5,0x7e,0x08,0x5f,0x05,A,A,A,A]
; CHECK-NEXT:    # fixup A - offset: 6, value: {{\.?LCPI[0-9]+_[0-9]+}}-4, kind: reloc_riprel_4byte
; CHECK-NEXT:    retq # encoding: [0xc3]
  %r = call half @llvm.maxnum.f16(half %x, half 1.0)
  ret half %r
}

define half @test_maxnum_const_nan(half %x) {
; CHECK-LABEL: test_maxnum_const_nan:
; CHECK:       # %bb.0:
; CHECK-NEXT:    retq # encoding: [0xc3]
  %r = call half @llvm.maxnum.f16(half %x, half 0x7fff000000000000)
  ret half %r
}

attributes #0 = { "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true"}
