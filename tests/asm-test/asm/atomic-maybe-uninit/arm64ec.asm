.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x15, x5, x10, eq
        stlxp             w11, x12, x15, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

.text:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x15, x5, x10, eq
        stlxp             w11, x12, x15, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        dmb               ish
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

.text:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x15, x5, x10, eq
        stlxp             w11, x12, x15, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

.text:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x15, x5, x10, eq
        stlxp             w11, x12, x15, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

.text:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x15, x5, x10, eq
        stlxp             w11, x12, x15, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

.text:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x15, x5, x10, eq
        stlxp             w11, x12, x15, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

.text:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x15, x5, x10, eq
        stlxp             w11, x12, x15, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

.text:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x15, x5, x10, eq
        stlxp             w11, x12, x15, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        dmb               ish
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

.text:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x15, x5, x10, eq
        stlxp             w11, x12, x15, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        dmb               ish
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

.text:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x15, x5, x10, eq
        stxp              w11, x12, x15, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

.text:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x15, x5, x10, eq
        stxp              w11, x12, x15, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

.text:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x15, x5, x10, eq
        stxp              w11, x12, x15, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

.text:
0:
        ldxp              x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x15, x5, x10, eq
        stxp              w11, x12, x15, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

.text:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x15, x5, x10, eq
        stlxp             w11, x12, x15, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

.text:
0:
        ldxp              x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x15, x5, x10, eq
        stlxp             w11, x12, x15, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
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

.text:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x15, x5, x10, eq
        stlxp             w11, x12, x15, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

.text:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x15, x5, x10, eq
        stlxp             w11, x12, x15, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        dmb               ish
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

.text:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x15, x5, x10, eq
        stlxp             w11, x12, x15, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

.text:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x15, x5, x10, eq
        stlxp             w11, x12, x15, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

.text:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x15, x5, x10, eq
        stlxp             w11, x12, x15, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

.text:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x15, x5, x10, eq
        stlxp             w11, x12, x15, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

.text:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x15, x5, x10, eq
        stlxp             w11, x12, x15, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

.text:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x15, x5, x10, eq
        stlxp             w11, x12, x15, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        dmb               ish
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

.text:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x15, x5, x10, eq
        stlxp             w11, x12, x15, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        dmb               ish
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

.text:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x15, x5, x10, eq
        stxp              w11, x12, x15, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

.text:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x15, x5, x10, eq
        stxp              w11, x12, x15, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

.text:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x15, x5, x10, eq
        stxp              w11, x12, x15, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

.text:
0:
        ldxp              x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x15, x5, x10, eq
        stxp              w11, x12, x15, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

.text:
0:
        ldaxp             x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x15, x5, x10, eq
        stlxp             w11, x12, x15, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

.text:
0:
        ldxp              x9, x10, [x0]
        cmp               x9, x2
        ccmp              x10, x3, #0x0, eq
        csel              x12, x4, x9, eq
        csel              x15, x5, x10, eq
        stlxp             w11, x12, x15, [x0]
        cbnz              w11, 0b
        cset              w11, eq
        stp               x9, x10, [x8]
        strb              w11, [x8, #0x10]
        ret

.text:
        ldarb             w0, [x0]
        ret

.text:
        ldarb             w0, [x0]
        ret

.text:
        ldrb              w0, [x0]
        ret

.text:
        ldarh             w0, [x0]
        ret

.text:
        ldarh             w0, [x0]
        ret

.text:
        ldrh              w0, [x0]
        ret

.text:
        ldar              w0, [x0]
        ret

.text:
        ldar              w0, [x0]
        ret

.text:
        ldr               w0, [x0]
        ret

.text:
        ldar              x0, [x0]
        ret

.text:
        ldar              x0, [x0]
        ret

.text:
        ldr               x0, [x0]
        ret

.text:
0:
        ldaxp             x8, x1, [x0]
        stlxp             w9, x8, x1, [x0]
        cbnz              w9, 0b
        mov               x0, x8
        ret

.text:
0:
        ldaxp             x8, x1, [x0]
        stxp              w9, x8, x1, [x0]
        cbnz              w9, 0b
        mov               x0, x8
        ret

.text:
0:
        ldxp              x8, x1, [x0]
        stxp              w9, x8, x1, [x0]
        cbnz              w9, 0b
        mov               x0, x8
        ret

.text:
0:
        ldaxrb            w8, [x0]
        stlxrb            w9, w1, [x0]
        cbnz              w9, 0b
        mov               w0, w8
        ret

.text:
0:
        ldaxrb            w8, [x0]
        stlxrb            w9, w1, [x0]
        cbnz              w9, 0b
        dmb               ish
        mov               w0, w8
        ret

.text:
0:
        ldaxrb            w8, [x0]
        stxrb             w9, w1, [x0]
        cbnz              w9, 0b
        mov               w0, w8
        ret

.text:
0:
        ldxrb             w8, [x0]
        stxrb             w9, w1, [x0]
        cbnz              w9, 0b
        mov               w0, w8
        ret

.text:
0:
        ldxrb             w8, [x0]
        stlxrb            w9, w1, [x0]
        cbnz              w9, 0b
        mov               w0, w8
        ret

.text:
0:
        ldaxrh            w8, [x0]
        stlxrh            w9, w1, [x0]
        cbnz              w9, 0b
        mov               w0, w8
        ret

.text:
0:
        ldaxrh            w8, [x0]
        stlxrh            w9, w1, [x0]
        cbnz              w9, 0b
        dmb               ish
        mov               w0, w8
        ret

.text:
0:
        ldaxrh            w8, [x0]
        stxrh             w9, w1, [x0]
        cbnz              w9, 0b
        mov               w0, w8
        ret

.text:
0:
        ldxrh             w8, [x0]
        stxrh             w9, w1, [x0]
        cbnz              w9, 0b
        mov               w0, w8
        ret

.text:
0:
        ldxrh             w8, [x0]
        stlxrh            w9, w1, [x0]
        cbnz              w9, 0b
        mov               w0, w8
        ret

.text:
0:
        ldaxr             w8, [x0]
        stlxr             w9, w1, [x0]
        cbnz              w9, 0b
        mov               w0, w8
        ret

.text:
0:
        ldaxr             w8, [x0]
        stlxr             w9, w1, [x0]
        cbnz              w9, 0b
        dmb               ish
        mov               w0, w8
        ret

.text:
0:
        ldaxr             w8, [x0]
        stxr              w9, w1, [x0]
        cbnz              w9, 0b
        mov               w0, w8
        ret

.text:
0:
        ldxr              w8, [x0]
        stxr              w9, w1, [x0]
        cbnz              w9, 0b
        mov               w0, w8
        ret

.text:
0:
        ldxr              w8, [x0]
        stlxr             w9, w1, [x0]
        cbnz              w9, 0b
        mov               w0, w8
        ret

.text:
0:
        ldaxr             x8, [x0]
        stlxr             w9, x1, [x0]
        cbnz              w9, 0b
        mov               x0, x8
        ret

.text:
0:
        ldaxr             x8, [x0]
        stlxr             w9, x1, [x0]
        cbnz              w9, 0b
        dmb               ish
        mov               x0, x8
        ret

.text:
0:
        ldaxr             x8, [x0]
        stxr              w9, x1, [x0]
        cbnz              w9, 0b
        mov               x0, x8
        ret

.text:
0:
        ldxr              x8, [x0]
        stxr              w9, x1, [x0]
        cbnz              w9, 0b
        mov               x0, x8
        ret

.text:
0:
        ldxr              x8, [x0]
        stlxr             w9, x1, [x0]
        cbnz              w9, 0b
        mov               x0, x8
        ret

.text:
0:
        ldaxp             x8, x1, [x0]
        stlxp             w9, x2, x3, [x0]
        cbnz              w9, 0b
        mov               x0, x8
        ret

.text:
0:
        ldaxp             x8, x1, [x0]
        stlxp             w9, x2, x3, [x0]
        cbnz              w9, 0b
        dmb               ish
        mov               x0, x8
        ret

.text:
0:
        ldaxp             x8, x1, [x0]
        stxp              w9, x2, x3, [x0]
        cbnz              w9, 0b
        mov               x0, x8
        ret

.text:
0:
        ldxp              x8, x1, [x0]
        stxp              w9, x2, x3, [x0]
        cbnz              w9, 0b
        mov               x0, x8
        ret

.text:
0:
        ldxp              x8, x1, [x0]
        stlxp             w9, x2, x3, [x0]
        cbnz              w9, 0b
        mov               x0, x8
        ret

.text:
        stlrb             w1, [x0]
        dmb               ish
        ret

.text:
        strb              w1, [x0]
        ret

.text:
        stlrb             w1, [x0]
        ret

.text:
        stlrh             w1, [x0]
        dmb               ish
        ret

.text:
        strh              w1, [x0]
        ret

.text:
        stlrh             w1, [x0]
        ret

.text:
        stlr              w1, [x0]
        dmb               ish
        ret

.text:
        str               w1, [x0]
        ret

.text:
        stlr              w1, [x0]
        ret

.text:
        stlr              x1, [x0]
        dmb               ish
        ret

.text:
        str               x1, [x0]
        ret

.text:
        stlr              x1, [x0]
        ret

.text:
0:
        ldaxp             xzr, x8, [x0]
        stlxp             w8, x2, x3, [x0]
        cbnz              w8, 0b
        dmb               ish
        ret

.text:
0:
        ldxp              xzr, x8, [x0]
        stxp              w8, x2, x3, [x0]
        cbnz              w8, 0b
        ret

.text:
0:
        ldxp              xzr, x8, [x0]
        stlxp             w8, x2, x3, [x0]
        cbnz              w8, 0b
        ret

.wowthk$aa:
        sub               sp, sp, #0xc0
        stp               q6, q7, [sp, #0x10]
        stp               q8, q9, [sp, #0x30]
        stp               q10, q11, [sp, #0x50]
        stp               q12, q13, [sp, #0x70]
        stp               q14, q15, [sp, #0x90]
        stp               x29, x30, [sp, #0xb0]
        add               x29, sp, #0xb0
        blr               x9
        and               w8, w1, #0x1
        adrp              x9, 0x0 <.wowthk$aa>
        strb              w0, [sp, #0xe]
        strb              w8, [sp, #0xf]
        ldrh              w8, [sp, #0xe]
        ldr               x0, [x9]
        ldp               x29, x30, [sp, #0xb0]
        ldp               q14, q15, [sp, #0x90]
        ldp               q12, q13, [sp, #0x70]
        ldp               q10, q11, [sp, #0x50]
        ldp               q8, q9, [sp, #0x30]
        ldp               q6, q7, [sp, #0x10]
        add               sp, sp, #0xc0
        br                x0

.wowthk$aa:
        sub               sp, sp, #0xc0
        stp               q6, q7, [sp, #0x10]
        stp               q8, q9, [sp, #0x30]
        stp               q10, q11, [sp, #0x50]
        stp               q12, q13, [sp, #0x70]
        stp               q14, q15, [sp, #0x90]
        stp               x29, x30, [sp, #0xb0]
        add               x29, sp, #0xb0
        blr               x9
        and               w8, w1, #0x1
        adrp              x9, 0x0 <.wowthk$aa>
        strh              w0, [sp, #0xc]
        strb              w8, [sp, #0xe]
        ldr               w8, [sp, #0xc]
        ldr               x0, [x9]
        ldp               x29, x30, [sp, #0xb0]
        ldp               q14, q15, [sp, #0x90]
        ldp               q12, q13, [sp, #0x70]
        ldp               q10, q11, [sp, #0x50]
        ldp               q8, q9, [sp, #0x30]
        ldp               q6, q7, [sp, #0x10]
        add               sp, sp, #0xc0
        br                x0

.wowthk$aa:
        sub               sp, sp, #0xc0
        stp               q6, q7, [sp, #0x10]
        stp               q8, q9, [sp, #0x30]
        stp               q10, q11, [sp, #0x50]
        stp               q12, q13, [sp, #0x70]
        stp               q14, q15, [sp, #0x90]
        stp               x29, x30, [sp, #0xb0]
        add               x29, sp, #0xb0
        blr               x9
        and               w8, w1, #0x1
        adrp              x9, 0x0 <.wowthk$aa>
        str               w0, [sp, #0x8]
        strb              w8, [sp, #0xc]
        ldr               x8, [sp, #0x8]
        ldr               x0, [x9]
        ldp               x29, x30, [sp, #0xb0]
        ldp               q14, q15, [sp, #0x90]
        ldp               q12, q13, [sp, #0x70]
        ldp               q10, q11, [sp, #0x50]
        ldp               q8, q9, [sp, #0x30]
        ldp               q6, q7, [sp, #0x10]
        add               sp, sp, #0xc0
        br                x0

.wowthk$aa:
        stp               q6, q7, [sp, #-0xc0]!
        stp               q8, q9, [sp, #0x20]
        stp               q10, q11, [sp, #0x40]
        stp               q12, q13, [sp, #0x60]
        stp               q14, q15, [sp, #0x80]
        str               x19, [sp, #0xa0]
        stp               x29, x30, [sp, #0xa8]
        add               x29, sp, #0xa8
        mov               x19, x0
        mov               x0, x1
        mov               x1, x2
        mov               x2, x3
        blr               x9
        and               w9, w1, #0x1
        adrp              x8, 0x0 <.wowthk$aa>
        str               x0, [x19]
        strb              w9, [x19, #0x8]
        ldr               x0, [x8]
        ldp               x29, x30, [sp, #0xa8]
        ldr               x19, [sp, #0xa0]
        ldp               q14, q15, [sp, #0x80]
        ldp               q12, q13, [sp, #0x60]
        ldp               q10, q11, [sp, #0x40]
        ldp               q8, q9, [sp, #0x20]
        ldp               q6, q7, [sp], #0xc0
        br                x0

.wowthk$aa:
        stp               q6, q7, [sp, #-0xc0]!
        stp               q8, q9, [sp, #0x20]
        stp               q10, q11, [sp, #0x40]
        stp               q12, q13, [sp, #0x60]
        stp               q14, q15, [sp, #0x80]
        str               x19, [sp, #0xa0]
        stp               x29, x30, [sp, #0xa8]
        add               x29, sp, #0xa8
        ldp               x2, x10, [x2]
        mov               x19, x0
        ldp               x4, x5, [x3]
        mov               x8, x0
        mov               x0, x1
        mov               x3, x10
        blr               x9
        adrp              x8, 0x0 <.wowthk$aa>
        ldr               x0, [x8]
        mov               x8, x19
        ldp               x29, x30, [sp, #0xa8]
        ldr               x19, [sp, #0xa0]
        ldp               q14, q15, [sp, #0x80]
        ldp               q12, q13, [sp, #0x60]
        ldp               q10, q11, [sp, #0x40]
        ldp               q8, q9, [sp, #0x20]
        ldp               q6, q7, [sp], #0xc0
        br                x0

.wowthk$aa:
        stp               q6, q7, [sp, #-0xb0]!
        stp               q8, q9, [sp, #0x20]
        stp               q10, q11, [sp, #0x40]
        stp               q12, q13, [sp, #0x60]
        stp               q14, q15, [sp, #0x80]
        stp               x29, x30, [sp, #0xa0]
        add               x29, sp, #0xa0
        blr               x9
        adrp              x8, 0x0 <.wowthk$aa>
        ldr               x1, [x8]
        mov               x8, x0
        ldp               x29, x30, [sp, #0xa0]
        ldp               q14, q15, [sp, #0x80]
        ldp               q12, q13, [sp, #0x60]
        ldp               q10, q11, [sp, #0x40]
        ldp               q8, q9, [sp, #0x20]
        ldp               q6, q7, [sp], #0xb0
        br                x1

.wowthk$aa:
        stp               q6, q7, [sp, #-0xc0]!
        stp               q8, q9, [sp, #0x20]
        stp               q10, q11, [sp, #0x40]
        stp               q12, q13, [sp, #0x60]
        stp               q14, q15, [sp, #0x80]
        str               x19, [sp, #0xa0]
        stp               x29, x30, [sp, #0xa8]
        add               x29, sp, #0xa8
        mov               x19, x0
        mov               x0, x1
        blr               x9
        adrp              x8, 0x0 <.wowthk$aa>
        stp               x0, x1, [x19]
        ldr               x0, [x8]
        ldp               x29, x30, [sp, #0xa8]
        ldr               x19, [sp, #0xa0]
        ldp               q14, q15, [sp, #0x80]
        ldp               q12, q13, [sp, #0x60]
        ldp               q10, q11, [sp, #0x40]
        ldp               q8, q9, [sp, #0x20]
        ldp               q6, q7, [sp], #0xc0
        br                x0

.wowthk$aa:
        stp               q6, q7, [sp, #-0xb0]!
        stp               q8, q9, [sp, #0x20]
        stp               q10, q11, [sp, #0x40]
        stp               q12, q13, [sp, #0x60]
        stp               q14, q15, [sp, #0x80]
        stp               x29, x30, [sp, #0xa0]
        add               x29, sp, #0xa0
        blr               x9
        adrp              x8, 0x0 <.wowthk$aa>
        ldr               x1, [x8]
        mov               x8, x0
        ldp               x29, x30, [sp, #0xa0]
        ldp               q14, q15, [sp, #0x80]
        ldp               q12, q13, [sp, #0x60]
        ldp               q10, q11, [sp, #0x40]
        ldp               q8, q9, [sp, #0x20]
        ldp               q6, q7, [sp], #0xb0
        br                x1

.wowthk$aa:
        stp               q6, q7, [sp, #-0xc0]!
        stp               q8, q9, [sp, #0x20]
        stp               q10, q11, [sp, #0x40]
        stp               q12, q13, [sp, #0x60]
        stp               q14, q15, [sp, #0x80]
        str               x19, [sp, #0xa0]
        stp               x29, x30, [sp, #0xa8]
        add               x29, sp, #0xa8
        ldp               x2, x3, [x2]
        mov               x19, x0
        mov               x0, x1
        blr               x9
        adrp              x8, 0x0 <.wowthk$aa>
        stp               x0, x1, [x19]
        ldr               x0, [x8]
        ldp               x29, x30, [sp, #0xa8]
        ldr               x19, [sp, #0xa0]
        ldp               q14, q15, [sp, #0x80]
        ldp               q12, q13, [sp, #0x60]
        ldp               q10, q11, [sp, #0x40]
        ldp               q8, q9, [sp, #0x20]
        ldp               q6, q7, [sp], #0xc0
        br                x0

.wowthk$aa:
        stp               q6, q7, [sp, #-0xb0]!
        stp               q8, q9, [sp, #0x20]
        stp               q10, q11, [sp, #0x40]
        stp               q12, q13, [sp, #0x60]
        stp               q14, q15, [sp, #0x80]
        stp               x29, x30, [sp, #0xa0]
        add               x29, sp, #0xa0
        blr               x9
        adrp              x8, 0x0 <.wowthk$aa>
        ldr               x0, [x8]
        ldp               x29, x30, [sp, #0xa0]
        ldp               q14, q15, [sp, #0x80]
        ldp               q12, q13, [sp, #0x60]
        ldp               q10, q11, [sp, #0x40]
        ldp               q8, q9, [sp, #0x20]
        ldp               q6, q7, [sp], #0xb0
        br                x0

.wowthk$aa:
        stp               q6, q7, [sp, #-0xb0]!
        stp               q8, q9, [sp, #0x20]
        stp               q10, q11, [sp, #0x40]
        stp               q12, q13, [sp, #0x60]
        stp               q14, q15, [sp, #0x80]
        stp               x29, x30, [sp, #0xa0]
        add               x29, sp, #0xa0
        ldp               x2, x3, [x1]
        blr               x9
        adrp              x8, 0x0 <.wowthk$aa>
        ldr               x0, [x8]
        ldp               x29, x30, [sp, #0xa0]
        ldp               q14, q15, [sp, #0x80]
        ldp               q12, q13, [sp, #0x60]
        ldp               q10, q11, [sp, #0x40]
        ldp               q8, q9, [sp, #0x20]
        ldp               q6, q7, [sp], #0xb0
        br                x0

