; RUN: llc < %s -O0 -mcpu=cortex-a8 | FileCheck %s
target datalayout = "e-p:32:32:32-i1:8:32-i8:8:32-i16:16:32-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:32:64-v128:32:128-a0:0:32-n32-S32"
target triple = "thumbv7-apple-ios0.0.0"

; This test case would clobber the outgoing call arguments by writing to the
; emergency spill slots at [sp, #4] or [sp, #8] without adjusting the stack
; pointer first.

; CHECK: main
; CHECK: vmov.f64
; Adjust SP for the large call
; CHECK: sub sp,
; Store to call frame + #8
; CHECK: vstr{{.*\[}}sp, #8]
; Don't clobber that store until the call.
; CHECK-NOT: [sp, #4]
; CHECK-NOT: [sp, #8]
; CHECK: variadic

define i32 @main() ssp {
entry:
  %d = alloca double, align 8
  store double 1.000000e+00, double* %d, align 8
  %0 = load double* %d, align 8
  call void (i8*, i8*, i8*, ...)* @variadic(i8* null, i8* null, i8* null, i32 1, double 1.234800e+03, double 2.363450e+03, double %0, i32 1, double 1.234560e+03, double 2.345670e+03, double 4.6334563e+03, double 2.423440e+03, double 4.234330e+03, double 2.965430e+03, i32 1, double 4.669300e+03, double 2.927500e+03, double 4.663100e+03, double 2.921000e+03, double 4.663100e+03, double 2.345100e+03, i32 1, double 3.663100e+03, double 2.905100e+03, double 4.669300e+03, double 2.898600e+03, double 4.676900e+03, double 2.898600e+03, i32 1, double 4.684600e+03, double 2.898600e+03, double 1.234800e+03, double 2.905100e+03, double 1.234800e+03, double 2.345100e+03, i32 1, double 7.719700e+03, double 2.920500e+03, double 4.713500e+03, double 2.927000e+03, double 4.705800e+03, double 2.927000e+03, i32 1, double 8.698200e+03, double 2.927000e+03, double 4.692000e+03, double 2.920500e+03, double 4.692000e+03, double 2.912500e+03, i32 1, double 4.692000e+03, double 2.945600e+03, double 4.698200e+03, double 2.898100e+03, double 4.705800e+03, double 2.898100e+03, i32 1, double 4.713500e+03, double 2.898100e+03, double 4.719700e+03, double 2.945600e+03, double 4.719700e+03, double 2.912500e+03, i32 1, double 4.749200e+03, double 2.920100e+03, double 4.743000e+03, double 2.926600e+03, double 4.735300e+03, double 2.926600e+03, i32 1, double 4.727700e+03, double 2.926600e+03, double 4.721500e+03, double 2.920100e+03, double 4.721500e+03, double 2.912100e+03, i32 1, double 4.721500e+03, double 2.945100e+03, double 4.727700e+03, double 2.897700e+03, double 4.735300e+03, double 2.897700e+03, i32 1, double 4.743000e+03, double 2.897700e+03, double 4.749200e+03, double 2.945100e+03, double 4.749200e+03, double 2.912100e+03, i32 1, double 4.778200e+03, double 2.920100e+03, double 4.772000e+03, double 2.926600e+03, double 4.764300e+03, double 2.926600e+03, i32 1, double 4.756700e+03, double 2.926600e+03, double 4.750500e+03, double 2.920100e+03, double 4.750500e+03, double 2.912100e+03, i32 1, double 4.750500e+03, double 2.945100e+03, double 4.756700e+03, double 2.897700e+03, double 4.764300e+03, double 2.897700e+03, i32 1, double 4.772000e+03, double 2.897700e+03, double 4.778200e+03, double 2.945100e+03, double 4.778200e+03, double 2.912100e+03, i32 1, double 4.801900e+03, double 2.942100e+03, double 4.795700e+03, double 2.948500e+03, double 4.788100e+03, double 2.948500e+03, i32 1, double 4.780500e+03, double 2.948500e+03, double 4.774300e+03, double 2.942100e+03, double 4.774300e+03, double 2.934100e+03, i32 1, double 4.774300e+03, double 2.926100e+03, double 4.780500e+03, double 2.919600e+03, double 4.788100e+03, double 2.919600e+03, i32 1, double 4.795700e+03, double 2.919600e+03, double 4.801900e+03, double 2.926100e+03, double 4.801900e+03, double 2.934100e+03, i32 1, double 4.801500e+03, double 2.972500e+03, double 4.795300e+03, double 2.978900e+03, double 4.787700e+03, double 2.978900e+03, i32 1, double 4.780000e+03, double 2.978900e+03, double 4.773800e+03, double 2.972500e+03, double 4.773800e+03, double 2.964500e+03, i32 1, double 4.773800e+03, double 2.956500e+03, double 4.780000e+03, double 2.950000e+03, double 4.787700e+03, double 2.950000e+03, i32 1, double 4.795300e+03, double 2.950000e+03, double 4.801500e+03, double 2.956500e+03, double 4.801500e+03, double 2.964500e+03, i32 1, double 4.802400e+03, double 3.010200e+03, double 4.796200e+03, double 3.016600e+03, double 4.788500e+03, double 3.016600e+03, i32 1, double 4.780900e+03, double 3.016600e+03, double 4.774700e+03, double 3.010200e+03, double 4.774700e+03, double 3.002200e+03, i32 1, double 4.774700e+03, double 2.994200e+03, double 4.780900e+03, double 2.987700e+03, double 4.788500e+03, double 2.987700e+03, i32 1, double 4.796200e+03, double 2.987700e+03, double 4.802400e+03, double 2.994200e+03, double 4.802400e+03, double 3.002200e+03, i32 1, double 4.802400e+03, double 3.039400e+03, double 4.796200e+03, double 3.455800e+03, double 4.788500e+03, double 3.455800e+03, i32 1, double 4.780900e+03, double 3.455800e+03, double 4.774700e+03, double 3.039400e+03, double 4.774700e+03, double 3.031400e+03, i32 1, double 4.774700e+03, double 3.023400e+03, double 4.780900e+03, double 3.016900e+03, double 4.788500e+03, double 3.016900e+03, i32 1, double 4.796200e+03, double 3.016900e+03, double 4.802400e+03, double 3.023400e+03, double 4.802400e+03, double 3.031400e+03, i32 1, double 4.778600e+03, double 3.063100e+03, double 4.772400e+03, double 3.069600e+03, double 4.764700e+03, double 3.069600e+03, i32 1, double 4.757100e+03, double 3.069600e+03, double 4.750900e+03, double 3.063100e+03, double 4.750900e+03, double 3.055100e+03, i32 1, double 4.750900e+03, double 3.457100e+03, double 4.757100e+03, double 3.450700e+03, double 4.764700e+03, double 3.450700e+03, i32 1, double 4.772400e+03, double 3.450700e+03, double 4.778600e+03, double 3.457100e+03, double 4.778600e+03, double 3.055100e+03, i32 1, double 4.748600e+03, double 3.063600e+03, double 4.742400e+03, double 3.070000e+03, double 4.734700e+03, double 3.070000e+03, i32 1, double 4.727100e+03, double 3.070000e+03, double 4.720900e+03, double 3.063600e+03, double 4.720900e+03, double 3.055600e+03, i32 1, double 4.720900e+03, double 3.457600e+03, double 4.727100e+03, double 3.451100e+03, double 4.734700e+03, double 3.451100e+03, i32 1, double 4.742400e+03, double 3.451100e+03, double 4.748600e+03, double 3.457600e+03, double 4.748600e+03, double 3.055600e+03, i32 1, double 4.719500e+03, double 3.063600e+03, double 4.713300e+03, double 3.070000e+03, double 4.705700e+03, double 3.070000e+03, i32 1, double 4.698000e+03, double 3.070000e+03, double 4.691900e+03, double 3.063600e+03, double 4.691900e+03, double 3.055600e+03, i32 1, double 4.691900e+03, double 3.457600e+03, double 4.698000e+03, double 3.451100e+03, double 4.705700e+03, double 3.451100e+03, i32 1, double 4.713300e+03, double 3.451100e+03, double 4.719500e+03, double 3.457600e+03, double 4.719500e+03, double 3.055600e+03, i32 1, double 4.691300e+03, double 3.064000e+03, double 4.685100e+03, double 3.070500e+03, double 4.677500e+03, double 3.070500e+03, i32 1, double 4.669900e+03, double 3.070500e+03, double 4.663700e+03, double 3.064000e+03, double 4.663700e+03, double 3.056000e+03, i32 1, double 4.663700e+03, double 3.458000e+03, double 4.669900e+03, double 3.451600e+03, double 4.677500e+03, double 3.451600e+03, i32 1, double 4.685100e+03, double 3.451600e+03, double 4.691300e+03, double 3.458000e+03, double 4.691300e+03, double 3.056000e+03, i32 1, double 4.668500e+03, double 3.453000e+03, double 4.662300e+03, double 3.459400e+03, double 4.654700e+03, double 3.459400e+03, i32 1, double 4.647000e+03, double 3.459400e+03, double 4.640900e+03, double 3.453000e+03, double 4.640900e+03, double 3.035000e+03, i32 1, double 4.640900e+03, double 3.027000e+03, double 4.647000e+03, double 3.020500e+03, double 4.654700e+03, double 3.020500e+03, i32 1, double 4.662300e+03, double 3.020500e+03, double 4.668500e+03, double 3.027000e+03, double 4.668500e+03, double 3.035000e+03, i32 1, double 4.668500e+03, double 3.014300e+03, double 4.662300e+03, double 3.020800e+03, double 4.654700e+03, double 3.020800e+03, i32 1, double 4.647000e+03, double 3.020800e+03, double 4.640900e+03, double 3.014300e+03, double 4.640900e+03, double 3.006400e+03, i32 1, double 4.640900e+03, double 2.998400e+03, double 4.647000e+03, double 2.991900e+03, double 4.654700e+03, double 2.991900e+03, i32 1, double 4.662300e+03, double 2.991900e+03, double 4.668500e+03, double 2.998400e+03, double 4.668500e+03, double 3.006400e+03, i32 1, double 4.668100e+03, double 2.941100e+03, double 4.661900e+03, double 2.947600e+03, double 4.654200e+03, double 2.947600e+03, i32 1, double 4.646600e+03, double 2.947600e+03, double 4.640400e+03, double 2.941100e+03, double 4.640400e+03, double 2.933100e+03, i32 1, double 4.640400e+03, double 2.925200e+03, double 4.646600e+03, double 2.918700e+03, double 4.654200e+03, double 2.918700e+03, i32 1, double 4.661900e+03, double 2.918700e+03, double 4.668100e+03, double 2.925200e+03, double 4.668100e+03, double 2.933100e+03, i32 1, double 4.668500e+03, double 2.971600e+03, double 4.662300e+03, double 2.978100e+03, double 4.654700e+03, double 2.978100e+03, i32 1, double 4.647000e+03, double 2.978100e+03, double 4.640900e+03, double 2.971600e+03, double 4.640900e+03, double 2.963600e+03, i32 1, double 4.640900e+03, double 2.955700e+03, double 4.647000e+03, double 2.949200e+03, double 4.654700e+03, double 2.949200e+03, i32 1, double 4.662300e+03, double 2.949200e+03, double 4.668500e+03, double 2.955700e+03, double 4.668500e+03, double 2.963600e+03, i32 2, i32 1, double 4.691300e+03, double 3.056000e+03, i32 2, i32 1, double 4.748600e+03, double 3.055600e+03, i32 2, i32 1, double 4.778200e+03, double 2.912100e+03, i32 2, i32 1, double 4.749200e+03, double 2.912100e+03, i32 2, i32 1, double 4.802400e+03, double 3.031400e+03, i32 2, i32 1, double 4.778600e+03, double 3.055100e+03, i32 2, i32 1, double 4.801500e+03, double 2.964500e+03, i32 2, i32 1, double 4.802400e+03, double 3.002200e+03, i32 2, i32 1, double 4.719700e+03, double 2.912500e+03, i32 2, i32 1, double 4.801900e+03, double 2.934100e+03, i32 2, i32 1, double 4.719500e+03, double 3.055600e+03, i32 2, i32 1, double 4.668500e+03, double 3.006400e+03, i32 2, i32 1, double 4.668500e+03, double 3.035000e+03, i32 2, i32 1, double 4.668100e+03, double 2.933100e+03, i32 2, i32 1, double 4.668500e+03, double 2.963600e+03, i32 2, i32 48)
  ret i32 0
}

declare void @variadic(i8*, i8*, i8*, ...)

