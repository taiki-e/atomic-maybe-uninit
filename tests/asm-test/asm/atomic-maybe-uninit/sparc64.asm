asm_test::compare_exchange::u8::acqrel_seqcst:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange::u8::seqcst_seqcst:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange::u8::acqrel_acquire:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange::u8::acqrel_relaxed:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange::u8::acquire_seqcst:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange::u8::relaxed_seqcst:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange::u8::release_seqcst:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange::u8::seqcst_acquire:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange::u8::seqcst_relaxed:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange::u8::acquire_acquire:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
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
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange::u8::acquire_relaxed:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
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
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange::u8::relaxed_acquire:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
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
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange::u8::relaxed_relaxed:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
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
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange::u8::release_acquire:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange::u8::release_relaxed:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange::u16::acqrel_seqcst:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange::u16::acqrel_seqcst+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange::u16::seqcst_seqcst:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange::u16::seqcst_seqcst+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange::u16::acqrel_acquire:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange::u16::acqrel_acquire+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange::u16::acqrel_relaxed:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange::u16::acqrel_relaxed+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange::u16::acquire_seqcst:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange::u16::acquire_seqcst+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange::u16::relaxed_seqcst:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange::u16::relaxed_seqcst+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange::u16::release_seqcst:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange::u16::release_seqcst+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange::u16::seqcst_acquire:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange::u16::seqcst_acquire+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange::u16::seqcst_relaxed:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange::u16::seqcst_relaxed+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange::u16::acquire_acquire:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
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
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange::u16::acquire_relaxed:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
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
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange::u16::relaxed_acquire:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
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
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange::u16::relaxed_relaxed:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
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
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange::u16::release_acquire:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange::u16::release_acquire+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange::u16::release_relaxed:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange::u16::release_relaxed+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange::u32::acqrel_seqcst:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u32::seqcst_seqcst:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u32::acqrel_acquire:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u32::acqrel_relaxed:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u32::acquire_seqcst:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u32::relaxed_seqcst:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u32::release_seqcst:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u32::seqcst_acquire:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u32::seqcst_relaxed:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u32::acquire_acquire:
        save              %sp, -128, %sp
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u32::acquire_relaxed:
        save              %sp, -128, %sp
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u32::relaxed_acquire:
        save              %sp, -128, %sp
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u32::relaxed_relaxed:
        save              %sp, -128, %sp
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u32::release_acquire:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u32::release_relaxed:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u64::acqrel_seqcst:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        casx              [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %xcc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u64::seqcst_seqcst:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        casx              [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %xcc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u64::acqrel_acquire:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        casx              [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %xcc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u64::acqrel_relaxed:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        casx              [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %xcc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u64::acquire_seqcst:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        casx              [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %xcc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u64::relaxed_seqcst:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        casx              [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %xcc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u64::release_seqcst:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        casx              [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %xcc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u64::seqcst_acquire:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        casx              [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %xcc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u64::seqcst_relaxed:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        casx              [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %xcc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u64::acquire_acquire:
        save              %sp, -128, %sp
        casx              [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %xcc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u64::acquire_relaxed:
        save              %sp, -128, %sp
        casx              [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %xcc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u64::relaxed_acquire:
        save              %sp, -128, %sp
        casx              [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %xcc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u64::relaxed_relaxed:
        save              %sp, -128, %sp
        casx              [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %xcc, 1, %i0
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u64::release_acquire:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        casx              [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %xcc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange::u64::release_relaxed:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        casx              [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %xcc, 1, %i0
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u8::release_seqcst:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u8::acquire_acquire:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
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
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
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
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
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
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
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
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u8::release_acquire:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u8::release_relaxed:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
        xor               %i0, 0x18, %i4
        and               %i1, 0xff, %i1
        and               %i2, 0xff, %i2
        mov               0xff, %i5
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange_weak::u16::acqrel_seqcst+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange_weak::u16::seqcst_seqcst+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange_weak::u16::acqrel_acquire+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange_weak::u16::acqrel_relaxed+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange_weak::u16::acquire_seqcst+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange_weak::u16::relaxed_seqcst+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u16::release_seqcst:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange_weak::u16::release_seqcst+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange_weak::u16::seqcst_acquire+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange_weak::u16::seqcst_relaxed+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u16::acquire_acquire:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
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
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
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
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
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
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
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
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u16::release_acquire:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange_weak::u16::release_acquire+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u16::release_relaxed:
        save              %sp, -128, %sp
        and               %i0, -4, %i3
        sllx              %i0, 3, %i0
        xor               %i0, 0x10, %i4
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i5	! ffff <asm_test::compare_exchange_weak::u16::release_relaxed+0xffff>
        and               %i1, %i5, %i1
        and               %i2, %i5, %i2
        sll               %i5, %i4, %i5
        sll               %i1, %i4, %i1
        sll               %i2, %i4, %i2
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i3 ], %i0
0:
        and               %i0, %i5, %g2
        cmp               %i1, %g2
        bne               %icc, 1f
        nop
        mov               %i0, %g2
        andn              %i0, %i5, %i0
        or                %i0, %i2, %i0
        cas               [ %i3 ], %g2, %i0
        cmp               %i0, %g2
        bne               %icc, 0b
        nop
1:
        mov               %g0, %g2
        move              %icc, 1, %g2
        srl               %i0, %i4, %i0
        mov               %g0, %i1
        movrne            %g2, 1, %i1
        ret
        restore

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u32::release_seqcst:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u32::acquire_acquire:
        save              %sp, -128, %sp
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        save              %sp, -128, %sp
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        save              %sp, -128, %sp
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        save              %sp, -128, %sp
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u32::release_acquire:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u32::release_relaxed:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        cas               [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %icc, 1, %i0
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u64::acqrel_seqcst:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        casx              [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %xcc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u64::seqcst_seqcst:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        casx              [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %xcc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u64::acqrel_acquire:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        casx              [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %xcc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u64::acqrel_relaxed:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        casx              [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %xcc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u64::acquire_seqcst:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        casx              [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %xcc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u64::relaxed_seqcst:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        casx              [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %xcc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u64::release_seqcst:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        casx              [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %xcc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u64::seqcst_acquire:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        casx              [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %xcc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u64::seqcst_relaxed:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        casx              [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %xcc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u64::acquire_acquire:
        save              %sp, -128, %sp
        casx              [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %xcc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u64::acquire_relaxed:
        save              %sp, -128, %sp
        casx              [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %xcc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u64::relaxed_acquire:
        save              %sp, -128, %sp
        casx              [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %xcc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u64::relaxed_relaxed:
        save              %sp, -128, %sp
        casx              [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %xcc, 1, %i0
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u64::release_acquire:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        casx              [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %xcc, 1, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::compare_exchange_weak::u64::release_relaxed:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        casx              [ %i0 ], %i1, %i2
        cmp               %i2, %i1
        mov               %g0, %i0
        move              %xcc, 1, %i0
        mov               %g0, %i1
        movrne            %i0, 1, %i1
        ret
        restore           %g0, %i2, %o0

asm_test::load::u8::seqcst:
        save              %sp, -128, %sp
        membar            #StoreLoad|#LoadLoad
        ldub              [ %i0 ], %i0
        membar            #LoadStore|#LoadLoad
        ret
        restore

asm_test::load::u8::acquire:
        save              %sp, -128, %sp
        ldub              [ %i0 ], %i0
        membar            #LoadStore|#LoadLoad
        ret
        restore

asm_test::load::u8::relaxed:
        save              %sp, -128, %sp
        ldub              [ %i0 ], %i0
        ret
        restore

asm_test::load::u16::seqcst:
        save              %sp, -128, %sp
        membar            #StoreLoad|#LoadLoad
        lduh              [ %i0 ], %i0
        membar            #LoadStore|#LoadLoad
        ret
        restore

asm_test::load::u16::acquire:
        save              %sp, -128, %sp
        lduh              [ %i0 ], %i0
        membar            #LoadStore|#LoadLoad
        ret
        restore

asm_test::load::u16::relaxed:
        save              %sp, -128, %sp
        lduh              [ %i0 ], %i0
        ret
        restore

asm_test::load::u32::seqcst:
        save              %sp, -128, %sp
        membar            #StoreLoad|#LoadLoad
        ld                [ %i0 ], %i0
        membar            #LoadStore|#LoadLoad
        ret
        restore

asm_test::load::u32::acquire:
        save              %sp, -128, %sp
        ld                [ %i0 ], %i0
        membar            #LoadStore|#LoadLoad
        ret
        restore

asm_test::load::u32::relaxed:
        save              %sp, -128, %sp
        ld                [ %i0 ], %i0
        ret
        restore

asm_test::load::u64::seqcst:
        save              %sp, -128, %sp
        membar            #StoreLoad|#LoadLoad
        ldx               [ %i0 ], %i0
        membar            #LoadStore|#LoadLoad
        ret
        restore

asm_test::load::u64::acquire:
        save              %sp, -128, %sp
        ldx               [ %i0 ], %i0
        membar            #LoadStore|#LoadLoad
        ret
        restore

asm_test::load::u64::relaxed:
        save              %sp, -128, %sp
        ldx               [ %i0 ], %i0
        ret
        restore

asm_test::swap::u8::acqrel:
        save              %sp, -128, %sp
        and               %i0, -4, %i2
        sllx              %i0, 3, %i0
        xor               %i0, 0x18, %i3
        and               %i1, 0xff, %i1
        mov               0xff, %i4
        sll               %i4, %i3, %i4
        sll               %i1, %i3, %i1
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i2 ], %i0
0:
        mov               %i0, %i5
        andn              %i0, %i4, %i0
        or                %i0, %i1, %i0
        cas               [ %i2 ], %i5, %i0
        cmp               %i0, %i5
        bne               %icc, 0b
        nop
        srl               %i0, %i3, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ret
        restore

asm_test::swap::u8::seqcst:
        save              %sp, -128, %sp
        and               %i0, -4, %i2
        sllx              %i0, 3, %i0
        xor               %i0, 0x18, %i3
        and               %i1, 0xff, %i1
        mov               0xff, %i4
        sll               %i4, %i3, %i4
        sll               %i1, %i3, %i1
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i2 ], %i0
0:
        mov               %i0, %i5
        andn              %i0, %i4, %i0
        or                %i0, %i1, %i0
        cas               [ %i2 ], %i5, %i0
        cmp               %i0, %i5
        bne               %icc, 0b
        nop
        srl               %i0, %i3, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ret
        restore

asm_test::swap::u8::acquire:
        save              %sp, -128, %sp
        and               %i0, -4, %i2
        sllx              %i0, 3, %i0
        xor               %i0, 0x18, %i3
        and               %i1, 0xff, %i1
        mov               0xff, %i4
        sll               %i4, %i3, %i4
        sll               %i1, %i3, %i1
        ld                [ %i2 ], %i0
0:
        mov               %i0, %i5
        andn              %i0, %i4, %i0
        or                %i0, %i1, %i0
        cas               [ %i2 ], %i5, %i0
        cmp               %i0, %i5
        bne               %icc, 0b
        nop
        srl               %i0, %i3, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ret
        restore

asm_test::swap::u8::relaxed:
        save              %sp, -128, %sp
        and               %i0, -4, %i2
        sllx              %i0, 3, %i0
        xor               %i0, 0x18, %i3
        and               %i1, 0xff, %i1
        mov               0xff, %i4
        sll               %i4, %i3, %i4
        sll               %i1, %i3, %i1
        ld                [ %i2 ], %i0
0:
        mov               %i0, %i5
        andn              %i0, %i4, %i0
        or                %i0, %i1, %i0
        cas               [ %i2 ], %i5, %i0
        cmp               %i0, %i5
        bne               %icc, 0b
        nop
        srl               %i0, %i3, %i0
        ret
        restore

asm_test::swap::u8::release:
        save              %sp, -128, %sp
        and               %i0, -4, %i2
        sllx              %i0, 3, %i0
        xor               %i0, 0x18, %i3
        and               %i1, 0xff, %i1
        mov               0xff, %i4
        sll               %i4, %i3, %i4
        sll               %i1, %i3, %i1
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i2 ], %i0
0:
        mov               %i0, %i5
        andn              %i0, %i4, %i0
        or                %i0, %i1, %i0
        cas               [ %i2 ], %i5, %i0
        cmp               %i0, %i5
        bne               %icc, 0b
        nop
        srl               %i0, %i3, %i0
        ret
        restore

asm_test::swap::u16::acqrel:
        save              %sp, -128, %sp
        and               %i0, -4, %i2
        sllx              %i0, 3, %i0
        xor               %i0, 0x10, %i3
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i4	! ffff <asm_test::swap::u16::acqrel+0xffff>
        and               %i1, %i4, %i1
        sll               %i4, %i3, %i4
        sll               %i1, %i3, %i1
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i2 ], %i0
0:
        mov               %i0, %i5
        andn              %i0, %i4, %i0
        or                %i0, %i1, %i0
        cas               [ %i2 ], %i5, %i0
        cmp               %i0, %i5
        bne               %icc, 0b
        nop
        srl               %i0, %i3, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ret
        restore

asm_test::swap::u16::seqcst:
        save              %sp, -128, %sp
        and               %i0, -4, %i2
        sllx              %i0, 3, %i0
        xor               %i0, 0x10, %i3
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i4	! ffff <asm_test::swap::u16::seqcst+0xffff>
        and               %i1, %i4, %i1
        sll               %i4, %i3, %i4
        sll               %i1, %i3, %i1
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i2 ], %i0
0:
        mov               %i0, %i5
        andn              %i0, %i4, %i0
        or                %i0, %i1, %i0
        cas               [ %i2 ], %i5, %i0
        cmp               %i0, %i5
        bne               %icc, 0b
        nop
        srl               %i0, %i3, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ret
        restore

asm_test::swap::u16::acquire:
        save              %sp, -128, %sp
        and               %i0, -4, %i2
        sllx              %i0, 3, %i0
        xor               %i0, 0x10, %i3
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i4	! ffff <asm_test::swap::u16::acquire+0xffff>
        and               %i1, %i4, %i1
        sll               %i4, %i3, %i4
        sll               %i1, %i3, %i1
        ld                [ %i2 ], %i0
0:
        mov               %i0, %i5
        andn              %i0, %i4, %i0
        or                %i0, %i1, %i0
        cas               [ %i2 ], %i5, %i0
        cmp               %i0, %i5
        bne               %icc, 0b
        nop
        srl               %i0, %i3, %i0
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ret
        restore

asm_test::swap::u16::relaxed:
        save              %sp, -128, %sp
        and               %i0, -4, %i2
        sllx              %i0, 3, %i0
        xor               %i0, 0x10, %i3
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i4	! ffff <asm_test::swap::u16::relaxed+0xffff>
        and               %i1, %i4, %i1
        sll               %i4, %i3, %i4
        sll               %i1, %i3, %i1
        ld                [ %i2 ], %i0
0:
        mov               %i0, %i5
        andn              %i0, %i4, %i0
        or                %i0, %i1, %i0
        cas               [ %i2 ], %i5, %i0
        cmp               %i0, %i5
        bne               %icc, 0b
        nop
        srl               %i0, %i3, %i0
        ret
        restore

asm_test::swap::u16::release:
        save              %sp, -128, %sp
        and               %i0, -4, %i2
        sllx              %i0, 3, %i0
        xor               %i0, 0x10, %i3
        sethi             %hi(0xfc00), %i0
        or                %i0, 0x3ff, %i4	! ffff <asm_test::swap::u16::release+0xffff>
        and               %i1, %i4, %i1
        sll               %i4, %i3, %i4
        sll               %i1, %i3, %i1
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i2 ], %i0
0:
        mov               %i0, %i5
        andn              %i0, %i4, %i0
        or                %i0, %i1, %i0
        cas               [ %i2 ], %i5, %i0
        cmp               %i0, %i5
        bne               %icc, 0b
        nop
        srl               %i0, %i3, %i0
        ret
        restore

asm_test::swap::u32::acqrel:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i0 ], %i2
0:
        mov               %i2, %i3
        mov               %i1, %i2
        cas               [ %i0 ], %i3, %i2
        cmp               %i2, %i3
        bne               %icc, 0b
        nop
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ret
        restore           %g0, %i2, %o0

asm_test::swap::u32::seqcst:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i0 ], %i2
0:
        mov               %i2, %i3
        mov               %i1, %i2
        cas               [ %i0 ], %i3, %i2
        cmp               %i2, %i3
        bne               %icc, 0b
        nop
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ret
        restore           %g0, %i2, %o0

asm_test::swap::u32::acquire:
        save              %sp, -128, %sp
        ld                [ %i0 ], %i2
0:
        mov               %i2, %i3
        mov               %i1, %i2
        cas               [ %i0 ], %i3, %i2
        cmp               %i2, %i3
        bne               %icc, 0b
        nop
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ret
        restore           %g0, %i2, %o0

asm_test::swap::u32::relaxed:
        save              %sp, -128, %sp
        ld                [ %i0 ], %i2
0:
        mov               %i2, %i3
        mov               %i1, %i2
        cas               [ %i0 ], %i3, %i2
        cmp               %i2, %i3
        bne               %icc, 0b
        nop
        ret
        restore           %g0, %i2, %o0

asm_test::swap::u32::release:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ld                [ %i0 ], %i2
0:
        mov               %i2, %i3
        mov               %i1, %i2
        cas               [ %i0 ], %i3, %i2
        cmp               %i2, %i3
        bne               %icc, 0b
        nop
        ret
        restore           %g0, %i2, %o0

asm_test::swap::u64::acqrel:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ldx               [ %i0 ], %i2
0:
        mov               %i2, %i3
        mov               %i1, %i2
        casx              [ %i0 ], %i3, %i2
        cmp               %i2, %i3
        bne               %xcc, 0b
        nop
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ret
        restore           %g0, %i2, %o0

asm_test::swap::u64::seqcst:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ldx               [ %i0 ], %i2
0:
        mov               %i2, %i3
        mov               %i1, %i2
        casx              [ %i0 ], %i3, %i2
        cmp               %i2, %i3
        bne               %xcc, 0b
        nop
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ret
        restore           %g0, %i2, %o0

asm_test::swap::u64::acquire:
        save              %sp, -128, %sp
        ldx               [ %i0 ], %i2
0:
        mov               %i2, %i3
        mov               %i1, %i2
        casx              [ %i0 ], %i3, %i2
        cmp               %i2, %i3
        bne               %xcc, 0b
        nop
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ret
        restore           %g0, %i2, %o0

asm_test::swap::u64::relaxed:
        save              %sp, -128, %sp
        ldx               [ %i0 ], %i2
0:
        mov               %i2, %i3
        mov               %i1, %i2
        casx              [ %i0 ], %i3, %i2
        cmp               %i2, %i3
        bne               %xcc, 0b
        nop
        ret
        restore           %g0, %i2, %o0

asm_test::swap::u64::release:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore|#StoreLoad|#LoadLoad
        ldx               [ %i0 ], %i2
0:
        mov               %i2, %i3
        mov               %i1, %i2
        casx              [ %i0 ], %i3, %i2
        cmp               %i2, %i3
        bne               %xcc, 0b
        nop
        ret
        restore           %g0, %i2, %o0

asm_test::store::u8::seqcst:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore
        stb               %i1, [ %i0 ]
        membar            #StoreStore|#StoreLoad
        ret
        restore

asm_test::store::u8::relaxed:
        save              %sp, -128, %sp
        stb               %i1, [ %i0 ]
        ret
        restore

asm_test::store::u8::release:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore
        stb               %i1, [ %i0 ]
        ret
        restore

asm_test::store::u16::seqcst:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore
        sth               %i1, [ %i0 ]
        membar            #StoreStore|#StoreLoad
        ret
        restore

asm_test::store::u16::relaxed:
        save              %sp, -128, %sp
        sth               %i1, [ %i0 ]
        ret
        restore

asm_test::store::u16::release:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore
        sth               %i1, [ %i0 ]
        ret
        restore

asm_test::store::u32::seqcst:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore
        st                %i1, [ %i0 ]
        membar            #StoreStore|#StoreLoad
        ret
        restore

asm_test::store::u32::relaxed:
        save              %sp, -128, %sp
        st                %i1, [ %i0 ]
        ret
        restore

asm_test::store::u32::release:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore
        st                %i1, [ %i0 ]
        ret
        restore

asm_test::store::u64::seqcst:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore
        stx               %i1, [ %i0 ]
        membar            #StoreStore|#StoreLoad
        ret
        restore

asm_test::store::u64::relaxed:
        save              %sp, -128, %sp
        stx               %i1, [ %i0 ]
        ret
        restore

asm_test::store::u64::release:
        save              %sp, -128, %sp
        membar            #StoreStore|#LoadStore
        stx               %i1, [ %i0 ]
        ret
        restore

