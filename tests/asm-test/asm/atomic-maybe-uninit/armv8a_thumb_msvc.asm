asm_test::compare_exchange::u8::acqrel_seqcst:
        uxtb              r1, r1
0:
        <unknown>
        cmp               r12, r1
        bne               1f
        <unknown>
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u8::seqcst_seqcst:
        uxtb              r1, r1
0:
        <unknown>
        cmp               r12, r1
        bne               1f
        <unknown>
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u8::acqrel_acquire:
        uxtb              r1, r1
0:
        <unknown>
        cmp               r12, r1
        bne               1f
        <unknown>
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u8::acqrel_relaxed:
        uxtb              r1, r1
0:
        <unknown>
        cmp               r12, r1
        bne               1f
        <unknown>
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u8::acquire_seqcst:
        uxtb              r1, r1
0:
        <unknown>
        cmp               r12, r1
        bne               1f
        <unknown>
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u8::relaxed_seqcst:
        uxtb              r1, r1
0:
        <unknown>
        cmp               r12, r1
        bne               1f
        <unknown>
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u8::release_seqcst:
        uxtb              r1, r1
0:
        <unknown>
        cmp               r12, r1
        bne               1f
        <unknown>
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u8::seqcst_acquire:
        uxtb              r1, r1
0:
        <unknown>
        cmp               r12, r1
        bne               1f
        <unknown>
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u8::seqcst_relaxed:
        uxtb              r1, r1
0:
        <unknown>
        cmp               r12, r1
        bne               1f
        <unknown>
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u8::acquire_acquire:
        uxtb              r1, r1
0:
        <unknown>
        cmp               r12, r1
        bne               1f
        strexb            r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u8::acquire_relaxed:
        uxtb              r1, r1
0:
        <unknown>
        cmp               r12, r1
        bne               1f
        strexb            r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u8::relaxed_acquire:
        uxtb              r1, r1
0:
        <unknown>
        cmp               r12, r1
        bne               1f
        strexb            r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u8::relaxed_relaxed:
        uxtb              r1, r1
0:
        ldrexb            r12, [r0]
        cmp               r12, r1
        bne               1f
        strexb            r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u8::release_acquire:
        uxtb              r1, r1
0:
        <unknown>
        cmp               r12, r1
        bne               1f
        <unknown>
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u8::release_relaxed:
        uxtb              r1, r1
0:
        ldrexb            r12, [r0]
        cmp               r12, r1
        bne               1f
        <unknown>
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u16::acqrel_seqcst:
        uxth              r1, r1
0:
        <unknown>
        cmp               r12, r1
        bne               1f
        <unknown>
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u16::seqcst_seqcst:
        uxth              r1, r1
0:
        <unknown>
        cmp               r12, r1
        bne               1f
        <unknown>
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u16::acqrel_acquire:
        uxth              r1, r1
0:
        <unknown>
        cmp               r12, r1
        bne               1f
        <unknown>
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u16::acqrel_relaxed:
        uxth              r1, r1
0:
        <unknown>
        cmp               r12, r1
        bne               1f
        <unknown>
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u16::acquire_seqcst:
        uxth              r1, r1
0:
        <unknown>
        cmp               r12, r1
        bne               1f
        <unknown>
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u16::relaxed_seqcst:
        uxth              r1, r1
0:
        <unknown>
        cmp               r12, r1
        bne               1f
        <unknown>
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u16::release_seqcst:
        uxth              r1, r1
0:
        <unknown>
        cmp               r12, r1
        bne               1f
        <unknown>
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u16::seqcst_acquire:
        uxth              r1, r1
0:
        <unknown>
        cmp               r12, r1
        bne               1f
        <unknown>
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u16::seqcst_relaxed:
        uxth              r1, r1
0:
        <unknown>
        cmp               r12, r1
        bne               1f
        <unknown>
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u16::acquire_acquire:
        uxth              r1, r1
0:
        <unknown>
        cmp               r12, r1
        bne               1f
        strexh            r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u16::acquire_relaxed:
        uxth              r1, r1
0:
        <unknown>
        cmp               r12, r1
        bne               1f
        strexh            r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u16::relaxed_acquire:
        uxth              r1, r1
0:
        <unknown>
        cmp               r12, r1
        bne               1f
        strexh            r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u16::relaxed_relaxed:
        uxth              r1, r1
0:
        ldrexh            r12, [r0]
        cmp               r12, r1
        bne               1f
        strexh            r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u16::release_acquire:
        uxth              r1, r1
0:
        <unknown>
        cmp               r12, r1
        bne               1f
        <unknown>
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u16::release_relaxed:
        uxth              r1, r1
0:
        ldrexh            r12, [r0]
        cmp               r12, r1
        bne               1f
        <unknown>
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u32::acqrel_seqcst:
0:
        <unknown>
        cmp               r12, r1
        bne               1f
        <unknown>
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u32::seqcst_seqcst:
0:
        <unknown>
        cmp               r12, r1
        bne               1f
        <unknown>
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u32::acqrel_acquire:
0:
        <unknown>
        cmp               r12, r1
        bne               1f
        <unknown>
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u32::acqrel_relaxed:
0:
        <unknown>
        cmp               r12, r1
        bne               1f
        <unknown>
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u32::acquire_seqcst:
0:
        <unknown>
        cmp               r12, r1
        bne               1f
        <unknown>
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u32::relaxed_seqcst:
0:
        <unknown>
        cmp               r12, r1
        bne               1f
        <unknown>
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u32::release_seqcst:
0:
        <unknown>
        cmp               r12, r1
        bne               1f
        <unknown>
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u32::seqcst_acquire:
0:
        <unknown>
        cmp               r12, r1
        bne               1f
        <unknown>
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u32::seqcst_relaxed:
0:
        <unknown>
        cmp               r12, r1
        bne               1f
        <unknown>
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u32::acquire_acquire:
0:
        <unknown>
        cmp               r12, r1
        bne               1f
        strex             r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u32::acquire_relaxed:
0:
        <unknown>
        cmp               r12, r1
        bne               1f
        strex             r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u32::relaxed_acquire:
0:
        <unknown>
        cmp               r12, r1
        bne               1f
        strex             r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u32::relaxed_relaxed:
0:
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        strex             r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u32::release_acquire:
0:
        <unknown>
        cmp               r12, r1
        bne               1f
        <unknown>
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u32::release_relaxed:
0:
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        <unknown>
        cbz               r3, 2f
        b                 0b
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u64::acqrel_seqcst:
        push.w            {r4, r5, r6, r7, r11, lr}
        mov               r12, r3
        mov               lr, r2
        mov               r6, r1
        ldrd              r4, r5, [sp, #24]
0:
        <unknown>
        eor.w             r7, r3, r12
        eor.w             r1, r2, lr
        orrs              r1, r7
        bne               1f
        <unknown>
        cbz               r1, 2f
        b                 0b
1:
        clrex
        mov.w             r1, #0x1
2:
        strd              r2, r3, [r0]
        eor               r1, r1, #0x1
        strb              r1, [r0, #0x8]
        pop.w             {r4, r5, r6, r7, r11, pc}

asm_test::compare_exchange::u64::seqcst_seqcst:
        push.w            {r4, r5, r6, r7, r11, lr}
        mov               r12, r3
        mov               lr, r2
        mov               r6, r1
        ldrd              r4, r5, [sp, #24]
0:
        <unknown>
        eor.w             r7, r3, r12
        eor.w             r1, r2, lr
        orrs              r1, r7
        bne               1f
        <unknown>
        cbz               r1, 2f
        b                 0b
1:
        clrex
        mov.w             r1, #0x1
2:
        strd              r2, r3, [r0]
        eor               r1, r1, #0x1
        strb              r1, [r0, #0x8]
        pop.w             {r4, r5, r6, r7, r11, pc}

asm_test::compare_exchange::u64::acqrel_acquire:
        push.w            {r4, r5, r6, r7, r11, lr}
        mov               r12, r3
        mov               lr, r2
        mov               r6, r1
        ldrd              r4, r5, [sp, #24]
0:
        <unknown>
        eor.w             r7, r3, r12
        eor.w             r1, r2, lr
        orrs              r1, r7
        bne               1f
        <unknown>
        cbz               r1, 2f
        b                 0b
1:
        clrex
        mov.w             r1, #0x1
2:
        strd              r2, r3, [r0]
        eor               r1, r1, #0x1
        strb              r1, [r0, #0x8]
        pop.w             {r4, r5, r6, r7, r11, pc}

asm_test::compare_exchange::u64::acqrel_relaxed:
        push.w            {r4, r5, r6, r7, r11, lr}
        mov               r12, r3
        mov               lr, r2
        mov               r6, r1
        ldrd              r4, r5, [sp, #24]
0:
        <unknown>
        eor.w             r7, r3, r12
        eor.w             r1, r2, lr
        orrs              r1, r7
        bne               1f
        <unknown>
        cbz               r1, 2f
        b                 0b
1:
        clrex
        mov.w             r1, #0x1
2:
        strd              r2, r3, [r0]
        eor               r1, r1, #0x1
        strb              r1, [r0, #0x8]
        pop.w             {r4, r5, r6, r7, r11, pc}

asm_test::compare_exchange::u64::acquire_seqcst:
        push.w            {r4, r5, r6, r7, r11, lr}
        mov               r12, r3
        mov               lr, r2
        mov               r6, r1
        ldrd              r4, r5, [sp, #24]
0:
        <unknown>
        eor.w             r7, r3, r12
        eor.w             r1, r2, lr
        orrs              r1, r7
        bne               1f
        <unknown>
        cbz               r1, 2f
        b                 0b
1:
        clrex
        mov.w             r1, #0x1
2:
        strd              r2, r3, [r0]
        eor               r1, r1, #0x1
        strb              r1, [r0, #0x8]
        pop.w             {r4, r5, r6, r7, r11, pc}

asm_test::compare_exchange::u64::relaxed_seqcst:
        push.w            {r4, r5, r6, r7, r11, lr}
        mov               r12, r3
        mov               lr, r2
        mov               r6, r1
        ldrd              r4, r5, [sp, #24]
0:
        <unknown>
        eor.w             r7, r3, r12
        eor.w             r1, r2, lr
        orrs              r1, r7
        bne               1f
        <unknown>
        cbz               r1, 2f
        b                 0b
1:
        clrex
        mov.w             r1, #0x1
2:
        strd              r2, r3, [r0]
        eor               r1, r1, #0x1
        strb              r1, [r0, #0x8]
        pop.w             {r4, r5, r6, r7, r11, pc}

asm_test::compare_exchange::u64::release_seqcst:
        push.w            {r4, r5, r6, r7, r11, lr}
        mov               r12, r3
        mov               lr, r2
        mov               r6, r1
        ldrd              r4, r5, [sp, #24]
0:
        <unknown>
        eor.w             r7, r3, r12
        eor.w             r1, r2, lr
        orrs              r1, r7
        bne               1f
        <unknown>
        cbz               r1, 2f
        b                 0b
1:
        clrex
        mov.w             r1, #0x1
2:
        strd              r2, r3, [r0]
        eor               r1, r1, #0x1
        strb              r1, [r0, #0x8]
        pop.w             {r4, r5, r6, r7, r11, pc}

asm_test::compare_exchange::u64::seqcst_acquire:
        push.w            {r4, r5, r6, r7, r11, lr}
        mov               r12, r3
        mov               lr, r2
        mov               r6, r1
        ldrd              r4, r5, [sp, #24]
0:
        <unknown>
        eor.w             r7, r3, r12
        eor.w             r1, r2, lr
        orrs              r1, r7
        bne               1f
        <unknown>
        cbz               r1, 2f
        b                 0b
1:
        clrex
        mov.w             r1, #0x1
2:
        strd              r2, r3, [r0]
        eor               r1, r1, #0x1
        strb              r1, [r0, #0x8]
        pop.w             {r4, r5, r6, r7, r11, pc}

asm_test::compare_exchange::u64::seqcst_relaxed:
        push.w            {r4, r5, r6, r7, r11, lr}
        mov               r12, r3
        mov               lr, r2
        mov               r6, r1
        ldrd              r4, r5, [sp, #24]
0:
        <unknown>
        eor.w             r7, r3, r12
        eor.w             r1, r2, lr
        orrs              r1, r7
        bne               1f
        <unknown>
        cbz               r1, 2f
        b                 0b
1:
        clrex
        mov.w             r1, #0x1
2:
        strd              r2, r3, [r0]
        eor               r1, r1, #0x1
        strb              r1, [r0, #0x8]
        pop.w             {r4, r5, r6, r7, r11, pc}

asm_test::compare_exchange::u64::acquire_acquire:
        push.w            {r4, r5, r6, r7, r11, lr}
        mov               r12, r3
        mov               lr, r2
        mov               r6, r1
        ldrd              r4, r5, [sp, #24]
0:
        <unknown>
        eor.w             r7, r3, r12
        eor.w             r1, r2, lr
        orrs              r1, r7
        bne               1f
        strexd            r1, r4, r5, [r6]
        cbz               r1, 2f
        b                 0b
1:
        clrex
        mov.w             r1, #0x1
2:
        strd              r2, r3, [r0]
        eor               r1, r1, #0x1
        strb              r1, [r0, #0x8]
        pop.w             {r4, r5, r6, r7, r11, pc}

asm_test::compare_exchange::u64::acquire_relaxed:
        push.w            {r4, r5, r6, r7, r11, lr}
        mov               r12, r3
        mov               lr, r2
        mov               r6, r1
        ldrd              r4, r5, [sp, #24]
0:
        <unknown>
        eor.w             r7, r3, r12
        eor.w             r1, r2, lr
        orrs              r1, r7
        bne               1f
        strexd            r1, r4, r5, [r6]
        cbz               r1, 2f
        b                 0b
1:
        clrex
        mov.w             r1, #0x1
2:
        strd              r2, r3, [r0]
        eor               r1, r1, #0x1
        strb              r1, [r0, #0x8]
        pop.w             {r4, r5, r6, r7, r11, pc}

asm_test::compare_exchange::u64::relaxed_acquire:
        push.w            {r4, r5, r6, r7, r11, lr}
        mov               r12, r3
        mov               lr, r2
        mov               r6, r1
        ldrd              r4, r5, [sp, #24]
0:
        <unknown>
        eor.w             r7, r3, r12
        eor.w             r1, r2, lr
        orrs              r1, r7
        bne               1f
        strexd            r1, r4, r5, [r6]
        cbz               r1, 2f
        b                 0b
1:
        clrex
        mov.w             r1, #0x1
2:
        strd              r2, r3, [r0]
        eor               r1, r1, #0x1
        strb              r1, [r0, #0x8]
        pop.w             {r4, r5, r6, r7, r11, pc}

asm_test::compare_exchange::u64::relaxed_relaxed:
        push.w            {r4, r5, r6, r7, r11, lr}
        mov               r12, r3
        mov               lr, r2
        mov               r6, r1
        ldrd              r4, r5, [sp, #24]
0:
        ldrexd            r2, r3, [r6]
        eor.w             r7, r3, r12
        eor.w             r1, r2, lr
        orrs              r1, r7
        bne               1f
        strexd            r1, r4, r5, [r6]
        cbz               r1, 2f
        b                 0b
1:
        clrex
        mov.w             r1, #0x1
2:
        strd              r2, r3, [r0]
        eor               r1, r1, #0x1
        strb              r1, [r0, #0x8]
        pop.w             {r4, r5, r6, r7, r11, pc}

asm_test::compare_exchange::u64::release_acquire:
        push.w            {r4, r5, r6, r7, r11, lr}
        mov               r12, r3
        mov               lr, r2
        mov               r6, r1
        ldrd              r4, r5, [sp, #24]
0:
        <unknown>
        eor.w             r7, r3, r12
        eor.w             r1, r2, lr
        orrs              r1, r7
        bne               1f
        <unknown>
        cbz               r1, 2f
        b                 0b
1:
        clrex
        mov.w             r1, #0x1
2:
        strd              r2, r3, [r0]
        eor               r1, r1, #0x1
        strb              r1, [r0, #0x8]
        pop.w             {r4, r5, r6, r7, r11, pc}

asm_test::compare_exchange::u64::release_relaxed:
        push.w            {r4, r5, r6, r7, r11, lr}
        mov               r12, r3
        mov               lr, r2
        mov               r6, r1
        ldrd              r4, r5, [sp, #24]
0:
        ldrexd            r2, r3, [r6]
        eor.w             r7, r3, r12
        eor.w             r1, r2, lr
        orrs              r1, r7
        bne               1f
        <unknown>
        cbz               r1, 2f
        b                 0b
1:
        clrex
        mov.w             r1, #0x1
2:
        strd              r2, r3, [r0]
        eor               r1, r1, #0x1
        strb              r1, [r0, #0x8]
        pop.w             {r4, r5, r6, r7, r11, pc}

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        uxtb              r1, r1
        <unknown>
        cmp               r12, r1
        bne               0f
        <unknown>
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        uxtb              r1, r1
        <unknown>
        cmp               r12, r1
        bne               0f
        <unknown>
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        uxtb              r1, r1
        <unknown>
        cmp               r12, r1
        bne               0f
        <unknown>
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        uxtb              r1, r1
        <unknown>
        cmp               r12, r1
        bne               0f
        <unknown>
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        uxtb              r1, r1
        <unknown>
        cmp               r12, r1
        bne               0f
        <unknown>
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        uxtb              r1, r1
        <unknown>
        cmp               r12, r1
        bne               0f
        <unknown>
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u8::release_seqcst:
        uxtb              r1, r1
        <unknown>
        cmp               r12, r1
        bne               0f
        <unknown>
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        uxtb              r1, r1
        <unknown>
        cmp               r12, r1
        bne               0f
        <unknown>
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        uxtb              r1, r1
        <unknown>
        cmp               r12, r1
        bne               0f
        <unknown>
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u8::acquire_acquire:
        uxtb              r1, r1
        <unknown>
        cmp               r12, r1
        bne               0f
        strexb            r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        uxtb              r1, r1
        <unknown>
        cmp               r12, r1
        bne               0f
        strexb            r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        uxtb              r1, r1
        <unknown>
        cmp               r12, r1
        bne               0f
        strexb            r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        uxtb              r1, r1
        ldrexb            r12, [r0]
        cmp               r12, r1
        bne               0f
        strexb            r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u8::release_acquire:
        uxtb              r1, r1
        <unknown>
        cmp               r12, r1
        bne               0f
        <unknown>
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u8::release_relaxed:
        uxtb              r1, r1
        ldrexb            r12, [r0]
        cmp               r12, r1
        bne               0f
        <unknown>
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        uxth              r1, r1
        <unknown>
        cmp               r12, r1
        bne               0f
        <unknown>
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        uxth              r1, r1
        <unknown>
        cmp               r12, r1
        bne               0f
        <unknown>
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        uxth              r1, r1
        <unknown>
        cmp               r12, r1
        bne               0f
        <unknown>
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        uxth              r1, r1
        <unknown>
        cmp               r12, r1
        bne               0f
        <unknown>
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        uxth              r1, r1
        <unknown>
        cmp               r12, r1
        bne               0f
        <unknown>
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        uxth              r1, r1
        <unknown>
        cmp               r12, r1
        bne               0f
        <unknown>
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u16::release_seqcst:
        uxth              r1, r1
        <unknown>
        cmp               r12, r1
        bne               0f
        <unknown>
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        uxth              r1, r1
        <unknown>
        cmp               r12, r1
        bne               0f
        <unknown>
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        uxth              r1, r1
        <unknown>
        cmp               r12, r1
        bne               0f
        <unknown>
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u16::acquire_acquire:
        uxth              r1, r1
        <unknown>
        cmp               r12, r1
        bne               0f
        strexh            r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        uxth              r1, r1
        <unknown>
        cmp               r12, r1
        bne               0f
        strexh            r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        uxth              r1, r1
        <unknown>
        cmp               r12, r1
        bne               0f
        strexh            r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        uxth              r1, r1
        ldrexh            r12, [r0]
        cmp               r12, r1
        bne               0f
        strexh            r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u16::release_acquire:
        uxth              r1, r1
        <unknown>
        cmp               r12, r1
        bne               0f
        <unknown>
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u16::release_relaxed:
        uxth              r1, r1
        ldrexh            r12, [r0]
        cmp               r12, r1
        bne               0f
        <unknown>
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        <unknown>
        cmp               r12, r1
        bne               0f
        <unknown>
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        <unknown>
        cmp               r12, r1
        bne               0f
        <unknown>
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        <unknown>
        cmp               r12, r1
        bne               0f
        <unknown>
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        <unknown>
        cmp               r12, r1
        bne               0f
        <unknown>
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        <unknown>
        cmp               r12, r1
        bne               0f
        <unknown>
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        <unknown>
        cmp               r12, r1
        bne               0f
        <unknown>
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u32::release_seqcst:
        <unknown>
        cmp               r12, r1
        bne               0f
        <unknown>
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        <unknown>
        cmp               r12, r1
        bne               0f
        <unknown>
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        <unknown>
        cmp               r12, r1
        bne               0f
        <unknown>
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u32::acquire_acquire:
        <unknown>
        cmp               r12, r1
        bne               0f
        strex             r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        <unknown>
        cmp               r12, r1
        bne               0f
        strex             r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        <unknown>
        cmp               r12, r1
        bne               0f
        strex             r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        strex             r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u32::release_acquire:
        <unknown>
        cmp               r12, r1
        bne               0f
        <unknown>
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u32::release_relaxed:
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        <unknown>
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u64::acqrel_seqcst:
        push.w            {r4, r5, r6, r7, r11, lr}
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
        <unknown>
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        bne               0f
        <unknown>
        b                 1f
0:
        clrex
        mov.w             r6, #0x1
1:
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop.w             {r4, r5, r6, r7, r11, pc}

asm_test::compare_exchange_weak::u64::seqcst_seqcst:
        push.w            {r4, r5, r6, r7, r11, lr}
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
        <unknown>
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        bne               0f
        <unknown>
        b                 1f
0:
        clrex
        mov.w             r6, #0x1
1:
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop.w             {r4, r5, r6, r7, r11, pc}

asm_test::compare_exchange_weak::u64::acqrel_acquire:
        push.w            {r4, r5, r6, r7, r11, lr}
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
        <unknown>
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        bne               0f
        <unknown>
        b                 1f
0:
        clrex
        mov.w             r6, #0x1
1:
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop.w             {r4, r5, r6, r7, r11, pc}

asm_test::compare_exchange_weak::u64::acqrel_relaxed:
        push.w            {r4, r5, r6, r7, r11, lr}
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
        <unknown>
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        bne               0f
        <unknown>
        b                 1f
0:
        clrex
        mov.w             r6, #0x1
1:
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop.w             {r4, r5, r6, r7, r11, pc}

asm_test::compare_exchange_weak::u64::acquire_seqcst:
        push.w            {r4, r5, r6, r7, r11, lr}
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
        <unknown>
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        bne               0f
        <unknown>
        b                 1f
0:
        clrex
        mov.w             r6, #0x1
1:
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop.w             {r4, r5, r6, r7, r11, pc}

asm_test::compare_exchange_weak::u64::relaxed_seqcst:
        push.w            {r4, r5, r6, r7, r11, lr}
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
        <unknown>
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        bne               0f
        <unknown>
        b                 1f
0:
        clrex
        mov.w             r6, #0x1
1:
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop.w             {r4, r5, r6, r7, r11, pc}

asm_test::compare_exchange_weak::u64::release_seqcst:
        push.w            {r4, r5, r6, r7, r11, lr}
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
        <unknown>
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        bne               0f
        <unknown>
        b                 1f
0:
        clrex
        mov.w             r6, #0x1
1:
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop.w             {r4, r5, r6, r7, r11, pc}

asm_test::compare_exchange_weak::u64::seqcst_acquire:
        push.w            {r4, r5, r6, r7, r11, lr}
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
        <unknown>
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        bne               0f
        <unknown>
        b                 1f
0:
        clrex
        mov.w             r6, #0x1
1:
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop.w             {r4, r5, r6, r7, r11, pc}

asm_test::compare_exchange_weak::u64::seqcst_relaxed:
        push.w            {r4, r5, r6, r7, r11, lr}
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
        <unknown>
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        bne               0f
        <unknown>
        b                 1f
0:
        clrex
        mov.w             r6, #0x1
1:
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop.w             {r4, r5, r6, r7, r11, pc}

asm_test::compare_exchange_weak::u64::acquire_acquire:
        push.w            {r4, r5, r6, r7, r11, lr}
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
        <unknown>
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        bne               0f
        strexd            r6, r4, r5, [r1]
        b                 1f
0:
        clrex
        mov.w             r6, #0x1
1:
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop.w             {r4, r5, r6, r7, r11, pc}

asm_test::compare_exchange_weak::u64::acquire_relaxed:
        push.w            {r4, r5, r6, r7, r11, lr}
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
        <unknown>
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        bne               0f
        strexd            r6, r4, r5, [r1]
        b                 1f
0:
        clrex
        mov.w             r6, #0x1
1:
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop.w             {r4, r5, r6, r7, r11, pc}

asm_test::compare_exchange_weak::u64::relaxed_acquire:
        push.w            {r4, r5, r6, r7, r11, lr}
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
        <unknown>
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        bne               0f
        strexd            r6, r4, r5, [r1]
        b                 1f
0:
        clrex
        mov.w             r6, #0x1
1:
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop.w             {r4, r5, r6, r7, r11, pc}

asm_test::compare_exchange_weak::u64::relaxed_relaxed:
        push.w            {r4, r5, r6, r7, r11, lr}
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
        ldrexd            r2, r3, [r1]
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        bne               0f
        strexd            r6, r4, r5, [r1]
        b                 1f
0:
        clrex
        mov.w             r6, #0x1
1:
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop.w             {r4, r5, r6, r7, r11, pc}

asm_test::compare_exchange_weak::u64::release_acquire:
        push.w            {r4, r5, r6, r7, r11, lr}
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
        <unknown>
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        bne               0f
        <unknown>
        b                 1f
0:
        clrex
        mov.w             r6, #0x1
1:
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop.w             {r4, r5, r6, r7, r11, pc}

asm_test::compare_exchange_weak::u64::release_relaxed:
        push.w            {r4, r5, r6, r7, r11, lr}
        mov               r12, r3
        mov               lr, r2
        ldrd              r4, r5, [sp, #24]
        ldrexd            r2, r3, [r1]
        eor.w             r7, r3, r12
        eor.w             r6, r2, lr
        orrs              r6, r7
        bne               0f
        <unknown>
        b                 1f
0:
        clrex
        mov.w             r6, #0x1
1:
        eor               r1, r6, #0x1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop.w             {r4, r5, r6, r7, r11, pc}

asm_test::load::u8::seqcst:
        <unknown>
        bx                lr

asm_test::load::u8::acquire:
        <unknown>
        bx                lr

asm_test::load::u8::relaxed:
        ldrb              r0, [r0]
        bx                lr

asm_test::load::u16::seqcst:
        <unknown>
        bx                lr

asm_test::load::u16::acquire:
        <unknown>
        bx                lr

asm_test::load::u16::relaxed:
        ldrh              r0, [r0]
        bx                lr

asm_test::load::u32::seqcst:
        <unknown>
        bx                lr

asm_test::load::u32::acquire:
        <unknown>
        bx                lr

asm_test::load::u32::relaxed:
        ldr               r0, [r0]
        bx                lr

asm_test::load::u64::seqcst:
        <unknown>
        clrex
        bx                lr

asm_test::load::u64::acquire:
        <unknown>
        clrex
        bx                lr

asm_test::load::u64::relaxed:
        ldrexd            r0, r1, [r0]
        clrex
        bx                lr

asm_test::swap::u8::acqrel:
0:
        <unknown>
        <unknown>
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u8::seqcst:
0:
        <unknown>
        <unknown>
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u8::acquire:
0:
        <unknown>
        strexb            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
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
0:
        ldrexb            r2, [r0]
        <unknown>
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u16::acqrel:
0:
        <unknown>
        <unknown>
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u16::seqcst:
0:
        <unknown>
        <unknown>
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u16::acquire:
0:
        <unknown>
        strexh            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
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
0:
        ldrexh            r2, [r0]
        <unknown>
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u32::acqrel:
0:
        <unknown>
        <unknown>
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u32::seqcst:
0:
        <unknown>
        <unknown>
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u32::acquire:
0:
        <unknown>
        strex             r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
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
0:
        ldrex             r2, [r0]
        <unknown>
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u64::acqrel:
        push.w            {r11, lr}
        mov               r12, r0
0:
        <unknown>
        <unknown>
        cmp.w             lr, #0x0
        bne               0b
        pop.w             {r11, pc}

asm_test::swap::u64::seqcst:
        push.w            {r11, lr}
        mov               r12, r0
0:
        <unknown>
        <unknown>
        cmp.w             lr, #0x0
        bne               0b
        pop.w             {r11, pc}

asm_test::swap::u64::acquire:
        push.w            {r11, lr}
        mov               r12, r0
0:
        <unknown>
        strexd            lr, r2, r3, [r12]
        cmp.w             lr, #0x0
        bne               0b
        pop.w             {r11, pc}

asm_test::swap::u64::relaxed:
        push.w            {r11, lr}
        mov               r12, r0
0:
        ldrexd            r0, r1, [r12]
        strexd            lr, r2, r3, [r12]
        cmp.w             lr, #0x0
        bne               0b
        pop.w             {r11, pc}

asm_test::swap::u64::release:
        push.w            {r11, lr}
        mov               r12, r0
0:
        ldrexd            r0, r1, [r12]
        <unknown>
        cmp.w             lr, #0x0
        bne               0b
        pop.w             {r11, pc}

asm_test::store::u8::seqcst:
        <unknown>
        bx                lr

asm_test::store::u8::relaxed:
        strb              r1, [r0]
        bx                lr

asm_test::store::u8::release:
        <unknown>
        bx                lr

asm_test::store::u16::seqcst:
        <unknown>
        bx                lr

asm_test::store::u16::relaxed:
        strh              r1, [r0]
        bx                lr

asm_test::store::u16::release:
        <unknown>
        bx                lr

asm_test::store::u32::seqcst:
        <unknown>
        bx                lr

asm_test::store::u32::relaxed:
        str               r1, [r0]
        bx                lr

asm_test::store::u32::release:
        <unknown>
        bx                lr

asm_test::store::u64::seqcst:
        push.w            {r4, r5, r11, lr}
0:
        <unknown>
        <unknown>
        cmp               r4, #0x0
        bne               0b
        pop.w             {r4, r5, r11, pc}

asm_test::store::u64::relaxed:
        push.w            {r4, r5, r11, lr}
0:
        ldrexd            r4, r5, [r0]
        strexd            r4, r2, r3, [r0]
        cmp               r4, #0x0
        bne               0b
        pop.w             {r4, r5, r11, pc}

asm_test::store::u64::release:
        push.w            {r4, r5, r11, lr}
0:
        ldrexd            r4, r5, [r0]
        <unknown>
        cmp               r4, #0x0
        bne               0b
        pop.w             {r4, r5, r11, pc}
