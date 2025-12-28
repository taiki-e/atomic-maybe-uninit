asm_test::compare_exchange::u8::acqrel_seqcst:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r12, r1
        cmp               r0, r12
        bne               1f
        dmb               ish
0:
        strexb            r1, r2, [r3]
        cmp               r1, #0
        beq               2f
        ldrexb            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr
2:
        mov               r1, #1
        dmb               ish
        bx                lr

asm_test::compare_exchange::u8::seqcst_seqcst:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r12, r1
        cmp               r0, r12
        bne               1f
        dmb               ish
0:
        strexb            r1, r2, [r3]
        cmp               r1, #0
        beq               2f
        ldrexb            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr
2:
        mov               r1, #1
        dmb               ish
        bx                lr

asm_test::compare_exchange::u8::acqrel_acquire:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r12, r1
        cmp               r0, r12
        bne               1f
        dmb               ish
0:
        strexb            r1, r2, [r3]
        cmp               r1, #0
        beq               2f
        ldrexb            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr
2:
        mov               r1, #1
        dmb               ish
        bx                lr

asm_test::compare_exchange::u8::acqrel_relaxed:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r12, r1
        cmp               r0, r12
        bne               1f
        dmb               ish
0:
        strexb            r1, r2, [r3]
        cmp               r1, #0
        beq               2f
        ldrexb            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        mov               r1, #0
        clrex
        bx                lr
2:
        mov               r1, #1
        dmb               ish
        bx                lr

asm_test::compare_exchange::u8::acquire_seqcst:
        mov               r3, r0
        uxtb              r12, r1
0:
        ldrexb            r0, [r3]
        cmp               r0, r12
        bne               1f
        strexb            r1, r2, [r3]
        cmp               r1, #0
        bne               0b
        mov               r1, #1
        dmb               ish
        bx                lr
1:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr

asm_test::compare_exchange::u8::relaxed_seqcst:
        mov               r3, r0
        uxtb              r12, r1
0:
        ldrexb            r0, [r3]
        cmp               r0, r12
        bne               1f
        strexb            r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        b                 0b
1:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr

asm_test::compare_exchange::u8::release_seqcst:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r12, r1
        cmp               r0, r12
        bne               1f
        dmb               ish
0:
        strexb            r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        ldrexb            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr

asm_test::compare_exchange::u8::seqcst_acquire:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r12, r1
        cmp               r0, r12
        bne               1f
        dmb               ish
0:
        strexb            r1, r2, [r3]
        cmp               r1, #0
        beq               2f
        ldrexb            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr
2:
        mov               r1, #1
        dmb               ish
        bx                lr

asm_test::compare_exchange::u8::seqcst_relaxed:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r12, r1
        cmp               r0, r12
        bne               1f
        dmb               ish
0:
        strexb            r1, r2, [r3]
        cmp               r1, #0
        beq               2f
        ldrexb            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        mov               r1, #0
        clrex
        bx                lr
2:
        mov               r1, #1
        dmb               ish
        bx                lr

asm_test::compare_exchange::u8::acquire_acquire:
        mov               r3, r0
        uxtb              r12, r1
0:
        ldrexb            r0, [r3]
        cmp               r0, r12
        bne               1f
        strexb            r1, r2, [r3]
        cmp               r1, #0
        bne               0b
        mov               r1, #1
        dmb               ish
        bx                lr
1:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr

asm_test::compare_exchange::u8::acquire_relaxed:
        mov               r3, r0
        uxtb              r12, r1
0:
        ldrexb            r0, [r3]
        cmp               r0, r12
        bne               1f
        strexb            r1, r2, [r3]
        cmp               r1, #0
        bne               0b
        mov               r1, #1
        dmb               ish
        bx                lr
1:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange::u8::relaxed_acquire:
        mov               r3, r0
        uxtb              r12, r1
0:
        ldrexb            r0, [r3]
        cmp               r0, r12
        bne               1f
        strexb            r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        b                 0b
1:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr

asm_test::compare_exchange::u8::relaxed_relaxed:
        mov               r3, r0
        uxtb              r12, r1
0:
        ldrexb            r0, [r3]
        cmp               r0, r12
        bne               1f
        strexb            r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        b                 0b
1:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange::u8::release_acquire:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r12, r1
        cmp               r0, r12
        bne               1f
        dmb               ish
0:
        strexb            r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        ldrexb            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr

asm_test::compare_exchange::u8::release_relaxed:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r12, r1
        cmp               r0, r12
        bne               1f
        dmb               ish
0:
        strexb            r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        ldrexb            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange::u16::acqrel_seqcst:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r12, r1
        cmp               r0, r12
        bne               1f
        dmb               ish
0:
        strexh            r1, r2, [r3]
        cmp               r1, #0
        beq               2f
        ldrexh            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr
2:
        mov               r1, #1
        dmb               ish
        bx                lr

asm_test::compare_exchange::u16::seqcst_seqcst:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r12, r1
        cmp               r0, r12
        bne               1f
        dmb               ish
0:
        strexh            r1, r2, [r3]
        cmp               r1, #0
        beq               2f
        ldrexh            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr
2:
        mov               r1, #1
        dmb               ish
        bx                lr

asm_test::compare_exchange::u16::acqrel_acquire:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r12, r1
        cmp               r0, r12
        bne               1f
        dmb               ish
0:
        strexh            r1, r2, [r3]
        cmp               r1, #0
        beq               2f
        ldrexh            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr
2:
        mov               r1, #1
        dmb               ish
        bx                lr

asm_test::compare_exchange::u16::acqrel_relaxed:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r12, r1
        cmp               r0, r12
        bne               1f
        dmb               ish
0:
        strexh            r1, r2, [r3]
        cmp               r1, #0
        beq               2f
        ldrexh            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        mov               r1, #0
        clrex
        bx                lr
2:
        mov               r1, #1
        dmb               ish
        bx                lr

asm_test::compare_exchange::u16::acquire_seqcst:
        mov               r3, r0
        uxth              r12, r1
0:
        ldrexh            r0, [r3]
        cmp               r0, r12
        bne               1f
        strexh            r1, r2, [r3]
        cmp               r1, #0
        bne               0b
        mov               r1, #1
        dmb               ish
        bx                lr
1:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr

asm_test::compare_exchange::u16::relaxed_seqcst:
        mov               r3, r0
        uxth              r12, r1
0:
        ldrexh            r0, [r3]
        cmp               r0, r12
        bne               1f
        strexh            r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        b                 0b
1:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr

asm_test::compare_exchange::u16::release_seqcst:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r12, r1
        cmp               r0, r12
        bne               1f
        dmb               ish
0:
        strexh            r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        ldrexh            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr

asm_test::compare_exchange::u16::seqcst_acquire:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r12, r1
        cmp               r0, r12
        bne               1f
        dmb               ish
0:
        strexh            r1, r2, [r3]
        cmp               r1, #0
        beq               2f
        ldrexh            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr
2:
        mov               r1, #1
        dmb               ish
        bx                lr

asm_test::compare_exchange::u16::seqcst_relaxed:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r12, r1
        cmp               r0, r12
        bne               1f
        dmb               ish
0:
        strexh            r1, r2, [r3]
        cmp               r1, #0
        beq               2f
        ldrexh            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        mov               r1, #0
        clrex
        bx                lr
2:
        mov               r1, #1
        dmb               ish
        bx                lr

asm_test::compare_exchange::u16::acquire_acquire:
        mov               r3, r0
        uxth              r12, r1
0:
        ldrexh            r0, [r3]
        cmp               r0, r12
        bne               1f
        strexh            r1, r2, [r3]
        cmp               r1, #0
        bne               0b
        mov               r1, #1
        dmb               ish
        bx                lr
1:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr

asm_test::compare_exchange::u16::acquire_relaxed:
        mov               r3, r0
        uxth              r12, r1
0:
        ldrexh            r0, [r3]
        cmp               r0, r12
        bne               1f
        strexh            r1, r2, [r3]
        cmp               r1, #0
        bne               0b
        mov               r1, #1
        dmb               ish
        bx                lr
1:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange::u16::relaxed_acquire:
        mov               r3, r0
        uxth              r12, r1
0:
        ldrexh            r0, [r3]
        cmp               r0, r12
        bne               1f
        strexh            r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        b                 0b
1:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr

asm_test::compare_exchange::u16::relaxed_relaxed:
        mov               r3, r0
        uxth              r12, r1
0:
        ldrexh            r0, [r3]
        cmp               r0, r12
        bne               1f
        strexh            r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        b                 0b
1:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange::u16::release_acquire:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r12, r1
        cmp               r0, r12
        bne               1f
        dmb               ish
0:
        strexh            r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        ldrexh            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr

asm_test::compare_exchange::u16::release_relaxed:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r12, r1
        cmp               r0, r12
        bne               1f
        dmb               ish
0:
        strexh            r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        ldrexh            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        mov               r1, #0
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
        cmp               r3, #0
        beq               2f
        ldrex             r0, [r12]
        cmp               r0, r1
        beq               0b
1:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr
2:
        mov               r1, #1
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
        cmp               r3, #0
        beq               2f
        ldrex             r0, [r12]
        cmp               r0, r1
        beq               0b
1:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr
2:
        mov               r1, #1
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
        cmp               r3, #0
        beq               2f
        ldrex             r0, [r12]
        cmp               r0, r1
        beq               0b
1:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr
2:
        mov               r1, #1
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
        cmp               r3, #0
        beq               2f
        ldrex             r0, [r12]
        cmp               r0, r1
        beq               0b
1:
        mov               r1, #0
        clrex
        bx                lr
2:
        mov               r1, #1
        dmb               ish
        bx                lr

asm_test::compare_exchange::u32::acquire_seqcst:
        mov               r12, r0
0:
        ldrex             r0, [r12]
        cmp               r0, r1
        bne               1f
        strex             r3, r2, [r12]
        cmp               r3, #0
        bne               0b
        mov               r1, #1
        dmb               ish
        bx                lr
1:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr

asm_test::compare_exchange::u32::relaxed_seqcst:
        mov               r12, r0
0:
        ldrex             r0, [r12]
        cmp               r0, r1
        bne               1f
        strex             r3, r2, [r12]
        cmp               r3, #0
        moveq             r1, #1
        bxeq              lr
        b                 0b
1:
        clrex
        mov               r1, #0
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
        cmp               r3, #0
        moveq             r1, #1
        bxeq              lr
        ldrex             r0, [r12]
        cmp               r0, r1
        beq               0b
1:
        clrex
        mov               r1, #0
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
        cmp               r3, #0
        beq               2f
        ldrex             r0, [r12]
        cmp               r0, r1
        beq               0b
1:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr
2:
        mov               r1, #1
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
        cmp               r3, #0
        beq               2f
        ldrex             r0, [r12]
        cmp               r0, r1
        beq               0b
1:
        mov               r1, #0
        clrex
        bx                lr
2:
        mov               r1, #1
        dmb               ish
        bx                lr

asm_test::compare_exchange::u32::acquire_acquire:
        mov               r12, r0
0:
        ldrex             r0, [r12]
        cmp               r0, r1
        bne               1f
        strex             r3, r2, [r12]
        cmp               r3, #0
        bne               0b
        mov               r1, #1
        dmb               ish
        bx                lr
1:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr

asm_test::compare_exchange::u32::acquire_relaxed:
        mov               r12, r0
0:
        ldrex             r0, [r12]
        cmp               r0, r1
        bne               1f
        strex             r3, r2, [r12]
        cmp               r3, #0
        bne               0b
        mov               r1, #1
        dmb               ish
        bx                lr
1:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange::u32::relaxed_acquire:
        mov               r12, r0
0:
        ldrex             r0, [r12]
        cmp               r0, r1
        bne               1f
        strex             r3, r2, [r12]
        cmp               r3, #0
        moveq             r1, #1
        bxeq              lr
        b                 0b
1:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr

asm_test::compare_exchange::u32::relaxed_relaxed:
        mov               r12, r0
0:
        ldrex             r0, [r12]
        cmp               r0, r1
        bne               1f
        strex             r3, r2, [r12]
        cmp               r3, #0
        moveq             r1, #1
        bxeq              lr
        b                 0b
1:
        mov               r1, #0
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
        cmp               r3, #0
        moveq             r1, #1
        bxeq              lr
        ldrex             r0, [r12]
        cmp               r0, r1
        beq               0b
1:
        clrex
        mov               r1, #0
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
        cmp               r3, #0
        moveq             r1, #1
        bxeq              lr
        ldrex             r0, [r12]
        cmp               r0, r1
        beq               0b
1:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange::u64::acqrel_seqcst:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        ldrexd            r4, r5, [r1]
        eor               r7, r5, r3
        eor               r6, r4, r2
        orrs              r7, r6, r7
        bne               1f
        ldr               r9, [sp, #0x24]
        dmb               ish
        ldr               r8, [sp, #0x20]
0:
        strexd            r6, r8, r9, [r1]
        cmp               r6, #0
        beq               2f
        ldrexd            r4, r5, [r1]
        eor               r7, r5, r3
        eor               r6, r4, r2
        orrs              r7, r6, r7
        beq               0b
1:
        mov               r1, #0
        clrex
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
2:
        mov               r1, #1
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}

asm_test::compare_exchange::u64::seqcst_seqcst:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        ldrexd            r4, r5, [r1]
        eor               r7, r5, r3
        eor               r6, r4, r2
        orrs              r7, r6, r7
        bne               1f
        ldr               r9, [sp, #0x24]
        dmb               ish
        ldr               r8, [sp, #0x20]
0:
        strexd            r6, r8, r9, [r1]
        cmp               r6, #0
        beq               2f
        ldrexd            r4, r5, [r1]
        eor               r7, r5, r3
        eor               r6, r4, r2
        orrs              r7, r6, r7
        beq               0b
1:
        mov               r1, #0
        clrex
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
2:
        mov               r1, #1
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}

asm_test::compare_exchange::u64::acqrel_acquire:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        ldrexd            r4, r5, [r1]
        eor               r7, r5, r3
        eor               r6, r4, r2
        orrs              r7, r6, r7
        bne               1f
        ldr               r9, [sp, #0x24]
        dmb               ish
        ldr               r8, [sp, #0x20]
0:
        strexd            r6, r8, r9, [r1]
        cmp               r6, #0
        beq               2f
        ldrexd            r4, r5, [r1]
        eor               r7, r5, r3
        eor               r6, r4, r2
        orrs              r7, r6, r7
        beq               0b
1:
        mov               r1, #0
        clrex
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
2:
        mov               r1, #1
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}

asm_test::compare_exchange::u64::acqrel_relaxed:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        ldrexd            r4, r5, [r1]
        eor               r7, r5, r3
        eor               r6, r4, r2
        orrs              r7, r6, r7
        bne               1f
        ldr               r9, [sp, #0x24]
        dmb               ish
        ldr               r8, [sp, #0x20]
0:
        strexd            r6, r8, r9, [r1]
        cmp               r6, #0
        beq               2f
        ldrexd            r4, r5, [r1]
        eor               r7, r5, r3
        eor               r6, r4, r2
        orrs              r7, r6, r7
        beq               0b
1:
        mov               r1, #0
        clrex
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
2:
        dmb               ish
        mov               r1, #1
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}

asm_test::compare_exchange::u64::acquire_seqcst:
        push              {r4, r5, r6, r8, r9, lr}
        ldr               r9, [sp, #0x1c]
        ldr               r8, [sp, #0x18]
0:
        ldrexd            r4, r5, [r1]
        eor               r12, r5, r3
        eor               r6, r4, r2
        orrs              r6, r6, r12
        bne               1f
        strexd            r6, r8, r9, [r1]
        cmp               r6, #0
        bne               0b
        mov               r1, #1
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r8, r9, pc}
1:
        mov               r1, #0
        clrex
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r8, r9, pc}

asm_test::compare_exchange::u64::relaxed_seqcst:
        push              {r4, r5, r6, r8, r9, lr}
        ldr               r9, [sp, #0x1c]
        ldr               r8, [sp, #0x18]
0:
        ldrexd            r4, r5, [r1]
        eor               r12, r5, r3
        eor               r6, r4, r2
        orrs              r6, r6, r12
        bne               1f
        strexd            r6, r8, r9, [r1]
        cmp               r6, #0
        bne               0b
        mov               r1, #1
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r8, r9, pc}
1:
        clrex
        mov               r1, #0
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r8, r9, pc}

asm_test::compare_exchange::u64::release_seqcst:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        ldrexd            r4, r5, [r1]
        eor               r7, r5, r3
        eor               r6, r4, r2
        orrs              r7, r6, r7
        bne               1f
        ldr               r9, [sp, #0x24]
        dmb               ish
        ldr               r8, [sp, #0x20]
0:
        strexd            r6, r8, r9, [r1]
        cmp               r6, #0
        beq               2f
        ldrexd            r4, r5, [r1]
        eor               r7, r5, r3
        eor               r6, r4, r2
        orrs              r7, r6, r7
        beq               0b
1:
        clrex
        mov               r1, #0
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
2:
        mov               r1, #1
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}

asm_test::compare_exchange::u64::seqcst_acquire:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        ldrexd            r4, r5, [r1]
        eor               r7, r5, r3
        eor               r6, r4, r2
        orrs              r7, r6, r7
        bne               1f
        ldr               r9, [sp, #0x24]
        dmb               ish
        ldr               r8, [sp, #0x20]
0:
        strexd            r6, r8, r9, [r1]
        cmp               r6, #0
        beq               2f
        ldrexd            r4, r5, [r1]
        eor               r7, r5, r3
        eor               r6, r4, r2
        orrs              r7, r6, r7
        beq               0b
1:
        mov               r1, #0
        clrex
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
2:
        mov               r1, #1
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}

asm_test::compare_exchange::u64::seqcst_relaxed:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        ldrexd            r4, r5, [r1]
        eor               r7, r5, r3
        eor               r6, r4, r2
        orrs              r7, r6, r7
        bne               1f
        ldr               r9, [sp, #0x24]
        dmb               ish
        ldr               r8, [sp, #0x20]
0:
        strexd            r6, r8, r9, [r1]
        cmp               r6, #0
        beq               2f
        ldrexd            r4, r5, [r1]
        eor               r7, r5, r3
        eor               r6, r4, r2
        orrs              r7, r6, r7
        beq               0b
1:
        mov               r1, #0
        clrex
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
2:
        dmb               ish
        mov               r1, #1
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}

asm_test::compare_exchange::u64::acquire_acquire:
        push              {r4, r5, r6, r8, r9, lr}
        ldr               r9, [sp, #0x1c]
        ldr               r8, [sp, #0x18]
0:
        ldrexd            r4, r5, [r1]
        eor               r12, r5, r3
        eor               r6, r4, r2
        orrs              r6, r6, r12
        bne               1f
        strexd            r6, r8, r9, [r1]
        cmp               r6, #0
        bne               0b
        mov               r1, #1
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r8, r9, pc}
1:
        mov               r1, #0
        clrex
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r8, r9, pc}

asm_test::compare_exchange::u64::acquire_relaxed:
        push              {r4, r5, r6, r8, r9, lr}
        ldr               r9, [sp, #0x1c]
        ldr               r8, [sp, #0x18]
0:
        ldrexd            r4, r5, [r1]
        eor               r12, r5, r3
        eor               r6, r4, r2
        orrs              r6, r6, r12
        bne               1f
        strexd            r6, r8, r9, [r1]
        cmp               r6, #0
        bne               0b
        dmb               ish
        mov               r1, #1
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r8, r9, pc}
1:
        mov               r1, #0
        clrex
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r8, r9, pc}

asm_test::compare_exchange::u64::relaxed_acquire:
        push              {r4, r5, r6, r8, r9, lr}
        ldr               r9, [sp, #0x1c]
        ldr               r8, [sp, #0x18]
0:
        ldrexd            r4, r5, [r1]
        eor               r12, r5, r3
        eor               r6, r4, r2
        orrs              r6, r6, r12
        bne               1f
        strexd            r6, r8, r9, [r1]
        cmp               r6, #0
        bne               0b
        mov               r1, #1
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r8, r9, pc}
1:
        clrex
        mov               r1, #0
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r8, r9, pc}

asm_test::compare_exchange::u64::relaxed_relaxed:
        push              {r4, r5, r6, r8, r9, lr}
        ldr               r9, [sp, #0x1c]
        ldr               r8, [sp, #0x18]
0:
        ldrexd            r4, r5, [r1]
        eor               r12, r5, r3
        eor               r6, r4, r2
        orrs              r6, r6, r12
        bne               1f
        strexd            r6, r8, r9, [r1]
        cmp               r6, #0
        bne               0b
        mov               r1, #1
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r8, r9, pc}
1:
        mov               r1, #0
        clrex
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r8, r9, pc}

asm_test::compare_exchange::u64::release_acquire:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        ldrexd            r4, r5, [r1]
        eor               r7, r5, r3
        eor               r6, r4, r2
        orrs              r7, r6, r7
        bne               1f
        ldr               r9, [sp, #0x24]
        dmb               ish
        ldr               r8, [sp, #0x20]
0:
        strexd            r6, r8, r9, [r1]
        cmp               r6, #0
        beq               2f
        ldrexd            r4, r5, [r1]
        eor               r7, r5, r3
        eor               r6, r4, r2
        orrs              r7, r6, r7
        beq               0b
1:
        clrex
        mov               r1, #0
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
2:
        mov               r1, #1
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}

asm_test::compare_exchange::u64::release_relaxed:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        ldrexd            r4, r5, [r1]
        eor               r7, r5, r3
        eor               r6, r4, r2
        orrs              r7, r6, r7
        bne               1f
        ldr               r9, [sp, #0x24]
        dmb               ish
        ldr               r8, [sp, #0x20]
0:
        strexd            r6, r8, r9, [r1]
        cmp               r6, #0
        beq               2f
        ldrexd            r4, r5, [r1]
        eor               r7, r5, r3
        eor               r6, r4, r2
        orrs              r7, r6, r7
        beq               0b
1:
        mov               r1, #0
        clrex
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
2:
        mov               r1, #1
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               ish
        mov               r1, #0
        strexb            r12, r2, [r3]
        dmb               ish
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               ish
        mov               r1, #0
        strexb            r12, r2, [r3]
        dmb               ish
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               ish
        mov               r1, #0
        strexb            r12, r2, [r3]
        dmb               ish
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               ish
        mov               r1, #0
        strexb            r12, r2, [r3]
        cmp               r12, #0
        bxne              lr
        mov               r1, #1
        dmb               ish
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        strexb            r12, r2, [r3]
        mov               r1, #0
        dmb               ish
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        strexb            r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        mov               r1, #0
        dmb               ish
        bx                lr
0:
        clrex
        mov               r1, #0
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
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        mov               r1, #0
        dmb               ish
        bx                lr
0:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               ish
        mov               r1, #0
        strexb            r12, r2, [r3]
        dmb               ish
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               ish
        mov               r1, #0
        strexb            r12, r2, [r3]
        cmp               r12, #0
        bxne              lr
        mov               r1, #1
        dmb               ish
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u8::acquire_acquire:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        strexb            r12, r2, [r3]
        mov               r1, #0
        dmb               ish
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        strexb            r12, r2, [r3]
        mov               r1, #0
        cmp               r12, #0
        bxne              lr
        mov               r1, #1
        dmb               ish
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        strexb            r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        mov               r1, #0
        dmb               ish
        bx                lr
0:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        strexb            r12, r2, [r3]
        mov               r1, #0
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u8::release_acquire:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               ish
        strexb            r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        mov               r1, #0
        dmb               ish
        bx                lr
0:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u8::release_relaxed:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               ish
        mov               r1, #0
        strexb            r12, r2, [r3]
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               ish
        mov               r1, #0
        strexh            r12, r2, [r3]
        dmb               ish
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               ish
        mov               r1, #0
        strexh            r12, r2, [r3]
        dmb               ish
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               ish
        mov               r1, #0
        strexh            r12, r2, [r3]
        dmb               ish
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               ish
        mov               r1, #0
        strexh            r12, r2, [r3]
        cmp               r12, #0
        bxne              lr
        mov               r1, #1
        dmb               ish
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        strexh            r12, r2, [r3]
        mov               r1, #0
        dmb               ish
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        strexh            r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        mov               r1, #0
        dmb               ish
        bx                lr
0:
        clrex
        mov               r1, #0
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
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        mov               r1, #0
        dmb               ish
        bx                lr
0:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               ish
        mov               r1, #0
        strexh            r12, r2, [r3]
        dmb               ish
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               ish
        mov               r1, #0
        strexh            r12, r2, [r3]
        cmp               r12, #0
        bxne              lr
        mov               r1, #1
        dmb               ish
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u16::acquire_acquire:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        strexh            r12, r2, [r3]
        mov               r1, #0
        dmb               ish
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        strexh            r12, r2, [r3]
        mov               r1, #0
        cmp               r12, #0
        bxne              lr
        mov               r1, #1
        dmb               ish
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        strexh            r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        mov               r1, #0
        dmb               ish
        bx                lr
0:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        strexh            r12, r2, [r3]
        mov               r1, #0
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u16::release_acquire:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               ish
        strexh            r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        mov               r1, #0
        dmb               ish
        bx                lr
0:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u16::release_relaxed:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               ish
        mov               r1, #0
        strexh            r12, r2, [r3]
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        dmb               ish
        mov               r1, #0
        strex             r12, r2, [r3]
        dmb               ish
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        dmb               ish
        mov               r1, #0
        strex             r12, r2, [r3]
        dmb               ish
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        dmb               ish
        mov               r1, #0
        strex             r12, r2, [r3]
        dmb               ish
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        dmb               ish
        mov               r1, #0
        strex             r12, r2, [r3]
        cmp               r12, #0
        bxne              lr
        mov               r1, #1
        dmb               ish
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        strex             r12, r2, [r3]
        mov               r1, #0
        dmb               ish
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        strex             r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        mov               r1, #0
        dmb               ish
        bx                lr
0:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u32::release_seqcst:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        dmb               ish
        strex             r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        mov               r1, #0
        dmb               ish
        bx                lr
0:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        dmb               ish
        mov               r1, #0
        strex             r12, r2, [r3]
        dmb               ish
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        dmb               ish
        mov               r1, #0
        strex             r12, r2, [r3]
        cmp               r12, #0
        bxne              lr
        mov               r1, #1
        dmb               ish
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u32::acquire_acquire:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        strex             r12, r2, [r3]
        mov               r1, #0
        dmb               ish
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        strex             r12, r2, [r3]
        mov               r1, #0
        cmp               r12, #0
        bxne              lr
        mov               r1, #1
        dmb               ish
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        strex             r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        mov               r1, #0
        dmb               ish
        bx                lr
0:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        strex             r12, r2, [r3]
        mov               r1, #0
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u32::release_acquire:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        dmb               ish
        strex             r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        mov               r1, #0
        dmb               ish
        bx                lr
0:
        clrex
        mov               r1, #0
        dmb               ish
        bx                lr

asm_test::compare_exchange_weak::u32::release_relaxed:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        dmb               ish
        mov               r1, #0
        strex             r12, r2, [r3]
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u64::acqrel_seqcst:
        push              {r4, r5, r11, lr}
        ldrexd            r4, r5, [r1]
        eor               r3, r5, r3
        eor               r2, r4, r2
        orrs              r2, r2, r3
        bne               0f
        ldr               r3, [sp, #0x14]
        dmb               ish
        ldr               r2, [sp, #0x10]
        strexd            r12, r2, r3, [r1]
        mov               r1, #0
        cmp               r12, #0
        mvneq             r1, #0
        b                 1f
0:
        mov               r1, #0
        clrex
1:
        dmb               ish
        and               r1, r1, #1
        strd              r4, r5, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r11, pc}

asm_test::compare_exchange_weak::u64::seqcst_seqcst:
        push              {r4, r5, r11, lr}
        ldrexd            r4, r5, [r1]
        eor               r3, r5, r3
        eor               r2, r4, r2
        orrs              r2, r2, r3
        bne               0f
        ldr               r3, [sp, #0x14]
        dmb               ish
        ldr               r2, [sp, #0x10]
        strexd            r12, r2, r3, [r1]
        mov               r1, #0
        cmp               r12, #0
        mvneq             r1, #0
        b                 1f
0:
        mov               r1, #0
        clrex
1:
        dmb               ish
        and               r1, r1, #1
        strd              r4, r5, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r11, pc}

asm_test::compare_exchange_weak::u64::acqrel_acquire:
        push              {r4, r5, r11, lr}
        ldrexd            r4, r5, [r1]
        eor               r3, r5, r3
        eor               r2, r4, r2
        orrs              r2, r2, r3
        bne               0f
        ldr               r3, [sp, #0x14]
        dmb               ish
        ldr               r2, [sp, #0x10]
        strexd            r12, r2, r3, [r1]
        mov               r1, #0
        cmp               r12, #0
        mvneq             r1, #0
        b                 1f
0:
        mov               r1, #0
        clrex
1:
        dmb               ish
        and               r1, r1, #1
        strd              r4, r5, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r11, pc}

asm_test::compare_exchange_weak::u64::acqrel_relaxed:
        push              {r4, r5, r11, lr}
        ldrexd            r4, r5, [r1]
        eor               r3, r5, r3
        eor               r2, r4, r2
        orrs              r2, r2, r3
        bne               0f
        ldr               r3, [sp, #0x14]
        dmb               ish
        ldr               r2, [sp, #0x10]
        strexd            r12, r2, r3, [r1]
        mov               r1, #0
        cmp               r12, #0
        beq               1f
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r11, pc}
0:
        mov               r1, #0
        clrex
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r11, pc}
1:
        dmb               ish
        mov               r1, #1
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r11, pc}

asm_test::compare_exchange_weak::u64::acquire_seqcst:
        push              {r4, r5, r11, lr}
        ldrexd            r4, r5, [r1]
        eor               r3, r5, r3
        eor               r2, r4, r2
        orrs              r2, r2, r3
        bne               0f
        ldr               r3, [sp, #0x14]
        ldr               r2, [sp, #0x10]
        strexd            r12, r2, r3, [r1]
        mov               r1, #0
        cmp               r12, #0
        mvneq             r1, #0
        b                 1f
0:
        mov               r1, #0
        clrex
1:
        dmb               ish
        and               r1, r1, #1
        strd              r4, r5, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r11, pc}

asm_test::compare_exchange_weak::u64::relaxed_seqcst:
        push              {r4, r6, r7, lr}
        ldrexd            r6, r7, [r1]
        eor               r3, r7, r3
        eor               r2, r6, r2
        orrs              r2, r2, r3
        bne               0f
        ldr               r3, [sp, #0x14]
        ldr               r2, [sp, #0x10]
        strexd            r4, r2, r3, [r1]
        cmp               r4, #0
        bne               1f
        mov               r1, #1
        strb              r1, [r0, #0x8]
        strd              r6, r7, [r0]
        pop               {r4, r6, r7, pc}
0:
        clrex
1:
        mov               r1, #0
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r6, r7, [r0]
        pop               {r4, r6, r7, pc}

asm_test::compare_exchange_weak::u64::release_seqcst:
        push              {r4, r5, r6, r7, r11, lr}
        ldrexd            r4, r5, [r1]
        eor               r3, r5, r3
        eor               r2, r4, r2
        orrs              r2, r2, r3
        bne               0f
        ldr               r7, [sp, #0x1c]
        dmb               ish
        ldr               r6, [sp, #0x18]
        strexd            r2, r6, r7, [r1]
        cmp               r2, #0
        bne               1f
        mov               r1, #1
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r7, r11, pc}
0:
        clrex
1:
        mov               r1, #0
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r7, r11, pc}

asm_test::compare_exchange_weak::u64::seqcst_acquire:
        push              {r4, r5, r11, lr}
        ldrexd            r4, r5, [r1]
        eor               r3, r5, r3
        eor               r2, r4, r2
        orrs              r2, r2, r3
        bne               0f
        ldr               r3, [sp, #0x14]
        dmb               ish
        ldr               r2, [sp, #0x10]
        strexd            r12, r2, r3, [r1]
        mov               r1, #0
        cmp               r12, #0
        mvneq             r1, #0
        b                 1f
0:
        mov               r1, #0
        clrex
1:
        dmb               ish
        and               r1, r1, #1
        strd              r4, r5, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r11, pc}

asm_test::compare_exchange_weak::u64::seqcst_relaxed:
        push              {r4, r5, r11, lr}
        ldrexd            r4, r5, [r1]
        eor               r3, r5, r3
        eor               r2, r4, r2
        orrs              r2, r2, r3
        bne               0f
        ldr               r3, [sp, #0x14]
        dmb               ish
        ldr               r2, [sp, #0x10]
        strexd            r12, r2, r3, [r1]
        mov               r1, #0
        cmp               r12, #0
        beq               1f
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r11, pc}
0:
        mov               r1, #0
        clrex
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r11, pc}
1:
        dmb               ish
        mov               r1, #1
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r11, pc}

asm_test::compare_exchange_weak::u64::acquire_acquire:
        push              {r4, r5, r11, lr}
        ldrexd            r4, r5, [r1]
        eor               r3, r5, r3
        eor               r2, r4, r2
        orrs              r2, r2, r3
        bne               0f
        ldr               r3, [sp, #0x14]
        ldr               r2, [sp, #0x10]
        strexd            r12, r2, r3, [r1]
        mov               r1, #0
        cmp               r12, #0
        mvneq             r1, #0
        b                 1f
0:
        mov               r1, #0
        clrex
1:
        dmb               ish
        and               r1, r1, #1
        strd              r4, r5, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r11, pc}

asm_test::compare_exchange_weak::u64::acquire_relaxed:
        push              {r4, r5, r11, lr}
        ldrexd            r4, r5, [r1]
        eor               r3, r5, r3
        eor               r2, r4, r2
        orrs              r2, r2, r3
        bne               0f
        ldr               r3, [sp, #0x14]
        ldr               r2, [sp, #0x10]
        strexd            r12, r2, r3, [r1]
        mov               r1, #0
        cmp               r12, #0
        beq               1f
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r11, pc}
0:
        mov               r1, #0
        clrex
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r11, pc}
1:
        dmb               ish
        mov               r1, #1
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r11, pc}

asm_test::compare_exchange_weak::u64::relaxed_acquire:
        push              {r4, r6, r7, lr}
        ldrexd            r6, r7, [r1]
        eor               r3, r7, r3
        eor               r2, r6, r2
        orrs              r2, r2, r3
        bne               0f
        ldr               r3, [sp, #0x14]
        ldr               r2, [sp, #0x10]
        strexd            r4, r2, r3, [r1]
        cmp               r4, #0
        bne               1f
        mov               r1, #1
        strb              r1, [r0, #0x8]
        strd              r6, r7, [r0]
        pop               {r4, r6, r7, pc}
0:
        clrex
1:
        mov               r1, #0
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r6, r7, [r0]
        pop               {r4, r6, r7, pc}

asm_test::compare_exchange_weak::u64::relaxed_relaxed:
        push              {r4, r5, r11, lr}
        ldrexd            r4, r5, [r1]
        eor               r3, r5, r3
        eor               r2, r4, r2
        orrs              r2, r2, r3
        bne               0f
        ldr               r3, [sp, #0x14]
        ldr               r2, [sp, #0x10]
        strexd            r12, r2, r3, [r1]
        mov               r1, #0
        cmp               r12, #0
        mvneq             r1, #0
        and               r1, r1, #1
        strd              r4, r5, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r11, pc}
0:
        mov               r1, #0
        clrex
        and               r1, r1, #1
        strd              r4, r5, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r11, pc}

asm_test::compare_exchange_weak::u64::release_acquire:
        push              {r4, r5, r6, r7, r11, lr}
        ldrexd            r4, r5, [r1]
        eor               r3, r5, r3
        eor               r2, r4, r2
        orrs              r2, r2, r3
        bne               0f
        ldr               r7, [sp, #0x1c]
        dmb               ish
        ldr               r6, [sp, #0x18]
        strexd            r2, r6, r7, [r1]
        cmp               r2, #0
        bne               1f
        mov               r1, #1
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r7, r11, pc}
0:
        clrex
1:
        mov               r1, #0
        dmb               ish
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r7, r11, pc}

asm_test::compare_exchange_weak::u64::release_relaxed:
        push              {r4, r5, r11, lr}
        ldrexd            r4, r5, [r1]
        eor               r3, r5, r3
        eor               r2, r4, r2
        orrs              r2, r2, r3
        bne               0f
        ldr               r3, [sp, #0x14]
        dmb               ish
        ldr               r2, [sp, #0x10]
        strexd            r12, r2, r3, [r1]
        mov               r1, #0
        cmp               r12, #0
        mvneq             r1, #0
        and               r1, r1, #1
        strd              r4, r5, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r11, pc}
0:
        mov               r1, #0
        clrex
        and               r1, r1, #1
        strd              r4, r5, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r11, pc}

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
        cmp               r3, #0
        bne               0b
        mov               r0, r2
        dmb               ish
        bx                lr

asm_test::swap::u8::seqcst:
        dmb               ish
0:
        ldrexb            r2, [r0]
        strexb            r3, r1, [r0]
        cmp               r3, #0
        bne               0b
        mov               r0, r2
        dmb               ish
        bx                lr

asm_test::swap::u8::acquire:
0:
        ldrexb            r2, [r0]
        strexb            r3, r1, [r0]
        cmp               r3, #0
        bne               0b
        mov               r0, r2
        dmb               ish
        bx                lr

asm_test::swap::u8::relaxed:
0:
        ldrexb            r2, [r0]
        strexb            r3, r1, [r0]
        cmp               r3, #0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u8::release:
        dmb               ish
0:
        ldrexb            r2, [r0]
        strexb            r3, r1, [r0]
        cmp               r3, #0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u16::acqrel:
        dmb               ish
0:
        ldrexh            r2, [r0]
        strexh            r3, r1, [r0]
        cmp               r3, #0
        bne               0b
        mov               r0, r2
        dmb               ish
        bx                lr

asm_test::swap::u16::seqcst:
        dmb               ish
0:
        ldrexh            r2, [r0]
        strexh            r3, r1, [r0]
        cmp               r3, #0
        bne               0b
        mov               r0, r2
        dmb               ish
        bx                lr

asm_test::swap::u16::acquire:
0:
        ldrexh            r2, [r0]
        strexh            r3, r1, [r0]
        cmp               r3, #0
        bne               0b
        mov               r0, r2
        dmb               ish
        bx                lr

asm_test::swap::u16::relaxed:
0:
        ldrexh            r2, [r0]
        strexh            r3, r1, [r0]
        cmp               r3, #0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u16::release:
        dmb               ish
0:
        ldrexh            r2, [r0]
        strexh            r3, r1, [r0]
        cmp               r3, #0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u32::acqrel:
        dmb               ish
0:
        ldrex             r2, [r0]
        strex             r3, r1, [r0]
        cmp               r3, #0
        bne               0b
        mov               r0, r2
        dmb               ish
        bx                lr

asm_test::swap::u32::seqcst:
        dmb               ish
0:
        ldrex             r2, [r0]
        strex             r3, r1, [r0]
        cmp               r3, #0
        bne               0b
        mov               r0, r2
        dmb               ish
        bx                lr

asm_test::swap::u32::acquire:
        mov               r2, r0
0:
        ldrex             r0, [r2]
        strex             r3, r1, [r2]
        cmp               r3, #0
        bne               0b
        dmb               ish
        bx                lr

asm_test::swap::u32::relaxed:
0:
        ldrex             r2, [r0]
        strex             r3, r1, [r0]
        cmp               r3, #0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u32::release:
        dmb               ish
0:
        ldrex             r2, [r0]
        strex             r3, r1, [r0]
        cmp               r3, #0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u64::acqrel:
        push              {r11, lr}
        mov               r12, r0
        dmb               ish
0:
        ldrexd            r0, r1, [r12]
        strexd            lr, r2, r3, [r12]
        cmp               lr, #0
        bne               0b
        dmb               ish
        pop               {r11, pc}

asm_test::swap::u64::seqcst:
        push              {r11, lr}
        mov               r12, r0
        dmb               ish
0:
        ldrexd            r0, r1, [r12]
        strexd            lr, r2, r3, [r12]
        cmp               lr, #0
        bne               0b
        dmb               ish
        pop               {r11, pc}

asm_test::swap::u64::acquire:
        push              {r11, lr}
        mov               r12, r0
0:
        ldrexd            r0, r1, [r12]
        strexd            lr, r2, r3, [r12]
        cmp               lr, #0
        bne               0b
        dmb               ish
        pop               {r11, pc}

asm_test::swap::u64::relaxed:
        push              {r11, lr}
        mov               r12, r0
0:
        ldrexd            r0, r1, [r12]
        strexd            lr, r2, r3, [r12]
        cmp               lr, #0
        bne               0b
        pop               {r11, pc}

asm_test::swap::u64::release:
        push              {r4, r5, r11, lr}
        dmb               ish
0:
        ldrexd            r4, r5, [r0]
        strexd            r1, r2, r3, [r0]
        cmp               r1, #0
        bne               0b
        mov               r0, r4
        mov               r1, r5
        pop               {r4, r5, r11, pc}

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
        push              {r4, r5, r11, lr}
        dmb               ish
0:
        ldrexd            r4, r5, [r0]
        strexd            r1, r2, r3, [r0]
        cmp               r1, #0
        bne               0b
        dmb               ish
        pop               {r4, r5, r11, pc}

asm_test::store::u64::relaxed:
        push              {r4, r5, r11, lr}
0:
        ldrexd            r4, r5, [r0]
        strexd            r1, r2, r3, [r0]
        cmp               r1, #0
        bne               0b
        pop               {r4, r5, r11, pc}

asm_test::store::u64::release:
        push              {r4, r5, r11, lr}
        dmb               ish
0:
        ldrexd            r4, r5, [r0]
        strexd            r1, r2, r3, [r0]
        cmp               r1, #0
        bne               0b
        pop               {r4, r5, r11, pc}

