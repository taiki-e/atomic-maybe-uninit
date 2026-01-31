asm_test::compare_exchange::u8::acqrel_seqcst:
        movw              r30, r24
        in                r25, 0x3f	; 63
        cli
        ld                r24, Z
        eor               r22, r24
0:
        brne              0f
        st                Z, r20
        out               0x3f, r25	; 63
        ldi               r25, 0x01	; 1
        cpi               r22, 0x00	; 0
1:
        breq              1f
        mov               r25, r1
        ret

asm_test::compare_exchange::u8::seqcst_seqcst:
        movw              r30, r24
        in                r25, 0x3f	; 63
        cli
        ld                r24, Z
        eor               r22, r24
0:
        brne              0f
        st                Z, r20
        out               0x3f, r25	; 63
        ldi               r25, 0x01	; 1
        cpi               r22, 0x00	; 0
1:
        breq              1f
        mov               r25, r1
        ret

asm_test::compare_exchange::u8::acqrel_acquire:
        movw              r30, r24
        in                r25, 0x3f	; 63
        cli
        ld                r24, Z
        eor               r22, r24
0:
        brne              0f
        st                Z, r20
        out               0x3f, r25	; 63
        ldi               r25, 0x01	; 1
        cpi               r22, 0x00	; 0
1:
        breq              1f
        mov               r25, r1
        ret

asm_test::compare_exchange::u8::acqrel_relaxed:
        movw              r30, r24
        in                r25, 0x3f	; 63
        cli
        ld                r24, Z
        eor               r22, r24
0:
        brne              0f
        st                Z, r20
        out               0x3f, r25	; 63
        ldi               r25, 0x01	; 1
        cpi               r22, 0x00	; 0
1:
        breq              1f
        mov               r25, r1
        ret

asm_test::compare_exchange::u8::acquire_seqcst:
        movw              r30, r24
        in                r25, 0x3f	; 63
        cli
        ld                r24, Z
        eor               r22, r24
0:
        brne              0f
        st                Z, r20
        out               0x3f, r25	; 63
        ldi               r25, 0x01	; 1
        cpi               r22, 0x00	; 0
1:
        breq              1f
        mov               r25, r1
        ret

asm_test::compare_exchange::u8::relaxed_seqcst:
        movw              r30, r24
        in                r25, 0x3f	; 63
        cli
        ld                r24, Z
        eor               r22, r24
0:
        brne              0f
        st                Z, r20
        out               0x3f, r25	; 63
        ldi               r25, 0x01	; 1
        cpi               r22, 0x00	; 0
1:
        breq              1f
        mov               r25, r1
        ret

asm_test::compare_exchange::u8::release_seqcst:
        movw              r30, r24
        in                r25, 0x3f	; 63
        cli
        ld                r24, Z
        eor               r22, r24
0:
        brne              0f
        st                Z, r20
        out               0x3f, r25	; 63
        ldi               r25, 0x01	; 1
        cpi               r22, 0x00	; 0
1:
        breq              1f
        mov               r25, r1
        ret

asm_test::compare_exchange::u8::seqcst_acquire:
        movw              r30, r24
        in                r25, 0x3f	; 63
        cli
        ld                r24, Z
        eor               r22, r24
0:
        brne              0f
        st                Z, r20
        out               0x3f, r25	; 63
        ldi               r25, 0x01	; 1
        cpi               r22, 0x00	; 0
1:
        breq              1f
        mov               r25, r1
        ret

asm_test::compare_exchange::u8::seqcst_relaxed:
        movw              r30, r24
        in                r25, 0x3f	; 63
        cli
        ld                r24, Z
        eor               r22, r24
0:
        brne              0f
        st                Z, r20
        out               0x3f, r25	; 63
        ldi               r25, 0x01	; 1
        cpi               r22, 0x00	; 0
1:
        breq              1f
        mov               r25, r1
        ret

asm_test::compare_exchange::u8::acquire_acquire:
        movw              r30, r24
        in                r25, 0x3f	; 63
        cli
        ld                r24, Z
        eor               r22, r24
0:
        brne              0f
        st                Z, r20
        out               0x3f, r25	; 63
        ldi               r25, 0x01	; 1
        cpi               r22, 0x00	; 0
1:
        breq              1f
        mov               r25, r1
        ret

asm_test::compare_exchange::u8::acquire_relaxed:
        movw              r30, r24
        in                r25, 0x3f	; 63
        cli
        ld                r24, Z
        eor               r22, r24
0:
        brne              0f
        st                Z, r20
        out               0x3f, r25	; 63
        ldi               r25, 0x01	; 1
        cpi               r22, 0x00	; 0
1:
        breq              1f
        mov               r25, r1
        ret

asm_test::compare_exchange::u8::relaxed_acquire:
        movw              r30, r24
        in                r25, 0x3f	; 63
        cli
        ld                r24, Z
        eor               r22, r24
0:
        brne              0f
        st                Z, r20
        out               0x3f, r25	; 63
        ldi               r25, 0x01	; 1
        cpi               r22, 0x00	; 0
1:
        breq              1f
        mov               r25, r1
        ret

asm_test::compare_exchange::u8::relaxed_relaxed:
        movw              r30, r24
        in                r25, 0x3f	; 63
        cli
        ld                r24, Z
        eor               r22, r24
0:
        brne              0f
        st                Z, r20
        out               0x3f, r25	; 63
        ldi               r25, 0x01	; 1
        cpi               r22, 0x00	; 0
1:
        breq              1f
        mov               r25, r1
        ret

asm_test::compare_exchange::u8::release_acquire:
        movw              r30, r24
        in                r25, 0x3f	; 63
        cli
        ld                r24, Z
        eor               r22, r24
0:
        brne              0f
        st                Z, r20
        out               0x3f, r25	; 63
        ldi               r25, 0x01	; 1
        cpi               r22, 0x00	; 0
1:
        breq              1f
        mov               r25, r1
        ret

asm_test::compare_exchange::u8::release_relaxed:
        movw              r30, r24
        in                r25, 0x3f	; 63
        cli
        ld                r24, Z
        eor               r22, r24
0:
        brne              0f
        st                Z, r20
        out               0x3f, r25	; 63
        ldi               r25, 0x01	; 1
        cpi               r22, 0x00	; 0
1:
        breq              1f
        mov               r25, r1
        ret

asm_test::compare_exchange::u16::acqrel_seqcst:
        movw              r18, r22
        in                r26, 0x3f	; 63
        cli
        movw              r30, r24
        ld                r22, Z
        ldd               r23, Z+1	; 0x01
        eor               r18, r22
        eor               r19, r23
        or                r19, r18
        cpi               r19, 0x00	; 0
0:
        breq              0f
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
1:
        brne              1f
        ret
        movw              r30, r24
        std               Z+1, r21	; 0x01
        st                Z, r20
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r1
        ret

asm_test::compare_exchange::u16::seqcst_seqcst:
        movw              r18, r22
        in                r26, 0x3f	; 63
        cli
        movw              r30, r24
        ld                r22, Z
        ldd               r23, Z+1	; 0x01
        eor               r18, r22
        eor               r19, r23
        or                r19, r18
        cpi               r19, 0x00	; 0
0:
        breq              0f
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
1:
        brne              1f
        ret
        movw              r30, r24
        std               Z+1, r21	; 0x01
        st                Z, r20
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r1
        ret

asm_test::compare_exchange::u16::acqrel_acquire:
        movw              r18, r22
        in                r26, 0x3f	; 63
        cli
        movw              r30, r24
        ld                r22, Z
        ldd               r23, Z+1	; 0x01
        eor               r18, r22
        eor               r19, r23
        or                r19, r18
        cpi               r19, 0x00	; 0
0:
        breq              0f
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
1:
        brne              1f
        ret
        movw              r30, r24
        std               Z+1, r21	; 0x01
        st                Z, r20
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r1
        ret

asm_test::compare_exchange::u16::acqrel_relaxed:
        movw              r18, r22
        in                r26, 0x3f	; 63
        cli
        movw              r30, r24
        ld                r22, Z
        ldd               r23, Z+1	; 0x01
        eor               r18, r22
        eor               r19, r23
        or                r19, r18
        cpi               r19, 0x00	; 0
0:
        breq              0f
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
1:
        brne              1f
        ret
        movw              r30, r24
        std               Z+1, r21	; 0x01
        st                Z, r20
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r1
        ret

asm_test::compare_exchange::u16::acquire_seqcst:
        movw              r18, r22
        in                r26, 0x3f	; 63
        cli
        movw              r30, r24
        ld                r22, Z
        ldd               r23, Z+1	; 0x01
        eor               r18, r22
        eor               r19, r23
        or                r19, r18
        cpi               r19, 0x00	; 0
0:
        breq              0f
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
1:
        brne              1f
        ret
        movw              r30, r24
        std               Z+1, r21	; 0x01
        st                Z, r20
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r1
        ret

asm_test::compare_exchange::u16::relaxed_seqcst:
        movw              r18, r22
        in                r26, 0x3f	; 63
        cli
        movw              r30, r24
        ld                r22, Z
        ldd               r23, Z+1	; 0x01
        eor               r18, r22
        eor               r19, r23
        or                r19, r18
        cpi               r19, 0x00	; 0
0:
        breq              0f
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
1:
        brne              1f
        ret
        movw              r30, r24
        std               Z+1, r21	; 0x01
        st                Z, r20
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r1
        ret

asm_test::compare_exchange::u16::release_seqcst:
        movw              r18, r22
        in                r26, 0x3f	; 63
        cli
        movw              r30, r24
        ld                r22, Z
        ldd               r23, Z+1	; 0x01
        eor               r18, r22
        eor               r19, r23
        or                r19, r18
        cpi               r19, 0x00	; 0
0:
        breq              0f
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
1:
        brne              1f
        ret
        movw              r30, r24
        std               Z+1, r21	; 0x01
        st                Z, r20
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r1
        ret

asm_test::compare_exchange::u16::seqcst_acquire:
        movw              r18, r22
        in                r26, 0x3f	; 63
        cli
        movw              r30, r24
        ld                r22, Z
        ldd               r23, Z+1	; 0x01
        eor               r18, r22
        eor               r19, r23
        or                r19, r18
        cpi               r19, 0x00	; 0
0:
        breq              0f
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
1:
        brne              1f
        ret
        movw              r30, r24
        std               Z+1, r21	; 0x01
        st                Z, r20
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r1
        ret

asm_test::compare_exchange::u16::seqcst_relaxed:
        movw              r18, r22
        in                r26, 0x3f	; 63
        cli
        movw              r30, r24
        ld                r22, Z
        ldd               r23, Z+1	; 0x01
        eor               r18, r22
        eor               r19, r23
        or                r19, r18
        cpi               r19, 0x00	; 0
0:
        breq              0f
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
1:
        brne              1f
        ret
        movw              r30, r24
        std               Z+1, r21	; 0x01
        st                Z, r20
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r1
        ret

asm_test::compare_exchange::u16::acquire_acquire:
        movw              r18, r22
        in                r26, 0x3f	; 63
        cli
        movw              r30, r24
        ld                r22, Z
        ldd               r23, Z+1	; 0x01
        eor               r18, r22
        eor               r19, r23
        or                r19, r18
        cpi               r19, 0x00	; 0
0:
        breq              0f
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
1:
        brne              1f
        ret
        movw              r30, r24
        std               Z+1, r21	; 0x01
        st                Z, r20
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r1
        ret

asm_test::compare_exchange::u16::acquire_relaxed:
        movw              r18, r22
        in                r26, 0x3f	; 63
        cli
        movw              r30, r24
        ld                r22, Z
        ldd               r23, Z+1	; 0x01
        eor               r18, r22
        eor               r19, r23
        or                r19, r18
        cpi               r19, 0x00	; 0
0:
        breq              0f
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
1:
        brne              1f
        ret
        movw              r30, r24
        std               Z+1, r21	; 0x01
        st                Z, r20
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r1
        ret

asm_test::compare_exchange::u16::relaxed_acquire:
        movw              r18, r22
        in                r26, 0x3f	; 63
        cli
        movw              r30, r24
        ld                r22, Z
        ldd               r23, Z+1	; 0x01
        eor               r18, r22
        eor               r19, r23
        or                r19, r18
        cpi               r19, 0x00	; 0
0:
        breq              0f
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
1:
        brne              1f
        ret
        movw              r30, r24
        std               Z+1, r21	; 0x01
        st                Z, r20
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r1
        ret

asm_test::compare_exchange::u16::relaxed_relaxed:
        movw              r18, r22
        in                r26, 0x3f	; 63
        cli
        movw              r30, r24
        ld                r22, Z
        ldd               r23, Z+1	; 0x01
        eor               r18, r22
        eor               r19, r23
        or                r19, r18
        cpi               r19, 0x00	; 0
0:
        breq              0f
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
1:
        brne              1f
        ret
        movw              r30, r24
        std               Z+1, r21	; 0x01
        st                Z, r20
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r1
        ret

asm_test::compare_exchange::u16::release_acquire:
        movw              r18, r22
        in                r26, 0x3f	; 63
        cli
        movw              r30, r24
        ld                r22, Z
        ldd               r23, Z+1	; 0x01
        eor               r18, r22
        eor               r19, r23
        or                r19, r18
        cpi               r19, 0x00	; 0
0:
        breq              0f
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
1:
        brne              1f
        ret
        movw              r30, r24
        std               Z+1, r21	; 0x01
        st                Z, r20
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r1
        ret

asm_test::compare_exchange::u16::release_relaxed:
        movw              r18, r22
        in                r26, 0x3f	; 63
        cli
        movw              r30, r24
        ld                r22, Z
        ldd               r23, Z+1	; 0x01
        eor               r18, r22
        eor               r19, r23
        or                r19, r18
        cpi               r19, 0x00	; 0
0:
        breq              0f
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
1:
        brne              1f
        ret
        movw              r30, r24
        std               Z+1, r21	; 0x01
        st                Z, r20
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r1
        ret

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        movw              r30, r24
        in                r25, 0x3f	; 63
        cli
        ld                r24, Z
        eor               r22, r24
0:
        brne              0f
        st                Z, r20
        out               0x3f, r25	; 63
        ldi               r25, 0x01	; 1
        cpi               r22, 0x00	; 0
1:
        breq              1f
        mov               r25, r1
        ret

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        movw              r30, r24
        in                r25, 0x3f	; 63
        cli
        ld                r24, Z
        eor               r22, r24
0:
        brne              0f
        st                Z, r20
        out               0x3f, r25	; 63
        ldi               r25, 0x01	; 1
        cpi               r22, 0x00	; 0
1:
        breq              1f
        mov               r25, r1
        ret

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        movw              r30, r24
        in                r25, 0x3f	; 63
        cli
        ld                r24, Z
        eor               r22, r24
0:
        brne              0f
        st                Z, r20
        out               0x3f, r25	; 63
        ldi               r25, 0x01	; 1
        cpi               r22, 0x00	; 0
1:
        breq              1f
        mov               r25, r1
        ret

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        movw              r30, r24
        in                r25, 0x3f	; 63
        cli
        ld                r24, Z
        eor               r22, r24
0:
        brne              0f
        st                Z, r20
        out               0x3f, r25	; 63
        ldi               r25, 0x01	; 1
        cpi               r22, 0x00	; 0
1:
        breq              1f
        mov               r25, r1
        ret

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        movw              r30, r24
        in                r25, 0x3f	; 63
        cli
        ld                r24, Z
        eor               r22, r24
0:
        brne              0f
        st                Z, r20
        out               0x3f, r25	; 63
        ldi               r25, 0x01	; 1
        cpi               r22, 0x00	; 0
1:
        breq              1f
        mov               r25, r1
        ret

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        movw              r30, r24
        in                r25, 0x3f	; 63
        cli
        ld                r24, Z
        eor               r22, r24
0:
        brne              0f
        st                Z, r20
        out               0x3f, r25	; 63
        ldi               r25, 0x01	; 1
        cpi               r22, 0x00	; 0
1:
        breq              1f
        mov               r25, r1
        ret

asm_test::compare_exchange_weak::u8::release_seqcst:
        movw              r30, r24
        in                r25, 0x3f	; 63
        cli
        ld                r24, Z
        eor               r22, r24
0:
        brne              0f
        st                Z, r20
        out               0x3f, r25	; 63
        ldi               r25, 0x01	; 1
        cpi               r22, 0x00	; 0
1:
        breq              1f
        mov               r25, r1
        ret

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        movw              r30, r24
        in                r25, 0x3f	; 63
        cli
        ld                r24, Z
        eor               r22, r24
0:
        brne              0f
        st                Z, r20
        out               0x3f, r25	; 63
        ldi               r25, 0x01	; 1
        cpi               r22, 0x00	; 0
1:
        breq              1f
        mov               r25, r1
        ret

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        movw              r30, r24
        in                r25, 0x3f	; 63
        cli
        ld                r24, Z
        eor               r22, r24
0:
        brne              0f
        st                Z, r20
        out               0x3f, r25	; 63
        ldi               r25, 0x01	; 1
        cpi               r22, 0x00	; 0
1:
        breq              1f
        mov               r25, r1
        ret

asm_test::compare_exchange_weak::u8::acquire_acquire:
        movw              r30, r24
        in                r25, 0x3f	; 63
        cli
        ld                r24, Z
        eor               r22, r24
0:
        brne              0f
        st                Z, r20
        out               0x3f, r25	; 63
        ldi               r25, 0x01	; 1
        cpi               r22, 0x00	; 0
1:
        breq              1f
        mov               r25, r1
        ret

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        movw              r30, r24
        in                r25, 0x3f	; 63
        cli
        ld                r24, Z
        eor               r22, r24
0:
        brne              0f
        st                Z, r20
        out               0x3f, r25	; 63
        ldi               r25, 0x01	; 1
        cpi               r22, 0x00	; 0
1:
        breq              1f
        mov               r25, r1
        ret

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        movw              r30, r24
        in                r25, 0x3f	; 63
        cli
        ld                r24, Z
        eor               r22, r24
0:
        brne              0f
        st                Z, r20
        out               0x3f, r25	; 63
        ldi               r25, 0x01	; 1
        cpi               r22, 0x00	; 0
1:
        breq              1f
        mov               r25, r1
        ret

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        movw              r30, r24
        in                r25, 0x3f	; 63
        cli
        ld                r24, Z
        eor               r22, r24
0:
        brne              0f
        st                Z, r20
        out               0x3f, r25	; 63
        ldi               r25, 0x01	; 1
        cpi               r22, 0x00	; 0
1:
        breq              1f
        mov               r25, r1
        ret

asm_test::compare_exchange_weak::u8::release_acquire:
        movw              r30, r24
        in                r25, 0x3f	; 63
        cli
        ld                r24, Z
        eor               r22, r24
0:
        brne              0f
        st                Z, r20
        out               0x3f, r25	; 63
        ldi               r25, 0x01	; 1
        cpi               r22, 0x00	; 0
1:
        breq              1f
        mov               r25, r1
        ret

asm_test::compare_exchange_weak::u8::release_relaxed:
        movw              r30, r24
        in                r25, 0x3f	; 63
        cli
        ld                r24, Z
        eor               r22, r24
0:
        brne              0f
        st                Z, r20
        out               0x3f, r25	; 63
        ldi               r25, 0x01	; 1
        cpi               r22, 0x00	; 0
1:
        breq              1f
        mov               r25, r1
        ret

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        movw              r18, r22
        in                r26, 0x3f	; 63
        cli
        movw              r30, r24
        ld                r22, Z
        ldd               r23, Z+1	; 0x01
        eor               r18, r22
        eor               r19, r23
        or                r19, r18
        cpi               r19, 0x00	; 0
0:
        breq              0f
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
1:
        brne              1f
        ret
        movw              r30, r24
        std               Z+1, r21	; 0x01
        st                Z, r20
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r1
        ret

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        movw              r18, r22
        in                r26, 0x3f	; 63
        cli
        movw              r30, r24
        ld                r22, Z
        ldd               r23, Z+1	; 0x01
        eor               r18, r22
        eor               r19, r23
        or                r19, r18
        cpi               r19, 0x00	; 0
0:
        breq              0f
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
1:
        brne              1f
        ret
        movw              r30, r24
        std               Z+1, r21	; 0x01
        st                Z, r20
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r1
        ret

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        movw              r18, r22
        in                r26, 0x3f	; 63
        cli
        movw              r30, r24
        ld                r22, Z
        ldd               r23, Z+1	; 0x01
        eor               r18, r22
        eor               r19, r23
        or                r19, r18
        cpi               r19, 0x00	; 0
0:
        breq              0f
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
1:
        brne              1f
        ret
        movw              r30, r24
        std               Z+1, r21	; 0x01
        st                Z, r20
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r1
        ret

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        movw              r18, r22
        in                r26, 0x3f	; 63
        cli
        movw              r30, r24
        ld                r22, Z
        ldd               r23, Z+1	; 0x01
        eor               r18, r22
        eor               r19, r23
        or                r19, r18
        cpi               r19, 0x00	; 0
0:
        breq              0f
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
1:
        brne              1f
        ret
        movw              r30, r24
        std               Z+1, r21	; 0x01
        st                Z, r20
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r1
        ret

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        movw              r18, r22
        in                r26, 0x3f	; 63
        cli
        movw              r30, r24
        ld                r22, Z
        ldd               r23, Z+1	; 0x01
        eor               r18, r22
        eor               r19, r23
        or                r19, r18
        cpi               r19, 0x00	; 0
0:
        breq              0f
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
1:
        brne              1f
        ret
        movw              r30, r24
        std               Z+1, r21	; 0x01
        st                Z, r20
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r1
        ret

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        movw              r18, r22
        in                r26, 0x3f	; 63
        cli
        movw              r30, r24
        ld                r22, Z
        ldd               r23, Z+1	; 0x01
        eor               r18, r22
        eor               r19, r23
        or                r19, r18
        cpi               r19, 0x00	; 0
0:
        breq              0f
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
1:
        brne              1f
        ret
        movw              r30, r24
        std               Z+1, r21	; 0x01
        st                Z, r20
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r1
        ret

asm_test::compare_exchange_weak::u16::release_seqcst:
        movw              r18, r22
        in                r26, 0x3f	; 63
        cli
        movw              r30, r24
        ld                r22, Z
        ldd               r23, Z+1	; 0x01
        eor               r18, r22
        eor               r19, r23
        or                r19, r18
        cpi               r19, 0x00	; 0
0:
        breq              0f
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
1:
        brne              1f
        ret
        movw              r30, r24
        std               Z+1, r21	; 0x01
        st                Z, r20
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r1
        ret

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        movw              r18, r22
        in                r26, 0x3f	; 63
        cli
        movw              r30, r24
        ld                r22, Z
        ldd               r23, Z+1	; 0x01
        eor               r18, r22
        eor               r19, r23
        or                r19, r18
        cpi               r19, 0x00	; 0
0:
        breq              0f
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
1:
        brne              1f
        ret
        movw              r30, r24
        std               Z+1, r21	; 0x01
        st                Z, r20
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r1
        ret

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        movw              r18, r22
        in                r26, 0x3f	; 63
        cli
        movw              r30, r24
        ld                r22, Z
        ldd               r23, Z+1	; 0x01
        eor               r18, r22
        eor               r19, r23
        or                r19, r18
        cpi               r19, 0x00	; 0
0:
        breq              0f
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
1:
        brne              1f
        ret
        movw              r30, r24
        std               Z+1, r21	; 0x01
        st                Z, r20
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r1
        ret

asm_test::compare_exchange_weak::u16::acquire_acquire:
        movw              r18, r22
        in                r26, 0x3f	; 63
        cli
        movw              r30, r24
        ld                r22, Z
        ldd               r23, Z+1	; 0x01
        eor               r18, r22
        eor               r19, r23
        or                r19, r18
        cpi               r19, 0x00	; 0
0:
        breq              0f
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
1:
        brne              1f
        ret
        movw              r30, r24
        std               Z+1, r21	; 0x01
        st                Z, r20
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r1
        ret

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        movw              r18, r22
        in                r26, 0x3f	; 63
        cli
        movw              r30, r24
        ld                r22, Z
        ldd               r23, Z+1	; 0x01
        eor               r18, r22
        eor               r19, r23
        or                r19, r18
        cpi               r19, 0x00	; 0
0:
        breq              0f
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
1:
        brne              1f
        ret
        movw              r30, r24
        std               Z+1, r21	; 0x01
        st                Z, r20
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r1
        ret

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        movw              r18, r22
        in                r26, 0x3f	; 63
        cli
        movw              r30, r24
        ld                r22, Z
        ldd               r23, Z+1	; 0x01
        eor               r18, r22
        eor               r19, r23
        or                r19, r18
        cpi               r19, 0x00	; 0
0:
        breq              0f
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
1:
        brne              1f
        ret
        movw              r30, r24
        std               Z+1, r21	; 0x01
        st                Z, r20
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r1
        ret

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        movw              r18, r22
        in                r26, 0x3f	; 63
        cli
        movw              r30, r24
        ld                r22, Z
        ldd               r23, Z+1	; 0x01
        eor               r18, r22
        eor               r19, r23
        or                r19, r18
        cpi               r19, 0x00	; 0
0:
        breq              0f
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
1:
        brne              1f
        ret
        movw              r30, r24
        std               Z+1, r21	; 0x01
        st                Z, r20
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r1
        ret

asm_test::compare_exchange_weak::u16::release_acquire:
        movw              r18, r22
        in                r26, 0x3f	; 63
        cli
        movw              r30, r24
        ld                r22, Z
        ldd               r23, Z+1	; 0x01
        eor               r18, r22
        eor               r19, r23
        or                r19, r18
        cpi               r19, 0x00	; 0
0:
        breq              0f
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
1:
        brne              1f
        ret
        movw              r30, r24
        std               Z+1, r21	; 0x01
        st                Z, r20
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r1
        ret

asm_test::compare_exchange_weak::u16::release_relaxed:
        movw              r18, r22
        in                r26, 0x3f	; 63
        cli
        movw              r30, r24
        ld                r22, Z
        ldd               r23, Z+1	; 0x01
        eor               r18, r22
        eor               r19, r23
        or                r19, r18
        cpi               r19, 0x00	; 0
0:
        breq              0f
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
1:
        brne              1f
        ret
        movw              r30, r24
        std               Z+1, r21	; 0x01
        st                Z, r20
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r1
        ret

asm_test::load::u8::seqcst:
        movw              r30, r24
        ld                r24, Z
        ret

asm_test::load::u8::acquire:
        movw              r30, r24
        ld                r24, Z
        ret

asm_test::load::u8::relaxed:
        movw              r30, r24
        ld                r24, Z
        ret

asm_test::load::u16::seqcst:
        in                r18, 0x3f	; 63
        cli
        movw              r30, r24
        ld                r24, Z
        ldd               r25, Z+1	; 0x01
        out               0x3f, r18	; 63
        ret

asm_test::load::u16::acquire:
        in                r18, 0x3f	; 63
        cli
        movw              r30, r24
        ld                r24, Z
        ldd               r25, Z+1	; 0x01
        out               0x3f, r18	; 63
        ret

asm_test::load::u16::relaxed:
        in                r18, 0x3f	; 63
        cli
        movw              r30, r24
        ld                r24, Z
        ldd               r25, Z+1	; 0x01
        out               0x3f, r18	; 63
        ret

asm_test::swap::u8::acqrel:
        movw              r30, r24
        in                r25, 0x3f	; 63
        cli
        ld                r24, Z
        st                Z, r22
        out               0x3f, r25	; 63
        ret

asm_test::swap::u8::seqcst:
        movw              r30, r24
        in                r25, 0x3f	; 63
        cli
        ld                r24, Z
        st                Z, r22
        out               0x3f, r25	; 63
        ret

asm_test::swap::u8::acquire:
        movw              r30, r24
        in                r25, 0x3f	; 63
        cli
        ld                r24, Z
        st                Z, r22
        out               0x3f, r25	; 63
        ret

asm_test::swap::u8::relaxed:
        movw              r30, r24
        in                r25, 0x3f	; 63
        cli
        ld                r24, Z
        st                Z, r22
        out               0x3f, r25	; 63
        ret

asm_test::swap::u8::release:
        movw              r30, r24
        in                r25, 0x3f	; 63
        cli
        ld                r24, Z
        st                Z, r22
        out               0x3f, r25	; 63
        ret

asm_test::swap::u16::acqrel:
        in                r18, 0x3f	; 63
        cli
        movw              r30, r24
        ld                r24, Z
        ldd               r25, Z+1	; 0x01
        std               Z+1, r23	; 0x01
        st                Z, r22
        out               0x3f, r18	; 63
        ret

asm_test::swap::u16::seqcst:
        in                r18, 0x3f	; 63
        cli
        movw              r30, r24
        ld                r24, Z
        ldd               r25, Z+1	; 0x01
        std               Z+1, r23	; 0x01
        st                Z, r22
        out               0x3f, r18	; 63
        ret

asm_test::swap::u16::acquire:
        in                r18, 0x3f	; 63
        cli
        movw              r30, r24
        ld                r24, Z
        ldd               r25, Z+1	; 0x01
        std               Z+1, r23	; 0x01
        st                Z, r22
        out               0x3f, r18	; 63
        ret

asm_test::swap::u16::relaxed:
        in                r18, 0x3f	; 63
        cli
        movw              r30, r24
        ld                r24, Z
        ldd               r25, Z+1	; 0x01
        std               Z+1, r23	; 0x01
        st                Z, r22
        out               0x3f, r18	; 63
        ret

asm_test::swap::u16::release:
        in                r18, 0x3f	; 63
        cli
        movw              r30, r24
        ld                r24, Z
        ldd               r25, Z+1	; 0x01
        std               Z+1, r23	; 0x01
        st                Z, r22
        out               0x3f, r18	; 63
        ret

asm_test::store::u8::seqcst:
        movw              r30, r24
        st                Z, r22
        ret

asm_test::store::u8::relaxed:
        movw              r30, r24
        st                Z, r22
        ret

asm_test::store::u8::release:
        movw              r30, r24
        st                Z, r22
        ret

asm_test::store::u16::seqcst:
        in                r18, 0x3f	; 63
        cli
        movw              r30, r24
        std               Z+1, r23	; 0x01
        st                Z, r22
        out               0x3f, r18	; 63
        ret

asm_test::store::u16::relaxed:
        in                r18, 0x3f	; 63
        cli
        movw              r30, r24
        std               Z+1, r23	; 0x01
        st                Z, r22
        out               0x3f, r18	; 63
        ret

asm_test::store::u16::release:
        in                r18, 0x3f	; 63
        cli
        movw              r30, r24
        std               Z+1, r23	; 0x01
        st                Z, r22
        out               0x3f, r18	; 63
        ret

