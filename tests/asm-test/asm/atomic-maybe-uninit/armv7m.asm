asm_test::compare_exchange::u8::acqrel_seqcst:
        uxtb.w            r12, r1
        movs              r1, #0x1
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               1f
        dmb               sy
0:
        strexb            r1, r2, [r0]
        cmp               r1, #0x0
        beq               1f
        ldrexb            r3, [r0]
        cmp               r3, r12
        beq               0b
1:
        dmb               sy
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange::u8::seqcst_seqcst:
        uxtb.w            r12, r1
        movs              r1, #0x1
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               1f
        dmb               sy
0:
        strexb            r1, r2, [r0]
        cmp               r1, #0x0
        beq               1f
        ldrexb            r3, [r0]
        cmp               r3, r12
        beq               0b
1:
        dmb               sy
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange::u8::acqrel_acquire:
        uxtb.w            r12, r1
        movs              r1, #0x1
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               1f
        dmb               sy
0:
        strexb            r1, r2, [r0]
        cmp               r1, #0x0
        beq               1f
        ldrexb            r3, [r0]
        cmp               r3, r12
        beq               0b
1:
        dmb               sy
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange::u8::acqrel_relaxed:
        uxtb.w            r12, r1
        movs              r1, #0x1
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               2f
        dmb               sy
0:
        strexb            r1, r2, [r0]
        cmp               r1, #0x0
        beq               1f
        ldrexb            r3, [r0]
        cmp               r3, r12
        beq               0b
        b                 2f
1:
        dmb               sy
2:
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange::u8::acquire_seqcst:
        uxtb.w            r12, r1
        movs              r1, #0x1
0:
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               1f
        strexb            r1, r2, [r0]
        cmp               r1, #0x0
        bne               0b
1:
        dmb               sy
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange::u8::relaxed_seqcst:
        uxtb.w            r12, r1
        movs              r1, #0x1
0:
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               1f
        strexb            r1, r2, [r0]
        cmp               r1, #0x0
        bne               0b
        b                 2f
1:
        dmb               sy
2:
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange::u8::release_seqcst:
        uxtb.w            r12, r1
        movs              r1, #0x1
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               1f
        dmb               sy
0:
        strexb            r1, r2, [r0]
        cmp               r1, #0x0
        beq               2f
        ldrexb            r3, [r0]
        cmp               r3, r12
        beq               0b
1:
        dmb               sy
2:
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange::u8::seqcst_acquire:
        uxtb.w            r12, r1
        movs              r1, #0x1
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               1f
        dmb               sy
0:
        strexb            r1, r2, [r0]
        cmp               r1, #0x0
        beq               1f
        ldrexb            r3, [r0]
        cmp               r3, r12
        beq               0b
1:
        dmb               sy
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange::u8::seqcst_relaxed:
        uxtb.w            r12, r1
        movs              r1, #0x1
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               2f
        dmb               sy
0:
        strexb            r1, r2, [r0]
        cmp               r1, #0x0
        beq               1f
        ldrexb            r3, [r0]
        cmp               r3, r12
        beq               0b
        b                 2f
1:
        dmb               sy
2:
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange::u8::acquire_acquire:
        uxtb.w            r12, r1
        movs              r1, #0x1
0:
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               1f
        strexb            r1, r2, [r0]
        cmp               r1, #0x0
        bne               0b
1:
        dmb               sy
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange::u8::acquire_relaxed:
        uxtb.w            r12, r1
        movs              r1, #0x1
0:
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               1f
        strexb            r1, r2, [r0]
        cmp               r1, #0x0
        bne               0b
        dmb               sy
1:
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange::u8::relaxed_acquire:
        uxtb.w            r12, r1
        movs              r1, #0x1
0:
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               1f
        strexb            r1, r2, [r0]
        cmp               r1, #0x0
        bne               0b
        b                 2f
1:
        dmb               sy
2:
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange::u8::relaxed_relaxed:
        uxtb.w            r12, r1
        movs              r1, #0x1
0:
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               1f
        strexb            r1, r2, [r0]
        cmp               r1, #0x0
        bne               0b
1:
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange::u8::release_acquire:
        uxtb.w            r12, r1
        movs              r1, #0x1
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               1f
        dmb               sy
0:
        strexb            r1, r2, [r0]
        cmp               r1, #0x0
        beq               2f
        ldrexb            r3, [r0]
        cmp               r3, r12
        beq               0b
1:
        dmb               sy
2:
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange::u8::release_relaxed:
        uxtb.w            r12, r1
        movs              r1, #0x1
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               1f
        dmb               sy
0:
        strexb            r1, r2, [r0]
        cmp               r1, #0x0
        beq               1f
        ldrexb            r3, [r0]
        cmp               r3, r12
        beq               0b
1:
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange::u16::acqrel_seqcst:
        uxth.w            r12, r1
        movs              r1, #0x1
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               1f
        dmb               sy
0:
        strexh            r1, r2, [r0]
        cmp               r1, #0x0
        beq               1f
        ldrexh            r3, [r0]
        cmp               r3, r12
        beq               0b
1:
        dmb               sy
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange::u16::seqcst_seqcst:
        uxth.w            r12, r1
        movs              r1, #0x1
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               1f
        dmb               sy
0:
        strexh            r1, r2, [r0]
        cmp               r1, #0x0
        beq               1f
        ldrexh            r3, [r0]
        cmp               r3, r12
        beq               0b
1:
        dmb               sy
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange::u16::acqrel_acquire:
        uxth.w            r12, r1
        movs              r1, #0x1
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               1f
        dmb               sy
0:
        strexh            r1, r2, [r0]
        cmp               r1, #0x0
        beq               1f
        ldrexh            r3, [r0]
        cmp               r3, r12
        beq               0b
1:
        dmb               sy
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange::u16::acqrel_relaxed:
        uxth.w            r12, r1
        movs              r1, #0x1
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               2f
        dmb               sy
0:
        strexh            r1, r2, [r0]
        cmp               r1, #0x0
        beq               1f
        ldrexh            r3, [r0]
        cmp               r3, r12
        beq               0b
        b                 2f
1:
        dmb               sy
2:
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange::u16::acquire_seqcst:
        uxth.w            r12, r1
        movs              r1, #0x1
0:
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               1f
        strexh            r1, r2, [r0]
        cmp               r1, #0x0
        bne               0b
1:
        dmb               sy
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange::u16::relaxed_seqcst:
        uxth.w            r12, r1
        movs              r1, #0x1
0:
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               1f
        strexh            r1, r2, [r0]
        cmp               r1, #0x0
        bne               0b
        b                 2f
1:
        dmb               sy
2:
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange::u16::release_seqcst:
        uxth.w            r12, r1
        movs              r1, #0x1
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               1f
        dmb               sy
0:
        strexh            r1, r2, [r0]
        cmp               r1, #0x0
        beq               2f
        ldrexh            r3, [r0]
        cmp               r3, r12
        beq               0b
1:
        dmb               sy
2:
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange::u16::seqcst_acquire:
        uxth.w            r12, r1
        movs              r1, #0x1
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               1f
        dmb               sy
0:
        strexh            r1, r2, [r0]
        cmp               r1, #0x0
        beq               1f
        ldrexh            r3, [r0]
        cmp               r3, r12
        beq               0b
1:
        dmb               sy
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange::u16::seqcst_relaxed:
        uxth.w            r12, r1
        movs              r1, #0x1
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               2f
        dmb               sy
0:
        strexh            r1, r2, [r0]
        cmp               r1, #0x0
        beq               1f
        ldrexh            r3, [r0]
        cmp               r3, r12
        beq               0b
        b                 2f
1:
        dmb               sy
2:
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange::u16::acquire_acquire:
        uxth.w            r12, r1
        movs              r1, #0x1
0:
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               1f
        strexh            r1, r2, [r0]
        cmp               r1, #0x0
        bne               0b
1:
        dmb               sy
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange::u16::acquire_relaxed:
        uxth.w            r12, r1
        movs              r1, #0x1
0:
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               1f
        strexh            r1, r2, [r0]
        cmp               r1, #0x0
        bne               0b
        dmb               sy
1:
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange::u16::relaxed_acquire:
        uxth.w            r12, r1
        movs              r1, #0x1
0:
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               1f
        strexh            r1, r2, [r0]
        cmp               r1, #0x0
        bne               0b
        b                 2f
1:
        dmb               sy
2:
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange::u16::relaxed_relaxed:
        uxth.w            r12, r1
        movs              r1, #0x1
0:
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               1f
        strexh            r1, r2, [r0]
        cmp               r1, #0x0
        bne               0b
1:
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange::u16::release_acquire:
        uxth.w            r12, r1
        movs              r1, #0x1
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               1f
        dmb               sy
0:
        strexh            r1, r2, [r0]
        cmp               r1, #0x0
        beq               2f
        ldrexh            r3, [r0]
        cmp               r3, r12
        beq               0b
1:
        dmb               sy
2:
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange::u16::release_relaxed:
        uxth.w            r12, r1
        movs              r1, #0x1
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               1f
        dmb               sy
0:
        strexh            r1, r2, [r0]
        cmp               r1, #0x0
        beq               1f
        ldrexh            r3, [r0]
        cmp               r3, r12
        beq               0b
1:
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange::u32::acqrel_seqcst:
        movs              r3, #0x1
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        dmb               sy
0:
        strex             r3, r2, [r0]
        cmp               r3, #0x0
        beq               1f
        ldrex             r12, [r0]
        cmp               r12, r1
        beq               0b
1:
        dmb               sy
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u32::seqcst_seqcst:
        movs              r3, #0x1
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        dmb               sy
0:
        strex             r3, r2, [r0]
        cmp               r3, #0x0
        beq               1f
        ldrex             r12, [r0]
        cmp               r12, r1
        beq               0b
1:
        dmb               sy
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u32::acqrel_acquire:
        movs              r3, #0x1
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        dmb               sy
0:
        strex             r3, r2, [r0]
        cmp               r3, #0x0
        beq               1f
        ldrex             r12, [r0]
        cmp               r12, r1
        beq               0b
1:
        dmb               sy
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u32::acqrel_relaxed:
        movs              r3, #0x1
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               2f
        dmb               sy
0:
        strex             r3, r2, [r0]
        cmp               r3, #0x0
        beq               1f
        ldrex             r12, [r0]
        cmp               r12, r1
        beq               0b
        b                 2f
1:
        dmb               sy
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u32::acquire_seqcst:
        movs              r3, #0x1
0:
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        strex             r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
1:
        dmb               sy
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u32::relaxed_seqcst:
        movs              r3, #0x1
0:
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        strex             r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        dmb               sy
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u32::release_seqcst:
        movs              r3, #0x1
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        dmb               sy
0:
        strex             r3, r2, [r0]
        cmp               r3, #0x0
        beq               2f
        ldrex             r12, [r0]
        cmp               r12, r1
        beq               0b
1:
        dmb               sy
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u32::seqcst_acquire:
        movs              r3, #0x1
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        dmb               sy
0:
        strex             r3, r2, [r0]
        cmp               r3, #0x0
        beq               1f
        ldrex             r12, [r0]
        cmp               r12, r1
        beq               0b
1:
        dmb               sy
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u32::seqcst_relaxed:
        movs              r3, #0x1
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               2f
        dmb               sy
0:
        strex             r3, r2, [r0]
        cmp               r3, #0x0
        beq               1f
        ldrex             r12, [r0]
        cmp               r12, r1
        beq               0b
        b                 2f
1:
        dmb               sy
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u32::acquire_acquire:
        movs              r3, #0x1
0:
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        strex             r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
1:
        dmb               sy
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u32::acquire_relaxed:
        movs              r3, #0x1
0:
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        strex             r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        dmb               sy
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u32::relaxed_acquire:
        movs              r3, #0x1
0:
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        strex             r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        dmb               sy
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u32::relaxed_relaxed:
        movs              r3, #0x1
0:
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        strex             r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u32::release_acquire:
        movs              r3, #0x1
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        dmb               sy
0:
        strex             r3, r2, [r0]
        cmp               r3, #0x0
        beq               2f
        ldrex             r12, [r0]
        cmp               r12, r1
        beq               0b
1:
        dmb               sy
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u32::release_relaxed:
        movs              r3, #0x1
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        dmb               sy
0:
        strex             r3, r2, [r0]
        cmp               r3, #0x0
        beq               1f
        ldrex             r12, [r0]
        cmp               r12, r1
        beq               0b
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        uxtb.w            r12, r1
        movs              r1, #0x1
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               0f
        dmb               sy
        strexb            r1, r2, [r0]
0:
        dmb               sy
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        uxtb.w            r12, r1
        movs              r1, #0x1
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               0f
        dmb               sy
        strexb            r1, r2, [r0]
0:
        dmb               sy
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        uxtb.w            r12, r1
        movs              r1, #0x1
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               0f
        dmb               sy
        strexb            r1, r2, [r0]
0:
        dmb               sy
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        uxtb.w            r12, r1
        movs              r1, #0x1
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               0f
        dmb               sy
        strexb            r1, r2, [r0]
        cmp               r1, #0x0
        bne               0f
        dmb               sy
0:
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        uxtb.w            r12, r1
        movs              r1, #0x1
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               0f
        strexb            r1, r2, [r0]
0:
        dmb               sy
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        uxtb.w            r12, r1
        movs              r1, #0x1
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               0f
        strexb            r1, r2, [r0]
        cmp               r1, #0x0
        beq               1f
0:
        dmb               sy
1:
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange_weak::u8::release_seqcst:
        uxtb.w            r12, r1
        movs              r1, #0x1
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               0f
        dmb               sy
        strexb            r1, r2, [r0]
        cmp               r1, #0x0
        beq               1f
0:
        dmb               sy
1:
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        uxtb.w            r12, r1
        movs              r1, #0x1
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               0f
        dmb               sy
        strexb            r1, r2, [r0]
0:
        dmb               sy
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        uxtb.w            r12, r1
        movs              r1, #0x1
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               0f
        dmb               sy
        strexb            r1, r2, [r0]
        cmp               r1, #0x0
        bne               0f
        dmb               sy
0:
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange_weak::u8::acquire_acquire:
        uxtb.w            r12, r1
        movs              r1, #0x1
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               0f
        strexb            r1, r2, [r0]
0:
        dmb               sy
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        uxtb.w            r12, r1
        movs              r1, #0x1
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               0f
        strexb            r1, r2, [r0]
        cmp               r1, #0x0
        bne               0f
        dmb               sy
0:
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        uxtb.w            r12, r1
        movs              r1, #0x1
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               0f
        strexb            r1, r2, [r0]
        cmp               r1, #0x0
        beq               1f
0:
        dmb               sy
1:
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        uxtb.w            r12, r1
        movs              r1, #0x1
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               0f
        strexb            r1, r2, [r0]
0:
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange_weak::u8::release_acquire:
        uxtb.w            r12, r1
        movs              r1, #0x1
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               0f
        dmb               sy
        strexb            r1, r2, [r0]
        cmp               r1, #0x0
        beq               1f
0:
        dmb               sy
1:
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange_weak::u8::release_relaxed:
        uxtb.w            r12, r1
        movs              r1, #0x1
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               0f
        dmb               sy
        strexb            r1, r2, [r0]
0:
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        uxth.w            r12, r1
        movs              r1, #0x1
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               0f
        dmb               sy
        strexh            r1, r2, [r0]
0:
        dmb               sy
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        uxth.w            r12, r1
        movs              r1, #0x1
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               0f
        dmb               sy
        strexh            r1, r2, [r0]
0:
        dmb               sy
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        uxth.w            r12, r1
        movs              r1, #0x1
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               0f
        dmb               sy
        strexh            r1, r2, [r0]
0:
        dmb               sy
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        uxth.w            r12, r1
        movs              r1, #0x1
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               0f
        dmb               sy
        strexh            r1, r2, [r0]
        cmp               r1, #0x0
        bne               0f
        dmb               sy
0:
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        uxth.w            r12, r1
        movs              r1, #0x1
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               0f
        strexh            r1, r2, [r0]
0:
        dmb               sy
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        uxth.w            r12, r1
        movs              r1, #0x1
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               0f
        strexh            r1, r2, [r0]
        cmp               r1, #0x0
        beq               1f
0:
        dmb               sy
1:
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange_weak::u16::release_seqcst:
        uxth.w            r12, r1
        movs              r1, #0x1
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               0f
        dmb               sy
        strexh            r1, r2, [r0]
        cmp               r1, #0x0
        beq               1f
0:
        dmb               sy
1:
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        uxth.w            r12, r1
        movs              r1, #0x1
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               0f
        dmb               sy
        strexh            r1, r2, [r0]
0:
        dmb               sy
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        uxth.w            r12, r1
        movs              r1, #0x1
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               0f
        dmb               sy
        strexh            r1, r2, [r0]
        cmp               r1, #0x0
        bne               0f
        dmb               sy
0:
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange_weak::u16::acquire_acquire:
        uxth.w            r12, r1
        movs              r1, #0x1
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               0f
        strexh            r1, r2, [r0]
0:
        dmb               sy
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        uxth.w            r12, r1
        movs              r1, #0x1
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               0f
        strexh            r1, r2, [r0]
        cmp               r1, #0x0
        bne               0f
        dmb               sy
0:
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        uxth.w            r12, r1
        movs              r1, #0x1
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               0f
        strexh            r1, r2, [r0]
        cmp               r1, #0x0
        beq               1f
0:
        dmb               sy
1:
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        uxth.w            r12, r1
        movs              r1, #0x1
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               0f
        strexh            r1, r2, [r0]
0:
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange_weak::u16::release_acquire:
        uxth.w            r12, r1
        movs              r1, #0x1
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               0f
        dmb               sy
        strexh            r1, r2, [r0]
        cmp               r1, #0x0
        beq               1f
0:
        dmb               sy
1:
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange_weak::u16::release_relaxed:
        uxth.w            r12, r1
        movs              r1, #0x1
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               0f
        dmb               sy
        strexh            r1, r2, [r0]
0:
        clz               r0, r1
        lsrs              r1, r0, #0x5
        mov               r0, r3
        bx                lr

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        movs              r3, #0x1
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        dmb               sy
        strex             r3, r2, [r0]
0:
        dmb               sy
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        movs              r3, #0x1
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        dmb               sy
        strex             r3, r2, [r0]
0:
        dmb               sy
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        movs              r3, #0x1
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        dmb               sy
        strex             r3, r2, [r0]
0:
        dmb               sy
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        movs              r3, #0x1
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        dmb               sy
        strex             r3, r2, [r0]
        cmp               r3, #0x0
        bne               0f
        dmb               sy
0:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        movs              r3, #0x1
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        strex             r3, r2, [r0]
0:
        dmb               sy
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        movs              r3, #0x1
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        strex             r3, r2, [r0]
        cmp               r3, #0x0
        beq               1f
0:
        dmb               sy
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u32::release_seqcst:
        movs              r3, #0x1
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        dmb               sy
        strex             r3, r2, [r0]
        cmp               r3, #0x0
        beq               1f
0:
        dmb               sy
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        movs              r3, #0x1
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        dmb               sy
        strex             r3, r2, [r0]
0:
        dmb               sy
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        movs              r3, #0x1
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        dmb               sy
        strex             r3, r2, [r0]
        cmp               r3, #0x0
        bne               0f
        dmb               sy
0:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u32::acquire_acquire:
        movs              r3, #0x1
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        strex             r3, r2, [r0]
0:
        dmb               sy
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        movs              r3, #0x1
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        strex             r3, r2, [r0]
        cmp               r3, #0x0
        bne               0f
        dmb               sy
0:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        movs              r3, #0x1
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        strex             r3, r2, [r0]
        cmp               r3, #0x0
        beq               1f
0:
        dmb               sy
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        movs              r3, #0x1
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        strex             r3, r2, [r0]
0:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u32::release_acquire:
        movs              r3, #0x1
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        dmb               sy
        strex             r3, r2, [r0]
        cmp               r3, #0x0
        beq               1f
0:
        dmb               sy
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u32::release_relaxed:
        movs              r3, #0x1
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        dmb               sy
        strex             r3, r2, [r0]
0:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::load::u8::seqcst:
        ldrb              r0, [r0]
        dmb               sy
        bx                lr

asm_test::load::u8::acquire:
        ldrb              r0, [r0]
        dmb               sy
        bx                lr

asm_test::load::u8::relaxed:
        ldrb              r0, [r0]
        bx                lr

asm_test::load::u16::seqcst:
        ldrh              r0, [r0]
        dmb               sy
        bx                lr

asm_test::load::u16::acquire:
        ldrh              r0, [r0]
        dmb               sy
        bx                lr

asm_test::load::u16::relaxed:
        ldrh              r0, [r0]
        bx                lr

asm_test::load::u32::seqcst:
        ldr               r0, [r0]
        dmb               sy
        bx                lr

asm_test::load::u32::acquire:
        ldr               r0, [r0]
        dmb               sy
        bx                lr

asm_test::load::u32::relaxed:
        ldr               r0, [r0]
        bx                lr

asm_test::swap::u8::acqrel:
        dmb               sy
0:
        ldrexb            r2, [r0]
        strexb            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        dmb               sy
        mov               r0, r2
        bx                lr

asm_test::swap::u8::seqcst:
        dmb               sy
0:
        ldrexb            r2, [r0]
        strexb            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        dmb               sy
        mov               r0, r2
        bx                lr

asm_test::swap::u8::acquire:
0:
        ldrexb            r2, [r0]
        strexb            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        dmb               sy
        mov               r0, r2
        bx                lr

asm_test::swap::u8::relaxed:
0:
        ldrexb            r2, [r0]
        strexb            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u8::release:
        dmb               sy
0:
        ldrexb            r2, [r0]
        strexb            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u16::acqrel:
        dmb               sy
0:
        ldrexh            r2, [r0]
        strexh            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        dmb               sy
        mov               r0, r2
        bx                lr

asm_test::swap::u16::seqcst:
        dmb               sy
0:
        ldrexh            r2, [r0]
        strexh            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        dmb               sy
        mov               r0, r2
        bx                lr

asm_test::swap::u16::acquire:
0:
        ldrexh            r2, [r0]
        strexh            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        dmb               sy
        mov               r0, r2
        bx                lr

asm_test::swap::u16::relaxed:
0:
        ldrexh            r2, [r0]
        strexh            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u16::release:
        dmb               sy
0:
        ldrexh            r2, [r0]
        strexh            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u32::acqrel:
        dmb               sy
0:
        ldrex             r2, [r0]
        strex             r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        dmb               sy
        mov               r0, r2
        bx                lr

asm_test::swap::u32::seqcst:
        dmb               sy
0:
        ldrex             r2, [r0]
        strex             r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        dmb               sy
        mov               r0, r2
        bx                lr

asm_test::swap::u32::acquire:
0:
        ldrex             r2, [r0]
        strex             r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        dmb               sy
        mov               r0, r2
        bx                lr

asm_test::swap::u32::relaxed:
0:
        ldrex             r2, [r0]
        strex             r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u32::release:
        dmb               sy
0:
        ldrex             r2, [r0]
        strex             r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::store::u8::seqcst:
        dmb               sy
        strb              r1, [r0]
        dmb               sy
        bx                lr

asm_test::store::u8::relaxed:
        strb              r1, [r0]
        bx                lr

asm_test::store::u8::release:
        dmb               sy
        strb              r1, [r0]
        bx                lr

asm_test::store::u16::seqcst:
        dmb               sy
        strh              r1, [r0]
        dmb               sy
        bx                lr

asm_test::store::u16::relaxed:
        strh              r1, [r0]
        bx                lr

asm_test::store::u16::release:
        dmb               sy
        strh              r1, [r0]
        bx                lr

asm_test::store::u32::seqcst:
        dmb               sy
        str               r1, [r0]
        dmb               sy
        bx                lr

asm_test::store::u32::relaxed:
        str               r1, [r0]
        bx                lr

asm_test::store::u32::release:
        dmb               sy
        str               r1, [r0]
        bx                lr
