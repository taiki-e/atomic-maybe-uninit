asm_test::compare_exchange::u8::acqrel_seqcst:
        stbar
        and               %o0, -4, %o3
        mov               3, %o4
        andn              %o4, %o0, %o0
        sll               %o0, 3, %o0
        mov               0xff, %o4
        sll               %o4, %o0, %g2
        xor               %g2, -1, %o4
        and               %o2, 0xff, %o2
        ld                [ %o3 ], %g3
        sll               %o2, %o0, %o2
        and               %o1, 0xff, %o1
        sll               %o1, %o0, %o5
        andn              %g3, %g2, %g2
0:
        or                %g2, %o2, %g3
        or                %g2, %o5, %o1
        casa              [ %o3 ] (10), %o1, %g3
        cmp               %g3, %o1
        be                1f
        nop
        mov               %g0, %o1
        cmp               %o1, 0
        be                2f
        nop
        b                 3f
        nop
1:
        mov               1, %o1	! 1 <asm_test::compare_exchange::u8::acqrel_seqcst+0x1>
        cmp               %o1, 0
        bne               3f
        nop
2:
        and               %g3, %o4, %g4
        cmp               %g2, %g4
        bne               0b
        mov               %g4, %g2
3:
        srl               %g3, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange::u8::seqcst_seqcst:
        stbar
        and               %o0, -4, %o3
        mov               3, %o4
        andn              %o4, %o0, %o0
        sll               %o0, 3, %o0
        mov               0xff, %o4
        sll               %o4, %o0, %g2
        xor               %g2, -1, %o4
        and               %o2, 0xff, %o2
        ld                [ %o3 ], %g3
        sll               %o2, %o0, %o2
        and               %o1, 0xff, %o1
        sll               %o1, %o0, %o5
        andn              %g3, %g2, %g2
0:
        or                %g2, %o2, %g3
        or                %g2, %o5, %o1
        casa              [ %o3 ] (10), %o1, %g3
        cmp               %g3, %o1
        be                1f
        nop
        mov               %g0, %o1
        cmp               %o1, 0
        be                2f
        nop
        b                 3f
        nop
1:
        mov               1, %o1	! 1 <asm_test::compare_exchange::u8::seqcst_seqcst+0x1>
        cmp               %o1, 0
        bne               3f
        nop
2:
        and               %g3, %o4, %g4
        cmp               %g2, %g4
        bne               0b
        mov               %g4, %g2
3:
        srl               %g3, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange::u8::acqrel_acquire:
        stbar
        and               %o0, -4, %o3
        mov               3, %o4
        andn              %o4, %o0, %o0
        sll               %o0, 3, %o0
        mov               0xff, %o4
        sll               %o4, %o0, %g2
        xor               %g2, -1, %o4
        and               %o2, 0xff, %o2
        ld                [ %o3 ], %g3
        sll               %o2, %o0, %o2
        and               %o1, 0xff, %o1
        sll               %o1, %o0, %o5
        andn              %g3, %g2, %g2
0:
        or                %g2, %o2, %g3
        or                %g2, %o5, %o1
        casa              [ %o3 ] (10), %o1, %g3
        cmp               %g3, %o1
        be                1f
        nop
        mov               %g0, %o1
        cmp               %o1, 0
        be                2f
        nop
        b                 3f
        nop
1:
        mov               1, %o1	! 1 <asm_test::compare_exchange::u8::acqrel_acquire+0x1>
        cmp               %o1, 0
        bne               3f
        nop
2:
        and               %g3, %o4, %g4
        cmp               %g2, %g4
        bne               0b
        mov               %g4, %g2
3:
        srl               %g3, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange::u8::acqrel_relaxed:
        stbar
        and               %o0, -4, %o3
        mov               3, %o4
        andn              %o4, %o0, %o0
        sll               %o0, 3, %o0
        mov               0xff, %o4
        sll               %o4, %o0, %g2
        xor               %g2, -1, %o4
        and               %o2, 0xff, %o2
        ld                [ %o3 ], %g3
        sll               %o2, %o0, %o2
        and               %o1, 0xff, %o1
        sll               %o1, %o0, %o5
        andn              %g3, %g2, %g2
0:
        or                %g2, %o2, %g3
        or                %g2, %o5, %o1
        casa              [ %o3 ] (10), %o1, %g3
        cmp               %g3, %o1
        be                1f
        nop
        mov               %g0, %o1
        cmp               %o1, 0
        be                2f
        nop
        b                 3f
        nop
1:
        mov               1, %o1	! 1 <asm_test::compare_exchange::u8::acqrel_relaxed+0x1>
        cmp               %o1, 0
        bne               3f
        nop
2:
        and               %g3, %o4, %g4
        cmp               %g2, %g4
        bne               0b
        mov               %g4, %g2
3:
        srl               %g3, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange::u8::acquire_seqcst:
        stbar
        and               %o0, -4, %o3
        mov               3, %o4
        andn              %o4, %o0, %o0
        sll               %o0, 3, %o0
        mov               0xff, %o4
        sll               %o4, %o0, %g2
        xor               %g2, -1, %o4
        and               %o2, 0xff, %o2
        ld                [ %o3 ], %g3
        sll               %o2, %o0, %o2
        and               %o1, 0xff, %o1
        sll               %o1, %o0, %o5
        andn              %g3, %g2, %g2
0:
        or                %g2, %o2, %g3
        or                %g2, %o5, %o1
        casa              [ %o3 ] (10), %o1, %g3
        cmp               %g3, %o1
        be                1f
        nop
        mov               %g0, %o1
        cmp               %o1, 0
        be                2f
        nop
        b                 3f
        nop
1:
        mov               1, %o1	! 1 <asm_test::compare_exchange::u8::acquire_seqcst+0x1>
        cmp               %o1, 0
        bne               3f
        nop
2:
        and               %g3, %o4, %g4
        cmp               %g2, %g4
        bne               0b
        mov               %g4, %g2
3:
        srl               %g3, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange::u8::relaxed_seqcst:
        stbar
        and               %o0, -4, %o3
        mov               3, %o4
        andn              %o4, %o0, %o0
        sll               %o0, 3, %o0
        mov               0xff, %o4
        sll               %o4, %o0, %g2
        xor               %g2, -1, %o4
        and               %o2, 0xff, %o2
        ld                [ %o3 ], %g3
        sll               %o2, %o0, %o2
        and               %o1, 0xff, %o1
        sll               %o1, %o0, %o5
        andn              %g3, %g2, %g2
0:
        or                %g2, %o2, %g3
        or                %g2, %o5, %o1
        casa              [ %o3 ] (10), %o1, %g3
        cmp               %g3, %o1
        be                1f
        nop
        mov               %g0, %o1
        cmp               %o1, 0
        be                2f
        nop
        b                 3f
        nop
1:
        mov               1, %o1	! 1 <asm_test::compare_exchange::u8::relaxed_seqcst+0x1>
        cmp               %o1, 0
        bne               3f
        nop
2:
        and               %g3, %o4, %g4
        cmp               %g2, %g4
        bne               0b
        mov               %g4, %g2
3:
        srl               %g3, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange::u8::release_seqcst:
        stbar
        and               %o0, -4, %o3
        mov               3, %o4
        andn              %o4, %o0, %o0
        sll               %o0, 3, %o0
        mov               0xff, %o4
        sll               %o4, %o0, %g2
        xor               %g2, -1, %o4
        and               %o2, 0xff, %o2
        ld                [ %o3 ], %g3
        sll               %o2, %o0, %o2
        and               %o1, 0xff, %o1
        sll               %o1, %o0, %o5
        andn              %g3, %g2, %g2
0:
        or                %g2, %o2, %g3
        or                %g2, %o5, %o1
        casa              [ %o3 ] (10), %o1, %g3
        cmp               %g3, %o1
        be                1f
        nop
        mov               %g0, %o1
        cmp               %o1, 0
        be                2f
        nop
        b                 3f
        nop
1:
        mov               1, %o1	! 1 <asm_test::compare_exchange::u8::release_seqcst+0x1>
        cmp               %o1, 0
        bne               3f
        nop
2:
        and               %g3, %o4, %g4
        cmp               %g2, %g4
        bne               0b
        mov               %g4, %g2
3:
        srl               %g3, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange::u8::seqcst_acquire:
        stbar
        and               %o0, -4, %o3
        mov               3, %o4
        andn              %o4, %o0, %o0
        sll               %o0, 3, %o0
        mov               0xff, %o4
        sll               %o4, %o0, %g2
        xor               %g2, -1, %o4
        and               %o2, 0xff, %o2
        ld                [ %o3 ], %g3
        sll               %o2, %o0, %o2
        and               %o1, 0xff, %o1
        sll               %o1, %o0, %o5
        andn              %g3, %g2, %g2
0:
        or                %g2, %o2, %g3
        or                %g2, %o5, %o1
        casa              [ %o3 ] (10), %o1, %g3
        cmp               %g3, %o1
        be                1f
        nop
        mov               %g0, %o1
        cmp               %o1, 0
        be                2f
        nop
        b                 3f
        nop
1:
        mov               1, %o1	! 1 <asm_test::compare_exchange::u8::seqcst_acquire+0x1>
        cmp               %o1, 0
        bne               3f
        nop
2:
        and               %g3, %o4, %g4
        cmp               %g2, %g4
        bne               0b
        mov               %g4, %g2
3:
        srl               %g3, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange::u8::seqcst_relaxed:
        stbar
        and               %o0, -4, %o3
        mov               3, %o4
        andn              %o4, %o0, %o0
        sll               %o0, 3, %o0
        mov               0xff, %o4
        sll               %o4, %o0, %g2
        xor               %g2, -1, %o4
        and               %o2, 0xff, %o2
        ld                [ %o3 ], %g3
        sll               %o2, %o0, %o2
        and               %o1, 0xff, %o1
        sll               %o1, %o0, %o5
        andn              %g3, %g2, %g2
0:
        or                %g2, %o2, %g3
        or                %g2, %o5, %o1
        casa              [ %o3 ] (10), %o1, %g3
        cmp               %g3, %o1
        be                1f
        nop
        mov               %g0, %o1
        cmp               %o1, 0
        be                2f
        nop
        b                 3f
        nop
1:
        mov               1, %o1	! 1 <asm_test::compare_exchange::u8::seqcst_relaxed+0x1>
        cmp               %o1, 0
        bne               3f
        nop
2:
        and               %g3, %o4, %g4
        cmp               %g2, %g4
        bne               0b
        mov               %g4, %g2
3:
        srl               %g3, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange::u8::acquire_acquire:
        and               %o0, -4, %o3
        mov               3, %o4
        andn              %o4, %o0, %o0
        sll               %o0, 3, %o0
        mov               0xff, %o4
        sll               %o4, %o0, %g2
        xor               %g2, -1, %o4
        and               %o2, 0xff, %o2
        ld                [ %o3 ], %g3
        sll               %o2, %o0, %o2
        and               %o1, 0xff, %o1
        sll               %o1, %o0, %o5
        andn              %g3, %g2, %g2
0:
        or                %g2, %o2, %g3
        or                %g2, %o5, %o1
        casa              [ %o3 ] (10), %o1, %g3
        cmp               %g3, %o1
        be                1f
        nop
        mov               %g0, %o1
        cmp               %o1, 0
        be                2f
        nop
        b                 3f
        nop
1:
        mov               1, %o1	! 1 <asm_test::compare_exchange::u8::acquire_acquire+0x1>
        cmp               %o1, 0
        bne               3f
        nop
2:
        and               %g3, %o4, %g4
        cmp               %g2, %g4
        bne               0b
        mov               %g4, %g2
3:
        srl               %g3, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange::u8::acquire_relaxed:
        and               %o0, -4, %o3
        mov               3, %o4
        andn              %o4, %o0, %o0
        sll               %o0, 3, %o0
        mov               0xff, %o4
        sll               %o4, %o0, %g2
        xor               %g2, -1, %o4
        and               %o2, 0xff, %o2
        ld                [ %o3 ], %g3
        sll               %o2, %o0, %o2
        and               %o1, 0xff, %o1
        sll               %o1, %o0, %o5
        andn              %g3, %g2, %g2
0:
        or                %g2, %o2, %g3
        or                %g2, %o5, %o1
        casa              [ %o3 ] (10), %o1, %g3
        cmp               %g3, %o1
        be                1f
        nop
        mov               %g0, %o1
        cmp               %o1, 0
        be                2f
        nop
        b                 3f
        nop
1:
        mov               1, %o1	! 1 <asm_test::compare_exchange::u8::acquire_relaxed+0x1>
        cmp               %o1, 0
        bne               3f
        nop
2:
        and               %g3, %o4, %g4
        cmp               %g2, %g4
        bne               0b
        mov               %g4, %g2
3:
        srl               %g3, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange::u8::relaxed_acquire:
        and               %o0, -4, %o3
        mov               3, %o4
        andn              %o4, %o0, %o0
        sll               %o0, 3, %o0
        mov               0xff, %o4
        sll               %o4, %o0, %g2
        xor               %g2, -1, %o4
        and               %o2, 0xff, %o2
        ld                [ %o3 ], %g3
        sll               %o2, %o0, %o2
        and               %o1, 0xff, %o1
        sll               %o1, %o0, %o5
        andn              %g3, %g2, %g2
0:
        or                %g2, %o2, %g3
        or                %g2, %o5, %o1
        casa              [ %o3 ] (10), %o1, %g3
        cmp               %g3, %o1
        be                1f
        nop
        mov               %g0, %o1
        cmp               %o1, 0
        be                2f
        nop
        b                 3f
        nop
1:
        mov               1, %o1	! 1 <asm_test::compare_exchange::u8::relaxed_acquire+0x1>
        cmp               %o1, 0
        bne               3f
        nop
2:
        and               %g3, %o4, %g4
        cmp               %g2, %g4
        bne               0b
        mov               %g4, %g2
3:
        srl               %g3, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange::u8::relaxed_relaxed:
        and               %o0, -4, %o3
        mov               3, %o4
        andn              %o4, %o0, %o0
        sll               %o0, 3, %o0
        mov               0xff, %o4
        sll               %o4, %o0, %g2
        xor               %g2, -1, %o4
        and               %o2, 0xff, %o2
        ld                [ %o3 ], %g3
        sll               %o2, %o0, %o2
        and               %o1, 0xff, %o1
        sll               %o1, %o0, %o5
        andn              %g3, %g2, %g2
0:
        or                %g2, %o2, %g3
        or                %g2, %o5, %o1
        casa              [ %o3 ] (10), %o1, %g3
        cmp               %g3, %o1
        be                1f
        nop
        mov               %g0, %o1
        cmp               %o1, 0
        be                2f
        nop
        b                 3f
        nop
1:
        mov               1, %o1	! 1 <asm_test::compare_exchange::u8::relaxed_relaxed+0x1>
        cmp               %o1, 0
        bne               3f
        nop
2:
        and               %g3, %o4, %g4
        cmp               %g2, %g4
        bne               0b
        mov               %g4, %g2
3:
        retl
        srl               %g3, %o0, %o0

asm_test::compare_exchange::u8::release_acquire:
        stbar
        and               %o0, -4, %o3
        mov               3, %o4
        andn              %o4, %o0, %o0
        sll               %o0, 3, %o0
        mov               0xff, %o4
        sll               %o4, %o0, %g2
        xor               %g2, -1, %o4
        and               %o2, 0xff, %o2
        ld                [ %o3 ], %g3
        sll               %o2, %o0, %o2
        and               %o1, 0xff, %o1
        sll               %o1, %o0, %o5
        andn              %g3, %g2, %g2
0:
        or                %g2, %o2, %g3
        or                %g2, %o5, %o1
        casa              [ %o3 ] (10), %o1, %g3
        cmp               %g3, %o1
        be                1f
        nop
        mov               %g0, %o1
        cmp               %o1, 0
        be                2f
        nop
        b                 3f
        nop
1:
        mov               1, %o1	! 1 <asm_test::compare_exchange::u8::release_acquire+0x1>
        cmp               %o1, 0
        bne               3f
        nop
2:
        and               %g3, %o4, %g4
        cmp               %g2, %g4
        bne               0b
        mov               %g4, %g2
3:
        srl               %g3, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange::u8::release_relaxed:
        stbar
        and               %o0, -4, %o3
        mov               3, %o4
        andn              %o4, %o0, %o0
        sll               %o0, 3, %o0
        mov               0xff, %o4
        sll               %o4, %o0, %g2
        xor               %g2, -1, %o4
        and               %o2, 0xff, %o2
        ld                [ %o3 ], %g3
        sll               %o2, %o0, %o2
        and               %o1, 0xff, %o1
        sll               %o1, %o0, %o5
        andn              %g3, %g2, %g2
0:
        or                %g2, %o2, %g3
        or                %g2, %o5, %o1
        casa              [ %o3 ] (10), %o1, %g3
        cmp               %g3, %o1
        be                1f
        nop
        mov               %g0, %o1
        cmp               %o1, 0
        be                2f
        nop
        b                 3f
        nop
1:
        mov               1, %o1	! 1 <asm_test::compare_exchange::u8::release_relaxed+0x1>
        cmp               %o1, 0
        bne               3f
        nop
2:
        and               %g3, %o4, %g4
        cmp               %g2, %g4
        bne               0b
        mov               %g4, %g2
3:
        retl
        srl               %g3, %o0, %o0

asm_test::compare_exchange::u16::acqrel_seqcst:
        stbar
        and               %o0, -4, %o3
        and               %o0, 3, %o0
        xor               %o0, 2, %o0
        sll               %o0, 3, %o0
        sethi             %hi(0xfc00), %o4
        or                %o4, 0x3ff, %o4	! ffff <asm_test::compare_exchange::u16::acqrel_seqcst+0xffff>
        sll               %o4, %o0, %g2
        and               %o2, %o4, %o5
        and               %o1, %o4, %o1
        ld                [ %o3 ], %g3
        xor               %g2, -1, %o2
        sll               %o5, %o0, %o4
        sll               %o1, %o0, %o5
        andn              %g3, %g2, %g2
0:
        or                %g2, %o4, %g3
        or                %g2, %o5, %o1
        casa              [ %o3 ] (10), %o1, %g3
        cmp               %g3, %o1
        be                1f
        nop
        mov               %g0, %o1
        cmp               %o1, 0
        be                2f
        nop
        b                 3f
        nop
1:
        mov               1, %o1	! 1 <asm_test::compare_exchange::u16::acqrel_seqcst+0x1>
        cmp               %o1, 0
        bne               3f
        nop
2:
        and               %g3, %o2, %g4
        cmp               %g2, %g4
        bne               0b
        mov               %g4, %g2
3:
        srl               %g3, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange::u16::seqcst_seqcst:
        stbar
        and               %o0, -4, %o3
        and               %o0, 3, %o0
        xor               %o0, 2, %o0
        sll               %o0, 3, %o0
        sethi             %hi(0xfc00), %o4
        or                %o4, 0x3ff, %o4	! ffff <asm_test::compare_exchange::u16::seqcst_seqcst+0xffff>
        sll               %o4, %o0, %g2
        and               %o2, %o4, %o5
        and               %o1, %o4, %o1
        ld                [ %o3 ], %g3
        xor               %g2, -1, %o2
        sll               %o5, %o0, %o4
        sll               %o1, %o0, %o5
        andn              %g3, %g2, %g2
0:
        or                %g2, %o4, %g3
        or                %g2, %o5, %o1
        casa              [ %o3 ] (10), %o1, %g3
        cmp               %g3, %o1
        be                1f
        nop
        mov               %g0, %o1
        cmp               %o1, 0
        be                2f
        nop
        b                 3f
        nop
1:
        mov               1, %o1	! 1 <asm_test::compare_exchange::u16::seqcst_seqcst+0x1>
        cmp               %o1, 0
        bne               3f
        nop
2:
        and               %g3, %o2, %g4
        cmp               %g2, %g4
        bne               0b
        mov               %g4, %g2
3:
        srl               %g3, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange::u16::acqrel_acquire:
        stbar
        and               %o0, -4, %o3
        and               %o0, 3, %o0
        xor               %o0, 2, %o0
        sll               %o0, 3, %o0
        sethi             %hi(0xfc00), %o4
        or                %o4, 0x3ff, %o4	! ffff <asm_test::compare_exchange::u16::acqrel_acquire+0xffff>
        sll               %o4, %o0, %g2
        and               %o2, %o4, %o5
        and               %o1, %o4, %o1
        ld                [ %o3 ], %g3
        xor               %g2, -1, %o2
        sll               %o5, %o0, %o4
        sll               %o1, %o0, %o5
        andn              %g3, %g2, %g2
0:
        or                %g2, %o4, %g3
        or                %g2, %o5, %o1
        casa              [ %o3 ] (10), %o1, %g3
        cmp               %g3, %o1
        be                1f
        nop
        mov               %g0, %o1
        cmp               %o1, 0
        be                2f
        nop
        b                 3f
        nop
1:
        mov               1, %o1	! 1 <asm_test::compare_exchange::u16::acqrel_acquire+0x1>
        cmp               %o1, 0
        bne               3f
        nop
2:
        and               %g3, %o2, %g4
        cmp               %g2, %g4
        bne               0b
        mov               %g4, %g2
3:
        srl               %g3, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange::u16::acqrel_relaxed:
        stbar
        and               %o0, -4, %o3
        and               %o0, 3, %o0
        xor               %o0, 2, %o0
        sll               %o0, 3, %o0
        sethi             %hi(0xfc00), %o4
        or                %o4, 0x3ff, %o4	! ffff <asm_test::compare_exchange::u16::acqrel_relaxed+0xffff>
        sll               %o4, %o0, %g2
        and               %o2, %o4, %o5
        and               %o1, %o4, %o1
        ld                [ %o3 ], %g3
        xor               %g2, -1, %o2
        sll               %o5, %o0, %o4
        sll               %o1, %o0, %o5
        andn              %g3, %g2, %g2
0:
        or                %g2, %o4, %g3
        or                %g2, %o5, %o1
        casa              [ %o3 ] (10), %o1, %g3
        cmp               %g3, %o1
        be                1f
        nop
        mov               %g0, %o1
        cmp               %o1, 0
        be                2f
        nop
        b                 3f
        nop
1:
        mov               1, %o1	! 1 <asm_test::compare_exchange::u16::acqrel_relaxed+0x1>
        cmp               %o1, 0
        bne               3f
        nop
2:
        and               %g3, %o2, %g4
        cmp               %g2, %g4
        bne               0b
        mov               %g4, %g2
3:
        srl               %g3, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange::u16::acquire_seqcst:
        stbar
        and               %o0, -4, %o3
        and               %o0, 3, %o0
        xor               %o0, 2, %o0
        sll               %o0, 3, %o0
        sethi             %hi(0xfc00), %o4
        or                %o4, 0x3ff, %o4	! ffff <asm_test::compare_exchange::u16::acquire_seqcst+0xffff>
        sll               %o4, %o0, %g2
        and               %o2, %o4, %o5
        and               %o1, %o4, %o1
        ld                [ %o3 ], %g3
        xor               %g2, -1, %o2
        sll               %o5, %o0, %o4
        sll               %o1, %o0, %o5
        andn              %g3, %g2, %g2
0:
        or                %g2, %o4, %g3
        or                %g2, %o5, %o1
        casa              [ %o3 ] (10), %o1, %g3
        cmp               %g3, %o1
        be                1f
        nop
        mov               %g0, %o1
        cmp               %o1, 0
        be                2f
        nop
        b                 3f
        nop
1:
        mov               1, %o1	! 1 <asm_test::compare_exchange::u16::acquire_seqcst+0x1>
        cmp               %o1, 0
        bne               3f
        nop
2:
        and               %g3, %o2, %g4
        cmp               %g2, %g4
        bne               0b
        mov               %g4, %g2
3:
        srl               %g3, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange::u16::relaxed_seqcst:
        stbar
        and               %o0, -4, %o3
        and               %o0, 3, %o0
        xor               %o0, 2, %o0
        sll               %o0, 3, %o0
        sethi             %hi(0xfc00), %o4
        or                %o4, 0x3ff, %o4	! ffff <asm_test::compare_exchange::u16::relaxed_seqcst+0xffff>
        sll               %o4, %o0, %g2
        and               %o2, %o4, %o5
        and               %o1, %o4, %o1
        ld                [ %o3 ], %g3
        xor               %g2, -1, %o2
        sll               %o5, %o0, %o4
        sll               %o1, %o0, %o5
        andn              %g3, %g2, %g2
0:
        or                %g2, %o4, %g3
        or                %g2, %o5, %o1
        casa              [ %o3 ] (10), %o1, %g3
        cmp               %g3, %o1
        be                1f
        nop
        mov               %g0, %o1
        cmp               %o1, 0
        be                2f
        nop
        b                 3f
        nop
1:
        mov               1, %o1	! 1 <asm_test::compare_exchange::u16::relaxed_seqcst+0x1>
        cmp               %o1, 0
        bne               3f
        nop
2:
        and               %g3, %o2, %g4
        cmp               %g2, %g4
        bne               0b
        mov               %g4, %g2
3:
        srl               %g3, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange::u16::release_seqcst:
        stbar
        and               %o0, -4, %o3
        and               %o0, 3, %o0
        xor               %o0, 2, %o0
        sll               %o0, 3, %o0
        sethi             %hi(0xfc00), %o4
        or                %o4, 0x3ff, %o4	! ffff <asm_test::compare_exchange::u16::release_seqcst+0xffff>
        sll               %o4, %o0, %g2
        and               %o2, %o4, %o5
        and               %o1, %o4, %o1
        ld                [ %o3 ], %g3
        xor               %g2, -1, %o2
        sll               %o5, %o0, %o4
        sll               %o1, %o0, %o5
        andn              %g3, %g2, %g2
0:
        or                %g2, %o4, %g3
        or                %g2, %o5, %o1
        casa              [ %o3 ] (10), %o1, %g3
        cmp               %g3, %o1
        be                1f
        nop
        mov               %g0, %o1
        cmp               %o1, 0
        be                2f
        nop
        b                 3f
        nop
1:
        mov               1, %o1	! 1 <asm_test::compare_exchange::u16::release_seqcst+0x1>
        cmp               %o1, 0
        bne               3f
        nop
2:
        and               %g3, %o2, %g4
        cmp               %g2, %g4
        bne               0b
        mov               %g4, %g2
3:
        srl               %g3, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange::u16::seqcst_acquire:
        stbar
        and               %o0, -4, %o3
        and               %o0, 3, %o0
        xor               %o0, 2, %o0
        sll               %o0, 3, %o0
        sethi             %hi(0xfc00), %o4
        or                %o4, 0x3ff, %o4	! ffff <asm_test::compare_exchange::u16::seqcst_acquire+0xffff>
        sll               %o4, %o0, %g2
        and               %o2, %o4, %o5
        and               %o1, %o4, %o1
        ld                [ %o3 ], %g3
        xor               %g2, -1, %o2
        sll               %o5, %o0, %o4
        sll               %o1, %o0, %o5
        andn              %g3, %g2, %g2
0:
        or                %g2, %o4, %g3
        or                %g2, %o5, %o1
        casa              [ %o3 ] (10), %o1, %g3
        cmp               %g3, %o1
        be                1f
        nop
        mov               %g0, %o1
        cmp               %o1, 0
        be                2f
        nop
        b                 3f
        nop
1:
        mov               1, %o1	! 1 <asm_test::compare_exchange::u16::seqcst_acquire+0x1>
        cmp               %o1, 0
        bne               3f
        nop
2:
        and               %g3, %o2, %g4
        cmp               %g2, %g4
        bne               0b
        mov               %g4, %g2
3:
        srl               %g3, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange::u16::seqcst_relaxed:
        stbar
        and               %o0, -4, %o3
        and               %o0, 3, %o0
        xor               %o0, 2, %o0
        sll               %o0, 3, %o0
        sethi             %hi(0xfc00), %o4
        or                %o4, 0x3ff, %o4	! ffff <asm_test::compare_exchange::u16::seqcst_relaxed+0xffff>
        sll               %o4, %o0, %g2
        and               %o2, %o4, %o5
        and               %o1, %o4, %o1
        ld                [ %o3 ], %g3
        xor               %g2, -1, %o2
        sll               %o5, %o0, %o4
        sll               %o1, %o0, %o5
        andn              %g3, %g2, %g2
0:
        or                %g2, %o4, %g3
        or                %g2, %o5, %o1
        casa              [ %o3 ] (10), %o1, %g3
        cmp               %g3, %o1
        be                1f
        nop
        mov               %g0, %o1
        cmp               %o1, 0
        be                2f
        nop
        b                 3f
        nop
1:
        mov               1, %o1	! 1 <asm_test::compare_exchange::u16::seqcst_relaxed+0x1>
        cmp               %o1, 0
        bne               3f
        nop
2:
        and               %g3, %o2, %g4
        cmp               %g2, %g4
        bne               0b
        mov               %g4, %g2
3:
        srl               %g3, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange::u16::acquire_acquire:
        and               %o0, -4, %o3
        and               %o0, 3, %o0
        xor               %o0, 2, %o0
        sll               %o0, 3, %o0
        sethi             %hi(0xfc00), %o4
        or                %o4, 0x3ff, %o4	! ffff <asm_test::compare_exchange::u16::acquire_acquire+0xffff>
        sll               %o4, %o0, %g2
        and               %o2, %o4, %o5
        and               %o1, %o4, %o1
        ld                [ %o3 ], %g3
        xor               %g2, -1, %o2
        sll               %o5, %o0, %o4
        sll               %o1, %o0, %o5
        andn              %g3, %g2, %g2
0:
        or                %g2, %o4, %g3
        or                %g2, %o5, %o1
        casa              [ %o3 ] (10), %o1, %g3
        cmp               %g3, %o1
        be                1f
        nop
        mov               %g0, %o1
        cmp               %o1, 0
        be                2f
        nop
        b                 3f
        nop
1:
        mov               1, %o1	! 1 <asm_test::compare_exchange::u16::acquire_acquire+0x1>
        cmp               %o1, 0
        bne               3f
        nop
2:
        and               %g3, %o2, %g4
        cmp               %g2, %g4
        bne               0b
        mov               %g4, %g2
3:
        srl               %g3, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange::u16::acquire_relaxed:
        and               %o0, -4, %o3
        and               %o0, 3, %o0
        xor               %o0, 2, %o0
        sll               %o0, 3, %o0
        sethi             %hi(0xfc00), %o4
        or                %o4, 0x3ff, %o4	! ffff <asm_test::compare_exchange::u16::acquire_relaxed+0xffff>
        sll               %o4, %o0, %g2
        and               %o2, %o4, %o5
        and               %o1, %o4, %o1
        ld                [ %o3 ], %g3
        xor               %g2, -1, %o2
        sll               %o5, %o0, %o4
        sll               %o1, %o0, %o5
        andn              %g3, %g2, %g2
0:
        or                %g2, %o4, %g3
        or                %g2, %o5, %o1
        casa              [ %o3 ] (10), %o1, %g3
        cmp               %g3, %o1
        be                1f
        nop
        mov               %g0, %o1
        cmp               %o1, 0
        be                2f
        nop
        b                 3f
        nop
1:
        mov               1, %o1	! 1 <asm_test::compare_exchange::u16::acquire_relaxed+0x1>
        cmp               %o1, 0
        bne               3f
        nop
2:
        and               %g3, %o2, %g4
        cmp               %g2, %g4
        bne               0b
        mov               %g4, %g2
3:
        srl               %g3, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange::u16::relaxed_acquire:
        and               %o0, -4, %o3
        and               %o0, 3, %o0
        xor               %o0, 2, %o0
        sll               %o0, 3, %o0
        sethi             %hi(0xfc00), %o4
        or                %o4, 0x3ff, %o4	! ffff <asm_test::compare_exchange::u16::relaxed_acquire+0xffff>
        sll               %o4, %o0, %g2
        and               %o2, %o4, %o5
        and               %o1, %o4, %o1
        ld                [ %o3 ], %g3
        xor               %g2, -1, %o2
        sll               %o5, %o0, %o4
        sll               %o1, %o0, %o5
        andn              %g3, %g2, %g2
0:
        or                %g2, %o4, %g3
        or                %g2, %o5, %o1
        casa              [ %o3 ] (10), %o1, %g3
        cmp               %g3, %o1
        be                1f
        nop
        mov               %g0, %o1
        cmp               %o1, 0
        be                2f
        nop
        b                 3f
        nop
1:
        mov               1, %o1	! 1 <asm_test::compare_exchange::u16::relaxed_acquire+0x1>
        cmp               %o1, 0
        bne               3f
        nop
2:
        and               %g3, %o2, %g4
        cmp               %g2, %g4
        bne               0b
        mov               %g4, %g2
3:
        srl               %g3, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange::u16::relaxed_relaxed:
        and               %o0, -4, %o3
        and               %o0, 3, %o0
        xor               %o0, 2, %o0
        sll               %o0, 3, %o0
        sethi             %hi(0xfc00), %o4
        or                %o4, 0x3ff, %o4	! ffff <asm_test::compare_exchange::u16::relaxed_relaxed+0xffff>
        sll               %o4, %o0, %g2
        and               %o2, %o4, %o5
        and               %o1, %o4, %o1
        ld                [ %o3 ], %g3
        xor               %g2, -1, %o2
        sll               %o5, %o0, %o4
        sll               %o1, %o0, %o5
        andn              %g3, %g2, %g2
0:
        or                %g2, %o4, %g3
        or                %g2, %o5, %o1
        casa              [ %o3 ] (10), %o1, %g3
        cmp               %g3, %o1
        be                1f
        nop
        mov               %g0, %o1
        cmp               %o1, 0
        be                2f
        nop
        b                 3f
        nop
1:
        mov               1, %o1	! 1 <asm_test::compare_exchange::u16::relaxed_relaxed+0x1>
        cmp               %o1, 0
        bne               3f
        nop
2:
        and               %g3, %o2, %g4
        cmp               %g2, %g4
        bne               0b
        mov               %g4, %g2
3:
        retl
        srl               %g3, %o0, %o0

asm_test::compare_exchange::u16::release_acquire:
        stbar
        and               %o0, -4, %o3
        and               %o0, 3, %o0
        xor               %o0, 2, %o0
        sll               %o0, 3, %o0
        sethi             %hi(0xfc00), %o4
        or                %o4, 0x3ff, %o4	! ffff <asm_test::compare_exchange::u16::release_acquire+0xffff>
        sll               %o4, %o0, %g2
        and               %o2, %o4, %o5
        and               %o1, %o4, %o1
        ld                [ %o3 ], %g3
        xor               %g2, -1, %o2
        sll               %o5, %o0, %o4
        sll               %o1, %o0, %o5
        andn              %g3, %g2, %g2
0:
        or                %g2, %o4, %g3
        or                %g2, %o5, %o1
        casa              [ %o3 ] (10), %o1, %g3
        cmp               %g3, %o1
        be                1f
        nop
        mov               %g0, %o1
        cmp               %o1, 0
        be                2f
        nop
        b                 3f
        nop
1:
        mov               1, %o1	! 1 <asm_test::compare_exchange::u16::release_acquire+0x1>
        cmp               %o1, 0
        bne               3f
        nop
2:
        and               %g3, %o2, %g4
        cmp               %g2, %g4
        bne               0b
        mov               %g4, %g2
3:
        srl               %g3, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange::u16::release_relaxed:
        stbar
        and               %o0, -4, %o3
        and               %o0, 3, %o0
        xor               %o0, 2, %o0
        sll               %o0, 3, %o0
        sethi             %hi(0xfc00), %o4
        or                %o4, 0x3ff, %o4	! ffff <asm_test::compare_exchange::u16::release_relaxed+0xffff>
        sll               %o4, %o0, %g2
        and               %o2, %o4, %o5
        and               %o1, %o4, %o1
        ld                [ %o3 ], %g3
        xor               %g2, -1, %o2
        sll               %o5, %o0, %o4
        sll               %o1, %o0, %o5
        andn              %g3, %g2, %g2
0:
        or                %g2, %o4, %g3
        or                %g2, %o5, %o1
        casa              [ %o3 ] (10), %o1, %g3
        cmp               %g3, %o1
        be                1f
        nop
        mov               %g0, %o1
        cmp               %o1, 0
        be                2f
        nop
        b                 3f
        nop
1:
        mov               1, %o1	! 1 <asm_test::compare_exchange::u16::release_relaxed+0x1>
        cmp               %o1, 0
        bne               3f
        nop
2:
        and               %g3, %o2, %g4
        cmp               %g2, %g4
        bne               0b
        mov               %g4, %g2
3:
        retl
        srl               %g3, %o0, %o0

asm_test::compare_exchange::u32::acqrel_seqcst:
        stbar
        casa              [ %o0 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        stbar
        retl
        mov               %o2, %o0
0:
        mov               1, %o1
        stbar
        retl
        mov               %o2, %o0

asm_test::compare_exchange::u32::seqcst_seqcst:
        stbar
        casa              [ %o0 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        stbar
        retl
        mov               %o2, %o0
0:
        mov               1, %o1
        stbar
        retl
        mov               %o2, %o0

asm_test::compare_exchange::u32::acqrel_acquire:
        stbar
        casa              [ %o0 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        stbar
        retl
        mov               %o2, %o0
0:
        mov               1, %o1
        stbar
        retl
        mov               %o2, %o0

asm_test::compare_exchange::u32::acqrel_relaxed:
        stbar
        casa              [ %o0 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        stbar
        retl
        mov               %o2, %o0
0:
        mov               1, %o1
        stbar
        retl
        mov               %o2, %o0

asm_test::compare_exchange::u32::acquire_seqcst:
        stbar
        casa              [ %o0 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        stbar
        retl
        mov               %o2, %o0
0:
        mov               1, %o1
        stbar
        retl
        mov               %o2, %o0

asm_test::compare_exchange::u32::relaxed_seqcst:
        stbar
        casa              [ %o0 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        stbar
        retl
        mov               %o2, %o0
0:
        mov               1, %o1
        stbar
        retl
        mov               %o2, %o0

asm_test::compare_exchange::u32::release_seqcst:
        stbar
        casa              [ %o0 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        stbar
        retl
        mov               %o2, %o0
0:
        mov               1, %o1
        stbar
        retl
        mov               %o2, %o0

asm_test::compare_exchange::u32::seqcst_acquire:
        stbar
        casa              [ %o0 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        stbar
        retl
        mov               %o2, %o0
0:
        mov               1, %o1
        stbar
        retl
        mov               %o2, %o0

asm_test::compare_exchange::u32::seqcst_relaxed:
        stbar
        casa              [ %o0 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        stbar
        retl
        mov               %o2, %o0
0:
        mov               1, %o1
        stbar
        retl
        mov               %o2, %o0

asm_test::compare_exchange::u32::acquire_acquire:
        casa              [ %o0 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        stbar
        retl
        mov               %o2, %o0
0:
        mov               1, %o1
        stbar
        retl
        mov               %o2, %o0

asm_test::compare_exchange::u32::acquire_relaxed:
        casa              [ %o0 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        stbar
        retl
        mov               %o2, %o0
0:
        mov               1, %o1
        stbar
        retl
        mov               %o2, %o0

asm_test::compare_exchange::u32::relaxed_acquire:
        casa              [ %o0 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        stbar
        retl
        mov               %o2, %o0
0:
        mov               1, %o1
        stbar
        retl
        mov               %o2, %o0

asm_test::compare_exchange::u32::relaxed_relaxed:
        casa              [ %o0 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        retl
        mov               %o2, %o0
0:
        mov               1, %o1
        retl
        mov               %o2, %o0

asm_test::compare_exchange::u32::release_acquire:
        stbar
        casa              [ %o0 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        stbar
        retl
        mov               %o2, %o0
0:
        mov               1, %o1
        stbar
        retl
        mov               %o2, %o0

asm_test::compare_exchange::u32::release_relaxed:
        stbar
        casa              [ %o0 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        retl
        mov               %o2, %o0
0:
        mov               1, %o1
        retl
        mov               %o2, %o0

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        stbar
        and               %o0, -4, %o3
        mov               3, %o4
        andn              %o4, %o0, %o0
        sll               %o0, 3, %o0
        mov               0xff, %o4
        sll               %o4, %o0, %o4
        and               %o2, 0xff, %o2
        ld                [ %o3 ], %o5
        sll               %o2, %o0, %o2
        and               %o1, 0xff, %o1
        sll               %o1, %o0, %o1
        andn              %o5, %o4, %o4
        or                %o4, %o2, %o2
        or                %o4, %o1, %o1
        casa              [ %o3 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        srl               %o2, %o0, %o0
        stbar
        retl
        nop
0:
        mov               1, %o1	! 1 <asm_test::compare_exchange_weak::u8::acqrel_seqcst+0x1>
        srl               %o2, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        stbar
        and               %o0, -4, %o3
        mov               3, %o4
        andn              %o4, %o0, %o0
        sll               %o0, 3, %o0
        mov               0xff, %o4
        sll               %o4, %o0, %o4
        and               %o2, 0xff, %o2
        ld                [ %o3 ], %o5
        sll               %o2, %o0, %o2
        and               %o1, 0xff, %o1
        sll               %o1, %o0, %o1
        andn              %o5, %o4, %o4
        or                %o4, %o2, %o2
        or                %o4, %o1, %o1
        casa              [ %o3 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        srl               %o2, %o0, %o0
        stbar
        retl
        nop
0:
        mov               1, %o1	! 1 <asm_test::compare_exchange_weak::u8::seqcst_seqcst+0x1>
        srl               %o2, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        stbar
        and               %o0, -4, %o3
        mov               3, %o4
        andn              %o4, %o0, %o0
        sll               %o0, 3, %o0
        mov               0xff, %o4
        sll               %o4, %o0, %o4
        and               %o2, 0xff, %o2
        ld                [ %o3 ], %o5
        sll               %o2, %o0, %o2
        and               %o1, 0xff, %o1
        sll               %o1, %o0, %o1
        andn              %o5, %o4, %o4
        or                %o4, %o2, %o2
        or                %o4, %o1, %o1
        casa              [ %o3 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        srl               %o2, %o0, %o0
        stbar
        retl
        nop
0:
        mov               1, %o1	! 1 <asm_test::compare_exchange_weak::u8::acqrel_acquire+0x1>
        srl               %o2, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        stbar
        and               %o0, -4, %o3
        mov               3, %o4
        andn              %o4, %o0, %o0
        sll               %o0, 3, %o0
        mov               0xff, %o4
        sll               %o4, %o0, %o4
        and               %o2, 0xff, %o2
        ld                [ %o3 ], %o5
        sll               %o2, %o0, %o2
        and               %o1, 0xff, %o1
        sll               %o1, %o0, %o1
        andn              %o5, %o4, %o4
        or                %o4, %o2, %o2
        or                %o4, %o1, %o1
        casa              [ %o3 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        srl               %o2, %o0, %o0
        stbar
        retl
        nop
0:
        mov               1, %o1	! 1 <asm_test::compare_exchange_weak::u8::acqrel_relaxed+0x1>
        srl               %o2, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        stbar
        and               %o0, -4, %o3
        mov               3, %o4
        andn              %o4, %o0, %o0
        sll               %o0, 3, %o0
        mov               0xff, %o4
        sll               %o4, %o0, %o4
        and               %o2, 0xff, %o2
        ld                [ %o3 ], %o5
        sll               %o2, %o0, %o2
        and               %o1, 0xff, %o1
        sll               %o1, %o0, %o1
        andn              %o5, %o4, %o4
        or                %o4, %o2, %o2
        or                %o4, %o1, %o1
        casa              [ %o3 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        srl               %o2, %o0, %o0
        stbar
        retl
        nop
0:
        mov               1, %o1	! 1 <asm_test::compare_exchange_weak::u8::acquire_seqcst+0x1>
        srl               %o2, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        stbar
        and               %o0, -4, %o3
        mov               3, %o4
        andn              %o4, %o0, %o0
        sll               %o0, 3, %o0
        mov               0xff, %o4
        sll               %o4, %o0, %o4
        and               %o2, 0xff, %o2
        ld                [ %o3 ], %o5
        sll               %o2, %o0, %o2
        and               %o1, 0xff, %o1
        sll               %o1, %o0, %o1
        andn              %o5, %o4, %o4
        or                %o4, %o2, %o2
        or                %o4, %o1, %o1
        casa              [ %o3 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        srl               %o2, %o0, %o0
        stbar
        retl
        nop
0:
        mov               1, %o1	! 1 <asm_test::compare_exchange_weak::u8::relaxed_seqcst+0x1>
        srl               %o2, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange_weak::u8::release_seqcst:
        stbar
        and               %o0, -4, %o3
        mov               3, %o4
        andn              %o4, %o0, %o0
        sll               %o0, 3, %o0
        mov               0xff, %o4
        sll               %o4, %o0, %o4
        and               %o2, 0xff, %o2
        ld                [ %o3 ], %o5
        sll               %o2, %o0, %o2
        and               %o1, 0xff, %o1
        sll               %o1, %o0, %o1
        andn              %o5, %o4, %o4
        or                %o4, %o2, %o2
        or                %o4, %o1, %o1
        casa              [ %o3 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        srl               %o2, %o0, %o0
        stbar
        retl
        nop
0:
        mov               1, %o1	! 1 <asm_test::compare_exchange_weak::u8::release_seqcst+0x1>
        srl               %o2, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        stbar
        and               %o0, -4, %o3
        mov               3, %o4
        andn              %o4, %o0, %o0
        sll               %o0, 3, %o0
        mov               0xff, %o4
        sll               %o4, %o0, %o4
        and               %o2, 0xff, %o2
        ld                [ %o3 ], %o5
        sll               %o2, %o0, %o2
        and               %o1, 0xff, %o1
        sll               %o1, %o0, %o1
        andn              %o5, %o4, %o4
        or                %o4, %o2, %o2
        or                %o4, %o1, %o1
        casa              [ %o3 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        srl               %o2, %o0, %o0
        stbar
        retl
        nop
0:
        mov               1, %o1	! 1 <asm_test::compare_exchange_weak::u8::seqcst_acquire+0x1>
        srl               %o2, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        stbar
        and               %o0, -4, %o3
        mov               3, %o4
        andn              %o4, %o0, %o0
        sll               %o0, 3, %o0
        mov               0xff, %o4
        sll               %o4, %o0, %o4
        and               %o2, 0xff, %o2
        ld                [ %o3 ], %o5
        sll               %o2, %o0, %o2
        and               %o1, 0xff, %o1
        sll               %o1, %o0, %o1
        andn              %o5, %o4, %o4
        or                %o4, %o2, %o2
        or                %o4, %o1, %o1
        casa              [ %o3 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        srl               %o2, %o0, %o0
        stbar
        retl
        nop
0:
        mov               1, %o1	! 1 <asm_test::compare_exchange_weak::u8::seqcst_relaxed+0x1>
        srl               %o2, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange_weak::u8::acquire_acquire:
        and               %o0, -4, %o3
        mov               3, %o4
        andn              %o4, %o0, %o0
        sll               %o0, 3, %o0
        mov               0xff, %o4
        sll               %o4, %o0, %o4
        and               %o2, 0xff, %o2
        ld                [ %o3 ], %o5
        sll               %o2, %o0, %o2
        and               %o1, 0xff, %o1
        sll               %o1, %o0, %o1
        andn              %o5, %o4, %o4
        or                %o4, %o2, %o2
        or                %o4, %o1, %o1
        casa              [ %o3 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        srl               %o2, %o0, %o0
        stbar
        retl
        nop
0:
        mov               1, %o1	! 1 <asm_test::compare_exchange_weak::u8::acquire_acquire+0x1>
        srl               %o2, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        and               %o0, -4, %o3
        mov               3, %o4
        andn              %o4, %o0, %o0
        sll               %o0, 3, %o0
        mov               0xff, %o4
        sll               %o4, %o0, %o4
        and               %o2, 0xff, %o2
        ld                [ %o3 ], %o5
        sll               %o2, %o0, %o2
        and               %o1, 0xff, %o1
        sll               %o1, %o0, %o1
        andn              %o5, %o4, %o4
        or                %o4, %o2, %o2
        or                %o4, %o1, %o1
        casa              [ %o3 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        srl               %o2, %o0, %o0
        stbar
        retl
        nop
0:
        mov               1, %o1	! 1 <asm_test::compare_exchange_weak::u8::acquire_relaxed+0x1>
        srl               %o2, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        and               %o0, -4, %o3
        mov               3, %o4
        andn              %o4, %o0, %o0
        sll               %o0, 3, %o0
        mov               0xff, %o4
        sll               %o4, %o0, %o4
        and               %o2, 0xff, %o2
        ld                [ %o3 ], %o5
        sll               %o2, %o0, %o2
        and               %o1, 0xff, %o1
        sll               %o1, %o0, %o1
        andn              %o5, %o4, %o4
        or                %o4, %o2, %o2
        or                %o4, %o1, %o1
        casa              [ %o3 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        srl               %o2, %o0, %o0
        stbar
        retl
        nop
0:
        mov               1, %o1	! 1 <asm_test::compare_exchange_weak::u8::relaxed_acquire+0x1>
        srl               %o2, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        and               %o0, -4, %o3
        mov               3, %o4
        andn              %o4, %o0, %o0
        sll               %o0, 3, %o0
        mov               0xff, %o4
        sll               %o4, %o0, %o4
        and               %o2, 0xff, %o2
        ld                [ %o3 ], %o5
        sll               %o2, %o0, %o2
        and               %o1, 0xff, %o1
        sll               %o1, %o0, %o1
        andn              %o5, %o4, %o4
        or                %o4, %o2, %o2
        or                %o4, %o1, %o1
        casa              [ %o3 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        retl
        srl               %o2, %o0, %o0
0:
        mov               1, %o1
        retl
        srl               %o2, %o0, %o0

asm_test::compare_exchange_weak::u8::release_acquire:
        stbar
        and               %o0, -4, %o3
        mov               3, %o4
        andn              %o4, %o0, %o0
        sll               %o0, 3, %o0
        mov               0xff, %o4
        sll               %o4, %o0, %o4
        and               %o2, 0xff, %o2
        ld                [ %o3 ], %o5
        sll               %o2, %o0, %o2
        and               %o1, 0xff, %o1
        sll               %o1, %o0, %o1
        andn              %o5, %o4, %o4
        or                %o4, %o2, %o2
        or                %o4, %o1, %o1
        casa              [ %o3 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        srl               %o2, %o0, %o0
        stbar
        retl
        nop
0:
        mov               1, %o1	! 1 <asm_test::compare_exchange_weak::u8::release_acquire+0x1>
        srl               %o2, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange_weak::u8::release_relaxed:
        stbar
        and               %o0, -4, %o3
        mov               3, %o4
        andn              %o4, %o0, %o0
        sll               %o0, 3, %o0
        mov               0xff, %o4
        sll               %o4, %o0, %o4
        and               %o2, 0xff, %o2
        ld                [ %o3 ], %o5
        sll               %o2, %o0, %o2
        and               %o1, 0xff, %o1
        sll               %o1, %o0, %o1
        andn              %o5, %o4, %o4
        or                %o4, %o2, %o2
        or                %o4, %o1, %o1
        casa              [ %o3 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        retl
        srl               %o2, %o0, %o0
0:
        mov               1, %o1
        retl
        srl               %o2, %o0, %o0

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        stbar
        and               %o0, -4, %o3
        and               %o0, 3, %o0
        xor               %o0, 2, %o0
        sll               %o0, 3, %o0
        sethi             %hi(0xfc00), %o4
        or                %o4, 0x3ff, %o4	! ffff <asm_test::compare_exchange_weak::u16::acqrel_seqcst+0xffff>
        and               %o2, %o4, %o2
        and               %o1, %o4, %o5
        ld                [ %o3 ], %g2
        sll               %o4, %o0, %g3
        sll               %o2, %o0, %o1
        sll               %o5, %o0, %o4
        andn              %g2, %g3, %o5
        or                %o5, %o1, %o2
        or                %o5, %o4, %o1
        casa              [ %o3 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        srl               %o2, %o0, %o0
        stbar
        retl
        nop
0:
        mov               1, %o1	! 1 <asm_test::compare_exchange_weak::u16::acqrel_seqcst+0x1>
        srl               %o2, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        stbar
        and               %o0, -4, %o3
        and               %o0, 3, %o0
        xor               %o0, 2, %o0
        sll               %o0, 3, %o0
        sethi             %hi(0xfc00), %o4
        or                %o4, 0x3ff, %o4	! ffff <asm_test::compare_exchange_weak::u16::seqcst_seqcst+0xffff>
        and               %o2, %o4, %o2
        and               %o1, %o4, %o5
        ld                [ %o3 ], %g2
        sll               %o4, %o0, %g3
        sll               %o2, %o0, %o1
        sll               %o5, %o0, %o4
        andn              %g2, %g3, %o5
        or                %o5, %o1, %o2
        or                %o5, %o4, %o1
        casa              [ %o3 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        srl               %o2, %o0, %o0
        stbar
        retl
        nop
0:
        mov               1, %o1	! 1 <asm_test::compare_exchange_weak::u16::seqcst_seqcst+0x1>
        srl               %o2, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        stbar
        and               %o0, -4, %o3
        and               %o0, 3, %o0
        xor               %o0, 2, %o0
        sll               %o0, 3, %o0
        sethi             %hi(0xfc00), %o4
        or                %o4, 0x3ff, %o4	! ffff <asm_test::compare_exchange_weak::u16::acqrel_acquire+0xffff>
        and               %o2, %o4, %o2
        and               %o1, %o4, %o5
        ld                [ %o3 ], %g2
        sll               %o4, %o0, %g3
        sll               %o2, %o0, %o1
        sll               %o5, %o0, %o4
        andn              %g2, %g3, %o5
        or                %o5, %o1, %o2
        or                %o5, %o4, %o1
        casa              [ %o3 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        srl               %o2, %o0, %o0
        stbar
        retl
        nop
0:
        mov               1, %o1	! 1 <asm_test::compare_exchange_weak::u16::acqrel_acquire+0x1>
        srl               %o2, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        stbar
        and               %o0, -4, %o3
        and               %o0, 3, %o0
        xor               %o0, 2, %o0
        sll               %o0, 3, %o0
        sethi             %hi(0xfc00), %o4
        or                %o4, 0x3ff, %o4	! ffff <asm_test::compare_exchange_weak::u16::acqrel_relaxed+0xffff>
        and               %o2, %o4, %o2
        and               %o1, %o4, %o5
        ld                [ %o3 ], %g2
        sll               %o4, %o0, %g3
        sll               %o2, %o0, %o1
        sll               %o5, %o0, %o4
        andn              %g2, %g3, %o5
        or                %o5, %o1, %o2
        or                %o5, %o4, %o1
        casa              [ %o3 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        srl               %o2, %o0, %o0
        stbar
        retl
        nop
0:
        mov               1, %o1	! 1 <asm_test::compare_exchange_weak::u16::acqrel_relaxed+0x1>
        srl               %o2, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        stbar
        and               %o0, -4, %o3
        and               %o0, 3, %o0
        xor               %o0, 2, %o0
        sll               %o0, 3, %o0
        sethi             %hi(0xfc00), %o4
        or                %o4, 0x3ff, %o4	! ffff <asm_test::compare_exchange_weak::u16::acquire_seqcst+0xffff>
        and               %o2, %o4, %o2
        and               %o1, %o4, %o5
        ld                [ %o3 ], %g2
        sll               %o4, %o0, %g3
        sll               %o2, %o0, %o1
        sll               %o5, %o0, %o4
        andn              %g2, %g3, %o5
        or                %o5, %o1, %o2
        or                %o5, %o4, %o1
        casa              [ %o3 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        srl               %o2, %o0, %o0
        stbar
        retl
        nop
0:
        mov               1, %o1	! 1 <asm_test::compare_exchange_weak::u16::acquire_seqcst+0x1>
        srl               %o2, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        stbar
        and               %o0, -4, %o3
        and               %o0, 3, %o0
        xor               %o0, 2, %o0
        sll               %o0, 3, %o0
        sethi             %hi(0xfc00), %o4
        or                %o4, 0x3ff, %o4	! ffff <asm_test::compare_exchange_weak::u16::relaxed_seqcst+0xffff>
        and               %o2, %o4, %o2
        and               %o1, %o4, %o5
        ld                [ %o3 ], %g2
        sll               %o4, %o0, %g3
        sll               %o2, %o0, %o1
        sll               %o5, %o0, %o4
        andn              %g2, %g3, %o5
        or                %o5, %o1, %o2
        or                %o5, %o4, %o1
        casa              [ %o3 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        srl               %o2, %o0, %o0
        stbar
        retl
        nop
0:
        mov               1, %o1	! 1 <asm_test::compare_exchange_weak::u16::relaxed_seqcst+0x1>
        srl               %o2, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange_weak::u16::release_seqcst:
        stbar
        and               %o0, -4, %o3
        and               %o0, 3, %o0
        xor               %o0, 2, %o0
        sll               %o0, 3, %o0
        sethi             %hi(0xfc00), %o4
        or                %o4, 0x3ff, %o4	! ffff <asm_test::compare_exchange_weak::u16::release_seqcst+0xffff>
        and               %o2, %o4, %o2
        and               %o1, %o4, %o5
        ld                [ %o3 ], %g2
        sll               %o4, %o0, %g3
        sll               %o2, %o0, %o1
        sll               %o5, %o0, %o4
        andn              %g2, %g3, %o5
        or                %o5, %o1, %o2
        or                %o5, %o4, %o1
        casa              [ %o3 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        srl               %o2, %o0, %o0
        stbar
        retl
        nop
0:
        mov               1, %o1	! 1 <asm_test::compare_exchange_weak::u16::release_seqcst+0x1>
        srl               %o2, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        stbar
        and               %o0, -4, %o3
        and               %o0, 3, %o0
        xor               %o0, 2, %o0
        sll               %o0, 3, %o0
        sethi             %hi(0xfc00), %o4
        or                %o4, 0x3ff, %o4	! ffff <asm_test::compare_exchange_weak::u16::seqcst_acquire+0xffff>
        and               %o2, %o4, %o2
        and               %o1, %o4, %o5
        ld                [ %o3 ], %g2
        sll               %o4, %o0, %g3
        sll               %o2, %o0, %o1
        sll               %o5, %o0, %o4
        andn              %g2, %g3, %o5
        or                %o5, %o1, %o2
        or                %o5, %o4, %o1
        casa              [ %o3 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        srl               %o2, %o0, %o0
        stbar
        retl
        nop
0:
        mov               1, %o1	! 1 <asm_test::compare_exchange_weak::u16::seqcst_acquire+0x1>
        srl               %o2, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        stbar
        and               %o0, -4, %o3
        and               %o0, 3, %o0
        xor               %o0, 2, %o0
        sll               %o0, 3, %o0
        sethi             %hi(0xfc00), %o4
        or                %o4, 0x3ff, %o4	! ffff <asm_test::compare_exchange_weak::u16::seqcst_relaxed+0xffff>
        and               %o2, %o4, %o2
        and               %o1, %o4, %o5
        ld                [ %o3 ], %g2
        sll               %o4, %o0, %g3
        sll               %o2, %o0, %o1
        sll               %o5, %o0, %o4
        andn              %g2, %g3, %o5
        or                %o5, %o1, %o2
        or                %o5, %o4, %o1
        casa              [ %o3 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        srl               %o2, %o0, %o0
        stbar
        retl
        nop
0:
        mov               1, %o1	! 1 <asm_test::compare_exchange_weak::u16::seqcst_relaxed+0x1>
        srl               %o2, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange_weak::u16::acquire_acquire:
        and               %o0, -4, %o3
        and               %o0, 3, %o0
        xor               %o0, 2, %o0
        sll               %o0, 3, %o0
        sethi             %hi(0xfc00), %o4
        or                %o4, 0x3ff, %o4	! ffff <asm_test::compare_exchange_weak::u16::acquire_acquire+0xffff>
        and               %o2, %o4, %o2
        and               %o1, %o4, %o5
        ld                [ %o3 ], %g2
        sll               %o4, %o0, %g3
        sll               %o2, %o0, %o1
        sll               %o5, %o0, %o4
        andn              %g2, %g3, %o5
        or                %o5, %o1, %o2
        or                %o5, %o4, %o1
        casa              [ %o3 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        srl               %o2, %o0, %o0
        stbar
        retl
        nop
0:
        mov               1, %o1	! 1 <asm_test::compare_exchange_weak::u16::acquire_acquire+0x1>
        srl               %o2, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        and               %o0, -4, %o3
        and               %o0, 3, %o0
        xor               %o0, 2, %o0
        sll               %o0, 3, %o0
        sethi             %hi(0xfc00), %o4
        or                %o4, 0x3ff, %o4	! ffff <asm_test::compare_exchange_weak::u16::acquire_relaxed+0xffff>
        and               %o2, %o4, %o2
        and               %o1, %o4, %o5
        ld                [ %o3 ], %g2
        sll               %o4, %o0, %g3
        sll               %o2, %o0, %o1
        sll               %o5, %o0, %o4
        andn              %g2, %g3, %o5
        or                %o5, %o1, %o2
        or                %o5, %o4, %o1
        casa              [ %o3 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        srl               %o2, %o0, %o0
        stbar
        retl
        nop
0:
        mov               1, %o1	! 1 <asm_test::compare_exchange_weak::u16::acquire_relaxed+0x1>
        srl               %o2, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        and               %o0, -4, %o3
        and               %o0, 3, %o0
        xor               %o0, 2, %o0
        sll               %o0, 3, %o0
        sethi             %hi(0xfc00), %o4
        or                %o4, 0x3ff, %o4	! ffff <asm_test::compare_exchange_weak::u16::relaxed_acquire+0xffff>
        and               %o2, %o4, %o2
        and               %o1, %o4, %o5
        ld                [ %o3 ], %g2
        sll               %o4, %o0, %g3
        sll               %o2, %o0, %o1
        sll               %o5, %o0, %o4
        andn              %g2, %g3, %o5
        or                %o5, %o1, %o2
        or                %o5, %o4, %o1
        casa              [ %o3 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        srl               %o2, %o0, %o0
        stbar
        retl
        nop
0:
        mov               1, %o1	! 1 <asm_test::compare_exchange_weak::u16::relaxed_acquire+0x1>
        srl               %o2, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        and               %o0, -4, %o3
        and               %o0, 3, %o0
        xor               %o0, 2, %o0
        sll               %o0, 3, %o0
        sethi             %hi(0xfc00), %o4
        or                %o4, 0x3ff, %o4	! ffff <asm_test::compare_exchange_weak::u16::relaxed_relaxed+0xffff>
        and               %o2, %o4, %o2
        and               %o1, %o4, %o5
        ld                [ %o3 ], %g2
        sll               %o4, %o0, %g3
        sll               %o2, %o0, %o1
        sll               %o5, %o0, %o4
        andn              %g2, %g3, %o5
        or                %o5, %o1, %o2
        or                %o5, %o4, %o1
        casa              [ %o3 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        retl
        srl               %o2, %o0, %o0
0:
        mov               1, %o1
        retl
        srl               %o2, %o0, %o0

asm_test::compare_exchange_weak::u16::release_acquire:
        stbar
        and               %o0, -4, %o3
        and               %o0, 3, %o0
        xor               %o0, 2, %o0
        sll               %o0, 3, %o0
        sethi             %hi(0xfc00), %o4
        or                %o4, 0x3ff, %o4	! ffff <asm_test::compare_exchange_weak::u16::release_acquire+0xffff>
        and               %o2, %o4, %o2
        and               %o1, %o4, %o5
        ld                [ %o3 ], %g2
        sll               %o4, %o0, %g3
        sll               %o2, %o0, %o1
        sll               %o5, %o0, %o4
        andn              %g2, %g3, %o5
        or                %o5, %o1, %o2
        or                %o5, %o4, %o1
        casa              [ %o3 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        srl               %o2, %o0, %o0
        stbar
        retl
        nop
0:
        mov               1, %o1	! 1 <asm_test::compare_exchange_weak::u16::release_acquire+0x1>
        srl               %o2, %o0, %o0
        stbar
        retl
        nop

asm_test::compare_exchange_weak::u16::release_relaxed:
        stbar
        and               %o0, -4, %o3
        and               %o0, 3, %o0
        xor               %o0, 2, %o0
        sll               %o0, 3, %o0
        sethi             %hi(0xfc00), %o4
        or                %o4, 0x3ff, %o4	! ffff <asm_test::compare_exchange_weak::u16::release_relaxed+0xffff>
        and               %o2, %o4, %o2
        and               %o1, %o4, %o5
        ld                [ %o3 ], %g2
        sll               %o4, %o0, %g3
        sll               %o2, %o0, %o1
        sll               %o5, %o0, %o4
        andn              %g2, %g3, %o5
        or                %o5, %o1, %o2
        or                %o5, %o4, %o1
        casa              [ %o3 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        retl
        srl               %o2, %o0, %o0
0:
        mov               1, %o1
        retl
        srl               %o2, %o0, %o0

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        stbar
        casa              [ %o0 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        stbar
        retl
        mov               %o2, %o0
0:
        mov               1, %o1
        stbar
        retl
        mov               %o2, %o0

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        stbar
        casa              [ %o0 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        stbar
        retl
        mov               %o2, %o0
0:
        mov               1, %o1
        stbar
        retl
        mov               %o2, %o0

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        stbar
        casa              [ %o0 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        stbar
        retl
        mov               %o2, %o0
0:
        mov               1, %o1
        stbar
        retl
        mov               %o2, %o0

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        stbar
        casa              [ %o0 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        stbar
        retl
        mov               %o2, %o0
0:
        mov               1, %o1
        stbar
        retl
        mov               %o2, %o0

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        stbar
        casa              [ %o0 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        stbar
        retl
        mov               %o2, %o0
0:
        mov               1, %o1
        stbar
        retl
        mov               %o2, %o0

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        stbar
        casa              [ %o0 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        stbar
        retl
        mov               %o2, %o0
0:
        mov               1, %o1
        stbar
        retl
        mov               %o2, %o0

asm_test::compare_exchange_weak::u32::release_seqcst:
        stbar
        casa              [ %o0 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        stbar
        retl
        mov               %o2, %o0
0:
        mov               1, %o1
        stbar
        retl
        mov               %o2, %o0

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        stbar
        casa              [ %o0 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        stbar
        retl
        mov               %o2, %o0
0:
        mov               1, %o1
        stbar
        retl
        mov               %o2, %o0

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        stbar
        casa              [ %o0 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        stbar
        retl
        mov               %o2, %o0
0:
        mov               1, %o1
        stbar
        retl
        mov               %o2, %o0

asm_test::compare_exchange_weak::u32::acquire_acquire:
        casa              [ %o0 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        stbar
        retl
        mov               %o2, %o0
0:
        mov               1, %o1
        stbar
        retl
        mov               %o2, %o0

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        casa              [ %o0 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        stbar
        retl
        mov               %o2, %o0
0:
        mov               1, %o1
        stbar
        retl
        mov               %o2, %o0

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        casa              [ %o0 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        stbar
        retl
        mov               %o2, %o0
0:
        mov               1, %o1
        stbar
        retl
        mov               %o2, %o0

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        casa              [ %o0 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        retl
        mov               %o2, %o0
0:
        mov               1, %o1
        retl
        mov               %o2, %o0

asm_test::compare_exchange_weak::u32::release_acquire:
        stbar
        casa              [ %o0 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        stbar
        retl
        mov               %o2, %o0
0:
        mov               1, %o1
        stbar
        retl
        mov               %o2, %o0

asm_test::compare_exchange_weak::u32::release_relaxed:
        stbar
        casa              [ %o0 ] (10), %o1, %o2
        cmp               %o2, %o1
        be                0f
        nop
        mov               %g0, %o1
        retl
        mov               %o2, %o0
0:
        mov               1, %o1
        retl
        mov               %o2, %o0

asm_test::load::u8::seqcst:
        ldub              [ %o0 ], %o0
        stbar
        retl
        nop

asm_test::load::u8::acquire:
        ldub              [ %o0 ], %o0
        stbar
        retl
        nop

asm_test::load::u8::relaxed:
        retl
        ldub              [ %o0 ], %o0

asm_test::load::u16::seqcst:
        lduh              [ %o0 ], %o0
        stbar
        retl
        nop

asm_test::load::u16::acquire:
        lduh              [ %o0 ], %o0
        stbar
        retl
        nop

asm_test::load::u16::relaxed:
        retl
        lduh              [ %o0 ], %o0

asm_test::load::u32::seqcst:
        ld                [ %o0 ], %o0
        stbar
        retl
        nop

asm_test::load::u32::acquire:
        ld                [ %o0 ], %o0
        stbar
        retl
        nop

asm_test::load::u32::relaxed:
        retl
        ld                [ %o0 ], %o0

asm_test::swap::u8::acqrel:
        stbar
        and               %o0, -4, %o2
        mov               3, %o3
        andn              %o3, %o0, %o0
        sll               %o0, 3, %o0
        mov               0xff, %o3
        sll               %o3, %o0, %o3
        xor               %o3, -1, %o3
        and               %o1, 0xff, %o1
        sll               %o1, %o0, %o1
        b                 1f
        ld                [ %o2 ], %o4
0:
        mov               %g0, %o5
        cmp               %o5, 1
        be                2f
        nop
1:
        mov               %o4, %o5
        and               %o4, %o3, %o4
        or                %o4, %o1, %o4
        casa              [ %o2 ] (10), %o5, %o4
        cmp               %o4, %o5
        bne               0b
        nop
        mov               1, %o5	! 1 <asm_test::swap::u8::acqrel+0x1>
        cmp               %o5, 1
        bne               1b
        nop
2:
        srl               %o4, %o0, %o0
        stbar
        retl
        nop

asm_test::swap::u8::seqcst:
        stbar
        and               %o0, -4, %o2
        mov               3, %o3
        andn              %o3, %o0, %o0
        sll               %o0, 3, %o0
        mov               0xff, %o3
        sll               %o3, %o0, %o3
        xor               %o3, -1, %o3
        and               %o1, 0xff, %o1
        sll               %o1, %o0, %o1
        b                 1f
        ld                [ %o2 ], %o4
0:
        mov               %g0, %o5
        cmp               %o5, 1
        be                2f
        nop
1:
        mov               %o4, %o5
        and               %o4, %o3, %o4
        or                %o4, %o1, %o4
        casa              [ %o2 ] (10), %o5, %o4
        cmp               %o4, %o5
        bne               0b
        nop
        mov               1, %o5	! 1 <asm_test::swap::u8::seqcst+0x1>
        cmp               %o5, 1
        bne               1b
        nop
2:
        srl               %o4, %o0, %o0
        stbar
        retl
        nop

asm_test::swap::u8::acquire:
        and               %o0, -4, %o2
        mov               3, %o3
        andn              %o3, %o0, %o0
        sll               %o0, 3, %o0
        mov               0xff, %o3
        sll               %o3, %o0, %o3
        xor               %o3, -1, %o3
        and               %o1, 0xff, %o1
        sll               %o1, %o0, %o1
        b                 1f
        ld                [ %o2 ], %o4
0:
        mov               %g0, %o5
        cmp               %o5, 1
        be                2f
        nop
1:
        mov               %o4, %o5
        and               %o4, %o3, %o4
        or                %o4, %o1, %o4
        casa              [ %o2 ] (10), %o5, %o4
        cmp               %o4, %o5
        bne               0b
        nop
        mov               1, %o5	! 1 <asm_test::swap::u8::acquire+0x1>
        cmp               %o5, 1
        bne               1b
        nop
2:
        srl               %o4, %o0, %o0
        stbar
        retl
        nop

asm_test::swap::u8::relaxed:
        and               %o0, -4, %o2
        mov               3, %o3
        andn              %o3, %o0, %o0
        sll               %o0, 3, %o0
        mov               0xff, %o3
        sll               %o3, %o0, %o3
        xor               %o3, -1, %o3
        and               %o1, 0xff, %o1
        sll               %o1, %o0, %o1
        b                 1f
        ld                [ %o2 ], %o4
0:
        mov               %g0, %o5
        cmp               %o5, 1
        be                2f
        nop
1:
        mov               %o4, %o5
        and               %o4, %o3, %o4
        or                %o4, %o1, %o4
        casa              [ %o2 ] (10), %o5, %o4
        cmp               %o4, %o5
        bne               0b
        nop
        mov               1, %o5	! 1 <asm_test::swap::u8::relaxed+0x1>
        cmp               %o5, 1
        bne               1b
        nop
2:
        retl
        srl               %o4, %o0, %o0

asm_test::swap::u8::release:
        stbar
        and               %o0, -4, %o2
        mov               3, %o3
        andn              %o3, %o0, %o0
        sll               %o0, 3, %o0
        mov               0xff, %o3
        sll               %o3, %o0, %o3
        xor               %o3, -1, %o3
        and               %o1, 0xff, %o1
        sll               %o1, %o0, %o1
        b                 1f
        ld                [ %o2 ], %o4
0:
        mov               %g0, %o5
        cmp               %o5, 1
        be                2f
        nop
1:
        mov               %o4, %o5
        and               %o4, %o3, %o4
        or                %o4, %o1, %o4
        casa              [ %o2 ] (10), %o5, %o4
        cmp               %o4, %o5
        bne               0b
        nop
        mov               1, %o5	! 1 <asm_test::swap::u8::release+0x1>
        cmp               %o5, 1
        bne               1b
        nop
2:
        retl
        srl               %o4, %o0, %o0

asm_test::swap::u16::acqrel:
        stbar
        and               %o0, -4, %o2
        and               %o0, 3, %o0
        xor               %o0, 2, %o0
        sll               %o0, 3, %o0
        sethi             %hi(0xfc00), %o3
        or                %o3, 0x3ff, %o4	! ffff <asm_test::swap::u16::acqrel+0xffff>
        sll               %o4, %o0, %o3
        xor               %o3, -1, %o3
        and               %o1, %o4, %o1
        sll               %o1, %o0, %o1
        b                 1f
        ld                [ %o2 ], %o4
0:
        mov               %g0, %o5
        cmp               %o5, 1
        be                2f
        nop
1:
        mov               %o4, %o5
        and               %o4, %o3, %o4
        or                %o4, %o1, %o4
        casa              [ %o2 ] (10), %o5, %o4
        cmp               %o4, %o5
        bne               0b
        nop
        mov               1, %o5	! 1 <asm_test::swap::u16::acqrel+0x1>
        cmp               %o5, 1
        bne               1b
        nop
2:
        srl               %o4, %o0, %o0
        stbar
        retl
        nop

asm_test::swap::u16::seqcst:
        stbar
        and               %o0, -4, %o2
        and               %o0, 3, %o0
        xor               %o0, 2, %o0
        sll               %o0, 3, %o0
        sethi             %hi(0xfc00), %o3
        or                %o3, 0x3ff, %o4	! ffff <asm_test::swap::u16::seqcst+0xffff>
        sll               %o4, %o0, %o3
        xor               %o3, -1, %o3
        and               %o1, %o4, %o1
        sll               %o1, %o0, %o1
        b                 1f
        ld                [ %o2 ], %o4
0:
        mov               %g0, %o5
        cmp               %o5, 1
        be                2f
        nop
1:
        mov               %o4, %o5
        and               %o4, %o3, %o4
        or                %o4, %o1, %o4
        casa              [ %o2 ] (10), %o5, %o4
        cmp               %o4, %o5
        bne               0b
        nop
        mov               1, %o5	! 1 <asm_test::swap::u16::seqcst+0x1>
        cmp               %o5, 1
        bne               1b
        nop
2:
        srl               %o4, %o0, %o0
        stbar
        retl
        nop

asm_test::swap::u16::acquire:
        and               %o0, -4, %o2
        and               %o0, 3, %o0
        xor               %o0, 2, %o0
        sll               %o0, 3, %o0
        sethi             %hi(0xfc00), %o3
        or                %o3, 0x3ff, %o4	! ffff <asm_test::swap::u16::acquire+0xffff>
        sll               %o4, %o0, %o3
        xor               %o3, -1, %o3
        and               %o1, %o4, %o1
        sll               %o1, %o0, %o1
        b                 1f
        ld                [ %o2 ], %o4
0:
        mov               %g0, %o5
        cmp               %o5, 1
        be                2f
        nop
1:
        mov               %o4, %o5
        and               %o4, %o3, %o4
        or                %o4, %o1, %o4
        casa              [ %o2 ] (10), %o5, %o4
        cmp               %o4, %o5
        bne               0b
        nop
        mov               1, %o5	! 1 <asm_test::swap::u16::acquire+0x1>
        cmp               %o5, 1
        bne               1b
        nop
2:
        srl               %o4, %o0, %o0
        stbar
        retl
        nop

asm_test::swap::u16::relaxed:
        and               %o0, -4, %o2
        and               %o0, 3, %o0
        xor               %o0, 2, %o0
        sll               %o0, 3, %o0
        sethi             %hi(0xfc00), %o3
        or                %o3, 0x3ff, %o4	! ffff <asm_test::swap::u16::relaxed+0xffff>
        sll               %o4, %o0, %o3
        xor               %o3, -1, %o3
        and               %o1, %o4, %o1
        sll               %o1, %o0, %o1
        b                 1f
        ld                [ %o2 ], %o4
0:
        mov               %g0, %o5
        cmp               %o5, 1
        be                2f
        nop
1:
        mov               %o4, %o5
        and               %o4, %o3, %o4
        or                %o4, %o1, %o4
        casa              [ %o2 ] (10), %o5, %o4
        cmp               %o4, %o5
        bne               0b
        nop
        mov               1, %o5	! 1 <asm_test::swap::u16::relaxed+0x1>
        cmp               %o5, 1
        bne               1b
        nop
2:
        retl
        srl               %o4, %o0, %o0

asm_test::swap::u16::release:
        stbar
        and               %o0, -4, %o2
        and               %o0, 3, %o0
        xor               %o0, 2, %o0
        sll               %o0, 3, %o0
        sethi             %hi(0xfc00), %o3
        or                %o3, 0x3ff, %o4	! ffff <asm_test::swap::u16::release+0xffff>
        sll               %o4, %o0, %o3
        xor               %o3, -1, %o3
        and               %o1, %o4, %o1
        sll               %o1, %o0, %o1
        b                 1f
        ld                [ %o2 ], %o4
0:
        mov               %g0, %o5
        cmp               %o5, 1
        be                2f
        nop
1:
        mov               %o4, %o5
        and               %o4, %o3, %o4
        or                %o4, %o1, %o4
        casa              [ %o2 ] (10), %o5, %o4
        cmp               %o4, %o5
        bne               0b
        nop
        mov               1, %o5	! 1 <asm_test::swap::u16::release+0x1>
        cmp               %o5, 1
        bne               1b
        nop
2:
        retl
        srl               %o4, %o0, %o0

asm_test::swap::u32::acqrel:
        stbar
        swap              [ %o0 ], %o1
        stbar
        retl
        mov               %o1, %o0

asm_test::swap::u32::seqcst:
        stbar
        swap              [ %o0 ], %o1
        stbar
        retl
        mov               %o1, %o0

asm_test::swap::u32::acquire:
        swap              [ %o0 ], %o1
        stbar
        retl
        mov               %o1, %o0

asm_test::swap::u32::relaxed:
        swap              [ %o0 ], %o1
        retl
        mov               %o1, %o0

asm_test::swap::u32::release:
        stbar
        swap              [ %o0 ], %o1
        retl
        mov               %o1, %o0

asm_test::store::u8::seqcst:
        stbar
        stb               %o1, [ %o0 ]
        stbar
        retl
        nop

asm_test::store::u8::relaxed:
        retl
        stb               %o1, [ %o0 ]

asm_test::store::u8::release:
        stbar
        retl
        stb               %o1, [ %o0 ]

asm_test::store::u16::seqcst:
        stbar
        sth               %o1, [ %o0 ]
        stbar
        retl
        nop

asm_test::store::u16::relaxed:
        retl
        sth               %o1, [ %o0 ]

asm_test::store::u16::release:
        stbar
        retl
        sth               %o1, [ %o0 ]

asm_test::store::u32::seqcst:
        stbar
        st                %o1, [ %o0 ]
        stbar
        retl
        nop

asm_test::store::u32::relaxed:
        retl
        st                %o1, [ %o0 ]

asm_test::store::u32::release:
        stbar
        retl
        st                %o1, [ %o0 ]

