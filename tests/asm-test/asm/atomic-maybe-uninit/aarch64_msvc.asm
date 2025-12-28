asm_test::compare_exchange::u8::acqrel_seqcst:
0:
        ldaxrb            w8, [x0]
        cmp               w8, w1, uxtb
        b.ne              1f
        stlxrb            w9, w2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u8::seqcst_seqcst:
0:
        ldaxrb            w8, [x0]
        cmp               w8, w1, uxtb
        b.ne              1f
        stlxrb            w9, w2, [x0]
        cbnz              w9, 0b
        dmb               ish
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u8::acqrel_acquire:
0:
        ldaxrb            w8, [x0]
        cmp               w8, w1, uxtb
        b.ne              1f
        stlxrb            w9, w2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u8::acqrel_relaxed:
0:
        ldaxrb            w8, [x0]
        cmp               w8, w1, uxtb
        b.ne              1f
        stlxrb            w9, w2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u8::acquire_seqcst:
0:
        ldaxrb            w8, [x0]
        cmp               w8, w1, uxtb
        b.ne              1f
        stlxrb            w9, w2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u8::relaxed_seqcst:
0:
        ldaxrb            w8, [x0]
        cmp               w8, w1, uxtb
        b.ne              1f
        stlxrb            w9, w2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u8::release_seqcst:
0:
        ldaxrb            w8, [x0]
        cmp               w8, w1, uxtb
        b.ne              1f
        stlxrb            w9, w2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u8::seqcst_acquire:
0:
        ldaxrb            w8, [x0]
        cmp               w8, w1, uxtb
        b.ne              1f
        stlxrb            w9, w2, [x0]
        cbnz              w9, 0b
        dmb               ish
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u8::seqcst_relaxed:
0:
        ldaxrb            w8, [x0]
        cmp               w8, w1, uxtb
        b.ne              1f
        stlxrb            w9, w2, [x0]
        cbnz              w9, 0b
        dmb               ish
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u8::acquire_acquire:
0:
        ldaxrb            w8, [x0]
        cmp               w8, w1, uxtb
        b.ne              1f
        stxrb             w9, w2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u8::acquire_relaxed:
0:
        ldaxrb            w8, [x0]
        cmp               w8, w1, uxtb
        b.ne              1f
        stxrb             w9, w2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u8::relaxed_acquire:
0:
        ldaxrb            w8, [x0]
        cmp               w8, w1, uxtb
        b.ne              1f
        stxrb             w9, w2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u8::relaxed_relaxed:
0:
        ldxrb             w8, [x0]
        cmp               w8, w1, uxtb
        b.ne              1f
        stxrb             w9, w2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u8::release_acquire:
0:
        ldaxrb            w8, [x0]
        cmp               w8, w1, uxtb
        b.ne              1f
        stlxrb            w9, w2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u8::release_relaxed:
0:
        ldxrb             w8, [x0]
        cmp               w8, w1, uxtb
        b.ne              1f
        stlxrb            w9, w2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u16::acqrel_seqcst:
0:
        ldaxrh            w8, [x0]
        cmp               w8, w1, uxth
        b.ne              1f
        stlxrh            w9, w2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u16::seqcst_seqcst:
0:
        ldaxrh            w8, [x0]
        cmp               w8, w1, uxth
        b.ne              1f
        stlxrh            w9, w2, [x0]
        cbnz              w9, 0b
        dmb               ish
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u16::acqrel_acquire:
0:
        ldaxrh            w8, [x0]
        cmp               w8, w1, uxth
        b.ne              1f
        stlxrh            w9, w2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u16::acqrel_relaxed:
0:
        ldaxrh            w8, [x0]
        cmp               w8, w1, uxth
        b.ne              1f
        stlxrh            w9, w2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u16::acquire_seqcst:
0:
        ldaxrh            w8, [x0]
        cmp               w8, w1, uxth
        b.ne              1f
        stlxrh            w9, w2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u16::relaxed_seqcst:
0:
        ldaxrh            w8, [x0]
        cmp               w8, w1, uxth
        b.ne              1f
        stlxrh            w9, w2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u16::release_seqcst:
0:
        ldaxrh            w8, [x0]
        cmp               w8, w1, uxth
        b.ne              1f
        stlxrh            w9, w2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u16::seqcst_acquire:
0:
        ldaxrh            w8, [x0]
        cmp               w8, w1, uxth
        b.ne              1f
        stlxrh            w9, w2, [x0]
        cbnz              w9, 0b
        dmb               ish
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u16::seqcst_relaxed:
0:
        ldaxrh            w8, [x0]
        cmp               w8, w1, uxth
        b.ne              1f
        stlxrh            w9, w2, [x0]
        cbnz              w9, 0b
        dmb               ish
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u16::acquire_acquire:
0:
        ldaxrh            w8, [x0]
        cmp               w8, w1, uxth
        b.ne              1f
        stxrh             w9, w2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u16::acquire_relaxed:
0:
        ldaxrh            w8, [x0]
        cmp               w8, w1, uxth
        b.ne              1f
        stxrh             w9, w2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u16::relaxed_acquire:
0:
        ldaxrh            w8, [x0]
        cmp               w8, w1, uxth
        b.ne              1f
        stxrh             w9, w2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u16::relaxed_relaxed:
0:
        ldxrh             w8, [x0]
        cmp               w8, w1, uxth
        b.ne              1f
        stxrh             w9, w2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u16::release_acquire:
0:
        ldaxrh            w8, [x0]
        cmp               w8, w1, uxth
        b.ne              1f
        stlxrh            w9, w2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u16::release_relaxed:
0:
        ldxrh             w8, [x0]
        cmp               w8, w1, uxth
        b.ne              1f
        stlxrh            w9, w2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u32::acqrel_seqcst:
0:
        ldaxr             w8, [x0]
        cmp               w8, w1
        b.ne              1f
        stlxr             w9, w2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u32::seqcst_seqcst:
0:
        ldaxr             w8, [x0]
        cmp               w8, w1
        b.ne              1f
        stlxr             w9, w2, [x0]
        cbnz              w9, 0b
        dmb               ish
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u32::acqrel_acquire:
0:
        ldaxr             w8, [x0]
        cmp               w8, w1
        b.ne              1f
        stlxr             w9, w2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u32::acqrel_relaxed:
0:
        ldaxr             w8, [x0]
        cmp               w8, w1
        b.ne              1f
        stlxr             w9, w2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u32::acquire_seqcst:
0:
        ldaxr             w8, [x0]
        cmp               w8, w1
        b.ne              1f
        stlxr             w9, w2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u32::relaxed_seqcst:
0:
        ldaxr             w8, [x0]
        cmp               w8, w1
        b.ne              1f
        stlxr             w9, w2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u32::release_seqcst:
0:
        ldaxr             w8, [x0]
        cmp               w8, w1
        b.ne              1f
        stlxr             w9, w2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u32::seqcst_acquire:
0:
        ldaxr             w8, [x0]
        cmp               w8, w1
        b.ne              1f
        stlxr             w9, w2, [x0]
        cbnz              w9, 0b
        dmb               ish
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u32::seqcst_relaxed:
0:
        ldaxr             w8, [x0]
        cmp               w8, w1
        b.ne              1f
        stlxr             w9, w2, [x0]
        cbnz              w9, 0b
        dmb               ish
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u32::acquire_acquire:
0:
        ldaxr             w8, [x0]
        cmp               w8, w1
        b.ne              1f
        stxr              w9, w2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u32::acquire_relaxed:
0:
        ldaxr             w8, [x0]
        cmp               w8, w1
        b.ne              1f
        stxr              w9, w2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u32::relaxed_acquire:
0:
        ldaxr             w8, [x0]
        cmp               w8, w1
        b.ne              1f
        stxr              w9, w2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u32::relaxed_relaxed:
0:
        ldxr              w8, [x0]
        cmp               w8, w1
        b.ne              1f
        stxr              w9, w2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u32::release_acquire:
0:
        ldaxr             w8, [x0]
        cmp               w8, w1
        b.ne              1f
        stlxr             w9, w2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u32::release_relaxed:
0:
        ldxr              w8, [x0]
        cmp               w8, w1
        b.ne              1f
        stlxr             w9, w2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u64::acqrel_seqcst:
0:
        ldaxr             x8, [x0]
        cmp               x8, x1
        b.ne              1f
        stlxr             w9, x2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u64::seqcst_seqcst:
0:
        ldaxr             x8, [x0]
        cmp               x8, x1
        b.ne              1f
        stlxr             w9, x2, [x0]
        cbnz              w9, 0b
        dmb               ish
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u64::acqrel_acquire:
0:
        ldaxr             x8, [x0]
        cmp               x8, x1
        b.ne              1f
        stlxr             w9, x2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u64::acqrel_relaxed:
0:
        ldaxr             x8, [x0]
        cmp               x8, x1
        b.ne              1f
        stlxr             w9, x2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u64::acquire_seqcst:
0:
        ldaxr             x8, [x0]
        cmp               x8, x1
        b.ne              1f
        stlxr             w9, x2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u64::relaxed_seqcst:
0:
        ldaxr             x8, [x0]
        cmp               x8, x1
        b.ne              1f
        stlxr             w9, x2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u64::release_seqcst:
0:
        ldaxr             x8, [x0]
        cmp               x8, x1
        b.ne              1f
        stlxr             w9, x2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u64::seqcst_acquire:
0:
        ldaxr             x8, [x0]
        cmp               x8, x1
        b.ne              1f
        stlxr             w9, x2, [x0]
        cbnz              w9, 0b
        dmb               ish
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u64::seqcst_relaxed:
0:
        ldaxr             x8, [x0]
        cmp               x8, x1
        b.ne              1f
        stlxr             w9, x2, [x0]
        cbnz              w9, 0b
        dmb               ish
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u64::acquire_acquire:
0:
        ldaxr             x8, [x0]
        cmp               x8, x1
        b.ne              1f
        stxr              w9, x2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u64::acquire_relaxed:
0:
        ldaxr             x8, [x0]
        cmp               x8, x1
        b.ne              1f
        stxr              w9, x2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u64::relaxed_acquire:
0:
        ldaxr             x8, [x0]
        cmp               x8, x1
        b.ne              1f
        stxr              w9, x2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u64::relaxed_relaxed:
0:
        ldxr              x8, [x0]
        cmp               x8, x1
        b.ne              1f
        stxr              w9, x2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u64::release_acquire:
0:
        ldaxr             x8, [x0]
        cmp               x8, x1
        b.ne              1f
        stlxr             w9, x2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u64::release_relaxed:
0:
        ldxr              x8, [x0]
        cmp               x8, x1
        b.ne              1f
        stlxr             w9, x2, [x0]
        cbnz              w9, 0b
        b                 2f
1:
        mov               w9, #0x1                // =1
        clrex
2:
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange::u128::acqrel_seqcst:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x13, x5, x10, eq
        stlxp             w11, x12, x13, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

asm_test::compare_exchange::u128::seqcst_seqcst:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x13, x5, x10, eq
        stlxp             w11, x12, x13, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        dmb               ish
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

asm_test::compare_exchange::u128::acqrel_acquire:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x13, x5, x10, eq
        stlxp             w11, x12, x13, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

asm_test::compare_exchange::u128::acqrel_relaxed:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x13, x5, x10, eq
        stlxp             w11, x12, x13, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

asm_test::compare_exchange::u128::acquire_seqcst:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x13, x5, x10, eq
        stlxp             w11, x12, x13, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

asm_test::compare_exchange::u128::relaxed_seqcst:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x13, x5, x10, eq
        stlxp             w11, x12, x13, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

asm_test::compare_exchange::u128::release_seqcst:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x13, x5, x10, eq
        stlxp             w11, x12, x13, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

asm_test::compare_exchange::u128::seqcst_acquire:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x13, x5, x10, eq
        stlxp             w11, x12, x13, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        dmb               ish
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

asm_test::compare_exchange::u128::seqcst_relaxed:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x13, x5, x10, eq
        stlxp             w11, x12, x13, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        dmb               ish
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

asm_test::compare_exchange::u128::acquire_acquire:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x13, x5, x10, eq
        stxp              w11, x12, x13, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

asm_test::compare_exchange::u128::acquire_relaxed:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x13, x5, x10, eq
        stxp              w11, x12, x13, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

asm_test::compare_exchange::u128::relaxed_acquire:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x13, x5, x10, eq
        stxp              w11, x12, x13, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

asm_test::compare_exchange::u128::relaxed_relaxed:
0:
        ldxp              x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x13, x5, x10, eq
        stxp              w11, x12, x13, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

asm_test::compare_exchange::u128::release_acquire:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x13, x5, x10, eq
        stlxp             w11, x12, x13, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

asm_test::compare_exchange::u128::release_relaxed:
0:
        ldxp              x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x13, x5, x10, eq
        stlxp             w11, x12, x13, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        ldaxrb            w8, [x0]
        cmp               w8, w1, uxtb
        b.ne              0f
        stlxrb            w9, w2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        ldaxrb            w8, [x0]
        cmp               w8, w1, uxtb
        b.ne              0f
        stlxrb            w9, w2, [x0]
        dmb               ish
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        ldaxrb            w8, [x0]
        cmp               w8, w1, uxtb
        b.ne              0f
        stlxrb            w9, w2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        ldaxrb            w8, [x0]
        cmp               w8, w1, uxtb
        b.ne              0f
        stlxrb            w9, w2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        ldaxrb            w8, [x0]
        cmp               w8, w1, uxtb
        b.ne              0f
        stlxrb            w9, w2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        ldaxrb            w8, [x0]
        cmp               w8, w1, uxtb
        b.ne              0f
        stlxrb            w9, w2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u8::release_seqcst:
        ldaxrb            w8, [x0]
        cmp               w8, w1, uxtb
        b.ne              0f
        stlxrb            w9, w2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        ldaxrb            w8, [x0]
        cmp               w8, w1, uxtb
        b.ne              0f
        stlxrb            w9, w2, [x0]
        dmb               ish
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        ldaxrb            w8, [x0]
        cmp               w8, w1, uxtb
        b.ne              0f
        stlxrb            w9, w2, [x0]
        dmb               ish
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u8::acquire_acquire:
        ldaxrb            w8, [x0]
        cmp               w8, w1, uxtb
        b.ne              0f
        stxrb             w9, w2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        ldaxrb            w8, [x0]
        cmp               w8, w1, uxtb
        b.ne              0f
        stxrb             w9, w2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        ldaxrb            w8, [x0]
        cmp               w8, w1, uxtb
        b.ne              0f
        stxrb             w9, w2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        ldxrb             w8, [x0]
        cmp               w8, w1, uxtb
        b.ne              0f
        stxrb             w9, w2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u8::release_acquire:
        ldaxrb            w8, [x0]
        cmp               w8, w1, uxtb
        b.ne              0f
        stlxrb            w9, w2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u8::release_relaxed:
        ldxrb             w8, [x0]
        cmp               w8, w1, uxtb
        b.ne              0f
        stlxrb            w9, w2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        ldaxrh            w8, [x0]
        cmp               w8, w1, uxth
        b.ne              0f
        stlxrh            w9, w2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        ldaxrh            w8, [x0]
        cmp               w8, w1, uxth
        b.ne              0f
        stlxrh            w9, w2, [x0]
        dmb               ish
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        ldaxrh            w8, [x0]
        cmp               w8, w1, uxth
        b.ne              0f
        stlxrh            w9, w2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        ldaxrh            w8, [x0]
        cmp               w8, w1, uxth
        b.ne              0f
        stlxrh            w9, w2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        ldaxrh            w8, [x0]
        cmp               w8, w1, uxth
        b.ne              0f
        stlxrh            w9, w2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        ldaxrh            w8, [x0]
        cmp               w8, w1, uxth
        b.ne              0f
        stlxrh            w9, w2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u16::release_seqcst:
        ldaxrh            w8, [x0]
        cmp               w8, w1, uxth
        b.ne              0f
        stlxrh            w9, w2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        ldaxrh            w8, [x0]
        cmp               w8, w1, uxth
        b.ne              0f
        stlxrh            w9, w2, [x0]
        dmb               ish
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        ldaxrh            w8, [x0]
        cmp               w8, w1, uxth
        b.ne              0f
        stlxrh            w9, w2, [x0]
        dmb               ish
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u16::acquire_acquire:
        ldaxrh            w8, [x0]
        cmp               w8, w1, uxth
        b.ne              0f
        stxrh             w9, w2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        ldaxrh            w8, [x0]
        cmp               w8, w1, uxth
        b.ne              0f
        stxrh             w9, w2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        ldaxrh            w8, [x0]
        cmp               w8, w1, uxth
        b.ne              0f
        stxrh             w9, w2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        ldxrh             w8, [x0]
        cmp               w8, w1, uxth
        b.ne              0f
        stxrh             w9, w2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u16::release_acquire:
        ldaxrh            w8, [x0]
        cmp               w8, w1, uxth
        b.ne              0f
        stlxrh            w9, w2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u16::release_relaxed:
        ldxrh             w8, [x0]
        cmp               w8, w1, uxth
        b.ne              0f
        stlxrh            w9, w2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        ldaxr             w8, [x0]
        cmp               w8, w1
        b.ne              0f
        stlxr             w9, w2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        ldaxr             w8, [x0]
        cmp               w8, w1
        b.ne              0f
        stlxr             w9, w2, [x0]
        dmb               ish
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        ldaxr             w8, [x0]
        cmp               w8, w1
        b.ne              0f
        stlxr             w9, w2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        ldaxr             w8, [x0]
        cmp               w8, w1
        b.ne              0f
        stlxr             w9, w2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        ldaxr             w8, [x0]
        cmp               w8, w1
        b.ne              0f
        stlxr             w9, w2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        ldaxr             w8, [x0]
        cmp               w8, w1
        b.ne              0f
        stlxr             w9, w2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u32::release_seqcst:
        ldaxr             w8, [x0]
        cmp               w8, w1
        b.ne              0f
        stlxr             w9, w2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        ldaxr             w8, [x0]
        cmp               w8, w1
        b.ne              0f
        stlxr             w9, w2, [x0]
        dmb               ish
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        ldaxr             w8, [x0]
        cmp               w8, w1
        b.ne              0f
        stlxr             w9, w2, [x0]
        dmb               ish
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u32::acquire_acquire:
        ldaxr             w8, [x0]
        cmp               w8, w1
        b.ne              0f
        stxr              w9, w2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        ldaxr             w8, [x0]
        cmp               w8, w1
        b.ne              0f
        stxr              w9, w2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        ldaxr             w8, [x0]
        cmp               w8, w1
        b.ne              0f
        stxr              w9, w2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        ldxr              w8, [x0]
        cmp               w8, w1
        b.ne              0f
        stxr              w9, w2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u32::release_acquire:
        ldaxr             w8, [x0]
        cmp               w8, w1
        b.ne              0f
        stlxr             w9, w2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u32::release_relaxed:
        ldxr              w8, [x0]
        cmp               w8, w1
        b.ne              0f
        stlxr             w9, w2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u64::acqrel_seqcst:
        ldaxr             x8, [x0]
        cmp               x8, x1
        b.ne              0f
        stlxr             w9, x2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u64::seqcst_seqcst:
        ldaxr             x8, [x0]
        cmp               x8, x1
        b.ne              0f
        stlxr             w9, x2, [x0]
        dmb               ish
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u64::acqrel_acquire:
        ldaxr             x8, [x0]
        cmp               x8, x1
        b.ne              0f
        stlxr             w9, x2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u64::acqrel_relaxed:
        ldaxr             x8, [x0]
        cmp               x8, x1
        b.ne              0f
        stlxr             w9, x2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u64::acquire_seqcst:
        ldaxr             x8, [x0]
        cmp               x8, x1
        b.ne              0f
        stlxr             w9, x2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u64::relaxed_seqcst:
        ldaxr             x8, [x0]
        cmp               x8, x1
        b.ne              0f
        stlxr             w9, x2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u64::release_seqcst:
        ldaxr             x8, [x0]
        cmp               x8, x1
        b.ne              0f
        stlxr             w9, x2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u64::seqcst_acquire:
        ldaxr             x8, [x0]
        cmp               x8, x1
        b.ne              0f
        stlxr             w9, x2, [x0]
        dmb               ish
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u64::seqcst_relaxed:
        ldaxr             x8, [x0]
        cmp               x8, x1
        b.ne              0f
        stlxr             w9, x2, [x0]
        dmb               ish
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u64::acquire_acquire:
        ldaxr             x8, [x0]
        cmp               x8, x1
        b.ne              0f
        stxr              w9, x2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u64::acquire_relaxed:
        ldaxr             x8, [x0]
        cmp               x8, x1
        b.ne              0f
        stxr              w9, x2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u64::relaxed_acquire:
        ldaxr             x8, [x0]
        cmp               x8, x1
        b.ne              0f
        stxr              w9, x2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u64::relaxed_relaxed:
        ldxr              x8, [x0]
        cmp               x8, x1
        b.ne              0f
        stxr              w9, x2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u64::release_acquire:
        ldaxr             x8, [x0]
        cmp               x8, x1
        b.ne              0f
        stlxr             w9, x2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u64::release_relaxed:
        ldxr              x8, [x0]
        cmp               x8, x1
        b.ne              0f
        stlxr             w9, x2, [x0]
        b                 1f
0:
        mov               w9, #0x1                // =1
        clrex
1:
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u128::acqrel_seqcst:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x13, x5, x10, eq
        stlxp             w11, x12, x13, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u128::seqcst_seqcst:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x13, x5, x10, eq
        stlxp             w11, x12, x13, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        dmb               ish
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u128::acqrel_acquire:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x13, x5, x10, eq
        stlxp             w11, x12, x13, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u128::acqrel_relaxed:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x13, x5, x10, eq
        stlxp             w11, x12, x13, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u128::acquire_seqcst:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x13, x5, x10, eq
        stlxp             w11, x12, x13, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u128::relaxed_seqcst:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x13, x5, x10, eq
        stlxp             w11, x12, x13, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u128::release_seqcst:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x13, x5, x10, eq
        stlxp             w11, x12, x13, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u128::seqcst_acquire:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x13, x5, x10, eq
        stlxp             w11, x12, x13, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        dmb               ish
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u128::seqcst_relaxed:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x13, x5, x10, eq
        stlxp             w11, x12, x13, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        dmb               ish
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u128::acquire_acquire:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x13, x5, x10, eq
        stxp              w11, x12, x13, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u128::acquire_relaxed:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x13, x5, x10, eq
        stxp              w11, x12, x13, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u128::relaxed_acquire:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x13, x5, x10, eq
        stxp              w11, x12, x13, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u128::relaxed_relaxed:
0:
        ldxp              x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x13, x5, x10, eq
        stxp              w11, x12, x13, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u128::release_acquire:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x13, x5, x10, eq
        stlxp             w11, x12, x13, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u128::release_relaxed:
0:
        ldxp              x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x13, x5, x10, eq
        stlxp             w11, x12, x13, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
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
0:
        ldaxp             x8, x1, [x0]
        stlxp             w9, x8, x1, [x0]
        cbnz              w9, 0b
        mov               x0, x8
        ret

asm_test::load::u128::acquire:
0:
        ldaxp             x8, x1, [x0]
        stxp              w9, x8, x1, [x0]
        cbnz              w9, 0b
        mov               x0, x8
        ret

asm_test::load::u128::relaxed:
0:
        ldxp              x8, x1, [x0]
        stxp              w9, x8, x1, [x0]
        cbnz              w9, 0b
        mov               x0, x8
        ret

asm_test::swap::u8::acqrel:
0:
        ldaxrb            w8, [x0]
        stlxrb            w9, w1, [x0]
        cbnz              w9, 0b
        mov               w0, w8
        ret

asm_test::swap::u8::seqcst:
0:
        ldaxrb            w8, [x0]
        stlxrb            w9, w1, [x0]
        cbnz              w9, 0b
        dmb               ish
        mov               w0, w8
        ret

asm_test::swap::u8::acquire:
0:
        ldaxrb            w8, [x0]
        stxrb             w9, w1, [x0]
        cbnz              w9, 0b
        mov               w0, w8
        ret

asm_test::swap::u8::relaxed:
0:
        ldxrb             w8, [x0]
        stxrb             w9, w1, [x0]
        cbnz              w9, 0b
        mov               w0, w8
        ret

asm_test::swap::u8::release:
0:
        ldxrb             w8, [x0]
        stlxrb            w9, w1, [x0]
        cbnz              w9, 0b
        mov               w0, w8
        ret

asm_test::swap::u16::acqrel:
0:
        ldaxrh            w8, [x0]
        stlxrh            w9, w1, [x0]
        cbnz              w9, 0b
        mov               w0, w8
        ret

asm_test::swap::u16::seqcst:
0:
        ldaxrh            w8, [x0]
        stlxrh            w9, w1, [x0]
        cbnz              w9, 0b
        dmb               ish
        mov               w0, w8
        ret

asm_test::swap::u16::acquire:
0:
        ldaxrh            w8, [x0]
        stxrh             w9, w1, [x0]
        cbnz              w9, 0b
        mov               w0, w8
        ret

asm_test::swap::u16::relaxed:
0:
        ldxrh             w8, [x0]
        stxrh             w9, w1, [x0]
        cbnz              w9, 0b
        mov               w0, w8
        ret

asm_test::swap::u16::release:
0:
        ldxrh             w8, [x0]
        stlxrh            w9, w1, [x0]
        cbnz              w9, 0b
        mov               w0, w8
        ret

asm_test::swap::u32::acqrel:
0:
        ldaxr             w8, [x0]
        stlxr             w9, w1, [x0]
        cbnz              w9, 0b
        mov               w0, w8
        ret

asm_test::swap::u32::seqcst:
0:
        ldaxr             w8, [x0]
        stlxr             w9, w1, [x0]
        cbnz              w9, 0b
        dmb               ish
        mov               w0, w8
        ret

asm_test::swap::u32::acquire:
0:
        ldaxr             w8, [x0]
        stxr              w9, w1, [x0]
        cbnz              w9, 0b
        mov               w0, w8
        ret

asm_test::swap::u32::relaxed:
0:
        ldxr              w8, [x0]
        stxr              w9, w1, [x0]
        cbnz              w9, 0b
        mov               w0, w8
        ret

asm_test::swap::u32::release:
0:
        ldxr              w8, [x0]
        stlxr             w9, w1, [x0]
        cbnz              w9, 0b
        mov               w0, w8
        ret

asm_test::swap::u64::acqrel:
0:
        ldaxr             x8, [x0]
        stlxr             w9, x1, [x0]
        cbnz              w9, 0b
        mov               x0, x8
        ret

asm_test::swap::u64::seqcst:
0:
        ldaxr             x8, [x0]
        stlxr             w9, x1, [x0]
        cbnz              w9, 0b
        dmb               ish
        mov               x0, x8
        ret

asm_test::swap::u64::acquire:
0:
        ldaxr             x8, [x0]
        stxr              w9, x1, [x0]
        cbnz              w9, 0b
        mov               x0, x8
        ret

asm_test::swap::u64::relaxed:
0:
        ldxr              x8, [x0]
        stxr              w9, x1, [x0]
        cbnz              w9, 0b
        mov               x0, x8
        ret

asm_test::swap::u64::release:
0:
        ldxr              x8, [x0]
        stlxr             w9, x1, [x0]
        cbnz              w9, 0b
        mov               x0, x8
        ret

asm_test::swap::u128::acqrel:
0:
        ldaxp             x8, x1, [x0]
        stlxp             w9, x2, x3, [x0]
        cbnz              w9, 0b
        mov               x0, x8
        ret

asm_test::swap::u128::seqcst:
0:
        ldaxp             x8, x1, [x0]
        stlxp             w9, x2, x3, [x0]
        cbnz              w9, 0b
        dmb               ish
        mov               x0, x8
        ret

asm_test::swap::u128::acquire:
0:
        ldaxp             x8, x1, [x0]
        stxp              w9, x2, x3, [x0]
        cbnz              w9, 0b
        mov               x0, x8
        ret

asm_test::swap::u128::relaxed:
0:
        ldxp              x8, x1, [x0]
        stxp              w9, x2, x3, [x0]
        cbnz              w9, 0b
        mov               x0, x8
        ret

asm_test::swap::u128::release:
0:
        ldxp              x8, x1, [x0]
        stlxp             w9, x2, x3, [x0]
        cbnz              w9, 0b
        mov               x0, x8
        ret

asm_test::store::u8::seqcst:
        stlrb             w1, [x0]
        dmb               ish
        ret

asm_test::store::u8::relaxed:
        strb              w1, [x0]
        ret

asm_test::store::u8::release:
        stlrb             w1, [x0]
        ret

asm_test::store::u16::seqcst:
        stlrh             w1, [x0]
        dmb               ish
        ret

asm_test::store::u16::relaxed:
        strh              w1, [x0]
        ret

asm_test::store::u16::release:
        stlrh             w1, [x0]
        ret

asm_test::store::u32::seqcst:
        stlr              w1, [x0]
        dmb               ish
        ret

asm_test::store::u32::relaxed:
        str               w1, [x0]
        ret

asm_test::store::u32::release:
        stlr              w1, [x0]
        ret

asm_test::store::u64::seqcst:
        stlr              x1, [x0]
        dmb               ish
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
        stlxp             w8, x2, x3, [x0]
        cbnz              w8, 0b
        dmb               ish
        ret

asm_test::store::u128::relaxed:
0:
        ldxp              xzr, x8, [x0]
        stxp              w8, x2, x3, [x0]
        cbnz              w8, 0b
        ret

asm_test::store::u128::release:
0:
        ldxp              xzr, x8, [x0]
        stlxp             w8, x2, x3, [x0]
        cbnz              w8, 0b
        ret

