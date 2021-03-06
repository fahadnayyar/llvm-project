; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instsimplify -S | FileCheck %s

declare i81 @llvm.smax.i81(i81, i81)
declare i8 @llvm.smax.i8(i8, i8)
declare <2 x i8> @llvm.smax.v2i8(<2 x i8>, <2 x i8>)
declare i3 @llvm.smin.i3(i3, i3)
declare i8 @llvm.smin.i8(i8, i8)
declare <2 x i8> @llvm.smin.v2i8(<2 x i8>, <2 x i8>)
declare i8 @llvm.umax.i8(i8, i8)
declare <2 x i8> @llvm.umax.v2i8(<2 x i8>, <2 x i8>)
declare i8 @llvm.umin.i8(i8, i8)
declare <2 x i8> @llvm.umin.v2i8(<2 x i8>, <2 x i8>)

define i81 @smax_sameval(i81 %x) {
; CHECK-LABEL: @smax_sameval(
; CHECK-NEXT:    [[R:%.*]] = call i81 @llvm.smax.i81(i81 [[X:%.*]], i81 [[X]])
; CHECK-NEXT:    ret i81 [[R]]
;
  %r = call i81 @llvm.smax.i81(i81 %x, i81 %x)
  ret i81 %r
}

define i3 @smin_sameval(i3 %x) {
; CHECK-LABEL: @smin_sameval(
; CHECK-NEXT:    [[R:%.*]] = call i3 @llvm.smin.i3(i3 [[X:%.*]], i3 [[X]])
; CHECK-NEXT:    ret i3 [[R]]
;
  %r = call i3 @llvm.smin.i3(i3 %x, i3 %x)
  ret i3 %r
}

define <2 x i8> @umax_sameval(<2 x i8> %x) {
; CHECK-LABEL: @umax_sameval(
; CHECK-NEXT:    [[R:%.*]] = call <2 x i8> @llvm.umax.v2i8(<2 x i8> [[X:%.*]], <2 x i8> [[X]])
; CHECK-NEXT:    ret <2 x i8> [[R]]
;
  %r = call <2 x i8> @llvm.umax.v2i8(<2 x i8> %x, <2 x i8> %x)
  ret <2 x i8> %r
}

define <2 x i8> @umin_sameval(<2 x i8> %x) {
; CHECK-LABEL: @umin_sameval(
; CHECK-NEXT:    [[R:%.*]] = call <2 x i8> @llvm.umin.v2i8(<2 x i8> [[X:%.*]], <2 x i8> [[X]])
; CHECK-NEXT:    ret <2 x i8> [[R]]
;
  %r = call <2 x i8> @llvm.umin.v2i8(<2 x i8> %x, <2 x i8> %x)
  ret <2 x i8> %r
}

define i81 @smax_undef(i81 %x) {
; CHECK-LABEL: @smax_undef(
; CHECK-NEXT:    [[R:%.*]] = call i81 @llvm.smax.i81(i81 undef, i81 [[X:%.*]])
; CHECK-NEXT:    ret i81 [[R]]
;
  %r = call i81 @llvm.smax.i81(i81 undef, i81 %x)
  ret i81 %r
}

define i3 @smin_undef(i3 %x) {
; CHECK-LABEL: @smin_undef(
; CHECK-NEXT:    [[R:%.*]] = call i3 @llvm.smin.i3(i3 [[X:%.*]], i3 undef)
; CHECK-NEXT:    ret i3 [[R]]
;
  %r = call i3 @llvm.smin.i3(i3 %x, i3 undef)
  ret i3 %r
}

define <2 x i8> @umax_undef(<2 x i8> %x) {
; CHECK-LABEL: @umax_undef(
; CHECK-NEXT:    [[R:%.*]] = call <2 x i8> @llvm.umax.v2i8(<2 x i8> undef, <2 x i8> [[X:%.*]])
; CHECK-NEXT:    ret <2 x i8> [[R]]
;
  %r = call <2 x i8> @llvm.umax.v2i8(<2 x i8> undef, <2 x i8> %x)
  ret <2 x i8> %r
}

define <2 x i8> @umin_undef(<2 x i8> %x) {
; CHECK-LABEL: @umin_undef(
; CHECK-NEXT:    [[R:%.*]] = call <2 x i8> @llvm.umin.v2i8(<2 x i8> [[X:%.*]], <2 x i8> undef)
; CHECK-NEXT:    ret <2 x i8> [[R]]
;
  %r = call <2 x i8> @llvm.umin.v2i8(<2 x i8> %x, <2 x i8> undef)
  ret <2 x i8> %r
}

define i8 @smax_maxval(i8 %x) {
; CHECK-LABEL: @smax_maxval(
; CHECK-NEXT:    ret i8 127
;
  %r = call i8 @llvm.smax.i8(i8 %x, i8 127)
  ret i8 %r
}

define <2 x i8> @smax_maxval_commute(<2 x i8> %x) {
; CHECK-LABEL: @smax_maxval_commute(
; CHECK-NEXT:    ret <2 x i8> <i8 127, i8 127>
;
  %r = call <2 x i8> @llvm.smax.v2i8(<2 x i8> <i8 127, i8 127>, <2 x i8> %x)
  ret <2 x i8> %r
}

define i8 @smin_minval(i8 %x) {
; CHECK-LABEL: @smin_minval(
; CHECK-NEXT:    ret i8 -128
;
  %r = call i8 @llvm.smin.i8(i8 -128, i8 %x)
  ret i8 %r
}

define <2 x i8> @smin_minval_commute(<2 x i8> %x) {
; CHECK-LABEL: @smin_minval_commute(
; CHECK-NEXT:    ret <2 x i8> <i8 -128, i8 -128>
;
  %r = call <2 x i8> @llvm.smin.v2i8(<2 x i8> %x, <2 x i8> <i8 -128, i8 -128>)
  ret <2 x i8> %r
}

define i8 @umax_maxval(i8 %x) {
; CHECK-LABEL: @umax_maxval(
; CHECK-NEXT:    ret i8 -1
;
  %r = call i8 @llvm.umax.i8(i8 %x, i8 255)
  ret i8 %r
}

define <2 x i8> @umax_maxval_commute(<2 x i8> %x) {
; CHECK-LABEL: @umax_maxval_commute(
; CHECK-NEXT:    ret <2 x i8> <i8 -1, i8 -1>
;
  %r = call <2 x i8> @llvm.umax.v2i8(<2 x i8> <i8 255, i8 255>, <2 x i8> %x)
  ret <2 x i8> %r
}

define i8 @umin_minval(i8 %x) {
; CHECK-LABEL: @umin_minval(
; CHECK-NEXT:    ret i8 0
;
  %r = call i8 @llvm.umin.i8(i8 0, i8 %x)
  ret i8 %r
}

define <2 x i8> @umin_minval_commute(<2 x i8> %x) {
; CHECK-LABEL: @umin_minval_commute(
; CHECK-NEXT:    ret <2 x i8> zeroinitializer
;
  %r = call <2 x i8> @llvm.umin.v2i8(<2 x i8> %x, <2 x i8> zeroinitializer)
  ret <2 x i8> %r
}

define i8 @smax_minval(i8 %x) {
; CHECK-LABEL: @smax_minval(
; CHECK-NEXT:    [[R:%.*]] = call i8 @llvm.smax.i8(i8 [[X:%.*]], i8 -128)
; CHECK-NEXT:    ret i8 [[R]]
;
  %r = call i8 @llvm.smax.i8(i8 %x, i8 -128)
  ret i8 %r
}

define <2 x i8> @smax_minval_commute(<2 x i8> %x) {
; CHECK-LABEL: @smax_minval_commute(
; CHECK-NEXT:    [[R:%.*]] = call <2 x i8> @llvm.smax.v2i8(<2 x i8> <i8 -128, i8 -128>, <2 x i8> [[X:%.*]])
; CHECK-NEXT:    ret <2 x i8> [[R]]
;
  %r = call <2 x i8> @llvm.smax.v2i8(<2 x i8> <i8 -128, i8 -128>, <2 x i8> %x)
  ret <2 x i8> %r
}

define i8 @smin_maxval(i8 %x) {
; CHECK-LABEL: @smin_maxval(
; CHECK-NEXT:    [[R:%.*]] = call i8 @llvm.smin.i8(i8 127, i8 [[X:%.*]])
; CHECK-NEXT:    ret i8 [[R]]
;
  %r = call i8 @llvm.smin.i8(i8 127, i8 %x)
  ret i8 %r
}

define <2 x i8> @smin_maxval_commute(<2 x i8> %x) {
; CHECK-LABEL: @smin_maxval_commute(
; CHECK-NEXT:    [[R:%.*]] = call <2 x i8> @llvm.smin.v2i8(<2 x i8> [[X:%.*]], <2 x i8> <i8 127, i8 127>)
; CHECK-NEXT:    ret <2 x i8> [[R]]
;
  %r = call <2 x i8> @llvm.smin.v2i8(<2 x i8> %x, <2 x i8> <i8 127, i8 127>)
  ret <2 x i8> %r
}

define i8 @umax_minval(i8 %x) {
; CHECK-LABEL: @umax_minval(
; CHECK-NEXT:    [[R:%.*]] = call i8 @llvm.umax.i8(i8 [[X:%.*]], i8 0)
; CHECK-NEXT:    ret i8 [[R]]
;
  %r = call i8 @llvm.umax.i8(i8 %x, i8 0)
  ret i8 %r
}

define <2 x i8> @umax_minval_commute(<2 x i8> %x) {
; CHECK-LABEL: @umax_minval_commute(
; CHECK-NEXT:    [[R:%.*]] = call <2 x i8> @llvm.umax.v2i8(<2 x i8> zeroinitializer, <2 x i8> [[X:%.*]])
; CHECK-NEXT:    ret <2 x i8> [[R]]
;
  %r = call <2 x i8> @llvm.umax.v2i8(<2 x i8> zeroinitializer, <2 x i8> %x)
  ret <2 x i8> %r
}

define i8 @umin_maxval(i8 %x) {
; CHECK-LABEL: @umin_maxval(
; CHECK-NEXT:    [[R:%.*]] = call i8 @llvm.umin.i8(i8 -1, i8 [[X:%.*]])
; CHECK-NEXT:    ret i8 [[R]]
;
  %r = call i8 @llvm.umin.i8(i8 255, i8 %x)
  ret i8 %r
}

define <2 x i8> @umin_maxval_commute(<2 x i8> %x) {
; CHECK-LABEL: @umin_maxval_commute(
; CHECK-NEXT:    [[R:%.*]] = call <2 x i8> @llvm.umin.v2i8(<2 x i8> [[X:%.*]], <2 x i8> <i8 -1, i8 -1>)
; CHECK-NEXT:    ret <2 x i8> [[R]]
;
  %r = call <2 x i8> @llvm.umin.v2i8(<2 x i8> %x, <2 x i8> <i8 255, i8 255>)
  ret <2 x i8> %r
}

define <2 x i8> @smax_maxval_partial_undef(<2 x i8> %x) {
; CHECK-LABEL: @smax_maxval_partial_undef(
; CHECK-NEXT:    [[R:%.*]] = call <2 x i8> @llvm.smax.v2i8(<2 x i8> <i8 undef, i8 127>, <2 x i8> [[X:%.*]])
; CHECK-NEXT:    ret <2 x i8> [[R]]
;
  %r = call <2 x i8> @llvm.smax.v2i8(<2 x i8> <i8 undef, i8 127>, <2 x i8> %x)
  ret <2 x i8> %r
}

define <2 x i8> @smin_minval_partial_undef(<2 x i8> %x) {
; CHECK-LABEL: @smin_minval_partial_undef(
; CHECK-NEXT:    [[R:%.*]] = call <2 x i8> @llvm.smin.v2i8(<2 x i8> [[X:%.*]], <2 x i8> <i8 -128, i8 undef>)
; CHECK-NEXT:    ret <2 x i8> [[R]]
;
  %r = call <2 x i8> @llvm.smin.v2i8(<2 x i8> %x, <2 x i8> <i8 -128, i8 undef>)
  ret <2 x i8> %r
}

define <2 x i8> @umax_maxval_partial_undef(<2 x i8> %x) {
; CHECK-LABEL: @umax_maxval_partial_undef(
; CHECK-NEXT:    [[R:%.*]] = call <2 x i8> @llvm.umax.v2i8(<2 x i8> <i8 -1, i8 undef>, <2 x i8> [[X:%.*]])
; CHECK-NEXT:    ret <2 x i8> [[R]]
;
  %r = call <2 x i8> @llvm.umax.v2i8(<2 x i8> <i8 255, i8 undef>, <2 x i8> %x)
  ret <2 x i8> %r
}

define <2 x i8> @umin_minval_partial_undef(<2 x i8> %x) {
; CHECK-LABEL: @umin_minval_partial_undef(
; CHECK-NEXT:    [[R:%.*]] = call <2 x i8> @llvm.umin.v2i8(<2 x i8> [[X:%.*]], <2 x i8> <i8 undef, i8 0>)
; CHECK-NEXT:    ret <2 x i8> [[R]]
;
  %r = call <2 x i8> @llvm.umin.v2i8(<2 x i8> %x, <2 x i8> <i8 undef, i8 0>)
  ret <2 x i8> %r
}

define <2 x i8> @smax_minval_partial_undef(<2 x i8> %x) {
; CHECK-LABEL: @smax_minval_partial_undef(
; CHECK-NEXT:    [[R:%.*]] = call <2 x i8> @llvm.smax.v2i8(<2 x i8> <i8 undef, i8 -128>, <2 x i8> [[X:%.*]])
; CHECK-NEXT:    ret <2 x i8> [[R]]
;
  %r = call <2 x i8> @llvm.smax.v2i8(<2 x i8> <i8 undef, i8 -128>, <2 x i8> %x)
  ret <2 x i8> %r
}

define <2 x i8> @smin_maxval_partial_undef(<2 x i8> %x) {
; CHECK-LABEL: @smin_maxval_partial_undef(
; CHECK-NEXT:    [[R:%.*]] = call <2 x i8> @llvm.smin.v2i8(<2 x i8> [[X:%.*]], <2 x i8> <i8 undef, i8 127>)
; CHECK-NEXT:    ret <2 x i8> [[R]]
;
  %r = call <2 x i8> @llvm.smin.v2i8(<2 x i8> %x, <2 x i8> <i8 undef, i8 127>)
  ret <2 x i8> %r
}

define <2 x i8> @umax_minval_partial_undef(<2 x i8> %x) {
; CHECK-LABEL: @umax_minval_partial_undef(
; CHECK-NEXT:    [[R:%.*]] = call <2 x i8> @llvm.umax.v2i8(<2 x i8> <i8 0, i8 undef>, <2 x i8> [[X:%.*]])
; CHECK-NEXT:    ret <2 x i8> [[R]]
;
  %r = call <2 x i8> @llvm.umax.v2i8(<2 x i8> <i8 0, i8 undef>, <2 x i8> %x)
  ret <2 x i8> %r
}

define <2 x i8> @umin_maxval_partial_undef(<2 x i8> %x) {
; CHECK-LABEL: @umin_maxval_partial_undef(
; CHECK-NEXT:    [[R:%.*]] = call <2 x i8> @llvm.umin.v2i8(<2 x i8> [[X:%.*]], <2 x i8> <i8 -1, i8 undef>)
; CHECK-NEXT:    ret <2 x i8> [[R]]
;
  %r = call <2 x i8> @llvm.umin.v2i8(<2 x i8> %x, <2 x i8> <i8 255, i8 undef>)
  ret <2 x i8> %r
}
