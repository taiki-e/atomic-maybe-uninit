asm_test::compare_exchange::u8::acqrel_seqcst:
        membar            #StoreStore|#LoadStore
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
        or                %g2, %o5, %g4
        cas               [ %o3 ], %g4, %g3
        mov               %g0, %o1
        cmp               %g3, %g4
        move              %icc, 1, %o1
        cmp               %o1, 0
        bne               %icc, 1f
        nop
        and               %g3, %o4, %g4
        cmp               %g2, %g4
        bne               %icc, 0b
        mov               %g4, %g2
1:
        srl               %g3, %o0, %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::compare_exchange::u8::seqcst_seqcst:
        membar            #StoreStore|#LoadStore
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
        or                %g2, %o5, %g4
        cas               [ %o3 ], %g4, %g3
        mov               %g0, %o1
        cmp               %g3, %g4
        move              %icc, 1, %o1
        cmp               %o1, 0
        bne               %icc, 1f
        nop
        and               %g3, %o4, %g4
        cmp               %g2, %g4
        bne               %icc, 0b
        mov               %g4, %g2
1:
        srl               %g3, %o0, %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::compare_exchange::u8::acqrel_acquire:
        membar            #StoreStore|#LoadStore
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
        or                %g2, %o5, %g4
        cas               [ %o3 ], %g4, %g3
        mov               %g0, %o1
        cmp               %g3, %g4
        move              %icc, 1, %o1
        cmp               %o1, 0
        bne               %icc, 1f
        nop
        and               %g3, %o4, %g4
        cmp               %g2, %g4
        bne               %icc, 0b
        mov               %g4, %g2
1:
        srl               %g3, %o0, %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::compare_exchange::u8::acqrel_relaxed:
        membar            #StoreStore|#LoadStore
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
        or                %g2, %o5, %g4
        cas               [ %o3 ], %g4, %g3
        mov               %g0, %o1
        cmp               %g3, %g4
        move              %icc, 1, %o1
        cmp               %o1, 0
        bne               %icc, 1f
        nop
        and               %g3, %o4, %g4
        cmp               %g2, %g4
        bne               %icc, 0b
        mov               %g4, %g2
1:
        srl               %g3, %o0, %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::compare_exchange::u8::acquire_seqcst:
        membar            #StoreStore|#LoadStore
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
        or                %g2, %o5, %g4
        cas               [ %o3 ], %g4, %g3
        mov               %g0, %o1
        cmp               %g3, %g4
        move              %icc, 1, %o1
        cmp               %o1, 0
        bne               %icc, 1f
        nop
        and               %g3, %o4, %g4
        cmp               %g2, %g4
        bne               %icc, 0b
        mov               %g4, %g2
1:
        srl               %g3, %o0, %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::compare_exchange::u8::relaxed_seqcst:
        membar            #StoreStore|#LoadStore
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
        or                %g2, %o5, %g4
        cas               [ %o3 ], %g4, %g3
        mov               %g0, %o1
        cmp               %g3, %g4
        move              %icc, 1, %o1
        cmp               %o1, 0
        bne               %icc, 1f
        nop
        and               %g3, %o4, %g4
        cmp               %g2, %g4
        bne               %icc, 0b
        mov               %g4, %g2
1:
        srl               %g3, %o0, %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::compare_exchange::u8::release_seqcst:
        membar            #StoreStore|#LoadStore
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
        or                %g2, %o5, %g4
        cas               [ %o3 ], %g4, %g3
        mov               %g0, %o1
        cmp               %g3, %g4
        move              %icc, 1, %o1
        cmp               %o1, 0
        bne               %icc, 1f
        nop
        and               %g3, %o4, %g4
        cmp               %g2, %g4
        bne               %icc, 0b
        mov               %g4, %g2
1:
        srl               %g3, %o0, %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::compare_exchange::u8::seqcst_acquire:
        membar            #StoreStore|#LoadStore
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
        or                %g2, %o5, %g4
        cas               [ %o3 ], %g4, %g3
        mov               %g0, %o1
        cmp               %g3, %g4
        move              %icc, 1, %o1
        cmp               %o1, 0
        bne               %icc, 1f
        nop
        and               %g3, %o4, %g4
        cmp               %g2, %g4
        bne               %icc, 0b
        mov               %g4, %g2
1:
        srl               %g3, %o0, %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::compare_exchange::u8::seqcst_relaxed:
        membar            #StoreStore|#LoadStore
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
        or                %g2, %o5, %g4
        cas               [ %o3 ], %g4, %g3
        mov               %g0, %o1
        cmp               %g3, %g4
        move              %icc, 1, %o1
        cmp               %o1, 0
        bne               %icc, 1f
        nop
        and               %g3, %o4, %g4
        cmp               %g2, %g4
        bne               %icc, 0b
        mov               %g4, %g2
1:
        srl               %g3, %o0, %o0
        membar            #LoadStore|#LoadLoad
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
        or                %g2, %o5, %g4
        cas               [ %o3 ], %g4, %g3
        mov               %g0, %o1
        cmp               %g3, %g4
        move              %icc, 1, %o1
        cmp               %o1, 0
        bne               %icc, 1f
        nop
        and               %g3, %o4, %g4
        cmp               %g2, %g4
        bne               %icc, 0b
        mov               %g4, %g2
1:
        srl               %g3, %o0, %o0
        membar            #LoadStore|#LoadLoad
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
        or                %g2, %o5, %g4
        cas               [ %o3 ], %g4, %g3
        mov               %g0, %o1
        cmp               %g3, %g4
        move              %icc, 1, %o1
        cmp               %o1, 0
        bne               %icc, 1f
        nop
        and               %g3, %o4, %g4
        cmp               %g2, %g4
        bne               %icc, 0b
        mov               %g4, %g2
1:
        srl               %g3, %o0, %o0
        membar            #LoadStore|#LoadLoad
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
        or                %g2, %o5, %g4
        cas               [ %o3 ], %g4, %g3
        mov               %g0, %o1
        cmp               %g3, %g4
        move              %icc, 1, %o1
        cmp               %o1, 0
        bne               %icc, 1f
        nop
        and               %g3, %o4, %g4
        cmp               %g2, %g4
        bne               %icc, 0b
        mov               %g4, %g2
1:
        srl               %g3, %o0, %o0
        membar            #LoadStore|#LoadLoad
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
        or                %g2, %o5, %g4
        cas               [ %o3 ], %g4, %g3
        mov               %g0, %o1
        cmp               %g3, %g4
        move              %icc, 1, %o1
        cmp               %o1, 0
        bne               %icc, 1f
        nop
        and               %g3, %o4, %g4
        cmp               %g2, %g4
        bne               %icc, 0b
        mov               %g4, %g2
1:
        retl
        srl               %g3, %o0, %o0

asm_test::compare_exchange::u8::release_acquire:
        membar            #StoreStore|#LoadStore
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
        or                %g2, %o5, %g4
        cas               [ %o3 ], %g4, %g3
        mov               %g0, %o1
        cmp               %g3, %g4
        move              %icc, 1, %o1
        cmp               %o1, 0
        bne               %icc, 1f
        nop
        and               %g3, %o4, %g4
        cmp               %g2, %g4
        bne               %icc, 0b
        mov               %g4, %g2
1:
        srl               %g3, %o0, %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::compare_exchange::u8::release_relaxed:
        membar            #StoreStore|#LoadStore
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
        or                %g2, %o5, %g4
        cas               [ %o3 ], %g4, %g3
        mov               %g0, %o1
        cmp               %g3, %g4
        move              %icc, 1, %o1
        cmp               %o1, 0
        bne               %icc, 1f
        nop
        and               %g3, %o4, %g4
        cmp               %g2, %g4
        bne               %icc, 0b
        mov               %g4, %g2
1:
        retl
        srl               %g3, %o0, %o0

asm_test::compare_exchange::u16::acqrel_seqcst:
        membar            #StoreStore|#LoadStore
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
        or                %g2, %o5, %g4
        cas               [ %o3 ], %g4, %g3
        mov               %g0, %o1
        cmp               %g3, %g4
        move              %icc, 1, %o1
        cmp               %o1, 0
        bne               %icc, 1f
        nop
        and               %g3, %o2, %g4
        cmp               %g2, %g4
        bne               %icc, 0b
        mov               %g4, %g2
1:
        srl               %g3, %o0, %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::compare_exchange::u16::seqcst_seqcst:
        membar            #StoreStore|#LoadStore
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
        or                %g2, %o5, %g4
        cas               [ %o3 ], %g4, %g3
        mov               %g0, %o1
        cmp               %g3, %g4
        move              %icc, 1, %o1
        cmp               %o1, 0
        bne               %icc, 1f
        nop
        and               %g3, %o2, %g4
        cmp               %g2, %g4
        bne               %icc, 0b
        mov               %g4, %g2
1:
        srl               %g3, %o0, %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::compare_exchange::u16::acqrel_acquire:
        membar            #StoreStore|#LoadStore
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
        or                %g2, %o5, %g4
        cas               [ %o3 ], %g4, %g3
        mov               %g0, %o1
        cmp               %g3, %g4
        move              %icc, 1, %o1
        cmp               %o1, 0
        bne               %icc, 1f
        nop
        and               %g3, %o2, %g4
        cmp               %g2, %g4
        bne               %icc, 0b
        mov               %g4, %g2
1:
        srl               %g3, %o0, %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::compare_exchange::u16::acqrel_relaxed:
        membar            #StoreStore|#LoadStore
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
        or                %g2, %o5, %g4
        cas               [ %o3 ], %g4, %g3
        mov               %g0, %o1
        cmp               %g3, %g4
        move              %icc, 1, %o1
        cmp               %o1, 0
        bne               %icc, 1f
        nop
        and               %g3, %o2, %g4
        cmp               %g2, %g4
        bne               %icc, 0b
        mov               %g4, %g2
1:
        srl               %g3, %o0, %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::compare_exchange::u16::acquire_seqcst:
        membar            #StoreStore|#LoadStore
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
        or                %g2, %o5, %g4
        cas               [ %o3 ], %g4, %g3
        mov               %g0, %o1
        cmp               %g3, %g4
        move              %icc, 1, %o1
        cmp               %o1, 0
        bne               %icc, 1f
        nop
        and               %g3, %o2, %g4
        cmp               %g2, %g4
        bne               %icc, 0b
        mov               %g4, %g2
1:
        srl               %g3, %o0, %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::compare_exchange::u16::relaxed_seqcst:
        membar            #StoreStore|#LoadStore
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
        or                %g2, %o5, %g4
        cas               [ %o3 ], %g4, %g3
        mov               %g0, %o1
        cmp               %g3, %g4
        move              %icc, 1, %o1
        cmp               %o1, 0
        bne               %icc, 1f
        nop
        and               %g3, %o2, %g4
        cmp               %g2, %g4
        bne               %icc, 0b
        mov               %g4, %g2
1:
        srl               %g3, %o0, %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::compare_exchange::u16::release_seqcst:
        membar            #StoreStore|#LoadStore
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
        or                %g2, %o5, %g4
        cas               [ %o3 ], %g4, %g3
        mov               %g0, %o1
        cmp               %g3, %g4
        move              %icc, 1, %o1
        cmp               %o1, 0
        bne               %icc, 1f
        nop
        and               %g3, %o2, %g4
        cmp               %g2, %g4
        bne               %icc, 0b
        mov               %g4, %g2
1:
        srl               %g3, %o0, %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::compare_exchange::u16::seqcst_acquire:
        membar            #StoreStore|#LoadStore
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
        or                %g2, %o5, %g4
        cas               [ %o3 ], %g4, %g3
        mov               %g0, %o1
        cmp               %g3, %g4
        move              %icc, 1, %o1
        cmp               %o1, 0
        bne               %icc, 1f
        nop
        and               %g3, %o2, %g4
        cmp               %g2, %g4
        bne               %icc, 0b
        mov               %g4, %g2
1:
        srl               %g3, %o0, %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::compare_exchange::u16::seqcst_relaxed:
        membar            #StoreStore|#LoadStore
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
        or                %g2, %o5, %g4
        cas               [ %o3 ], %g4, %g3
        mov               %g0, %o1
        cmp               %g3, %g4
        move              %icc, 1, %o1
        cmp               %o1, 0
        bne               %icc, 1f
        nop
        and               %g3, %o2, %g4
        cmp               %g2, %g4
        bne               %icc, 0b
        mov               %g4, %g2
1:
        srl               %g3, %o0, %o0
        membar            #LoadStore|#LoadLoad
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
        or                %g2, %o5, %g4
        cas               [ %o3 ], %g4, %g3
        mov               %g0, %o1
        cmp               %g3, %g4
        move              %icc, 1, %o1
        cmp               %o1, 0
        bne               %icc, 1f
        nop
        and               %g3, %o2, %g4
        cmp               %g2, %g4
        bne               %icc, 0b
        mov               %g4, %g2
1:
        srl               %g3, %o0, %o0
        membar            #LoadStore|#LoadLoad
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
        or                %g2, %o5, %g4
        cas               [ %o3 ], %g4, %g3
        mov               %g0, %o1
        cmp               %g3, %g4
        move              %icc, 1, %o1
        cmp               %o1, 0
        bne               %icc, 1f
        nop
        and               %g3, %o2, %g4
        cmp               %g2, %g4
        bne               %icc, 0b
        mov               %g4, %g2
1:
        srl               %g3, %o0, %o0
        membar            #LoadStore|#LoadLoad
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
        or                %g2, %o5, %g4
        cas               [ %o3 ], %g4, %g3
        mov               %g0, %o1
        cmp               %g3, %g4
        move              %icc, 1, %o1
        cmp               %o1, 0
        bne               %icc, 1f
        nop
        and               %g3, %o2, %g4
        cmp               %g2, %g4
        bne               %icc, 0b
        mov               %g4, %g2
1:
        srl               %g3, %o0, %o0
        membar            #LoadStore|#LoadLoad
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
        or                %g2, %o5, %g4
        cas               [ %o3 ], %g4, %g3
        mov               %g0, %o1
        cmp               %g3, %g4
        move              %icc, 1, %o1
        cmp               %o1, 0
        bne               %icc, 1f
        nop
        and               %g3, %o2, %g4
        cmp               %g2, %g4
        bne               %icc, 0b
        mov               %g4, %g2
1:
        retl
        srl               %g3, %o0, %o0

asm_test::compare_exchange::u16::release_acquire:
        membar            #StoreStore|#LoadStore
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
        or                %g2, %o5, %g4
        cas               [ %o3 ], %g4, %g3
        mov               %g0, %o1
        cmp               %g3, %g4
        move              %icc, 1, %o1
        cmp               %o1, 0
        bne               %icc, 1f
        nop
        and               %g3, %o2, %g4
        cmp               %g2, %g4
        bne               %icc, 0b
        mov               %g4, %g2
1:
        srl               %g3, %o0, %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::compare_exchange::u16::release_relaxed:
        membar            #StoreStore|#LoadStore
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
        or                %g2, %o5, %g4
        cas               [ %o3 ], %g4, %g3
        mov               %g0, %o1
        cmp               %g3, %g4
        move              %icc, 1, %o1
        cmp               %o1, 0
        bne               %icc, 1f
        nop
        and               %g3, %o2, %g4
        cmp               %g2, %g4
        bne               %icc, 0b
        mov               %g4, %g2
1:
        retl
        srl               %g3, %o0, %o0

asm_test::compare_exchange::u32::acqrel_seqcst:
        membar            #StoreStore|#LoadStore
        cas               [ %o0 ], %o1, %o2
        mov               %g0, %o3
        cmp               %o2, %o1
        move              %icc, 1, %o3
        membar            #LoadStore|#LoadLoad
        mov               %o2, %o0
        retl
        mov               %o3, %o1

asm_test::compare_exchange::u32::seqcst_seqcst:
        membar            #StoreStore|#LoadStore
        cas               [ %o0 ], %o1, %o2
        mov               %g0, %o3
        cmp               %o2, %o1
        move              %icc, 1, %o3
        membar            #LoadStore|#LoadLoad
        mov               %o2, %o0
        retl
        mov               %o3, %o1

asm_test::compare_exchange::u32::acqrel_acquire:
        membar            #StoreStore|#LoadStore
        cas               [ %o0 ], %o1, %o2
        mov               %g0, %o3
        cmp               %o2, %o1
        move              %icc, 1, %o3
        membar            #LoadStore|#LoadLoad
        mov               %o2, %o0
        retl
        mov               %o3, %o1

asm_test::compare_exchange::u32::acqrel_relaxed:
        membar            #StoreStore|#LoadStore
        cas               [ %o0 ], %o1, %o2
        mov               %g0, %o3
        cmp               %o2, %o1
        move              %icc, 1, %o3
        membar            #LoadStore|#LoadLoad
        mov               %o2, %o0
        retl
        mov               %o3, %o1

asm_test::compare_exchange::u32::acquire_seqcst:
        membar            #StoreStore|#LoadStore
        cas               [ %o0 ], %o1, %o2
        mov               %g0, %o3
        cmp               %o2, %o1
        move              %icc, 1, %o3
        membar            #LoadStore|#LoadLoad
        mov               %o2, %o0
        retl
        mov               %o3, %o1

asm_test::compare_exchange::u32::relaxed_seqcst:
        membar            #StoreStore|#LoadStore
        cas               [ %o0 ], %o1, %o2
        mov               %g0, %o3
        cmp               %o2, %o1
        move              %icc, 1, %o3
        membar            #LoadStore|#LoadLoad
        mov               %o2, %o0
        retl
        mov               %o3, %o1

asm_test::compare_exchange::u32::release_seqcst:
        membar            #StoreStore|#LoadStore
        cas               [ %o0 ], %o1, %o2
        mov               %g0, %o3
        cmp               %o2, %o1
        move              %icc, 1, %o3
        membar            #LoadStore|#LoadLoad
        mov               %o2, %o0
        retl
        mov               %o3, %o1

asm_test::compare_exchange::u32::seqcst_acquire:
        membar            #StoreStore|#LoadStore
        cas               [ %o0 ], %o1, %o2
        mov               %g0, %o3
        cmp               %o2, %o1
        move              %icc, 1, %o3
        membar            #LoadStore|#LoadLoad
        mov               %o2, %o0
        retl
        mov               %o3, %o1

asm_test::compare_exchange::u32::seqcst_relaxed:
        membar            #StoreStore|#LoadStore
        cas               [ %o0 ], %o1, %o2
        mov               %g0, %o3
        cmp               %o2, %o1
        move              %icc, 1, %o3
        membar            #LoadStore|#LoadLoad
        mov               %o2, %o0
        retl
        mov               %o3, %o1

asm_test::compare_exchange::u32::acquire_acquire:
        cas               [ %o0 ], %o1, %o2
        mov               %g0, %o3
        cmp               %o2, %o1
        move              %icc, 1, %o3
        membar            #LoadStore|#LoadLoad
        mov               %o2, %o0
        retl
        mov               %o3, %o1

asm_test::compare_exchange::u32::acquire_relaxed:
        cas               [ %o0 ], %o1, %o2
        mov               %g0, %o3
        cmp               %o2, %o1
        move              %icc, 1, %o3
        membar            #LoadStore|#LoadLoad
        mov               %o2, %o0
        retl
        mov               %o3, %o1

asm_test::compare_exchange::u32::relaxed_acquire:
        cas               [ %o0 ], %o1, %o2
        mov               %g0, %o3
        cmp               %o2, %o1
        move              %icc, 1, %o3
        membar            #LoadStore|#LoadLoad
        mov               %o2, %o0
        retl
        mov               %o3, %o1

asm_test::compare_exchange::u32::relaxed_relaxed:
        cas               [ %o0 ], %o1, %o2
        mov               %g0, %o3
        cmp               %o2, %o1
        move              %icc, 1, %o3
        mov               %o2, %o0
        retl
        mov               %o3, %o1

asm_test::compare_exchange::u32::release_acquire:
        membar            #StoreStore|#LoadStore
        cas               [ %o0 ], %o1, %o2
        mov               %g0, %o3
        cmp               %o2, %o1
        move              %icc, 1, %o3
        membar            #LoadStore|#LoadLoad
        mov               %o2, %o0
        retl
        mov               %o3, %o1

asm_test::compare_exchange::u32::release_relaxed:
        membar            #StoreStore|#LoadStore
        cas               [ %o0 ], %o1, %o2
        mov               %g0, %o3
        cmp               %o2, %o1
        move              %icc, 1, %o3
        mov               %o2, %o0
        retl
        mov               %o3, %o1

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        membar            #StoreStore|#LoadStore
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
        or                %o4, %o1, %o4
        cas               [ %o3 ], %o4, %o2
        mov               %g0, %o1
        cmp               %o2, %o4
        move              %icc, 1, %o1
        srl               %o2, %o0, %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        membar            #StoreStore|#LoadStore
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
        or                %o4, %o1, %o4
        cas               [ %o3 ], %o4, %o2
        mov               %g0, %o1
        cmp               %o2, %o4
        move              %icc, 1, %o1
        srl               %o2, %o0, %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        membar            #StoreStore|#LoadStore
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
        or                %o4, %o1, %o4
        cas               [ %o3 ], %o4, %o2
        mov               %g0, %o1
        cmp               %o2, %o4
        move              %icc, 1, %o1
        srl               %o2, %o0, %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        membar            #StoreStore|#LoadStore
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
        or                %o4, %o1, %o4
        cas               [ %o3 ], %o4, %o2
        mov               %g0, %o1
        cmp               %o2, %o4
        move              %icc, 1, %o1
        srl               %o2, %o0, %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        membar            #StoreStore|#LoadStore
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
        or                %o4, %o1, %o4
        cas               [ %o3 ], %o4, %o2
        mov               %g0, %o1
        cmp               %o2, %o4
        move              %icc, 1, %o1
        srl               %o2, %o0, %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        membar            #StoreStore|#LoadStore
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
        or                %o4, %o1, %o4
        cas               [ %o3 ], %o4, %o2
        mov               %g0, %o1
        cmp               %o2, %o4
        move              %icc, 1, %o1
        srl               %o2, %o0, %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::compare_exchange_weak::u8::release_seqcst:
        membar            #StoreStore|#LoadStore
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
        or                %o4, %o1, %o4
        cas               [ %o3 ], %o4, %o2
        mov               %g0, %o1
        cmp               %o2, %o4
        move              %icc, 1, %o1
        srl               %o2, %o0, %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        membar            #StoreStore|#LoadStore
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
        or                %o4, %o1, %o4
        cas               [ %o3 ], %o4, %o2
        mov               %g0, %o1
        cmp               %o2, %o4
        move              %icc, 1, %o1
        srl               %o2, %o0, %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        membar            #StoreStore|#LoadStore
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
        or                %o4, %o1, %o4
        cas               [ %o3 ], %o4, %o2
        mov               %g0, %o1
        cmp               %o2, %o4
        move              %icc, 1, %o1
        srl               %o2, %o0, %o0
        membar            #LoadStore|#LoadLoad
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
        or                %o4, %o1, %o4
        cas               [ %o3 ], %o4, %o2
        mov               %g0, %o1
        cmp               %o2, %o4
        move              %icc, 1, %o1
        srl               %o2, %o0, %o0
        membar            #LoadStore|#LoadLoad
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
        or                %o4, %o1, %o4
        cas               [ %o3 ], %o4, %o2
        mov               %g0, %o1
        cmp               %o2, %o4
        move              %icc, 1, %o1
        srl               %o2, %o0, %o0
        membar            #LoadStore|#LoadLoad
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
        or                %o4, %o1, %o4
        cas               [ %o3 ], %o4, %o2
        mov               %g0, %o1
        cmp               %o2, %o4
        move              %icc, 1, %o1
        srl               %o2, %o0, %o0
        membar            #LoadStore|#LoadLoad
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
        or                %o4, %o1, %o4
        cas               [ %o3 ], %o4, %o2
        mov               %g0, %o1
        cmp               %o2, %o4
        move              %icc, 1, %o1
        retl
        srl               %o2, %o0, %o0

asm_test::compare_exchange_weak::u8::release_acquire:
        membar            #StoreStore|#LoadStore
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
        or                %o4, %o1, %o4
        cas               [ %o3 ], %o4, %o2
        mov               %g0, %o1
        cmp               %o2, %o4
        move              %icc, 1, %o1
        srl               %o2, %o0, %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::compare_exchange_weak::u8::release_relaxed:
        membar            #StoreStore|#LoadStore
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
        or                %o4, %o1, %o4
        cas               [ %o3 ], %o4, %o2
        mov               %g0, %o1
        cmp               %o2, %o4
        move              %icc, 1, %o1
        retl
        srl               %o2, %o0, %o0

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        membar            #StoreStore|#LoadStore
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
        or                %o5, %o4, %o4
        cas               [ %o3 ], %o4, %o2
        mov               %g0, %o1
        cmp               %o2, %o4
        move              %icc, 1, %o1
        srl               %o2, %o0, %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        membar            #StoreStore|#LoadStore
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
        or                %o5, %o4, %o4
        cas               [ %o3 ], %o4, %o2
        mov               %g0, %o1
        cmp               %o2, %o4
        move              %icc, 1, %o1
        srl               %o2, %o0, %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        membar            #StoreStore|#LoadStore
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
        or                %o5, %o4, %o4
        cas               [ %o3 ], %o4, %o2
        mov               %g0, %o1
        cmp               %o2, %o4
        move              %icc, 1, %o1
        srl               %o2, %o0, %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        membar            #StoreStore|#LoadStore
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
        or                %o5, %o4, %o4
        cas               [ %o3 ], %o4, %o2
        mov               %g0, %o1
        cmp               %o2, %o4
        move              %icc, 1, %o1
        srl               %o2, %o0, %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        membar            #StoreStore|#LoadStore
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
        or                %o5, %o4, %o4
        cas               [ %o3 ], %o4, %o2
        mov               %g0, %o1
        cmp               %o2, %o4
        move              %icc, 1, %o1
        srl               %o2, %o0, %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        membar            #StoreStore|#LoadStore
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
        or                %o5, %o4, %o4
        cas               [ %o3 ], %o4, %o2
        mov               %g0, %o1
        cmp               %o2, %o4
        move              %icc, 1, %o1
        srl               %o2, %o0, %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::compare_exchange_weak::u16::release_seqcst:
        membar            #StoreStore|#LoadStore
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
        or                %o5, %o4, %o4
        cas               [ %o3 ], %o4, %o2
        mov               %g0, %o1
        cmp               %o2, %o4
        move              %icc, 1, %o1
        srl               %o2, %o0, %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        membar            #StoreStore|#LoadStore
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
        or                %o5, %o4, %o4
        cas               [ %o3 ], %o4, %o2
        mov               %g0, %o1
        cmp               %o2, %o4
        move              %icc, 1, %o1
        srl               %o2, %o0, %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        membar            #StoreStore|#LoadStore
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
        or                %o5, %o4, %o4
        cas               [ %o3 ], %o4, %o2
        mov               %g0, %o1
        cmp               %o2, %o4
        move              %icc, 1, %o1
        srl               %o2, %o0, %o0
        membar            #LoadStore|#LoadLoad
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
        or                %o5, %o4, %o4
        cas               [ %o3 ], %o4, %o2
        mov               %g0, %o1
        cmp               %o2, %o4
        move              %icc, 1, %o1
        srl               %o2, %o0, %o0
        membar            #LoadStore|#LoadLoad
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
        or                %o5, %o4, %o4
        cas               [ %o3 ], %o4, %o2
        mov               %g0, %o1
        cmp               %o2, %o4
        move              %icc, 1, %o1
        srl               %o2, %o0, %o0
        membar            #LoadStore|#LoadLoad
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
        or                %o5, %o4, %o4
        cas               [ %o3 ], %o4, %o2
        mov               %g0, %o1
        cmp               %o2, %o4
        move              %icc, 1, %o1
        srl               %o2, %o0, %o0
        membar            #LoadStore|#LoadLoad
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
        or                %o5, %o4, %o4
        cas               [ %o3 ], %o4, %o2
        mov               %g0, %o1
        cmp               %o2, %o4
        move              %icc, 1, %o1
        retl
        srl               %o2, %o0, %o0

asm_test::compare_exchange_weak::u16::release_acquire:
        membar            #StoreStore|#LoadStore
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
        or                %o5, %o4, %o4
        cas               [ %o3 ], %o4, %o2
        mov               %g0, %o1
        cmp               %o2, %o4
        move              %icc, 1, %o1
        srl               %o2, %o0, %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::compare_exchange_weak::u16::release_relaxed:
        membar            #StoreStore|#LoadStore
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
        or                %o5, %o4, %o4
        cas               [ %o3 ], %o4, %o2
        mov               %g0, %o1
        cmp               %o2, %o4
        move              %icc, 1, %o1
        retl
        srl               %o2, %o0, %o0

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        membar            #StoreStore|#LoadStore
        cas               [ %o0 ], %o1, %o2
        mov               %g0, %o3
        cmp               %o2, %o1
        move              %icc, 1, %o3
        membar            #LoadStore|#LoadLoad
        mov               %o2, %o0
        retl
        mov               %o3, %o1

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        membar            #StoreStore|#LoadStore
        cas               [ %o0 ], %o1, %o2
        mov               %g0, %o3
        cmp               %o2, %o1
        move              %icc, 1, %o3
        membar            #LoadStore|#LoadLoad
        mov               %o2, %o0
        retl
        mov               %o3, %o1

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        membar            #StoreStore|#LoadStore
        cas               [ %o0 ], %o1, %o2
        mov               %g0, %o3
        cmp               %o2, %o1
        move              %icc, 1, %o3
        membar            #LoadStore|#LoadLoad
        mov               %o2, %o0
        retl
        mov               %o3, %o1

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        membar            #StoreStore|#LoadStore
        cas               [ %o0 ], %o1, %o2
        mov               %g0, %o3
        cmp               %o2, %o1
        move              %icc, 1, %o3
        membar            #LoadStore|#LoadLoad
        mov               %o2, %o0
        retl
        mov               %o3, %o1

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        membar            #StoreStore|#LoadStore
        cas               [ %o0 ], %o1, %o2
        mov               %g0, %o3
        cmp               %o2, %o1
        move              %icc, 1, %o3
        membar            #LoadStore|#LoadLoad
        mov               %o2, %o0
        retl
        mov               %o3, %o1

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        membar            #StoreStore|#LoadStore
        cas               [ %o0 ], %o1, %o2
        mov               %g0, %o3
        cmp               %o2, %o1
        move              %icc, 1, %o3
        membar            #LoadStore|#LoadLoad
        mov               %o2, %o0
        retl
        mov               %o3, %o1

asm_test::compare_exchange_weak::u32::release_seqcst:
        membar            #StoreStore|#LoadStore
        cas               [ %o0 ], %o1, %o2
        mov               %g0, %o3
        cmp               %o2, %o1
        move              %icc, 1, %o3
        membar            #LoadStore|#LoadLoad
        mov               %o2, %o0
        retl
        mov               %o3, %o1

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        membar            #StoreStore|#LoadStore
        cas               [ %o0 ], %o1, %o2
        mov               %g0, %o3
        cmp               %o2, %o1
        move              %icc, 1, %o3
        membar            #LoadStore|#LoadLoad
        mov               %o2, %o0
        retl
        mov               %o3, %o1

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        membar            #StoreStore|#LoadStore
        cas               [ %o0 ], %o1, %o2
        mov               %g0, %o3
        cmp               %o2, %o1
        move              %icc, 1, %o3
        membar            #LoadStore|#LoadLoad
        mov               %o2, %o0
        retl
        mov               %o3, %o1

asm_test::compare_exchange_weak::u32::acquire_acquire:
        cas               [ %o0 ], %o1, %o2
        mov               %g0, %o3
        cmp               %o2, %o1
        move              %icc, 1, %o3
        membar            #LoadStore|#LoadLoad
        mov               %o2, %o0
        retl
        mov               %o3, %o1

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        cas               [ %o0 ], %o1, %o2
        mov               %g0, %o3
        cmp               %o2, %o1
        move              %icc, 1, %o3
        membar            #LoadStore|#LoadLoad
        mov               %o2, %o0
        retl
        mov               %o3, %o1

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        cas               [ %o0 ], %o1, %o2
        mov               %g0, %o3
        cmp               %o2, %o1
        move              %icc, 1, %o3
        membar            #LoadStore|#LoadLoad
        mov               %o2, %o0
        retl
        mov               %o3, %o1

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        cas               [ %o0 ], %o1, %o2
        mov               %g0, %o3
        cmp               %o2, %o1
        move              %icc, 1, %o3
        mov               %o2, %o0
        retl
        mov               %o3, %o1

asm_test::compare_exchange_weak::u32::release_acquire:
        membar            #StoreStore|#LoadStore
        cas               [ %o0 ], %o1, %o2
        mov               %g0, %o3
        cmp               %o2, %o1
        move              %icc, 1, %o3
        membar            #LoadStore|#LoadLoad
        mov               %o2, %o0
        retl
        mov               %o3, %o1

asm_test::compare_exchange_weak::u32::release_relaxed:
        membar            #StoreStore|#LoadStore
        cas               [ %o0 ], %o1, %o2
        mov               %g0, %o3
        cmp               %o2, %o1
        move              %icc, 1, %o3
        mov               %o2, %o0
        retl
        mov               %o3, %o1

asm_test::load::u8::seqcst:
        ldub              [ %o0 ], %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::load::u8::acquire:
        ldub              [ %o0 ], %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::load::u8::relaxed:
        retl
        ldub              [ %o0 ], %o0

asm_test::load::u16::seqcst:
        lduh              [ %o0 ], %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::load::u16::acquire:
        lduh              [ %o0 ], %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::load::u16::relaxed:
        retl
        lduh              [ %o0 ], %o0

asm_test::load::u32::seqcst:
        ld                [ %o0 ], %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::load::u32::acquire:
        ld                [ %o0 ], %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::load::u32::relaxed:
        retl
        ld                [ %o0 ], %o0

asm_test::swap::u8::acqrel:
        membar            #StoreStore|#LoadStore
        and               %o0, -4, %o2
        mov               3, %o3
        andn              %o3, %o0, %o0
        sll               %o0, 3, %o0
        mov               0xff, %o3
        sll               %o3, %o0, %o4
        ld                [ %o2 ], %o3
        xor               %o4, -1, %o4
        and               %o1, 0xff, %o1
        sll               %o1, %o0, %o1
0:
        mov               %o3, %o5
        and               %o3, %o4, %o3
        or                %o3, %o1, %o3
        cas               [ %o2 ], %o5, %o3
        mov               %g0, %g2
        cmp               %o3, %o5
        move              %icc, 1, %g2
        cmp               %g2, 1
        bne               %icc, 0b
        nop
        srl               %o3, %o0, %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::swap::u8::seqcst:
        membar            #StoreStore|#LoadStore
        and               %o0, -4, %o2
        mov               3, %o3
        andn              %o3, %o0, %o0
        sll               %o0, 3, %o0
        mov               0xff, %o3
        sll               %o3, %o0, %o4
        ld                [ %o2 ], %o3
        xor               %o4, -1, %o4
        and               %o1, 0xff, %o1
        sll               %o1, %o0, %o1
0:
        mov               %o3, %o5
        and               %o3, %o4, %o3
        or                %o3, %o1, %o3
        cas               [ %o2 ], %o5, %o3
        mov               %g0, %g2
        cmp               %o3, %o5
        move              %icc, 1, %g2
        cmp               %g2, 1
        bne               %icc, 0b
        nop
        srl               %o3, %o0, %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::swap::u8::acquire:
        and               %o0, -4, %o2
        mov               3, %o3
        andn              %o3, %o0, %o0
        sll               %o0, 3, %o0
        mov               0xff, %o3
        sll               %o3, %o0, %o4
        ld                [ %o2 ], %o3
        xor               %o4, -1, %o4
        and               %o1, 0xff, %o1
        sll               %o1, %o0, %o1
0:
        mov               %o3, %o5
        and               %o3, %o4, %o3
        or                %o3, %o1, %o3
        cas               [ %o2 ], %o5, %o3
        mov               %g0, %g2
        cmp               %o3, %o5
        move              %icc, 1, %g2
        cmp               %g2, 1
        bne               %icc, 0b
        nop
        srl               %o3, %o0, %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::swap::u8::relaxed:
        and               %o0, -4, %o2
        mov               3, %o3
        andn              %o3, %o0, %o0
        sll               %o0, 3, %o0
        mov               0xff, %o3
        sll               %o3, %o0, %o4
        ld                [ %o2 ], %o3
        xor               %o4, -1, %o4
        and               %o1, 0xff, %o1
        sll               %o1, %o0, %o1
0:
        mov               %o3, %o5
        and               %o3, %o4, %o3
        or                %o3, %o1, %o3
        cas               [ %o2 ], %o5, %o3
        mov               %g0, %g2
        cmp               %o3, %o5
        move              %icc, 1, %g2
        cmp               %g2, 1
        bne               %icc, 0b
        nop
        retl
        srl               %o3, %o0, %o0

asm_test::swap::u8::release:
        membar            #StoreStore|#LoadStore
        and               %o0, -4, %o2
        mov               3, %o3
        andn              %o3, %o0, %o0
        sll               %o0, 3, %o0
        mov               0xff, %o3
        sll               %o3, %o0, %o4
        ld                [ %o2 ], %o3
        xor               %o4, -1, %o4
        and               %o1, 0xff, %o1
        sll               %o1, %o0, %o1
0:
        mov               %o3, %o5
        and               %o3, %o4, %o3
        or                %o3, %o1, %o3
        cas               [ %o2 ], %o5, %o3
        mov               %g0, %g2
        cmp               %o3, %o5
        move              %icc, 1, %g2
        cmp               %g2, 1
        bne               %icc, 0b
        nop
        retl
        srl               %o3, %o0, %o0

asm_test::swap::u16::acqrel:
        membar            #StoreStore|#LoadStore
        and               %o0, -4, %o2
        and               %o0, 3, %o0
        xor               %o0, 2, %o0
        sll               %o0, 3, %o0
        sethi             %hi(0xfc00), %o3
        or                %o3, 0x3ff, %o3	! ffff <asm_test::swap::u16::acqrel+0xffff>
        and               %o1, %o3, %o4
        ld                [ %o2 ], %o1
        sll               %o3, %o0, %o3
        xor               %o3, -1, %o3
        sll               %o4, %o0, %o4
0:
        mov               %o1, %o5
        and               %o1, %o3, %o1
        or                %o1, %o4, %o1
        cas               [ %o2 ], %o5, %o1
        mov               %g0, %g2
        cmp               %o1, %o5
        move              %icc, 1, %g2
        cmp               %g2, 1
        bne               %icc, 0b
        nop
        srl               %o1, %o0, %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::swap::u16::seqcst:
        membar            #StoreStore|#LoadStore
        and               %o0, -4, %o2
        and               %o0, 3, %o0
        xor               %o0, 2, %o0
        sll               %o0, 3, %o0
        sethi             %hi(0xfc00), %o3
        or                %o3, 0x3ff, %o3	! ffff <asm_test::swap::u16::seqcst+0xffff>
        and               %o1, %o3, %o4
        ld                [ %o2 ], %o1
        sll               %o3, %o0, %o3
        xor               %o3, -1, %o3
        sll               %o4, %o0, %o4
0:
        mov               %o1, %o5
        and               %o1, %o3, %o1
        or                %o1, %o4, %o1
        cas               [ %o2 ], %o5, %o1
        mov               %g0, %g2
        cmp               %o1, %o5
        move              %icc, 1, %g2
        cmp               %g2, 1
        bne               %icc, 0b
        nop
        srl               %o1, %o0, %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::swap::u16::acquire:
        and               %o0, -4, %o2
        and               %o0, 3, %o0
        xor               %o0, 2, %o0
        sll               %o0, 3, %o0
        sethi             %hi(0xfc00), %o3
        or                %o3, 0x3ff, %o3	! ffff <asm_test::swap::u16::acquire+0xffff>
        and               %o1, %o3, %o4
        ld                [ %o2 ], %o1
        sll               %o3, %o0, %o3
        xor               %o3, -1, %o3
        sll               %o4, %o0, %o4
0:
        mov               %o1, %o5
        and               %o1, %o3, %o1
        or                %o1, %o4, %o1
        cas               [ %o2 ], %o5, %o1
        mov               %g0, %g2
        cmp               %o1, %o5
        move              %icc, 1, %g2
        cmp               %g2, 1
        bne               %icc, 0b
        nop
        srl               %o1, %o0, %o0
        membar            #LoadStore|#LoadLoad
        retl
        nop

asm_test::swap::u16::relaxed:
        and               %o0, -4, %o2
        and               %o0, 3, %o0
        xor               %o0, 2, %o0
        sll               %o0, 3, %o0
        sethi             %hi(0xfc00), %o3
        or                %o3, 0x3ff, %o3	! ffff <asm_test::swap::u16::relaxed+0xffff>
        and               %o1, %o3, %o4
        ld                [ %o2 ], %o1
        sll               %o3, %o0, %o3
        xor               %o3, -1, %o3
        sll               %o4, %o0, %o4
0:
        mov               %o1, %o5
        and               %o1, %o3, %o1
        or                %o1, %o4, %o1
        cas               [ %o2 ], %o5, %o1
        mov               %g0, %g2
        cmp               %o1, %o5
        move              %icc, 1, %g2
        cmp               %g2, 1
        bne               %icc, 0b
        nop
        retl
        srl               %o1, %o0, %o0

asm_test::swap::u16::release:
        membar            #StoreStore|#LoadStore
        and               %o0, -4, %o2
        and               %o0, 3, %o0
        xor               %o0, 2, %o0
        sll               %o0, 3, %o0
        sethi             %hi(0xfc00), %o3
        or                %o3, 0x3ff, %o3	! ffff <asm_test::swap::u16::release+0xffff>
        and               %o1, %o3, %o4
        ld                [ %o2 ], %o1
        sll               %o3, %o0, %o3
        xor               %o3, -1, %o3
        sll               %o4, %o0, %o4
0:
        mov               %o1, %o5
        and               %o1, %o3, %o1
        or                %o1, %o4, %o1
        cas               [ %o2 ], %o5, %o1
        mov               %g0, %g2
        cmp               %o1, %o5
        move              %icc, 1, %g2
        cmp               %g2, 1
        bne               %icc, 0b
        nop
        retl
        srl               %o1, %o0, %o0

asm_test::swap::u32::acqrel:
        membar            #StoreStore|#LoadStore
        swap              [ %o0 ], %o1
        membar            #LoadStore|#LoadLoad
        retl
        mov               %o1, %o0

asm_test::swap::u32::seqcst:
        membar            #StoreStore|#LoadStore
        swap              [ %o0 ], %o1
        membar            #LoadStore|#LoadLoad
        retl
        mov               %o1, %o0

asm_test::swap::u32::acquire:
        swap              [ %o0 ], %o1
        membar            #LoadStore|#LoadLoad
        retl
        mov               %o1, %o0

asm_test::swap::u32::relaxed:
        swap              [ %o0 ], %o1
        retl
        mov               %o1, %o0

asm_test::swap::u32::release:
        membar            #StoreStore|#LoadStore
        swap              [ %o0 ], %o1
        retl
        mov               %o1, %o0

asm_test::store::u8::seqcst:
        membar            #StoreStore|#LoadStore
        stb               %o1, [ %o0 ]
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        retl
        nop

asm_test::store::u8::relaxed:
        retl
        stb               %o1, [ %o0 ]

asm_test::store::u8::release:
        membar            #StoreStore|#LoadStore
        retl
        stb               %o1, [ %o0 ]

asm_test::store::u16::seqcst:
        membar            #StoreStore|#LoadStore
        sth               %o1, [ %o0 ]
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        retl
        nop

asm_test::store::u16::relaxed:
        retl
        sth               %o1, [ %o0 ]

asm_test::store::u16::release:
        membar            #StoreStore|#LoadStore
        retl
        sth               %o1, [ %o0 ]

asm_test::store::u32::seqcst:
        membar            #StoreStore|#LoadStore
        st                %o1, [ %o0 ]
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        retl
        nop

asm_test::store::u32::relaxed:
        retl
        st                %o1, [ %o0 ]

asm_test::store::u32::release:
        membar            #StoreStore|#LoadStore
        retl
        st                %o1, [ %o0 ]

