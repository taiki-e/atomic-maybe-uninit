asm_test::compare_exchange::u8::acqrel_seqcst:
        entry             a1, 32
        movi              a9, 255
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        memw
        l32i.n            a2, a12, 0
0:
        and               a14, a2, a9
        bne               a14, a10, 1f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 0b
        movi.n            a13, 1
1:
        memw
        beq               a13, a3, 2f
        movi.n            a3, 1
2:
        ssr               a8
        srl               a2, a2
        retw.n

asm_test::compare_exchange::u8::seqcst_seqcst:
        entry             a1, 32
        movi              a9, 255
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        memw
        l32i.n            a2, a12, 0
0:
        and               a14, a2, a9
        bne               a14, a10, 1f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 0b
        movi.n            a13, 1
1:
        memw
        beq               a13, a3, 2f
        movi.n            a3, 1
2:
        ssr               a8
        srl               a2, a2
        retw.n

asm_test::compare_exchange::u8::acqrel_acquire:
        entry             a1, 32
        movi              a9, 255
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        memw
        l32i.n            a2, a12, 0
0:
        and               a14, a2, a9
        bne               a14, a10, 1f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 0b
        movi.n            a13, 1
1:
        memw
        beq               a13, a3, 2f
        movi.n            a3, 1
2:
        ssr               a8
        srl               a2, a2
        retw.n

asm_test::compare_exchange::u8::acqrel_relaxed:
        entry             a1, 32
        movi              a9, 255
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        memw
        l32i.n            a2, a12, 0
0:
        and               a14, a2, a9
        bne               a14, a10, 1f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 0b
        movi.n            a13, 1
1:
        memw
        beq               a13, a3, 2f
        movi.n            a3, 1
2:
        ssr               a8
        srl               a2, a2
        retw.n

asm_test::compare_exchange::u8::acquire_seqcst:
        entry             a1, 32
        movi              a9, 255
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        memw
        l32i.n            a2, a12, 0
0:
        and               a14, a2, a9
        bne               a14, a10, 1f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 0b
        movi.n            a13, 1
1:
        memw
        beq               a13, a3, 2f
        movi.n            a3, 1
2:
        ssr               a8
        srl               a2, a2
        retw.n

asm_test::compare_exchange::u8::relaxed_seqcst:
        entry             a1, 32
        movi              a9, 255
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        memw
        l32i.n            a2, a12, 0
0:
        and               a14, a2, a9
        bne               a14, a10, 1f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 0b
        movi.n            a13, 1
1:
        memw
        beq               a13, a3, 2f
        movi.n            a3, 1
2:
        ssr               a8
        srl               a2, a2
        retw.n

asm_test::compare_exchange::u8::release_seqcst:
        entry             a1, 32
        movi              a9, 255
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        memw
        l32i.n            a2, a12, 0
0:
        and               a14, a2, a9
        bne               a14, a10, 1f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 0b
        movi.n            a13, 1
1:
        memw
        beq               a13, a3, 2f
        movi.n            a3, 1
2:
        ssr               a8
        srl               a2, a2
        retw.n

asm_test::compare_exchange::u8::seqcst_acquire:
        entry             a1, 32
        movi              a9, 255
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        memw
        l32i.n            a2, a12, 0
0:
        and               a14, a2, a9
        bne               a14, a10, 1f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 0b
        movi.n            a13, 1
1:
        memw
        beq               a13, a3, 2f
        movi.n            a3, 1
2:
        ssr               a8
        srl               a2, a2
        retw.n

asm_test::compare_exchange::u8::seqcst_relaxed:
        entry             a1, 32
        movi              a9, 255
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        memw
        l32i.n            a2, a12, 0
0:
        and               a14, a2, a9
        bne               a14, a10, 1f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 0b
        movi.n            a13, 1
1:
        memw
        beq               a13, a3, 2f
        movi.n            a3, 1
2:
        ssr               a8
        srl               a2, a2
        retw.n

asm_test::compare_exchange::u8::acquire_acquire:
        entry             a1, 32
        movi              a9, 255
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        l32i.n            a2, a12, 0
0:
        and               a14, a2, a9
        bne               a14, a10, 1f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 0b
        movi.n            a13, 1
1:
        memw
        beq               a13, a3, 2f
        movi.n            a3, 1
2:
        ssr               a8
        srl               a2, a2
        retw.n

asm_test::compare_exchange::u8::acquire_relaxed:
        entry             a1, 32
        movi              a9, 255
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        l32i.n            a2, a12, 0
0:
        and               a14, a2, a9
        bne               a14, a10, 1f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 0b
        movi.n            a13, 1
1:
        memw
        beq               a13, a3, 2f
        movi.n            a3, 1
2:
        ssr               a8
        srl               a2, a2
        retw.n

asm_test::compare_exchange::u8::relaxed_acquire:
        entry             a1, 32
        movi              a9, 255
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        l32i.n            a2, a12, 0
0:
        and               a14, a2, a9
        bne               a14, a10, 1f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 0b
        movi.n            a13, 1
1:
        memw
        beq               a13, a3, 2f
        movi.n            a3, 1
2:
        ssr               a8
        srl               a2, a2
        retw.n

asm_test::compare_exchange::u8::relaxed_relaxed:
        entry             a1, 32
        movi              a9, 255
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        l32i.n            a2, a12, 0
0:
        and               a14, a2, a9
        bne               a14, a10, 1f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 0b
        movi.n            a13, 1
1:
        beq               a13, a3, 2f
        movi.n            a3, 1
2:
        ssr               a8
        srl               a2, a2
        retw.n

asm_test::compare_exchange::u8::release_acquire:
        entry             a1, 32
        movi              a9, 255
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        memw
        l32i.n            a2, a12, 0
0:
        and               a14, a2, a9
        bne               a14, a10, 1f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 0b
        movi.n            a13, 1
1:
        memw
        beq               a13, a3, 2f
        movi.n            a3, 1
2:
        ssr               a8
        srl               a2, a2
        retw.n

asm_test::compare_exchange::u8::release_relaxed:
        entry             a1, 32
        movi              a9, 255
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        memw
        l32i.n            a2, a12, 0
0:
        and               a14, a2, a9
        bne               a14, a10, 1f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 0b
        movi.n            a13, 1
1:
        beq               a13, a3, 2f
        movi.n            a3, 1
2:
        ssr               a8
        srl               a2, a2
        retw.n

.literal.asm_test::compare_exchange::u16::acqrel_seqcst:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange::u16::acqrel_seqcst:
0:
        entry             a1, 32
        l32r              a9, 0b (91004136 <asm_test::compare_exchange::u16::acqrel_seqcst+0x91004136>)
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        memw
        l32i.n            a2, a12, 0
1:
        and               a14, a2, a9
        bne               a14, a10, 2f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 1b
        movi.n            a13, 1
2:
        memw
        beq               a13, a3, 3f
        movi.n            a3, 1
3:
        ssr               a8
        srl               a2, a2
        retw.n

.literal.asm_test::compare_exchange::u16::seqcst_seqcst:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange::u16::seqcst_seqcst:
0:
        entry             a1, 32
        l32r              a9, 0b (91004136 <asm_test::compare_exchange::u16::seqcst_seqcst+0x91004136>)
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        memw
        l32i.n            a2, a12, 0
1:
        and               a14, a2, a9
        bne               a14, a10, 2f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 1b
        movi.n            a13, 1
2:
        memw
        beq               a13, a3, 3f
        movi.n            a3, 1
3:
        ssr               a8
        srl               a2, a2
        retw.n

.literal.asm_test::compare_exchange::u16::acqrel_acquire:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange::u16::acqrel_acquire:
0:
        entry             a1, 32
        l32r              a9, 0b (91004136 <asm_test::compare_exchange::u16::acqrel_acquire+0x91004136>)
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        memw
        l32i.n            a2, a12, 0
1:
        and               a14, a2, a9
        bne               a14, a10, 2f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 1b
        movi.n            a13, 1
2:
        memw
        beq               a13, a3, 3f
        movi.n            a3, 1
3:
        ssr               a8
        srl               a2, a2
        retw.n

.literal.asm_test::compare_exchange::u16::acqrel_relaxed:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange::u16::acqrel_relaxed:
0:
        entry             a1, 32
        l32r              a9, 0b (91004136 <asm_test::compare_exchange::u16::acqrel_relaxed+0x91004136>)
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        memw
        l32i.n            a2, a12, 0
1:
        and               a14, a2, a9
        bne               a14, a10, 2f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 1b
        movi.n            a13, 1
2:
        memw
        beq               a13, a3, 3f
        movi.n            a3, 1
3:
        ssr               a8
        srl               a2, a2
        retw.n

.literal.asm_test::compare_exchange::u16::acquire_seqcst:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange::u16::acquire_seqcst:
0:
        entry             a1, 32
        l32r              a9, 0b (91004136 <asm_test::compare_exchange::u16::acquire_seqcst+0x91004136>)
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        memw
        l32i.n            a2, a12, 0
1:
        and               a14, a2, a9
        bne               a14, a10, 2f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 1b
        movi.n            a13, 1
2:
        memw
        beq               a13, a3, 3f
        movi.n            a3, 1
3:
        ssr               a8
        srl               a2, a2
        retw.n

.literal.asm_test::compare_exchange::u16::relaxed_seqcst:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange::u16::relaxed_seqcst:
0:
        entry             a1, 32
        l32r              a9, 0b (91004136 <asm_test::compare_exchange::u16::relaxed_seqcst+0x91004136>)
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        memw
        l32i.n            a2, a12, 0
1:
        and               a14, a2, a9
        bne               a14, a10, 2f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 1b
        movi.n            a13, 1
2:
        memw
        beq               a13, a3, 3f
        movi.n            a3, 1
3:
        ssr               a8
        srl               a2, a2
        retw.n

.literal.asm_test::compare_exchange::u16::release_seqcst:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange::u16::release_seqcst:
0:
        entry             a1, 32
        l32r              a9, 0b (91004136 <asm_test::compare_exchange::u16::release_seqcst+0x91004136>)
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        memw
        l32i.n            a2, a12, 0
1:
        and               a14, a2, a9
        bne               a14, a10, 2f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 1b
        movi.n            a13, 1
2:
        memw
        beq               a13, a3, 3f
        movi.n            a3, 1
3:
        ssr               a8
        srl               a2, a2
        retw.n

.literal.asm_test::compare_exchange::u16::seqcst_acquire:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange::u16::seqcst_acquire:
0:
        entry             a1, 32
        l32r              a9, 0b (91004136 <asm_test::compare_exchange::u16::seqcst_acquire+0x91004136>)
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        memw
        l32i.n            a2, a12, 0
1:
        and               a14, a2, a9
        bne               a14, a10, 2f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 1b
        movi.n            a13, 1
2:
        memw
        beq               a13, a3, 3f
        movi.n            a3, 1
3:
        ssr               a8
        srl               a2, a2
        retw.n

.literal.asm_test::compare_exchange::u16::seqcst_relaxed:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange::u16::seqcst_relaxed:
0:
        entry             a1, 32
        l32r              a9, 0b (91004136 <asm_test::compare_exchange::u16::seqcst_relaxed+0x91004136>)
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        memw
        l32i.n            a2, a12, 0
1:
        and               a14, a2, a9
        bne               a14, a10, 2f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 1b
        movi.n            a13, 1
2:
        memw
        beq               a13, a3, 3f
        movi.n            a3, 1
3:
        ssr               a8
        srl               a2, a2
        retw.n

.literal.asm_test::compare_exchange::u16::acquire_acquire:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange::u16::acquire_acquire:
0:
        entry             a1, 32
        l32r              a9, 0b (91004136 <asm_test::compare_exchange::u16::acquire_acquire+0x91004136>)
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        l32i.n            a2, a12, 0
1:
        and               a14, a2, a9
        bne               a14, a10, 2f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 1b
        movi.n            a13, 1
2:
        memw
        beq               a13, a3, 3f
        movi.n            a3, 1
3:
        ssr               a8
        srl               a2, a2
        retw.n

.literal.asm_test::compare_exchange::u16::acquire_relaxed:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange::u16::acquire_relaxed:
0:
        entry             a1, 32
        l32r              a9, 0b (91004136 <asm_test::compare_exchange::u16::acquire_relaxed+0x91004136>)
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        l32i.n            a2, a12, 0
1:
        and               a14, a2, a9
        bne               a14, a10, 2f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 1b
        movi.n            a13, 1
2:
        memw
        beq               a13, a3, 3f
        movi.n            a3, 1
3:
        ssr               a8
        srl               a2, a2
        retw.n

.literal.asm_test::compare_exchange::u16::relaxed_acquire:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange::u16::relaxed_acquire:
0:
        entry             a1, 32
        l32r              a9, 0b (91004136 <asm_test::compare_exchange::u16::relaxed_acquire+0x91004136>)
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        l32i.n            a2, a12, 0
1:
        and               a14, a2, a9
        bne               a14, a10, 2f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 1b
        movi.n            a13, 1
2:
        memw
        beq               a13, a3, 3f
        movi.n            a3, 1
3:
        ssr               a8
        srl               a2, a2
        retw.n

.literal.asm_test::compare_exchange::u16::relaxed_relaxed:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange::u16::relaxed_relaxed:
0:
        entry             a1, 32
        l32r              a9, 0b (91004136 <asm_test::compare_exchange::u16::relaxed_relaxed+0x91004136>)
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        l32i.n            a2, a12, 0
1:
        and               a14, a2, a9
        bne               a14, a10, 2f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 1b
        movi.n            a13, 1
2:
        beq               a13, a3, 3f
        movi.n            a3, 1
3:
        ssr               a8
        srl               a2, a2
        retw.n

.literal.asm_test::compare_exchange::u16::release_acquire:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange::u16::release_acquire:
0:
        entry             a1, 32
        l32r              a9, 0b (91004136 <asm_test::compare_exchange::u16::release_acquire+0x91004136>)
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        memw
        l32i.n            a2, a12, 0
1:
        and               a14, a2, a9
        bne               a14, a10, 2f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 1b
        movi.n            a13, 1
2:
        memw
        beq               a13, a3, 3f
        movi.n            a3, 1
3:
        ssr               a8
        srl               a2, a2
        retw.n

.literal.asm_test::compare_exchange::u16::release_relaxed:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange::u16::release_relaxed:
0:
        entry             a1, 32
        l32r              a9, 0b (91004136 <asm_test::compare_exchange::u16::release_relaxed+0x91004136>)
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        memw
        l32i.n            a2, a12, 0
1:
        and               a14, a2, a9
        bne               a14, a10, 2f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 1b
        movi.n            a13, 1
2:
        beq               a13, a3, 3f
        movi.n            a3, 1
3:
        ssr               a8
        srl               a2, a2
        retw.n

asm_test::compare_exchange::u32::acqrel_seqcst:
        entry             a1, 32
        mov.n             a8, a3
        movi.n            a3, 1
        mov.n             a9, a3
        memw
        wsr.scompare1     a8
        s32c1i            a4, a2, 0
        memw
        beq               a8, a4, 0f
        movi.n            a9, 0
0:
        movi.n            a8, 0
        bne               a9, a8, 1f
        mov.n             a3, a8
1:
        mov.n             a2, a4
        retw.n

asm_test::compare_exchange::u32::seqcst_seqcst:
        entry             a1, 32
        mov.n             a8, a3
        movi.n            a3, 1
        mov.n             a9, a3
        memw
        wsr.scompare1     a8
        s32c1i            a4, a2, 0
        memw
        beq               a8, a4, 0f
        movi.n            a9, 0
0:
        movi.n            a8, 0
        bne               a9, a8, 1f
        mov.n             a3, a8
1:
        mov.n             a2, a4
        retw.n

asm_test::compare_exchange::u32::acqrel_acquire:
        entry             a1, 32
        mov.n             a8, a3
        movi.n            a3, 1
        mov.n             a9, a3
        memw
        wsr.scompare1     a8
        s32c1i            a4, a2, 0
        memw
        beq               a8, a4, 0f
        movi.n            a9, 0
0:
        movi.n            a8, 0
        bne               a9, a8, 1f
        mov.n             a3, a8
1:
        mov.n             a2, a4
        retw.n

asm_test::compare_exchange::u32::acqrel_relaxed:
        entry             a1, 32
        mov.n             a8, a3
        movi.n            a3, 1
        mov.n             a9, a3
        memw
        wsr.scompare1     a8
        s32c1i            a4, a2, 0
        memw
        beq               a8, a4, 0f
        movi.n            a9, 0
0:
        movi.n            a8, 0
        bne               a9, a8, 1f
        mov.n             a3, a8
1:
        mov.n             a2, a4
        retw.n

asm_test::compare_exchange::u32::acquire_seqcst:
        entry             a1, 32
        mov.n             a8, a3
        movi.n            a3, 1
        mov.n             a9, a3
        memw
        wsr.scompare1     a8
        s32c1i            a4, a2, 0
        memw
        beq               a8, a4, 0f
        movi.n            a9, 0
0:
        movi.n            a8, 0
        bne               a9, a8, 1f
        mov.n             a3, a8
1:
        mov.n             a2, a4
        retw.n

asm_test::compare_exchange::u32::relaxed_seqcst:
        entry             a1, 32
        mov.n             a8, a3
        movi.n            a3, 1
        mov.n             a9, a3
        memw
        wsr.scompare1     a8
        s32c1i            a4, a2, 0
        memw
        beq               a8, a4, 0f
        movi.n            a9, 0
0:
        movi.n            a8, 0
        bne               a9, a8, 1f
        mov.n             a3, a8
1:
        mov.n             a2, a4
        retw.n

asm_test::compare_exchange::u32::release_seqcst:
        entry             a1, 32
        mov.n             a8, a3
        movi.n            a3, 1
        mov.n             a9, a3
        memw
        wsr.scompare1     a8
        s32c1i            a4, a2, 0
        memw
        beq               a8, a4, 0f
        movi.n            a9, 0
0:
        movi.n            a8, 0
        bne               a9, a8, 1f
        mov.n             a3, a8
1:
        mov.n             a2, a4
        retw.n

asm_test::compare_exchange::u32::seqcst_acquire:
        entry             a1, 32
        mov.n             a8, a3
        movi.n            a3, 1
        mov.n             a9, a3
        memw
        wsr.scompare1     a8
        s32c1i            a4, a2, 0
        memw
        beq               a8, a4, 0f
        movi.n            a9, 0
0:
        movi.n            a8, 0
        bne               a9, a8, 1f
        mov.n             a3, a8
1:
        mov.n             a2, a4
        retw.n

asm_test::compare_exchange::u32::seqcst_relaxed:
        entry             a1, 32
        mov.n             a8, a3
        movi.n            a3, 1
        mov.n             a9, a3
        memw
        wsr.scompare1     a8
        s32c1i            a4, a2, 0
        memw
        beq               a8, a4, 0f
        movi.n            a9, 0
0:
        movi.n            a8, 0
        bne               a9, a8, 1f
        mov.n             a3, a8
1:
        mov.n             a2, a4
        retw.n

asm_test::compare_exchange::u32::acquire_acquire:
        entry             a1, 32
        mov.n             a8, a3
        movi.n            a3, 1
        mov.n             a9, a3
        wsr.scompare1     a8
        s32c1i            a4, a2, 0
        memw
        beq               a8, a4, 0f
        movi.n            a9, 0
0:
        movi.n            a8, 0
        bne               a9, a8, 1f
        mov.n             a3, a8
1:
        mov.n             a2, a4
        retw.n

asm_test::compare_exchange::u32::acquire_relaxed:
        entry             a1, 32
        mov.n             a8, a3
        movi.n            a3, 1
        mov.n             a9, a3
        wsr.scompare1     a8
        s32c1i            a4, a2, 0
        memw
        beq               a8, a4, 0f
        movi.n            a9, 0
0:
        movi.n            a8, 0
        bne               a9, a8, 1f
        mov.n             a3, a8
1:
        mov.n             a2, a4
        retw.n

asm_test::compare_exchange::u32::relaxed_acquire:
        entry             a1, 32
        mov.n             a8, a3
        movi.n            a3, 1
        mov.n             a9, a3
        wsr.scompare1     a8
        s32c1i            a4, a2, 0
        memw
        beq               a8, a4, 0f
        movi.n            a9, 0
0:
        movi.n            a8, 0
        bne               a9, a8, 1f
        mov.n             a3, a8
1:
        mov.n             a2, a4
        retw.n

asm_test::compare_exchange::u32::relaxed_relaxed:
        entry             a1, 32
        mov.n             a8, a3
        movi.n            a3, 1
        mov.n             a9, a3
        wsr.scompare1     a8
        s32c1i            a4, a2, 0
        beq               a8, a4, 0f
        movi.n            a9, 0
0:
        movi.n            a8, 0
        bne               a9, a8, 1f
        mov.n             a3, a8
1:
        mov.n             a2, a4
        retw.n

asm_test::compare_exchange::u32::release_acquire:
        entry             a1, 32
        mov.n             a8, a3
        movi.n            a3, 1
        mov.n             a9, a3
        memw
        wsr.scompare1     a8
        s32c1i            a4, a2, 0
        memw
        beq               a8, a4, 0f
        movi.n            a9, 0
0:
        movi.n            a8, 0
        bne               a9, a8, 1f
        mov.n             a3, a8
1:
        mov.n             a2, a4
        retw.n

asm_test::compare_exchange::u32::release_relaxed:
        entry             a1, 32
        mov.n             a8, a3
        movi.n            a3, 1
        mov.n             a9, a3
        memw
        wsr.scompare1     a8
        s32c1i            a4, a2, 0
        beq               a8, a4, 0f
        movi.n            a9, 0
0:
        movi.n            a8, 0
        bne               a9, a8, 1f
        mov.n             a3, a8
1:
        mov.n             a2, a4
        retw.n

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        entry             a1, 32
        movi              a9, 255
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        memw
        l32i.n            a2, a12, 0
0:
        and               a14, a2, a9
        bne               a14, a10, 1f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 0b
        movi.n            a13, 1
1:
        memw
        beq               a13, a3, 2f
        movi.n            a3, 1
2:
        ssr               a8
        srl               a2, a2
        retw.n

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        entry             a1, 32
        movi              a9, 255
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        memw
        l32i.n            a2, a12, 0
0:
        and               a14, a2, a9
        bne               a14, a10, 1f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 0b
        movi.n            a13, 1
1:
        memw
        beq               a13, a3, 2f
        movi.n            a3, 1
2:
        ssr               a8
        srl               a2, a2
        retw.n

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        entry             a1, 32
        movi              a9, 255
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        memw
        l32i.n            a2, a12, 0
0:
        and               a14, a2, a9
        bne               a14, a10, 1f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 0b
        movi.n            a13, 1
1:
        memw
        beq               a13, a3, 2f
        movi.n            a3, 1
2:
        ssr               a8
        srl               a2, a2
        retw.n

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        entry             a1, 32
        movi              a9, 255
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        memw
        l32i.n            a2, a12, 0
0:
        and               a14, a2, a9
        bne               a14, a10, 1f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 0b
        movi.n            a13, 1
1:
        memw
        beq               a13, a3, 2f
        movi.n            a3, 1
2:
        ssr               a8
        srl               a2, a2
        retw.n

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        entry             a1, 32
        movi              a9, 255
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        memw
        l32i.n            a2, a12, 0
0:
        and               a14, a2, a9
        bne               a14, a10, 1f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 0b
        movi.n            a13, 1
1:
        memw
        beq               a13, a3, 2f
        movi.n            a3, 1
2:
        ssr               a8
        srl               a2, a2
        retw.n

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        entry             a1, 32
        movi              a9, 255
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        memw
        l32i.n            a2, a12, 0
0:
        and               a14, a2, a9
        bne               a14, a10, 1f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 0b
        movi.n            a13, 1
1:
        memw
        beq               a13, a3, 2f
        movi.n            a3, 1
2:
        ssr               a8
        srl               a2, a2
        retw.n

asm_test::compare_exchange_weak::u8::release_seqcst:
        entry             a1, 32
        movi              a9, 255
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        memw
        l32i.n            a2, a12, 0
0:
        and               a14, a2, a9
        bne               a14, a10, 1f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 0b
        movi.n            a13, 1
1:
        memw
        beq               a13, a3, 2f
        movi.n            a3, 1
2:
        ssr               a8
        srl               a2, a2
        retw.n

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        entry             a1, 32
        movi              a9, 255
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        memw
        l32i.n            a2, a12, 0
0:
        and               a14, a2, a9
        bne               a14, a10, 1f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 0b
        movi.n            a13, 1
1:
        memw
        beq               a13, a3, 2f
        movi.n            a3, 1
2:
        ssr               a8
        srl               a2, a2
        retw.n

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        entry             a1, 32
        movi              a9, 255
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        memw
        l32i.n            a2, a12, 0
0:
        and               a14, a2, a9
        bne               a14, a10, 1f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 0b
        movi.n            a13, 1
1:
        memw
        beq               a13, a3, 2f
        movi.n            a3, 1
2:
        ssr               a8
        srl               a2, a2
        retw.n

asm_test::compare_exchange_weak::u8::acquire_acquire:
        entry             a1, 32
        movi              a9, 255
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        l32i.n            a2, a12, 0
0:
        and               a14, a2, a9
        bne               a14, a10, 1f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 0b
        movi.n            a13, 1
1:
        memw
        beq               a13, a3, 2f
        movi.n            a3, 1
2:
        ssr               a8
        srl               a2, a2
        retw.n

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        entry             a1, 32
        movi              a9, 255
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        l32i.n            a2, a12, 0
0:
        and               a14, a2, a9
        bne               a14, a10, 1f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 0b
        movi.n            a13, 1
1:
        memw
        beq               a13, a3, 2f
        movi.n            a3, 1
2:
        ssr               a8
        srl               a2, a2
        retw.n

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        entry             a1, 32
        movi              a9, 255
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        l32i.n            a2, a12, 0
0:
        and               a14, a2, a9
        bne               a14, a10, 1f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 0b
        movi.n            a13, 1
1:
        memw
        beq               a13, a3, 2f
        movi.n            a3, 1
2:
        ssr               a8
        srl               a2, a2
        retw.n

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        entry             a1, 32
        movi              a9, 255
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        l32i.n            a2, a12, 0
0:
        and               a14, a2, a9
        bne               a14, a10, 1f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 0b
        movi.n            a13, 1
1:
        beq               a13, a3, 2f
        movi.n            a3, 1
2:
        ssr               a8
        srl               a2, a2
        retw.n

asm_test::compare_exchange_weak::u8::release_acquire:
        entry             a1, 32
        movi              a9, 255
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        memw
        l32i.n            a2, a12, 0
0:
        and               a14, a2, a9
        bne               a14, a10, 1f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 0b
        movi.n            a13, 1
1:
        memw
        beq               a13, a3, 2f
        movi.n            a3, 1
2:
        ssr               a8
        srl               a2, a2
        retw.n

asm_test::compare_exchange_weak::u8::release_relaxed:
        entry             a1, 32
        movi              a9, 255
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        memw
        l32i.n            a2, a12, 0
0:
        and               a14, a2, a9
        bne               a14, a10, 1f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 0b
        movi.n            a13, 1
1:
        beq               a13, a3, 2f
        movi.n            a3, 1
2:
        ssr               a8
        srl               a2, a2
        retw.n

.literal.asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
0:
        entry             a1, 32
        l32r              a9, 0b (91004136 <asm_test::compare_exchange_weak::u16::acqrel_seqcst+0x91004136>)
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        memw
        l32i.n            a2, a12, 0
1:
        and               a14, a2, a9
        bne               a14, a10, 2f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 1b
        movi.n            a13, 1
2:
        memw
        beq               a13, a3, 3f
        movi.n            a3, 1
3:
        ssr               a8
        srl               a2, a2
        retw.n

.literal.asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
0:
        entry             a1, 32
        l32r              a9, 0b (91004136 <asm_test::compare_exchange_weak::u16::seqcst_seqcst+0x91004136>)
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        memw
        l32i.n            a2, a12, 0
1:
        and               a14, a2, a9
        bne               a14, a10, 2f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 1b
        movi.n            a13, 1
2:
        memw
        beq               a13, a3, 3f
        movi.n            a3, 1
3:
        ssr               a8
        srl               a2, a2
        retw.n

.literal.asm_test::compare_exchange_weak::u16::acqrel_acquire:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange_weak::u16::acqrel_acquire:
0:
        entry             a1, 32
        l32r              a9, 0b (91004136 <asm_test::compare_exchange_weak::u16::acqrel_acquire+0x91004136>)
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        memw
        l32i.n            a2, a12, 0
1:
        and               a14, a2, a9
        bne               a14, a10, 2f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 1b
        movi.n            a13, 1
2:
        memw
        beq               a13, a3, 3f
        movi.n            a3, 1
3:
        ssr               a8
        srl               a2, a2
        retw.n

.literal.asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
0:
        entry             a1, 32
        l32r              a9, 0b (91004136 <asm_test::compare_exchange_weak::u16::acqrel_relaxed+0x91004136>)
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        memw
        l32i.n            a2, a12, 0
1:
        and               a14, a2, a9
        bne               a14, a10, 2f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 1b
        movi.n            a13, 1
2:
        memw
        beq               a13, a3, 3f
        movi.n            a3, 1
3:
        ssr               a8
        srl               a2, a2
        retw.n

.literal.asm_test::compare_exchange_weak::u16::acquire_seqcst:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange_weak::u16::acquire_seqcst:
0:
        entry             a1, 32
        l32r              a9, 0b (91004136 <asm_test::compare_exchange_weak::u16::acquire_seqcst+0x91004136>)
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        memw
        l32i.n            a2, a12, 0
1:
        and               a14, a2, a9
        bne               a14, a10, 2f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 1b
        movi.n            a13, 1
2:
        memw
        beq               a13, a3, 3f
        movi.n            a3, 1
3:
        ssr               a8
        srl               a2, a2
        retw.n

.literal.asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
0:
        entry             a1, 32
        l32r              a9, 0b (91004136 <asm_test::compare_exchange_weak::u16::relaxed_seqcst+0x91004136>)
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        memw
        l32i.n            a2, a12, 0
1:
        and               a14, a2, a9
        bne               a14, a10, 2f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 1b
        movi.n            a13, 1
2:
        memw
        beq               a13, a3, 3f
        movi.n            a3, 1
3:
        ssr               a8
        srl               a2, a2
        retw.n

.literal.asm_test::compare_exchange_weak::u16::release_seqcst:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange_weak::u16::release_seqcst:
0:
        entry             a1, 32
        l32r              a9, 0b (91004136 <asm_test::compare_exchange_weak::u16::release_seqcst+0x91004136>)
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        memw
        l32i.n            a2, a12, 0
1:
        and               a14, a2, a9
        bne               a14, a10, 2f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 1b
        movi.n            a13, 1
2:
        memw
        beq               a13, a3, 3f
        movi.n            a3, 1
3:
        ssr               a8
        srl               a2, a2
        retw.n

.literal.asm_test::compare_exchange_weak::u16::seqcst_acquire:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange_weak::u16::seqcst_acquire:
0:
        entry             a1, 32
        l32r              a9, 0b (91004136 <asm_test::compare_exchange_weak::u16::seqcst_acquire+0x91004136>)
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        memw
        l32i.n            a2, a12, 0
1:
        and               a14, a2, a9
        bne               a14, a10, 2f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 1b
        movi.n            a13, 1
2:
        memw
        beq               a13, a3, 3f
        movi.n            a3, 1
3:
        ssr               a8
        srl               a2, a2
        retw.n

.literal.asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
0:
        entry             a1, 32
        l32r              a9, 0b (91004136 <asm_test::compare_exchange_weak::u16::seqcst_relaxed+0x91004136>)
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        memw
        l32i.n            a2, a12, 0
1:
        and               a14, a2, a9
        bne               a14, a10, 2f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 1b
        movi.n            a13, 1
2:
        memw
        beq               a13, a3, 3f
        movi.n            a3, 1
3:
        ssr               a8
        srl               a2, a2
        retw.n

.literal.asm_test::compare_exchange_weak::u16::acquire_acquire:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange_weak::u16::acquire_acquire:
0:
        entry             a1, 32
        l32r              a9, 0b (91004136 <asm_test::compare_exchange_weak::u16::acquire_acquire+0x91004136>)
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        l32i.n            a2, a12, 0
1:
        and               a14, a2, a9
        bne               a14, a10, 2f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 1b
        movi.n            a13, 1
2:
        memw
        beq               a13, a3, 3f
        movi.n            a3, 1
3:
        ssr               a8
        srl               a2, a2
        retw.n

.literal.asm_test::compare_exchange_weak::u16::acquire_relaxed:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange_weak::u16::acquire_relaxed:
0:
        entry             a1, 32
        l32r              a9, 0b (91004136 <asm_test::compare_exchange_weak::u16::acquire_relaxed+0x91004136>)
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        l32i.n            a2, a12, 0
1:
        and               a14, a2, a9
        bne               a14, a10, 2f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 1b
        movi.n            a13, 1
2:
        memw
        beq               a13, a3, 3f
        movi.n            a3, 1
3:
        ssr               a8
        srl               a2, a2
        retw.n

.literal.asm_test::compare_exchange_weak::u16::relaxed_acquire:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange_weak::u16::relaxed_acquire:
0:
        entry             a1, 32
        l32r              a9, 0b (91004136 <asm_test::compare_exchange_weak::u16::relaxed_acquire+0x91004136>)
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        l32i.n            a2, a12, 0
1:
        and               a14, a2, a9
        bne               a14, a10, 2f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 1b
        movi.n            a13, 1
2:
        memw
        beq               a13, a3, 3f
        movi.n            a3, 1
3:
        ssr               a8
        srl               a2, a2
        retw.n

.literal.asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
0:
        entry             a1, 32
        l32r              a9, 0b (91004136 <asm_test::compare_exchange_weak::u16::relaxed_relaxed+0x91004136>)
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        l32i.n            a2, a12, 0
1:
        and               a14, a2, a9
        bne               a14, a10, 2f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 1b
        movi.n            a13, 1
2:
        beq               a13, a3, 3f
        movi.n            a3, 1
3:
        ssr               a8
        srl               a2, a2
        retw.n

.literal.asm_test::compare_exchange_weak::u16::release_acquire:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange_weak::u16::release_acquire:
0:
        entry             a1, 32
        l32r              a9, 0b (91004136 <asm_test::compare_exchange_weak::u16::release_acquire+0x91004136>)
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        memw
        l32i.n            a2, a12, 0
1:
        and               a14, a2, a9
        bne               a14, a10, 2f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 1b
        movi.n            a13, 1
2:
        memw
        beq               a13, a3, 3f
        movi.n            a3, 1
3:
        ssr               a8
        srl               a2, a2
        retw.n

.literal.asm_test::compare_exchange_weak::u16::release_relaxed:
        .byte             0xff
        .byte             0xff

asm_test::compare_exchange_weak::u16::release_relaxed:
0:
        entry             a1, 32
        l32r              a9, 0b (91004136 <asm_test::compare_exchange_weak::u16::release_relaxed+0x91004136>)
        and               a10, a3, a9
        and               a11, a4, a9
        slli              a8, a2, 3
        ssl               a8
        sll               a9, a9
        sll               a10, a10
        sll               a11, a11
        movi.n            a12, -4
        and               a12, a2, a12
        movi.n            a3, 0
        mov.n             a13, a3
        memw
        l32i.n            a2, a12, 0
1:
        and               a14, a2, a9
        bne               a14, a10, 2f
        mov.n             a14, a2
        wsr.scompare1     a14
        xor               a2, a14, a11
        and               a2, a2, a9
        xor               a2, a2, a14
        s32c1i            a2, a12, 0
        bne               a14, a2, 1b
        movi.n            a13, 1
2:
        beq               a13, a3, 3f
        movi.n            a3, 1
3:
        ssr               a8
        srl               a2, a2
        retw.n

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        entry             a1, 32
        mov.n             a8, a3
        movi.n            a3, 1
        mov.n             a9, a3
        memw
        wsr.scompare1     a8
        s32c1i            a4, a2, 0
        memw
        beq               a8, a4, 0f
        movi.n            a9, 0
0:
        movi.n            a8, 0
        bne               a9, a8, 1f
        mov.n             a3, a8
1:
        mov.n             a2, a4
        retw.n

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        entry             a1, 32
        mov.n             a8, a3
        movi.n            a3, 1
        mov.n             a9, a3
        memw
        wsr.scompare1     a8
        s32c1i            a4, a2, 0
        memw
        beq               a8, a4, 0f
        movi.n            a9, 0
0:
        movi.n            a8, 0
        bne               a9, a8, 1f
        mov.n             a3, a8
1:
        mov.n             a2, a4
        retw.n

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        entry             a1, 32
        mov.n             a8, a3
        movi.n            a3, 1
        mov.n             a9, a3
        memw
        wsr.scompare1     a8
        s32c1i            a4, a2, 0
        memw
        beq               a8, a4, 0f
        movi.n            a9, 0
0:
        movi.n            a8, 0
        bne               a9, a8, 1f
        mov.n             a3, a8
1:
        mov.n             a2, a4
        retw.n

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        entry             a1, 32
        mov.n             a8, a3
        movi.n            a3, 1
        mov.n             a9, a3
        memw
        wsr.scompare1     a8
        s32c1i            a4, a2, 0
        memw
        beq               a8, a4, 0f
        movi.n            a9, 0
0:
        movi.n            a8, 0
        bne               a9, a8, 1f
        mov.n             a3, a8
1:
        mov.n             a2, a4
        retw.n

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        entry             a1, 32
        mov.n             a8, a3
        movi.n            a3, 1
        mov.n             a9, a3
        memw
        wsr.scompare1     a8
        s32c1i            a4, a2, 0
        memw
        beq               a8, a4, 0f
        movi.n            a9, 0
0:
        movi.n            a8, 0
        bne               a9, a8, 1f
        mov.n             a3, a8
1:
        mov.n             a2, a4
        retw.n

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        entry             a1, 32
        mov.n             a8, a3
        movi.n            a3, 1
        mov.n             a9, a3
        memw
        wsr.scompare1     a8
        s32c1i            a4, a2, 0
        memw
        beq               a8, a4, 0f
        movi.n            a9, 0
0:
        movi.n            a8, 0
        bne               a9, a8, 1f
        mov.n             a3, a8
1:
        mov.n             a2, a4
        retw.n

asm_test::compare_exchange_weak::u32::release_seqcst:
        entry             a1, 32
        mov.n             a8, a3
        movi.n            a3, 1
        mov.n             a9, a3
        memw
        wsr.scompare1     a8
        s32c1i            a4, a2, 0
        memw
        beq               a8, a4, 0f
        movi.n            a9, 0
0:
        movi.n            a8, 0
        bne               a9, a8, 1f
        mov.n             a3, a8
1:
        mov.n             a2, a4
        retw.n

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        entry             a1, 32
        mov.n             a8, a3
        movi.n            a3, 1
        mov.n             a9, a3
        memw
        wsr.scompare1     a8
        s32c1i            a4, a2, 0
        memw
        beq               a8, a4, 0f
        movi.n            a9, 0
0:
        movi.n            a8, 0
        bne               a9, a8, 1f
        mov.n             a3, a8
1:
        mov.n             a2, a4
        retw.n

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        entry             a1, 32
        mov.n             a8, a3
        movi.n            a3, 1
        mov.n             a9, a3
        memw
        wsr.scompare1     a8
        s32c1i            a4, a2, 0
        memw
        beq               a8, a4, 0f
        movi.n            a9, 0
0:
        movi.n            a8, 0
        bne               a9, a8, 1f
        mov.n             a3, a8
1:
        mov.n             a2, a4
        retw.n

asm_test::compare_exchange_weak::u32::acquire_acquire:
        entry             a1, 32
        mov.n             a8, a3
        movi.n            a3, 1
        mov.n             a9, a3
        wsr.scompare1     a8
        s32c1i            a4, a2, 0
        memw
        beq               a8, a4, 0f
        movi.n            a9, 0
0:
        movi.n            a8, 0
        bne               a9, a8, 1f
        mov.n             a3, a8
1:
        mov.n             a2, a4
        retw.n

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        entry             a1, 32
        mov.n             a8, a3
        movi.n            a3, 1
        mov.n             a9, a3
        wsr.scompare1     a8
        s32c1i            a4, a2, 0
        memw
        beq               a8, a4, 0f
        movi.n            a9, 0
0:
        movi.n            a8, 0
        bne               a9, a8, 1f
        mov.n             a3, a8
1:
        mov.n             a2, a4
        retw.n

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        entry             a1, 32
        mov.n             a8, a3
        movi.n            a3, 1
        mov.n             a9, a3
        wsr.scompare1     a8
        s32c1i            a4, a2, 0
        memw
        beq               a8, a4, 0f
        movi.n            a9, 0
0:
        movi.n            a8, 0
        bne               a9, a8, 1f
        mov.n             a3, a8
1:
        mov.n             a2, a4
        retw.n

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        entry             a1, 32
        mov.n             a8, a3
        movi.n            a3, 1
        mov.n             a9, a3
        wsr.scompare1     a8
        s32c1i            a4, a2, 0
        beq               a8, a4, 0f
        movi.n            a9, 0
0:
        movi.n            a8, 0
        bne               a9, a8, 1f
        mov.n             a3, a8
1:
        mov.n             a2, a4
        retw.n

asm_test::compare_exchange_weak::u32::release_acquire:
        entry             a1, 32
        mov.n             a8, a3
        movi.n            a3, 1
        mov.n             a9, a3
        memw
        wsr.scompare1     a8
        s32c1i            a4, a2, 0
        memw
        beq               a8, a4, 0f
        movi.n            a9, 0
0:
        movi.n            a8, 0
        bne               a9, a8, 1f
        mov.n             a3, a8
1:
        mov.n             a2, a4
        retw.n

asm_test::compare_exchange_weak::u32::release_relaxed:
        entry             a1, 32
        mov.n             a8, a3
        movi.n            a3, 1
        mov.n             a9, a3
        memw
        wsr.scompare1     a8
        s32c1i            a4, a2, 0
        beq               a8, a4, 0f
        movi.n            a9, 0
0:
        movi.n            a8, 0
        bne               a9, a8, 1f
        mov.n             a3, a8
1:
        mov.n             a2, a4
        retw.n

asm_test::load::u8::seqcst:
        entry             a1, 32
        l8ui              a2, a2, 0
        memw
        retw.n

asm_test::load::u8::acquire:
        entry             a1, 32
        l8ui              a2, a2, 0
        memw
        retw.n

asm_test::load::u8::relaxed:
        entry             a1, 32
        l8ui              a2, a2, 0
        retw.n

asm_test::load::u16::seqcst:
        entry             a1, 32
        l16ui             a2, a2, 0
        memw
        retw.n

asm_test::load::u16::acquire:
        entry             a1, 32
        l16ui             a2, a2, 0
        memw
        retw.n

asm_test::load::u16::relaxed:
        entry             a1, 32
        l16ui             a2, a2, 0
        retw.n

asm_test::load::u32::seqcst:
        entry             a1, 32
        l32i.n            a2, a2, 0
        memw
        retw.n

asm_test::load::u32::acquire:
        entry             a1, 32
        l32i.n            a2, a2, 0
        memw
        retw.n

asm_test::load::u32::relaxed:
        entry             a1, 32
        l32i.n            a2, a2, 0
        retw.n

asm_test::swap::u8::acqrel:
        entry             a1, 32
        movi              a8, 255
        and               a9, a3, a8
        slli              a10, a2, 3
        ssl               a10
        sll               a8, a8
        sll               a9, a9
        movi.n            a11, -4
        and               a11, a2, a11
        memw
        l32i.n            a2, a11, 0
0:
        mov.n             a12, a2
        wsr.scompare1     a12
        xor               a2, a12, a9
        and               a2, a2, a8
        xor               a2, a2, a12
        s32c1i            a2, a11, 0
        bne               a12, a2, 0b
        memw
        ssr               a10
        srl               a2, a2
        retw.n

asm_test::swap::u8::seqcst:
        entry             a1, 32
        movi              a8, 255
        and               a9, a3, a8
        slli              a10, a2, 3
        ssl               a10
        sll               a8, a8
        sll               a9, a9
        movi.n            a11, -4
        and               a11, a2, a11
        memw
        l32i.n            a2, a11, 0
0:
        mov.n             a12, a2
        wsr.scompare1     a12
        xor               a2, a12, a9
        and               a2, a2, a8
        xor               a2, a2, a12
        s32c1i            a2, a11, 0
        bne               a12, a2, 0b
        memw
        ssr               a10
        srl               a2, a2
        retw.n

asm_test::swap::u8::acquire:
        entry             a1, 32
        movi              a8, 255
        and               a9, a3, a8
        slli              a10, a2, 3
        ssl               a10
        sll               a8, a8
        sll               a9, a9
        movi.n            a11, -4
        and               a11, a2, a11
        l32i.n            a2, a11, 0
0:
        mov.n             a12, a2
        wsr.scompare1     a12
        xor               a2, a12, a9
        and               a2, a2, a8
        xor               a2, a2, a12
        s32c1i            a2, a11, 0
        bne               a12, a2, 0b
        memw
        ssr               a10
        srl               a2, a2
        retw.n

asm_test::swap::u8::relaxed:
        entry             a1, 32
        movi              a8, 255
        and               a9, a3, a8
        slli              a10, a2, 3
        ssl               a10
        sll               a8, a8
        sll               a9, a9
        movi.n            a11, -4
        and               a11, a2, a11
        l32i.n            a2, a11, 0
0:
        mov.n             a12, a2
        wsr.scompare1     a12
        xor               a2, a12, a9
        and               a2, a2, a8
        xor               a2, a2, a12
        s32c1i            a2, a11, 0
        bne               a12, a2, 0b
        ssr               a10
        srl               a2, a2
        retw.n

asm_test::swap::u8::release:
        entry             a1, 32
        movi              a8, 255
        and               a9, a3, a8
        slli              a10, a2, 3
        ssl               a10
        sll               a8, a8
        sll               a9, a9
        movi.n            a11, -4
        and               a11, a2, a11
        memw
        l32i.n            a2, a11, 0
0:
        mov.n             a12, a2
        wsr.scompare1     a12
        xor               a2, a12, a9
        and               a2, a2, a8
        xor               a2, a2, a12
        s32c1i            a2, a11, 0
        bne               a12, a2, 0b
        ssr               a10
        srl               a2, a2
        retw.n

.literal.asm_test::swap::u16::acqrel:
        .byte             0xff
        .byte             0xff

asm_test::swap::u16::acqrel:
0:
        entry             a1, 32
        l32r              a8, 0b (81004136 <asm_test::swap::u16::acqrel+0x81004136>)
        and               a9, a3, a8
        slli              a10, a2, 3
        ssl               a10
        sll               a8, a8
        sll               a9, a9
        movi.n            a11, -4
        and               a11, a2, a11
        memw
        l32i.n            a2, a11, 0
1:
        mov.n             a12, a2
        wsr.scompare1     a12
        xor               a2, a12, a9
        and               a2, a2, a8
        xor               a2, a2, a12
        s32c1i            a2, a11, 0
        bne               a12, a2, 1b
        memw
        ssr               a10
        srl               a2, a2
        retw.n

.literal.asm_test::swap::u16::seqcst:
        .byte             0xff
        .byte             0xff

asm_test::swap::u16::seqcst:
0:
        entry             a1, 32
        l32r              a8, 0b (81004136 <asm_test::swap::u16::seqcst+0x81004136>)
        and               a9, a3, a8
        slli              a10, a2, 3
        ssl               a10
        sll               a8, a8
        sll               a9, a9
        movi.n            a11, -4
        and               a11, a2, a11
        memw
        l32i.n            a2, a11, 0
1:
        mov.n             a12, a2
        wsr.scompare1     a12
        xor               a2, a12, a9
        and               a2, a2, a8
        xor               a2, a2, a12
        s32c1i            a2, a11, 0
        bne               a12, a2, 1b
        memw
        ssr               a10
        srl               a2, a2
        retw.n

.literal.asm_test::swap::u16::acquire:
        .byte             0xff
        .byte             0xff

asm_test::swap::u16::acquire:
0:
        entry             a1, 32
        l32r              a8, 0b (81004136 <asm_test::swap::u16::acquire+0x81004136>)
        and               a9, a3, a8
        slli              a10, a2, 3
        ssl               a10
        sll               a8, a8
        sll               a9, a9
        movi.n            a11, -4
        and               a11, a2, a11
        l32i.n            a2, a11, 0
1:
        mov.n             a12, a2
        wsr.scompare1     a12
        xor               a2, a12, a9
        and               a2, a2, a8
        xor               a2, a2, a12
        s32c1i            a2, a11, 0
        bne               a12, a2, 1b
        memw
        ssr               a10
        srl               a2, a2
        retw.n

.literal.asm_test::swap::u16::relaxed:
        .byte             0xff
        .byte             0xff

asm_test::swap::u16::relaxed:
0:
        entry             a1, 32
        l32r              a8, 0b (81004136 <asm_test::swap::u16::relaxed+0x81004136>)
        and               a9, a3, a8
        slli              a10, a2, 3
        ssl               a10
        sll               a8, a8
        sll               a9, a9
        movi.n            a11, -4
        and               a11, a2, a11
        l32i.n            a2, a11, 0
1:
        mov.n             a12, a2
        wsr.scompare1     a12
        xor               a2, a12, a9
        and               a2, a2, a8
        xor               a2, a2, a12
        s32c1i            a2, a11, 0
        bne               a12, a2, 1b
        ssr               a10
        srl               a2, a2
        retw.n

.literal.asm_test::swap::u16::release:
        .byte             0xff
        .byte             0xff

asm_test::swap::u16::release:
0:
        entry             a1, 32
        l32r              a8, 0b (81004136 <asm_test::swap::u16::release+0x81004136>)
        and               a9, a3, a8
        slli              a10, a2, 3
        ssl               a10
        sll               a8, a8
        sll               a9, a9
        movi.n            a11, -4
        and               a11, a2, a11
        memw
        l32i.n            a2, a11, 0
1:
        mov.n             a12, a2
        wsr.scompare1     a12
        xor               a2, a12, a9
        and               a2, a2, a8
        xor               a2, a2, a12
        s32c1i            a2, a11, 0
        bne               a12, a2, 1b
        ssr               a10
        srl               a2, a2
        retw.n

asm_test::swap::u32::acqrel:
        entry             a1, 32
        memw
        l32i.n            a8, a2, 0
0:
        mov.n             a9, a8
        wsr.scompare1     a9
        mov.n             a8, a3
        s32c1i            a8, a2, 0
        bne               a9, a8, 0b
        memw
        mov.n             a2, a8
        retw.n

asm_test::swap::u32::seqcst:
        entry             a1, 32
        memw
        l32i.n            a8, a2, 0
0:
        mov.n             a9, a8
        wsr.scompare1     a9
        mov.n             a8, a3
        s32c1i            a8, a2, 0
        bne               a9, a8, 0b
        memw
        mov.n             a2, a8
        retw.n

asm_test::swap::u32::acquire:
        entry             a1, 32
        l32i.n            a8, a2, 0
0:
        mov.n             a9, a8
        wsr.scompare1     a9
        mov.n             a8, a3
        s32c1i            a8, a2, 0
        bne               a9, a8, 0b
        memw
        mov.n             a2, a8
        retw.n

asm_test::swap::u32::relaxed:
        entry             a1, 32
        l32i.n            a8, a2, 0
0:
        mov.n             a9, a8
        wsr.scompare1     a9
        mov.n             a8, a3
        s32c1i            a8, a2, 0
        bne               a9, a8, 0b
        mov.n             a2, a8
        retw.n

asm_test::swap::u32::release:
        entry             a1, 32
        memw
        l32i.n            a8, a2, 0
0:
        mov.n             a9, a8
        wsr.scompare1     a9
        mov.n             a8, a3
        s32c1i            a8, a2, 0
        bne               a9, a8, 0b
        mov.n             a2, a8
        retw.n

asm_test::store::u8::seqcst:
        entry             a1, 32
        memw
        s8i               a3, a2, 0
        memw
        retw.n

asm_test::store::u8::relaxed:
        entry             a1, 32
        s8i               a3, a2, 0
        retw.n

asm_test::store::u8::release:
        entry             a1, 32
        memw
        s8i               a3, a2, 0
        retw.n

asm_test::store::u16::seqcst:
        entry             a1, 32
        memw
        s16i              a3, a2, 0
        memw
        retw.n

asm_test::store::u16::relaxed:
        entry             a1, 32
        s16i              a3, a2, 0
        retw.n

asm_test::store::u16::release:
        entry             a1, 32
        memw
        s16i              a3, a2, 0
        retw.n

asm_test::store::u32::seqcst:
        entry             a1, 32
        memw
        s32i.n            a3, a2, 0
        memw
        retw.n

asm_test::store::u32::relaxed:
        entry             a1, 32
        s32i.n            a3, a2, 0
        retw.n

asm_test::store::u32::release:
        entry             a1, 32
        memw
        s32i.n            a3, a2, 0
        retw.n
