asm_test::compare_exchange::u8::acqrel_seqcst:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        stbar
        nop
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange::u8::seqcst_seqcst:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        stbar
        nop
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange::u8::acqrel_acquire:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        stbar
        nop
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange::u8::acqrel_relaxed:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        stbar
        nop
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange::u8::acquire_seqcst:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        stbar
        nop
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange::u8::relaxed_seqcst:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        stbar
        nop
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange::u8::release_seqcst:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        stbar
        nop
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange::u8::seqcst_acquire:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        stbar
        nop
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange::u8::seqcst_relaxed:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        stbar
        nop
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange::u8::acquire_acquire:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange::u8::acquire_relaxed:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange::u8::relaxed_acquire:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange::u8::relaxed_relaxed:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange::u8::release_acquire:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        stbar
        nop
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange::u8::release_relaxed:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        stbar
        nop
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange::u16::acqrel_seqcst:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange::u16::acqrel_seqcst+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        stbar
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange::u16::seqcst_seqcst:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange::u16::seqcst_seqcst+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        stbar
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange::u16::acqrel_acquire:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange::u16::acqrel_acquire+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        stbar
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange::u16::acqrel_relaxed:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange::u16::acqrel_relaxed+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        stbar
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange::u16::acquire_seqcst:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange::u16::acquire_seqcst+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        stbar
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange::u16::relaxed_seqcst:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange::u16::relaxed_seqcst+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        stbar
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange::u16::release_seqcst:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange::u16::release_seqcst+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        stbar
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange::u16::seqcst_acquire:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange::u16::seqcst_acquire+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        stbar
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange::u16::seqcst_relaxed:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange::u16::seqcst_relaxed+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        stbar
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange::u16::acquire_acquire:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange::u16::acquire_acquire+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange::u16::acquire_relaxed:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange::u16::acquire_relaxed+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange::u16::relaxed_acquire:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange::u16::relaxed_acquire+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange::u16::relaxed_relaxed:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange::u16::relaxed_relaxed+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange::u16::release_acquire:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange::u16::release_acquire+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        stbar
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange::u16::release_relaxed:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange::u16::release_relaxed+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        stbar
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange::u32::acqrel_seqcst:
        save              %sp, -96, %sp
        nop
        stbar
        nop
        ldstub            [ %sp + -1 ], %g0
        nop
        nop
        nop
        casa              [ %i0 ] (10), %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        bne               0f
        nop
        mov               1, %i0	! 1 <asm_test::compare_exchange::u32::acqrel_seqcst+0x1>
0:
        stbar
        cmp               %i0, 0
        bne               1f
        nop
        mov               %g0, %i1
        ret
        restore           %g0, %i2, %o0
1:
        mov               1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u32::seqcst_seqcst:
        save              %sp, -96, %sp
        nop
        stbar
        nop
        ldstub            [ %sp + -1 ], %g0
        nop
        nop
        nop
        casa              [ %i0 ] (10), %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        bne               0f
        nop
        mov               1, %i0	! 1 <asm_test::compare_exchange::u32::seqcst_seqcst+0x1>
0:
        stbar
        cmp               %i0, 0
        bne               1f
        nop
        mov               %g0, %i1
        ret
        restore           %g0, %i2, %o0
1:
        mov               1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u32::acqrel_acquire:
        save              %sp, -96, %sp
        nop
        stbar
        nop
        ldstub            [ %sp + -1 ], %g0
        nop
        nop
        nop
        casa              [ %i0 ] (10), %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        bne               0f
        nop
        mov               1, %i0	! 1 <asm_test::compare_exchange::u32::acqrel_acquire+0x1>
0:
        stbar
        cmp               %i0, 0
        bne               1f
        nop
        mov               %g0, %i1
        ret
        restore           %g0, %i2, %o0
1:
        mov               1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u32::acqrel_relaxed:
        save              %sp, -96, %sp
        nop
        stbar
        nop
        ldstub            [ %sp + -1 ], %g0
        nop
        nop
        nop
        casa              [ %i0 ] (10), %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        bne               0f
        nop
        mov               1, %i0	! 1 <asm_test::compare_exchange::u32::acqrel_relaxed+0x1>
0:
        stbar
        cmp               %i0, 0
        bne               1f
        nop
        mov               %g0, %i1
        ret
        restore           %g0, %i2, %o0
1:
        mov               1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u32::acquire_seqcst:
        save              %sp, -96, %sp
        nop
        stbar
        nop
        ldstub            [ %sp + -1 ], %g0
        nop
        nop
        nop
        casa              [ %i0 ] (10), %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        bne               0f
        nop
        mov               1, %i0	! 1 <asm_test::compare_exchange::u32::acquire_seqcst+0x1>
0:
        stbar
        cmp               %i0, 0
        bne               1f
        nop
        mov               %g0, %i1
        ret
        restore           %g0, %i2, %o0
1:
        mov               1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u32::relaxed_seqcst:
        save              %sp, -96, %sp
        nop
        stbar
        nop
        ldstub            [ %sp + -1 ], %g0
        nop
        nop
        nop
        casa              [ %i0 ] (10), %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        bne               0f
        nop
        mov               1, %i0	! 1 <asm_test::compare_exchange::u32::relaxed_seqcst+0x1>
0:
        stbar
        cmp               %i0, 0
        bne               1f
        nop
        mov               %g0, %i1
        ret
        restore           %g0, %i2, %o0
1:
        mov               1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u32::release_seqcst:
        save              %sp, -96, %sp
        nop
        stbar
        nop
        ldstub            [ %sp + -1 ], %g0
        nop
        nop
        nop
        casa              [ %i0 ] (10), %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        bne               0f
        nop
        mov               1, %i0	! 1 <asm_test::compare_exchange::u32::release_seqcst+0x1>
0:
        stbar
        cmp               %i0, 0
        bne               1f
        nop
        mov               %g0, %i1
        ret
        restore           %g0, %i2, %o0
1:
        mov               1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u32::seqcst_acquire:
        save              %sp, -96, %sp
        nop
        stbar
        nop
        ldstub            [ %sp + -1 ], %g0
        nop
        nop
        nop
        casa              [ %i0 ] (10), %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        bne               0f
        nop
        mov               1, %i0	! 1 <asm_test::compare_exchange::u32::seqcst_acquire+0x1>
0:
        stbar
        cmp               %i0, 0
        bne               1f
        nop
        mov               %g0, %i1
        ret
        restore           %g0, %i2, %o0
1:
        mov               1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u32::seqcst_relaxed:
        save              %sp, -96, %sp
        nop
        stbar
        nop
        ldstub            [ %sp + -1 ], %g0
        nop
        nop
        nop
        casa              [ %i0 ] (10), %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        bne               0f
        nop
        mov               1, %i0	! 1 <asm_test::compare_exchange::u32::seqcst_relaxed+0x1>
0:
        stbar
        cmp               %i0, 0
        bne               1f
        nop
        mov               %g0, %i1
        ret
        restore           %g0, %i2, %o0
1:
        mov               1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u32::acquire_acquire:
        save              %sp, -96, %sp
        nop
        nop
        nop
        casa              [ %i0 ] (10), %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        bne               0f
        nop
        mov               1, %i0	! 1 <asm_test::compare_exchange::u32::acquire_acquire+0x1>
0:
        stbar
        cmp               %i0, 0
        bne               1f
        nop
        mov               %g0, %i1
        ret
        restore           %g0, %i2, %o0
1:
        mov               1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u32::acquire_relaxed:
        save              %sp, -96, %sp
        nop
        nop
        nop
        casa              [ %i0 ] (10), %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        bne               0f
        nop
        mov               1, %i0	! 1 <asm_test::compare_exchange::u32::acquire_relaxed+0x1>
0:
        stbar
        cmp               %i0, 0
        bne               1f
        nop
        mov               %g0, %i1
        ret
        restore           %g0, %i2, %o0
1:
        mov               1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u32::relaxed_acquire:
        save              %sp, -96, %sp
        nop
        nop
        nop
        casa              [ %i0 ] (10), %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        bne               0f
        nop
        mov               1, %i0	! 1 <asm_test::compare_exchange::u32::relaxed_acquire+0x1>
0:
        stbar
        cmp               %i0, 0
        bne               1f
        nop
        mov               %g0, %i1
        ret
        restore           %g0, %i2, %o0
1:
        mov               1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u32::relaxed_relaxed:
        save              %sp, -96, %sp
        nop
        nop
        nop
        casa              [ %i0 ] (10), %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        bne               0f
        nop
        mov               1, %i0	! 1 <asm_test::compare_exchange::u32::relaxed_relaxed+0x1>
0:
        cmp               %i0, 0
        bne               1f
        nop
        mov               %g0, %i1
        ret
        restore           %g0, %i2, %o0
1:
        mov               1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u32::release_acquire:
        save              %sp, -96, %sp
        nop
        stbar
        nop
        ldstub            [ %sp + -1 ], %g0
        nop
        nop
        nop
        casa              [ %i0 ] (10), %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        bne               0f
        nop
        mov               1, %i0	! 1 <asm_test::compare_exchange::u32::release_acquire+0x1>
0:
        stbar
        cmp               %i0, 0
        bne               1f
        nop
        mov               %g0, %i1
        ret
        restore           %g0, %i2, %o0
1:
        mov               1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u32::release_relaxed:
        save              %sp, -96, %sp
        nop
        stbar
        nop
        ldstub            [ %sp + -1 ], %g0
        nop
        nop
        nop
        casa              [ %i0 ] (10), %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        bne               0f
        nop
        mov               1, %i0	! 1 <asm_test::compare_exchange::u32::release_relaxed+0x1>
0:
        cmp               %i0, 0
        bne               1f
        nop
        mov               %g0, %i1
        ret
        restore           %g0, %i2, %o0
1:
        mov               1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        stbar
        nop
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        stbar
        nop
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        stbar
        nop
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        stbar
        nop
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        stbar
        nop
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        stbar
        nop
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange_weak::u8::release_seqcst:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        stbar
        nop
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        stbar
        nop
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        stbar
        nop
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange_weak::u8::acquire_acquire:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange_weak::u8::release_acquire:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        stbar
        nop
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange_weak::u8::release_relaxed:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        stbar
        nop
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange_weak::u16::acqrel_seqcst+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        stbar
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange_weak::u16::seqcst_seqcst+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        stbar
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange_weak::u16::acqrel_acquire+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        stbar
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange_weak::u16::acqrel_relaxed+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        stbar
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange_weak::u16::acquire_seqcst+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        stbar
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange_weak::u16::relaxed_seqcst+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        stbar
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange_weak::u16::release_seqcst:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange_weak::u16::release_seqcst+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        stbar
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange_weak::u16::seqcst_acquire+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        stbar
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange_weak::u16::seqcst_relaxed+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        stbar
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange_weak::u16::acquire_acquire:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange_weak::u16::acquire_acquire+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange_weak::u16::acquire_relaxed+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange_weak::u16::relaxed_acquire+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange_weak::u16::relaxed_relaxed+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange_weak::u16::release_acquire:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange_weak::u16::release_acquire+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        stbar
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        stbar
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange_weak::u16::release_relaxed:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange_weak::u16::release_relaxed+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        stbar
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        nop
        nop
        nop
        casa              [ %i3 ] (10), %g2, %i0
        cmp               %i0, %g2
        bne               0b
        mov               1, %g2
1:
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        bne               2f
        nop
        ret
        restore           %g0, %g0, %o1
2:
        ret
        restore           %g0, 1, %o1

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        save              %sp, -96, %sp
        nop
        stbar
        nop
        ldstub            [ %sp + -1 ], %g0
        nop
        nop
        nop
        casa              [ %i0 ] (10), %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        bne               0f
        nop
        mov               1, %i0	! 1 <asm_test::compare_exchange_weak::u32::acqrel_seqcst+0x1>
0:
        stbar
        cmp               %i0, 0
        bne               1f
        nop
        mov               %g0, %i1
        ret
        restore           %g0, %i2, %o0
1:
        mov               1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        save              %sp, -96, %sp
        nop
        stbar
        nop
        ldstub            [ %sp + -1 ], %g0
        nop
        nop
        nop
        casa              [ %i0 ] (10), %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        bne               0f
        nop
        mov               1, %i0	! 1 <asm_test::compare_exchange_weak::u32::seqcst_seqcst+0x1>
0:
        stbar
        cmp               %i0, 0
        bne               1f
        nop
        mov               %g0, %i1
        ret
        restore           %g0, %i2, %o0
1:
        mov               1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        save              %sp, -96, %sp
        nop
        stbar
        nop
        ldstub            [ %sp + -1 ], %g0
        nop
        nop
        nop
        casa              [ %i0 ] (10), %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        bne               0f
        nop
        mov               1, %i0	! 1 <asm_test::compare_exchange_weak::u32::acqrel_acquire+0x1>
0:
        stbar
        cmp               %i0, 0
        bne               1f
        nop
        mov               %g0, %i1
        ret
        restore           %g0, %i2, %o0
1:
        mov               1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        save              %sp, -96, %sp
        nop
        stbar
        nop
        ldstub            [ %sp + -1 ], %g0
        nop
        nop
        nop
        casa              [ %i0 ] (10), %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        bne               0f
        nop
        mov               1, %i0	! 1 <asm_test::compare_exchange_weak::u32::acqrel_relaxed+0x1>
0:
        stbar
        cmp               %i0, 0
        bne               1f
        nop
        mov               %g0, %i1
        ret
        restore           %g0, %i2, %o0
1:
        mov               1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        save              %sp, -96, %sp
        nop
        stbar
        nop
        ldstub            [ %sp + -1 ], %g0
        nop
        nop
        nop
        casa              [ %i0 ] (10), %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        bne               0f
        nop
        mov               1, %i0	! 1 <asm_test::compare_exchange_weak::u32::acquire_seqcst+0x1>
0:
        stbar
        cmp               %i0, 0
        bne               1f
        nop
        mov               %g0, %i1
        ret
        restore           %g0, %i2, %o0
1:
        mov               1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        save              %sp, -96, %sp
        nop
        stbar
        nop
        ldstub            [ %sp + -1 ], %g0
        nop
        nop
        nop
        casa              [ %i0 ] (10), %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        bne               0f
        nop
        mov               1, %i0	! 1 <asm_test::compare_exchange_weak::u32::relaxed_seqcst+0x1>
0:
        stbar
        cmp               %i0, 0
        bne               1f
        nop
        mov               %g0, %i1
        ret
        restore           %g0, %i2, %o0
1:
        mov               1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u32::release_seqcst:
        save              %sp, -96, %sp
        nop
        stbar
        nop
        ldstub            [ %sp + -1 ], %g0
        nop
        nop
        nop
        casa              [ %i0 ] (10), %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        bne               0f
        nop
        mov               1, %i0	! 1 <asm_test::compare_exchange_weak::u32::release_seqcst+0x1>
0:
        stbar
        cmp               %i0, 0
        bne               1f
        nop
        mov               %g0, %i1
        ret
        restore           %g0, %i2, %o0
1:
        mov               1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        save              %sp, -96, %sp
        nop
        stbar
        nop
        ldstub            [ %sp + -1 ], %g0
        nop
        nop
        nop
        casa              [ %i0 ] (10), %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        bne               0f
        nop
        mov               1, %i0	! 1 <asm_test::compare_exchange_weak::u32::seqcst_acquire+0x1>
0:
        stbar
        cmp               %i0, 0
        bne               1f
        nop
        mov               %g0, %i1
        ret
        restore           %g0, %i2, %o0
1:
        mov               1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        save              %sp, -96, %sp
        nop
        stbar
        nop
        ldstub            [ %sp + -1 ], %g0
        nop
        nop
        nop
        casa              [ %i0 ] (10), %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        bne               0f
        nop
        mov               1, %i0	! 1 <asm_test::compare_exchange_weak::u32::seqcst_relaxed+0x1>
0:
        stbar
        cmp               %i0, 0
        bne               1f
        nop
        mov               %g0, %i1
        ret
        restore           %g0, %i2, %o0
1:
        mov               1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u32::acquire_acquire:
        save              %sp, -96, %sp
        nop
        nop
        nop
        casa              [ %i0 ] (10), %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        bne               0f
        nop
        mov               1, %i0	! 1 <asm_test::compare_exchange_weak::u32::acquire_acquire+0x1>
0:
        stbar
        cmp               %i0, 0
        bne               1f
        nop
        mov               %g0, %i1
        ret
        restore           %g0, %i2, %o0
1:
        mov               1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        save              %sp, -96, %sp
        nop
        nop
        nop
        casa              [ %i0 ] (10), %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        bne               0f
        nop
        mov               1, %i0	! 1 <asm_test::compare_exchange_weak::u32::acquire_relaxed+0x1>
0:
        stbar
        cmp               %i0, 0
        bne               1f
        nop
        mov               %g0, %i1
        ret
        restore           %g0, %i2, %o0
1:
        mov               1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        save              %sp, -96, %sp
        nop
        nop
        nop
        casa              [ %i0 ] (10), %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        bne               0f
        nop
        mov               1, %i0	! 1 <asm_test::compare_exchange_weak::u32::relaxed_acquire+0x1>
0:
        stbar
        cmp               %i0, 0
        bne               1f
        nop
        mov               %g0, %i1
        ret
        restore           %g0, %i2, %o0
1:
        mov               1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        save              %sp, -96, %sp
        nop
        nop
        nop
        casa              [ %i0 ] (10), %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        bne               0f
        nop
        mov               1, %i0	! 1 <asm_test::compare_exchange_weak::u32::relaxed_relaxed+0x1>
0:
        cmp               %i0, 0
        bne               1f
        nop
        mov               %g0, %i1
        ret
        restore           %g0, %i2, %o0
1:
        mov               1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u32::release_acquire:
        save              %sp, -96, %sp
        nop
        stbar
        nop
        ldstub            [ %sp + -1 ], %g0
        nop
        nop
        nop
        casa              [ %i0 ] (10), %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        bne               0f
        nop
        mov               1, %i0	! 1 <asm_test::compare_exchange_weak::u32::release_acquire+0x1>
0:
        stbar
        cmp               %i0, 0
        bne               1f
        nop
        mov               %g0, %i1
        ret
        restore           %g0, %i2, %o0
1:
        mov               1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u32::release_relaxed:
        save              %sp, -96, %sp
        nop
        stbar
        nop
        ldstub            [ %sp + -1 ], %g0
        nop
        nop
        nop
        casa              [ %i0 ] (10), %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        bne               0f
        nop
        mov               1, %i0	! 1 <asm_test::compare_exchange_weak::u32::release_relaxed+0x1>
0:
        cmp               %i0, 0
        bne               1f
        nop
        mov               %g0, %i1
        ret
        restore           %g0, %i2, %o0
1:
        mov               1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::load::u8::seqcst:
        save              %sp, -96, %sp
        nop
        nop
        nop
        ldstub            [ %sp + -1 ], %g0
        ldub              [ %i0 ], %i0
        stbar
        ret
        restore

asm_test::load::u8::acquire:
        save              %sp, -96, %sp
        ldub              [ %i0 ], %i0
        stbar
        ret
        restore

asm_test::load::u8::relaxed:
        save              %sp, -96, %sp
        ldub              [ %i0 ], %i0
        ret
        restore

asm_test::load::u16::seqcst:
        save              %sp, -96, %sp
        nop
        nop
        nop
        ldstub            [ %sp + -1 ], %g0
        lduh              [ %i0 ], %i0
        stbar
        ret
        restore

asm_test::load::u16::acquire:
        save              %sp, -96, %sp
        lduh              [ %i0 ], %i0
        stbar
        ret
        restore

asm_test::load::u16::relaxed:
        save              %sp, -96, %sp
        lduh              [ %i0 ], %i0
        ret
        restore

asm_test::load::u32::seqcst:
        save              %sp, -96, %sp
        nop
        nop
        nop
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i0 ], %i0
        stbar
        ret
        restore

asm_test::load::u32::acquire:
        save              %sp, -96, %sp
        ld                [ %i0 ], %i0
        stbar
        ret
        restore

asm_test::load::u32::relaxed:
        save              %sp, -96, %sp
        ld                [ %i0 ], %i0
        ret
        restore

asm_test::swap::u8::acqrel:
        save              %sp, -96, %sp
        and               %i0, -4, %i2
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i3
        and               %i1, 0xff, %i1
        mov               0xff, %i4
        sll               %i4, %i3, %i4
        sll               %i1, %i3, %i1
        stbar
        nop
        nop
        nop
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i2 ], %i5
0:
        andn              %i5, %i4, %i0
        or                %i0, %i1, %i0
        casa              [ %i2 ] (10), %i5, %i0
        cmp               %i0, %i5
        bne,a             0b
        mov               %i0, %i5
        srl               %i0, %i3, %i0
        stbar
        ret
        restore

asm_test::swap::u8::seqcst:
        save              %sp, -96, %sp
        and               %i0, -4, %i2
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i3
        and               %i1, 0xff, %i1
        mov               0xff, %i4
        sll               %i4, %i3, %i4
        sll               %i1, %i3, %i1
        stbar
        nop
        nop
        nop
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i2 ], %i5
0:
        andn              %i5, %i4, %i0
        or                %i0, %i1, %i0
        casa              [ %i2 ] (10), %i5, %i0
        cmp               %i0, %i5
        bne,a             0b
        mov               %i0, %i5
        srl               %i0, %i3, %i0
        stbar
        ret
        restore

asm_test::swap::u8::acquire:
        save              %sp, -96, %sp
        and               %i0, -4, %i2
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i3
        and               %i1, 0xff, %i1
        mov               0xff, %i4
        sll               %i4, %i3, %i4
        sll               %i1, %i3, %i1
        ld                [ %i2 ], %i5
0:
        andn              %i5, %i4, %i0
        or                %i0, %i1, %i0
        nop
        casa              [ %i2 ] (10), %i5, %i0
        cmp               %i0, %i5
        bne,a             0b
        mov               %i0, %i5
        srl               %i0, %i3, %i0
        stbar
        ret
        restore

asm_test::swap::u8::relaxed:
        save              %sp, -96, %sp
        and               %i0, -4, %i2
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i3
        and               %i1, 0xff, %i1
        mov               0xff, %i4
        sll               %i4, %i3, %i4
        sll               %i1, %i3, %i1
        ld                [ %i2 ], %i5
0:
        andn              %i5, %i4, %i0
        or                %i0, %i1, %i0
        nop
        casa              [ %i2 ] (10), %i5, %i0
        cmp               %i0, %i5
        bne,a             0b
        mov               %i0, %i5
        srl               %i0, %i3, %i0
        ret
        restore

asm_test::swap::u8::release:
        save              %sp, -96, %sp
        and               %i0, -4, %i2
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i3
        and               %i1, 0xff, %i1
        mov               0xff, %i4
        sll               %i4, %i3, %i4
        sll               %i1, %i3, %i1
        stbar
        nop
        nop
        nop
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i2 ], %i5
0:
        andn              %i5, %i4, %i0
        or                %i0, %i1, %i0
        casa              [ %i2 ] (10), %i5, %i0
        cmp               %i0, %i5
        bne,a             0b
        mov               %i0, %i5
        srl               %i0, %i3, %i0
        ret
        restore

asm_test::swap::u16::acqrel:
        save              %sp, -96, %sp
        and               %i0, -4, %i2
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i3
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i4	! ffff <asm_test::swap::u16::acqrel+0xffff>
        and               %i1, %i4, %i1
        sll               %i4, %i3, %i4
        sll               %i1, %i3, %i1
        stbar
        nop
        nop
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i2 ], %i5
0:
        andn              %i5, %i4, %i0
        or                %i0, %i1, %i0
        casa              [ %i2 ] (10), %i5, %i0
        cmp               %i0, %i5
        bne,a             0b
        mov               %i0, %i5
        srl               %i0, %i3, %i0
        stbar
        ret
        restore

asm_test::swap::u16::seqcst:
        save              %sp, -96, %sp
        and               %i0, -4, %i2
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i3
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i4	! ffff <asm_test::swap::u16::seqcst+0xffff>
        and               %i1, %i4, %i1
        sll               %i4, %i3, %i4
        sll               %i1, %i3, %i1
        stbar
        nop
        nop
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i2 ], %i5
0:
        andn              %i5, %i4, %i0
        or                %i0, %i1, %i0
        casa              [ %i2 ] (10), %i5, %i0
        cmp               %i0, %i5
        bne,a             0b
        mov               %i0, %i5
        srl               %i0, %i3, %i0
        stbar
        ret
        restore

asm_test::swap::u16::acquire:
        save              %sp, -96, %sp
        and               %i0, -4, %i2
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i3
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i4	! ffff <asm_test::swap::u16::acquire+0xffff>
        and               %i1, %i4, %i1
        sll               %i4, %i3, %i4
        sll               %i1, %i3, %i1
        ld                [ %i2 ], %i5
0:
        andn              %i5, %i4, %i0
        or                %i0, %i1, %i0
        casa              [ %i2 ] (10), %i5, %i0
        cmp               %i0, %i5
        bne,a             0b
        mov               %i0, %i5
        srl               %i0, %i3, %i0
        stbar
        ret
        restore

asm_test::swap::u16::relaxed:
        save              %sp, -96, %sp
        and               %i0, -4, %i2
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i3
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i4	! ffff <asm_test::swap::u16::relaxed+0xffff>
        and               %i1, %i4, %i1
        sll               %i4, %i3, %i4
        sll               %i1, %i3, %i1
        ld                [ %i2 ], %i5
0:
        andn              %i5, %i4, %i0
        or                %i0, %i1, %i0
        casa              [ %i2 ] (10), %i5, %i0
        cmp               %i0, %i5
        bne,a             0b
        mov               %i0, %i5
        srl               %i0, %i3, %i0
        ret
        restore

asm_test::swap::u16::release:
        save              %sp, -96, %sp
        and               %i0, -4, %i2
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i3
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i4	! ffff <asm_test::swap::u16::release+0xffff>
        and               %i1, %i4, %i1
        sll               %i4, %i3, %i4
        sll               %i1, %i3, %i1
        stbar
        nop
        nop
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i2 ], %i5
0:
        andn              %i5, %i4, %i0
        or                %i0, %i1, %i0
        casa              [ %i2 ] (10), %i5, %i0
        cmp               %i0, %i5
        bne,a             0b
        mov               %i0, %i5
        srl               %i0, %i3, %i0
        ret
        restore

asm_test::swap::u32::acqrel:
        save              %sp, -96, %sp
        stbar
        nop
        nop
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i0 ], %i3
0:
        mov               %i1, %i2
        nop
        casa              [ %i0 ] (10), %i3, %i2
        cmp               %i2, %i3
        bne,a             0b
        mov               %i2, %i3
        stbar
        ret
        restore           %g0, %i2, %o0

asm_test::swap::u32::seqcst:
        save              %sp, -96, %sp
        stbar
        nop
        nop
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i0 ], %i3
0:
        mov               %i1, %i2
        nop
        casa              [ %i0 ] (10), %i3, %i2
        cmp               %i2, %i3
        bne,a             0b
        mov               %i2, %i3
        stbar
        ret
        restore           %g0, %i2, %o0

asm_test::swap::u32::acquire:
        save              %sp, -96, %sp
        ld                [ %i0 ], %i3
0:
        mov               %i1, %i2
        nop
        casa              [ %i0 ] (10), %i3, %i2
        cmp               %i2, %i3
        bne,a             0b
        mov               %i2, %i3
        stbar
        ret
        restore           %g0, %i2, %o0

asm_test::swap::u32::relaxed:
        save              %sp, -96, %sp
        ld                [ %i0 ], %i3
0:
        mov               %i1, %i2
        nop
        casa              [ %i0 ] (10), %i3, %i2
        cmp               %i2, %i3
        bne,a             0b
        mov               %i2, %i3
        ret
        restore           %g0, %i2, %o0

asm_test::swap::u32::release:
        save              %sp, -96, %sp
        stbar
        nop
        nop
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i0 ], %i3
0:
        mov               %i1, %i2
        nop
        casa              [ %i0 ] (10), %i3, %i2
        cmp               %i2, %i3
        bne,a             0b
        mov               %i2, %i3
        ret
        restore           %g0, %i2, %o0

asm_test::store::u8::seqcst:
        save              %sp, -96, %sp
        nop
        stbar
        stb               %i1, [ %i0 ]
        stbar
        nop
        nop
        nop
        ldstub            [ %sp + -1 ], %g0
        nop
        ret
        restore

asm_test::store::u8::relaxed:
        save              %sp, -96, %sp
        nop
        stb               %i1, [ %i0 ]
        nop
        ret
        restore

asm_test::store::u8::release:
        save              %sp, -96, %sp
        nop
        stbar
        stb               %i1, [ %i0 ]
        nop
        ret
        restore

asm_test::store::u16::seqcst:
        save              %sp, -96, %sp
        nop
        stbar
        sth               %i1, [ %i0 ]
        stbar
        nop
        nop
        nop
        ldstub            [ %sp + -1 ], %g0
        nop
        ret
        restore

asm_test::store::u16::relaxed:
        save              %sp, -96, %sp
        nop
        sth               %i1, [ %i0 ]
        nop
        ret
        restore

asm_test::store::u16::release:
        save              %sp, -96, %sp
        nop
        stbar
        sth               %i1, [ %i0 ]
        nop
        ret
        restore

asm_test::store::u32::seqcst:
        save              %sp, -96, %sp
        nop
        stbar
        st                %i1, [ %i0 ]
        stbar
        nop
        nop
        nop
        ldstub            [ %sp + -1 ], %g0
        nop
        ret
        restore

asm_test::store::u32::relaxed:
        save              %sp, -96, %sp
        nop
        st                %i1, [ %i0 ]
        nop
        ret
        restore

asm_test::store::u32::release:
        save              %sp, -96, %sp
        nop
        stbar
        st                %i1, [ %i0 ]
        nop
        ret
        restore

