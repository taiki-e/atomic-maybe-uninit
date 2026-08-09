asm_test::compare_exchange::u8::acqrel_seqcst:
        uxtb.w            r12, r1
        movs              r1, #0x1
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               1f
        dmb               ish
0:
        strexb            r1, r2, [r0]
        cmp               r1, #0x0
        beq               1f
        ldrexb            r3, [r0]
        cmp               r3, r12
        beq               0b
1:
        dmb               ish
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
        dmb               ish
0:
        strexb            r1, r2, [r0]
        cmp               r1, #0x0
        beq               1f
        ldrexb            r3, [r0]
        cmp               r3, r12
        beq               0b
1:
        dmb               ish
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
        dmb               ish
0:
        strexb            r1, r2, [r0]
        cmp               r1, #0x0
        beq               1f
        ldrexb            r3, [r0]
        cmp               r3, r12
        beq               0b
1:
        dmb               ish
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
        dmb               ish
0:
        strexb            r1, r2, [r0]
        cmp               r1, #0x0
        beq               1f
        ldrexb            r3, [r0]
        cmp               r3, r12
        beq               0b
        b                 2f
1:
        dmb               ish
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
        dmb               ish
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
        dmb               ish
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
        dmb               ish
0:
        strexb            r1, r2, [r0]
        cmp               r1, #0x0
        beq               2f
        ldrexb            r3, [r0]
        cmp               r3, r12
        beq               0b
1:
        dmb               ish
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
        dmb               ish
0:
        strexb            r1, r2, [r0]
        cmp               r1, #0x0
        beq               1f
        ldrexb            r3, [r0]
        cmp               r3, r12
        beq               0b
1:
        dmb               ish
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
        dmb               ish
0:
        strexb            r1, r2, [r0]
        cmp               r1, #0x0
        beq               1f
        ldrexb            r3, [r0]
        cmp               r3, r12
        beq               0b
        b                 2f
1:
        dmb               ish
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
        dmb               ish
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
        dmb               ish
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
        dmb               ish
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
        dmb               ish
0:
        strexb            r1, r2, [r0]
        cmp               r1, #0x0
        beq               2f
        ldrexb            r3, [r0]
        cmp               r3, r12
        beq               0b
1:
        dmb               ish
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
        dmb               ish
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
        dmb               ish
0:
        strexh            r1, r2, [r0]
        cmp               r1, #0x0
        beq               1f
        ldrexh            r3, [r0]
        cmp               r3, r12
        beq               0b
1:
        dmb               ish
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
        dmb               ish
0:
        strexh            r1, r2, [r0]
        cmp               r1, #0x0
        beq               1f
        ldrexh            r3, [r0]
        cmp               r3, r12
        beq               0b
1:
        dmb               ish
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
        dmb               ish
0:
        strexh            r1, r2, [r0]
        cmp               r1, #0x0
        beq               1f
        ldrexh            r3, [r0]
        cmp               r3, r12
        beq               0b
1:
        dmb               ish
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
        dmb               ish
0:
        strexh            r1, r2, [r0]
        cmp               r1, #0x0
        beq               1f
        ldrexh            r3, [r0]
        cmp               r3, r12
        beq               0b
        b                 2f
1:
        dmb               ish
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
        dmb               ish
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
        dmb               ish
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
        dmb               ish
0:
        strexh            r1, r2, [r0]
        cmp               r1, #0x0
        beq               2f
        ldrexh            r3, [r0]
        cmp               r3, r12
        beq               0b
1:
        dmb               ish
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
        dmb               ish
0:
        strexh            r1, r2, [r0]
        cmp               r1, #0x0
        beq               1f
        ldrexh            r3, [r0]
        cmp               r3, r12
        beq               0b
1:
        dmb               ish
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
        dmb               ish
0:
        strexh            r1, r2, [r0]
        cmp               r1, #0x0
        beq               1f
        ldrexh            r3, [r0]
        cmp               r3, r12
        beq               0b
        b                 2f
1:
        dmb               ish
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
        dmb               ish
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
        dmb               ish
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
        dmb               ish
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
        dmb               ish
0:
        strexh            r1, r2, [r0]
        cmp               r1, #0x0
        beq               2f
        ldrexh            r3, [r0]
        cmp               r3, r12
        beq               0b
1:
        dmb               ish
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
        dmb               ish
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
        dmb               ish
0:
        strex             r3, r2, [r0]
        cmp               r3, #0x0
        beq               1f
        ldrex             r12, [r0]
        cmp               r12, r1
        beq               0b
1:
        dmb               ish
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u32::seqcst_seqcst:
        movs              r3, #0x1
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        dmb               ish
0:
        strex             r3, r2, [r0]
        cmp               r3, #0x0
        beq               1f
        ldrex             r12, [r0]
        cmp               r12, r1
        beq               0b
1:
        dmb               ish
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u32::acqrel_acquire:
        movs              r3, #0x1
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        dmb               ish
0:
        strex             r3, r2, [r0]
        cmp               r3, #0x0
        beq               1f
        ldrex             r12, [r0]
        cmp               r12, r1
        beq               0b
1:
        dmb               ish
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u32::acqrel_relaxed:
        movs              r3, #0x1
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               2f
        dmb               ish
0:
        strex             r3, r2, [r0]
        cmp               r3, #0x0
        beq               1f
        ldrex             r12, [r0]
        cmp               r12, r1
        beq               0b
        b                 2f
1:
        dmb               ish
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
        dmb               ish
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
        dmb               ish
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
        dmb               ish
0:
        strex             r3, r2, [r0]
        cmp               r3, #0x0
        beq               2f
        ldrex             r12, [r0]
        cmp               r12, r1
        beq               0b
1:
        dmb               ish
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
        dmb               ish
0:
        strex             r3, r2, [r0]
        cmp               r3, #0x0
        beq               1f
        ldrex             r12, [r0]
        cmp               r12, r1
        beq               0b
1:
        dmb               ish
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u32::seqcst_relaxed:
        movs              r3, #0x1
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               2f
        dmb               ish
0:
        strex             r3, r2, [r0]
        cmp               r3, #0x0
        beq               1f
        ldrex             r12, [r0]
        cmp               r12, r1
        beq               0b
        b                 2f
1:
        dmb               ish
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
        dmb               ish
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
        dmb               ish
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
        dmb               ish
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
        dmb               ish
0:
        strex             r3, r2, [r0]
        cmp               r3, #0x0
        beq               2f
        ldrex             r12, [r0]
        cmp               r12, r1
        beq               0b
1:
        dmb               ish
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
        dmb               ish
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

asm_test::compare_exchange::u64::acqrel_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
        ldrexd            r2, r3, [r1]
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        mov.w             r6, #0x1
        bne               1f
        dmb               ish
0:
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0x0
        beq               1f
        ldrexd            r2, r3, [r1]
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        mov.w             r6, #0x1
        beq               0b
1:
        dmb               ish
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}

asm_test::compare_exchange::u64::seqcst_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
        ldrexd            r2, r3, [r1]
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        mov.w             r6, #0x1
        bne               1f
        dmb               ish
0:
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0x0
        beq               1f
        ldrexd            r2, r3, [r1]
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        mov.w             r6, #0x1
        beq               0b
1:
        dmb               ish
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}

asm_test::compare_exchange::u64::acqrel_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
        ldrexd            r2, r3, [r1]
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        mov.w             r6, #0x1
        bne               1f
        dmb               ish
0:
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0x0
        beq               1f
        ldrexd            r2, r3, [r1]
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        mov.w             r6, #0x1
        beq               0b
1:
        dmb               ish
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}

asm_test::compare_exchange::u64::acqrel_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
        ldrexd            r2, r3, [r1]
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        mov.w             r6, #0x1
        bne               2f
        dmb               ish
0:
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0x0
        beq               1f
        ldrexd            r2, r3, [r1]
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        mov.w             r6, #0x1
        beq               0b
        b                 2f
1:
        dmb               ish
2:
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}

asm_test::compare_exchange::u64::acquire_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
0:
        ldrexd            r2, r3, [r1]
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        mov.w             r6, #0x1
        bne               1f
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0x0
        bne               0b
1:
        dmb               ish
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}

asm_test::compare_exchange::u64::relaxed_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
0:
        ldrexd            r2, r3, [r1]
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        mov.w             r6, #0x1
        bne               1f
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0x0
        bne               0b
        b                 2f
1:
        dmb               ish
2:
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}

asm_test::compare_exchange::u64::release_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
        ldrexd            r2, r3, [r1]
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        mov.w             r6, #0x1
        bne               1f
        dmb               ish
0:
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0x0
        beq               2f
        ldrexd            r2, r3, [r1]
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        mov.w             r6, #0x1
        beq               0b
1:
        dmb               ish
2:
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}

asm_test::compare_exchange::u64::seqcst_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
        ldrexd            r2, r3, [r1]
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        mov.w             r6, #0x1
        bne               1f
        dmb               ish
0:
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0x0
        beq               1f
        ldrexd            r2, r3, [r1]
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        mov.w             r6, #0x1
        beq               0b
1:
        dmb               ish
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}

asm_test::compare_exchange::u64::seqcst_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
        ldrexd            r2, r3, [r1]
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        mov.w             r6, #0x1
        bne               2f
        dmb               ish
0:
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0x0
        beq               1f
        ldrexd            r2, r3, [r1]
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        mov.w             r6, #0x1
        beq               0b
        b                 2f
1:
        dmb               ish
2:
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}

asm_test::compare_exchange::u64::acquire_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
0:
        ldrexd            r2, r3, [r1]
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        mov.w             r6, #0x1
        bne               1f
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0x0
        bne               0b
1:
        dmb               ish
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}

asm_test::compare_exchange::u64::acquire_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
0:
        ldrexd            r2, r3, [r1]
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        mov.w             r6, #0x1
        bne               1f
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0x0
        bne               0b
        dmb               ish
1:
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}

asm_test::compare_exchange::u64::relaxed_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
0:
        ldrexd            r2, r3, [r1]
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        mov.w             r6, #0x1
        bne               1f
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0x0
        bne               0b
        b                 2f
1:
        dmb               ish
2:
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}

asm_test::compare_exchange::u64::relaxed_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
0:
        ldrexd            r2, r3, [r1]
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        mov.w             r6, #0x1
        bne               1f
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0x0
        bne               0b
1:
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}

asm_test::compare_exchange::u64::release_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
        ldrexd            r2, r3, [r1]
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        mov.w             r6, #0x1
        bne               1f
        dmb               ish
0:
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0x0
        beq               2f
        ldrexd            r2, r3, [r1]
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        mov.w             r6, #0x1
        beq               0b
1:
        dmb               ish
2:
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}

asm_test::compare_exchange::u64::release_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
        ldrexd            r2, r3, [r1]
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        mov.w             r6, #0x1
        bne               1f
        dmb               ish
0:
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0x0
        beq               1f
        ldrexd            r2, r3, [r1]
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        mov.w             r6, #0x1
        beq               0b
1:
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        uxtb.w            r12, r1
        movs              r1, #0x1
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               0f
        dmb               ish
        strexb            r1, r2, [r0]
0:
        dmb               ish
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
        dmb               ish
        strexb            r1, r2, [r0]
0:
        dmb               ish
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
        dmb               ish
        strexb            r1, r2, [r0]
0:
        dmb               ish
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
        dmb               ish
        strexb            r1, r2, [r0]
        cmp               r1, #0x0
        bne               0f
        dmb               ish
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
        dmb               ish
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
        dmb               ish
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
        dmb               ish
        strexb            r1, r2, [r0]
        cmp               r1, #0x0
        beq               1f
0:
        dmb               ish
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
        dmb               ish
        strexb            r1, r2, [r0]
0:
        dmb               ish
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
        dmb               ish
        strexb            r1, r2, [r0]
        cmp               r1, #0x0
        bne               0f
        dmb               ish
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
        dmb               ish
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
        dmb               ish
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
        dmb               ish
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
        dmb               ish
        strexb            r1, r2, [r0]
        cmp               r1, #0x0
        beq               1f
0:
        dmb               ish
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
        dmb               ish
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
        dmb               ish
        strexh            r1, r2, [r0]
0:
        dmb               ish
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
        dmb               ish
        strexh            r1, r2, [r0]
0:
        dmb               ish
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
        dmb               ish
        strexh            r1, r2, [r0]
0:
        dmb               ish
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
        dmb               ish
        strexh            r1, r2, [r0]
        cmp               r1, #0x0
        bne               0f
        dmb               ish
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
        dmb               ish
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
        dmb               ish
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
        dmb               ish
        strexh            r1, r2, [r0]
        cmp               r1, #0x0
        beq               1f
0:
        dmb               ish
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
        dmb               ish
        strexh            r1, r2, [r0]
0:
        dmb               ish
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
        dmb               ish
        strexh            r1, r2, [r0]
        cmp               r1, #0x0
        bne               0f
        dmb               ish
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
        dmb               ish
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
        dmb               ish
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
        dmb               ish
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
        dmb               ish
        strexh            r1, r2, [r0]
        cmp               r1, #0x0
        beq               1f
0:
        dmb               ish
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
        dmb               ish
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
        dmb               ish
        strex             r3, r2, [r0]
0:
        dmb               ish
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        movs              r3, #0x1
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        dmb               ish
        strex             r3, r2, [r0]
0:
        dmb               ish
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        movs              r3, #0x1
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        dmb               ish
        strex             r3, r2, [r0]
0:
        dmb               ish
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        movs              r3, #0x1
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        dmb               ish
        strex             r3, r2, [r0]
        cmp               r3, #0x0
        bne               0f
        dmb               ish
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
        dmb               ish
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
        dmb               ish
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
        dmb               ish
        strex             r3, r2, [r0]
        cmp               r3, #0x0
        beq               1f
0:
        dmb               ish
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
        dmb               ish
        strex             r3, r2, [r0]
0:
        dmb               ish
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        movs              r3, #0x1
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        dmb               ish
        strex             r3, r2, [r0]
        cmp               r3, #0x0
        bne               0f
        dmb               ish
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
        dmb               ish
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
        dmb               ish
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
        dmb               ish
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
        dmb               ish
        strex             r3, r2, [r0]
        cmp               r3, #0x0
        beq               1f
0:
        dmb               ish
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
        dmb               ish
        strex             r3, r2, [r0]
0:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u64::acqrel_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
        ldrexd            r2, r3, [r1]
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        mov.w             r6, #0x1
        bne               0f
        dmb               ish
        strexd            r6, r4, r5, [r1]
0:
        dmb               ish
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}

asm_test::compare_exchange_weak::u64::seqcst_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
        ldrexd            r2, r3, [r1]
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        mov.w             r6, #0x1
        bne               0f
        dmb               ish
        strexd            r6, r4, r5, [r1]
0:
        dmb               ish
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}

asm_test::compare_exchange_weak::u64::acqrel_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
        ldrexd            r2, r3, [r1]
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        mov.w             r6, #0x1
        bne               0f
        dmb               ish
        strexd            r6, r4, r5, [r1]
0:
        dmb               ish
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}

asm_test::compare_exchange_weak::u64::acqrel_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
        ldrexd            r2, r3, [r1]
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        mov.w             r6, #0x1
        bne               0f
        dmb               ish
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0x0
        bne               0f
        dmb               ish
0:
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}

asm_test::compare_exchange_weak::u64::acquire_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
        ldrexd            r2, r3, [r1]
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        mov.w             r6, #0x1
        bne               0f
        strexd            r6, r4, r5, [r1]
0:
        dmb               ish
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}

asm_test::compare_exchange_weak::u64::relaxed_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
        ldrexd            r2, r3, [r1]
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        mov.w             r6, #0x1
        bne               0f
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0x0
        beq               1f
0:
        dmb               ish
1:
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}

asm_test::compare_exchange_weak::u64::release_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
        ldrexd            r2, r3, [r1]
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        mov.w             r6, #0x1
        bne               0f
        dmb               ish
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0x0
        beq               1f
0:
        dmb               ish
1:
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}

asm_test::compare_exchange_weak::u64::seqcst_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
        ldrexd            r2, r3, [r1]
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        mov.w             r6, #0x1
        bne               0f
        dmb               ish
        strexd            r6, r4, r5, [r1]
0:
        dmb               ish
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}

asm_test::compare_exchange_weak::u64::seqcst_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
        ldrexd            r2, r3, [r1]
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        mov.w             r6, #0x1
        bne               0f
        dmb               ish
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0x0
        bne               0f
        dmb               ish
0:
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}

asm_test::compare_exchange_weak::u64::acquire_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
        ldrexd            r2, r3, [r1]
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        mov.w             r6, #0x1
        bne               0f
        strexd            r6, r4, r5, [r1]
0:
        dmb               ish
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}

asm_test::compare_exchange_weak::u64::acquire_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
        ldrexd            r2, r3, [r1]
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        mov.w             r6, #0x1
        bne               0f
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0x0
        bne               0f
        dmb               ish
0:
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}

asm_test::compare_exchange_weak::u64::relaxed_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
        ldrexd            r2, r3, [r1]
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        mov.w             r6, #0x1
        bne               0f
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0x0
        beq               1f
0:
        dmb               ish
1:
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}

asm_test::compare_exchange_weak::u64::relaxed_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
        ldrexd            r2, r3, [r1]
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        mov.w             r6, #0x1
        bne               0f
        strexd            r6, r4, r5, [r1]
0:
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}

asm_test::compare_exchange_weak::u64::release_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
        ldrexd            r2, r3, [r1]
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        mov.w             r6, #0x1
        bne               0f
        dmb               ish
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0x0
        beq               1f
0:
        dmb               ish
1:
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}

asm_test::compare_exchange_weak::u64::release_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
        ldrexd            r2, r3, [r1]
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        mov.w             r6, #0x1
        bne               0f
        dmb               ish
        strexd            r6, r4, r5, [r1]
0:
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}

asm_test::load::u8::seqcst:
        ldrb              r0, [r0]
        dmb               ish
        bx                lr

asm_test::load::u8::acquire:
        ldrb              r0, [r0]
        dmb               ish
        bx                lr

asm_test::load::u8::relaxed:
        ldrb              r0, [r0]
        bx                lr

asm_test::load::u16::seqcst:
        ldrh              r0, [r0]
        dmb               ish
        bx                lr

asm_test::load::u16::acquire:
        ldrh              r0, [r0]
        dmb               ish
        bx                lr

asm_test::load::u16::relaxed:
        ldrh              r0, [r0]
        bx                lr

asm_test::load::u32::seqcst:
        ldr               r0, [r0]
        dmb               ish
        bx                lr

asm_test::load::u32::acquire:
        ldr               r0, [r0]
        dmb               ish
        bx                lr

asm_test::load::u32::relaxed:
        ldr               r0, [r0]
        bx                lr

asm_test::load::u64::seqcst:
        ldrexd            r0, r1, [r0]
        dmb               ish
        bx                lr

asm_test::load::u64::acquire:
        ldrexd            r0, r1, [r0]
        dmb               ish
        bx                lr

asm_test::load::u64::relaxed:
        ldrexd            r0, r1, [r0]
        bx                lr

asm_test::swap::u8::acqrel:
        dmb               ish
0:
        ldrexb            r2, [r0]
        strexb            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        dmb               ish
        mov               r0, r2
        bx                lr

asm_test::swap::u8::seqcst:
        dmb               ish
0:
        ldrexb            r2, [r0]
        strexb            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        dmb               ish
        mov               r0, r2
        bx                lr

asm_test::swap::u8::acquire:
0:
        ldrexb            r2, [r0]
        strexb            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        dmb               ish
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
        dmb               ish
0:
        ldrexb            r2, [r0]
        strexb            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u16::acqrel:
        dmb               ish
0:
        ldrexh            r2, [r0]
        strexh            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        dmb               ish
        mov               r0, r2
        bx                lr

asm_test::swap::u16::seqcst:
        dmb               ish
0:
        ldrexh            r2, [r0]
        strexh            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        dmb               ish
        mov               r0, r2
        bx                lr

asm_test::swap::u16::acquire:
0:
        ldrexh            r2, [r0]
        strexh            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        dmb               ish
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
        dmb               ish
0:
        ldrexh            r2, [r0]
        strexh            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u32::acqrel:
        dmb               ish
0:
        ldrex             r2, [r0]
        strex             r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        dmb               ish
        mov               r0, r2
        bx                lr

asm_test::swap::u32::seqcst:
        dmb               ish
0:
        ldrex             r2, [r0]
        strex             r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        dmb               ish
        mov               r0, r2
        bx                lr

asm_test::swap::u32::acquire:
0:
        ldrex             r2, [r0]
        strex             r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        dmb               ish
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
        dmb               ish
0:
        ldrex             r2, [r0]
        strex             r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u64::acqrel:
        push              {r7, lr}
        mov               r12, r0
        dmb               ish
0:
        ldrexd            r0, r1, [r12]
        strexd            lr, r2, r3, [r12]
        cmp.w             lr, #0x0
        bne               0b
        dmb               ish
        pop               {r7, pc}

asm_test::swap::u64::seqcst:
        push              {r7, lr}
        mov               r12, r0
        dmb               ish
0:
        ldrexd            r0, r1, [r12]
        strexd            lr, r2, r3, [r12]
        cmp.w             lr, #0x0
        bne               0b
        dmb               ish
        pop               {r7, pc}

asm_test::swap::u64::acquire:
        push              {r7, lr}
        mov               r12, r0
0:
        ldrexd            r0, r1, [r12]
        strexd            lr, r2, r3, [r12]
        cmp.w             lr, #0x0
        bne               0b
        dmb               ish
        pop               {r7, pc}

asm_test::swap::u64::relaxed:
        push              {r7, lr}
        mov               r12, r0
0:
        ldrexd            r0, r1, [r12]
        strexd            lr, r2, r3, [r12]
        cmp.w             lr, #0x0
        bne               0b
        pop               {r7, pc}

asm_test::swap::u64::release:
        push              {r7, lr}
        mov               r12, r0
        dmb               ish
0:
        ldrexd            r0, r1, [r12]
        strexd            lr, r2, r3, [r12]
        cmp.w             lr, #0x0
        bne               0b
        pop               {r7, pc}

asm_test::store::u8::seqcst:
        dmb               ish
        strb              r1, [r0]
        dmb               ish
        bx                lr

asm_test::store::u8::relaxed:
        strb              r1, [r0]
        bx                lr

asm_test::store::u8::release:
        dmb               ish
        strb              r1, [r0]
        bx                lr

asm_test::store::u16::seqcst:
        dmb               ish
        strh              r1, [r0]
        dmb               ish
        bx                lr

asm_test::store::u16::relaxed:
        strh              r1, [r0]
        bx                lr

asm_test::store::u16::release:
        dmb               ish
        strh              r1, [r0]
        bx                lr

asm_test::store::u32::seqcst:
        dmb               ish
        str               r1, [r0]
        dmb               ish
        bx                lr

asm_test::store::u32::relaxed:
        str               r1, [r0]
        bx                lr

asm_test::store::u32::release:
        dmb               ish
        str               r1, [r0]
        bx                lr

asm_test::store::u64::seqcst:
        push              {r4, r5, r7, lr}
        dmb               ish
0:
        ldrexd            r4, r5, [r0]
        strexd            r4, r2, r3, [r0]
        cmp               r4, #0x0
        bne               0b
        dmb               ish
        pop               {r4, r5, r7, pc}

asm_test::store::u64::relaxed:
        push              {r4, r5, r7, lr}
0:
        ldrexd            r4, r5, [r0]
        strexd            r4, r2, r3, [r0]
        cmp               r4, #0x0
        bne               0b
        pop               {r4, r5, r7, pc}

asm_test::store::u64::release:
        push              {r4, r5, r7, lr}
        dmb               ish
0:
        ldrexd            r4, r5, [r0]
        strexd            r4, r2, r3, [r0]
        cmp               r4, #0x0
        bne               0b
        pop               {r4, r5, r7, pc}
