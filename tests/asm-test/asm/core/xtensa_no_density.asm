asm_test::compare_exchange::u8::acqrel_seqcst:
        entry             a1, 32
        movi              a11, 255
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a9, a9
        and               a10, a4, a11
        ssl               a8
        sll               a10, a10
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a11, a11, a12
        movi              a12, -4
        and               a12, a2, a12
        memw
        l32i              a13, a12, 0
        and               a6, a13, a11
        movi              a13, 0
        movi              a14, 1
0:
        or                a7, a6, a6
        or                a15, a7, a10
        or                a6, a7, a9
        wsr.scompare1     a6
        s32c1i            a15, a12, 0
        or                a3, a14, a14
        beq               a15, a6, 1f
        or                a3, a13, a13
1:
        bnez              a3, 2f
        and               a6, a15, a11
        bne               a7, a6, 0b
2:
        ssr               a8
        srl               a2, a15
        memw
        retw

asm_test::compare_exchange::u8::seqcst_seqcst:
        entry             a1, 32
        movi              a11, 255
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a9, a9
        and               a10, a4, a11
        ssl               a8
        sll               a10, a10
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a11, a11, a12
        movi              a12, -4
        and               a12, a2, a12
        memw
        l32i              a13, a12, 0
        and               a6, a13, a11
        movi              a13, 0
        movi              a14, 1
0:
        or                a7, a6, a6
        or                a15, a7, a10
        or                a6, a7, a9
        wsr.scompare1     a6
        s32c1i            a15, a12, 0
        or                a3, a14, a14
        beq               a15, a6, 1f
        or                a3, a13, a13
1:
        bnez              a3, 2f
        and               a6, a15, a11
        bne               a7, a6, 0b
2:
        ssr               a8
        srl               a2, a15
        memw
        retw

asm_test::compare_exchange::u8::acqrel_acquire:
        entry             a1, 32
        movi              a11, 255
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a9, a9
        and               a10, a4, a11
        ssl               a8
        sll               a10, a10
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a11, a11, a12
        movi              a12, -4
        and               a12, a2, a12
        memw
        l32i              a13, a12, 0
        and               a6, a13, a11
        movi              a13, 0
        movi              a14, 1
0:
        or                a7, a6, a6
        or                a15, a7, a10
        or                a6, a7, a9
        wsr.scompare1     a6
        s32c1i            a15, a12, 0
        or                a3, a14, a14
        beq               a15, a6, 1f
        or                a3, a13, a13
1:
        bnez              a3, 2f
        and               a6, a15, a11
        bne               a7, a6, 0b
2:
        ssr               a8
        srl               a2, a15
        memw
        retw

asm_test::compare_exchange::u8::acqrel_relaxed:
        entry             a1, 32
        movi              a11, 255
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a9, a9
        and               a10, a4, a11
        ssl               a8
        sll               a10, a10
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a11, a11, a12
        movi              a12, -4
        and               a12, a2, a12
        memw
        l32i              a13, a12, 0
        and               a6, a13, a11
        movi              a13, 0
        movi              a14, 1
0:
        or                a7, a6, a6
        or                a15, a7, a10
        or                a6, a7, a9
        wsr.scompare1     a6
        s32c1i            a15, a12, 0
        or                a3, a14, a14
        beq               a15, a6, 1f
        or                a3, a13, a13
1:
        bnez              a3, 2f
        and               a6, a15, a11
        bne               a7, a6, 0b
2:
        ssr               a8
        srl               a2, a15
        memw
        retw

asm_test::compare_exchange::u8::acquire_seqcst:
        entry             a1, 32
        movi              a11, 255
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a9, a9
        and               a10, a4, a11
        ssl               a8
        sll               a10, a10
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a11, a11, a12
        movi              a12, -4
        and               a12, a2, a12
        memw
        l32i              a13, a12, 0
        and               a6, a13, a11
        movi              a13, 0
        movi              a14, 1
0:
        or                a7, a6, a6
        or                a15, a7, a10
        or                a6, a7, a9
        wsr.scompare1     a6
        s32c1i            a15, a12, 0
        or                a3, a14, a14
        beq               a15, a6, 1f
        or                a3, a13, a13
1:
        bnez              a3, 2f
        and               a6, a15, a11
        bne               a7, a6, 0b
2:
        ssr               a8
        srl               a2, a15
        memw
        retw

asm_test::compare_exchange::u8::relaxed_seqcst:
        entry             a1, 32
        movi              a11, 255
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a9, a9
        and               a10, a4, a11
        ssl               a8
        sll               a10, a10
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a11, a11, a12
        movi              a12, -4
        and               a12, a2, a12
        memw
        l32i              a13, a12, 0
        and               a6, a13, a11
        movi              a13, 0
        movi              a14, 1
0:
        or                a7, a6, a6
        or                a15, a7, a10
        or                a6, a7, a9
        wsr.scompare1     a6
        s32c1i            a15, a12, 0
        or                a3, a14, a14
        beq               a15, a6, 1f
        or                a3, a13, a13
1:
        bnez              a3, 2f
        and               a6, a15, a11
        bne               a7, a6, 0b
2:
        ssr               a8
        srl               a2, a15
        memw
        retw

asm_test::compare_exchange::u8::release_seqcst:
        entry             a1, 32
        movi              a11, 255
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a9, a9
        and               a10, a4, a11
        ssl               a8
        sll               a10, a10
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a11, a11, a12
        movi              a12, -4
        and               a12, a2, a12
        memw
        l32i              a13, a12, 0
        and               a6, a13, a11
        movi              a13, 0
        movi              a14, 1
0:
        or                a7, a6, a6
        or                a15, a7, a10
        or                a6, a7, a9
        wsr.scompare1     a6
        s32c1i            a15, a12, 0
        or                a3, a14, a14
        beq               a15, a6, 1f
        or                a3, a13, a13
1:
        bnez              a3, 2f
        and               a6, a15, a11
        bne               a7, a6, 0b
2:
        ssr               a8
        srl               a2, a15
        memw
        retw

asm_test::compare_exchange::u8::seqcst_acquire:
        entry             a1, 32
        movi              a11, 255
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a9, a9
        and               a10, a4, a11
        ssl               a8
        sll               a10, a10
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a11, a11, a12
        movi              a12, -4
        and               a12, a2, a12
        memw
        l32i              a13, a12, 0
        and               a6, a13, a11
        movi              a13, 0
        movi              a14, 1
0:
        or                a7, a6, a6
        or                a15, a7, a10
        or                a6, a7, a9
        wsr.scompare1     a6
        s32c1i            a15, a12, 0
        or                a3, a14, a14
        beq               a15, a6, 1f
        or                a3, a13, a13
1:
        bnez              a3, 2f
        and               a6, a15, a11
        bne               a7, a6, 0b
2:
        ssr               a8
        srl               a2, a15
        memw
        retw

asm_test::compare_exchange::u8::seqcst_relaxed:
        entry             a1, 32
        movi              a11, 255
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a9, a9
        and               a10, a4, a11
        ssl               a8
        sll               a10, a10
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a11, a11, a12
        movi              a12, -4
        and               a12, a2, a12
        memw
        l32i              a13, a12, 0
        and               a6, a13, a11
        movi              a13, 0
        movi              a14, 1
0:
        or                a7, a6, a6
        or                a15, a7, a10
        or                a6, a7, a9
        wsr.scompare1     a6
        s32c1i            a15, a12, 0
        or                a3, a14, a14
        beq               a15, a6, 1f
        or                a3, a13, a13
1:
        bnez              a3, 2f
        and               a6, a15, a11
        bne               a7, a6, 0b
2:
        ssr               a8
        srl               a2, a15
        memw
        retw

asm_test::compare_exchange::u8::acquire_acquire:
        entry             a1, 32
        movi              a11, 255
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a9, a9
        and               a10, a4, a11
        ssl               a8
        sll               a10, a10
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a11, a11, a12
        movi              a12, -4
        and               a12, a2, a12
        l32i              a13, a12, 0
        and               a6, a13, a11
        movi              a13, 0
        movi              a14, 1
0:
        or                a7, a6, a6
        or                a15, a7, a10
        or                a6, a7, a9
        wsr.scompare1     a6
        s32c1i            a15, a12, 0
        or                a3, a14, a14
        beq               a15, a6, 1f
        or                a3, a13, a13
1:
        bnez              a3, 2f
        and               a6, a15, a11
        bne               a7, a6, 0b
2:
        ssr               a8
        srl               a2, a15
        memw
        retw

asm_test::compare_exchange::u8::acquire_relaxed:
        entry             a1, 32
        movi              a11, 255
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a9, a9
        and               a10, a4, a11
        ssl               a8
        sll               a10, a10
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a11, a11, a12
        movi              a12, -4
        and               a12, a2, a12
        l32i              a13, a12, 0
        and               a6, a13, a11
        movi              a13, 0
        movi              a14, 1
0:
        or                a7, a6, a6
        or                a15, a7, a10
        or                a6, a7, a9
        wsr.scompare1     a6
        s32c1i            a15, a12, 0
        or                a3, a14, a14
        beq               a15, a6, 1f
        or                a3, a13, a13
1:
        bnez              a3, 2f
        and               a6, a15, a11
        bne               a7, a6, 0b
2:
        ssr               a8
        srl               a2, a15
        memw
        retw

asm_test::compare_exchange::u8::relaxed_acquire:
        entry             a1, 32
        movi              a11, 255
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a9, a9
        and               a10, a4, a11
        ssl               a8
        sll               a10, a10
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a11, a11, a12
        movi              a12, -4
        and               a12, a2, a12
        l32i              a13, a12, 0
        and               a6, a13, a11
        movi              a13, 0
        movi              a14, 1
0:
        or                a7, a6, a6
        or                a15, a7, a10
        or                a6, a7, a9
        wsr.scompare1     a6
        s32c1i            a15, a12, 0
        or                a3, a14, a14
        beq               a15, a6, 1f
        or                a3, a13, a13
1:
        bnez              a3, 2f
        and               a6, a15, a11
        bne               a7, a6, 0b
2:
        ssr               a8
        srl               a2, a15
        memw
        retw

asm_test::compare_exchange::u8::relaxed_relaxed:
        entry             a1, 32
        movi              a11, 255
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a9, a9
        and               a10, a4, a11
        ssl               a8
        sll               a10, a10
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a11, a11, a12
        movi              a12, -4
        and               a12, a2, a12
        l32i              a13, a12, 0
        and               a6, a13, a11
        movi              a13, 0
        movi              a14, 1
0:
        or                a7, a6, a6
        or                a15, a7, a10
        or                a6, a7, a9
        wsr.scompare1     a6
        s32c1i            a15, a12, 0
        or                a3, a14, a14
        beq               a15, a6, 1f
        or                a3, a13, a13
1:
        bnez              a3, 2f
        and               a6, a15, a11
        bne               a7, a6, 0b
2:
        ssr               a8
        srl               a2, a15
        retw

asm_test::compare_exchange::u8::release_acquire:
        entry             a1, 32
        movi              a11, 255
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a9, a9
        and               a10, a4, a11
        ssl               a8
        sll               a10, a10
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a11, a11, a12
        movi              a12, -4
        and               a12, a2, a12
        memw
        l32i              a13, a12, 0
        and               a6, a13, a11
        movi              a13, 0
        movi              a14, 1
0:
        or                a7, a6, a6
        or                a15, a7, a10
        or                a6, a7, a9
        wsr.scompare1     a6
        s32c1i            a15, a12, 0
        or                a3, a14, a14
        beq               a15, a6, 1f
        or                a3, a13, a13
1:
        bnez              a3, 2f
        and               a6, a15, a11
        bne               a7, a6, 0b
2:
        ssr               a8
        srl               a2, a15
        memw
        retw

asm_test::compare_exchange::u8::release_relaxed:
        entry             a1, 32
        movi              a11, 255
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a9, a9
        and               a10, a4, a11
        ssl               a8
        sll               a10, a10
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a11, a11, a12
        movi              a12, -4
        and               a12, a2, a12
        memw
        l32i              a13, a12, 0
        and               a6, a13, a11
        movi              a13, 0
        movi              a14, 1
0:
        or                a7, a6, a6
        or                a15, a7, a10
        or                a6, a7, a9
        wsr.scompare1     a6
        s32c1i            a15, a12, 0
        or                a3, a14, a14
        beq               a15, a6, 1f
        or                a3, a13, a13
1:
        bnez              a3, 2f
        and               a6, a15, a11
        bne               a7, a6, 0b
2:
        ssr               a8
        srl               a2, a15
        retw

.literal.asm_test::compare_exchange::u16::acqrel_seqcst:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange::u16::acqrel_seqcst:
0:
        entry             a1, 32
        l32r              a11, 0b (b1004136 <asm_test::compare_exchange::u16::acqrel_seqcst+0xb1004136>)
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a9, a9
        and               a10, a4, a11
        ssl               a8
        sll               a10, a10
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a11, a11, a12
        movi              a12, -4
        and               a12, a2, a12
        memw
        l32i              a13, a12, 0
        and               a6, a13, a11
        movi              a13, 0
        movi              a14, 1
1:
        or                a7, a6, a6
        or                a15, a7, a10
        or                a6, a7, a9
        wsr.scompare1     a6
        s32c1i            a15, a12, 0
        or                a3, a14, a14
        beq               a15, a6, 2f
        or                a3, a13, a13
2:
        bnez              a3, 3f
        and               a6, a15, a11
        bne               a7, a6, 1b
3:
        ssr               a8
        srl               a2, a15
        memw
        retw

.literal.asm_test::compare_exchange::u16::seqcst_seqcst:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange::u16::seqcst_seqcst:
0:
        entry             a1, 32
        l32r              a11, 0b (b1004136 <asm_test::compare_exchange::u16::seqcst_seqcst+0xb1004136>)
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a9, a9
        and               a10, a4, a11
        ssl               a8
        sll               a10, a10
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a11, a11, a12
        movi              a12, -4
        and               a12, a2, a12
        memw
        l32i              a13, a12, 0
        and               a6, a13, a11
        movi              a13, 0
        movi              a14, 1
1:
        or                a7, a6, a6
        or                a15, a7, a10
        or                a6, a7, a9
        wsr.scompare1     a6
        s32c1i            a15, a12, 0
        or                a3, a14, a14
        beq               a15, a6, 2f
        or                a3, a13, a13
2:
        bnez              a3, 3f
        and               a6, a15, a11
        bne               a7, a6, 1b
3:
        ssr               a8
        srl               a2, a15
        memw
        retw

.literal.asm_test::compare_exchange::u16::acqrel_acquire:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange::u16::acqrel_acquire:
0:
        entry             a1, 32
        l32r              a11, 0b (b1004136 <asm_test::compare_exchange::u16::acqrel_acquire+0xb1004136>)
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a9, a9
        and               a10, a4, a11
        ssl               a8
        sll               a10, a10
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a11, a11, a12
        movi              a12, -4
        and               a12, a2, a12
        memw
        l32i              a13, a12, 0
        and               a6, a13, a11
        movi              a13, 0
        movi              a14, 1
1:
        or                a7, a6, a6
        or                a15, a7, a10
        or                a6, a7, a9
        wsr.scompare1     a6
        s32c1i            a15, a12, 0
        or                a3, a14, a14
        beq               a15, a6, 2f
        or                a3, a13, a13
2:
        bnez              a3, 3f
        and               a6, a15, a11
        bne               a7, a6, 1b
3:
        ssr               a8
        srl               a2, a15
        memw
        retw

.literal.asm_test::compare_exchange::u16::acqrel_relaxed:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange::u16::acqrel_relaxed:
0:
        entry             a1, 32
        l32r              a11, 0b (b1004136 <asm_test::compare_exchange::u16::acqrel_relaxed+0xb1004136>)
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a9, a9
        and               a10, a4, a11
        ssl               a8
        sll               a10, a10
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a11, a11, a12
        movi              a12, -4
        and               a12, a2, a12
        memw
        l32i              a13, a12, 0
        and               a6, a13, a11
        movi              a13, 0
        movi              a14, 1
1:
        or                a7, a6, a6
        or                a15, a7, a10
        or                a6, a7, a9
        wsr.scompare1     a6
        s32c1i            a15, a12, 0
        or                a3, a14, a14
        beq               a15, a6, 2f
        or                a3, a13, a13
2:
        bnez              a3, 3f
        and               a6, a15, a11
        bne               a7, a6, 1b
3:
        ssr               a8
        srl               a2, a15
        memw
        retw

.literal.asm_test::compare_exchange::u16::acquire_seqcst:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange::u16::acquire_seqcst:
0:
        entry             a1, 32
        l32r              a11, 0b (b1004136 <asm_test::compare_exchange::u16::acquire_seqcst+0xb1004136>)
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a9, a9
        and               a10, a4, a11
        ssl               a8
        sll               a10, a10
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a11, a11, a12
        movi              a12, -4
        and               a12, a2, a12
        memw
        l32i              a13, a12, 0
        and               a6, a13, a11
        movi              a13, 0
        movi              a14, 1
1:
        or                a7, a6, a6
        or                a15, a7, a10
        or                a6, a7, a9
        wsr.scompare1     a6
        s32c1i            a15, a12, 0
        or                a3, a14, a14
        beq               a15, a6, 2f
        or                a3, a13, a13
2:
        bnez              a3, 3f
        and               a6, a15, a11
        bne               a7, a6, 1b
3:
        ssr               a8
        srl               a2, a15
        memw
        retw

.literal.asm_test::compare_exchange::u16::relaxed_seqcst:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange::u16::relaxed_seqcst:
0:
        entry             a1, 32
        l32r              a11, 0b (b1004136 <asm_test::compare_exchange::u16::relaxed_seqcst+0xb1004136>)
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a9, a9
        and               a10, a4, a11
        ssl               a8
        sll               a10, a10
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a11, a11, a12
        movi              a12, -4
        and               a12, a2, a12
        memw
        l32i              a13, a12, 0
        and               a6, a13, a11
        movi              a13, 0
        movi              a14, 1
1:
        or                a7, a6, a6
        or                a15, a7, a10
        or                a6, a7, a9
        wsr.scompare1     a6
        s32c1i            a15, a12, 0
        or                a3, a14, a14
        beq               a15, a6, 2f
        or                a3, a13, a13
2:
        bnez              a3, 3f
        and               a6, a15, a11
        bne               a7, a6, 1b
3:
        ssr               a8
        srl               a2, a15
        memw
        retw

.literal.asm_test::compare_exchange::u16::release_seqcst:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange::u16::release_seqcst:
0:
        entry             a1, 32
        l32r              a11, 0b (b1004136 <asm_test::compare_exchange::u16::release_seqcst+0xb1004136>)
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a9, a9
        and               a10, a4, a11
        ssl               a8
        sll               a10, a10
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a11, a11, a12
        movi              a12, -4
        and               a12, a2, a12
        memw
        l32i              a13, a12, 0
        and               a6, a13, a11
        movi              a13, 0
        movi              a14, 1
1:
        or                a7, a6, a6
        or                a15, a7, a10
        or                a6, a7, a9
        wsr.scompare1     a6
        s32c1i            a15, a12, 0
        or                a3, a14, a14
        beq               a15, a6, 2f
        or                a3, a13, a13
2:
        bnez              a3, 3f
        and               a6, a15, a11
        bne               a7, a6, 1b
3:
        ssr               a8
        srl               a2, a15
        memw
        retw

.literal.asm_test::compare_exchange::u16::seqcst_acquire:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange::u16::seqcst_acquire:
0:
        entry             a1, 32
        l32r              a11, 0b (b1004136 <asm_test::compare_exchange::u16::seqcst_acquire+0xb1004136>)
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a9, a9
        and               a10, a4, a11
        ssl               a8
        sll               a10, a10
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a11, a11, a12
        movi              a12, -4
        and               a12, a2, a12
        memw
        l32i              a13, a12, 0
        and               a6, a13, a11
        movi              a13, 0
        movi              a14, 1
1:
        or                a7, a6, a6
        or                a15, a7, a10
        or                a6, a7, a9
        wsr.scompare1     a6
        s32c1i            a15, a12, 0
        or                a3, a14, a14
        beq               a15, a6, 2f
        or                a3, a13, a13
2:
        bnez              a3, 3f
        and               a6, a15, a11
        bne               a7, a6, 1b
3:
        ssr               a8
        srl               a2, a15
        memw
        retw

.literal.asm_test::compare_exchange::u16::seqcst_relaxed:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange::u16::seqcst_relaxed:
0:
        entry             a1, 32
        l32r              a11, 0b (b1004136 <asm_test::compare_exchange::u16::seqcst_relaxed+0xb1004136>)
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a9, a9
        and               a10, a4, a11
        ssl               a8
        sll               a10, a10
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a11, a11, a12
        movi              a12, -4
        and               a12, a2, a12
        memw
        l32i              a13, a12, 0
        and               a6, a13, a11
        movi              a13, 0
        movi              a14, 1
1:
        or                a7, a6, a6
        or                a15, a7, a10
        or                a6, a7, a9
        wsr.scompare1     a6
        s32c1i            a15, a12, 0
        or                a3, a14, a14
        beq               a15, a6, 2f
        or                a3, a13, a13
2:
        bnez              a3, 3f
        and               a6, a15, a11
        bne               a7, a6, 1b
3:
        ssr               a8
        srl               a2, a15
        memw
        retw

.literal.asm_test::compare_exchange::u16::acquire_acquire:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange::u16::acquire_acquire:
0:
        entry             a1, 32
        l32r              a11, 0b (b1004136 <asm_test::compare_exchange::u16::acquire_acquire+0xb1004136>)
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a9, a9
        and               a10, a4, a11
        ssl               a8
        sll               a10, a10
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a11, a11, a12
        movi              a12, -4
        and               a12, a2, a12
        l32i              a13, a12, 0
        and               a6, a13, a11
        movi              a13, 0
        movi              a14, 1
1:
        or                a7, a6, a6
        or                a15, a7, a10
        or                a6, a7, a9
        wsr.scompare1     a6
        s32c1i            a15, a12, 0
        or                a3, a14, a14
        beq               a15, a6, 2f
        or                a3, a13, a13
2:
        bnez              a3, 3f
        and               a6, a15, a11
        bne               a7, a6, 1b
3:
        ssr               a8
        srl               a2, a15
        memw
        retw

.literal.asm_test::compare_exchange::u16::acquire_relaxed:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange::u16::acquire_relaxed:
0:
        entry             a1, 32
        l32r              a11, 0b (b1004136 <asm_test::compare_exchange::u16::acquire_relaxed+0xb1004136>)
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a9, a9
        and               a10, a4, a11
        ssl               a8
        sll               a10, a10
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a11, a11, a12
        movi              a12, -4
        and               a12, a2, a12
        l32i              a13, a12, 0
        and               a6, a13, a11
        movi              a13, 0
        movi              a14, 1
1:
        or                a7, a6, a6
        or                a15, a7, a10
        or                a6, a7, a9
        wsr.scompare1     a6
        s32c1i            a15, a12, 0
        or                a3, a14, a14
        beq               a15, a6, 2f
        or                a3, a13, a13
2:
        bnez              a3, 3f
        and               a6, a15, a11
        bne               a7, a6, 1b
3:
        ssr               a8
        srl               a2, a15
        memw
        retw

.literal.asm_test::compare_exchange::u16::relaxed_acquire:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange::u16::relaxed_acquire:
0:
        entry             a1, 32
        l32r              a11, 0b (b1004136 <asm_test::compare_exchange::u16::relaxed_acquire+0xb1004136>)
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a9, a9
        and               a10, a4, a11
        ssl               a8
        sll               a10, a10
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a11, a11, a12
        movi              a12, -4
        and               a12, a2, a12
        l32i              a13, a12, 0
        and               a6, a13, a11
        movi              a13, 0
        movi              a14, 1
1:
        or                a7, a6, a6
        or                a15, a7, a10
        or                a6, a7, a9
        wsr.scompare1     a6
        s32c1i            a15, a12, 0
        or                a3, a14, a14
        beq               a15, a6, 2f
        or                a3, a13, a13
2:
        bnez              a3, 3f
        and               a6, a15, a11
        bne               a7, a6, 1b
3:
        ssr               a8
        srl               a2, a15
        memw
        retw

.literal.asm_test::compare_exchange::u16::relaxed_relaxed:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange::u16::relaxed_relaxed:
0:
        entry             a1, 32
        l32r              a11, 0b (b1004136 <asm_test::compare_exchange::u16::relaxed_relaxed+0xb1004136>)
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a9, a9
        and               a10, a4, a11
        ssl               a8
        sll               a10, a10
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a11, a11, a12
        movi              a12, -4
        and               a12, a2, a12
        l32i              a13, a12, 0
        and               a6, a13, a11
        movi              a13, 0
        movi              a14, 1
1:
        or                a7, a6, a6
        or                a15, a7, a10
        or                a6, a7, a9
        wsr.scompare1     a6
        s32c1i            a15, a12, 0
        or                a3, a14, a14
        beq               a15, a6, 2f
        or                a3, a13, a13
2:
        bnez              a3, 3f
        and               a6, a15, a11
        bne               a7, a6, 1b
3:
        ssr               a8
        srl               a2, a15
        retw

.literal.asm_test::compare_exchange::u16::release_acquire:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange::u16::release_acquire:
0:
        entry             a1, 32
        l32r              a11, 0b (b1004136 <asm_test::compare_exchange::u16::release_acquire+0xb1004136>)
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a9, a9
        and               a10, a4, a11
        ssl               a8
        sll               a10, a10
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a11, a11, a12
        movi              a12, -4
        and               a12, a2, a12
        memw
        l32i              a13, a12, 0
        and               a6, a13, a11
        movi              a13, 0
        movi              a14, 1
1:
        or                a7, a6, a6
        or                a15, a7, a10
        or                a6, a7, a9
        wsr.scompare1     a6
        s32c1i            a15, a12, 0
        or                a3, a14, a14
        beq               a15, a6, 2f
        or                a3, a13, a13
2:
        bnez              a3, 3f
        and               a6, a15, a11
        bne               a7, a6, 1b
3:
        ssr               a8
        srl               a2, a15
        memw
        retw

.literal.asm_test::compare_exchange::u16::release_relaxed:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange::u16::release_relaxed:
0:
        entry             a1, 32
        l32r              a11, 0b (b1004136 <asm_test::compare_exchange::u16::release_relaxed+0xb1004136>)
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a9, a9
        and               a10, a4, a11
        ssl               a8
        sll               a10, a10
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a11, a11, a12
        movi              a12, -4
        and               a12, a2, a12
        memw
        l32i              a13, a12, 0
        and               a6, a13, a11
        movi              a13, 0
        movi              a14, 1
1:
        or                a7, a6, a6
        or                a15, a7, a10
        or                a6, a7, a9
        wsr.scompare1     a6
        s32c1i            a15, a12, 0
        or                a3, a14, a14
        beq               a15, a6, 2f
        or                a3, a13, a13
2:
        bnez              a3, 3f
        and               a6, a15, a11
        bne               a7, a6, 1b
3:
        ssr               a8
        srl               a2, a15
        retw

asm_test::compare_exchange::u32::acqrel_seqcst:
        entry             a1, 32
        memw
        wsr.scompare1     a3
        s32c1i            a4, a2, 0
        beq               a4, a3, 0f
        movi              a3, 0
        memw
        or                a2, a4, a4
        retw
0:
        movi              a3, 1
        memw
        or                a2, a4, a4
        retw

asm_test::compare_exchange::u32::seqcst_seqcst:
        entry             a1, 32
        memw
        wsr.scompare1     a3
        s32c1i            a4, a2, 0
        beq               a4, a3, 0f
        movi              a3, 0
        memw
        or                a2, a4, a4
        retw
0:
        movi              a3, 1
        memw
        or                a2, a4, a4
        retw

asm_test::compare_exchange::u32::acqrel_acquire:
        entry             a1, 32
        memw
        wsr.scompare1     a3
        s32c1i            a4, a2, 0
        beq               a4, a3, 0f
        movi              a3, 0
        memw
        or                a2, a4, a4
        retw
0:
        movi              a3, 1
        memw
        or                a2, a4, a4
        retw

asm_test::compare_exchange::u32::acqrel_relaxed:
        entry             a1, 32
        memw
        wsr.scompare1     a3
        s32c1i            a4, a2, 0
        beq               a4, a3, 0f
        movi              a3, 0
        memw
        or                a2, a4, a4
        retw
0:
        movi              a3, 1
        memw
        or                a2, a4, a4
        retw

asm_test::compare_exchange::u32::acquire_seqcst:
        entry             a1, 32
        memw
        wsr.scompare1     a3
        s32c1i            a4, a2, 0
        beq               a4, a3, 0f
        movi              a3, 0
        memw
        or                a2, a4, a4
        retw
0:
        movi              a3, 1
        memw
        or                a2, a4, a4
        retw

asm_test::compare_exchange::u32::relaxed_seqcst:
        entry             a1, 32
        memw
        wsr.scompare1     a3
        s32c1i            a4, a2, 0
        beq               a4, a3, 0f
        movi              a3, 0
        memw
        or                a2, a4, a4
        retw
0:
        movi              a3, 1
        memw
        or                a2, a4, a4
        retw

asm_test::compare_exchange::u32::release_seqcst:
        entry             a1, 32
        memw
        wsr.scompare1     a3
        s32c1i            a4, a2, 0
        beq               a4, a3, 0f
        movi              a3, 0
        memw
        or                a2, a4, a4
        retw
0:
        movi              a3, 1
        memw
        or                a2, a4, a4
        retw

asm_test::compare_exchange::u32::seqcst_acquire:
        entry             a1, 32
        memw
        wsr.scompare1     a3
        s32c1i            a4, a2, 0
        beq               a4, a3, 0f
        movi              a3, 0
        memw
        or                a2, a4, a4
        retw
0:
        movi              a3, 1
        memw
        or                a2, a4, a4
        retw

asm_test::compare_exchange::u32::seqcst_relaxed:
        entry             a1, 32
        memw
        wsr.scompare1     a3
        s32c1i            a4, a2, 0
        beq               a4, a3, 0f
        movi              a3, 0
        memw
        or                a2, a4, a4
        retw
0:
        movi              a3, 1
        memw
        or                a2, a4, a4
        retw

asm_test::compare_exchange::u32::acquire_acquire:
        entry             a1, 32
        wsr.scompare1     a3
        s32c1i            a4, a2, 0
        beq               a4, a3, 0f
        movi              a3, 0
        memw
        or                a2, a4, a4
        retw
0:
        movi              a3, 1
        memw
        or                a2, a4, a4
        retw

asm_test::compare_exchange::u32::acquire_relaxed:
        entry             a1, 32
        wsr.scompare1     a3
        s32c1i            a4, a2, 0
        beq               a4, a3, 0f
        movi              a3, 0
        memw
        or                a2, a4, a4
        retw
0:
        movi              a3, 1
        memw
        or                a2, a4, a4
        retw

asm_test::compare_exchange::u32::relaxed_acquire:
        entry             a1, 32
        wsr.scompare1     a3
        s32c1i            a4, a2, 0
        beq               a4, a3, 0f
        movi              a3, 0
        memw
        or                a2, a4, a4
        retw
0:
        movi              a3, 1
        memw
        or                a2, a4, a4
        retw

asm_test::compare_exchange::u32::relaxed_relaxed:
        entry             a1, 32
        wsr.scompare1     a3
        s32c1i            a4, a2, 0
        beq               a4, a3, 0f
        movi              a3, 0
        or                a2, a4, a4
        retw
0:
        movi              a3, 1
        or                a2, a4, a4
        retw

asm_test::compare_exchange::u32::release_acquire:
        entry             a1, 32
        memw
        wsr.scompare1     a3
        s32c1i            a4, a2, 0
        beq               a4, a3, 0f
        movi              a3, 0
        memw
        or                a2, a4, a4
        retw
0:
        movi              a3, 1
        memw
        or                a2, a4, a4
        retw

asm_test::compare_exchange::u32::release_relaxed:
        entry             a1, 32
        memw
        wsr.scompare1     a3
        s32c1i            a4, a2, 0
        beq               a4, a3, 0f
        movi              a3, 0
        or                a2, a4, a4
        retw
0:
        movi              a3, 1
        or                a2, a4, a4
        retw

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        entry             a1, 32
        movi              a11, 255
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a10, a9
        and               a9, a4, a11
        ssl               a8
        sll               a9, a9
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a12, a11, a12
        movi              a11, -4
        and               a11, a2, a11
        memw
        l32i              a13, a11, 0
        and               a12, a13, a12
        or                a9, a12, a9
        or                a10, a12, a10
        wsr.scompare1     a10
        s32c1i            a9, a11, 0
        beq               a9, a10, 0f
        movi              a3, 0
        ssr               a8
        srl               a2, a9
        memw
        retw
0:
        movi              a3, 1
        ssr               a8
        srl               a2, a9
        memw
        retw

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        entry             a1, 32
        movi              a11, 255
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a10, a9
        and               a9, a4, a11
        ssl               a8
        sll               a9, a9
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a12, a11, a12
        movi              a11, -4
        and               a11, a2, a11
        memw
        l32i              a13, a11, 0
        and               a12, a13, a12
        or                a9, a12, a9
        or                a10, a12, a10
        wsr.scompare1     a10
        s32c1i            a9, a11, 0
        beq               a9, a10, 0f
        movi              a3, 0
        ssr               a8
        srl               a2, a9
        memw
        retw
0:
        movi              a3, 1
        ssr               a8
        srl               a2, a9
        memw
        retw

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        entry             a1, 32
        movi              a11, 255
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a10, a9
        and               a9, a4, a11
        ssl               a8
        sll               a9, a9
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a12, a11, a12
        movi              a11, -4
        and               a11, a2, a11
        memw
        l32i              a13, a11, 0
        and               a12, a13, a12
        or                a9, a12, a9
        or                a10, a12, a10
        wsr.scompare1     a10
        s32c1i            a9, a11, 0
        beq               a9, a10, 0f
        movi              a3, 0
        ssr               a8
        srl               a2, a9
        memw
        retw
0:
        movi              a3, 1
        ssr               a8
        srl               a2, a9
        memw
        retw

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        entry             a1, 32
        movi              a11, 255
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a10, a9
        and               a9, a4, a11
        ssl               a8
        sll               a9, a9
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a12, a11, a12
        movi              a11, -4
        and               a11, a2, a11
        memw
        l32i              a13, a11, 0
        and               a12, a13, a12
        or                a9, a12, a9
        or                a10, a12, a10
        wsr.scompare1     a10
        s32c1i            a9, a11, 0
        beq               a9, a10, 0f
        movi              a3, 0
        ssr               a8
        srl               a2, a9
        memw
        retw
0:
        movi              a3, 1
        ssr               a8
        srl               a2, a9
        memw
        retw

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        entry             a1, 32
        movi              a11, 255
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a10, a9
        and               a9, a4, a11
        ssl               a8
        sll               a9, a9
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a12, a11, a12
        movi              a11, -4
        and               a11, a2, a11
        memw
        l32i              a13, a11, 0
        and               a12, a13, a12
        or                a9, a12, a9
        or                a10, a12, a10
        wsr.scompare1     a10
        s32c1i            a9, a11, 0
        beq               a9, a10, 0f
        movi              a3, 0
        ssr               a8
        srl               a2, a9
        memw
        retw
0:
        movi              a3, 1
        ssr               a8
        srl               a2, a9
        memw
        retw

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        entry             a1, 32
        movi              a11, 255
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a10, a9
        and               a9, a4, a11
        ssl               a8
        sll               a9, a9
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a12, a11, a12
        movi              a11, -4
        and               a11, a2, a11
        memw
        l32i              a13, a11, 0
        and               a12, a13, a12
        or                a9, a12, a9
        or                a10, a12, a10
        wsr.scompare1     a10
        s32c1i            a9, a11, 0
        beq               a9, a10, 0f
        movi              a3, 0
        ssr               a8
        srl               a2, a9
        memw
        retw
0:
        movi              a3, 1
        ssr               a8
        srl               a2, a9
        memw
        retw

asm_test::compare_exchange_weak::u8::release_seqcst:
        entry             a1, 32
        movi              a11, 255
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a10, a9
        and               a9, a4, a11
        ssl               a8
        sll               a9, a9
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a12, a11, a12
        movi              a11, -4
        and               a11, a2, a11
        memw
        l32i              a13, a11, 0
        and               a12, a13, a12
        or                a9, a12, a9
        or                a10, a12, a10
        wsr.scompare1     a10
        s32c1i            a9, a11, 0
        beq               a9, a10, 0f
        movi              a3, 0
        ssr               a8
        srl               a2, a9
        memw
        retw
0:
        movi              a3, 1
        ssr               a8
        srl               a2, a9
        memw
        retw

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        entry             a1, 32
        movi              a11, 255
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a10, a9
        and               a9, a4, a11
        ssl               a8
        sll               a9, a9
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a12, a11, a12
        movi              a11, -4
        and               a11, a2, a11
        memw
        l32i              a13, a11, 0
        and               a12, a13, a12
        or                a9, a12, a9
        or                a10, a12, a10
        wsr.scompare1     a10
        s32c1i            a9, a11, 0
        beq               a9, a10, 0f
        movi              a3, 0
        ssr               a8
        srl               a2, a9
        memw
        retw
0:
        movi              a3, 1
        ssr               a8
        srl               a2, a9
        memw
        retw

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        entry             a1, 32
        movi              a11, 255
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a10, a9
        and               a9, a4, a11
        ssl               a8
        sll               a9, a9
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a12, a11, a12
        movi              a11, -4
        and               a11, a2, a11
        memw
        l32i              a13, a11, 0
        and               a12, a13, a12
        or                a9, a12, a9
        or                a10, a12, a10
        wsr.scompare1     a10
        s32c1i            a9, a11, 0
        beq               a9, a10, 0f
        movi              a3, 0
        ssr               a8
        srl               a2, a9
        memw
        retw
0:
        movi              a3, 1
        ssr               a8
        srl               a2, a9
        memw
        retw

asm_test::compare_exchange_weak::u8::acquire_acquire:
        entry             a1, 32
        movi              a11, 255
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a10, a9
        and               a9, a4, a11
        ssl               a8
        sll               a9, a9
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a12, a11, a12
        movi              a11, -4
        and               a11, a2, a11
        l32i              a13, a11, 0
        and               a12, a13, a12
        or                a9, a12, a9
        or                a10, a12, a10
        wsr.scompare1     a10
        s32c1i            a9, a11, 0
        beq               a9, a10, 0f
        movi              a3, 0
        ssr               a8
        srl               a2, a9
        memw
        retw
0:
        movi              a3, 1
        ssr               a8
        srl               a2, a9
        memw
        retw

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        entry             a1, 32
        movi              a11, 255
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a10, a9
        and               a9, a4, a11
        ssl               a8
        sll               a9, a9
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a12, a11, a12
        movi              a11, -4
        and               a11, a2, a11
        l32i              a13, a11, 0
        and               a12, a13, a12
        or                a9, a12, a9
        or                a10, a12, a10
        wsr.scompare1     a10
        s32c1i            a9, a11, 0
        beq               a9, a10, 0f
        movi              a3, 0
        ssr               a8
        srl               a2, a9
        memw
        retw
0:
        movi              a3, 1
        ssr               a8
        srl               a2, a9
        memw
        retw

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        entry             a1, 32
        movi              a11, 255
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a10, a9
        and               a9, a4, a11
        ssl               a8
        sll               a9, a9
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a12, a11, a12
        movi              a11, -4
        and               a11, a2, a11
        l32i              a13, a11, 0
        and               a12, a13, a12
        or                a9, a12, a9
        or                a10, a12, a10
        wsr.scompare1     a10
        s32c1i            a9, a11, 0
        beq               a9, a10, 0f
        movi              a3, 0
        ssr               a8
        srl               a2, a9
        memw
        retw
0:
        movi              a3, 1
        ssr               a8
        srl               a2, a9
        memw
        retw

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        entry             a1, 32
        movi              a11, 255
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a10, a9
        and               a9, a4, a11
        ssl               a8
        sll               a9, a9
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a12, a11, a12
        movi              a11, -4
        and               a11, a2, a11
        l32i              a13, a11, 0
        and               a12, a13, a12
        or                a9, a12, a9
        or                a10, a12, a10
        wsr.scompare1     a10
        s32c1i            a9, a11, 0
        beq               a9, a10, 0f
        movi              a3, 0
        ssr               a8
        srl               a2, a9
        retw
0:
        movi              a3, 1
        ssr               a8
        srl               a2, a9
        retw

asm_test::compare_exchange_weak::u8::release_acquire:
        entry             a1, 32
        movi              a11, 255
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a10, a9
        and               a9, a4, a11
        ssl               a8
        sll               a9, a9
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a12, a11, a12
        movi              a11, -4
        and               a11, a2, a11
        memw
        l32i              a13, a11, 0
        and               a12, a13, a12
        or                a9, a12, a9
        or                a10, a12, a10
        wsr.scompare1     a10
        s32c1i            a9, a11, 0
        beq               a9, a10, 0f
        movi              a3, 0
        ssr               a8
        srl               a2, a9
        memw
        retw
0:
        movi              a3, 1
        ssr               a8
        srl               a2, a9
        memw
        retw

asm_test::compare_exchange_weak::u8::release_relaxed:
        entry             a1, 32
        movi              a11, 255
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a10, a9
        and               a9, a4, a11
        ssl               a8
        sll               a9, a9
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a12, a11, a12
        movi              a11, -4
        and               a11, a2, a11
        memw
        l32i              a13, a11, 0
        and               a12, a13, a12
        or                a9, a12, a9
        or                a10, a12, a10
        wsr.scompare1     a10
        s32c1i            a9, a11, 0
        beq               a9, a10, 0f
        movi              a3, 0
        ssr               a8
        srl               a2, a9
        retw
0:
        movi              a3, 1
        ssr               a8
        srl               a2, a9
        retw

.literal.asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
0:
        entry             a1, 32
        l32r              a11, 0b (b1004136 <asm_test::compare_exchange_weak::u16::acqrel_seqcst+0xb1004136>)
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a10, a9
        and               a9, a4, a11
        ssl               a8
        sll               a9, a9
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a12, a11, a12
        movi              a11, -4
        and               a11, a2, a11
        memw
        l32i              a13, a11, 0
        and               a12, a13, a12
        or                a9, a12, a9
        or                a10, a12, a10
        wsr.scompare1     a10
        s32c1i            a9, a11, 0
        beq               a9, a10, 1f
        movi              a3, 0
        ssr               a8
        srl               a2, a9
        memw
        retw
1:
        movi              a3, 1
        ssr               a8
        srl               a2, a9
        memw
        retw

.literal.asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
0:
        entry             a1, 32
        l32r              a11, 0b (b1004136 <asm_test::compare_exchange_weak::u16::seqcst_seqcst+0xb1004136>)
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a10, a9
        and               a9, a4, a11
        ssl               a8
        sll               a9, a9
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a12, a11, a12
        movi              a11, -4
        and               a11, a2, a11
        memw
        l32i              a13, a11, 0
        and               a12, a13, a12
        or                a9, a12, a9
        or                a10, a12, a10
        wsr.scompare1     a10
        s32c1i            a9, a11, 0
        beq               a9, a10, 1f
        movi              a3, 0
        ssr               a8
        srl               a2, a9
        memw
        retw
1:
        movi              a3, 1
        ssr               a8
        srl               a2, a9
        memw
        retw

.literal.asm_test::compare_exchange_weak::u16::acqrel_acquire:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange_weak::u16::acqrel_acquire:
0:
        entry             a1, 32
        l32r              a11, 0b (b1004136 <asm_test::compare_exchange_weak::u16::acqrel_acquire+0xb1004136>)
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a10, a9
        and               a9, a4, a11
        ssl               a8
        sll               a9, a9
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a12, a11, a12
        movi              a11, -4
        and               a11, a2, a11
        memw
        l32i              a13, a11, 0
        and               a12, a13, a12
        or                a9, a12, a9
        or                a10, a12, a10
        wsr.scompare1     a10
        s32c1i            a9, a11, 0
        beq               a9, a10, 1f
        movi              a3, 0
        ssr               a8
        srl               a2, a9
        memw
        retw
1:
        movi              a3, 1
        ssr               a8
        srl               a2, a9
        memw
        retw

.literal.asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
0:
        entry             a1, 32
        l32r              a11, 0b (b1004136 <asm_test::compare_exchange_weak::u16::acqrel_relaxed+0xb1004136>)
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a10, a9
        and               a9, a4, a11
        ssl               a8
        sll               a9, a9
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a12, a11, a12
        movi              a11, -4
        and               a11, a2, a11
        memw
        l32i              a13, a11, 0
        and               a12, a13, a12
        or                a9, a12, a9
        or                a10, a12, a10
        wsr.scompare1     a10
        s32c1i            a9, a11, 0
        beq               a9, a10, 1f
        movi              a3, 0
        ssr               a8
        srl               a2, a9
        memw
        retw
1:
        movi              a3, 1
        ssr               a8
        srl               a2, a9
        memw
        retw

.literal.asm_test::compare_exchange_weak::u16::acquire_seqcst:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange_weak::u16::acquire_seqcst:
0:
        entry             a1, 32
        l32r              a11, 0b (b1004136 <asm_test::compare_exchange_weak::u16::acquire_seqcst+0xb1004136>)
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a10, a9
        and               a9, a4, a11
        ssl               a8
        sll               a9, a9
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a12, a11, a12
        movi              a11, -4
        and               a11, a2, a11
        memw
        l32i              a13, a11, 0
        and               a12, a13, a12
        or                a9, a12, a9
        or                a10, a12, a10
        wsr.scompare1     a10
        s32c1i            a9, a11, 0
        beq               a9, a10, 1f
        movi              a3, 0
        ssr               a8
        srl               a2, a9
        memw
        retw
1:
        movi              a3, 1
        ssr               a8
        srl               a2, a9
        memw
        retw

.literal.asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
0:
        entry             a1, 32
        l32r              a11, 0b (b1004136 <asm_test::compare_exchange_weak::u16::relaxed_seqcst+0xb1004136>)
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a10, a9
        and               a9, a4, a11
        ssl               a8
        sll               a9, a9
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a12, a11, a12
        movi              a11, -4
        and               a11, a2, a11
        memw
        l32i              a13, a11, 0
        and               a12, a13, a12
        or                a9, a12, a9
        or                a10, a12, a10
        wsr.scompare1     a10
        s32c1i            a9, a11, 0
        beq               a9, a10, 1f
        movi              a3, 0
        ssr               a8
        srl               a2, a9
        memw
        retw
1:
        movi              a3, 1
        ssr               a8
        srl               a2, a9
        memw
        retw

.literal.asm_test::compare_exchange_weak::u16::release_seqcst:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange_weak::u16::release_seqcst:
0:
        entry             a1, 32
        l32r              a11, 0b (b1004136 <asm_test::compare_exchange_weak::u16::release_seqcst+0xb1004136>)
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a10, a9
        and               a9, a4, a11
        ssl               a8
        sll               a9, a9
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a12, a11, a12
        movi              a11, -4
        and               a11, a2, a11
        memw
        l32i              a13, a11, 0
        and               a12, a13, a12
        or                a9, a12, a9
        or                a10, a12, a10
        wsr.scompare1     a10
        s32c1i            a9, a11, 0
        beq               a9, a10, 1f
        movi              a3, 0
        ssr               a8
        srl               a2, a9
        memw
        retw
1:
        movi              a3, 1
        ssr               a8
        srl               a2, a9
        memw
        retw

.literal.asm_test::compare_exchange_weak::u16::seqcst_acquire:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange_weak::u16::seqcst_acquire:
0:
        entry             a1, 32
        l32r              a11, 0b (b1004136 <asm_test::compare_exchange_weak::u16::seqcst_acquire+0xb1004136>)
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a10, a9
        and               a9, a4, a11
        ssl               a8
        sll               a9, a9
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a12, a11, a12
        movi              a11, -4
        and               a11, a2, a11
        memw
        l32i              a13, a11, 0
        and               a12, a13, a12
        or                a9, a12, a9
        or                a10, a12, a10
        wsr.scompare1     a10
        s32c1i            a9, a11, 0
        beq               a9, a10, 1f
        movi              a3, 0
        ssr               a8
        srl               a2, a9
        memw
        retw
1:
        movi              a3, 1
        ssr               a8
        srl               a2, a9
        memw
        retw

.literal.asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
0:
        entry             a1, 32
        l32r              a11, 0b (b1004136 <asm_test::compare_exchange_weak::u16::seqcst_relaxed+0xb1004136>)
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a10, a9
        and               a9, a4, a11
        ssl               a8
        sll               a9, a9
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a12, a11, a12
        movi              a11, -4
        and               a11, a2, a11
        memw
        l32i              a13, a11, 0
        and               a12, a13, a12
        or                a9, a12, a9
        or                a10, a12, a10
        wsr.scompare1     a10
        s32c1i            a9, a11, 0
        beq               a9, a10, 1f
        movi              a3, 0
        ssr               a8
        srl               a2, a9
        memw
        retw
1:
        movi              a3, 1
        ssr               a8
        srl               a2, a9
        memw
        retw

.literal.asm_test::compare_exchange_weak::u16::acquire_acquire:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange_weak::u16::acquire_acquire:
0:
        entry             a1, 32
        l32r              a11, 0b (b1004136 <asm_test::compare_exchange_weak::u16::acquire_acquire+0xb1004136>)
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a10, a9
        and               a9, a4, a11
        ssl               a8
        sll               a9, a9
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a12, a11, a12
        movi              a11, -4
        and               a11, a2, a11
        l32i              a13, a11, 0
        and               a12, a13, a12
        or                a9, a12, a9
        or                a10, a12, a10
        wsr.scompare1     a10
        s32c1i            a9, a11, 0
        beq               a9, a10, 1f
        movi              a3, 0
        ssr               a8
        srl               a2, a9
        memw
        retw
1:
        movi              a3, 1
        ssr               a8
        srl               a2, a9
        memw
        retw

.literal.asm_test::compare_exchange_weak::u16::acquire_relaxed:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange_weak::u16::acquire_relaxed:
0:
        entry             a1, 32
        l32r              a11, 0b (b1004136 <asm_test::compare_exchange_weak::u16::acquire_relaxed+0xb1004136>)
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a10, a9
        and               a9, a4, a11
        ssl               a8
        sll               a9, a9
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a12, a11, a12
        movi              a11, -4
        and               a11, a2, a11
        l32i              a13, a11, 0
        and               a12, a13, a12
        or                a9, a12, a9
        or                a10, a12, a10
        wsr.scompare1     a10
        s32c1i            a9, a11, 0
        beq               a9, a10, 1f
        movi              a3, 0
        ssr               a8
        srl               a2, a9
        memw
        retw
1:
        movi              a3, 1
        ssr               a8
        srl               a2, a9
        memw
        retw

.literal.asm_test::compare_exchange_weak::u16::relaxed_acquire:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange_weak::u16::relaxed_acquire:
0:
        entry             a1, 32
        l32r              a11, 0b (b1004136 <asm_test::compare_exchange_weak::u16::relaxed_acquire+0xb1004136>)
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a10, a9
        and               a9, a4, a11
        ssl               a8
        sll               a9, a9
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a12, a11, a12
        movi              a11, -4
        and               a11, a2, a11
        l32i              a13, a11, 0
        and               a12, a13, a12
        or                a9, a12, a9
        or                a10, a12, a10
        wsr.scompare1     a10
        s32c1i            a9, a11, 0
        beq               a9, a10, 1f
        movi              a3, 0
        ssr               a8
        srl               a2, a9
        memw
        retw
1:
        movi              a3, 1
        ssr               a8
        srl               a2, a9
        memw
        retw

.literal.asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
0:
        entry             a1, 32
        l32r              a11, 0b (b1004136 <asm_test::compare_exchange_weak::u16::relaxed_relaxed+0xb1004136>)
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a10, a9
        and               a9, a4, a11
        ssl               a8
        sll               a9, a9
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a12, a11, a12
        movi              a11, -4
        and               a11, a2, a11
        l32i              a13, a11, 0
        and               a12, a13, a12
        or                a9, a12, a9
        or                a10, a12, a10
        wsr.scompare1     a10
        s32c1i            a9, a11, 0
        beq               a9, a10, 1f
        movi              a3, 0
        ssr               a8
        srl               a2, a9
        retw
1:
        movi              a3, 1
        ssr               a8
        srl               a2, a9
        retw

.literal.asm_test::compare_exchange_weak::u16::release_acquire:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange_weak::u16::release_acquire:
0:
        entry             a1, 32
        l32r              a11, 0b (b1004136 <asm_test::compare_exchange_weak::u16::release_acquire+0xb1004136>)
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a10, a9
        and               a9, a4, a11
        ssl               a8
        sll               a9, a9
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a12, a11, a12
        movi              a11, -4
        and               a11, a2, a11
        memw
        l32i              a13, a11, 0
        and               a12, a13, a12
        or                a9, a12, a9
        or                a10, a12, a10
        wsr.scompare1     a10
        s32c1i            a9, a11, 0
        beq               a9, a10, 1f
        movi              a3, 0
        ssr               a8
        srl               a2, a9
        memw
        retw
1:
        movi              a3, 1
        ssr               a8
        srl               a2, a9
        memw
        retw

.literal.asm_test::compare_exchange_weak::u16::release_relaxed:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange_weak::u16::release_relaxed:
0:
        entry             a1, 32
        l32r              a11, 0b (b1004136 <asm_test::compare_exchange_weak::u16::release_relaxed+0xb1004136>)
        and               a9, a3, a11
        slli              a8, a2, 3
        movi              a10, 24
        and               a8, a8, a10
        ssl               a8
        sll               a10, a9
        and               a9, a4, a11
        ssl               a8
        sll               a9, a9
        ssl               a8
        sll               a11, a11
        movi              a12, -1
        xor               a12, a11, a12
        movi              a11, -4
        and               a11, a2, a11
        memw
        l32i              a13, a11, 0
        and               a12, a13, a12
        or                a9, a12, a9
        or                a10, a12, a10
        wsr.scompare1     a10
        s32c1i            a9, a11, 0
        beq               a9, a10, 1f
        movi              a3, 0
        ssr               a8
        srl               a2, a9
        retw
1:
        movi              a3, 1
        ssr               a8
        srl               a2, a9
        retw

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        entry             a1, 32
        memw
        wsr.scompare1     a3
        s32c1i            a4, a2, 0
        beq               a4, a3, 0f
        movi              a3, 0
        memw
        or                a2, a4, a4
        retw
0:
        movi              a3, 1
        memw
        or                a2, a4, a4
        retw

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        entry             a1, 32
        memw
        wsr.scompare1     a3
        s32c1i            a4, a2, 0
        beq               a4, a3, 0f
        movi              a3, 0
        memw
        or                a2, a4, a4
        retw
0:
        movi              a3, 1
        memw
        or                a2, a4, a4
        retw

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        entry             a1, 32
        memw
        wsr.scompare1     a3
        s32c1i            a4, a2, 0
        beq               a4, a3, 0f
        movi              a3, 0
        memw
        or                a2, a4, a4
        retw
0:
        movi              a3, 1
        memw
        or                a2, a4, a4
        retw

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        entry             a1, 32
        memw
        wsr.scompare1     a3
        s32c1i            a4, a2, 0
        beq               a4, a3, 0f
        movi              a3, 0
        memw
        or                a2, a4, a4
        retw
0:
        movi              a3, 1
        memw
        or                a2, a4, a4
        retw

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        entry             a1, 32
        memw
        wsr.scompare1     a3
        s32c1i            a4, a2, 0
        beq               a4, a3, 0f
        movi              a3, 0
        memw
        or                a2, a4, a4
        retw
0:
        movi              a3, 1
        memw
        or                a2, a4, a4
        retw

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        entry             a1, 32
        memw
        wsr.scompare1     a3
        s32c1i            a4, a2, 0
        beq               a4, a3, 0f
        movi              a3, 0
        memw
        or                a2, a4, a4
        retw
0:
        movi              a3, 1
        memw
        or                a2, a4, a4
        retw

asm_test::compare_exchange_weak::u32::release_seqcst:
        entry             a1, 32
        memw
        wsr.scompare1     a3
        s32c1i            a4, a2, 0
        beq               a4, a3, 0f
        movi              a3, 0
        memw
        or                a2, a4, a4
        retw
0:
        movi              a3, 1
        memw
        or                a2, a4, a4
        retw

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        entry             a1, 32
        memw
        wsr.scompare1     a3
        s32c1i            a4, a2, 0
        beq               a4, a3, 0f
        movi              a3, 0
        memw
        or                a2, a4, a4
        retw
0:
        movi              a3, 1
        memw
        or                a2, a4, a4
        retw

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        entry             a1, 32
        memw
        wsr.scompare1     a3
        s32c1i            a4, a2, 0
        beq               a4, a3, 0f
        movi              a3, 0
        memw
        or                a2, a4, a4
        retw
0:
        movi              a3, 1
        memw
        or                a2, a4, a4
        retw

asm_test::compare_exchange_weak::u32::acquire_acquire:
        entry             a1, 32
        wsr.scompare1     a3
        s32c1i            a4, a2, 0
        beq               a4, a3, 0f
        movi              a3, 0
        memw
        or                a2, a4, a4
        retw
0:
        movi              a3, 1
        memw
        or                a2, a4, a4
        retw

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        entry             a1, 32
        wsr.scompare1     a3
        s32c1i            a4, a2, 0
        beq               a4, a3, 0f
        movi              a3, 0
        memw
        or                a2, a4, a4
        retw
0:
        movi              a3, 1
        memw
        or                a2, a4, a4
        retw

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        entry             a1, 32
        wsr.scompare1     a3
        s32c1i            a4, a2, 0
        beq               a4, a3, 0f
        movi              a3, 0
        memw
        or                a2, a4, a4
        retw
0:
        movi              a3, 1
        memw
        or                a2, a4, a4
        retw

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        entry             a1, 32
        wsr.scompare1     a3
        s32c1i            a4, a2, 0
        beq               a4, a3, 0f
        movi              a3, 0
        or                a2, a4, a4
        retw
0:
        movi              a3, 1
        or                a2, a4, a4
        retw

asm_test::compare_exchange_weak::u32::release_acquire:
        entry             a1, 32
        memw
        wsr.scompare1     a3
        s32c1i            a4, a2, 0
        beq               a4, a3, 0f
        movi              a3, 0
        memw
        or                a2, a4, a4
        retw
0:
        movi              a3, 1
        memw
        or                a2, a4, a4
        retw

asm_test::compare_exchange_weak::u32::release_relaxed:
        entry             a1, 32
        memw
        wsr.scompare1     a3
        s32c1i            a4, a2, 0
        beq               a4, a3, 0f
        movi              a3, 0
        or                a2, a4, a4
        retw
0:
        movi              a3, 1
        or                a2, a4, a4
        retw

asm_test::load::u8::seqcst:
        entry             a1, 32
        l8ui              a2, a2, 0
        memw
        retw

asm_test::load::u8::acquire:
        entry             a1, 32
        l8ui              a2, a2, 0
        memw
        retw

asm_test::load::u8::relaxed:
        entry             a1, 32
        l8ui              a2, a2, 0
        retw

asm_test::load::u16::seqcst:
        entry             a1, 32
        l16ui             a2, a2, 0
        memw
        retw

asm_test::load::u16::acquire:
        entry             a1, 32
        l16ui             a2, a2, 0
        memw
        retw

asm_test::load::u16::relaxed:
        entry             a1, 32
        l16ui             a2, a2, 0
        retw

asm_test::load::u32::seqcst:
        entry             a1, 32
        l32i              a2, a2, 0
        memw
        retw

asm_test::load::u32::acquire:
        entry             a1, 32
        l32i              a2, a2, 0
        memw
        retw

asm_test::load::u32::relaxed:
        entry             a1, 32
        l32i              a2, a2, 0
        retw

asm_test::swap::u8::acqrel:
        entry             a1, 32
        movi              a10, 255
        and               a9, a3, a10
        slli              a8, a2, 3
        movi              a11, 24
        and               a8, a8, a11
        ssl               a8
        sll               a9, a9
        ssl               a8
        sll               a10, a10
        movi              a11, -1
        xor               a10, a10, a11
        movi              a11, -4
        and               a11, a2, a11
        memw
        l32i              a15, a11, 0
        movi              a12, 0
        movi              a13, 1
        j                 1f
0:
        or                a15, a14, a14
        beqi              a7, 1, 2f
1:
        and               a14, a15, a10
        or                a14, a14, a9
        wsr.scompare1     a15
        s32c1i            a14, a11, 0
        or                a7, a13, a13
        beq               a14, a15, 0b
        or                a7, a12, a12
        j                 0b
2:
        ssr               a8
        srl               a2, a14
        memw
        retw

asm_test::swap::u8::seqcst:
        entry             a1, 32
        movi              a10, 255
        and               a9, a3, a10
        slli              a8, a2, 3
        movi              a11, 24
        and               a8, a8, a11
        ssl               a8
        sll               a9, a9
        ssl               a8
        sll               a10, a10
        movi              a11, -1
        xor               a10, a10, a11
        movi              a11, -4
        and               a11, a2, a11
        memw
        l32i              a15, a11, 0
        movi              a12, 0
        movi              a13, 1
        j                 1f
0:
        or                a15, a14, a14
        beqi              a7, 1, 2f
1:
        and               a14, a15, a10
        or                a14, a14, a9
        wsr.scompare1     a15
        s32c1i            a14, a11, 0
        or                a7, a13, a13
        beq               a14, a15, 0b
        or                a7, a12, a12
        j                 0b
2:
        ssr               a8
        srl               a2, a14
        memw
        retw

asm_test::swap::u8::acquire:
        entry             a1, 32
        movi              a10, 255
        and               a9, a3, a10
        slli              a8, a2, 3
        movi              a11, 24
        and               a8, a8, a11
        ssl               a8
        sll               a9, a9
        ssl               a8
        sll               a10, a10
        movi              a11, -1
        xor               a10, a10, a11
        movi              a11, -4
        and               a11, a2, a11
        l32i              a15, a11, 0
        movi              a12, 0
        movi              a13, 1
        j                 1f
0:
        or                a15, a14, a14
        beqi              a7, 1, 2f
1:
        and               a14, a15, a10
        or                a14, a14, a9
        wsr.scompare1     a15
        s32c1i            a14, a11, 0
        or                a7, a13, a13
        beq               a14, a15, 0b
        or                a7, a12, a12
        j                 0b
2:
        ssr               a8
        srl               a2, a14
        memw
        retw

asm_test::swap::u8::relaxed:
        entry             a1, 32
        movi              a10, 255
        and               a9, a3, a10
        slli              a8, a2, 3
        movi              a11, 24
        and               a8, a8, a11
        ssl               a8
        sll               a9, a9
        ssl               a8
        sll               a10, a10
        movi              a11, -1
        xor               a10, a10, a11
        movi              a11, -4
        and               a11, a2, a11
        l32i              a15, a11, 0
        movi              a12, 0
        movi              a13, 1
        j                 1f
0:
        or                a15, a14, a14
        beqi              a7, 1, 2f
1:
        and               a14, a15, a10
        or                a14, a14, a9
        wsr.scompare1     a15
        s32c1i            a14, a11, 0
        or                a7, a13, a13
        beq               a14, a15, 0b
        or                a7, a12, a12
        j                 0b
2:
        ssr               a8
        srl               a2, a14
        retw

asm_test::swap::u8::release:
        entry             a1, 32
        movi              a10, 255
        and               a9, a3, a10
        slli              a8, a2, 3
        movi              a11, 24
        and               a8, a8, a11
        ssl               a8
        sll               a9, a9
        ssl               a8
        sll               a10, a10
        movi              a11, -1
        xor               a10, a10, a11
        movi              a11, -4
        and               a11, a2, a11
        memw
        l32i              a15, a11, 0
        movi              a12, 0
        movi              a13, 1
        j                 1f
0:
        or                a15, a14, a14
        beqi              a7, 1, 2f
1:
        and               a14, a15, a10
        or                a14, a14, a9
        wsr.scompare1     a15
        s32c1i            a14, a11, 0
        or                a7, a13, a13
        beq               a14, a15, 0b
        or                a7, a12, a12
        j                 0b
2:
        ssr               a8
        srl               a2, a14
        retw

.literal.asm_test::swap::u16::acqrel:
        .byte             0xff
        .byte             0xff

asm_test::swap::u16::acqrel:
0:
        entry             a1, 32
        l32r              a10, 0b (a1004136 <asm_test::swap::u16::acqrel+0xa1004136>)
        and               a9, a3, a10
        slli              a8, a2, 3
        movi              a11, 24
        and               a8, a8, a11
        ssl               a8
        sll               a9, a9
        ssl               a8
        sll               a10, a10
        movi              a11, -1
        xor               a10, a10, a11
        movi              a11, -4
        and               a11, a2, a11
        memw
        l32i              a15, a11, 0
        movi              a12, 0
        movi              a13, 1
        j                 2f
1:
        or                a15, a14, a14
        beqi              a7, 1, 3f
2:
        and               a14, a15, a10
        or                a14, a14, a9
        wsr.scompare1     a15
        s32c1i            a14, a11, 0
        or                a7, a13, a13
        beq               a14, a15, 1b
        or                a7, a12, a12
        j                 1b
3:
        ssr               a8
        srl               a2, a14
        memw
        retw

.literal.asm_test::swap::u16::seqcst:
        .byte             0xff
        .byte             0xff

asm_test::swap::u16::seqcst:
0:
        entry             a1, 32
        l32r              a10, 0b (a1004136 <asm_test::swap::u16::seqcst+0xa1004136>)
        and               a9, a3, a10
        slli              a8, a2, 3
        movi              a11, 24
        and               a8, a8, a11
        ssl               a8
        sll               a9, a9
        ssl               a8
        sll               a10, a10
        movi              a11, -1
        xor               a10, a10, a11
        movi              a11, -4
        and               a11, a2, a11
        memw
        l32i              a15, a11, 0
        movi              a12, 0
        movi              a13, 1
        j                 2f
1:
        or                a15, a14, a14
        beqi              a7, 1, 3f
2:
        and               a14, a15, a10
        or                a14, a14, a9
        wsr.scompare1     a15
        s32c1i            a14, a11, 0
        or                a7, a13, a13
        beq               a14, a15, 1b
        or                a7, a12, a12
        j                 1b
3:
        ssr               a8
        srl               a2, a14
        memw
        retw

.literal.asm_test::swap::u16::acquire:
        .byte             0xff
        .byte             0xff

asm_test::swap::u16::acquire:
0:
        entry             a1, 32
        l32r              a10, 0b (a1004136 <asm_test::swap::u16::acquire+0xa1004136>)
        and               a9, a3, a10
        slli              a8, a2, 3
        movi              a11, 24
        and               a8, a8, a11
        ssl               a8
        sll               a9, a9
        ssl               a8
        sll               a10, a10
        movi              a11, -1
        xor               a10, a10, a11
        movi              a11, -4
        and               a11, a2, a11
        l32i              a15, a11, 0
        movi              a12, 0
        movi              a13, 1
        j                 2f
1:
        or                a15, a14, a14
        beqi              a7, 1, 3f
2:
        and               a14, a15, a10
        or                a14, a14, a9
        wsr.scompare1     a15
        s32c1i            a14, a11, 0
        or                a7, a13, a13
        beq               a14, a15, 1b
        or                a7, a12, a12
        j                 1b
3:
        ssr               a8
        srl               a2, a14
        memw
        retw

.literal.asm_test::swap::u16::relaxed:
        .byte             0xff
        .byte             0xff

asm_test::swap::u16::relaxed:
0:
        entry             a1, 32
        l32r              a10, 0b (a1004136 <asm_test::swap::u16::relaxed+0xa1004136>)
        and               a9, a3, a10
        slli              a8, a2, 3
        movi              a11, 24
        and               a8, a8, a11
        ssl               a8
        sll               a9, a9
        ssl               a8
        sll               a10, a10
        movi              a11, -1
        xor               a10, a10, a11
        movi              a11, -4
        and               a11, a2, a11
        l32i              a15, a11, 0
        movi              a12, 0
        movi              a13, 1
        j                 2f
1:
        or                a15, a14, a14
        beqi              a7, 1, 3f
2:
        and               a14, a15, a10
        or                a14, a14, a9
        wsr.scompare1     a15
        s32c1i            a14, a11, 0
        or                a7, a13, a13
        beq               a14, a15, 1b
        or                a7, a12, a12
        j                 1b
3:
        ssr               a8
        srl               a2, a14
        retw

.literal.asm_test::swap::u16::release:
        .byte             0xff
        .byte             0xff

asm_test::swap::u16::release:
0:
        entry             a1, 32
        l32r              a10, 0b (a1004136 <asm_test::swap::u16::release+0xa1004136>)
        and               a9, a3, a10
        slli              a8, a2, 3
        movi              a11, 24
        and               a8, a8, a11
        ssl               a8
        sll               a9, a9
        ssl               a8
        sll               a10, a10
        movi              a11, -1
        xor               a10, a10, a11
        movi              a11, -4
        and               a11, a2, a11
        memw
        l32i              a15, a11, 0
        movi              a12, 0
        movi              a13, 1
        j                 2f
1:
        or                a15, a14, a14
        beqi              a7, 1, 3f
2:
        and               a14, a15, a10
        or                a14, a14, a9
        wsr.scompare1     a15
        s32c1i            a14, a11, 0
        or                a7, a13, a13
        beq               a14, a15, 1b
        or                a7, a12, a12
        j                 1b
3:
        ssr               a8
        srl               a2, a14
        retw

asm_test::swap::u32::acqrel:
        entry             a1, 32
        memw
        l32i              a11, a2, 0
        movi              a9, 0
        movi              a10, 1
        j                 1f
0:
        or                a11, a8, a8
        beqi              a12, 1, 2f
1:
        wsr.scompare1     a11
        or                a8, a3, a3
        s32c1i            a8, a2, 0
        or                a12, a10, a10
        beq               a8, a11, 0b
        or                a12, a9, a9
        j                 0b
2:
        memw
        or                a2, a8, a8
        retw

asm_test::swap::u32::seqcst:
        entry             a1, 32
        memw
        l32i              a11, a2, 0
        movi              a9, 0
        movi              a10, 1
        j                 1f
0:
        or                a11, a8, a8
        beqi              a12, 1, 2f
1:
        wsr.scompare1     a11
        or                a8, a3, a3
        s32c1i            a8, a2, 0
        or                a12, a10, a10
        beq               a8, a11, 0b
        or                a12, a9, a9
        j                 0b
2:
        memw
        or                a2, a8, a8
        retw

asm_test::swap::u32::acquire:
        entry             a1, 32
        l32i              a11, a2, 0
        movi              a9, 0
        movi              a10, 1
        j                 1f
0:
        or                a11, a8, a8
        beqi              a12, 1, 2f
1:
        wsr.scompare1     a11
        or                a8, a3, a3
        s32c1i            a8, a2, 0
        or                a12, a10, a10
        beq               a8, a11, 0b
        or                a12, a9, a9
        j                 0b
2:
        memw
        or                a2, a8, a8
        retw

asm_test::swap::u32::relaxed:
        entry             a1, 32
        l32i              a11, a2, 0
        movi              a9, 0
        movi              a10, 1
        j                 1f
0:
        or                a11, a8, a8
        beqi              a12, 1, 2f
1:
        wsr.scompare1     a11
        or                a8, a3, a3
        s32c1i            a8, a2, 0
        or                a12, a10, a10
        beq               a8, a11, 0b
        or                a12, a9, a9
        j                 0b
2:
        or                a2, a8, a8
        retw

asm_test::swap::u32::release:
        entry             a1, 32
        memw
        l32i              a11, a2, 0
        movi              a9, 0
        movi              a10, 1
        j                 1f
0:
        or                a11, a8, a8
        beqi              a12, 1, 2f
1:
        wsr.scompare1     a11
        or                a8, a3, a3
        s32c1i            a8, a2, 0
        or                a12, a10, a10
        beq               a8, a11, 0b
        or                a12, a9, a9
        j                 0b
2:
        or                a2, a8, a8
        retw

asm_test::store::u8::seqcst:
        entry             a1, 32
        memw
        s8i               a3, a2, 0
        memw
        retw

asm_test::store::u8::relaxed:
        entry             a1, 32
        s8i               a3, a2, 0
        retw

asm_test::store::u8::release:
        entry             a1, 32
        memw
        s8i               a3, a2, 0
        retw

asm_test::store::u16::seqcst:
        entry             a1, 32
        memw
        s16i              a3, a2, 0
        memw
        retw

asm_test::store::u16::relaxed:
        entry             a1, 32
        s16i              a3, a2, 0
        retw

asm_test::store::u16::release:
        entry             a1, 32
        memw
        s16i              a3, a2, 0
        retw

asm_test::store::u32::seqcst:
        entry             a1, 32
        memw
        s32i              a3, a2, 0
        memw
        retw

asm_test::store::u32::relaxed:
        entry             a1, 32
        s32i              a3, a2, 0
        retw

asm_test::store::u32::release:
        entry             a1, 32
        memw
        s32i              a3, a2, 0
        retw
