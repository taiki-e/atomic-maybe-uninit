asm_test::load::u8::seqcst:
        mov               r26, r24
        mov               r27, r25
        in                r16, 0x3f	; 63
        cli
        ld                r24, X
        out               0x3f, r16	; 63
        ret

asm_test::load::u8::acquire:
        mov               r26, r24
        mov               r27, r25
        in                r16, 0x3f	; 63
        cli
        ld                r24, X
        out               0x3f, r16	; 63
        ret

asm_test::load::u8::relaxed:
        mov               r26, r24
        mov               r27, r25
        in                r16, 0x3f	; 63
        cli
        ld                r24, X
        out               0x3f, r16	; 63
        ret

asm_test::load::u16::seqcst:
        mov               r30, r24
        mov               r31, r25
        in                r16, 0x3f	; 63
        cli
        ld                r24, Z+
        ld                r25, Z+
        out               0x3f, r16	; 63
        ret

asm_test::load::u16::acquire:
        mov               r30, r24
        mov               r31, r25
        in                r16, 0x3f	; 63
        cli
        ld                r24, Z+
        ld                r25, Z+
        out               0x3f, r16	; 63
        ret

asm_test::load::u16::relaxed:
        mov               r30, r24
        mov               r31, r25
        in                r16, 0x3f	; 63
        cli
        ld                r24, Z+
        ld                r25, Z+
        out               0x3f, r16	; 63
        ret

asm_test::store::u8::seqcst:
        mov               r26, r24
        mov               r27, r25
        in                r16, 0x3f	; 63
        cli
        st                X, r22
        out               0x3f, r16	; 63
        ret

asm_test::store::u8::relaxed:
        mov               r26, r24
        mov               r27, r25
        in                r16, 0x3f	; 63
        cli
        st                X, r22
        out               0x3f, r16	; 63
        ret

asm_test::store::u8::release:
        mov               r26, r24
        mov               r27, r25
        in                r16, 0x3f	; 63
        cli
        st                X, r22
        out               0x3f, r16	; 63
        ret

asm_test::store::u16::seqcst:
        mov               r30, r24
        mov               r31, r25
        in                r16, 0x3f	; 63
        cli
        st                Z+, r22
        st                Z+, r23
        out               0x3f, r16	; 63
        ret

asm_test::store::u16::relaxed:
        mov               r30, r24
        mov               r31, r25
        in                r16, 0x3f	; 63
        cli
        st                Z+, r22
        st                Z+, r23
        out               0x3f, r16	; 63
        ret

asm_test::store::u16::release:
        mov               r30, r24
        mov               r31, r25
        in                r16, 0x3f	; 63
        cli
        st                Z+, r22
        st                Z+, r23
        out               0x3f, r16	; 63
        ret
