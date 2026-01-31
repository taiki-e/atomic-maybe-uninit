asm_test::compare_exchange::u8::acqrel_seqcst:
        mov               x8, x0
0:
        ldaxrb            w0, [x8]
        cmp               w0, w1, uxtb
        b.ne              1f
        stlxrb            w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u8::seqcst_seqcst:
        mov               x8, x0
0:
        ldaxrb            w0, [x8]
        cmp               w0, w1, uxtb
        b.ne              1f
        stlxrb            w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u8::acqrel_acquire:
        mov               x8, x0
0:
        ldaxrb            w0, [x8]
        cmp               w0, w1, uxtb
        b.ne              1f
        stlxrb            w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u8::acqrel_relaxed:
        mov               x8, x0
0:
        ldaxrb            w0, [x8]
        cmp               w0, w1, uxtb
        b.ne              1f
        stlxrb            w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u8::acquire_seqcst:
        mov               x8, x0
0:
        ldaxrb            w0, [x8]
        cmp               w0, w1, uxtb
        b.ne              1f
        stlxrb            w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u8::relaxed_seqcst:
        mov               x8, x0
0:
        ldaxrb            w0, [x8]
        cmp               w0, w1, uxtb
        b.ne              1f
        stlxrb            w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u8::release_seqcst:
        mov               x8, x0
0:
        ldaxrb            w0, [x8]
        cmp               w0, w1, uxtb
        b.ne              1f
        stlxrb            w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u8::seqcst_acquire:
        mov               x8, x0
0:
        ldaxrb            w0, [x8]
        cmp               w0, w1, uxtb
        b.ne              1f
        stlxrb            w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u8::seqcst_relaxed:
        mov               x8, x0
0:
        ldaxrb            w0, [x8]
        cmp               w0, w1, uxtb
        b.ne              1f
        stlxrb            w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u8::acquire_acquire:
        mov               x8, x0
0:
        ldaxrb            w0, [x8]
        cmp               w0, w1, uxtb
        b.ne              1f
        stxrb             w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u8::acquire_relaxed:
        mov               x8, x0
0:
        ldaxrb            w0, [x8]
        cmp               w0, w1, uxtb
        b.ne              1f
        stxrb             w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u8::relaxed_acquire:
        mov               x8, x0
0:
        ldaxrb            w0, [x8]
        cmp               w0, w1, uxtb
        b.ne              1f
        stxrb             w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u8::relaxed_relaxed:
        mov               x8, x0
0:
        ldxrb             w0, [x8]
        cmp               w0, w1, uxtb
        b.ne              1f
        stxrb             w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u8::release_acquire:
        mov               x8, x0
0:
        ldaxrb            w0, [x8]
        cmp               w0, w1, uxtb
        b.ne              1f
        stlxrb            w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u8::release_relaxed:
        mov               x8, x0
0:
        ldxrb             w0, [x8]
        cmp               w0, w1, uxtb
        b.ne              1f
        stlxrb            w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u16::acqrel_seqcst:
        mov               x8, x0
0:
        ldaxrh            w0, [x8]
        cmp               w0, w1, uxth
        b.ne              1f
        stlxrh            w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u16::seqcst_seqcst:
        mov               x8, x0
0:
        ldaxrh            w0, [x8]
        cmp               w0, w1, uxth
        b.ne              1f
        stlxrh            w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u16::acqrel_acquire:
        mov               x8, x0
0:
        ldaxrh            w0, [x8]
        cmp               w0, w1, uxth
        b.ne              1f
        stlxrh            w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u16::acqrel_relaxed:
        mov               x8, x0
0:
        ldaxrh            w0, [x8]
        cmp               w0, w1, uxth
        b.ne              1f
        stlxrh            w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u16::acquire_seqcst:
        mov               x8, x0
0:
        ldaxrh            w0, [x8]
        cmp               w0, w1, uxth
        b.ne              1f
        stlxrh            w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u16::relaxed_seqcst:
        mov               x8, x0
0:
        ldaxrh            w0, [x8]
        cmp               w0, w1, uxth
        b.ne              1f
        stlxrh            w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u16::release_seqcst:
        mov               x8, x0
0:
        ldaxrh            w0, [x8]
        cmp               w0, w1, uxth
        b.ne              1f
        stlxrh            w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u16::seqcst_acquire:
        mov               x8, x0
0:
        ldaxrh            w0, [x8]
        cmp               w0, w1, uxth
        b.ne              1f
        stlxrh            w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u16::seqcst_relaxed:
        mov               x8, x0
0:
        ldaxrh            w0, [x8]
        cmp               w0, w1, uxth
        b.ne              1f
        stlxrh            w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u16::acquire_acquire:
        mov               x8, x0
0:
        ldaxrh            w0, [x8]
        cmp               w0, w1, uxth
        b.ne              1f
        stxrh             w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u16::acquire_relaxed:
        mov               x8, x0
0:
        ldaxrh            w0, [x8]
        cmp               w0, w1, uxth
        b.ne              1f
        stxrh             w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u16::relaxed_acquire:
        mov               x8, x0
0:
        ldaxrh            w0, [x8]
        cmp               w0, w1, uxth
        b.ne              1f
        stxrh             w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u16::relaxed_relaxed:
        mov               x8, x0
0:
        ldxrh             w0, [x8]
        cmp               w0, w1, uxth
        b.ne              1f
        stxrh             w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u16::release_acquire:
        mov               x8, x0
0:
        ldaxrh            w0, [x8]
        cmp               w0, w1, uxth
        b.ne              1f
        stlxrh            w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u16::release_relaxed:
        mov               x8, x0
0:
        ldxrh             w0, [x8]
        cmp               w0, w1, uxth
        b.ne              1f
        stlxrh            w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u32::acqrel_seqcst:
        mov               x8, x0
0:
        ldaxr             w0, [x8]
        cmp               w0, w1
        b.ne              1f
        stlxr             w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u32::seqcst_seqcst:
        mov               x8, x0
0:
        ldaxr             w0, [x8]
        cmp               w0, w1
        b.ne              1f
        stlxr             w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u32::acqrel_acquire:
        mov               x8, x0
0:
        ldaxr             w0, [x8]
        cmp               w0, w1
        b.ne              1f
        stlxr             w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u32::acqrel_relaxed:
        mov               x8, x0
0:
        ldaxr             w0, [x8]
        cmp               w0, w1
        b.ne              1f
        stlxr             w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u32::acquire_seqcst:
        mov               x8, x0
0:
        ldaxr             w0, [x8]
        cmp               w0, w1
        b.ne              1f
        stlxr             w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u32::relaxed_seqcst:
        mov               x8, x0
0:
        ldaxr             w0, [x8]
        cmp               w0, w1
        b.ne              1f
        stlxr             w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u32::release_seqcst:
        mov               x8, x0
0:
        ldaxr             w0, [x8]
        cmp               w0, w1
        b.ne              1f
        stlxr             w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u32::seqcst_acquire:
        mov               x8, x0
0:
        ldaxr             w0, [x8]
        cmp               w0, w1
        b.ne              1f
        stlxr             w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u32::seqcst_relaxed:
        mov               x8, x0
0:
        ldaxr             w0, [x8]
        cmp               w0, w1
        b.ne              1f
        stlxr             w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u32::acquire_acquire:
        mov               x8, x0
0:
        ldaxr             w0, [x8]
        cmp               w0, w1
        b.ne              1f
        stxr              w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u32::acquire_relaxed:
        mov               x8, x0
0:
        ldaxr             w0, [x8]
        cmp               w0, w1
        b.ne              1f
        stxr              w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u32::relaxed_acquire:
        mov               x8, x0
0:
        ldaxr             w0, [x8]
        cmp               w0, w1
        b.ne              1f
        stxr              w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u32::relaxed_relaxed:
        mov               x8, x0
0:
        ldxr              w0, [x8]
        cmp               w0, w1
        b.ne              1f
        stxr              w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u32::release_acquire:
        mov               x8, x0
0:
        ldaxr             w0, [x8]
        cmp               w0, w1
        b.ne              1f
        stlxr             w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u32::release_relaxed:
        mov               x8, x0
0:
        ldxr              w0, [x8]
        cmp               w0, w1
        b.ne              1f
        stlxr             w9, w2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u64::acqrel_seqcst:
        mov               x8, x0
0:
        ldaxr             x0, [x8]
        cmp               x0, x1
        b.ne              1f
        stlxr             w9, x2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u64::seqcst_seqcst:
        mov               x8, x0
0:
        ldaxr             x0, [x8]
        cmp               x0, x1
        b.ne              1f
        stlxr             w9, x2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u64::acqrel_acquire:
        mov               x8, x0
0:
        ldaxr             x0, [x8]
        cmp               x0, x1
        b.ne              1f
        stlxr             w9, x2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u64::acqrel_relaxed:
        mov               x8, x0
0:
        ldaxr             x0, [x8]
        cmp               x0, x1
        b.ne              1f
        stlxr             w9, x2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u64::acquire_seqcst:
        mov               x8, x0
0:
        ldaxr             x0, [x8]
        cmp               x0, x1
        b.ne              1f
        stlxr             w9, x2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u64::relaxed_seqcst:
        mov               x8, x0
0:
        ldaxr             x0, [x8]
        cmp               x0, x1
        b.ne              1f
        stlxr             w9, x2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u64::release_seqcst:
        mov               x8, x0
0:
        ldaxr             x0, [x8]
        cmp               x0, x1
        b.ne              1f
        stlxr             w9, x2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u64::seqcst_acquire:
        mov               x8, x0
0:
        ldaxr             x0, [x8]
        cmp               x0, x1
        b.ne              1f
        stlxr             w9, x2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u64::seqcst_relaxed:
        mov               x8, x0
0:
        ldaxr             x0, [x8]
        cmp               x0, x1
        b.ne              1f
        stlxr             w9, x2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u64::acquire_acquire:
        mov               x8, x0
0:
        ldaxr             x0, [x8]
        cmp               x0, x1
        b.ne              1f
        stxr              w9, x2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u64::acquire_relaxed:
        mov               x8, x0
0:
        ldaxr             x0, [x8]
        cmp               x0, x1
        b.ne              1f
        stxr              w9, x2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u64::relaxed_acquire:
        mov               x8, x0
0:
        ldaxr             x0, [x8]
        cmp               x0, x1
        b.ne              1f
        stxr              w9, x2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u64::relaxed_relaxed:
        mov               x8, x0
0:
        ldxr              x0, [x8]
        cmp               x0, x1
        b.ne              1f
        stxr              w9, x2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u64::release_acquire:
        mov               x8, x0
0:
        ldaxr             x0, [x8]
        cmp               x0, x1
        b.ne              1f
        stlxr             w9, x2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u64::release_relaxed:
        mov               x8, x0
0:
        ldxr              x0, [x8]
        cmp               x0, x1
        b.ne              1f
        stlxr             w9, x2, [x8]
        cbnz              w9, 0b
        mov               w1, #0x1                // =1
        ret
1:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange::u128::acqrel_seqcst:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x3
        cset              w11, ne
        cmp               x10, x2
        cinc              w11, w11, ne
        cbz               w11, 1f
        stlxp             w11, x9, x10, [x0]
        cbnz              w11, 0b
        b                 2f
1:
        stlxp             w11, x5, x4, [x0]
        cbnz              w11, 0b
2:
        cmp               x9, x3
        stp               x10, x9, [x8]
        ccmp              x10, x2, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange::u128::seqcst_seqcst:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x3
        cset              w11, ne
        cmp               x10, x2
        cinc              w11, w11, ne
        cbz               w11, 1f
        stlxp             w11, x9, x10, [x0]
        cbnz              w11, 0b
        b                 2f
1:
        stlxp             w11, x5, x4, [x0]
        cbnz              w11, 0b
2:
        cmp               x9, x3
        stp               x10, x9, [x8]
        ccmp              x10, x2, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange::u128::acqrel_acquire:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x3
        cset              w11, ne
        cmp               x10, x2
        cinc              w11, w11, ne
        cbz               w11, 1f
        stlxp             w11, x9, x10, [x0]
        cbnz              w11, 0b
        b                 2f
1:
        stlxp             w11, x5, x4, [x0]
        cbnz              w11, 0b
2:
        cmp               x9, x3
        stp               x10, x9, [x8]
        ccmp              x10, x2, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange::u128::acqrel_relaxed:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x3
        cset              w11, ne
        cmp               x10, x2
        cinc              w11, w11, ne
        cbz               w11, 1f
        stlxp             w11, x9, x10, [x0]
        cbnz              w11, 0b
        b                 2f
1:
        stlxp             w11, x5, x4, [x0]
        cbnz              w11, 0b
2:
        cmp               x9, x3
        stp               x10, x9, [x8]
        ccmp              x10, x2, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange::u128::acquire_seqcst:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x3
        cset              w11, ne
        cmp               x10, x2
        cinc              w11, w11, ne
        cbz               w11, 1f
        stlxp             w11, x9, x10, [x0]
        cbnz              w11, 0b
        b                 2f
1:
        stlxp             w11, x5, x4, [x0]
        cbnz              w11, 0b
2:
        cmp               x9, x3
        stp               x10, x9, [x8]
        ccmp              x10, x2, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange::u128::relaxed_seqcst:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x3
        cset              w11, ne
        cmp               x10, x2
        cinc              w11, w11, ne
        cbz               w11, 1f
        stlxp             w11, x9, x10, [x0]
        cbnz              w11, 0b
        b                 2f
1:
        stlxp             w11, x5, x4, [x0]
        cbnz              w11, 0b
2:
        cmp               x9, x3
        stp               x10, x9, [x8]
        ccmp              x10, x2, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange::u128::release_seqcst:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x3
        cset              w11, ne
        cmp               x10, x2
        cinc              w11, w11, ne
        cbz               w11, 1f
        stlxp             w11, x9, x10, [x0]
        cbnz              w11, 0b
        b                 2f
1:
        stlxp             w11, x5, x4, [x0]
        cbnz              w11, 0b
2:
        cmp               x9, x3
        stp               x10, x9, [x8]
        ccmp              x10, x2, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange::u128::seqcst_acquire:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x3
        cset              w11, ne
        cmp               x10, x2
        cinc              w11, w11, ne
        cbz               w11, 1f
        stlxp             w11, x9, x10, [x0]
        cbnz              w11, 0b
        b                 2f
1:
        stlxp             w11, x5, x4, [x0]
        cbnz              w11, 0b
2:
        cmp               x9, x3
        stp               x10, x9, [x8]
        ccmp              x10, x2, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange::u128::seqcst_relaxed:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x3
        cset              w11, ne
        cmp               x10, x2
        cinc              w11, w11, ne
        cbz               w11, 1f
        stlxp             w11, x9, x10, [x0]
        cbnz              w11, 0b
        b                 2f
1:
        stlxp             w11, x5, x4, [x0]
        cbnz              w11, 0b
2:
        cmp               x9, x3
        stp               x10, x9, [x8]
        ccmp              x10, x2, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange::u128::acquire_acquire:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x3
        cset              w11, ne
        cmp               x10, x2
        cinc              w11, w11, ne
        cbz               w11, 1f
        stxp              w11, x9, x10, [x0]
        cbnz              w11, 0b
        b                 2f
1:
        stxp              w11, x5, x4, [x0]
        cbnz              w11, 0b
2:
        cmp               x9, x3
        stp               x10, x9, [x8]
        ccmp              x10, x2, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange::u128::acquire_relaxed:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x3
        cset              w11, ne
        cmp               x10, x2
        cinc              w11, w11, ne
        cbz               w11, 1f
        stxp              w11, x9, x10, [x0]
        cbnz              w11, 0b
        b                 2f
1:
        stxp              w11, x5, x4, [x0]
        cbnz              w11, 0b
2:
        cmp               x9, x3
        stp               x10, x9, [x8]
        ccmp              x10, x2, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange::u128::relaxed_acquire:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x3
        cset              w11, ne
        cmp               x10, x2
        cinc              w11, w11, ne
        cbz               w11, 1f
        stxp              w11, x9, x10, [x0]
        cbnz              w11, 0b
        b                 2f
1:
        stxp              w11, x5, x4, [x0]
        cbnz              w11, 0b
2:
        cmp               x9, x3
        stp               x10, x9, [x8]
        ccmp              x10, x2, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange::u128::relaxed_relaxed:
0:
        ldxp              x9, x10, [x0]
        cmp               x9, x3
        cset              w11, ne
        cmp               x10, x2
        cinc              w11, w11, ne
        cbz               w11, 1f
        stxp              w11, x9, x10, [x0]
        cbnz              w11, 0b
        b                 2f
1:
        stxp              w11, x5, x4, [x0]
        cbnz              w11, 0b
2:
        cmp               x9, x3
        stp               x10, x9, [x8]
        ccmp              x10, x2, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange::u128::release_acquire:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x3
        cset              w11, ne
        cmp               x10, x2
        cinc              w11, w11, ne
        cbz               w11, 1f
        stlxp             w11, x9, x10, [x0]
        cbnz              w11, 0b
        b                 2f
1:
        stlxp             w11, x5, x4, [x0]
        cbnz              w11, 0b
2:
        cmp               x9, x3
        stp               x10, x9, [x8]
        ccmp              x10, x2, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange::u128::release_relaxed:
0:
        ldxp              x9, x10, [x0]
        cmp               x9, x3
        cset              w11, ne
        cmp               x10, x2
        cinc              w11, w11, ne
        cbz               w11, 1f
        stlxp             w11, x9, x10, [x0]
        cbnz              w11, 0b
        b                 2f
1:
        stlxp             w11, x5, x4, [x0]
        cbnz              w11, 0b
2:
        cmp               x9, x3
        stp               x10, x9, [x8]
        ccmp              x10, x2, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        mov               x8, x0
        ldaxrb            w0, [x0]
        cmp               w0, w1, uxtb
        b.ne              0f
        stlxrb            w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        mov               x8, x0
        ldaxrb            w0, [x0]
        cmp               w0, w1, uxtb
        b.ne              0f
        stlxrb            w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        mov               x8, x0
        ldaxrb            w0, [x0]
        cmp               w0, w1, uxtb
        b.ne              0f
        stlxrb            w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        mov               x8, x0
        ldaxrb            w0, [x0]
        cmp               w0, w1, uxtb
        b.ne              0f
        stlxrb            w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        mov               x8, x0
        ldaxrb            w0, [x0]
        cmp               w0, w1, uxtb
        b.ne              0f
        stlxrb            w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        mov               x8, x0
        ldaxrb            w0, [x0]
        cmp               w0, w1, uxtb
        b.ne              0f
        stlxrb            w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u8::release_seqcst:
        mov               x8, x0
        ldaxrb            w0, [x0]
        cmp               w0, w1, uxtb
        b.ne              0f
        stlxrb            w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        mov               x8, x0
        ldaxrb            w0, [x0]
        cmp               w0, w1, uxtb
        b.ne              0f
        stlxrb            w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        mov               x8, x0
        ldaxrb            w0, [x0]
        cmp               w0, w1, uxtb
        b.ne              0f
        stlxrb            w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u8::acquire_acquire:
        mov               x8, x0
        ldaxrb            w0, [x0]
        cmp               w0, w1, uxtb
        b.ne              0f
        stxrb             w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        mov               x8, x0
        ldaxrb            w0, [x0]
        cmp               w0, w1, uxtb
        b.ne              0f
        stxrb             w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        mov               x8, x0
        ldaxrb            w0, [x0]
        cmp               w0, w1, uxtb
        b.ne              0f
        stxrb             w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        mov               x8, x0
        ldxrb             w0, [x0]
        cmp               w0, w1, uxtb
        b.ne              0f
        stxrb             w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u8::release_acquire:
        mov               x8, x0
        ldaxrb            w0, [x0]
        cmp               w0, w1, uxtb
        b.ne              0f
        stlxrb            w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u8::release_relaxed:
        mov               x8, x0
        ldxrb             w0, [x0]
        cmp               w0, w1, uxtb
        b.ne              0f
        stlxrb            w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        mov               x8, x0
        ldaxrh            w0, [x0]
        cmp               w0, w1, uxth
        b.ne              0f
        stlxrh            w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        mov               x8, x0
        ldaxrh            w0, [x0]
        cmp               w0, w1, uxth
        b.ne              0f
        stlxrh            w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        mov               x8, x0
        ldaxrh            w0, [x0]
        cmp               w0, w1, uxth
        b.ne              0f
        stlxrh            w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        mov               x8, x0
        ldaxrh            w0, [x0]
        cmp               w0, w1, uxth
        b.ne              0f
        stlxrh            w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        mov               x8, x0
        ldaxrh            w0, [x0]
        cmp               w0, w1, uxth
        b.ne              0f
        stlxrh            w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        mov               x8, x0
        ldaxrh            w0, [x0]
        cmp               w0, w1, uxth
        b.ne              0f
        stlxrh            w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u16::release_seqcst:
        mov               x8, x0
        ldaxrh            w0, [x0]
        cmp               w0, w1, uxth
        b.ne              0f
        stlxrh            w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        mov               x8, x0
        ldaxrh            w0, [x0]
        cmp               w0, w1, uxth
        b.ne              0f
        stlxrh            w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        mov               x8, x0
        ldaxrh            w0, [x0]
        cmp               w0, w1, uxth
        b.ne              0f
        stlxrh            w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u16::acquire_acquire:
        mov               x8, x0
        ldaxrh            w0, [x0]
        cmp               w0, w1, uxth
        b.ne              0f
        stxrh             w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        mov               x8, x0
        ldaxrh            w0, [x0]
        cmp               w0, w1, uxth
        b.ne              0f
        stxrh             w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        mov               x8, x0
        ldaxrh            w0, [x0]
        cmp               w0, w1, uxth
        b.ne              0f
        stxrh             w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        mov               x8, x0
        ldxrh             w0, [x0]
        cmp               w0, w1, uxth
        b.ne              0f
        stxrh             w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u16::release_acquire:
        mov               x8, x0
        ldaxrh            w0, [x0]
        cmp               w0, w1, uxth
        b.ne              0f
        stlxrh            w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u16::release_relaxed:
        mov               x8, x0
        ldxrh             w0, [x0]
        cmp               w0, w1, uxth
        b.ne              0f
        stlxrh            w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        mov               x8, x0
        ldaxr             w0, [x0]
        cmp               w0, w1
        b.ne              0f
        stlxr             w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        mov               x8, x0
        ldaxr             w0, [x0]
        cmp               w0, w1
        b.ne              0f
        stlxr             w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        mov               x8, x0
        ldaxr             w0, [x0]
        cmp               w0, w1
        b.ne              0f
        stlxr             w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        mov               x8, x0
        ldaxr             w0, [x0]
        cmp               w0, w1
        b.ne              0f
        stlxr             w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        mov               x8, x0
        ldaxr             w0, [x0]
        cmp               w0, w1
        b.ne              0f
        stlxr             w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        mov               x8, x0
        ldaxr             w0, [x0]
        cmp               w0, w1
        b.ne              0f
        stlxr             w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u32::release_seqcst:
        mov               x8, x0
        ldaxr             w0, [x0]
        cmp               w0, w1
        b.ne              0f
        stlxr             w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        mov               x8, x0
        ldaxr             w0, [x0]
        cmp               w0, w1
        b.ne              0f
        stlxr             w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        mov               x8, x0
        ldaxr             w0, [x0]
        cmp               w0, w1
        b.ne              0f
        stlxr             w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u32::acquire_acquire:
        mov               x8, x0
        ldaxr             w0, [x0]
        cmp               w0, w1
        b.ne              0f
        stxr              w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        mov               x8, x0
        ldaxr             w0, [x0]
        cmp               w0, w1
        b.ne              0f
        stxr              w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        mov               x8, x0
        ldaxr             w0, [x0]
        cmp               w0, w1
        b.ne              0f
        stxr              w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        mov               x8, x0
        ldxr              w0, [x0]
        cmp               w0, w1
        b.ne              0f
        stxr              w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u32::release_acquire:
        mov               x8, x0
        ldaxr             w0, [x0]
        cmp               w0, w1
        b.ne              0f
        stlxr             w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u32::release_relaxed:
        mov               x8, x0
        ldxr              w0, [x0]
        cmp               w0, w1
        b.ne              0f
        stlxr             w9, w2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u64::acqrel_seqcst:
        mov               x8, x0
        ldaxr             x0, [x0]
        cmp               x0, x1
        b.ne              0f
        stlxr             w9, x2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u64::seqcst_seqcst:
        mov               x8, x0
        ldaxr             x0, [x0]
        cmp               x0, x1
        b.ne              0f
        stlxr             w9, x2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u64::acqrel_acquire:
        mov               x8, x0
        ldaxr             x0, [x0]
        cmp               x0, x1
        b.ne              0f
        stlxr             w9, x2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u64::acqrel_relaxed:
        mov               x8, x0
        ldaxr             x0, [x0]
        cmp               x0, x1
        b.ne              0f
        stlxr             w9, x2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u64::acquire_seqcst:
        mov               x8, x0
        ldaxr             x0, [x0]
        cmp               x0, x1
        b.ne              0f
        stlxr             w9, x2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u64::relaxed_seqcst:
        mov               x8, x0
        ldaxr             x0, [x0]
        cmp               x0, x1
        b.ne              0f
        stlxr             w9, x2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u64::release_seqcst:
        mov               x8, x0
        ldaxr             x0, [x0]
        cmp               x0, x1
        b.ne              0f
        stlxr             w9, x2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u64::seqcst_acquire:
        mov               x8, x0
        ldaxr             x0, [x0]
        cmp               x0, x1
        b.ne              0f
        stlxr             w9, x2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u64::seqcst_relaxed:
        mov               x8, x0
        ldaxr             x0, [x0]
        cmp               x0, x1
        b.ne              0f
        stlxr             w9, x2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u64::acquire_acquire:
        mov               x8, x0
        ldaxr             x0, [x0]
        cmp               x0, x1
        b.ne              0f
        stxr              w9, x2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u64::acquire_relaxed:
        mov               x8, x0
        ldaxr             x0, [x0]
        cmp               x0, x1
        b.ne              0f
        stxr              w9, x2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u64::relaxed_acquire:
        mov               x8, x0
        ldaxr             x0, [x0]
        cmp               x0, x1
        b.ne              0f
        stxr              w9, x2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u64::relaxed_relaxed:
        mov               x8, x0
        ldxr              x0, [x0]
        cmp               x0, x1
        b.ne              0f
        stxr              w9, x2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u64::release_acquire:
        mov               x8, x0
        ldaxr             x0, [x0]
        cmp               x0, x1
        b.ne              0f
        stlxr             w9, x2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u64::release_relaxed:
        mov               x8, x0
        ldxr              x0, [x0]
        cmp               x0, x1
        b.ne              0f
        stlxr             w9, x2, [x8]
        cmp               w9, #0x0
        cset              w1, eq
        ret
0:
        mov               w1, wzr
        clrex
        ret

asm_test::compare_exchange_weak::u128::acqrel_seqcst:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x3
        cset              w11, ne
        cmp               x10, x2
        cinc              w11, w11, ne
        cbz               w11, 1f
        stlxp             w11, x9, x10, [x0]
        cbnz              w11, 0b
        b                 2f
1:
        stlxp             w11, x5, x4, [x0]
        cbnz              w11, 0b
2:
        cmp               x9, x3
        stp               x10, x9, [x8]
        ccmp              x10, x2, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u128::seqcst_seqcst:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x3
        cset              w11, ne
        cmp               x10, x2
        cinc              w11, w11, ne
        cbz               w11, 1f
        stlxp             w11, x9, x10, [x0]
        cbnz              w11, 0b
        b                 2f
1:
        stlxp             w11, x5, x4, [x0]
        cbnz              w11, 0b
2:
        cmp               x9, x3
        stp               x10, x9, [x8]
        ccmp              x10, x2, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u128::acqrel_acquire:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x3
        cset              w11, ne
        cmp               x10, x2
        cinc              w11, w11, ne
        cbz               w11, 1f
        stlxp             w11, x9, x10, [x0]
        cbnz              w11, 0b
        b                 2f
1:
        stlxp             w11, x5, x4, [x0]
        cbnz              w11, 0b
2:
        cmp               x9, x3
        stp               x10, x9, [x8]
        ccmp              x10, x2, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u128::acqrel_relaxed:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x3
        cset              w11, ne
        cmp               x10, x2
        cinc              w11, w11, ne
        cbz               w11, 1f
        stlxp             w11, x9, x10, [x0]
        cbnz              w11, 0b
        b                 2f
1:
        stlxp             w11, x5, x4, [x0]
        cbnz              w11, 0b
2:
        cmp               x9, x3
        stp               x10, x9, [x8]
        ccmp              x10, x2, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u128::acquire_seqcst:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x3
        cset              w11, ne
        cmp               x10, x2
        cinc              w11, w11, ne
        cbz               w11, 1f
        stlxp             w11, x9, x10, [x0]
        cbnz              w11, 0b
        b                 2f
1:
        stlxp             w11, x5, x4, [x0]
        cbnz              w11, 0b
2:
        cmp               x9, x3
        stp               x10, x9, [x8]
        ccmp              x10, x2, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u128::relaxed_seqcst:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x3
        cset              w11, ne
        cmp               x10, x2
        cinc              w11, w11, ne
        cbz               w11, 1f
        stlxp             w11, x9, x10, [x0]
        cbnz              w11, 0b
        b                 2f
1:
        stlxp             w11, x5, x4, [x0]
        cbnz              w11, 0b
2:
        cmp               x9, x3
        stp               x10, x9, [x8]
        ccmp              x10, x2, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u128::release_seqcst:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x3
        cset              w11, ne
        cmp               x10, x2
        cinc              w11, w11, ne
        cbz               w11, 1f
        stlxp             w11, x9, x10, [x0]
        cbnz              w11, 0b
        b                 2f
1:
        stlxp             w11, x5, x4, [x0]
        cbnz              w11, 0b
2:
        cmp               x9, x3
        stp               x10, x9, [x8]
        ccmp              x10, x2, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u128::seqcst_acquire:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x3
        cset              w11, ne
        cmp               x10, x2
        cinc              w11, w11, ne
        cbz               w11, 1f
        stlxp             w11, x9, x10, [x0]
        cbnz              w11, 0b
        b                 2f
1:
        stlxp             w11, x5, x4, [x0]
        cbnz              w11, 0b
2:
        cmp               x9, x3
        stp               x10, x9, [x8]
        ccmp              x10, x2, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u128::seqcst_relaxed:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x3
        cset              w11, ne
        cmp               x10, x2
        cinc              w11, w11, ne
        cbz               w11, 1f
        stlxp             w11, x9, x10, [x0]
        cbnz              w11, 0b
        b                 2f
1:
        stlxp             w11, x5, x4, [x0]
        cbnz              w11, 0b
2:
        cmp               x9, x3
        stp               x10, x9, [x8]
        ccmp              x10, x2, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u128::acquire_acquire:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x3
        cset              w11, ne
        cmp               x10, x2
        cinc              w11, w11, ne
        cbz               w11, 1f
        stxp              w11, x9, x10, [x0]
        cbnz              w11, 0b
        b                 2f
1:
        stxp              w11, x5, x4, [x0]
        cbnz              w11, 0b
2:
        cmp               x9, x3
        stp               x10, x9, [x8]
        ccmp              x10, x2, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u128::acquire_relaxed:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x3
        cset              w11, ne
        cmp               x10, x2
        cinc              w11, w11, ne
        cbz               w11, 1f
        stxp              w11, x9, x10, [x0]
        cbnz              w11, 0b
        b                 2f
1:
        stxp              w11, x5, x4, [x0]
        cbnz              w11, 0b
2:
        cmp               x9, x3
        stp               x10, x9, [x8]
        ccmp              x10, x2, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u128::relaxed_acquire:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x3
        cset              w11, ne
        cmp               x10, x2
        cinc              w11, w11, ne
        cbz               w11, 1f
        stxp              w11, x9, x10, [x0]
        cbnz              w11, 0b
        b                 2f
1:
        stxp              w11, x5, x4, [x0]
        cbnz              w11, 0b
2:
        cmp               x9, x3
        stp               x10, x9, [x8]
        ccmp              x10, x2, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u128::relaxed_relaxed:
0:
        ldxp              x9, x10, [x0]
        cmp               x9, x3
        cset              w11, ne
        cmp               x10, x2
        cinc              w11, w11, ne
        cbz               w11, 1f
        stxp              w11, x9, x10, [x0]
        cbnz              w11, 0b
        b                 2f
1:
        stxp              w11, x5, x4, [x0]
        cbnz              w11, 0b
2:
        cmp               x9, x3
        stp               x10, x9, [x8]
        ccmp              x10, x2, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u128::release_acquire:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x3
        cset              w11, ne
        cmp               x10, x2
        cinc              w11, w11, ne
        cbz               w11, 1f
        stlxp             w11, x9, x10, [x0]
        cbnz              w11, 0b
        b                 2f
1:
        stlxp             w11, x5, x4, [x0]
        cbnz              w11, 0b
2:
        cmp               x9, x3
        stp               x10, x9, [x8]
        ccmp              x10, x2, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u128::release_relaxed:
0:
        ldxp              x9, x10, [x0]
        cmp               x9, x3
        cset              w11, ne
        cmp               x10, x2
        cinc              w11, w11, ne
        cbz               w11, 1f
        stlxp             w11, x9, x10, [x0]
        cbnz              w11, 0b
        b                 2f
1:
        stlxp             w11, x5, x4, [x0]
        cbnz              w11, 0b
2:
        cmp               x9, x3
        stp               x10, x9, [x8]
        ccmp              x10, x2, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::load::u8::seqcst:
        ldarb             w0, [x0]
        ret

asm_test::load::u8::acquire:
        ldarb             w0, [x0]
        ret

asm_test::load::u8::relaxed:
        ldrb              w0, [x0]
        ret

asm_test::load::u16::seqcst:
        ldarh             w0, [x0]
        ret

asm_test::load::u16::acquire:
        ldarh             w0, [x0]
        ret

asm_test::load::u16::relaxed:
        ldrh              w0, [x0]
        ret

asm_test::load::u32::seqcst:
        ldar              w0, [x0]
        ret

asm_test::load::u32::acquire:
        ldar              w0, [x0]
        ret

asm_test::load::u32::relaxed:
        ldr               w0, [x0]
        ret

asm_test::load::u64::seqcst:
        ldar              x0, [x0]
        ret

asm_test::load::u64::acquire:
        ldar              x0, [x0]
        ret

asm_test::load::u64::relaxed:
        ldr               x0, [x0]
        ret

asm_test::load::u128::seqcst:
        mov               x8, x0
0:
        ldaxp             x1, x0, [x8]
        stlxp             w9, x1, x0, [x8]
        cbnz              w9, 0b
        ret

asm_test::load::u128::acquire:
        mov               x8, x0
0:
        ldaxp             x1, x0, [x8]
        stxp              w9, x1, x0, [x8]
        cbnz              w9, 0b
        ret

asm_test::load::u128::relaxed:
        mov               x8, x0
0:
        ldxp              x1, x0, [x8]
        stxp              w9, x1, x0, [x8]
        cbnz              w9, 0b
        ret

asm_test::swap::u8::acqrel:
        mov               x8, x0
0:
        ldaxrb            w0, [x8]
        stlxrb            w9, w1, [x8]
        cbnz              w9, 0b
        ret

asm_test::swap::u8::seqcst:
        mov               x8, x0
0:
        ldaxrb            w0, [x8]
        stlxrb            w9, w1, [x8]
        cbnz              w9, 0b
        ret

asm_test::swap::u8::acquire:
        mov               x8, x0
0:
        ldaxrb            w0, [x8]
        stxrb             w9, w1, [x8]
        cbnz              w9, 0b
        ret

asm_test::swap::u8::relaxed:
        mov               x8, x0
0:
        ldxrb             w0, [x8]
        stxrb             w9, w1, [x8]
        cbnz              w9, 0b
        ret

asm_test::swap::u8::release:
        mov               x8, x0
0:
        ldxrb             w0, [x8]
        stlxrb            w9, w1, [x8]
        cbnz              w9, 0b
        ret

asm_test::swap::u16::acqrel:
        mov               x8, x0
0:
        ldaxrh            w0, [x8]
        stlxrh            w9, w1, [x8]
        cbnz              w9, 0b
        ret

asm_test::swap::u16::seqcst:
        mov               x8, x0
0:
        ldaxrh            w0, [x8]
        stlxrh            w9, w1, [x8]
        cbnz              w9, 0b
        ret

asm_test::swap::u16::acquire:
        mov               x8, x0
0:
        ldaxrh            w0, [x8]
        stxrh             w9, w1, [x8]
        cbnz              w9, 0b
        ret

asm_test::swap::u16::relaxed:
        mov               x8, x0
0:
        ldxrh             w0, [x8]
        stxrh             w9, w1, [x8]
        cbnz              w9, 0b
        ret

asm_test::swap::u16::release:
        mov               x8, x0
0:
        ldxrh             w0, [x8]
        stlxrh            w9, w1, [x8]
        cbnz              w9, 0b
        ret

asm_test::swap::u32::acqrel:
        mov               x8, x0
0:
        ldaxr             w0, [x8]
        stlxr             w9, w1, [x8]
        cbnz              w9, 0b
        ret

asm_test::swap::u32::seqcst:
        mov               x8, x0
0:
        ldaxr             w0, [x8]
        stlxr             w9, w1, [x8]
        cbnz              w9, 0b
        ret

asm_test::swap::u32::acquire:
        mov               x8, x0
0:
        ldaxr             w0, [x8]
        stxr              w9, w1, [x8]
        cbnz              w9, 0b
        ret

asm_test::swap::u32::relaxed:
        mov               x8, x0
0:
        ldxr              w0, [x8]
        stxr              w9, w1, [x8]
        cbnz              w9, 0b
        ret

asm_test::swap::u32::release:
        mov               x8, x0
0:
        ldxr              w0, [x8]
        stlxr             w9, w1, [x8]
        cbnz              w9, 0b
        ret

asm_test::swap::u64::acqrel:
        mov               x8, x0
0:
        ldaxr             x0, [x8]
        stlxr             w9, x1, [x8]
        cbnz              w9, 0b
        ret

asm_test::swap::u64::seqcst:
        mov               x8, x0
0:
        ldaxr             x0, [x8]
        stlxr             w9, x1, [x8]
        cbnz              w9, 0b
        ret

asm_test::swap::u64::acquire:
        mov               x8, x0
0:
        ldaxr             x0, [x8]
        stxr              w9, x1, [x8]
        cbnz              w9, 0b
        ret

asm_test::swap::u64::relaxed:
        mov               x8, x0
0:
        ldxr              x0, [x8]
        stxr              w9, x1, [x8]
        cbnz              w9, 0b
        ret

asm_test::swap::u64::release:
        mov               x8, x0
0:
        ldxr              x0, [x8]
        stlxr             w9, x1, [x8]
        cbnz              w9, 0b
        ret

asm_test::swap::u128::acqrel:
0:
        ldaxp             x1, x8, [x0]
        stlxp             w9, x3, x2, [x0]
        cbnz              w9, 0b
        mov               x0, x8
        ret

asm_test::swap::u128::seqcst:
0:
        ldaxp             x1, x8, [x0]
        stlxp             w9, x3, x2, [x0]
        cbnz              w9, 0b
        mov               x0, x8
        ret

asm_test::swap::u128::acquire:
0:
        ldaxp             x1, x8, [x0]
        stxp              w9, x3, x2, [x0]
        cbnz              w9, 0b
        mov               x0, x8
        ret

asm_test::swap::u128::relaxed:
0:
        ldxp              x1, x8, [x0]
        stxp              w9, x3, x2, [x0]
        cbnz              w9, 0b
        mov               x0, x8
        ret

asm_test::swap::u128::release:
0:
        ldxp              x1, x8, [x0]
        stlxp             w9, x3, x2, [x0]
        cbnz              w9, 0b
        mov               x0, x8
        ret

asm_test::store::u8::seqcst:
        stlrb             w1, [x0]
        ret

asm_test::store::u8::relaxed:
        strb              w1, [x0]
        ret

asm_test::store::u8::release:
        stlrb             w1, [x0]
        ret

asm_test::store::u16::seqcst:
        stlrh             w1, [x0]
        ret

asm_test::store::u16::relaxed:
        strh              w1, [x0]
        ret

asm_test::store::u16::release:
        stlrh             w1, [x0]
        ret

asm_test::store::u32::seqcst:
        stlr              w1, [x0]
        ret

asm_test::store::u32::relaxed:
        str               w1, [x0]
        ret

asm_test::store::u32::release:
        stlr              w1, [x0]
        ret

asm_test::store::u64::seqcst:
        stlr              x1, [x0]
        ret

asm_test::store::u64::relaxed:
        str               x1, [x0]
        ret

asm_test::store::u64::release:
        stlr              x1, [x0]
        ret

asm_test::store::u128::seqcst:
0:
        ldaxp             xzr, x8, [x0]
        stlxp             w8, x3, x2, [x0]
        cbnz              w8, 0b
        ret

asm_test::store::u128::relaxed:
0:
        ldxp              xzr, x8, [x0]
        stxp              w8, x3, x2, [x0]
        cbnz              w8, 0b
        ret

asm_test::store::u128::release:
0:
        ldxp              xzr, x8, [x0]
        stlxp             w8, x3, x2, [x0]
        cbnz              w8, 0b
        ret

