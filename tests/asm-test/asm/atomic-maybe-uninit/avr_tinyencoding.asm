asm_test::compare_exchange::u8::acqrel_seqcst:
        mov               r30, r24
        mov               r31, r25
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
        mov               r25, r17
        ret

asm_test::compare_exchange::u8::seqcst_seqcst:
        mov               r30, r24
        mov               r31, r25
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
        mov               r25, r17
        ret

asm_test::compare_exchange::u8::acqrel_acquire:
        mov               r30, r24
        mov               r31, r25
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
        mov               r25, r17
        ret

asm_test::compare_exchange::u8::acqrel_relaxed:
        mov               r30, r24
        mov               r31, r25
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
        mov               r25, r17
        ret

asm_test::compare_exchange::u8::acquire_seqcst:
        mov               r30, r24
        mov               r31, r25
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
        mov               r25, r17
        ret

asm_test::compare_exchange::u8::relaxed_seqcst:
        mov               r30, r24
        mov               r31, r25
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
        mov               r25, r17
        ret

asm_test::compare_exchange::u8::release_seqcst:
        mov               r30, r24
        mov               r31, r25
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
        mov               r25, r17
        ret

asm_test::compare_exchange::u8::seqcst_acquire:
        mov               r30, r24
        mov               r31, r25
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
        mov               r25, r17
        ret

asm_test::compare_exchange::u8::seqcst_relaxed:
        mov               r30, r24
        mov               r31, r25
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
        mov               r25, r17
        ret

asm_test::compare_exchange::u8::acquire_acquire:
        mov               r30, r24
        mov               r31, r25
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
        mov               r25, r17
        ret

asm_test::compare_exchange::u8::acquire_relaxed:
        mov               r30, r24
        mov               r31, r25
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
        mov               r25, r17
        ret

asm_test::compare_exchange::u8::relaxed_acquire:
        mov               r30, r24
        mov               r31, r25
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
        mov               r25, r17
        ret

asm_test::compare_exchange::u8::relaxed_relaxed:
        mov               r30, r24
        mov               r31, r25
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
        mov               r25, r17
        ret

asm_test::compare_exchange::u8::release_acquire:
        mov               r30, r24
        mov               r31, r25
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
        mov               r25, r17
        ret

asm_test::compare_exchange::u8::release_relaxed:
        mov               r30, r24
        mov               r31, r25
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
        mov               r25, r17
        ret

asm_test::compare_exchange::u16::acqrel_seqcst:
        push              r18
        push              r19
        mov               r18, r22
        mov               r19, r23
        in                r26, 0x3f	; 63
        cli
        mov               r30, r24
        mov               r31, r25
        ld                r22, Z+
        ld                r23, Z+
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
        pop               r19
        pop               r18
        ret
        mov               r30, r24
        mov               r31, r25
        st                Z+, r20
        st                Z+, r21
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r17
        pop               r19
        pop               r18
        ret

asm_test::compare_exchange::u16::seqcst_seqcst:
        push              r18
        push              r19
        mov               r18, r22
        mov               r19, r23
        in                r26, 0x3f	; 63
        cli
        mov               r30, r24
        mov               r31, r25
        ld                r22, Z+
        ld                r23, Z+
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
        pop               r19
        pop               r18
        ret
        mov               r30, r24
        mov               r31, r25
        st                Z+, r20
        st                Z+, r21
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r17
        pop               r19
        pop               r18
        ret

asm_test::compare_exchange::u16::acqrel_acquire:
        push              r18
        push              r19
        mov               r18, r22
        mov               r19, r23
        in                r26, 0x3f	; 63
        cli
        mov               r30, r24
        mov               r31, r25
        ld                r22, Z+
        ld                r23, Z+
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
        pop               r19
        pop               r18
        ret
        mov               r30, r24
        mov               r31, r25
        st                Z+, r20
        st                Z+, r21
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r17
        pop               r19
        pop               r18
        ret

asm_test::compare_exchange::u16::acqrel_relaxed:
        push              r18
        push              r19
        mov               r18, r22
        mov               r19, r23
        in                r26, 0x3f	; 63
        cli
        mov               r30, r24
        mov               r31, r25
        ld                r22, Z+
        ld                r23, Z+
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
        pop               r19
        pop               r18
        ret
        mov               r30, r24
        mov               r31, r25
        st                Z+, r20
        st                Z+, r21
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r17
        pop               r19
        pop               r18
        ret

asm_test::compare_exchange::u16::acquire_seqcst:
        push              r18
        push              r19
        mov               r18, r22
        mov               r19, r23
        in                r26, 0x3f	; 63
        cli
        mov               r30, r24
        mov               r31, r25
        ld                r22, Z+
        ld                r23, Z+
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
        pop               r19
        pop               r18
        ret
        mov               r30, r24
        mov               r31, r25
        st                Z+, r20
        st                Z+, r21
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r17
        pop               r19
        pop               r18
        ret

asm_test::compare_exchange::u16::relaxed_seqcst:
        push              r18
        push              r19
        mov               r18, r22
        mov               r19, r23
        in                r26, 0x3f	; 63
        cli
        mov               r30, r24
        mov               r31, r25
        ld                r22, Z+
        ld                r23, Z+
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
        pop               r19
        pop               r18
        ret
        mov               r30, r24
        mov               r31, r25
        st                Z+, r20
        st                Z+, r21
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r17
        pop               r19
        pop               r18
        ret

asm_test::compare_exchange::u16::release_seqcst:
        push              r18
        push              r19
        mov               r18, r22
        mov               r19, r23
        in                r26, 0x3f	; 63
        cli
        mov               r30, r24
        mov               r31, r25
        ld                r22, Z+
        ld                r23, Z+
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
        pop               r19
        pop               r18
        ret
        mov               r30, r24
        mov               r31, r25
        st                Z+, r20
        st                Z+, r21
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r17
        pop               r19
        pop               r18
        ret

asm_test::compare_exchange::u16::seqcst_acquire:
        push              r18
        push              r19
        mov               r18, r22
        mov               r19, r23
        in                r26, 0x3f	; 63
        cli
        mov               r30, r24
        mov               r31, r25
        ld                r22, Z+
        ld                r23, Z+
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
        pop               r19
        pop               r18
        ret
        mov               r30, r24
        mov               r31, r25
        st                Z+, r20
        st                Z+, r21
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r17
        pop               r19
        pop               r18
        ret

asm_test::compare_exchange::u16::seqcst_relaxed:
        push              r18
        push              r19
        mov               r18, r22
        mov               r19, r23
        in                r26, 0x3f	; 63
        cli
        mov               r30, r24
        mov               r31, r25
        ld                r22, Z+
        ld                r23, Z+
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
        pop               r19
        pop               r18
        ret
        mov               r30, r24
        mov               r31, r25
        st                Z+, r20
        st                Z+, r21
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r17
        pop               r19
        pop               r18
        ret

asm_test::compare_exchange::u16::acquire_acquire:
        push              r18
        push              r19
        mov               r18, r22
        mov               r19, r23
        in                r26, 0x3f	; 63
        cli
        mov               r30, r24
        mov               r31, r25
        ld                r22, Z+
        ld                r23, Z+
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
        pop               r19
        pop               r18
        ret
        mov               r30, r24
        mov               r31, r25
        st                Z+, r20
        st                Z+, r21
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r17
        pop               r19
        pop               r18
        ret

asm_test::compare_exchange::u16::acquire_relaxed:
        push              r18
        push              r19
        mov               r18, r22
        mov               r19, r23
        in                r26, 0x3f	; 63
        cli
        mov               r30, r24
        mov               r31, r25
        ld                r22, Z+
        ld                r23, Z+
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
        pop               r19
        pop               r18
        ret
        mov               r30, r24
        mov               r31, r25
        st                Z+, r20
        st                Z+, r21
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r17
        pop               r19
        pop               r18
        ret

asm_test::compare_exchange::u16::relaxed_acquire:
        push              r18
        push              r19
        mov               r18, r22
        mov               r19, r23
        in                r26, 0x3f	; 63
        cli
        mov               r30, r24
        mov               r31, r25
        ld                r22, Z+
        ld                r23, Z+
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
        pop               r19
        pop               r18
        ret
        mov               r30, r24
        mov               r31, r25
        st                Z+, r20
        st                Z+, r21
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r17
        pop               r19
        pop               r18
        ret

asm_test::compare_exchange::u16::relaxed_relaxed:
        push              r18
        push              r19
        mov               r18, r22
        mov               r19, r23
        in                r26, 0x3f	; 63
        cli
        mov               r30, r24
        mov               r31, r25
        ld                r22, Z+
        ld                r23, Z+
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
        pop               r19
        pop               r18
        ret
        mov               r30, r24
        mov               r31, r25
        st                Z+, r20
        st                Z+, r21
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r17
        pop               r19
        pop               r18
        ret

asm_test::compare_exchange::u16::release_acquire:
        push              r18
        push              r19
        mov               r18, r22
        mov               r19, r23
        in                r26, 0x3f	; 63
        cli
        mov               r30, r24
        mov               r31, r25
        ld                r22, Z+
        ld                r23, Z+
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
        pop               r19
        pop               r18
        ret
        mov               r30, r24
        mov               r31, r25
        st                Z+, r20
        st                Z+, r21
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r17
        pop               r19
        pop               r18
        ret

asm_test::compare_exchange::u16::release_relaxed:
        push              r18
        push              r19
        mov               r18, r22
        mov               r19, r23
        in                r26, 0x3f	; 63
        cli
        mov               r30, r24
        mov               r31, r25
        ld                r22, Z+
        ld                r23, Z+
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
        pop               r19
        pop               r18
        ret
        mov               r30, r24
        mov               r31, r25
        st                Z+, r20
        st                Z+, r21
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r17
        pop               r19
        pop               r18
        ret

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        mov               r30, r24
        mov               r31, r25
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
        mov               r25, r17
        ret

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        mov               r30, r24
        mov               r31, r25
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
        mov               r25, r17
        ret

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        mov               r30, r24
        mov               r31, r25
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
        mov               r25, r17
        ret

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        mov               r30, r24
        mov               r31, r25
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
        mov               r25, r17
        ret

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        mov               r30, r24
        mov               r31, r25
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
        mov               r25, r17
        ret

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        mov               r30, r24
        mov               r31, r25
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
        mov               r25, r17
        ret

asm_test::compare_exchange_weak::u8::release_seqcst:
        mov               r30, r24
        mov               r31, r25
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
        mov               r25, r17
        ret

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        mov               r30, r24
        mov               r31, r25
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
        mov               r25, r17
        ret

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        mov               r30, r24
        mov               r31, r25
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
        mov               r25, r17
        ret

asm_test::compare_exchange_weak::u8::acquire_acquire:
        mov               r30, r24
        mov               r31, r25
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
        mov               r25, r17
        ret

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        mov               r30, r24
        mov               r31, r25
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
        mov               r25, r17
        ret

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        mov               r30, r24
        mov               r31, r25
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
        mov               r25, r17
        ret

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        mov               r30, r24
        mov               r31, r25
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
        mov               r25, r17
        ret

asm_test::compare_exchange_weak::u8::release_acquire:
        mov               r30, r24
        mov               r31, r25
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
        mov               r25, r17
        ret

asm_test::compare_exchange_weak::u8::release_relaxed:
        mov               r30, r24
        mov               r31, r25
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
        mov               r25, r17
        ret

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        push              r18
        push              r19
        mov               r18, r22
        mov               r19, r23
        in                r26, 0x3f	; 63
        cli
        mov               r30, r24
        mov               r31, r25
        ld                r22, Z+
        ld                r23, Z+
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
        pop               r19
        pop               r18
        ret
        mov               r30, r24
        mov               r31, r25
        st                Z+, r20
        st                Z+, r21
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r17
        pop               r19
        pop               r18
        ret

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        push              r18
        push              r19
        mov               r18, r22
        mov               r19, r23
        in                r26, 0x3f	; 63
        cli
        mov               r30, r24
        mov               r31, r25
        ld                r22, Z+
        ld                r23, Z+
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
        pop               r19
        pop               r18
        ret
        mov               r30, r24
        mov               r31, r25
        st                Z+, r20
        st                Z+, r21
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r17
        pop               r19
        pop               r18
        ret

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        push              r18
        push              r19
        mov               r18, r22
        mov               r19, r23
        in                r26, 0x3f	; 63
        cli
        mov               r30, r24
        mov               r31, r25
        ld                r22, Z+
        ld                r23, Z+
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
        pop               r19
        pop               r18
        ret
        mov               r30, r24
        mov               r31, r25
        st                Z+, r20
        st                Z+, r21
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r17
        pop               r19
        pop               r18
        ret

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        push              r18
        push              r19
        mov               r18, r22
        mov               r19, r23
        in                r26, 0x3f	; 63
        cli
        mov               r30, r24
        mov               r31, r25
        ld                r22, Z+
        ld                r23, Z+
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
        pop               r19
        pop               r18
        ret
        mov               r30, r24
        mov               r31, r25
        st                Z+, r20
        st                Z+, r21
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r17
        pop               r19
        pop               r18
        ret

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        push              r18
        push              r19
        mov               r18, r22
        mov               r19, r23
        in                r26, 0x3f	; 63
        cli
        mov               r30, r24
        mov               r31, r25
        ld                r22, Z+
        ld                r23, Z+
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
        pop               r19
        pop               r18
        ret
        mov               r30, r24
        mov               r31, r25
        st                Z+, r20
        st                Z+, r21
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r17
        pop               r19
        pop               r18
        ret

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        push              r18
        push              r19
        mov               r18, r22
        mov               r19, r23
        in                r26, 0x3f	; 63
        cli
        mov               r30, r24
        mov               r31, r25
        ld                r22, Z+
        ld                r23, Z+
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
        pop               r19
        pop               r18
        ret
        mov               r30, r24
        mov               r31, r25
        st                Z+, r20
        st                Z+, r21
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r17
        pop               r19
        pop               r18
        ret

asm_test::compare_exchange_weak::u16::release_seqcst:
        push              r18
        push              r19
        mov               r18, r22
        mov               r19, r23
        in                r26, 0x3f	; 63
        cli
        mov               r30, r24
        mov               r31, r25
        ld                r22, Z+
        ld                r23, Z+
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
        pop               r19
        pop               r18
        ret
        mov               r30, r24
        mov               r31, r25
        st                Z+, r20
        st                Z+, r21
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r17
        pop               r19
        pop               r18
        ret

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        push              r18
        push              r19
        mov               r18, r22
        mov               r19, r23
        in                r26, 0x3f	; 63
        cli
        mov               r30, r24
        mov               r31, r25
        ld                r22, Z+
        ld                r23, Z+
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
        pop               r19
        pop               r18
        ret
        mov               r30, r24
        mov               r31, r25
        st                Z+, r20
        st                Z+, r21
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r17
        pop               r19
        pop               r18
        ret

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        push              r18
        push              r19
        mov               r18, r22
        mov               r19, r23
        in                r26, 0x3f	; 63
        cli
        mov               r30, r24
        mov               r31, r25
        ld                r22, Z+
        ld                r23, Z+
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
        pop               r19
        pop               r18
        ret
        mov               r30, r24
        mov               r31, r25
        st                Z+, r20
        st                Z+, r21
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r17
        pop               r19
        pop               r18
        ret

asm_test::compare_exchange_weak::u16::acquire_acquire:
        push              r18
        push              r19
        mov               r18, r22
        mov               r19, r23
        in                r26, 0x3f	; 63
        cli
        mov               r30, r24
        mov               r31, r25
        ld                r22, Z+
        ld                r23, Z+
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
        pop               r19
        pop               r18
        ret
        mov               r30, r24
        mov               r31, r25
        st                Z+, r20
        st                Z+, r21
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r17
        pop               r19
        pop               r18
        ret

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        push              r18
        push              r19
        mov               r18, r22
        mov               r19, r23
        in                r26, 0x3f	; 63
        cli
        mov               r30, r24
        mov               r31, r25
        ld                r22, Z+
        ld                r23, Z+
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
        pop               r19
        pop               r18
        ret
        mov               r30, r24
        mov               r31, r25
        st                Z+, r20
        st                Z+, r21
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r17
        pop               r19
        pop               r18
        ret

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        push              r18
        push              r19
        mov               r18, r22
        mov               r19, r23
        in                r26, 0x3f	; 63
        cli
        mov               r30, r24
        mov               r31, r25
        ld                r22, Z+
        ld                r23, Z+
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
        pop               r19
        pop               r18
        ret
        mov               r30, r24
        mov               r31, r25
        st                Z+, r20
        st                Z+, r21
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r17
        pop               r19
        pop               r18
        ret

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        push              r18
        push              r19
        mov               r18, r22
        mov               r19, r23
        in                r26, 0x3f	; 63
        cli
        mov               r30, r24
        mov               r31, r25
        ld                r22, Z+
        ld                r23, Z+
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
        pop               r19
        pop               r18
        ret
        mov               r30, r24
        mov               r31, r25
        st                Z+, r20
        st                Z+, r21
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r17
        pop               r19
        pop               r18
        ret

asm_test::compare_exchange_weak::u16::release_acquire:
        push              r18
        push              r19
        mov               r18, r22
        mov               r19, r23
        in                r26, 0x3f	; 63
        cli
        mov               r30, r24
        mov               r31, r25
        ld                r22, Z+
        ld                r23, Z+
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
        pop               r19
        pop               r18
        ret
        mov               r30, r24
        mov               r31, r25
        st                Z+, r20
        st                Z+, r21
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r17
        pop               r19
        pop               r18
        ret

asm_test::compare_exchange_weak::u16::release_relaxed:
        push              r18
        push              r19
        mov               r18, r22
        mov               r19, r23
        in                r26, 0x3f	; 63
        cli
        mov               r30, r24
        mov               r31, r25
        ld                r22, Z+
        ld                r23, Z+
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
        pop               r19
        pop               r18
        ret
        mov               r30, r24
        mov               r31, r25
        st                Z+, r20
        st                Z+, r21
        out               0x3f, r26	; 63
        ldi               r24, 0x01	; 1
        cpi               r19, 0x00	; 0
2:
        breq              2f
        mov               r24, r17
        pop               r19
        pop               r18
        ret

asm_test::load::u8::seqcst:
        mov               r30, r24
        mov               r31, r25
        ld                r24, Z
        ret

asm_test::load::u8::acquire:
        mov               r30, r24
        mov               r31, r25
        ld                r24, Z
        ret

asm_test::load::u8::relaxed:
        mov               r30, r24
        mov               r31, r25
        ld                r24, Z
        ret

asm_test::load::u16::seqcst:
        in                r20, 0x3f	; 63
        cli
        mov               r30, r24
        mov               r31, r25
        ld                r24, Z+
        ld                r25, Z+
        out               0x3f, r20	; 63
        ret

asm_test::load::u16::acquire:
        in                r20, 0x3f	; 63
        cli
        mov               r30, r24
        mov               r31, r25
        ld                r24, Z+
        ld                r25, Z+
        out               0x3f, r20	; 63
        ret

asm_test::load::u16::relaxed:
        in                r20, 0x3f	; 63
        cli
        mov               r30, r24
        mov               r31, r25
        ld                r24, Z+
        ld                r25, Z+
        out               0x3f, r20	; 63
        ret

asm_test::swap::u8::acqrel:
        mov               r30, r24
        mov               r31, r25
        in                r25, 0x3f	; 63
        cli
        ld                r24, Z
        st                Z, r22
        out               0x3f, r25	; 63
        ret

asm_test::swap::u8::seqcst:
        mov               r30, r24
        mov               r31, r25
        in                r25, 0x3f	; 63
        cli
        ld                r24, Z
        st                Z, r22
        out               0x3f, r25	; 63
        ret

asm_test::swap::u8::acquire:
        mov               r30, r24
        mov               r31, r25
        in                r25, 0x3f	; 63
        cli
        ld                r24, Z
        st                Z, r22
        out               0x3f, r25	; 63
        ret

asm_test::swap::u8::relaxed:
        mov               r30, r24
        mov               r31, r25
        in                r25, 0x3f	; 63
        cli
        ld                r24, Z
        st                Z, r22
        out               0x3f, r25	; 63
        ret

asm_test::swap::u8::release:
        mov               r30, r24
        mov               r31, r25
        in                r25, 0x3f	; 63
        cli
        ld                r24, Z
        st                Z, r22
        out               0x3f, r25	; 63
        ret

asm_test::swap::u16::acqrel:
        in                r20, 0x3f	; 63
        cli
        mov               r30, r24
        mov               r31, r25
        ld                r24, Z+
        ld                r25, Z+
        subi              r30, 0x02	; 2
        sbci              r31, 0x00	; 0
        st                Z+, r22
        st                Z+, r23
        out               0x3f, r20	; 63
        ret

asm_test::swap::u16::seqcst:
        in                r20, 0x3f	; 63
        cli
        mov               r30, r24
        mov               r31, r25
        ld                r24, Z+
        ld                r25, Z+
        subi              r30, 0x02	; 2
        sbci              r31, 0x00	; 0
        st                Z+, r22
        st                Z+, r23
        out               0x3f, r20	; 63
        ret

asm_test::swap::u16::acquire:
        in                r20, 0x3f	; 63
        cli
        mov               r30, r24
        mov               r31, r25
        ld                r24, Z+
        ld                r25, Z+
        subi              r30, 0x02	; 2
        sbci              r31, 0x00	; 0
        st                Z+, r22
        st                Z+, r23
        out               0x3f, r20	; 63
        ret

asm_test::swap::u16::relaxed:
        in                r20, 0x3f	; 63
        cli
        mov               r30, r24
        mov               r31, r25
        ld                r24, Z+
        ld                r25, Z+
        subi              r30, 0x02	; 2
        sbci              r31, 0x00	; 0
        st                Z+, r22
        st                Z+, r23
        out               0x3f, r20	; 63
        ret

asm_test::swap::u16::release:
        in                r20, 0x3f	; 63
        cli
        mov               r30, r24
        mov               r31, r25
        ld                r24, Z+
        ld                r25, Z+
        subi              r30, 0x02	; 2
        sbci              r31, 0x00	; 0
        st                Z+, r22
        st                Z+, r23
        out               0x3f, r20	; 63
        ret

asm_test::store::u8::seqcst:
        mov               r30, r24
        mov               r31, r25
        st                Z, r22
        ret

asm_test::store::u8::relaxed:
        mov               r30, r24
        mov               r31, r25
        st                Z, r22
        ret

asm_test::store::u8::release:
        mov               r30, r24
        mov               r31, r25
        st                Z, r22
        ret

asm_test::store::u16::seqcst:
        in                r20, 0x3f	; 63
        cli
        mov               r30, r24
        mov               r31, r25
        st                Z+, r22
        st                Z+, r23
        out               0x3f, r20	; 63
        ret

asm_test::store::u16::relaxed:
        in                r20, 0x3f	; 63
        cli
        mov               r30, r24
        mov               r31, r25
        st                Z+, r22
        st                Z+, r23
        out               0x3f, r20	; 63
        ret

asm_test::store::u16::release:
        in                r20, 0x3f	; 63
        cli
        mov               r30, r24
        mov               r31, r25
        st                Z+, r22
        st                Z+, r23
        out               0x3f, r20	; 63
        ret
