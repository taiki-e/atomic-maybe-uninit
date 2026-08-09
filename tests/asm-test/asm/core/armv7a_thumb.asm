asm_test::compare_exchange::u8::acqrel_seqcst:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               ish
0:
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             ish
        bxeq              lr
        ldrexb            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               ish
        bx                lr

asm_test::compare_exchange::u8::seqcst_seqcst:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               ish
0:
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             ish
        bxeq              lr
        ldrexb            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               ish
        bx                lr

asm_test::compare_exchange::u8::acqrel_acquire:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               ish
0:
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             ish
        bxeq              lr
        ldrexb            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               ish
        bx                lr

asm_test::compare_exchange::u8::acqrel_relaxed:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               ish
0:
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        dmbeq             ish
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
        dmbeq             ish
        bxeq              lr
        b                 0b
1:
        clrex
        movs              r1, #0x0
        dmb               ish
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
        dmb               ish
        bx                lr

asm_test::compare_exchange::u8::release_seqcst:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               ish
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
        dmb               ish
        bx                lr

asm_test::compare_exchange::u8::seqcst_acquire:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               ish
0:
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             ish
        bxeq              lr
        ldrexb            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               ish
        bx                lr

asm_test::compare_exchange::u8::seqcst_relaxed:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               ish
0:
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        dmbeq             ish
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
        dmbeq             ish
        bxeq              lr
        b                 0b
1:
        clrex
        movs              r1, #0x0
        dmb               ish
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
        dmbeq             ish
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
        dmb               ish
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
        dmb               ish
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
        dmb               ish
        bx                lr

asm_test::compare_exchange::u8::release_relaxed:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               ish
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
        dmb               ish
0:
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             ish
        bxeq              lr
        ldrexh            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               ish
        bx                lr

asm_test::compare_exchange::u16::seqcst_seqcst:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               ish
0:
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             ish
        bxeq              lr
        ldrexh            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               ish
        bx                lr

asm_test::compare_exchange::u16::acqrel_acquire:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               ish
0:
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             ish
        bxeq              lr
        ldrexh            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               ish
        bx                lr

asm_test::compare_exchange::u16::acqrel_relaxed:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               ish
0:
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        dmbeq             ish
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
        dmbeq             ish
        bxeq              lr
        b                 0b
1:
        clrex
        movs              r1, #0x0
        dmb               ish
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
        dmb               ish
        bx                lr

asm_test::compare_exchange::u16::release_seqcst:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               ish
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
        dmb               ish
        bx                lr

asm_test::compare_exchange::u16::seqcst_acquire:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               ish
0:
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             ish
        bxeq              lr
        ldrexh            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               ish
        bx                lr

asm_test::compare_exchange::u16::seqcst_relaxed:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               ish
0:
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        dmbeq             ish
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
        dmbeq             ish
        bxeq              lr
        b                 0b
1:
        clrex
        movs              r1, #0x0
        dmb               ish
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
        dmbeq             ish
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
        dmb               ish
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
        dmb               ish
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
        dmb               ish
        bx                lr

asm_test::compare_exchange::u16::release_relaxed:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               ish
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
        dmb               ish
0:
        strex             r3, r2, [r12]
        cmp               r3, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             ish
        bxeq              lr
        ldrex             r0, [r12]
        cmp               r0, r1
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               ish
        bx                lr

asm_test::compare_exchange::u32::seqcst_seqcst:
        mov               r12, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               1f
        dmb               ish
0:
        strex             r3, r2, [r12]
        cmp               r3, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             ish
        bxeq              lr
        ldrex             r0, [r12]
        cmp               r0, r1
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               ish
        bx                lr

asm_test::compare_exchange::u32::acqrel_acquire:
        mov               r12, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               1f
        dmb               ish
0:
        strex             r3, r2, [r12]
        cmp               r3, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             ish
        bxeq              lr
        ldrex             r0, [r12]
        cmp               r0, r1
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               ish
        bx                lr

asm_test::compare_exchange::u32::acqrel_relaxed:
        mov               r12, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               1f
        dmb               ish
0:
        strex             r3, r2, [r12]
        cmp               r3, #0x0
        ittt              eq
        dmbeq             ish
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
        dmbeq             ish
        bxeq              lr
        b                 0b
1:
        clrex
        movs              r1, #0x0
        dmb               ish
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
        dmb               ish
        bx                lr

asm_test::compare_exchange::u32::release_seqcst:
        mov               r12, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               1f
        dmb               ish
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
        dmb               ish
        bx                lr

asm_test::compare_exchange::u32::seqcst_acquire:
        mov               r12, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               1f
        dmb               ish
0:
        strex             r3, r2, [r12]
        cmp               r3, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             ish
        bxeq              lr
        ldrex             r0, [r12]
        cmp               r0, r1
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               ish
        bx                lr

asm_test::compare_exchange::u32::seqcst_relaxed:
        mov               r12, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               1f
        dmb               ish
0:
        strex             r3, r2, [r12]
        cmp               r3, #0x0
        ittt              eq
        dmbeq             ish
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
        dmbeq             ish
        bxeq              lr
        b                 0b
1:
        clrex
        movs              r1, #0x0
        dmb               ish
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
        dmbeq             ish
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
        dmb               ish
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
        dmb               ish
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
        dmb               ish
        bx                lr

asm_test::compare_exchange::u32::release_relaxed:
        mov               r12, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               1f
        dmb               ish
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

asm_test::compare_exchange::u64::acqrel_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        ldrexd            r12, lr, [r1]
        eor.w             r4, lr, r3
        eor.w             r5, r12, r2
        orrs              r4, r5
        bne               1f
        ldrd              r5, r4, [sp, #24]
        dmb               ish
0:
        strexd            r6, r5, r4, [r1]
        cbz               r6, 2f
        ldrexd            r12, lr, [r1]
        eor.w             r6, lr, r3
        eor.w             r7, r12, r2
        orrs              r6, r7
        beq               0b
1:
        movs              r1, #0x0
        clrex
        b                 3f
2:
        movs              r1, #0x1
3:
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}

asm_test::compare_exchange::u64::seqcst_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        ldrexd            r12, lr, [r1]
        eor.w             r4, lr, r3
        eor.w             r5, r12, r2
        orrs              r4, r5
        bne               1f
        ldrd              r5, r4, [sp, #24]
        dmb               ish
0:
        strexd            r6, r5, r4, [r1]
        cbz               r6, 2f
        ldrexd            r12, lr, [r1]
        eor.w             r6, lr, r3
        eor.w             r7, r12, r2
        orrs              r6, r7
        beq               0b
1:
        movs              r1, #0x0
        clrex
        b                 3f
2:
        movs              r1, #0x1
3:
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}

asm_test::compare_exchange::u64::acqrel_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        ldrexd            r12, lr, [r1]
        eor.w             r4, lr, r3
        eor.w             r5, r12, r2
        orrs              r4, r5
        bne               1f
        ldrd              r5, r4, [sp, #24]
        dmb               ish
0:
        strexd            r6, r5, r4, [r1]
        cbz               r6, 2f
        ldrexd            r12, lr, [r1]
        eor.w             r6, lr, r3
        eor.w             r7, r12, r2
        orrs              r6, r7
        beq               0b
1:
        movs              r1, #0x0
        clrex
        b                 3f
2:
        movs              r1, #0x1
3:
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}

asm_test::compare_exchange::u64::acqrel_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        ldrexd            r12, lr, [r1]
        eor.w             r4, lr, r3
        eor.w             r5, r12, r2
        orrs              r4, r5
        bne               1f
        ldrd              r5, r4, [sp, #24]
        dmb               ish
0:
        strexd            r6, r5, r4, [r1]
        cbz               r6, 2f
        ldrexd            r12, lr, [r1]
        eor.w             r6, lr, r3
        eor.w             r7, r12, r2
        orrs              r6, r7
        beq               0b
1:
        movs              r1, #0x0
        clrex
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
2:
        dmb               ish
        movs              r1, #0x1
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}

asm_test::compare_exchange::u64::acquire_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        ldrd              r5, r4, [sp, #24]
0:
        ldrexd            r12, lr, [r1]
        eor.w             r6, lr, r3
        eor.w             r7, r12, r2
        orrs              r6, r7
        bne               2f
        strexd            r6, r5, r4, [r1]
        cmp               r6, #0x0
        bne               0b
        movs              r1, #0x1
1:
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
2:
        movs              r1, #0x0
        clrex
        b                 1b

asm_test::compare_exchange::u64::relaxed_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        ldrd              r5, r4, [sp, #24]
0:
        ldrexd            r12, lr, [r1]
        eor.w             r6, lr, r3
        eor.w             r7, r12, r2
        orrs              r6, r7
        bne               1f
        strexd            r6, r5, r4, [r1]
        cmp               r6, #0x0
        bne               0b
        movs              r1, #0x1
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
1:
        clrex
        movs              r1, #0x0
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}

asm_test::compare_exchange::u64::release_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        ldrexd            r12, lr, [r1]
        eor.w             r4, lr, r3
        eor.w             r5, r12, r2
        orrs              r4, r5
        bne               1f
        ldrd              r5, r4, [sp, #24]
        dmb               ish
0:
        strexd            r6, r5, r4, [r1]
        cbz               r6, 2f
        ldrexd            r12, lr, [r1]
        eor.w             r6, lr, r3
        eor.w             r7, r12, r2
        orrs              r6, r7
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
2:
        movs              r1, #0x1
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}

asm_test::compare_exchange::u64::seqcst_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        ldrexd            r12, lr, [r1]
        eor.w             r4, lr, r3
        eor.w             r5, r12, r2
        orrs              r4, r5
        bne               1f
        ldrd              r5, r4, [sp, #24]
        dmb               ish
0:
        strexd            r6, r5, r4, [r1]
        cbz               r6, 2f
        ldrexd            r12, lr, [r1]
        eor.w             r6, lr, r3
        eor.w             r7, r12, r2
        orrs              r6, r7
        beq               0b
1:
        movs              r1, #0x0
        clrex
        b                 3f
2:
        movs              r1, #0x1
3:
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}

asm_test::compare_exchange::u64::seqcst_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        ldrexd            r12, lr, [r1]
        eor.w             r4, lr, r3
        eor.w             r5, r12, r2
        orrs              r4, r5
        bne               1f
        ldrd              r5, r4, [sp, #24]
        dmb               ish
0:
        strexd            r6, r5, r4, [r1]
        cbz               r6, 2f
        ldrexd            r12, lr, [r1]
        eor.w             r6, lr, r3
        eor.w             r7, r12, r2
        orrs              r6, r7
        beq               0b
1:
        movs              r1, #0x0
        clrex
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
2:
        dmb               ish
        movs              r1, #0x1
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}

asm_test::compare_exchange::u64::acquire_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        ldrd              r5, r4, [sp, #24]
0:
        ldrexd            r12, lr, [r1]
        eor.w             r6, lr, r3
        eor.w             r7, r12, r2
        orrs              r6, r7
        bne               2f
        strexd            r6, r5, r4, [r1]
        cmp               r6, #0x0
        bne               0b
        movs              r1, #0x1
1:
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
2:
        movs              r1, #0x0
        clrex
        b                 1b

asm_test::compare_exchange::u64::acquire_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        ldrd              r5, r4, [sp, #24]
0:
        ldrexd            r12, lr, [r1]
        eor.w             r6, lr, r3
        eor.w             r7, r12, r2
        orrs              r6, r7
        bne               1f
        strexd            r6, r5, r4, [r1]
        cmp               r6, #0x0
        bne               0b
        dmb               ish
        movs              r1, #0x1
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
1:
        movs              r1, #0x0
        clrex
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}

asm_test::compare_exchange::u64::relaxed_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        ldrd              r5, r4, [sp, #24]
0:
        ldrexd            r12, lr, [r1]
        eor.w             r6, lr, r3
        eor.w             r7, r12, r2
        orrs              r6, r7
        bne               1f
        strexd            r6, r5, r4, [r1]
        cmp               r6, #0x0
        bne               0b
        movs              r1, #0x1
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
1:
        clrex
        movs              r1, #0x0
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}

asm_test::compare_exchange::u64::relaxed_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        ldrd              r5, r4, [sp, #24]
0:
        ldrexd            r12, lr, [r1]
        eor.w             r6, lr, r3
        eor.w             r7, r12, r2
        orrs              r6, r7
        bne               1f
        strexd            r6, r5, r4, [r1]
        cmp               r6, #0x0
        bne               0b
        movs              r1, #0x1
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
1:
        movs              r1, #0x0
        clrex
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}

asm_test::compare_exchange::u64::release_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        ldrexd            r12, lr, [r1]
        eor.w             r4, lr, r3
        eor.w             r5, r12, r2
        orrs              r4, r5
        bne               1f
        ldrd              r5, r4, [sp, #24]
        dmb               ish
0:
        strexd            r6, r5, r4, [r1]
        cbz               r6, 2f
        ldrexd            r12, lr, [r1]
        eor.w             r6, lr, r3
        eor.w             r7, r12, r2
        orrs              r6, r7
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
2:
        movs              r1, #0x1
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}

asm_test::compare_exchange::u64::release_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        ldrexd            r12, lr, [r1]
        eor.w             r4, lr, r3
        eor.w             r5, r12, r2
        orrs              r4, r5
        bne               1f
        ldrd              r5, r4, [sp, #24]
        dmb               ish
0:
        strexd            r6, r5, r4, [r1]
        cbz               r6, 2f
        ldrexd            r12, lr, [r1]
        eor.w             r6, lr, r3
        eor.w             r7, r12, r2
        orrs              r6, r7
        beq               0b
1:
        movs              r1, #0x0
        clrex
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
2:
        movs              r1, #0x1
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               ish
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             ish
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               ish
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             ish
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               ish
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             ish
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               ish
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        dmbeq             ish
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
        dmbeq             ish
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               ish
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
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u8::release_seqcst:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               ish
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
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               ish
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             ish
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               ish
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        dmbeq             ish
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
        dmbeq             ish
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               ish
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
        dmbeq             ish
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
        dmb               ish
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
        dmb               ish
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
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u8::release_relaxed:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               ish
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
        dmb               ish
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             ish
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               ish
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             ish
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               ish
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             ish
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               ish
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        dmbeq             ish
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
        dmbeq             ish
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               ish
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
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u16::release_seqcst:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               ish
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
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               ish
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             ish
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               ish
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        dmbeq             ish
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
        dmbeq             ish
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               ish
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
        dmbeq             ish
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
        dmb               ish
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
        dmb               ish
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
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u16::release_relaxed:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               ish
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
        dmb               ish
        strex             r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             ish
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        dmb               ish
        strex             r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             ish
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        dmb               ish
        strex             r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             ish
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        dmb               ish
        strex             r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        dmbeq             ish
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
        dmbeq             ish
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               ish
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
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u32::release_seqcst:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        dmb               ish
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
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        dmb               ish
        strex             r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        moveq             r1, #0x1
        dmbeq             ish
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        dmb               ish
        strex             r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        dmbeq             ish
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
        dmbeq             ish
        bxeq              lr
        b                 1f
0:
        clrex
1:
        movs              r1, #0x0
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        strex             r1, r2, [r3]
        cmp               r1, #0x0
        ittt              eq
        dmbeq             ish
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
        dmb               ish
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
        dmb               ish
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
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u32::release_relaxed:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        dmb               ish
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

asm_test::compare_exchange_weak::u64::acqrel_seqcst:
        push              {r4, lr}
        ldrexd            r12, lr, [r1]
        eor.w             r3, r3, lr
        eor.w             r2, r2, r12
        orrs              r2, r3
        bne               0f
        ldrd              r3, r2, [sp, #8]
        dmb               ish
        strexd            r4, r3, r2, [r1]
        cbnz              r4, 1f
        movs              r1, #0x1
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        pop               {r4, pc}
0:
        clrex
1:
        movs              r1, #0x0
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        pop               {r4, pc}

asm_test::compare_exchange_weak::u64::seqcst_seqcst:
        push              {r4, lr}
        ldrexd            r12, lr, [r1]
        eor.w             r3, r3, lr
        eor.w             r2, r2, r12
        orrs              r2, r3
        bne               0f
        ldrd              r3, r2, [sp, #8]
        dmb               ish
        strexd            r4, r3, r2, [r1]
        cbnz              r4, 1f
        movs              r1, #0x1
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        pop               {r4, pc}
0:
        clrex
1:
        movs              r1, #0x0
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        pop               {r4, pc}

asm_test::compare_exchange_weak::u64::acqrel_acquire:
        push              {r4, lr}
        ldrexd            r12, lr, [r1]
        eor.w             r3, r3, lr
        eor.w             r2, r2, r12
        orrs              r2, r3
        bne               0f
        ldrd              r3, r2, [sp, #8]
        dmb               ish
        strexd            r4, r3, r2, [r1]
        cbnz              r4, 1f
        movs              r1, #0x1
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        pop               {r4, pc}
0:
        clrex
1:
        movs              r1, #0x0
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        pop               {r4, pc}

asm_test::compare_exchange_weak::u64::acqrel_relaxed:
        push              {r4, lr}
        ldrexd            r12, lr, [r1]
        eor.w             r3, r3, lr
        eor.w             r2, r2, r12
        orrs              r2, r3
        bne               0f
        ldrd              r3, r2, [sp, #8]
        dmb               ish
        strexd            r4, r3, r2, [r1]
        cbnz              r4, 1f
        dmb               ish
        movs              r1, #0x1
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        pop               {r4, pc}
0:
        clrex
1:
        movs              r1, #0x0
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        pop               {r4, pc}

asm_test::compare_exchange_weak::u64::acquire_seqcst:
        push              {r4, lr}
        ldrexd            r12, lr, [r1]
        eor.w             r3, r3, lr
        eor.w             r2, r2, r12
        orrs              r2, r3
        bne               0f
        ldrd              r3, r2, [sp, #8]
        strexd            r4, r3, r2, [r1]
        cbnz              r4, 1f
        movs              r1, #0x1
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        pop               {r4, pc}
0:
        clrex
1:
        movs              r1, #0x0
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        pop               {r4, pc}

asm_test::compare_exchange_weak::u64::relaxed_seqcst:
        push              {r4, lr}
        ldrexd            r12, lr, [r1]
        eor.w             r3, r3, lr
        eor.w             r2, r2, r12
        orrs              r2, r3
        bne               0f
        ldrd              r3, r2, [sp, #8]
        strexd            r4, r3, r2, [r1]
        cbnz              r4, 1f
        movs              r1, #0x1
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        pop               {r4, pc}
0:
        clrex
1:
        movs              r1, #0x0
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        pop               {r4, pc}

asm_test::compare_exchange_weak::u64::release_seqcst:
        push              {r4, lr}
        ldrexd            r12, lr, [r1]
        eor.w             r3, r3, lr
        eor.w             r2, r2, r12
        orrs              r2, r3
        bne               0f
        ldrd              r3, r2, [sp, #8]
        dmb               ish
        strexd            r4, r3, r2, [r1]
        cbnz              r4, 1f
        movs              r1, #0x1
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        pop               {r4, pc}
0:
        clrex
1:
        movs              r1, #0x0
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        pop               {r4, pc}

asm_test::compare_exchange_weak::u64::seqcst_acquire:
        push              {r4, lr}
        ldrexd            r12, lr, [r1]
        eor.w             r3, r3, lr
        eor.w             r2, r2, r12
        orrs              r2, r3
        bne               0f
        ldrd              r3, r2, [sp, #8]
        dmb               ish
        strexd            r4, r3, r2, [r1]
        cbnz              r4, 1f
        movs              r1, #0x1
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        pop               {r4, pc}
0:
        clrex
1:
        movs              r1, #0x0
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        pop               {r4, pc}

asm_test::compare_exchange_weak::u64::seqcst_relaxed:
        push              {r4, lr}
        ldrexd            r12, lr, [r1]
        eor.w             r3, r3, lr
        eor.w             r2, r2, r12
        orrs              r2, r3
        bne               0f
        ldrd              r3, r2, [sp, #8]
        dmb               ish
        strexd            r4, r3, r2, [r1]
        cbnz              r4, 1f
        dmb               ish
        movs              r1, #0x1
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        pop               {r4, pc}
0:
        clrex
1:
        movs              r1, #0x0
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        pop               {r4, pc}

asm_test::compare_exchange_weak::u64::acquire_acquire:
        push              {r4, lr}
        ldrexd            r12, lr, [r1]
        eor.w             r3, r3, lr
        eor.w             r2, r2, r12
        orrs              r2, r3
        bne               0f
        ldrd              r3, r2, [sp, #8]
        strexd            r4, r3, r2, [r1]
        cbnz              r4, 1f
        movs              r1, #0x1
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        pop               {r4, pc}
0:
        clrex
1:
        movs              r1, #0x0
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        pop               {r4, pc}

asm_test::compare_exchange_weak::u64::acquire_relaxed:
        push              {r4, lr}
        ldrexd            r12, lr, [r1]
        eor.w             r3, r3, lr
        eor.w             r2, r2, r12
        orrs              r2, r3
        bne               0f
        ldrd              r3, r2, [sp, #8]
        strexd            r4, r3, r2, [r1]
        cbnz              r4, 1f
        dmb               ish
        movs              r1, #0x1
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        pop               {r4, pc}
0:
        clrex
1:
        movs              r1, #0x0
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        pop               {r4, pc}

asm_test::compare_exchange_weak::u64::relaxed_acquire:
        push              {r4, lr}
        ldrexd            r12, lr, [r1]
        eor.w             r3, r3, lr
        eor.w             r2, r2, r12
        orrs              r2, r3
        bne               0f
        ldrd              r3, r2, [sp, #8]
        strexd            r4, r3, r2, [r1]
        cbnz              r4, 1f
        movs              r1, #0x1
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        pop               {r4, pc}
0:
        clrex
1:
        movs              r1, #0x0
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        pop               {r4, pc}

asm_test::compare_exchange_weak::u64::relaxed_relaxed:
        push              {r4, lr}
        ldrexd            r12, lr, [r1]
        eor.w             r3, r3, lr
        eor.w             r2, r2, r12
        orrs              r2, r3
        bne               0f
        ldrd              r3, r2, [sp, #8]
        strexd            r4, r3, r2, [r1]
        cbnz              r4, 1f
        movs              r1, #0x1
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        pop               {r4, pc}
0:
        clrex
1:
        movs              r1, #0x0
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        pop               {r4, pc}

asm_test::compare_exchange_weak::u64::release_acquire:
        push              {r4, lr}
        ldrexd            r12, lr, [r1]
        eor.w             r3, r3, lr
        eor.w             r2, r2, r12
        orrs              r2, r3
        bne               0f
        ldrd              r3, r2, [sp, #8]
        dmb               ish
        strexd            r4, r3, r2, [r1]
        cbnz              r4, 1f
        movs              r1, #0x1
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        pop               {r4, pc}
0:
        clrex
1:
        movs              r1, #0x0
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        pop               {r4, pc}

asm_test::compare_exchange_weak::u64::release_relaxed:
        push              {r4, lr}
        ldrexd            r12, lr, [r1]
        eor.w             r3, r3, lr
        eor.w             r2, r2, r12
        orrs              r2, r3
        bne               0f
        ldrd              r3, r2, [sp, #8]
        dmb               ish
        strexd            r4, r3, r2, [r1]
        cbnz              r4, 1f
        movs              r1, #0x1
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        pop               {r4, pc}
0:
        clrex
1:
        movs              r1, #0x0
        strb              r1, [r0, #0x8]
        strd              r12, lr, [r0]
        pop               {r4, pc}

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
        clrex
        dmb               ish
        bx                lr

asm_test::load::u64::acquire:
        ldrexd            r0, r1, [r0]
        clrex
        dmb               ish
        bx                lr

asm_test::load::u64::relaxed:
        ldrexd            r0, r1, [r0]
        clrex
        bx                lr

asm_test::swap::u8::acqrel:
        dmb               ish
0:
        ldrexb            r2, [r0]
        strexb            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        dmb               ish
        bx                lr

asm_test::swap::u8::seqcst:
        dmb               ish
0:
        ldrexb            r2, [r0]
        strexb            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        dmb               ish
        bx                lr

asm_test::swap::u8::acquire:
        mov               r2, r0
0:
        ldrexb            r0, [r2]
        strexb            r3, r1, [r2]
        cmp               r3, #0x0
        bne               0b
        dmb               ish
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
        mov               r0, r2
        dmb               ish
        bx                lr

asm_test::swap::u16::seqcst:
        dmb               ish
0:
        ldrexh            r2, [r0]
        strexh            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        dmb               ish
        bx                lr

asm_test::swap::u16::acquire:
        mov               r2, r0
0:
        ldrexh            r0, [r2]
        strexh            r3, r1, [r2]
        cmp               r3, #0x0
        bne               0b
        dmb               ish
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
        mov               r2, r0
        dmb               ish
0:
        ldrex             r0, [r2]
        strex             r3, r1, [r2]
        cmp               r3, #0x0
        bne               0b
        dmb               ish
        bx                lr

asm_test::swap::u32::seqcst:
        mov               r2, r0
        dmb               ish
0:
        ldrex             r0, [r2]
        strex             r3, r1, [r2]
        cmp               r3, #0x0
        bne               0b
        dmb               ish
        bx                lr

asm_test::swap::u32::acquire:
        mov               r2, r0
0:
        ldrex             r0, [r2]
        strex             r3, r1, [r2]
        cmp               r3, #0x0
        bne               0b
        dmb               ish
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
        dmb               ish
0:
        ldrexd            r12, r1, [r0]
        strexd            lr, r2, r3, [r0]
        cmp.w             lr, #0x0
        bne               0b
        mov               r0, r12
        dmb               ish
        pop               {r7, pc}

asm_test::swap::u64::seqcst:
        push              {r7, lr}
        dmb               ish
0:
        ldrexd            r12, r1, [r0]
        strexd            lr, r2, r3, [r0]
        cmp.w             lr, #0x0
        bne               0b
        mov               r0, r12
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
0:
        ldrexd            r12, r1, [r0]
        strexd            lr, r2, r3, [r0]
        cmp.w             lr, #0x0
        bne               0b
        mov               r0, r12
        pop               {r7, pc}

asm_test::swap::u64::release:
        push              {r7, lr}
        dmb               ish
0:
        ldrexd            r12, r1, [r0]
        strexd            lr, r2, r3, [r0]
        cmp.w             lr, #0x0
        bne               0b
        mov               r0, r12
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
        dmb               ish
0:
        ldrexd            r1, r12, [r0]
        strexd            r1, r2, r3, [r0]
        cmp               r1, #0x0
        bne               0b
        dmb               ish
        bx                lr

asm_test::store::u64::relaxed:
0:
        ldrexd            r1, r12, [r0]
        strexd            r1, r2, r3, [r0]
        cmp               r1, #0x0
        bne               0b
        bx                lr

asm_test::store::u64::release:
        dmb               ish
0:
        ldrexd            r1, r12, [r0]
        strexd            r1, r2, r3, [r0]
        cmp               r1, #0x0
        bne               0b
        bx                lr
