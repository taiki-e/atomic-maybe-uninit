asm_test::compare_exchange::u8::acqrel_seqcst:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        sll               %i1, %i4, %i1
        and               %i2, 0xff, %i2
        sll               %i2, %i4, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        membar            #StoreStore|#LoadStore
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange::u8::seqcst_seqcst:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        sll               %i1, %i4, %i1
        and               %i2, 0xff, %i2
        sll               %i2, %i4, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        membar            #StoreStore|#LoadStore
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange::u8::acqrel_acquire:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        sll               %i1, %i4, %i1
        and               %i2, 0xff, %i2
        sll               %i2, %i4, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        membar            #StoreStore|#LoadStore
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange::u8::acqrel_relaxed:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        sll               %i1, %i4, %i1
        and               %i2, 0xff, %i2
        sll               %i2, %i4, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        membar            #StoreStore|#LoadStore
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange::u8::acquire_seqcst:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        sll               %i1, %i4, %i1
        and               %i2, 0xff, %i2
        sll               %i2, %i4, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        membar            #StoreStore|#LoadStore
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange::u8::relaxed_seqcst:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        sll               %i1, %i4, %i1
        and               %i2, 0xff, %i2
        sll               %i2, %i4, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        membar            #StoreStore|#LoadStore
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange::u8::release_seqcst:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        sll               %i1, %i4, %i1
        and               %i2, 0xff, %i2
        sll               %i2, %i4, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        membar            #StoreStore|#LoadStore
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange::u8::seqcst_acquire:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        sll               %i1, %i4, %i1
        and               %i2, 0xff, %i2
        sll               %i2, %i4, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        membar            #StoreStore|#LoadStore
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange::u8::seqcst_relaxed:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        sll               %i1, %i4, %i1
        and               %i2, 0xff, %i2
        sll               %i2, %i4, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        membar            #StoreStore|#LoadStore
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange::u8::acquire_acquire:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        sll               %i1, %i4, %i1
        and               %i2, 0xff, %i2
        sll               %i2, %i4, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange::u8::acquire_relaxed:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        sll               %i1, %i4, %i1
        and               %i2, 0xff, %i2
        sll               %i2, %i4, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange::u8::relaxed_acquire:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        sll               %i1, %i4, %i1
        and               %i2, 0xff, %i2
        sll               %i2, %i4, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange::u8::relaxed_relaxed:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        sll               %i1, %i4, %i1
        and               %i2, 0xff, %i2
        sll               %i2, %i4, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange::u8::release_acquire:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        sll               %i1, %i4, %i1
        and               %i2, 0xff, %i2
        sll               %i2, %i4, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        membar            #StoreStore|#LoadStore
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange::u8::release_relaxed:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        sll               %i1, %i4, %i1
        and               %i2, 0xff, %i2
        sll               %i2, %i4, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        membar            #StoreStore|#LoadStore
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange::u16::acqrel_seqcst:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange::u16::acqrel_seqcst+0xffff>
        and               %i1, %i5, %i1
        sll               %i1, %i4, %i1
        and               %i2, %i5, %i2
        sll               %i2, %i4, %i2
        sll               %i5, %i4, %i5
        membar            #StoreStore|#LoadStore
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange::u16::seqcst_seqcst:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange::u16::seqcst_seqcst+0xffff>
        and               %i1, %i5, %i1
        sll               %i1, %i4, %i1
        and               %i2, %i5, %i2
        sll               %i2, %i4, %i2
        sll               %i5, %i4, %i5
        membar            #StoreStore|#LoadStore
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange::u16::acqrel_acquire:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange::u16::acqrel_acquire+0xffff>
        and               %i1, %i5, %i1
        sll               %i1, %i4, %i1
        and               %i2, %i5, %i2
        sll               %i2, %i4, %i2
        sll               %i5, %i4, %i5
        membar            #StoreStore|#LoadStore
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange::u16::acqrel_relaxed:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange::u16::acqrel_relaxed+0xffff>
        and               %i1, %i5, %i1
        sll               %i1, %i4, %i1
        and               %i2, %i5, %i2
        sll               %i2, %i4, %i2
        sll               %i5, %i4, %i5
        membar            #StoreStore|#LoadStore
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange::u16::acquire_seqcst:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange::u16::acquire_seqcst+0xffff>
        and               %i1, %i5, %i1
        sll               %i1, %i4, %i1
        and               %i2, %i5, %i2
        sll               %i2, %i4, %i2
        sll               %i5, %i4, %i5
        membar            #StoreStore|#LoadStore
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange::u16::relaxed_seqcst:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange::u16::relaxed_seqcst+0xffff>
        and               %i1, %i5, %i1
        sll               %i1, %i4, %i1
        and               %i2, %i5, %i2
        sll               %i2, %i4, %i2
        sll               %i5, %i4, %i5
        membar            #StoreStore|#LoadStore
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange::u16::release_seqcst:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange::u16::release_seqcst+0xffff>
        and               %i1, %i5, %i1
        sll               %i1, %i4, %i1
        and               %i2, %i5, %i2
        sll               %i2, %i4, %i2
        sll               %i5, %i4, %i5
        membar            #StoreStore|#LoadStore
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange::u16::seqcst_acquire:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange::u16::seqcst_acquire+0xffff>
        and               %i1, %i5, %i1
        sll               %i1, %i4, %i1
        and               %i2, %i5, %i2
        sll               %i2, %i4, %i2
        sll               %i5, %i4, %i5
        membar            #StoreStore|#LoadStore
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange::u16::seqcst_relaxed:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange::u16::seqcst_relaxed+0xffff>
        and               %i1, %i5, %i1
        sll               %i1, %i4, %i1
        and               %i2, %i5, %i2
        sll               %i2, %i4, %i2
        sll               %i5, %i4, %i5
        membar            #StoreStore|#LoadStore
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange::u16::acquire_acquire:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange::u16::acquire_acquire+0xffff>
        and               %i1, %i5, %i1
        sll               %i1, %i4, %i1
        and               %i2, %i5, %i2
        sll               %i2, %i4, %i2
        sll               %i5, %i4, %i5
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange::u16::acquire_relaxed:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange::u16::acquire_relaxed+0xffff>
        and               %i1, %i5, %i1
        sll               %i1, %i4, %i1
        and               %i2, %i5, %i2
        sll               %i2, %i4, %i2
        sll               %i5, %i4, %i5
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange::u16::relaxed_acquire:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange::u16::relaxed_acquire+0xffff>
        and               %i1, %i5, %i1
        sll               %i1, %i4, %i1
        and               %i2, %i5, %i2
        sll               %i2, %i4, %i2
        sll               %i5, %i4, %i5
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange::u16::relaxed_relaxed:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange::u16::relaxed_relaxed+0xffff>
        and               %i1, %i5, %i1
        sll               %i1, %i4, %i1
        and               %i2, %i5, %i2
        sll               %i2, %i4, %i2
        sll               %i5, %i4, %i5
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange::u16::release_acquire:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange::u16::release_acquire+0xffff>
        and               %i1, %i5, %i1
        sll               %i1, %i4, %i1
        and               %i2, %i5, %i2
        sll               %i2, %i4, %i2
        sll               %i5, %i4, %i5
        membar            #StoreStore|#LoadStore
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange::u16::release_relaxed:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange::u16::release_relaxed+0xffff>
        and               %i1, %i5, %i1
        sll               %i1, %i4, %i1
        and               %i2, %i5, %i2
        sll               %i2, %i4, %i2
        sll               %i5, %i4, %i5
        membar            #StoreStore|#LoadStore
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange::u32::acqrel_seqcst:
        save              %sp, -96, %sp
        membar            #StoreStore|#LoadStore
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        cmp               %i0, 0
        movne             %icc, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u32::seqcst_seqcst:
        save              %sp, -96, %sp
        membar            #StoreStore|#LoadStore
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        cmp               %i0, 0
        movne             %icc, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u32::acqrel_acquire:
        save              %sp, -96, %sp
        membar            #StoreStore|#LoadStore
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        cmp               %i0, 0
        movne             %icc, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u32::acqrel_relaxed:
        save              %sp, -96, %sp
        membar            #StoreStore|#LoadStore
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        cmp               %i0, 0
        movne             %icc, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u32::acquire_seqcst:
        save              %sp, -96, %sp
        membar            #StoreStore|#LoadStore
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        cmp               %i0, 0
        movne             %icc, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u32::relaxed_seqcst:
        save              %sp, -96, %sp
        membar            #StoreStore|#LoadStore
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        cmp               %i0, 0
        movne             %icc, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u32::release_seqcst:
        save              %sp, -96, %sp
        membar            #StoreStore|#LoadStore
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        cmp               %i0, 0
        movne             %icc, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u32::seqcst_acquire:
        save              %sp, -96, %sp
        membar            #StoreStore|#LoadStore
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        cmp               %i0, 0
        movne             %icc, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u32::seqcst_relaxed:
        save              %sp, -96, %sp
        membar            #StoreStore|#LoadStore
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        cmp               %i0, 0
        movne             %icc, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u32::acquire_acquire:
        save              %sp, -96, %sp
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        cmp               %i0, 0
        movne             %icc, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u32::acquire_relaxed:
        save              %sp, -96, %sp
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        cmp               %i0, 0
        movne             %icc, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u32::relaxed_acquire:
        save              %sp, -96, %sp
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        cmp               %i0, 0
        movne             %icc, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u32::relaxed_relaxed:
        save              %sp, -96, %sp
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        mov               %g0, %i1
        cmp               %i0, 0
        movne             %icc, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u32::release_acquire:
        save              %sp, -96, %sp
        membar            #StoreStore|#LoadStore
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        cmp               %i0, 0
        movne             %icc, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u32::release_relaxed:
        save              %sp, -96, %sp
        membar            #StoreStore|#LoadStore
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        mov               %g0, %i1
        cmp               %i0, 0
        movne             %icc, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u64::acqrel_seqcst:
        save              %sp, -112, %sp
        mov               %i4, %g3
        mov               %i2, %l1
        ld                [ %fp + 0x40 ], %i4
        mov               %i1, %l0
        sttw              %l0, [ %fp + -16 ]
        add               %fp, -16, %i1
        add               %fp, -8, %i2
        mov               %i3, %g2
        sttw              %g2, [ %fp + -8 ]
        ldx               [ %i1 ], %o0
        ldx               [ %i2 ], %o1
        membar            #StoreStore|#LoadStore
        casx              [ %i0 ], %o0, %o1
        cmp               %o1, %o0
        membar            #LoadStore|#LoadLoad
        stx               %o1, [ %i2 ]
        mov               %g0, %i2
        move              %xcc, 1, %i2
        ldtw              [ %fp + -8 ], %i0
        sttw              %i0, [ %i4 ]
        stb               %i2, [ %i4 + 8 ]
        jmp               %i7 + 0xc
        restore           %g0, %i4, %o0

asm_test::compare_exchange::u64::seqcst_seqcst:
        save              %sp, -112, %sp
        mov               %i4, %g3
        mov               %i2, %l1
        ld                [ %fp + 0x40 ], %i4
        mov               %i1, %l0
        sttw              %l0, [ %fp + -16 ]
        add               %fp, -16, %i1
        add               %fp, -8, %i2
        mov               %i3, %g2
        sttw              %g2, [ %fp + -8 ]
        ldx               [ %i1 ], %o0
        ldx               [ %i2 ], %o1
        membar            #StoreStore|#LoadStore
        casx              [ %i0 ], %o0, %o1
        cmp               %o1, %o0
        membar            #LoadStore|#LoadLoad
        stx               %o1, [ %i2 ]
        mov               %g0, %i2
        move              %xcc, 1, %i2
        ldtw              [ %fp + -8 ], %i0
        sttw              %i0, [ %i4 ]
        stb               %i2, [ %i4 + 8 ]
        jmp               %i7 + 0xc
        restore           %g0, %i4, %o0

asm_test::compare_exchange::u64::acqrel_acquire:
        save              %sp, -112, %sp
        mov               %i4, %g3
        mov               %i2, %l1
        ld                [ %fp + 0x40 ], %i4
        mov               %i1, %l0
        sttw              %l0, [ %fp + -16 ]
        add               %fp, -16, %i1
        add               %fp, -8, %i2
        mov               %i3, %g2
        sttw              %g2, [ %fp + -8 ]
        ldx               [ %i1 ], %o0
        ldx               [ %i2 ], %o1
        membar            #StoreStore|#LoadStore
        casx              [ %i0 ], %o0, %o1
        cmp               %o1, %o0
        membar            #LoadStore|#LoadLoad
        stx               %o1, [ %i2 ]
        mov               %g0, %i2
        move              %xcc, 1, %i2
        ldtw              [ %fp + -8 ], %i0
        sttw              %i0, [ %i4 ]
        stb               %i2, [ %i4 + 8 ]
        jmp               %i7 + 0xc
        restore           %g0, %i4, %o0

asm_test::compare_exchange::u64::acqrel_relaxed:
        save              %sp, -112, %sp
        mov               %i4, %g3
        mov               %i2, %l1
        ld                [ %fp + 0x40 ], %i4
        mov               %i1, %l0
        sttw              %l0, [ %fp + -16 ]
        add               %fp, -16, %i1
        add               %fp, -8, %i2
        mov               %i3, %g2
        sttw              %g2, [ %fp + -8 ]
        ldx               [ %i1 ], %o0
        ldx               [ %i2 ], %o1
        membar            #StoreStore|#LoadStore
        casx              [ %i0 ], %o0, %o1
        cmp               %o1, %o0
        membar            #LoadStore|#LoadLoad
        stx               %o1, [ %i2 ]
        mov               %g0, %i2
        move              %xcc, 1, %i2
        ldtw              [ %fp + -8 ], %i0
        sttw              %i0, [ %i4 ]
        stb               %i2, [ %i4 + 8 ]
        jmp               %i7 + 0xc
        restore           %g0, %i4, %o0

asm_test::compare_exchange::u64::acquire_seqcst:
        save              %sp, -112, %sp
        mov               %i4, %g3
        mov               %i2, %l1
        ld                [ %fp + 0x40 ], %i4
        mov               %i1, %l0
        sttw              %l0, [ %fp + -16 ]
        add               %fp, -16, %i1
        add               %fp, -8, %i2
        mov               %i3, %g2
        sttw              %g2, [ %fp + -8 ]
        ldx               [ %i1 ], %o0
        ldx               [ %i2 ], %o1
        membar            #StoreStore|#LoadStore
        casx              [ %i0 ], %o0, %o1
        cmp               %o1, %o0
        membar            #LoadStore|#LoadLoad
        stx               %o1, [ %i2 ]
        mov               %g0, %i2
        move              %xcc, 1, %i2
        ldtw              [ %fp + -8 ], %i0
        sttw              %i0, [ %i4 ]
        stb               %i2, [ %i4 + 8 ]
        jmp               %i7 + 0xc
        restore           %g0, %i4, %o0

asm_test::compare_exchange::u64::relaxed_seqcst:
        save              %sp, -112, %sp
        mov               %i4, %g3
        mov               %i2, %l1
        ld                [ %fp + 0x40 ], %i4
        mov               %i1, %l0
        sttw              %l0, [ %fp + -16 ]
        add               %fp, -16, %i1
        add               %fp, -8, %i2
        mov               %i3, %g2
        sttw              %g2, [ %fp + -8 ]
        ldx               [ %i1 ], %o0
        ldx               [ %i2 ], %o1
        membar            #StoreStore|#LoadStore
        casx              [ %i0 ], %o0, %o1
        cmp               %o1, %o0
        membar            #LoadStore|#LoadLoad
        stx               %o1, [ %i2 ]
        mov               %g0, %i2
        move              %xcc, 1, %i2
        ldtw              [ %fp + -8 ], %i0
        sttw              %i0, [ %i4 ]
        stb               %i2, [ %i4 + 8 ]
        jmp               %i7 + 0xc
        restore           %g0, %i4, %o0

asm_test::compare_exchange::u64::release_seqcst:
        save              %sp, -112, %sp
        mov               %i4, %g3
        mov               %i2, %l1
        ld                [ %fp + 0x40 ], %i4
        mov               %i1, %l0
        sttw              %l0, [ %fp + -16 ]
        add               %fp, -16, %i1
        add               %fp, -8, %i2
        mov               %i3, %g2
        sttw              %g2, [ %fp + -8 ]
        ldx               [ %i1 ], %o0
        ldx               [ %i2 ], %o1
        membar            #StoreStore|#LoadStore
        casx              [ %i0 ], %o0, %o1
        cmp               %o1, %o0
        membar            #LoadStore|#LoadLoad
        stx               %o1, [ %i2 ]
        mov               %g0, %i2
        move              %xcc, 1, %i2
        ldtw              [ %fp + -8 ], %i0
        sttw              %i0, [ %i4 ]
        stb               %i2, [ %i4 + 8 ]
        jmp               %i7 + 0xc
        restore           %g0, %i4, %o0

asm_test::compare_exchange::u64::seqcst_acquire:
        save              %sp, -112, %sp
        mov               %i4, %g3
        mov               %i2, %l1
        ld                [ %fp + 0x40 ], %i4
        mov               %i1, %l0
        sttw              %l0, [ %fp + -16 ]
        add               %fp, -16, %i1
        add               %fp, -8, %i2
        mov               %i3, %g2
        sttw              %g2, [ %fp + -8 ]
        ldx               [ %i1 ], %o0
        ldx               [ %i2 ], %o1
        membar            #StoreStore|#LoadStore
        casx              [ %i0 ], %o0, %o1
        cmp               %o1, %o0
        membar            #LoadStore|#LoadLoad
        stx               %o1, [ %i2 ]
        mov               %g0, %i2
        move              %xcc, 1, %i2
        ldtw              [ %fp + -8 ], %i0
        sttw              %i0, [ %i4 ]
        stb               %i2, [ %i4 + 8 ]
        jmp               %i7 + 0xc
        restore           %g0, %i4, %o0

asm_test::compare_exchange::u64::seqcst_relaxed:
        save              %sp, -112, %sp
        mov               %i4, %g3
        mov               %i2, %l1
        ld                [ %fp + 0x40 ], %i4
        mov               %i1, %l0
        sttw              %l0, [ %fp + -16 ]
        add               %fp, -16, %i1
        add               %fp, -8, %i2
        mov               %i3, %g2
        sttw              %g2, [ %fp + -8 ]
        ldx               [ %i1 ], %o0
        ldx               [ %i2 ], %o1
        membar            #StoreStore|#LoadStore
        casx              [ %i0 ], %o0, %o1
        cmp               %o1, %o0
        membar            #LoadStore|#LoadLoad
        stx               %o1, [ %i2 ]
        mov               %g0, %i2
        move              %xcc, 1, %i2
        ldtw              [ %fp + -8 ], %i0
        sttw              %i0, [ %i4 ]
        stb               %i2, [ %i4 + 8 ]
        jmp               %i7 + 0xc
        restore           %g0, %i4, %o0

asm_test::compare_exchange::u64::acquire_acquire:
        save              %sp, -112, %sp
        mov               %i4, %g3
        mov               %i2, %l1
        ld                [ %fp + 0x40 ], %i4
        mov               %i1, %l0
        sttw              %l0, [ %fp + -16 ]
        add               %fp, -16, %i1
        add               %fp, -8, %i2
        mov               %i3, %g2
        sttw              %g2, [ %fp + -8 ]
        ldx               [ %i1 ], %o0
        ldx               [ %i2 ], %o1
        casx              [ %i0 ], %o0, %o1
        cmp               %o1, %o0
        membar            #LoadStore|#LoadLoad
        stx               %o1, [ %i2 ]
        mov               %g0, %i2
        move              %xcc, 1, %i2
        ldtw              [ %fp + -8 ], %i0
        sttw              %i0, [ %i4 ]
        stb               %i2, [ %i4 + 8 ]
        jmp               %i7 + 0xc
        restore           %g0, %i4, %o0

asm_test::compare_exchange::u64::acquire_relaxed:
        save              %sp, -112, %sp
        mov               %i4, %g3
        mov               %i2, %l1
        ld                [ %fp + 0x40 ], %i4
        mov               %i1, %l0
        sttw              %l0, [ %fp + -16 ]
        add               %fp, -16, %i1
        add               %fp, -8, %i2
        mov               %i3, %g2
        sttw              %g2, [ %fp + -8 ]
        ldx               [ %i1 ], %o0
        ldx               [ %i2 ], %o1
        casx              [ %i0 ], %o0, %o1
        cmp               %o1, %o0
        membar            #LoadStore|#LoadLoad
        stx               %o1, [ %i2 ]
        mov               %g0, %i2
        move              %xcc, 1, %i2
        ldtw              [ %fp + -8 ], %i0
        sttw              %i0, [ %i4 ]
        stb               %i2, [ %i4 + 8 ]
        jmp               %i7 + 0xc
        restore           %g0, %i4, %o0

asm_test::compare_exchange::u64::relaxed_acquire:
        save              %sp, -112, %sp
        mov               %i4, %g3
        mov               %i2, %l1
        ld                [ %fp + 0x40 ], %i4
        mov               %i1, %l0
        sttw              %l0, [ %fp + -16 ]
        add               %fp, -16, %i1
        add               %fp, -8, %i2
        mov               %i3, %g2
        sttw              %g2, [ %fp + -8 ]
        ldx               [ %i1 ], %o0
        ldx               [ %i2 ], %o1
        casx              [ %i0 ], %o0, %o1
        cmp               %o1, %o0
        membar            #LoadStore|#LoadLoad
        stx               %o1, [ %i2 ]
        mov               %g0, %i2
        move              %xcc, 1, %i2
        ldtw              [ %fp + -8 ], %i0
        sttw              %i0, [ %i4 ]
        stb               %i2, [ %i4 + 8 ]
        jmp               %i7 + 0xc
        restore           %g0, %i4, %o0

asm_test::compare_exchange::u64::relaxed_relaxed:
        save              %sp, -112, %sp
        mov               %i4, %g3
        mov               %i2, %l1
        ld                [ %fp + 0x40 ], %i4
        mov               %i1, %l0
        sttw              %l0, [ %fp + -16 ]
        add               %fp, -16, %i1
        add               %fp, -8, %i2
        mov               %i3, %g2
        sttw              %g2, [ %fp + -8 ]
        ldx               [ %i1 ], %o0
        ldx               [ %i2 ], %o1
        casx              [ %i0 ], %o0, %o1
        cmp               %o1, %o0
        stx               %o1, [ %i2 ]
        mov               %g0, %i2
        move              %xcc, 1, %i2
        ldtw              [ %fp + -8 ], %i0
        sttw              %i0, [ %i4 ]
        stb               %i2, [ %i4 + 8 ]
        jmp               %i7 + 0xc
        restore           %g0, %i4, %o0

asm_test::compare_exchange::u64::release_acquire:
        save              %sp, -112, %sp
        mov               %i4, %g3
        mov               %i2, %l1
        ld                [ %fp + 0x40 ], %i4
        mov               %i1, %l0
        sttw              %l0, [ %fp + -16 ]
        add               %fp, -16, %i1
        add               %fp, -8, %i2
        mov               %i3, %g2
        sttw              %g2, [ %fp + -8 ]
        ldx               [ %i1 ], %o0
        ldx               [ %i2 ], %o1
        membar            #StoreStore|#LoadStore
        casx              [ %i0 ], %o0, %o1
        cmp               %o1, %o0
        membar            #LoadStore|#LoadLoad
        stx               %o1, [ %i2 ]
        mov               %g0, %i2
        move              %xcc, 1, %i2
        ldtw              [ %fp + -8 ], %i0
        sttw              %i0, [ %i4 ]
        stb               %i2, [ %i4 + 8 ]
        jmp               %i7 + 0xc
        restore           %g0, %i4, %o0

asm_test::compare_exchange::u64::release_relaxed:
        save              %sp, -112, %sp
        mov               %i4, %g3
        mov               %i2, %l1
        ld                [ %fp + 0x40 ], %i4
        mov               %i1, %l0
        sttw              %l0, [ %fp + -16 ]
        add               %fp, -16, %i1
        add               %fp, -8, %i2
        mov               %i3, %g2
        sttw              %g2, [ %fp + -8 ]
        ldx               [ %i1 ], %o0
        ldx               [ %i2 ], %o1
        membar            #StoreStore|#LoadStore
        casx              [ %i0 ], %o0, %o1
        cmp               %o1, %o0
        stx               %o1, [ %i2 ]
        mov               %g0, %i2
        move              %xcc, 1, %i2
        ldtw              [ %fp + -8 ], %i0
        sttw              %i0, [ %i4 ]
        stb               %i2, [ %i4 + 8 ]
        jmp               %i7 + 0xc
        restore           %g0, %i4, %o0

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        sll               %i1, %i4, %i1
        and               %i2, 0xff, %i2
        sll               %i2, %i4, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        membar            #StoreStore|#LoadStore
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        sll               %i1, %i4, %i1
        and               %i2, 0xff, %i2
        sll               %i2, %i4, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        membar            #StoreStore|#LoadStore
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        sll               %i1, %i4, %i1
        and               %i2, 0xff, %i2
        sll               %i2, %i4, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        membar            #StoreStore|#LoadStore
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        sll               %i1, %i4, %i1
        and               %i2, 0xff, %i2
        sll               %i2, %i4, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        membar            #StoreStore|#LoadStore
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        sll               %i1, %i4, %i1
        and               %i2, 0xff, %i2
        sll               %i2, %i4, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        membar            #StoreStore|#LoadStore
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        sll               %i1, %i4, %i1
        and               %i2, 0xff, %i2
        sll               %i2, %i4, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        membar            #StoreStore|#LoadStore
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u8::release_seqcst:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        sll               %i1, %i4, %i1
        and               %i2, 0xff, %i2
        sll               %i2, %i4, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        membar            #StoreStore|#LoadStore
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        sll               %i1, %i4, %i1
        and               %i2, 0xff, %i2
        sll               %i2, %i4, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        membar            #StoreStore|#LoadStore
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        sll               %i1, %i4, %i1
        and               %i2, 0xff, %i2
        sll               %i2, %i4, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        membar            #StoreStore|#LoadStore
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u8::acquire_acquire:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        sll               %i1, %i4, %i1
        and               %i2, 0xff, %i2
        sll               %i2, %i4, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        sll               %i1, %i4, %i1
        and               %i2, 0xff, %i2
        sll               %i2, %i4, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        sll               %i1, %i4, %i1
        and               %i2, 0xff, %i2
        sll               %i2, %i4, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        sll               %i1, %i4, %i1
        and               %i2, 0xff, %i2
        sll               %i2, %i4, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u8::release_acquire:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        sll               %i1, %i4, %i1
        and               %i2, 0xff, %i2
        sll               %i2, %i4, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        membar            #StoreStore|#LoadStore
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u8::release_relaxed:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        sll               %i1, %i4, %i1
        and               %i2, 0xff, %i2
        sll               %i2, %i4, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        membar            #StoreStore|#LoadStore
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange_weak::u16::acqrel_seqcst+0xffff>
        and               %i1, %i5, %i1
        sll               %i1, %i4, %i1
        and               %i2, %i5, %i2
        sll               %i2, %i4, %i2
        sll               %i5, %i4, %i5
        membar            #StoreStore|#LoadStore
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange_weak::u16::seqcst_seqcst+0xffff>
        and               %i1, %i5, %i1
        sll               %i1, %i4, %i1
        and               %i2, %i5, %i2
        sll               %i2, %i4, %i2
        sll               %i5, %i4, %i5
        membar            #StoreStore|#LoadStore
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange_weak::u16::acqrel_acquire+0xffff>
        and               %i1, %i5, %i1
        sll               %i1, %i4, %i1
        and               %i2, %i5, %i2
        sll               %i2, %i4, %i2
        sll               %i5, %i4, %i5
        membar            #StoreStore|#LoadStore
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange_weak::u16::acqrel_relaxed+0xffff>
        and               %i1, %i5, %i1
        sll               %i1, %i4, %i1
        and               %i2, %i5, %i2
        sll               %i2, %i4, %i2
        sll               %i5, %i4, %i5
        membar            #StoreStore|#LoadStore
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange_weak::u16::acquire_seqcst+0xffff>
        and               %i1, %i5, %i1
        sll               %i1, %i4, %i1
        and               %i2, %i5, %i2
        sll               %i2, %i4, %i2
        sll               %i5, %i4, %i5
        membar            #StoreStore|#LoadStore
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange_weak::u16::relaxed_seqcst+0xffff>
        and               %i1, %i5, %i1
        sll               %i1, %i4, %i1
        and               %i2, %i5, %i2
        sll               %i2, %i4, %i2
        sll               %i5, %i4, %i5
        membar            #StoreStore|#LoadStore
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u16::release_seqcst:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange_weak::u16::release_seqcst+0xffff>
        and               %i1, %i5, %i1
        sll               %i1, %i4, %i1
        and               %i2, %i5, %i2
        sll               %i2, %i4, %i2
        sll               %i5, %i4, %i5
        membar            #StoreStore|#LoadStore
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange_weak::u16::seqcst_acquire+0xffff>
        and               %i1, %i5, %i1
        sll               %i1, %i4, %i1
        and               %i2, %i5, %i2
        sll               %i2, %i4, %i2
        sll               %i5, %i4, %i5
        membar            #StoreStore|#LoadStore
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange_weak::u16::seqcst_relaxed+0xffff>
        and               %i1, %i5, %i1
        sll               %i1, %i4, %i1
        and               %i2, %i5, %i2
        sll               %i2, %i4, %i2
        sll               %i5, %i4, %i5
        membar            #StoreStore|#LoadStore
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u16::acquire_acquire:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange_weak::u16::acquire_acquire+0xffff>
        and               %i1, %i5, %i1
        sll               %i1, %i4, %i1
        and               %i2, %i5, %i2
        sll               %i2, %i4, %i2
        sll               %i5, %i4, %i5
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange_weak::u16::acquire_relaxed+0xffff>
        and               %i1, %i5, %i1
        sll               %i1, %i4, %i1
        and               %i2, %i5, %i2
        sll               %i2, %i4, %i2
        sll               %i5, %i4, %i5
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange_weak::u16::relaxed_acquire+0xffff>
        and               %i1, %i5, %i1
        sll               %i1, %i4, %i1
        and               %i2, %i5, %i2
        sll               %i2, %i4, %i2
        sll               %i5, %i4, %i5
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange_weak::u16::relaxed_relaxed+0xffff>
        and               %i1, %i5, %i1
        sll               %i1, %i4, %i1
        and               %i2, %i5, %i2
        sll               %i2, %i4, %i2
        sll               %i5, %i4, %i5
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u16::release_acquire:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange_weak::u16::release_acquire+0xffff>
        and               %i1, %i5, %i1
        sll               %i1, %i4, %i1
        and               %i2, %i5, %i2
        sll               %i2, %i4, %i2
        sll               %i5, %i4, %i5
        membar            #StoreStore|#LoadStore
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u16::release_relaxed:
        save              %sp, -96, %sp
        and               %i0, -4, %i3
        sll               %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange_weak::u16::release_relaxed+0xffff>
        and               %i1, %i5, %i1
        sll               %i1, %i4, %i1
        and               %i2, %i5, %i2
        sll               %i2, %i4, %i2
        sll               %i5, %i4, %i5
        membar            #StoreStore|#LoadStore
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne,a             %icc, 1f
        mov               %g0, %g2
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        mov               1, %g2
1:
        mov               %g0, %i1
        srl               %i0, %i4, %i0
        cmp               %g2, 0
        movne             %icc, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        save              %sp, -96, %sp
        membar            #StoreStore|#LoadStore
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        cmp               %i0, 0
        movne             %icc, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        save              %sp, -96, %sp
        membar            #StoreStore|#LoadStore
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        cmp               %i0, 0
        movne             %icc, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        save              %sp, -96, %sp
        membar            #StoreStore|#LoadStore
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        cmp               %i0, 0
        movne             %icc, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        save              %sp, -96, %sp
        membar            #StoreStore|#LoadStore
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        cmp               %i0, 0
        movne             %icc, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        save              %sp, -96, %sp
        membar            #StoreStore|#LoadStore
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        cmp               %i0, 0
        movne             %icc, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        save              %sp, -96, %sp
        membar            #StoreStore|#LoadStore
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        cmp               %i0, 0
        movne             %icc, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u32::release_seqcst:
        save              %sp, -96, %sp
        membar            #StoreStore|#LoadStore
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        cmp               %i0, 0
        movne             %icc, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        save              %sp, -96, %sp
        membar            #StoreStore|#LoadStore
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        cmp               %i0, 0
        movne             %icc, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        save              %sp, -96, %sp
        membar            #StoreStore|#LoadStore
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        cmp               %i0, 0
        movne             %icc, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u32::acquire_acquire:
        save              %sp, -96, %sp
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        cmp               %i0, 0
        movne             %icc, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        save              %sp, -96, %sp
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        cmp               %i0, 0
        movne             %icc, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        save              %sp, -96, %sp
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        cmp               %i0, 0
        movne             %icc, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        save              %sp, -96, %sp
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        mov               %g0, %i1
        cmp               %i0, 0
        movne             %icc, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u32::release_acquire:
        save              %sp, -96, %sp
        membar            #StoreStore|#LoadStore
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #LoadStore|#LoadLoad
        mov               %g0, %i1
        cmp               %i0, 0
        movne             %icc, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u32::release_relaxed:
        save              %sp, -96, %sp
        membar            #StoreStore|#LoadStore
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        mov               %g0, %i1
        cmp               %i0, 0
        movne             %icc, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u64::acqrel_seqcst:
        save              %sp, -112, %sp
        mov               %i4, %g3
        mov               %i2, %l1
        ld                [ %fp + 0x40 ], %i4
        mov               %i1, %l0
        sttw              %l0, [ %fp + -16 ]
        add               %fp, -16, %i1
        add               %fp, -8, %i2
        mov               %i3, %g2
        sttw              %g2, [ %fp + -8 ]
        ldx               [ %i1 ], %o0
        ldx               [ %i2 ], %o1
        membar            #StoreStore|#LoadStore
        casx              [ %i0 ], %o0, %o1
        cmp               %o1, %o0
        membar            #LoadStore|#LoadLoad
        stx               %o1, [ %i2 ]
        mov               %g0, %i2
        move              %xcc, 1, %i2
        ldtw              [ %fp + -8 ], %i0
        sttw              %i0, [ %i4 ]
        stb               %i2, [ %i4 + 8 ]
        jmp               %i7 + 0xc
        restore           %g0, %i4, %o0

asm_test::compare_exchange_weak::u64::seqcst_seqcst:
        save              %sp, -112, %sp
        mov               %i4, %g3
        mov               %i2, %l1
        ld                [ %fp + 0x40 ], %i4
        mov               %i1, %l0
        sttw              %l0, [ %fp + -16 ]
        add               %fp, -16, %i1
        add               %fp, -8, %i2
        mov               %i3, %g2
        sttw              %g2, [ %fp + -8 ]
        ldx               [ %i1 ], %o0
        ldx               [ %i2 ], %o1
        membar            #StoreStore|#LoadStore
        casx              [ %i0 ], %o0, %o1
        cmp               %o1, %o0
        membar            #LoadStore|#LoadLoad
        stx               %o1, [ %i2 ]
        mov               %g0, %i2
        move              %xcc, 1, %i2
        ldtw              [ %fp + -8 ], %i0
        sttw              %i0, [ %i4 ]
        stb               %i2, [ %i4 + 8 ]
        jmp               %i7 + 0xc
        restore           %g0, %i4, %o0

asm_test::compare_exchange_weak::u64::acqrel_acquire:
        save              %sp, -112, %sp
        mov               %i4, %g3
        mov               %i2, %l1
        ld                [ %fp + 0x40 ], %i4
        mov               %i1, %l0
        sttw              %l0, [ %fp + -16 ]
        add               %fp, -16, %i1
        add               %fp, -8, %i2
        mov               %i3, %g2
        sttw              %g2, [ %fp + -8 ]
        ldx               [ %i1 ], %o0
        ldx               [ %i2 ], %o1
        membar            #StoreStore|#LoadStore
        casx              [ %i0 ], %o0, %o1
        cmp               %o1, %o0
        membar            #LoadStore|#LoadLoad
        stx               %o1, [ %i2 ]
        mov               %g0, %i2
        move              %xcc, 1, %i2
        ldtw              [ %fp + -8 ], %i0
        sttw              %i0, [ %i4 ]
        stb               %i2, [ %i4 + 8 ]
        jmp               %i7 + 0xc
        restore           %g0, %i4, %o0

asm_test::compare_exchange_weak::u64::acqrel_relaxed:
        save              %sp, -112, %sp
        mov               %i4, %g3
        mov               %i2, %l1
        ld                [ %fp + 0x40 ], %i4
        mov               %i1, %l0
        sttw              %l0, [ %fp + -16 ]
        add               %fp, -16, %i1
        add               %fp, -8, %i2
        mov               %i3, %g2
        sttw              %g2, [ %fp + -8 ]
        ldx               [ %i1 ], %o0
        ldx               [ %i2 ], %o1
        membar            #StoreStore|#LoadStore
        casx              [ %i0 ], %o0, %o1
        cmp               %o1, %o0
        membar            #LoadStore|#LoadLoad
        stx               %o1, [ %i2 ]
        mov               %g0, %i2
        move              %xcc, 1, %i2
        ldtw              [ %fp + -8 ], %i0
        sttw              %i0, [ %i4 ]
        stb               %i2, [ %i4 + 8 ]
        jmp               %i7 + 0xc
        restore           %g0, %i4, %o0

asm_test::compare_exchange_weak::u64::acquire_seqcst:
        save              %sp, -112, %sp
        mov               %i4, %g3
        mov               %i2, %l1
        ld                [ %fp + 0x40 ], %i4
        mov               %i1, %l0
        sttw              %l0, [ %fp + -16 ]
        add               %fp, -16, %i1
        add               %fp, -8, %i2
        mov               %i3, %g2
        sttw              %g2, [ %fp + -8 ]
        ldx               [ %i1 ], %o0
        ldx               [ %i2 ], %o1
        membar            #StoreStore|#LoadStore
        casx              [ %i0 ], %o0, %o1
        cmp               %o1, %o0
        membar            #LoadStore|#LoadLoad
        stx               %o1, [ %i2 ]
        mov               %g0, %i2
        move              %xcc, 1, %i2
        ldtw              [ %fp + -8 ], %i0
        sttw              %i0, [ %i4 ]
        stb               %i2, [ %i4 + 8 ]
        jmp               %i7 + 0xc
        restore           %g0, %i4, %o0

asm_test::compare_exchange_weak::u64::relaxed_seqcst:
        save              %sp, -112, %sp
        mov               %i4, %g3
        mov               %i2, %l1
        ld                [ %fp + 0x40 ], %i4
        mov               %i1, %l0
        sttw              %l0, [ %fp + -16 ]
        add               %fp, -16, %i1
        add               %fp, -8, %i2
        mov               %i3, %g2
        sttw              %g2, [ %fp + -8 ]
        ldx               [ %i1 ], %o0
        ldx               [ %i2 ], %o1
        membar            #StoreStore|#LoadStore
        casx              [ %i0 ], %o0, %o1
        cmp               %o1, %o0
        membar            #LoadStore|#LoadLoad
        stx               %o1, [ %i2 ]
        mov               %g0, %i2
        move              %xcc, 1, %i2
        ldtw              [ %fp + -8 ], %i0
        sttw              %i0, [ %i4 ]
        stb               %i2, [ %i4 + 8 ]
        jmp               %i7 + 0xc
        restore           %g0, %i4, %o0

asm_test::compare_exchange_weak::u64::release_seqcst:
        save              %sp, -112, %sp
        mov               %i4, %g3
        mov               %i2, %l1
        ld                [ %fp + 0x40 ], %i4
        mov               %i1, %l0
        sttw              %l0, [ %fp + -16 ]
        add               %fp, -16, %i1
        add               %fp, -8, %i2
        mov               %i3, %g2
        sttw              %g2, [ %fp + -8 ]
        ldx               [ %i1 ], %o0
        ldx               [ %i2 ], %o1
        membar            #StoreStore|#LoadStore
        casx              [ %i0 ], %o0, %o1
        cmp               %o1, %o0
        membar            #LoadStore|#LoadLoad
        stx               %o1, [ %i2 ]
        mov               %g0, %i2
        move              %xcc, 1, %i2
        ldtw              [ %fp + -8 ], %i0
        sttw              %i0, [ %i4 ]
        stb               %i2, [ %i4 + 8 ]
        jmp               %i7 + 0xc
        restore           %g0, %i4, %o0

asm_test::compare_exchange_weak::u64::seqcst_acquire:
        save              %sp, -112, %sp
        mov               %i4, %g3
        mov               %i2, %l1
        ld                [ %fp + 0x40 ], %i4
        mov               %i1, %l0
        sttw              %l0, [ %fp + -16 ]
        add               %fp, -16, %i1
        add               %fp, -8, %i2
        mov               %i3, %g2
        sttw              %g2, [ %fp + -8 ]
        ldx               [ %i1 ], %o0
        ldx               [ %i2 ], %o1
        membar            #StoreStore|#LoadStore
        casx              [ %i0 ], %o0, %o1
        cmp               %o1, %o0
        membar            #LoadStore|#LoadLoad
        stx               %o1, [ %i2 ]
        mov               %g0, %i2
        move              %xcc, 1, %i2
        ldtw              [ %fp + -8 ], %i0
        sttw              %i0, [ %i4 ]
        stb               %i2, [ %i4 + 8 ]
        jmp               %i7 + 0xc
        restore           %g0, %i4, %o0

asm_test::compare_exchange_weak::u64::seqcst_relaxed:
        save              %sp, -112, %sp
        mov               %i4, %g3
        mov               %i2, %l1
        ld                [ %fp + 0x40 ], %i4
        mov               %i1, %l0
        sttw              %l0, [ %fp + -16 ]
        add               %fp, -16, %i1
        add               %fp, -8, %i2
        mov               %i3, %g2
        sttw              %g2, [ %fp + -8 ]
        ldx               [ %i1 ], %o0
        ldx               [ %i2 ], %o1
        membar            #StoreStore|#LoadStore
        casx              [ %i0 ], %o0, %o1
        cmp               %o1, %o0
        membar            #LoadStore|#LoadLoad
        stx               %o1, [ %i2 ]
        mov               %g0, %i2
        move              %xcc, 1, %i2
        ldtw              [ %fp + -8 ], %i0
        sttw              %i0, [ %i4 ]
        stb               %i2, [ %i4 + 8 ]
        jmp               %i7 + 0xc
        restore           %g0, %i4, %o0

asm_test::compare_exchange_weak::u64::acquire_acquire:
        save              %sp, -112, %sp
        mov               %i4, %g3
        mov               %i2, %l1
        ld                [ %fp + 0x40 ], %i4
        mov               %i1, %l0
        sttw              %l0, [ %fp + -16 ]
        add               %fp, -16, %i1
        add               %fp, -8, %i2
        mov               %i3, %g2
        sttw              %g2, [ %fp + -8 ]
        ldx               [ %i1 ], %o0
        ldx               [ %i2 ], %o1
        casx              [ %i0 ], %o0, %o1
        cmp               %o1, %o0
        membar            #LoadStore|#LoadLoad
        stx               %o1, [ %i2 ]
        mov               %g0, %i2
        move              %xcc, 1, %i2
        ldtw              [ %fp + -8 ], %i0
        sttw              %i0, [ %i4 ]
        stb               %i2, [ %i4 + 8 ]
        jmp               %i7 + 0xc
        restore           %g0, %i4, %o0

asm_test::compare_exchange_weak::u64::acquire_relaxed:
        save              %sp, -112, %sp
        mov               %i4, %g3
        mov               %i2, %l1
        ld                [ %fp + 0x40 ], %i4
        mov               %i1, %l0
        sttw              %l0, [ %fp + -16 ]
        add               %fp, -16, %i1
        add               %fp, -8, %i2
        mov               %i3, %g2
        sttw              %g2, [ %fp + -8 ]
        ldx               [ %i1 ], %o0
        ldx               [ %i2 ], %o1
        casx              [ %i0 ], %o0, %o1
        cmp               %o1, %o0
        membar            #LoadStore|#LoadLoad
        stx               %o1, [ %i2 ]
        mov               %g0, %i2
        move              %xcc, 1, %i2
        ldtw              [ %fp + -8 ], %i0
        sttw              %i0, [ %i4 ]
        stb               %i2, [ %i4 + 8 ]
        jmp               %i7 + 0xc
        restore           %g0, %i4, %o0

asm_test::compare_exchange_weak::u64::relaxed_acquire:
        save              %sp, -112, %sp
        mov               %i4, %g3
        mov               %i2, %l1
        ld                [ %fp + 0x40 ], %i4
        mov               %i1, %l0
        sttw              %l0, [ %fp + -16 ]
        add               %fp, -16, %i1
        add               %fp, -8, %i2
        mov               %i3, %g2
        sttw              %g2, [ %fp + -8 ]
        ldx               [ %i1 ], %o0
        ldx               [ %i2 ], %o1
        casx              [ %i0 ], %o0, %o1
        cmp               %o1, %o0
        membar            #LoadStore|#LoadLoad
        stx               %o1, [ %i2 ]
        mov               %g0, %i2
        move              %xcc, 1, %i2
        ldtw              [ %fp + -8 ], %i0
        sttw              %i0, [ %i4 ]
        stb               %i2, [ %i4 + 8 ]
        jmp               %i7 + 0xc
        restore           %g0, %i4, %o0

asm_test::compare_exchange_weak::u64::relaxed_relaxed:
        save              %sp, -112, %sp
        mov               %i4, %g3
        mov               %i2, %l1
        ld                [ %fp + 0x40 ], %i4
        mov               %i1, %l0
        sttw              %l0, [ %fp + -16 ]
        add               %fp, -16, %i1
        add               %fp, -8, %i2
        mov               %i3, %g2
        sttw              %g2, [ %fp + -8 ]
        ldx               [ %i1 ], %o0
        ldx               [ %i2 ], %o1
        casx              [ %i0 ], %o0, %o1
        cmp               %o1, %o0
        stx               %o1, [ %i2 ]
        mov               %g0, %i2
        move              %xcc, 1, %i2
        ldtw              [ %fp + -8 ], %i0
        sttw              %i0, [ %i4 ]
        stb               %i2, [ %i4 + 8 ]
        jmp               %i7 + 0xc
        restore           %g0, %i4, %o0

asm_test::compare_exchange_weak::u64::release_acquire:
        save              %sp, -112, %sp
        mov               %i4, %g3
        mov               %i2, %l1
        ld                [ %fp + 0x40 ], %i4
        mov               %i1, %l0
        sttw              %l0, [ %fp + -16 ]
        add               %fp, -16, %i1
        add               %fp, -8, %i2
        mov               %i3, %g2
        sttw              %g2, [ %fp + -8 ]
        ldx               [ %i1 ], %o0
        ldx               [ %i2 ], %o1
        membar            #StoreStore|#LoadStore
        casx              [ %i0 ], %o0, %o1
        cmp               %o1, %o0
        membar            #LoadStore|#LoadLoad
        stx               %o1, [ %i2 ]
        mov               %g0, %i2
        move              %xcc, 1, %i2
        ldtw              [ %fp + -8 ], %i0
        sttw              %i0, [ %i4 ]
        stb               %i2, [ %i4 + 8 ]
        jmp               %i7 + 0xc
        restore           %g0, %i4, %o0

asm_test::compare_exchange_weak::u64::release_relaxed:
        save              %sp, -112, %sp
        mov               %i4, %g3
        mov               %i2, %l1
        ld                [ %fp + 0x40 ], %i4
        mov               %i1, %l0
        sttw              %l0, [ %fp + -16 ]
        add               %fp, -16, %i1
        add               %fp, -8, %i2
        mov               %i3, %g2
        sttw              %g2, [ %fp + -8 ]
        ldx               [ %i1 ], %o0
        ldx               [ %i2 ], %o1
        membar            #StoreStore|#LoadStore
        casx              [ %i0 ], %o0, %o1
        cmp               %o1, %o0
        stx               %o1, [ %i2 ]
        mov               %g0, %i2
        move              %xcc, 1, %i2
        ldtw              [ %fp + -8 ], %i0
        sttw              %i0, [ %i4 ]
        stb               %i2, [ %i4 + 8 ]
        jmp               %i7 + 0xc
        restore           %g0, %i4, %o0

asm_test::load::u8::seqcst:
        save              %sp, -96, %sp
        ldub              [ %i0 ], %i0
        membar            #LoadStore|#LoadLoad
        ret
        restore

asm_test::load::u8::acquire:
        save              %sp, -96, %sp
        ldub              [ %i0 ], %i0
        membar            #LoadStore|#LoadLoad
        ret
        restore

asm_test::load::u8::relaxed:
        save              %sp, -96, %sp
        ldub              [ %i0 ], %i0
        ret
        restore

asm_test::load::u16::seqcst:
        save              %sp, -96, %sp
        lduh              [ %i0 ], %i0
        membar            #LoadStore|#LoadLoad
        ret
        restore

asm_test::load::u16::acquire:
        save              %sp, -96, %sp
        lduh              [ %i0 ], %i0
        membar            #LoadStore|#LoadLoad
        ret
        restore

asm_test::load::u16::relaxed:
        save              %sp, -96, %sp
        lduh              [ %i0 ], %i0
        ret
        restore

asm_test::load::u32::seqcst:
        save              %sp, -96, %sp
        ld                [ %i0 ], %i0
        membar            #LoadStore|#LoadLoad
        ret
        restore

asm_test::load::u32::acquire:
        save              %sp, -96, %sp
        ld                [ %i0 ], %i0
        membar            #LoadStore|#LoadLoad
        ret
        restore

asm_test::load::u32::relaxed:
        save              %sp, -96, %sp
        ld                [ %i0 ], %i0
        ret
        restore

asm_test::load::u64::seqcst:
        save              %sp, -104, %sp
        add               %fp, -8, %i1
        ldx               [ %i0 ], %o0
        membar            #LoadStore|#LoadLoad
        stx               %o0, [ %i1 ]
        ldtw              [ %fp + -8 ], %i0
        ret
        restore

asm_test::load::u64::acquire:
        save              %sp, -104, %sp
        add               %fp, -8, %i1
        ldx               [ %i0 ], %o0
        membar            #LoadStore|#LoadLoad
        stx               %o0, [ %i1 ]
        ldtw              [ %fp + -8 ], %i0
        ret
        restore

asm_test::load::u64::relaxed:
        save              %sp, -104, %sp
        add               %fp, -8, %i1
        ldx               [ %i0 ], %o0
        stx               %o0, [ %i1 ]
        ldtw              [ %fp + -8 ], %i0
        ret
        restore

asm_test::swap::u8::acqrel:
        save              %sp, -96, %sp
        and               %i0, -4, %i2
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i3
        and               %i1, 0xff, %i1
        sll               %i1, %i3, %i1
        mov               0xff, %i4
        sll               %i4, %i3, %i4
        membar            #StoreStore|#LoadStore
        ld                [ %i2 ], %i5
0:
        andn              %i5, %i4, %i0
        or                %i0, %i1, %i0
        cas               [ %i2 ], %i5, %i0
        cmp               %i0, %i5
        bne,a             %icc, 0b
        mov               %i0, %i5
        membar            #LoadStore|#LoadLoad
        srl               %i0, %i3, %i0
        ret
        restore

asm_test::swap::u8::seqcst:
        save              %sp, -96, %sp
        and               %i0, -4, %i2
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i3
        and               %i1, 0xff, %i1
        sll               %i1, %i3, %i1
        mov               0xff, %i4
        sll               %i4, %i3, %i4
        membar            #StoreStore|#LoadStore
        ld                [ %i2 ], %i5
0:
        andn              %i5, %i4, %i0
        or                %i0, %i1, %i0
        cas               [ %i2 ], %i5, %i0
        cmp               %i0, %i5
        bne,a             %icc, 0b
        mov               %i0, %i5
        membar            #LoadStore|#LoadLoad
        srl               %i0, %i3, %i0
        ret
        restore

asm_test::swap::u8::acquire:
        save              %sp, -96, %sp
        and               %i0, -4, %i2
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i3
        and               %i1, 0xff, %i1
        sll               %i1, %i3, %i1
        mov               0xff, %i4
        sll               %i4, %i3, %i4
        ld                [ %i2 ], %i5
0:
        andn              %i5, %i4, %i0
        or                %i0, %i1, %i0
        cas               [ %i2 ], %i5, %i0
        cmp               %i0, %i5
        bne,a             %icc, 0b
        mov               %i0, %i5
        membar            #LoadStore|#LoadLoad
        srl               %i0, %i3, %i0
        ret
        restore

asm_test::swap::u8::relaxed:
        save              %sp, -96, %sp
        and               %i0, -4, %i2
        sll               %i0, 3, %i0
        xor               %i0, 0x18, %i3
        and               %i1, 0xff, %i1
        sll               %i1, %i3, %i1
        mov               0xff, %i4
        sll               %i4, %i3, %i4
        ld                [ %i2 ], %i5
0:
        andn              %i5, %i4, %i0
        or                %i0, %i1, %i0
        cas               [ %i2 ], %i5, %i0
        cmp               %i0, %i5
        bne,a             %icc, 0b
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
        sll               %i1, %i3, %i1
        mov               0xff, %i4
        sll               %i4, %i3, %i4
        membar            #StoreStore|#LoadStore
        ld                [ %i2 ], %i5
0:
        andn              %i5, %i4, %i0
        or                %i0, %i1, %i0
        cas               [ %i2 ], %i5, %i0
        cmp               %i0, %i5
        bne,a             %icc, 0b
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
        sll               %i1, %i3, %i1
        sll               %i4, %i3, %i4
        membar            #StoreStore|#LoadStore
        ld                [ %i2 ], %i5
0:
        andn              %i5, %i4, %i0
        or                %i0, %i1, %i0
        cas               [ %i2 ], %i5, %i0
        cmp               %i0, %i5
        bne,a             %icc, 0b
        mov               %i0, %i5
        membar            #LoadStore|#LoadLoad
        srl               %i0, %i3, %i0
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
        sll               %i1, %i3, %i1
        sll               %i4, %i3, %i4
        membar            #StoreStore|#LoadStore
        ld                [ %i2 ], %i5
0:
        andn              %i5, %i4, %i0
        or                %i0, %i1, %i0
        cas               [ %i2 ], %i5, %i0
        cmp               %i0, %i5
        bne,a             %icc, 0b
        mov               %i0, %i5
        membar            #LoadStore|#LoadLoad
        srl               %i0, %i3, %i0
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
        sll               %i1, %i3, %i1
        sll               %i4, %i3, %i4
        ld                [ %i2 ], %i5
0:
        andn              %i5, %i4, %i0
        or                %i0, %i1, %i0
        cas               [ %i2 ], %i5, %i0
        cmp               %i0, %i5
        bne,a             %icc, 0b
        mov               %i0, %i5
        membar            #LoadStore|#LoadLoad
        srl               %i0, %i3, %i0
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
        sll               %i1, %i3, %i1
        sll               %i4, %i3, %i4
        ld                [ %i2 ], %i5
0:
        andn              %i5, %i4, %i0
        or                %i0, %i1, %i0
        cas               [ %i2 ], %i5, %i0
        cmp               %i0, %i5
        bne,a             %icc, 0b
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
        sll               %i1, %i3, %i1
        sll               %i4, %i3, %i4
        membar            #StoreStore|#LoadStore
        ld                [ %i2 ], %i5
0:
        andn              %i5, %i4, %i0
        or                %i0, %i1, %i0
        cas               [ %i2 ], %i5, %i0
        cmp               %i0, %i5
        bne,a             %icc, 0b
        mov               %i0, %i5
        srl               %i0, %i3, %i0
        ret
        restore

asm_test::swap::u32::acqrel:
        save              %sp, -96, %sp
        membar            #StoreStore|#LoadStore
        ld                [ %i0 ], %i3
0:
        mov               %i1, %i2
        cas               [ %i0 ], %i3, %i2
        cmp               %i2, %i3
        bne,a             %icc, 0b
        mov               %i2, %i3
        membar            #LoadStore|#LoadLoad
        ret
        restore           %g0, %i2, %o0

asm_test::swap::u32::seqcst:
        save              %sp, -96, %sp
        membar            #StoreStore|#LoadStore
        ld                [ %i0 ], %i3
0:
        mov               %i1, %i2
        cas               [ %i0 ], %i3, %i2
        cmp               %i2, %i3
        bne,a             %icc, 0b
        mov               %i2, %i3
        membar            #LoadStore|#LoadLoad
        ret
        restore           %g0, %i2, %o0

asm_test::swap::u32::acquire:
        save              %sp, -96, %sp
        ld                [ %i0 ], %i3
0:
        mov               %i1, %i2
        cas               [ %i0 ], %i3, %i2
        cmp               %i2, %i3
        bne,a             %icc, 0b
        mov               %i2, %i3
        membar            #LoadStore|#LoadLoad
        ret
        restore           %g0, %i2, %o0

asm_test::swap::u32::relaxed:
        save              %sp, -96, %sp
        ld                [ %i0 ], %i3
0:
        mov               %i1, %i2
        cas               [ %i0 ], %i3, %i2
        cmp               %i2, %i3
        bne,a             %icc, 0b
        mov               %i2, %i3
        ret
        restore           %g0, %i2, %o0

asm_test::swap::u32::release:
        save              %sp, -96, %sp
        membar            #StoreStore|#LoadStore
        ld                [ %i0 ], %i3
0:
        mov               %i1, %i2
        cas               [ %i0 ], %i3, %i2
        cmp               %i2, %i3
        bne,a             %icc, 0b
        mov               %i2, %i3
        ret
        restore           %g0, %i2, %o0

asm_test::swap::u64::acqrel:
        save              %sp, -112, %sp
        mov               %i2, %i5
        add               %fp, -16, %i3
        add               %fp, -8, %i2
        mov               %i1, %i4
        sttw              %i4, [ %fp + -16 ]
        mov               %i3, %i1
        ldx               [ %i1 ], %o0
        membar            #StoreStore|#LoadStore
        ldx               [ %i0 ], %o2
0:
        mov               %o0, %o1
        casx              [ %i0 ], %o2, %o1
        cmp               %o1, %o2
        mov               %g0, %i3
        move              %xcc, 1, %i3
        cmp               %i3, 1
        bne,a             %icc, 0b
        mov               %o1, %o2
        membar            #LoadStore|#LoadLoad
        stx               %o1, [ %i2 ]
        ldtw              [ %fp + -8 ], %i0
        ret
        restore

asm_test::swap::u64::seqcst:
        save              %sp, -112, %sp
        mov               %i2, %i5
        add               %fp, -16, %i3
        add               %fp, -8, %i2
        mov               %i1, %i4
        sttw              %i4, [ %fp + -16 ]
        mov               %i3, %i1
        ldx               [ %i1 ], %o0
        membar            #StoreStore|#LoadStore
        ldx               [ %i0 ], %o2
0:
        mov               %o0, %o1
        casx              [ %i0 ], %o2, %o1
        cmp               %o1, %o2
        mov               %g0, %i3
        move              %xcc, 1, %i3
        cmp               %i3, 1
        bne,a             %icc, 0b
        mov               %o1, %o2
        membar            #LoadStore|#LoadLoad
        stx               %o1, [ %i2 ]
        ldtw              [ %fp + -8 ], %i0
        ret
        restore

asm_test::swap::u64::acquire:
        save              %sp, -112, %sp
        mov               %i2, %i5
        add               %fp, -16, %i3
        add               %fp, -8, %i2
        mov               %i1, %i4
        sttw              %i4, [ %fp + -16 ]
        mov               %i3, %i1
        ldx               [ %i1 ], %o0
        ldx               [ %i0 ], %o2
0:
        mov               %o0, %o1
        casx              [ %i0 ], %o2, %o1
        cmp               %o1, %o2
        mov               %g0, %i3
        move              %xcc, 1, %i3
        cmp               %i3, 1
        bne,a             %icc, 0b
        mov               %o1, %o2
        membar            #LoadStore|#LoadLoad
        stx               %o1, [ %i2 ]
        ldtw              [ %fp + -8 ], %i0
        ret
        restore

asm_test::swap::u64::relaxed:
        save              %sp, -112, %sp
        mov               %i2, %i5
        add               %fp, -16, %i3
        add               %fp, -8, %i2
        mov               %i1, %i4
        sttw              %i4, [ %fp + -16 ]
        mov               %i3, %i1
        ldx               [ %i1 ], %o0
        ldx               [ %i0 ], %o2
0:
        mov               %o0, %o1
        casx              [ %i0 ], %o2, %o1
        cmp               %o1, %o2
        mov               %g0, %i3
        move              %xcc, 1, %i3
        cmp               %i3, 1
        bne,a             %icc, 0b
        mov               %o1, %o2
        stx               %o1, [ %i2 ]
        ldtw              [ %fp + -8 ], %i0
        ret
        restore

asm_test::swap::u64::release:
        save              %sp, -112, %sp
        mov               %i2, %i5
        add               %fp, -16, %i3
        add               %fp, -8, %i2
        mov               %i1, %i4
        sttw              %i4, [ %fp + -16 ]
        mov               %i3, %i1
        ldx               [ %i1 ], %o0
        membar            #StoreStore|#LoadStore
        ldx               [ %i0 ], %o2
0:
        mov               %o0, %o1
        casx              [ %i0 ], %o2, %o1
        cmp               %o1, %o2
        mov               %g0, %i3
        move              %xcc, 1, %i3
        cmp               %i3, 1
        bne,a             %icc, 0b
        mov               %o1, %o2
        stx               %o1, [ %i2 ]
        ldtw              [ %fp + -8 ], %i0
        ret
        restore

asm_test::store::u8::seqcst:
        save              %sp, -96, %sp
        membar            #StoreStore|#LoadStore
        stb               %i1, [ %i0 ]
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ret
        restore

asm_test::store::u8::relaxed:
        save              %sp, -96, %sp
        stb               %i1, [ %i0 ]
        ret
        restore

asm_test::store::u8::release:
        save              %sp, -96, %sp
        membar            #StoreStore|#LoadStore
        stb               %i1, [ %i0 ]
        ret
        restore

asm_test::store::u16::seqcst:
        save              %sp, -96, %sp
        membar            #StoreStore|#LoadStore
        sth               %i1, [ %i0 ]
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ret
        restore

asm_test::store::u16::relaxed:
        save              %sp, -96, %sp
        sth               %i1, [ %i0 ]
        ret
        restore

asm_test::store::u16::release:
        save              %sp, -96, %sp
        membar            #StoreStore|#LoadStore
        sth               %i1, [ %i0 ]
        ret
        restore

asm_test::store::u32::seqcst:
        save              %sp, -96, %sp
        membar            #StoreStore|#LoadStore
        st                %i1, [ %i0 ]
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ret
        restore

asm_test::store::u32::relaxed:
        save              %sp, -96, %sp
        st                %i1, [ %i0 ]
        ret
        restore

asm_test::store::u32::release:
        save              %sp, -96, %sp
        membar            #StoreStore|#LoadStore
        st                %i1, [ %i0 ]
        ret
        restore

asm_test::store::u64::seqcst:
        save              %sp, -104, %sp
        mov               %i2, %i5
        add               %fp, -8, %i2
        mov               %i1, %i4
        sttw              %i4, [ %fp + -8 ]
        mov               %i2, %i1
        ldx               [ %i1 ], %o0
        membar            #StoreStore|#LoadStore
        stx               %o0, [ %i0 ]
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ret
        restore

asm_test::store::u64::relaxed:
        save              %sp, -104, %sp
        mov               %i2, %i5
        add               %fp, -8, %i2
        mov               %i1, %i4
        sttw              %i4, [ %fp + -8 ]
        mov               %i2, %i1
        ldx               [ %i1 ], %o0
        stx               %o0, [ %i0 ]
        ret
        restore

asm_test::store::u64::release:
        save              %sp, -104, %sp
        mov               %i2, %i5
        add               %fp, -8, %i2
        mov               %i1, %i4
        sttw              %i4, [ %fp + -8 ]
        mov               %i2, %i1
        ldx               [ %i1 ], %o0
        membar            #StoreStore|#LoadStore
        stx               %o0, [ %i0 ]
        ret
        restore
