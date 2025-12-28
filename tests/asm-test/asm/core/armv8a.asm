asm_test::compare_exchange::u8::acqrel_seqcst:
        mov               r3, r0
        uxtb              r12, r1
0:
        ldaexb            r0, [r3]
        cmp               r0, r12
        bne               1f
        stlexb            r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        b                 0b
1:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange::u8::seqcst_seqcst:
        mov               r3, r0
        uxtb              r12, r1
0:
        ldaexb            r0, [r3]
        cmp               r0, r12
        bne               1f
        stlexb            r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        b                 0b
1:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange::u8::acqrel_acquire:
        mov               r3, r0
        uxtb              r12, r1
0:
        ldaexb            r0, [r3]
        cmp               r0, r12
        bne               1f
        stlexb            r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        b                 0b
1:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange::u8::acqrel_relaxed:
        mov               r3, r0
        uxtb              r12, r1
0:
        ldaexb            r0, [r3]
        cmp               r0, r12
        bne               1f
        stlexb            r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        b                 0b
1:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange::u8::acquire_seqcst:
        mov               r3, r0
        uxtb              r12, r1
0:
        ldaexb            r0, [r3]
        cmp               r0, r12
        bne               1f
        stlexb            r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        b                 0b
1:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange::u8::relaxed_seqcst:
        mov               r3, r0
        uxtb              r12, r1
0:
        ldaexb            r0, [r3]
        cmp               r0, r12
        bne               1f
        stlexb            r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        b                 0b
1:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange::u8::release_seqcst:
        mov               r3, r0
        uxtb              r12, r1
0:
        ldaexb            r0, [r3]
        cmp               r0, r12
        bne               1f
        stlexb            r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        b                 0b
1:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange::u8::seqcst_acquire:
        mov               r3, r0
        uxtb              r12, r1
0:
        ldaexb            r0, [r3]
        cmp               r0, r12
        bne               1f
        stlexb            r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        b                 0b
1:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange::u8::seqcst_relaxed:
        mov               r3, r0
        uxtb              r12, r1
0:
        ldaexb            r0, [r3]
        cmp               r0, r12
        bne               1f
        stlexb            r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        b                 0b
1:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange::u8::acquire_acquire:
        mov               r3, r0
        uxtb              r12, r1
0:
        ldaexb            r0, [r3]
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

asm_test::compare_exchange::u8::acquire_relaxed:
        mov               r3, r0
        uxtb              r12, r1
0:
        ldaexb            r0, [r3]
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

asm_test::compare_exchange::u8::relaxed_acquire:
        mov               r3, r0
        uxtb              r12, r1
0:
        ldaexb            r0, [r3]
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
        uxtb              r12, r1
0:
        ldaexb            r0, [r3]
        cmp               r0, r12
        bne               1f
        stlexb            r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        b                 0b
1:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange::u8::release_relaxed:
        mov               r3, r0
        uxtb              r12, r1
0:
        ldrexb            r0, [r3]
        cmp               r0, r12
        bne               1f
        stlexb            r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        b                 0b
1:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange::u16::acqrel_seqcst:
        mov               r3, r0
        uxth              r12, r1
0:
        ldaexh            r0, [r3]
        cmp               r0, r12
        bne               1f
        stlexh            r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        b                 0b
1:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange::u16::seqcst_seqcst:
        mov               r3, r0
        uxth              r12, r1
0:
        ldaexh            r0, [r3]
        cmp               r0, r12
        bne               1f
        stlexh            r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        b                 0b
1:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange::u16::acqrel_acquire:
        mov               r3, r0
        uxth              r12, r1
0:
        ldaexh            r0, [r3]
        cmp               r0, r12
        bne               1f
        stlexh            r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        b                 0b
1:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange::u16::acqrel_relaxed:
        mov               r3, r0
        uxth              r12, r1
0:
        ldaexh            r0, [r3]
        cmp               r0, r12
        bne               1f
        stlexh            r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        b                 0b
1:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange::u16::acquire_seqcst:
        mov               r3, r0
        uxth              r12, r1
0:
        ldaexh            r0, [r3]
        cmp               r0, r12
        bne               1f
        stlexh            r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        b                 0b
1:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange::u16::relaxed_seqcst:
        mov               r3, r0
        uxth              r12, r1
0:
        ldaexh            r0, [r3]
        cmp               r0, r12
        bne               1f
        stlexh            r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        b                 0b
1:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange::u16::release_seqcst:
        mov               r3, r0
        uxth              r12, r1
0:
        ldaexh            r0, [r3]
        cmp               r0, r12
        bne               1f
        stlexh            r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        b                 0b
1:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange::u16::seqcst_acquire:
        mov               r3, r0
        uxth              r12, r1
0:
        ldaexh            r0, [r3]
        cmp               r0, r12
        bne               1f
        stlexh            r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        b                 0b
1:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange::u16::seqcst_relaxed:
        mov               r3, r0
        uxth              r12, r1
0:
        ldaexh            r0, [r3]
        cmp               r0, r12
        bne               1f
        stlexh            r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        b                 0b
1:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange::u16::acquire_acquire:
        mov               r3, r0
        uxth              r12, r1
0:
        ldaexh            r0, [r3]
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

asm_test::compare_exchange::u16::acquire_relaxed:
        mov               r3, r0
        uxth              r12, r1
0:
        ldaexh            r0, [r3]
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

asm_test::compare_exchange::u16::relaxed_acquire:
        mov               r3, r0
        uxth              r12, r1
0:
        ldaexh            r0, [r3]
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
        uxth              r12, r1
0:
        ldaexh            r0, [r3]
        cmp               r0, r12
        bne               1f
        stlexh            r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        b                 0b
1:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange::u16::release_relaxed:
        mov               r3, r0
        uxth              r12, r1
0:
        ldrexh            r0, [r3]
        cmp               r0, r12
        bne               1f
        stlexh            r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #1
        bxeq              lr
        b                 0b
1:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange::u32::acqrel_seqcst:
        mov               r12, r0
0:
        ldaex             r0, [r12]
        cmp               r0, r1
        bne               1f
        stlex             r3, r2, [r12]
        cmp               r3, #0
        moveq             r1, #1
        bxeq              lr
        b                 0b
1:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange::u32::seqcst_seqcst:
        mov               r12, r0
0:
        ldaex             r0, [r12]
        cmp               r0, r1
        bne               1f
        stlex             r3, r2, [r12]
        cmp               r3, #0
        moveq             r1, #1
        bxeq              lr
        b                 0b
1:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange::u32::acqrel_acquire:
        mov               r12, r0
0:
        ldaex             r0, [r12]
        cmp               r0, r1
        bne               1f
        stlex             r3, r2, [r12]
        cmp               r3, #0
        moveq             r1, #1
        bxeq              lr
        b                 0b
1:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange::u32::acqrel_relaxed:
        mov               r12, r0
0:
        ldaex             r0, [r12]
        cmp               r0, r1
        bne               1f
        stlex             r3, r2, [r12]
        cmp               r3, #0
        moveq             r1, #1
        bxeq              lr
        b                 0b
1:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange::u32::acquire_seqcst:
        mov               r12, r0
0:
        ldaex             r0, [r12]
        cmp               r0, r1
        bne               1f
        stlex             r3, r2, [r12]
        cmp               r3, #0
        moveq             r1, #1
        bxeq              lr
        b                 0b
1:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange::u32::relaxed_seqcst:
        mov               r12, r0
0:
        ldaex             r0, [r12]
        cmp               r0, r1
        bne               1f
        stlex             r3, r2, [r12]
        cmp               r3, #0
        moveq             r1, #1
        bxeq              lr
        b                 0b
1:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange::u32::release_seqcst:
        mov               r12, r0
0:
        ldaex             r0, [r12]
        cmp               r0, r1
        bne               1f
        stlex             r3, r2, [r12]
        cmp               r3, #0
        moveq             r1, #1
        bxeq              lr
        b                 0b
1:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange::u32::seqcst_acquire:
        mov               r12, r0
0:
        ldaex             r0, [r12]
        cmp               r0, r1
        bne               1f
        stlex             r3, r2, [r12]
        cmp               r3, #0
        moveq             r1, #1
        bxeq              lr
        b                 0b
1:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange::u32::seqcst_relaxed:
        mov               r12, r0
0:
        ldaex             r0, [r12]
        cmp               r0, r1
        bne               1f
        stlex             r3, r2, [r12]
        cmp               r3, #0
        moveq             r1, #1
        bxeq              lr
        b                 0b
1:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange::u32::acquire_acquire:
        mov               r12, r0
0:
        ldaex             r0, [r12]
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

asm_test::compare_exchange::u32::acquire_relaxed:
        mov               r12, r0
0:
        ldaex             r0, [r12]
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

asm_test::compare_exchange::u32::relaxed_acquire:
        mov               r12, r0
0:
        ldaex             r0, [r12]
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
0:
        ldaex             r0, [r12]
        cmp               r0, r1
        bne               1f
        stlex             r3, r2, [r12]
        cmp               r3, #0
        moveq             r1, #1
        bxeq              lr
        b                 0b
1:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange::u32::release_relaxed:
        mov               r12, r0
0:
        ldrex             r0, [r12]
        cmp               r0, r1
        bne               1f
        stlex             r3, r2, [r12]
        cmp               r3, #0
        moveq             r1, #1
        bxeq              lr
        b                 0b
1:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange::u64::acqrel_seqcst:
        push              {r4, r5, r6, r8, r9, lr}
        ldr               r9, [sp, #0x1c]
        ldr               r8, [sp, #0x18]
0:
        ldaexd            r4, r5, [r1]
        eor               r12, r5, r3
        eor               r6, r4, r2
        orrs              r6, r6, r12
        bne               1f
        stlexd            r6, r8, r9, [r1]
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

asm_test::compare_exchange::u64::seqcst_seqcst:
        push              {r4, r5, r6, r8, r9, lr}
        ldr               r9, [sp, #0x1c]
        ldr               r8, [sp, #0x18]
0:
        ldaexd            r4, r5, [r1]
        eor               r12, r5, r3
        eor               r6, r4, r2
        orrs              r6, r6, r12
        bne               1f
        stlexd            r6, r8, r9, [r1]
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

asm_test::compare_exchange::u64::acqrel_acquire:
        push              {r4, r5, r6, r8, r9, lr}
        ldr               r9, [sp, #0x1c]
        ldr               r8, [sp, #0x18]
0:
        ldaexd            r4, r5, [r1]
        eor               r12, r5, r3
        eor               r6, r4, r2
        orrs              r6, r6, r12
        bne               1f
        stlexd            r6, r8, r9, [r1]
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

asm_test::compare_exchange::u64::acqrel_relaxed:
        push              {r4, r5, r6, r8, r9, lr}
        ldr               r9, [sp, #0x1c]
        ldr               r8, [sp, #0x18]
0:
        ldaexd            r4, r5, [r1]
        eor               r12, r5, r3
        eor               r6, r4, r2
        orrs              r6, r6, r12
        bne               1f
        stlexd            r6, r8, r9, [r1]
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

asm_test::compare_exchange::u64::acquire_seqcst:
        push              {r4, r5, r6, r8, r9, lr}
        ldr               r9, [sp, #0x1c]
        ldr               r8, [sp, #0x18]
0:
        ldaexd            r4, r5, [r1]
        eor               r12, r5, r3
        eor               r6, r4, r2
        orrs              r6, r6, r12
        bne               1f
        stlexd            r6, r8, r9, [r1]
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

asm_test::compare_exchange::u64::relaxed_seqcst:
        push              {r4, r5, r6, r8, r9, lr}
        ldr               r9, [sp, #0x1c]
        ldr               r8, [sp, #0x18]
0:
        ldaexd            r4, r5, [r1]
        eor               r12, r5, r3
        eor               r6, r4, r2
        orrs              r6, r6, r12
        bne               1f
        stlexd            r6, r8, r9, [r1]
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

asm_test::compare_exchange::u64::release_seqcst:
        push              {r4, r5, r6, r8, r9, lr}
        ldr               r9, [sp, #0x1c]
        ldr               r8, [sp, #0x18]
0:
        ldaexd            r4, r5, [r1]
        eor               r12, r5, r3
        eor               r6, r4, r2
        orrs              r6, r6, r12
        bne               1f
        stlexd            r6, r8, r9, [r1]
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

asm_test::compare_exchange::u64::seqcst_acquire:
        push              {r4, r5, r6, r8, r9, lr}
        ldr               r9, [sp, #0x1c]
        ldr               r8, [sp, #0x18]
0:
        ldaexd            r4, r5, [r1]
        eor               r12, r5, r3
        eor               r6, r4, r2
        orrs              r6, r6, r12
        bne               1f
        stlexd            r6, r8, r9, [r1]
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

asm_test::compare_exchange::u64::seqcst_relaxed:
        push              {r4, r5, r6, r8, r9, lr}
        ldr               r9, [sp, #0x1c]
        ldr               r8, [sp, #0x18]
0:
        ldaexd            r4, r5, [r1]
        eor               r12, r5, r3
        eor               r6, r4, r2
        orrs              r6, r6, r12
        bne               1f
        stlexd            r6, r8, r9, [r1]
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

asm_test::compare_exchange::u64::acquire_acquire:
        push              {r4, r5, r6, r8, r9, lr}
        ldr               r9, [sp, #0x1c]
        ldr               r8, [sp, #0x18]
0:
        ldaexd            r4, r5, [r1]
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

asm_test::compare_exchange::u64::acquire_relaxed:
        push              {r4, r5, r6, r8, r9, lr}
        ldr               r9, [sp, #0x1c]
        ldr               r8, [sp, #0x18]
0:
        ldaexd            r4, r5, [r1]
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

asm_test::compare_exchange::u64::relaxed_acquire:
        push              {r4, r5, r6, r8, r9, lr}
        ldr               r9, [sp, #0x1c]
        ldr               r8, [sp, #0x18]
0:
        ldaexd            r4, r5, [r1]
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
        push              {r4, r5, r6, r8, r9, lr}
        ldr               r9, [sp, #0x1c]
        ldr               r8, [sp, #0x18]
0:
        ldaexd            r4, r5, [r1]
        eor               r12, r5, r3
        eor               r6, r4, r2
        orrs              r6, r6, r12
        bne               1f
        stlexd            r6, r8, r9, [r1]
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

asm_test::compare_exchange::u64::release_relaxed:
        push              {r4, r5, r6, r8, r9, lr}
        ldr               r9, [sp, #0x1c]
        ldr               r8, [sp, #0x18]
0:
        ldrexd            r4, r5, [r1]
        eor               r12, r5, r3
        eor               r6, r4, r2
        orrs              r6, r6, r12
        bne               1f
        stlexd            r6, r8, r9, [r1]
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

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        mov               r3, r0
        ldaexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        stlexb            r12, r2, [r3]
        mov               r1, #0
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        mov               r3, r0
        ldaexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        stlexb            r12, r2, [r3]
        mov               r1, #0
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        mov               r3, r0
        ldaexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        stlexb            r12, r2, [r3]
        mov               r1, #0
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        mov               r3, r0
        ldaexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        stlexb            r12, r2, [r3]
        mov               r1, #0
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        mov               r3, r0
        ldaexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        stlexb            r12, r2, [r3]
        mov               r1, #0
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        mov               r3, r0
        ldaexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        stlexb            r12, r2, [r3]
        mov               r1, #0
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u8::release_seqcst:
        mov               r3, r0
        ldaexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        stlexb            r12, r2, [r3]
        mov               r1, #0
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        mov               r3, r0
        ldaexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        stlexb            r12, r2, [r3]
        mov               r1, #0
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        mov               r3, r0
        ldaexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        stlexb            r12, r2, [r3]
        mov               r1, #0
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u8::acquire_acquire:
        mov               r3, r0
        ldaexb            r0, [r0]
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

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        mov               r3, r0
        ldaexb            r0, [r0]
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

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        mov               r3, r0
        ldaexb            r0, [r0]
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
        ldaexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        stlexb            r12, r2, [r3]
        mov               r1, #0
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u8::release_relaxed:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        stlexb            r12, r2, [r3]
        mov               r1, #0
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        mov               r3, r0
        ldaexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        stlexh            r12, r2, [r3]
        mov               r1, #0
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        mov               r3, r0
        ldaexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        stlexh            r12, r2, [r3]
        mov               r1, #0
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        mov               r3, r0
        ldaexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        stlexh            r12, r2, [r3]
        mov               r1, #0
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        mov               r3, r0
        ldaexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        stlexh            r12, r2, [r3]
        mov               r1, #0
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        mov               r3, r0
        ldaexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        stlexh            r12, r2, [r3]
        mov               r1, #0
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        mov               r3, r0
        ldaexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        stlexh            r12, r2, [r3]
        mov               r1, #0
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u16::release_seqcst:
        mov               r3, r0
        ldaexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        stlexh            r12, r2, [r3]
        mov               r1, #0
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        mov               r3, r0
        ldaexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        stlexh            r12, r2, [r3]
        mov               r1, #0
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        mov               r3, r0
        ldaexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        stlexh            r12, r2, [r3]
        mov               r1, #0
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u16::acquire_acquire:
        mov               r3, r0
        ldaexh            r0, [r0]
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

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        mov               r3, r0
        ldaexh            r0, [r0]
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

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        mov               r3, r0
        ldaexh            r0, [r0]
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
        ldaexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        stlexh            r12, r2, [r3]
        mov               r1, #0
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u16::release_relaxed:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        stlexh            r12, r2, [r3]
        mov               r1, #0
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        mov               r3, r0
        ldaex             r0, [r0]
        cmp               r0, r1
        bne               0f
        stlex             r12, r2, [r3]
        mov               r1, #0
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        mov               r3, r0
        ldaex             r0, [r0]
        cmp               r0, r1
        bne               0f
        stlex             r12, r2, [r3]
        mov               r1, #0
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        mov               r3, r0
        ldaex             r0, [r0]
        cmp               r0, r1
        bne               0f
        stlex             r12, r2, [r3]
        mov               r1, #0
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        mov               r3, r0
        ldaex             r0, [r0]
        cmp               r0, r1
        bne               0f
        stlex             r12, r2, [r3]
        mov               r1, #0
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        mov               r3, r0
        ldaex             r0, [r0]
        cmp               r0, r1
        bne               0f
        stlex             r12, r2, [r3]
        mov               r1, #0
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        mov               r3, r0
        ldaex             r0, [r0]
        cmp               r0, r1
        bne               0f
        stlex             r12, r2, [r3]
        mov               r1, #0
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u32::release_seqcst:
        mov               r3, r0
        ldaex             r0, [r0]
        cmp               r0, r1
        bne               0f
        stlex             r12, r2, [r3]
        mov               r1, #0
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        mov               r3, r0
        ldaex             r0, [r0]
        cmp               r0, r1
        bne               0f
        stlex             r12, r2, [r3]
        mov               r1, #0
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        mov               r3, r0
        ldaex             r0, [r0]
        cmp               r0, r1
        bne               0f
        stlex             r12, r2, [r3]
        mov               r1, #0
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u32::acquire_acquire:
        mov               r3, r0
        ldaex             r0, [r0]
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

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        mov               r3, r0
        ldaex             r0, [r0]
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

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        mov               r3, r0
        ldaex             r0, [r0]
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
        ldaex             r0, [r0]
        cmp               r0, r1
        bne               0f
        stlex             r12, r2, [r3]
        mov               r1, #0
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u32::release_relaxed:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        stlex             r12, r2, [r3]
        mov               r1, #0
        cmp               r12, #0
        mvneq             r1, #0
        bx                lr
0:
        mov               r1, #0
        clrex
        bx                lr

asm_test::compare_exchange_weak::u64::acqrel_seqcst:
        push              {r4, r5, r11, lr}
        ldaexd            r4, r5, [r1]
        eor               r3, r5, r3
        eor               r2, r4, r2
        orrs              r2, r2, r3
        bne               0f
        ldr               r3, [sp, #0x14]
        ldr               r2, [sp, #0x10]
        stlexd            r12, r2, r3, [r1]
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

asm_test::compare_exchange_weak::u64::seqcst_seqcst:
        push              {r4, r5, r11, lr}
        ldaexd            r4, r5, [r1]
        eor               r3, r5, r3
        eor               r2, r4, r2
        orrs              r2, r2, r3
        bne               0f
        ldr               r3, [sp, #0x14]
        ldr               r2, [sp, #0x10]
        stlexd            r12, r2, r3, [r1]
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

asm_test::compare_exchange_weak::u64::acqrel_acquire:
        push              {r4, r5, r11, lr}
        ldaexd            r4, r5, [r1]
        eor               r3, r5, r3
        eor               r2, r4, r2
        orrs              r2, r2, r3
        bne               0f
        ldr               r3, [sp, #0x14]
        ldr               r2, [sp, #0x10]
        stlexd            r12, r2, r3, [r1]
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

asm_test::compare_exchange_weak::u64::acqrel_relaxed:
        push              {r4, r5, r11, lr}
        ldaexd            r4, r5, [r1]
        eor               r3, r5, r3
        eor               r2, r4, r2
        orrs              r2, r2, r3
        bne               0f
        ldr               r3, [sp, #0x14]
        ldr               r2, [sp, #0x10]
        stlexd            r12, r2, r3, [r1]
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

asm_test::compare_exchange_weak::u64::acquire_seqcst:
        push              {r4, r5, r11, lr}
        ldaexd            r4, r5, [r1]
        eor               r3, r5, r3
        eor               r2, r4, r2
        orrs              r2, r2, r3
        bne               0f
        ldr               r3, [sp, #0x14]
        ldr               r2, [sp, #0x10]
        stlexd            r12, r2, r3, [r1]
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

asm_test::compare_exchange_weak::u64::relaxed_seqcst:
        push              {r4, r5, r11, lr}
        ldaexd            r4, r5, [r1]
        eor               r3, r5, r3
        eor               r2, r4, r2
        orrs              r2, r2, r3
        bne               0f
        ldr               r3, [sp, #0x14]
        ldr               r2, [sp, #0x10]
        stlexd            r12, r2, r3, [r1]
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

asm_test::compare_exchange_weak::u64::release_seqcst:
        push              {r4, r5, r11, lr}
        ldaexd            r4, r5, [r1]
        eor               r3, r5, r3
        eor               r2, r4, r2
        orrs              r2, r2, r3
        bne               0f
        ldr               r3, [sp, #0x14]
        ldr               r2, [sp, #0x10]
        stlexd            r12, r2, r3, [r1]
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

asm_test::compare_exchange_weak::u64::seqcst_acquire:
        push              {r4, r5, r11, lr}
        ldaexd            r4, r5, [r1]
        eor               r3, r5, r3
        eor               r2, r4, r2
        orrs              r2, r2, r3
        bne               0f
        ldr               r3, [sp, #0x14]
        ldr               r2, [sp, #0x10]
        stlexd            r12, r2, r3, [r1]
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

asm_test::compare_exchange_weak::u64::seqcst_relaxed:
        push              {r4, r5, r11, lr}
        ldaexd            r4, r5, [r1]
        eor               r3, r5, r3
        eor               r2, r4, r2
        orrs              r2, r2, r3
        bne               0f
        ldr               r3, [sp, #0x14]
        ldr               r2, [sp, #0x10]
        stlexd            r12, r2, r3, [r1]
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

asm_test::compare_exchange_weak::u64::acquire_acquire:
        push              {r4, r5, r11, lr}
        ldaexd            r4, r5, [r1]
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

asm_test::compare_exchange_weak::u64::acquire_relaxed:
        push              {r4, r5, r11, lr}
        ldaexd            r4, r5, [r1]
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

asm_test::compare_exchange_weak::u64::relaxed_acquire:
        push              {r4, r5, r11, lr}
        ldaexd            r4, r5, [r1]
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
        push              {r4, r5, r11, lr}
        ldaexd            r4, r5, [r1]
        eor               r3, r5, r3
        eor               r2, r4, r2
        orrs              r2, r2, r3
        bne               0f
        ldr               r3, [sp, #0x14]
        ldr               r2, [sp, #0x10]
        stlexd            r12, r2, r3, [r1]
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

asm_test::compare_exchange_weak::u64::release_relaxed:
        push              {r4, r5, r11, lr}
        ldrexd            r4, r5, [r1]
        eor               r3, r5, r3
        eor               r2, r4, r2
        orrs              r2, r2, r3
        bne               0f
        ldr               r3, [sp, #0x14]
        ldr               r2, [sp, #0x10]
        stlexd            r12, r2, r3, [r1]
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
        ldab              r0, [r0]
        bx                lr

asm_test::load::u8::acquire:
        ldab              r0, [r0]
        bx                lr

asm_test::load::u8::relaxed:
        ldrb              r0, [r0]
        bx                lr

asm_test::load::u16::seqcst:
        ldah              r0, [r0]
        bx                lr

asm_test::load::u16::acquire:
        ldah              r0, [r0]
        bx                lr

asm_test::load::u16::relaxed:
        ldrh              r0, [r0]
        bx                lr

asm_test::load::u32::seqcst:
        lda               r0, [r0]
        bx                lr

asm_test::load::u32::acquire:
        lda               r0, [r0]
        bx                lr

asm_test::load::u32::relaxed:
        ldr               r0, [r0]
        bx                lr

asm_test::load::u64::seqcst:
        ldaexd            r0, r1, [r0]
        clrex
        bx                lr

asm_test::load::u64::acquire:
        ldaexd            r0, r1, [r0]
        clrex
        bx                lr

asm_test::load::u64::relaxed:
        ldrexd            r0, r1, [r0]
        clrex
        bx                lr

asm_test::swap::u8::acqrel:
0:
        ldaexb            r2, [r0]
        stlexb            r3, r1, [r0]
        cmp               r3, #0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u8::seqcst:
0:
        ldaexb            r2, [r0]
        stlexb            r3, r1, [r0]
        cmp               r3, #0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u8::acquire:
0:
        ldaexb            r2, [r0]
        strexb            r3, r1, [r0]
        cmp               r3, #0
        bne               0b
        mov               r0, r2
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
0:
        ldrexb            r2, [r0]
        stlexb            r3, r1, [r0]
        cmp               r3, #0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u16::acqrel:
0:
        ldaexh            r2, [r0]
        stlexh            r3, r1, [r0]
        cmp               r3, #0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u16::seqcst:
0:
        ldaexh            r2, [r0]
        stlexh            r3, r1, [r0]
        cmp               r3, #0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u16::acquire:
0:
        ldaexh            r2, [r0]
        strexh            r3, r1, [r0]
        cmp               r3, #0
        bne               0b
        mov               r0, r2
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
0:
        ldrexh            r2, [r0]
        stlexh            r3, r1, [r0]
        cmp               r3, #0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u32::acqrel:
0:
        ldaex             r2, [r0]
        stlex             r3, r1, [r0]
        cmp               r3, #0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u32::seqcst:
0:
        ldaex             r2, [r0]
        stlex             r3, r1, [r0]
        cmp               r3, #0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u32::acquire:
0:
        ldaex             r2, [r0]
        strex             r3, r1, [r0]
        cmp               r3, #0
        bne               0b
        mov               r0, r2
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
0:
        ldrex             r2, [r0]
        stlex             r3, r1, [r0]
        cmp               r3, #0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u64::acqrel:
        push              {r11, lr}
        mov               r12, r0
0:
        ldaexd            r0, r1, [r12]
        stlexd            lr, r2, r3, [r12]
        cmp               lr, #0
        bne               0b
        pop               {r11, pc}

asm_test::swap::u64::seqcst:
        push              {r11, lr}
        mov               r12, r0
0:
        ldaexd            r0, r1, [r12]
        stlexd            lr, r2, r3, [r12]
        cmp               lr, #0
        bne               0b
        pop               {r11, pc}

asm_test::swap::u64::acquire:
        push              {r11, lr}
        mov               r12, r0
0:
        ldaexd            r0, r1, [r12]
        strexd            lr, r2, r3, [r12]
        cmp               lr, #0
        bne               0b
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
        push              {r11, lr}
        mov               r12, r0
0:
        ldrexd            r0, r1, [r12]
        stlexd            lr, r2, r3, [r12]
        cmp               lr, #0
        bne               0b
        pop               {r11, pc}

asm_test::store::u8::seqcst:
        stlb              r1, [r0]
        bx                lr

asm_test::store::u8::relaxed:
        strb              r1, [r0]
        bx                lr

asm_test::store::u8::release:
        stlb              r1, [r0]
        bx                lr

asm_test::store::u16::seqcst:
        stlh              r1, [r0]
        bx                lr

asm_test::store::u16::relaxed:
        strh              r1, [r0]
        bx                lr

asm_test::store::u16::release:
        stlh              r1, [r0]
        bx                lr

asm_test::store::u32::seqcst:
        stl               r1, [r0]
        bx                lr

asm_test::store::u32::relaxed:
        str               r1, [r0]
        bx                lr

asm_test::store::u32::release:
        stl               r1, [r0]
        bx                lr

asm_test::store::u64::seqcst:
        push              {r4, r5, r11, lr}
0:
        ldaexd            r4, r5, [r0]
        stlexd            r1, r2, r3, [r0]
        cmp               r1, #0
        bne               0b
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
0:
        ldrexd            r4, r5, [r0]
        stlexd            r1, r2, r3, [r0]
        cmp               r1, #0
        bne               0b
        pop               {r4, r5, r11, pc}

