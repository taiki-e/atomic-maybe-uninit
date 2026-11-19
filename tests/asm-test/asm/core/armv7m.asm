asm_test::compare_exchange::u8::acqrel_seqcst:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               sy
0:
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             sy
        bxeq              lr
        ldrexb            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange::u8::seqcst_seqcst:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               sy
0:
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             sy
        bxeq              lr
        ldrexb            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange::u8::acqrel_acquire:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               sy
0:
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             sy
        bxeq              lr
        ldrexb            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange::u8::acqrel_relaxed:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               sy
0:
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        dmbeq             sy
        moveq             r1, #0x1
        bxeq              lr
        ldrexb            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        movs              r1, #0x0
        clrex
        bx                lr

asm_test::compare_exchange::u8::acquire_seqcst:
        mov               r3, r0
        uxtb.w            r12, r1
0:
        ldrexb            r0, [r3]
        cmp               r0, r12
        bne               1f
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             sy
        bxeq              lr
        b                 0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange::u8::relaxed_seqcst:
        mov               r3, r0
        uxtb.w            r12, r1
0:
        ldrexb            r0, [r3]
        cmp               r0, r12
        bne               1f
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        itt               eq
        moveq             r1, #0x1
        bxeq              lr
        b                 0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange::u8::release_seqcst:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               sy
0:
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        itt               eq
        moveq             r1, #0x1
        bxeq              lr
        ldrexb            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange::u8::seqcst_acquire:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               sy
0:
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             sy
        bxeq              lr
        ldrexb            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange::u8::seqcst_relaxed:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               sy
0:
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        dmbeq             sy
        moveq             r1, #0x1
        bxeq              lr
        ldrexb            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        movs              r1, #0x0
        clrex
        bx                lr

asm_test::compare_exchange::u8::acquire_acquire:
        mov               r3, r0
        uxtb.w            r12, r1
0:
        ldrexb            r0, [r3]
        cmp               r0, r12
        bne               1f
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             sy
        bxeq              lr
        b                 0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange::u8::acquire_relaxed:
        mov               r3, r0
        uxtb.w            r12, r1
0:
        ldrexb            r0, [r3]
        cmp               r0, r12
        bne               1f
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        dmbeq             sy
        moveq             r1, #0x1
        bxeq              lr
        b                 0b
1:
        movs              r1, #0x0
        clrex
        bx                lr

asm_test::compare_exchange::u8::relaxed_acquire:
        mov               r3, r0
        uxtb.w            r12, r1
0:
        ldrexb            r0, [r3]
        cmp               r0, r12
        bne               1f
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        itt               eq
        moveq             r1, #0x1
        bxeq              lr
        b                 0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange::u8::relaxed_relaxed:
        mov               r3, r0
        uxtb.w            r12, r1
0:
        ldrexb            r0, [r3]
        cmp               r0, r12
        bne               1f
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        itt               eq
        moveq             r1, #0x1
        bxeq              lr
        b                 0b
1:
        movs              r1, #0x0
        clrex
        bx                lr

asm_test::compare_exchange::u8::release_acquire:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               sy
0:
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        itt               eq
        moveq             r1, #0x1
        bxeq              lr
        ldrexb            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange::u8::release_relaxed:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               sy
0:
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        itt               eq
        moveq             r1, #0x1
        bxeq              lr
        ldrexb            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        movs              r1, #0x0
        clrex
        bx                lr

asm_test::compare_exchange::u16::acqrel_seqcst:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               sy
0:
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             sy
        bxeq              lr
        ldrexh            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange::u16::seqcst_seqcst:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               sy
0:
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             sy
        bxeq              lr
        ldrexh            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange::u16::acqrel_acquire:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               sy
0:
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             sy
        bxeq              lr
        ldrexh            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange::u16::acqrel_relaxed:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               sy
0:
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        dmbeq             sy
        moveq             r1, #0x1
        bxeq              lr
        ldrexh            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        movs              r1, #0x0
        clrex
        bx                lr

asm_test::compare_exchange::u16::acquire_seqcst:
        mov               r3, r0
        uxth.w            r12, r1
0:
        ldrexh            r0, [r3]
        cmp               r0, r12
        bne               1f
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             sy
        bxeq              lr
        b                 0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange::u16::relaxed_seqcst:
        mov               r3, r0
        uxth.w            r12, r1
0:
        ldrexh            r0, [r3]
        cmp               r0, r12
        bne               1f
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        itt               eq
        moveq             r1, #0x1
        bxeq              lr
        b                 0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange::u16::release_seqcst:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               sy
0:
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        itt               eq
        moveq             r1, #0x1
        bxeq              lr
        ldrexh            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange::u16::seqcst_acquire:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               sy
0:
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             sy
        bxeq              lr
        ldrexh            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange::u16::seqcst_relaxed:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               sy
0:
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        dmbeq             sy
        moveq             r1, #0x1
        bxeq              lr
        ldrexh            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        movs              r1, #0x0
        clrex
        bx                lr

asm_test::compare_exchange::u16::acquire_acquire:
        mov               r3, r0
        uxth.w            r12, r1
0:
        ldrexh            r0, [r3]
        cmp               r0, r12
        bne               1f
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             sy
        bxeq              lr
        b                 0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange::u16::acquire_relaxed:
        mov               r3, r0
        uxth.w            r12, r1
0:
        ldrexh            r0, [r3]
        cmp               r0, r12
        bne               1f
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        dmbeq             sy
        moveq             r1, #0x1
        bxeq              lr
        b                 0b
1:
        movs              r1, #0x0
        clrex
        bx                lr

asm_test::compare_exchange::u16::relaxed_acquire:
        mov               r3, r0
        uxth.w            r12, r1
0:
        ldrexh            r0, [r3]
        cmp               r0, r12
        bne               1f
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        itt               eq
        moveq             r1, #0x1
        bxeq              lr
        b                 0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange::u16::relaxed_relaxed:
        mov               r3, r0
        uxth.w            r12, r1
0:
        ldrexh            r0, [r3]
        cmp               r0, r12
        bne               1f
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        itt               eq
        moveq             r1, #0x1
        bxeq              lr
        b                 0b
1:
        movs              r1, #0x0
        clrex
        bx                lr

asm_test::compare_exchange::u16::release_acquire:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               sy
0:
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        itt               eq
        moveq             r1, #0x1
        bxeq              lr
        ldrexh            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange::u16::release_relaxed:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               sy
0:
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        itt               eq
        moveq             r1, #0x1
        bxeq              lr
        ldrexh            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        movs              r1, #0x0
        clrex
        bx                lr

asm_test::compare_exchange::u32::acqrel_seqcst:
        mov               r12, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               1f
        dmb               sy
0:
        strex             r3, r2, [r12]
        cmp               r3, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             sy
        bxeq              lr
        ldrex             r0, [r12]
        cmp               r0, r1
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange::u32::seqcst_seqcst:
        mov               r12, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               1f
        dmb               sy
0:
        strex             r3, r2, [r12]
        cmp               r3, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             sy
        bxeq              lr
        ldrex             r0, [r12]
        cmp               r0, r1
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange::u32::acqrel_acquire:
        mov               r12, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               1f
        dmb               sy
0:
        strex             r3, r2, [r12]
        cmp               r3, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             sy
        bxeq              lr
        ldrex             r0, [r12]
        cmp               r0, r1
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange::u32::acqrel_relaxed:
        mov               r12, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               1f
        dmb               sy
0:
        strex             r3, r2, [r12]
        cmp               r3, #0x0
        ittt              eq
        dmbeq             sy
        moveq             r1, #0x1
        bxeq              lr
        ldrex             r0, [r12]
        cmp               r0, r1
        beq               0b
1:
        movs              r1, #0x0
        clrex
        bx                lr

asm_test::compare_exchange::u32::acquire_seqcst:
        mov               r12, r0
0:
        ldrex             r0, [r12]
        cmp               r0, r1
        bne               1f
        strex             r3, r2, [r12]
        cmp               r3, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             sy
        bxeq              lr
        b                 0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange::u32::relaxed_seqcst:
        mov               r12, r0
0:
        ldrex             r0, [r12]
        cmp               r0, r1
        bne               1f
        strex             r3, r2, [r12]
        cmp               r3, #0x0
        itt               eq
        moveq             r1, #0x1
        bxeq              lr
        b                 0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange::u32::release_seqcst:
        mov               r12, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               1f
        dmb               sy
0:
        strex             r3, r2, [r12]
        cmp               r3, #0x0
        itt               eq
        moveq             r1, #0x1
        bxeq              lr
        ldrex             r0, [r12]
        cmp               r0, r1
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange::u32::seqcst_acquire:
        mov               r12, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               1f
        dmb               sy
0:
        strex             r3, r2, [r12]
        cmp               r3, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             sy
        bxeq              lr
        ldrex             r0, [r12]
        cmp               r0, r1
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange::u32::seqcst_relaxed:
        mov               r12, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               1f
        dmb               sy
0:
        strex             r3, r2, [r12]
        cmp               r3, #0x0
        ittt              eq
        dmbeq             sy
        moveq             r1, #0x1
        bxeq              lr
        ldrex             r0, [r12]
        cmp               r0, r1
        beq               0b
1:
        movs              r1, #0x0
        clrex
        bx                lr

asm_test::compare_exchange::u32::acquire_acquire:
        mov               r12, r0
0:
        ldrex             r0, [r12]
        cmp               r0, r1
        bne               1f
        strex             r3, r2, [r12]
        cmp               r3, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             sy
        bxeq              lr
        b                 0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange::u32::acquire_relaxed:
        mov               r12, r0
0:
        ldrex             r0, [r12]
        cmp               r0, r1
        bne               1f
        strex             r3, r2, [r12]
        cmp               r3, #0x0
        ittt              eq
        dmbeq             sy
        moveq             r1, #0x1
        bxeq              lr
        b                 0b
1:
        movs              r1, #0x0
        clrex
        bx                lr

asm_test::compare_exchange::u32::relaxed_acquire:
        mov               r12, r0
0:
        ldrex             r0, [r12]
        cmp               r0, r1
        bne               1f
        strex             r3, r2, [r12]
        cmp               r3, #0x0
        itt               eq
        moveq             r1, #0x1
        bxeq              lr
        b                 0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange::u32::relaxed_relaxed:
        mov               r12, r0
0:
        ldrex             r0, [r12]
        cmp               r0, r1
        bne               1f
        strex             r3, r2, [r12]
        cmp               r3, #0x0
        itt               eq
        moveq             r1, #0x1
        bxeq              lr
        b                 0b
1:
        movs              r1, #0x0
        clrex
        bx                lr

asm_test::compare_exchange::u32::release_acquire:
        mov               r12, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               1f
        dmb               sy
0:
        strex             r3, r2, [r12]
        cmp               r3, #0x0
        itt               eq
        moveq             r1, #0x1
        bxeq              lr
        ldrex             r0, [r12]
        cmp               r0, r1
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange::u32::release_relaxed:
        mov               r12, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               1f
        dmb               sy
0:
        strex             r3, r2, [r12]
        cmp               r3, #0x0
        itt               eq
        moveq             r1, #0x1
        bxeq              lr
        ldrex             r0, [r12]
        cmp               r0, r1
        beq               0b
1:
        movs              r1, #0x0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               sy
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             sy
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               sy
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             sy
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               sy
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             sy
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               sy
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        dmbeq             sy
        moveq             r1, #0x1
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             sy
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        itt               eq
        moveq             r1, #0x1
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange_weak::u8::release_seqcst:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               sy
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        itt               eq
        moveq             r1, #0x1
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               sy
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             sy
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               sy
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        dmbeq             sy
        moveq             r1, #0x1
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u8::acquire_acquire:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             sy
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        dmbeq             sy
        moveq             r1, #0x1
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        itt               eq
        moveq             r1, #0x1
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        itt               eq
        moveq             r1, #0x1
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u8::release_acquire:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               sy
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        itt               eq
        moveq             r1, #0x1
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange_weak::u8::release_relaxed:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               sy
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        itt               eq
        moveq             r1, #0x1
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               sy
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             sy
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               sy
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             sy
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               sy
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             sy
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               sy
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        dmbeq             sy
        moveq             r1, #0x1
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             sy
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        itt               eq
        moveq             r1, #0x1
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange_weak::u16::release_seqcst:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               sy
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        itt               eq
        moveq             r1, #0x1
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               sy
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             sy
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               sy
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        dmbeq             sy
        moveq             r1, #0x1
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u16::acquire_acquire:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             sy
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        dmbeq             sy
        moveq             r1, #0x1
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        itt               eq
        moveq             r1, #0x1
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        itt               eq
        moveq             r1, #0x1
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u16::release_acquire:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               sy
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        itt               eq
        moveq             r1, #0x1
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange_weak::u16::release_relaxed:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               sy
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        itt               eq
        moveq             r1, #0x1
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        dmb               sy
        strex             r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             sy
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        dmb               sy
        strex             r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             sy
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        dmb               sy
        strex             r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             sy
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        dmb               sy
        strex             r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        dmbeq             sy
        moveq             r1, #0x1
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        strex             r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             sy
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        strex             r1, r2, [r3]
        cmp               r1, #0x0
        itt               eq
        moveq             r1, #0x1
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange_weak::u32::release_seqcst:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        dmb               sy
        strex             r1, r2, [r3]
        cmp               r1, #0x0
        itt               eq
        moveq             r1, #0x1
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        dmb               sy
        strex             r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             sy
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        dmb               sy
        strex             r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        dmbeq             sy
        moveq             r1, #0x1
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u32::acquire_acquire:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        strex             r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             sy
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        strex             r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        dmbeq             sy
        moveq             r1, #0x1
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        strex             r1, r2, [r3]
        cmp               r1, #0x0
        itt               eq
        moveq             r1, #0x1
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        strex             r1, r2, [r3]
        cmp               r1, #0x0
        itt               eq
        moveq             r1, #0x1
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u32::release_acquire:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        dmb               sy
        strex             r1, r2, [r3]
        cmp               r1, #0x0
        itt               eq
        moveq             r1, #0x1
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               sy
        bx                lr

asm_test::compare_exchange_weak::u32::release_relaxed:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        dmb               sy
        strex             r1, r2, [r3]
        cmp               r1, #0x0
        itt               eq
        moveq             r1, #0x1
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
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
        mov               r0, r2
        dmb               sy
        bx                lr

asm_test::swap::u8::seqcst:
        dmb               sy
0:
        ldrexb            r2, [r0]
        strexb            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        dmb               sy
        bx                lr

asm_test::swap::u8::acquire:
        mov               r2, r0
0:
        ldrexb            r0, [r2]
        strexb            r3, r1, [r2]
        cmp               r3, #0x0
        bne               0b
        dmb               sy
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
        mov               r0, r2
        dmb               sy
        bx                lr

asm_test::swap::u16::seqcst:
        dmb               sy
0:
        ldrexh            r2, [r0]
        strexh            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        dmb               sy
        bx                lr

asm_test::swap::u16::acquire:
        mov               r2, r0
0:
        ldrexh            r0, [r2]
        strexh            r3, r1, [r2]
        cmp               r3, #0x0
        bne               0b
        dmb               sy
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
        mov               r2, r0
        dmb               sy
0:
        ldrex             r0, [r2]
        strex             r3, r1, [r2]
        cmp               r3, #0x0
        bne               0b
        dmb               sy
        bx                lr

asm_test::swap::u32::seqcst:
        mov               r2, r0
        dmb               sy
0:
        ldrex             r0, [r2]
        strex             r3, r1, [r2]
        cmp               r3, #0x0
        bne               0b
        dmb               sy
        bx                lr

asm_test::swap::u32::acquire:
        mov               r2, r0
0:
        ldrex             r0, [r2]
        strex             r3, r1, [r2]
        cmp               r3, #0x0
        bne               0b
        dmb               sy
        bx                lr

asm_test::swap::u32::relaxed:
        mov               r2, r0
0:
        ldrex             r0, [r2]
        strex             r3, r1, [r2]
        cmp               r3, #0x0
        bne               0b
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
