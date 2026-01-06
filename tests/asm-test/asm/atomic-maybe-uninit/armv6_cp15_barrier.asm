asm_test::compare_exchange::u8::acqrel_seqcst:
        push              {r11, lr}
        uxtb              r12, r1
        mov               r1, #0
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               1f
        mcr               p15, #0x0, r1, c7, c10, #0x5
0:
        strexb            r3, r2, [r0]
        cmp               r3, #0
        beq               2f
        ldrexb            lr, [r0]
        cmp               lr, r12
        beq               0b
1:
        mov               r3, #1
2:
        mcr               p15, #0x0, r1, c7, c10, #0x5
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange::u8::seqcst_seqcst:
        push              {r11, lr}
        uxtb              r12, r1
        mov               r1, #0
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               1f
        mcr               p15, #0x0, r1, c7, c10, #0x5
0:
        strexb            r3, r2, [r0]
        cmp               r3, #0
        beq               2f
        ldrexb            lr, [r0]
        cmp               lr, r12
        beq               0b
1:
        mov               r3, #1
2:
        mcr               p15, #0x0, r1, c7, c10, #0x5
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange::u8::acqrel_acquire:
        push              {r11, lr}
        uxtb              r12, r1
        mov               r1, #0
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               1f
        mcr               p15, #0x0, r1, c7, c10, #0x5
0:
        strexb            r3, r2, [r0]
        cmp               r3, #0
        beq               2f
        ldrexb            lr, [r0]
        cmp               lr, r12
        beq               0b
1:
        mov               r3, #1
2:
        mcr               p15, #0x0, r1, c7, c10, #0x5
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange::u8::acqrel_relaxed:
        push              {r11, lr}
        uxtb              r12, r1
        mov               r1, #0
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               1f
        mcr               p15, #0x0, r1, c7, c10, #0x5
0:
        strexb            r3, r2, [r0]
        cmp               r3, #0
        beq               2f
        ldrexb            lr, [r0]
        cmp               lr, r12
        beq               0b
1:
        mov               r3, #1
        b                 3f
2:
        mcr               p15, #0x0, r1, c7, c10, #0x5
3:
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange::u8::acquire_seqcst:
        push              {r11, lr}
        uxtb              r12, r1
        mov               r1, #0
0:
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               1f
        strexb            r3, r2, [r0]
        cmp               r3, #0
        bne               0b
        mcr               p15, #0x0, r1, c7, c10, #0x5
        b                 2f
1:
        mov               r3, #1
        mcr               p15, #0x0, r1, c7, c10, #0x5
2:
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange::u8::relaxed_seqcst:
        push              {r11, lr}
        uxtb              r12, r1
        mov               r1, #0
0:
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               1f
        strexb            r3, r2, [r0]
        cmp               r3, #0
        bne               0b
        b                 2f
1:
        mov               r3, #1
        mcr               p15, #0x0, r1, c7, c10, #0x5
2:
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange::u8::release_seqcst:
        push              {r11, lr}
        uxtb              r12, r1
        mov               r1, #0
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               1f
        mcr               p15, #0x0, r1, c7, c10, #0x5
0:
        strexb            r3, r2, [r0]
        cmp               r3, #0
        beq               2f
        ldrexb            lr, [r0]
        cmp               lr, r12
        beq               0b
1:
        mov               r3, #1
        mcr               p15, #0x0, r1, c7, c10, #0x5
2:
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange::u8::seqcst_acquire:
        push              {r11, lr}
        uxtb              r12, r1
        mov               r1, #0
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               1f
        mcr               p15, #0x0, r1, c7, c10, #0x5
0:
        strexb            r3, r2, [r0]
        cmp               r3, #0
        beq               2f
        ldrexb            lr, [r0]
        cmp               lr, r12
        beq               0b
1:
        mov               r3, #1
2:
        mcr               p15, #0x0, r1, c7, c10, #0x5
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange::u8::seqcst_relaxed:
        push              {r11, lr}
        uxtb              r12, r1
        mov               r1, #0
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               1f
        mcr               p15, #0x0, r1, c7, c10, #0x5
0:
        strexb            r3, r2, [r0]
        cmp               r3, #0
        beq               2f
        ldrexb            lr, [r0]
        cmp               lr, r12
        beq               0b
1:
        mov               r3, #1
        b                 3f
2:
        mcr               p15, #0x0, r1, c7, c10, #0x5
3:
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange::u8::acquire_acquire:
        push              {r11, lr}
        uxtb              r12, r1
        mov               r1, #0
0:
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               1f
        strexb            r3, r2, [r0]
        cmp               r3, #0
        bne               0b
        mcr               p15, #0x0, r1, c7, c10, #0x5
        b                 2f
1:
        mov               r3, #1
        mcr               p15, #0x0, r1, c7, c10, #0x5
2:
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange::u8::acquire_relaxed:
        push              {r11, lr}
        uxtb              r12, r1
        mov               r1, #0
0:
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               1f
        strexb            r3, r2, [r0]
        cmp               r3, #0
        bne               0b
        mcr               p15, #0x0, r1, c7, c10, #0x5
        b                 2f
1:
        mov               r3, #1
2:
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange::u8::relaxed_acquire:
        push              {r11, lr}
        uxtb              r12, r1
        mov               r1, #0
0:
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               1f
        strexb            r3, r2, [r0]
        cmp               r3, #0
        bne               0b
        b                 2f
1:
        mov               r3, #1
        mcr               p15, #0x0, r1, c7, c10, #0x5
2:
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange::u8::relaxed_relaxed:
        uxtb              r1, r1
0:
        ldrexb            r12, [r0]
        cmp               r12, r1
        bne               1f
        strexb            r3, r2, [r0]
        cmp               r3, #0
        bne               0b
        b                 2f
1:
        mov               r3, #1
2:
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u8::release_acquire:
        push              {r11, lr}
        uxtb              r12, r1
        mov               r1, #0
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               1f
        mcr               p15, #0x0, r1, c7, c10, #0x5
0:
        strexb            r3, r2, [r0]
        cmp               r3, #0
        beq               2f
        ldrexb            lr, [r0]
        cmp               lr, r12
        beq               0b
1:
        mov               r3, #1
        mcr               p15, #0x0, r1, c7, c10, #0x5
2:
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange::u8::release_relaxed:
        push              {r11, lr}
        uxtb              r12, r1
        mov               r1, #0
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               1f
        mcr               p15, #0x0, r1, c7, c10, #0x5
0:
        strexb            r3, r2, [r0]
        cmp               r3, #0
        beq               2f
        ldrexb            lr, [r0]
        cmp               lr, r12
        beq               0b
1:
        mov               r3, #1
2:
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange::u16::acqrel_seqcst:
        push              {r11, lr}
        uxth              r12, r1
        mov               r1, #0
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               1f
        mcr               p15, #0x0, r1, c7, c10, #0x5
0:
        strexh            r3, r2, [r0]
        cmp               r3, #0
        beq               2f
        ldrexh            lr, [r0]
        cmp               lr, r12
        beq               0b
1:
        mov               r3, #1
2:
        mcr               p15, #0x0, r1, c7, c10, #0x5
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange::u16::seqcst_seqcst:
        push              {r11, lr}
        uxth              r12, r1
        mov               r1, #0
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               1f
        mcr               p15, #0x0, r1, c7, c10, #0x5
0:
        strexh            r3, r2, [r0]
        cmp               r3, #0
        beq               2f
        ldrexh            lr, [r0]
        cmp               lr, r12
        beq               0b
1:
        mov               r3, #1
2:
        mcr               p15, #0x0, r1, c7, c10, #0x5
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange::u16::acqrel_acquire:
        push              {r11, lr}
        uxth              r12, r1
        mov               r1, #0
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               1f
        mcr               p15, #0x0, r1, c7, c10, #0x5
0:
        strexh            r3, r2, [r0]
        cmp               r3, #0
        beq               2f
        ldrexh            lr, [r0]
        cmp               lr, r12
        beq               0b
1:
        mov               r3, #1
2:
        mcr               p15, #0x0, r1, c7, c10, #0x5
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange::u16::acqrel_relaxed:
        push              {r11, lr}
        uxth              r12, r1
        mov               r1, #0
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               1f
        mcr               p15, #0x0, r1, c7, c10, #0x5
0:
        strexh            r3, r2, [r0]
        cmp               r3, #0
        beq               2f
        ldrexh            lr, [r0]
        cmp               lr, r12
        beq               0b
1:
        mov               r3, #1
        b                 3f
2:
        mcr               p15, #0x0, r1, c7, c10, #0x5
3:
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange::u16::acquire_seqcst:
        push              {r11, lr}
        uxth              r12, r1
        mov               r1, #0
0:
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               1f
        strexh            r3, r2, [r0]
        cmp               r3, #0
        bne               0b
        mcr               p15, #0x0, r1, c7, c10, #0x5
        b                 2f
1:
        mov               r3, #1
        mcr               p15, #0x0, r1, c7, c10, #0x5
2:
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange::u16::relaxed_seqcst:
        push              {r11, lr}
        uxth              r12, r1
        mov               r1, #0
0:
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               1f
        strexh            r3, r2, [r0]
        cmp               r3, #0
        bne               0b
        b                 2f
1:
        mov               r3, #1
        mcr               p15, #0x0, r1, c7, c10, #0x5
2:
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange::u16::release_seqcst:
        push              {r11, lr}
        uxth              r12, r1
        mov               r1, #0
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               1f
        mcr               p15, #0x0, r1, c7, c10, #0x5
0:
        strexh            r3, r2, [r0]
        cmp               r3, #0
        beq               2f
        ldrexh            lr, [r0]
        cmp               lr, r12
        beq               0b
1:
        mov               r3, #1
        mcr               p15, #0x0, r1, c7, c10, #0x5
2:
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange::u16::seqcst_acquire:
        push              {r11, lr}
        uxth              r12, r1
        mov               r1, #0
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               1f
        mcr               p15, #0x0, r1, c7, c10, #0x5
0:
        strexh            r3, r2, [r0]
        cmp               r3, #0
        beq               2f
        ldrexh            lr, [r0]
        cmp               lr, r12
        beq               0b
1:
        mov               r3, #1
2:
        mcr               p15, #0x0, r1, c7, c10, #0x5
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange::u16::seqcst_relaxed:
        push              {r11, lr}
        uxth              r12, r1
        mov               r1, #0
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               1f
        mcr               p15, #0x0, r1, c7, c10, #0x5
0:
        strexh            r3, r2, [r0]
        cmp               r3, #0
        beq               2f
        ldrexh            lr, [r0]
        cmp               lr, r12
        beq               0b
1:
        mov               r3, #1
        b                 3f
2:
        mcr               p15, #0x0, r1, c7, c10, #0x5
3:
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange::u16::acquire_acquire:
        push              {r11, lr}
        uxth              r12, r1
        mov               r1, #0
0:
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               1f
        strexh            r3, r2, [r0]
        cmp               r3, #0
        bne               0b
        mcr               p15, #0x0, r1, c7, c10, #0x5
        b                 2f
1:
        mov               r3, #1
        mcr               p15, #0x0, r1, c7, c10, #0x5
2:
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange::u16::acquire_relaxed:
        push              {r11, lr}
        uxth              r12, r1
        mov               r1, #0
0:
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               1f
        strexh            r3, r2, [r0]
        cmp               r3, #0
        bne               0b
        mcr               p15, #0x0, r1, c7, c10, #0x5
        b                 2f
1:
        mov               r3, #1
2:
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange::u16::relaxed_acquire:
        push              {r11, lr}
        uxth              r12, r1
        mov               r1, #0
0:
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               1f
        strexh            r3, r2, [r0]
        cmp               r3, #0
        bne               0b
        b                 2f
1:
        mov               r3, #1
        mcr               p15, #0x0, r1, c7, c10, #0x5
2:
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange::u16::relaxed_relaxed:
        uxth              r1, r1
0:
        ldrexh            r12, [r0]
        cmp               r12, r1
        bne               1f
        strexh            r3, r2, [r0]
        cmp               r3, #0
        bne               0b
        b                 2f
1:
        mov               r3, #1
2:
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u16::release_acquire:
        push              {r11, lr}
        uxth              r12, r1
        mov               r1, #0
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               1f
        mcr               p15, #0x0, r1, c7, c10, #0x5
0:
        strexh            r3, r2, [r0]
        cmp               r3, #0
        beq               2f
        ldrexh            lr, [r0]
        cmp               lr, r12
        beq               0b
1:
        mov               r3, #1
        mcr               p15, #0x0, r1, c7, c10, #0x5
2:
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange::u16::release_relaxed:
        push              {r11, lr}
        uxth              r12, r1
        mov               r1, #0
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               1f
        mcr               p15, #0x0, r1, c7, c10, #0x5
0:
        strexh            r3, r2, [r0]
        cmp               r3, #0
        beq               2f
        ldrexh            lr, [r0]
        cmp               lr, r12
        beq               0b
1:
        mov               r3, #1
2:
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange::u32::acqrel_seqcst:
        push              {r11, lr}
        mov               r3, #0
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        mcr               p15, #0x0, r3, c7, c10, #0x5
0:
        strex             lr, r2, [r0]
        cmp               lr, #0
        beq               2f
        ldrex             r12, [r0]
        cmp               r12, r1
        beq               0b
1:
        mov               lr, #1
2:
        mcr               p15, #0x0, r3, c7, c10, #0x5
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}

asm_test::compare_exchange::u32::seqcst_seqcst:
        push              {r11, lr}
        mov               r3, #0
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        mcr               p15, #0x0, r3, c7, c10, #0x5
0:
        strex             lr, r2, [r0]
        cmp               lr, #0
        beq               2f
        ldrex             r12, [r0]
        cmp               r12, r1
        beq               0b
1:
        mov               lr, #1
2:
        mcr               p15, #0x0, r3, c7, c10, #0x5
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}

asm_test::compare_exchange::u32::acqrel_acquire:
        push              {r11, lr}
        mov               r3, #0
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        mcr               p15, #0x0, r3, c7, c10, #0x5
0:
        strex             lr, r2, [r0]
        cmp               lr, #0
        beq               2f
        ldrex             r12, [r0]
        cmp               r12, r1
        beq               0b
1:
        mov               lr, #1
2:
        mcr               p15, #0x0, r3, c7, c10, #0x5
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}

asm_test::compare_exchange::u32::acqrel_relaxed:
        push              {r11, lr}
        mov               r3, #0
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        mcr               p15, #0x0, r3, c7, c10, #0x5
0:
        strex             lr, r2, [r0]
        cmp               lr, #0
        beq               2f
        ldrex             r12, [r0]
        cmp               r12, r1
        beq               0b
1:
        mov               lr, #1
        b                 3f
2:
        mcr               p15, #0x0, r3, c7, c10, #0x5
3:
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}

asm_test::compare_exchange::u32::acquire_seqcst:
        push              {r11, lr}
        mov               r3, #0
0:
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        strex             lr, r2, [r0]
        cmp               lr, #0
        bne               0b
        mcr               p15, #0x0, r3, c7, c10, #0x5
        b                 2f
1:
        mov               lr, #1
        mcr               p15, #0x0, r3, c7, c10, #0x5
2:
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}

asm_test::compare_exchange::u32::relaxed_seqcst:
        push              {r11, lr}
        mov               r3, #0
0:
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        strex             lr, r2, [r0]
        cmp               lr, #0
        bne               0b
        b                 2f
1:
        mov               lr, #1
        mcr               p15, #0x0, r3, c7, c10, #0x5
2:
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}

asm_test::compare_exchange::u32::release_seqcst:
        push              {r11, lr}
        mov               r3, #0
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        mcr               p15, #0x0, r3, c7, c10, #0x5
0:
        strex             lr, r2, [r0]
        cmp               lr, #0
        beq               2f
        ldrex             r12, [r0]
        cmp               r12, r1
        beq               0b
1:
        mov               lr, #1
        mcr               p15, #0x0, r3, c7, c10, #0x5
2:
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}

asm_test::compare_exchange::u32::seqcst_acquire:
        push              {r11, lr}
        mov               r3, #0
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        mcr               p15, #0x0, r3, c7, c10, #0x5
0:
        strex             lr, r2, [r0]
        cmp               lr, #0
        beq               2f
        ldrex             r12, [r0]
        cmp               r12, r1
        beq               0b
1:
        mov               lr, #1
2:
        mcr               p15, #0x0, r3, c7, c10, #0x5
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}

asm_test::compare_exchange::u32::seqcst_relaxed:
        push              {r11, lr}
        mov               r3, #0
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        mcr               p15, #0x0, r3, c7, c10, #0x5
0:
        strex             lr, r2, [r0]
        cmp               lr, #0
        beq               2f
        ldrex             r12, [r0]
        cmp               r12, r1
        beq               0b
1:
        mov               lr, #1
        b                 3f
2:
        mcr               p15, #0x0, r3, c7, c10, #0x5
3:
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}

asm_test::compare_exchange::u32::acquire_acquire:
        push              {r11, lr}
        mov               r3, #0
0:
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        strex             lr, r2, [r0]
        cmp               lr, #0
        bne               0b
        mcr               p15, #0x0, r3, c7, c10, #0x5
        b                 2f
1:
        mov               lr, #1
        mcr               p15, #0x0, r3, c7, c10, #0x5
2:
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}

asm_test::compare_exchange::u32::acquire_relaxed:
        push              {r11, lr}
        mov               r3, #0
0:
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        strex             lr, r2, [r0]
        cmp               lr, #0
        bne               0b
        mcr               p15, #0x0, r3, c7, c10, #0x5
        b                 2f
1:
        mov               lr, #1
2:
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}

asm_test::compare_exchange::u32::relaxed_acquire:
        push              {r11, lr}
        mov               r3, #0
0:
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        strex             lr, r2, [r0]
        cmp               lr, #0
        bne               0b
        b                 2f
1:
        mov               lr, #1
        mcr               p15, #0x0, r3, c7, c10, #0x5
2:
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}

asm_test::compare_exchange::u32::relaxed_relaxed:
0:
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        strex             r3, r2, [r0]
        cmp               r3, #0
        bne               0b
        b                 2f
1:
        mov               r3, #1
2:
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange::u32::release_acquire:
        push              {r11, lr}
        mov               r3, #0
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        mcr               p15, #0x0, r3, c7, c10, #0x5
0:
        strex             lr, r2, [r0]
        cmp               lr, #0
        beq               2f
        ldrex             r12, [r0]
        cmp               r12, r1
        beq               0b
1:
        mov               lr, #1
        mcr               p15, #0x0, r3, c7, c10, #0x5
2:
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}

asm_test::compare_exchange::u32::release_relaxed:
        push              {r11, lr}
        mov               r3, #0
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        mcr               p15, #0x0, r3, c7, c10, #0x5
0:
        strex             lr, r2, [r0]
        cmp               lr, #0
        beq               2f
        ldrex             r12, [r0]
        cmp               r12, r1
        beq               0b
1:
        mov               lr, #1
2:
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}

asm_test::compare_exchange::u64::acqrel_seqcst:
        push              {r4, r5, r6, r7, r8, lr}
        mov               r6, #0
        mov               r12, r3
        mov               lr, r2
        ldr               r4, [sp, #0x18]
        ldr               r5, [sp, #0x1c]
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r8, r2, lr
        orrs              r8, r8, r7
        bne               1f
        mcr               p15, #0x0, r6, c7, c10, #0x5
0:
        strexd            r8, r4, r5, [r1]
        cmp               r8, #0
        beq               2f
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r8, r2, lr
        orrs              r8, r8, r7
        beq               0b
1:
        mov               r8, #1
2:
        mcr               p15, #0x0, r6, c7, c10, #0x5
        eor               r1, r8, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, pc}

asm_test::compare_exchange::u64::seqcst_seqcst:
        push              {r4, r5, r6, r7, r8, lr}
        mov               r6, #0
        mov               r12, r3
        mov               lr, r2
        ldr               r4, [sp, #0x18]
        ldr               r5, [sp, #0x1c]
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r8, r2, lr
        orrs              r8, r8, r7
        bne               1f
        mcr               p15, #0x0, r6, c7, c10, #0x5
0:
        strexd            r8, r4, r5, [r1]
        cmp               r8, #0
        beq               2f
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r8, r2, lr
        orrs              r8, r8, r7
        beq               0b
1:
        mov               r8, #1
2:
        mcr               p15, #0x0, r6, c7, c10, #0x5
        eor               r1, r8, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, pc}

asm_test::compare_exchange::u64::acqrel_acquire:
        push              {r4, r5, r6, r7, r8, lr}
        mov               r6, #0
        mov               r12, r3
        mov               lr, r2
        ldr               r4, [sp, #0x18]
        ldr               r5, [sp, #0x1c]
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r8, r2, lr
        orrs              r8, r8, r7
        bne               1f
        mcr               p15, #0x0, r6, c7, c10, #0x5
0:
        strexd            r8, r4, r5, [r1]
        cmp               r8, #0
        beq               2f
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r8, r2, lr
        orrs              r8, r8, r7
        beq               0b
1:
        mov               r8, #1
2:
        mcr               p15, #0x0, r6, c7, c10, #0x5
        eor               r1, r8, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, pc}

asm_test::compare_exchange::u64::acqrel_relaxed:
        push              {r4, r5, r6, r7, r8, lr}
        mov               r6, #0
        mov               r12, r3
        mov               lr, r2
        ldr               r4, [sp, #0x18]
        ldr               r5, [sp, #0x1c]
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r8, r2, lr
        orrs              r8, r8, r7
        bne               1f
        mcr               p15, #0x0, r6, c7, c10, #0x5
0:
        strexd            r8, r4, r5, [r1]
        cmp               r8, #0
        beq               2f
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r8, r2, lr
        orrs              r8, r8, r7
        beq               0b
1:
        mov               r8, #1
        b                 3f
2:
        mcr               p15, #0x0, r6, c7, c10, #0x5
3:
        eor               r1, r8, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, pc}

asm_test::compare_exchange::u64::acquire_seqcst:
        push              {r4, r5, r6, r7, r8, lr}
        mov               r6, #0
        mov               r12, r3
        mov               lr, r2
        ldr               r4, [sp, #0x18]
        ldr               r5, [sp, #0x1c]
0:
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r8, r2, lr
        orrs              r8, r8, r7
        bne               1f
        strexd            r8, r4, r5, [r1]
        cmp               r8, #0
        bne               0b
        mcr               p15, #0x0, r6, c7, c10, #0x5
        b                 2f
1:
        mov               r8, #1
        mcr               p15, #0x0, r6, c7, c10, #0x5
2:
        eor               r1, r8, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, pc}

asm_test::compare_exchange::u64::relaxed_seqcst:
        push              {r4, r5, r6, r7, r8, lr}
        mov               r6, #0
        mov               r12, r3
        mov               lr, r2
        ldr               r4, [sp, #0x18]
        ldr               r5, [sp, #0x1c]
0:
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r8, r2, lr
        orrs              r8, r8, r7
        bne               1f
        strexd            r8, r4, r5, [r1]
        cmp               r8, #0
        bne               0b
        b                 2f
1:
        mov               r8, #1
        mcr               p15, #0x0, r6, c7, c10, #0x5
2:
        eor               r1, r8, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, pc}

asm_test::compare_exchange::u64::release_seqcst:
        push              {r4, r5, r6, r7, r8, lr}
        mov               r6, #0
        mov               r12, r3
        mov               lr, r2
        ldr               r4, [sp, #0x18]
        ldr               r5, [sp, #0x1c]
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r8, r2, lr
        orrs              r8, r8, r7
        bne               1f
        mcr               p15, #0x0, r6, c7, c10, #0x5
0:
        strexd            r8, r4, r5, [r1]
        cmp               r8, #0
        beq               2f
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r8, r2, lr
        orrs              r8, r8, r7
        beq               0b
1:
        mov               r8, #1
        mcr               p15, #0x0, r6, c7, c10, #0x5
2:
        eor               r1, r8, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, pc}

asm_test::compare_exchange::u64::seqcst_acquire:
        push              {r4, r5, r6, r7, r8, lr}
        mov               r6, #0
        mov               r12, r3
        mov               lr, r2
        ldr               r4, [sp, #0x18]
        ldr               r5, [sp, #0x1c]
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r8, r2, lr
        orrs              r8, r8, r7
        bne               1f
        mcr               p15, #0x0, r6, c7, c10, #0x5
0:
        strexd            r8, r4, r5, [r1]
        cmp               r8, #0
        beq               2f
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r8, r2, lr
        orrs              r8, r8, r7
        beq               0b
1:
        mov               r8, #1
2:
        mcr               p15, #0x0, r6, c7, c10, #0x5
        eor               r1, r8, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, pc}

asm_test::compare_exchange::u64::seqcst_relaxed:
        push              {r4, r5, r6, r7, r8, lr}
        mov               r6, #0
        mov               r12, r3
        mov               lr, r2
        ldr               r4, [sp, #0x18]
        ldr               r5, [sp, #0x1c]
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r8, r2, lr
        orrs              r8, r8, r7
        bne               1f
        mcr               p15, #0x0, r6, c7, c10, #0x5
0:
        strexd            r8, r4, r5, [r1]
        cmp               r8, #0
        beq               2f
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r8, r2, lr
        orrs              r8, r8, r7
        beq               0b
1:
        mov               r8, #1
        b                 3f
2:
        mcr               p15, #0x0, r6, c7, c10, #0x5
3:
        eor               r1, r8, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, pc}

asm_test::compare_exchange::u64::acquire_acquire:
        push              {r4, r5, r6, r7, r8, lr}
        mov               r6, #0
        mov               r12, r3
        mov               lr, r2
        ldr               r4, [sp, #0x18]
        ldr               r5, [sp, #0x1c]
0:
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r8, r2, lr
        orrs              r8, r8, r7
        bne               1f
        strexd            r8, r4, r5, [r1]
        cmp               r8, #0
        bne               0b
        mcr               p15, #0x0, r6, c7, c10, #0x5
        b                 2f
1:
        mov               r8, #1
        mcr               p15, #0x0, r6, c7, c10, #0x5
2:
        eor               r1, r8, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, pc}

asm_test::compare_exchange::u64::acquire_relaxed:
        push              {r4, r5, r6, r7, r8, lr}
        mov               r6, #0
        mov               r12, r3
        mov               lr, r2
        ldr               r4, [sp, #0x18]
        ldr               r5, [sp, #0x1c]
0:
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r8, r2, lr
        orrs              r8, r8, r7
        bne               1f
        strexd            r8, r4, r5, [r1]
        cmp               r8, #0
        bne               0b
        mcr               p15, #0x0, r6, c7, c10, #0x5
        b                 2f
1:
        mov               r8, #1
2:
        eor               r1, r8, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, pc}

asm_test::compare_exchange::u64::relaxed_acquire:
        push              {r4, r5, r6, r7, r8, lr}
        mov               r6, #0
        mov               r12, r3
        mov               lr, r2
        ldr               r4, [sp, #0x18]
        ldr               r5, [sp, #0x1c]
0:
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r8, r2, lr
        orrs              r8, r8, r7
        bne               1f
        strexd            r8, r4, r5, [r1]
        cmp               r8, #0
        bne               0b
        b                 2f
1:
        mov               r8, #1
        mcr               p15, #0x0, r6, c7, c10, #0x5
2:
        eor               r1, r8, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, pc}

asm_test::compare_exchange::u64::relaxed_relaxed:
        push              {r4, r5, r6, r7, r11, lr}
        mov               r12, r3
        mov               lr, r2
        ldr               r4, [sp, #0x18]
        ldr               r5, [sp, #0x1c]
0:
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r6, r2, lr
        orrs              r6, r6, r7
        bne               1f
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0
        bne               0b
        b                 2f
1:
        mov               r6, #1
2:
        eor               r1, r6, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r11, pc}

asm_test::compare_exchange::u64::release_acquire:
        push              {r4, r5, r6, r7, r8, lr}
        mov               r6, #0
        mov               r12, r3
        mov               lr, r2
        ldr               r4, [sp, #0x18]
        ldr               r5, [sp, #0x1c]
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r8, r2, lr
        orrs              r8, r8, r7
        bne               1f
        mcr               p15, #0x0, r6, c7, c10, #0x5
0:
        strexd            r8, r4, r5, [r1]
        cmp               r8, #0
        beq               2f
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r8, r2, lr
        orrs              r8, r8, r7
        beq               0b
1:
        mov               r8, #1
        mcr               p15, #0x0, r6, c7, c10, #0x5
2:
        eor               r1, r8, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, pc}

asm_test::compare_exchange::u64::release_relaxed:
        push              {r4, r5, r6, r7, r8, lr}
        mov               r6, #0
        mov               r12, r3
        mov               lr, r2
        ldr               r4, [sp, #0x18]
        ldr               r5, [sp, #0x1c]
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r8, r2, lr
        orrs              r8, r8, r7
        bne               1f
        mcr               p15, #0x0, r6, c7, c10, #0x5
0:
        strexd            r8, r4, r5, [r1]
        cmp               r8, #0
        beq               2f
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r8, r2, lr
        orrs              r8, r8, r7
        beq               0b
1:
        mov               r8, #1
2:
        eor               r1, r8, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, pc}

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        push              {r11, lr}
        uxtb              r12, r1
        mov               r1, #0
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               0f
        mcr               p15, #0x0, r1, c7, c10, #0x5
        strexb            r3, r2, [r0]
        b                 1f
0:
        mov               r3, #1
1:
        mcr               p15, #0x0, r1, c7, c10, #0x5
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        push              {r11, lr}
        uxtb              r12, r1
        mov               r1, #0
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               0f
        mcr               p15, #0x0, r1, c7, c10, #0x5
        strexb            r3, r2, [r0]
        b                 1f
0:
        mov               r3, #1
1:
        mcr               p15, #0x0, r1, c7, c10, #0x5
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        push              {r11, lr}
        uxtb              r12, r1
        mov               r1, #0
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               0f
        mcr               p15, #0x0, r1, c7, c10, #0x5
        strexb            r3, r2, [r0]
        b                 1f
0:
        mov               r3, #1
1:
        mcr               p15, #0x0, r1, c7, c10, #0x5
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        push              {r11, lr}
        uxtb              r12, r1
        mov               r1, #0
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               0f
        mcr               p15, #0x0, r1, c7, c10, #0x5
        strexb            r3, r2, [r0]
        cmp               r3, #0
        beq               1f
        b                 2f
0:
        mov               r3, #1
        b                 2f
1:
        mcr               p15, #0x0, r1, c7, c10, #0x5
2:
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        push              {r11, lr}
        uxtb              r12, r1
        mov               r1, #0
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               0f
        strexb            r3, r2, [r0]
        b                 1f
0:
        mov               r3, #1
1:
        mcr               p15, #0x0, r1, c7, c10, #0x5
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        push              {r11, lr}
        uxtb              r12, r1
        mov               r1, #0
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               0f
        strexb            r3, r2, [r0]
        cmp               r3, #0
        beq               2f
        b                 1f
0:
        mov               r3, #1
1:
        mcr               p15, #0x0, r1, c7, c10, #0x5
2:
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange_weak::u8::release_seqcst:
        push              {r11, lr}
        uxtb              r12, r1
        mov               r1, #0
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               0f
        mcr               p15, #0x0, r1, c7, c10, #0x5
        strexb            r3, r2, [r0]
        cmp               r3, #0
        beq               2f
        b                 1f
0:
        mov               r3, #1
1:
        mcr               p15, #0x0, r1, c7, c10, #0x5
2:
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        push              {r11, lr}
        uxtb              r12, r1
        mov               r1, #0
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               0f
        mcr               p15, #0x0, r1, c7, c10, #0x5
        strexb            r3, r2, [r0]
        b                 1f
0:
        mov               r3, #1
1:
        mcr               p15, #0x0, r1, c7, c10, #0x5
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        push              {r11, lr}
        uxtb              r12, r1
        mov               r1, #0
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               0f
        mcr               p15, #0x0, r1, c7, c10, #0x5
        strexb            r3, r2, [r0]
        cmp               r3, #0
        beq               1f
        b                 2f
0:
        mov               r3, #1
        b                 2f
1:
        mcr               p15, #0x0, r1, c7, c10, #0x5
2:
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange_weak::u8::acquire_acquire:
        push              {r11, lr}
        uxtb              r12, r1
        mov               r1, #0
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               0f
        strexb            r3, r2, [r0]
        b                 1f
0:
        mov               r3, #1
1:
        mcr               p15, #0x0, r1, c7, c10, #0x5
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        push              {r11, lr}
        uxtb              r12, r1
        mov               r1, #0
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               0f
        strexb            r3, r2, [r0]
        cmp               r3, #0
        beq               1f
        b                 2f
0:
        mov               r3, #1
        b                 2f
1:
        mcr               p15, #0x0, r1, c7, c10, #0x5
2:
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        push              {r11, lr}
        uxtb              r12, r1
        mov               r1, #0
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               0f
        strexb            r3, r2, [r0]
        cmp               r3, #0
        beq               2f
        b                 1f
0:
        mov               r3, #1
1:
        mcr               p15, #0x0, r1, c7, c10, #0x5
2:
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        uxtb              r1, r1
        ldrexb            r12, [r0]
        cmp               r12, r1
        bne               0f
        strexb            r3, r2, [r0]
        b                 1f
0:
        mov               r3, #1
1:
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u8::release_acquire:
        push              {r11, lr}
        uxtb              r12, r1
        mov               r1, #0
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               0f
        mcr               p15, #0x0, r1, c7, c10, #0x5
        strexb            r3, r2, [r0]
        cmp               r3, #0
        beq               2f
        b                 1f
0:
        mov               r3, #1
1:
        mcr               p15, #0x0, r1, c7, c10, #0x5
2:
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange_weak::u8::release_relaxed:
        push              {r11, lr}
        uxtb              r12, r1
        mov               r1, #0
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               0f
        mcr               p15, #0x0, r1, c7, c10, #0x5
        strexb            r3, r2, [r0]
        b                 1f
0:
        mov               r3, #1
1:
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        push              {r11, lr}
        uxth              r12, r1
        mov               r1, #0
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               0f
        mcr               p15, #0x0, r1, c7, c10, #0x5
        strexh            r3, r2, [r0]
        b                 1f
0:
        mov               r3, #1
1:
        mcr               p15, #0x0, r1, c7, c10, #0x5
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        push              {r11, lr}
        uxth              r12, r1
        mov               r1, #0
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               0f
        mcr               p15, #0x0, r1, c7, c10, #0x5
        strexh            r3, r2, [r0]
        b                 1f
0:
        mov               r3, #1
1:
        mcr               p15, #0x0, r1, c7, c10, #0x5
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        push              {r11, lr}
        uxth              r12, r1
        mov               r1, #0
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               0f
        mcr               p15, #0x0, r1, c7, c10, #0x5
        strexh            r3, r2, [r0]
        b                 1f
0:
        mov               r3, #1
1:
        mcr               p15, #0x0, r1, c7, c10, #0x5
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        push              {r11, lr}
        uxth              r12, r1
        mov               r1, #0
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               0f
        mcr               p15, #0x0, r1, c7, c10, #0x5
        strexh            r3, r2, [r0]
        cmp               r3, #0
        beq               1f
        b                 2f
0:
        mov               r3, #1
        b                 2f
1:
        mcr               p15, #0x0, r1, c7, c10, #0x5
2:
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        push              {r11, lr}
        uxth              r12, r1
        mov               r1, #0
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               0f
        strexh            r3, r2, [r0]
        b                 1f
0:
        mov               r3, #1
1:
        mcr               p15, #0x0, r1, c7, c10, #0x5
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        push              {r11, lr}
        uxth              r12, r1
        mov               r1, #0
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               0f
        strexh            r3, r2, [r0]
        cmp               r3, #0
        beq               2f
        b                 1f
0:
        mov               r3, #1
1:
        mcr               p15, #0x0, r1, c7, c10, #0x5
2:
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange_weak::u16::release_seqcst:
        push              {r11, lr}
        uxth              r12, r1
        mov               r1, #0
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               0f
        mcr               p15, #0x0, r1, c7, c10, #0x5
        strexh            r3, r2, [r0]
        cmp               r3, #0
        beq               2f
        b                 1f
0:
        mov               r3, #1
1:
        mcr               p15, #0x0, r1, c7, c10, #0x5
2:
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        push              {r11, lr}
        uxth              r12, r1
        mov               r1, #0
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               0f
        mcr               p15, #0x0, r1, c7, c10, #0x5
        strexh            r3, r2, [r0]
        b                 1f
0:
        mov               r3, #1
1:
        mcr               p15, #0x0, r1, c7, c10, #0x5
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        push              {r11, lr}
        uxth              r12, r1
        mov               r1, #0
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               0f
        mcr               p15, #0x0, r1, c7, c10, #0x5
        strexh            r3, r2, [r0]
        cmp               r3, #0
        beq               1f
        b                 2f
0:
        mov               r3, #1
        b                 2f
1:
        mcr               p15, #0x0, r1, c7, c10, #0x5
2:
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange_weak::u16::acquire_acquire:
        push              {r11, lr}
        uxth              r12, r1
        mov               r1, #0
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               0f
        strexh            r3, r2, [r0]
        b                 1f
0:
        mov               r3, #1
1:
        mcr               p15, #0x0, r1, c7, c10, #0x5
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        push              {r11, lr}
        uxth              r12, r1
        mov               r1, #0
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               0f
        strexh            r3, r2, [r0]
        cmp               r3, #0
        beq               1f
        b                 2f
0:
        mov               r3, #1
        b                 2f
1:
        mcr               p15, #0x0, r1, c7, c10, #0x5
2:
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        push              {r11, lr}
        uxth              r12, r1
        mov               r1, #0
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               0f
        strexh            r3, r2, [r0]
        cmp               r3, #0
        beq               2f
        b                 1f
0:
        mov               r3, #1
1:
        mcr               p15, #0x0, r1, c7, c10, #0x5
2:
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        uxth              r1, r1
        ldrexh            r12, [r0]
        cmp               r12, r1
        bne               0f
        strexh            r3, r2, [r0]
        b                 1f
0:
        mov               r3, #1
1:
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u16::release_acquire:
        push              {r11, lr}
        uxth              r12, r1
        mov               r1, #0
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               0f
        mcr               p15, #0x0, r1, c7, c10, #0x5
        strexh            r3, r2, [r0]
        cmp               r3, #0
        beq               2f
        b                 1f
0:
        mov               r3, #1
1:
        mcr               p15, #0x0, r1, c7, c10, #0x5
2:
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange_weak::u16::release_relaxed:
        push              {r11, lr}
        uxth              r12, r1
        mov               r1, #0
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               0f
        mcr               p15, #0x0, r1, c7, c10, #0x5
        strexh            r3, r2, [r0]
        b                 1f
0:
        mov               r3, #1
1:
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        push              {r11, lr}
        mov               r3, #0
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        mcr               p15, #0x0, r3, c7, c10, #0x5
        strex             lr, r2, [r0]
        b                 1f
0:
        mov               lr, #1
1:
        mcr               p15, #0x0, r3, c7, c10, #0x5
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        push              {r11, lr}
        mov               r3, #0
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        mcr               p15, #0x0, r3, c7, c10, #0x5
        strex             lr, r2, [r0]
        b                 1f
0:
        mov               lr, #1
1:
        mcr               p15, #0x0, r3, c7, c10, #0x5
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        push              {r11, lr}
        mov               r3, #0
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        mcr               p15, #0x0, r3, c7, c10, #0x5
        strex             lr, r2, [r0]
        b                 1f
0:
        mov               lr, #1
1:
        mcr               p15, #0x0, r3, c7, c10, #0x5
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        push              {r11, lr}
        mov               r3, #0
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        mcr               p15, #0x0, r3, c7, c10, #0x5
        strex             lr, r2, [r0]
        cmp               lr, #0
        beq               1f
        b                 2f
0:
        mov               lr, #1
        b                 2f
1:
        mcr               p15, #0x0, r3, c7, c10, #0x5
2:
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        push              {r11, lr}
        mov               r3, #0
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        strex             lr, r2, [r0]
        b                 1f
0:
        mov               lr, #1
1:
        mcr               p15, #0x0, r3, c7, c10, #0x5
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        push              {r11, lr}
        mov               r3, #0
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        strex             lr, r2, [r0]
        cmp               lr, #0
        beq               2f
        b                 1f
0:
        mov               lr, #1
1:
        mcr               p15, #0x0, r3, c7, c10, #0x5
2:
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}

asm_test::compare_exchange_weak::u32::release_seqcst:
        push              {r11, lr}
        mov               r3, #0
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        mcr               p15, #0x0, r3, c7, c10, #0x5
        strex             lr, r2, [r0]
        cmp               lr, #0
        beq               2f
        b                 1f
0:
        mov               lr, #1
1:
        mcr               p15, #0x0, r3, c7, c10, #0x5
2:
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        push              {r11, lr}
        mov               r3, #0
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        mcr               p15, #0x0, r3, c7, c10, #0x5
        strex             lr, r2, [r0]
        b                 1f
0:
        mov               lr, #1
1:
        mcr               p15, #0x0, r3, c7, c10, #0x5
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        push              {r11, lr}
        mov               r3, #0
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        mcr               p15, #0x0, r3, c7, c10, #0x5
        strex             lr, r2, [r0]
        cmp               lr, #0
        beq               1f
        b                 2f
0:
        mov               lr, #1
        b                 2f
1:
        mcr               p15, #0x0, r3, c7, c10, #0x5
2:
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}

asm_test::compare_exchange_weak::u32::acquire_acquire:
        push              {r11, lr}
        mov               r3, #0
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        strex             lr, r2, [r0]
        b                 1f
0:
        mov               lr, #1
1:
        mcr               p15, #0x0, r3, c7, c10, #0x5
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        push              {r11, lr}
        mov               r3, #0
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        strex             lr, r2, [r0]
        cmp               lr, #0
        beq               1f
        b                 2f
0:
        mov               lr, #1
        b                 2f
1:
        mcr               p15, #0x0, r3, c7, c10, #0x5
2:
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        push              {r11, lr}
        mov               r3, #0
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        strex             lr, r2, [r0]
        cmp               lr, #0
        beq               2f
        b                 1f
0:
        mov               lr, #1
1:
        mcr               p15, #0x0, r3, c7, c10, #0x5
2:
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        strex             r3, r2, [r0]
        b                 1f
0:
        mov               r3, #1
1:
        clz               r0, r3
        lsr               r1, r0, #5
        mov               r0, r12
        bx                lr

asm_test::compare_exchange_weak::u32::release_acquire:
        push              {r11, lr}
        mov               r3, #0
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        mcr               p15, #0x0, r3, c7, c10, #0x5
        strex             lr, r2, [r0]
        cmp               lr, #0
        beq               2f
        b                 1f
0:
        mov               lr, #1
1:
        mcr               p15, #0x0, r3, c7, c10, #0x5
2:
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}

asm_test::compare_exchange_weak::u32::release_relaxed:
        push              {r11, lr}
        mov               r3, #0
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        mcr               p15, #0x0, r3, c7, c10, #0x5
        strex             lr, r2, [r0]
        b                 1f
0:
        mov               lr, #1
1:
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}

asm_test::compare_exchange_weak::u64::acqrel_seqcst:
        push              {r4, r5, r6, r7, r8, lr}
        mov               r6, #0
        mov               r12, r3
        mov               lr, r2
        ldr               r4, [sp, #0x18]
        ldr               r5, [sp, #0x1c]
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r8, r2, lr
        orrs              r8, r8, r7
        bne               0f
        mcr               p15, #0x0, r6, c7, c10, #0x5
        strexd            r8, r4, r5, [r1]
        b                 1f
0:
        mov               r8, #1
1:
        mcr               p15, #0x0, r6, c7, c10, #0x5
        eor               r1, r8, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, pc}

asm_test::compare_exchange_weak::u64::seqcst_seqcst:
        push              {r4, r5, r6, r7, r8, lr}
        mov               r6, #0
        mov               r12, r3
        mov               lr, r2
        ldr               r4, [sp, #0x18]
        ldr               r5, [sp, #0x1c]
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r8, r2, lr
        orrs              r8, r8, r7
        bne               0f
        mcr               p15, #0x0, r6, c7, c10, #0x5
        strexd            r8, r4, r5, [r1]
        b                 1f
0:
        mov               r8, #1
1:
        mcr               p15, #0x0, r6, c7, c10, #0x5
        eor               r1, r8, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, pc}

asm_test::compare_exchange_weak::u64::acqrel_acquire:
        push              {r4, r5, r6, r7, r8, lr}
        mov               r6, #0
        mov               r12, r3
        mov               lr, r2
        ldr               r4, [sp, #0x18]
        ldr               r5, [sp, #0x1c]
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r8, r2, lr
        orrs              r8, r8, r7
        bne               0f
        mcr               p15, #0x0, r6, c7, c10, #0x5
        strexd            r8, r4, r5, [r1]
        b                 1f
0:
        mov               r8, #1
1:
        mcr               p15, #0x0, r6, c7, c10, #0x5
        eor               r1, r8, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, pc}

asm_test::compare_exchange_weak::u64::acqrel_relaxed:
        push              {r4, r5, r6, r7, r8, lr}
        mov               r6, #0
        mov               r12, r3
        mov               lr, r2
        ldr               r4, [sp, #0x18]
        ldr               r5, [sp, #0x1c]
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r8, r2, lr
        orrs              r8, r8, r7
        bne               0f
        mcr               p15, #0x0, r6, c7, c10, #0x5
        strexd            r8, r4, r5, [r1]
        cmp               r8, #0
        beq               1f
        b                 2f
0:
        mov               r8, #1
        b                 2f
1:
        mcr               p15, #0x0, r6, c7, c10, #0x5
2:
        eor               r1, r8, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, pc}

asm_test::compare_exchange_weak::u64::acquire_seqcst:
        push              {r4, r5, r6, r7, r8, lr}
        mov               r6, #0
        mov               r12, r3
        mov               lr, r2
        ldr               r4, [sp, #0x18]
        ldr               r5, [sp, #0x1c]
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r8, r2, lr
        orrs              r8, r8, r7
        bne               0f
        strexd            r8, r4, r5, [r1]
        b                 1f
0:
        mov               r8, #1
1:
        mcr               p15, #0x0, r6, c7, c10, #0x5
        eor               r1, r8, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, pc}

asm_test::compare_exchange_weak::u64::relaxed_seqcst:
        push              {r4, r5, r6, r7, r8, lr}
        mov               r6, #0
        mov               r12, r3
        mov               lr, r2
        ldr               r4, [sp, #0x18]
        ldr               r5, [sp, #0x1c]
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r8, r2, lr
        orrs              r8, r8, r7
        bne               0f
        strexd            r8, r4, r5, [r1]
        cmp               r8, #0
        beq               2f
        b                 1f
0:
        mov               r8, #1
1:
        mcr               p15, #0x0, r6, c7, c10, #0x5
2:
        eor               r1, r8, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, pc}

asm_test::compare_exchange_weak::u64::release_seqcst:
        push              {r4, r5, r6, r7, r8, lr}
        mov               r6, #0
        mov               r12, r3
        mov               lr, r2
        ldr               r4, [sp, #0x18]
        ldr               r5, [sp, #0x1c]
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r8, r2, lr
        orrs              r8, r8, r7
        bne               0f
        mcr               p15, #0x0, r6, c7, c10, #0x5
        strexd            r8, r4, r5, [r1]
        cmp               r8, #0
        beq               2f
        b                 1f
0:
        mov               r8, #1
1:
        mcr               p15, #0x0, r6, c7, c10, #0x5
2:
        eor               r1, r8, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, pc}

asm_test::compare_exchange_weak::u64::seqcst_acquire:
        push              {r4, r5, r6, r7, r8, lr}
        mov               r6, #0
        mov               r12, r3
        mov               lr, r2
        ldr               r4, [sp, #0x18]
        ldr               r5, [sp, #0x1c]
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r8, r2, lr
        orrs              r8, r8, r7
        bne               0f
        mcr               p15, #0x0, r6, c7, c10, #0x5
        strexd            r8, r4, r5, [r1]
        b                 1f
0:
        mov               r8, #1
1:
        mcr               p15, #0x0, r6, c7, c10, #0x5
        eor               r1, r8, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, pc}

asm_test::compare_exchange_weak::u64::seqcst_relaxed:
        push              {r4, r5, r6, r7, r8, lr}
        mov               r6, #0
        mov               r12, r3
        mov               lr, r2
        ldr               r4, [sp, #0x18]
        ldr               r5, [sp, #0x1c]
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r8, r2, lr
        orrs              r8, r8, r7
        bne               0f
        mcr               p15, #0x0, r6, c7, c10, #0x5
        strexd            r8, r4, r5, [r1]
        cmp               r8, #0
        beq               1f
        b                 2f
0:
        mov               r8, #1
        b                 2f
1:
        mcr               p15, #0x0, r6, c7, c10, #0x5
2:
        eor               r1, r8, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, pc}

asm_test::compare_exchange_weak::u64::acquire_acquire:
        push              {r4, r5, r6, r7, r8, lr}
        mov               r6, #0
        mov               r12, r3
        mov               lr, r2
        ldr               r4, [sp, #0x18]
        ldr               r5, [sp, #0x1c]
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r8, r2, lr
        orrs              r8, r8, r7
        bne               0f
        strexd            r8, r4, r5, [r1]
        b                 1f
0:
        mov               r8, #1
1:
        mcr               p15, #0x0, r6, c7, c10, #0x5
        eor               r1, r8, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, pc}

asm_test::compare_exchange_weak::u64::acquire_relaxed:
        push              {r4, r5, r6, r7, r8, lr}
        mov               r6, #0
        mov               r12, r3
        mov               lr, r2
        ldr               r4, [sp, #0x18]
        ldr               r5, [sp, #0x1c]
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r8, r2, lr
        orrs              r8, r8, r7
        bne               0f
        strexd            r8, r4, r5, [r1]
        cmp               r8, #0
        beq               1f
        b                 2f
0:
        mov               r8, #1
        b                 2f
1:
        mcr               p15, #0x0, r6, c7, c10, #0x5
2:
        eor               r1, r8, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, pc}

asm_test::compare_exchange_weak::u64::relaxed_acquire:
        push              {r4, r5, r6, r7, r8, lr}
        mov               r6, #0
        mov               r12, r3
        mov               lr, r2
        ldr               r4, [sp, #0x18]
        ldr               r5, [sp, #0x1c]
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r8, r2, lr
        orrs              r8, r8, r7
        bne               0f
        strexd            r8, r4, r5, [r1]
        cmp               r8, #0
        beq               2f
        b                 1f
0:
        mov               r8, #1
1:
        mcr               p15, #0x0, r6, c7, c10, #0x5
2:
        eor               r1, r8, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, pc}

asm_test::compare_exchange_weak::u64::relaxed_relaxed:
        push              {r4, r5, r6, r7, r11, lr}
        mov               r12, r3
        mov               lr, r2
        ldr               r4, [sp, #0x18]
        ldr               r5, [sp, #0x1c]
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r6, r2, lr
        orrs              r6, r6, r7
        bne               0f
        strexd            r6, r4, r5, [r1]
        b                 1f
0:
        mov               r6, #1
1:
        eor               r1, r6, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r11, pc}

asm_test::compare_exchange_weak::u64::release_acquire:
        push              {r4, r5, r6, r7, r8, lr}
        mov               r6, #0
        mov               r12, r3
        mov               lr, r2
        ldr               r4, [sp, #0x18]
        ldr               r5, [sp, #0x1c]
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r8, r2, lr
        orrs              r8, r8, r7
        bne               0f
        mcr               p15, #0x0, r6, c7, c10, #0x5
        strexd            r8, r4, r5, [r1]
        cmp               r8, #0
        beq               2f
        b                 1f
0:
        mov               r8, #1
1:
        mcr               p15, #0x0, r6, c7, c10, #0x5
2:
        eor               r1, r8, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, pc}

asm_test::compare_exchange_weak::u64::release_relaxed:
        push              {r4, r5, r6, r7, r8, lr}
        mov               r6, #0
        mov               r12, r3
        mov               lr, r2
        ldr               r4, [sp, #0x18]
        ldr               r5, [sp, #0x1c]
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r8, r2, lr
        orrs              r8, r8, r7
        bne               0f
        mcr               p15, #0x0, r6, c7, c10, #0x5
        strexd            r8, r4, r5, [r1]
        b                 1f
0:
        mov               r8, #1
1:
        eor               r1, r8, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, pc}

asm_test::load::u8::seqcst:
        mov               r1, #0
        ldrb              r0, [r0]
        mcr               p15, #0x0, r1, c7, c10, #0x5
        bx                lr

asm_test::load::u8::acquire:
        mov               r1, #0
        ldrb              r0, [r0]
        mcr               p15, #0x0, r1, c7, c10, #0x5
        bx                lr

asm_test::load::u8::relaxed:
        ldrb              r0, [r0]
        bx                lr

asm_test::load::u16::seqcst:
        mov               r1, #0
        ldrh              r0, [r0]
        mcr               p15, #0x0, r1, c7, c10, #0x5
        bx                lr

asm_test::load::u16::acquire:
        mov               r1, #0
        ldrh              r0, [r0]
        mcr               p15, #0x0, r1, c7, c10, #0x5
        bx                lr

asm_test::load::u16::relaxed:
        ldrh              r0, [r0]
        bx                lr

asm_test::load::u32::seqcst:
        mov               r1, #0
        ldr               r0, [r0]
        mcr               p15, #0x0, r1, c7, c10, #0x5
        bx                lr

asm_test::load::u32::acquire:
        mov               r1, #0
        ldr               r0, [r0]
        mcr               p15, #0x0, r1, c7, c10, #0x5
        bx                lr

asm_test::load::u32::relaxed:
        ldr               r0, [r0]
        bx                lr

asm_test::load::u64::seqcst:
        mov               r2, #0
        ldrexd            r0, r1, [r0]
        mcr               p15, #0x0, r2, c7, c10, #0x5
        bx                lr

asm_test::load::u64::acquire:
        mov               r2, #0
        ldrexd            r0, r1, [r0]
        mcr               p15, #0x0, r2, c7, c10, #0x5
        bx                lr

asm_test::load::u64::relaxed:
        ldrexd            r0, r1, [r0]
        bx                lr

asm_test::swap::u8::acqrel:
        mov               r3, #0
        mcr               p15, #0x0, r3, c7, c10, #0x5
0:
        ldrexb            r2, [r0]
        strexb            r12, r1, [r0]
        cmp               r12, #0
        bne               0b
        mcr               p15, #0x0, r3, c7, c10, #0x5
        mov               r0, r2
        bx                lr

asm_test::swap::u8::seqcst:
        mov               r3, #0
        mcr               p15, #0x0, r3, c7, c10, #0x5
0:
        ldrexb            r2, [r0]
        strexb            r12, r1, [r0]
        cmp               r12, #0
        bne               0b
        mcr               p15, #0x0, r3, c7, c10, #0x5
        mov               r0, r2
        bx                lr

asm_test::swap::u8::acquire:
        mov               r3, #0
0:
        ldrexb            r2, [r0]
        strexb            r12, r1, [r0]
        cmp               r12, #0
        bne               0b
        mcr               p15, #0x0, r3, c7, c10, #0x5
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
        mov               r3, #0
        mcr               p15, #0x0, r3, c7, c10, #0x5
0:
        ldrexb            r2, [r0]
        strexb            r12, r1, [r0]
        cmp               r12, #0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u16::acqrel:
        mov               r3, #0
        mcr               p15, #0x0, r3, c7, c10, #0x5
0:
        ldrexh            r2, [r0]
        strexh            r12, r1, [r0]
        cmp               r12, #0
        bne               0b
        mcr               p15, #0x0, r3, c7, c10, #0x5
        mov               r0, r2
        bx                lr

asm_test::swap::u16::seqcst:
        mov               r3, #0
        mcr               p15, #0x0, r3, c7, c10, #0x5
0:
        ldrexh            r2, [r0]
        strexh            r12, r1, [r0]
        cmp               r12, #0
        bne               0b
        mcr               p15, #0x0, r3, c7, c10, #0x5
        mov               r0, r2
        bx                lr

asm_test::swap::u16::acquire:
        mov               r3, #0
0:
        ldrexh            r2, [r0]
        strexh            r12, r1, [r0]
        cmp               r12, #0
        bne               0b
        mcr               p15, #0x0, r3, c7, c10, #0x5
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
        mov               r3, #0
        mcr               p15, #0x0, r3, c7, c10, #0x5
0:
        ldrexh            r2, [r0]
        strexh            r12, r1, [r0]
        cmp               r12, #0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u32::acqrel:
        mov               r3, #0
        mcr               p15, #0x0, r3, c7, c10, #0x5
0:
        ldrex             r2, [r0]
        strex             r12, r1, [r0]
        cmp               r12, #0
        bne               0b
        mcr               p15, #0x0, r3, c7, c10, #0x5
        mov               r0, r2
        bx                lr

asm_test::swap::u32::seqcst:
        mov               r3, #0
        mcr               p15, #0x0, r3, c7, c10, #0x5
0:
        ldrex             r2, [r0]
        strex             r12, r1, [r0]
        cmp               r12, #0
        bne               0b
        mcr               p15, #0x0, r3, c7, c10, #0x5
        mov               r0, r2
        bx                lr

asm_test::swap::u32::acquire:
        mov               r3, #0
0:
        ldrex             r2, [r0]
        strex             r12, r1, [r0]
        cmp               r12, #0
        bne               0b
        mcr               p15, #0x0, r3, c7, c10, #0x5
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
        mov               r3, #0
        mcr               p15, #0x0, r3, c7, c10, #0x5
0:
        ldrex             r2, [r0]
        strex             r12, r1, [r0]
        cmp               r12, #0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u64::acqrel:
        push              {r4, lr}
        mov               lr, #0
        mov               r12, r0
        mcr               p15, #0x0, lr, c7, c10, #0x5
0:
        ldrexd            r0, r1, [r12]
        strexd            r4, r2, r3, [r12]
        cmp               r4, #0
        bne               0b
        mcr               p15, #0x0, lr, c7, c10, #0x5
        pop               {r4, pc}

asm_test::swap::u64::seqcst:
        push              {r4, lr}
        mov               lr, #0
        mov               r12, r0
        mcr               p15, #0x0, lr, c7, c10, #0x5
0:
        ldrexd            r0, r1, [r12]
        strexd            r4, r2, r3, [r12]
        cmp               r4, #0
        bne               0b
        mcr               p15, #0x0, lr, c7, c10, #0x5
        pop               {r4, pc}

asm_test::swap::u64::acquire:
        push              {r4, lr}
        mov               lr, #0
        mov               r12, r0
0:
        ldrexd            r0, r1, [r12]
        strexd            r4, r2, r3, [r12]
        cmp               r4, #0
        bne               0b
        mcr               p15, #0x0, lr, c7, c10, #0x5
        pop               {r4, pc}

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
        push              {r4, lr}
        mov               lr, #0
        mov               r12, r0
        mcr               p15, #0x0, lr, c7, c10, #0x5
0:
        ldrexd            r0, r1, [r12]
        strexd            r4, r2, r3, [r12]
        cmp               r4, #0
        bne               0b
        pop               {r4, pc}

asm_test::store::u8::seqcst:
        mov               r2, #0
        mcr               p15, #0x0, r2, c7, c10, #0x5
        strb              r1, [r0]
        mcr               p15, #0x0, r2, c7, c10, #0x5
        bx                lr

asm_test::store::u8::relaxed:
        strb              r1, [r0]
        bx                lr

asm_test::store::u8::release:
        mov               r2, #0
        mcr               p15, #0x0, r2, c7, c10, #0x5
        strb              r1, [r0]
        bx                lr

asm_test::store::u16::seqcst:
        mov               r2, #0
        mcr               p15, #0x0, r2, c7, c10, #0x5
        strh              r1, [r0]
        mcr               p15, #0x0, r2, c7, c10, #0x5
        bx                lr

asm_test::store::u16::relaxed:
        strh              r1, [r0]
        bx                lr

asm_test::store::u16::release:
        mov               r2, #0
        mcr               p15, #0x0, r2, c7, c10, #0x5
        strh              r1, [r0]
        bx                lr

asm_test::store::u32::seqcst:
        mov               r2, #0
        mcr               p15, #0x0, r2, c7, c10, #0x5
        str               r1, [r0]
        mcr               p15, #0x0, r2, c7, c10, #0x5
        bx                lr

asm_test::store::u32::relaxed:
        str               r1, [r0]
        bx                lr

asm_test::store::u32::release:
        mov               r2, #0
        mcr               p15, #0x0, r2, c7, c10, #0x5
        str               r1, [r0]
        bx                lr

asm_test::store::u64::seqcst:
        push              {r4, r5, r11, lr}
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
0:
        ldrexd            r4, r5, [r0]
        strexd            r4, r2, r3, [r0]
        cmp               r4, #0
        bne               0b
        mcr               p15, #0x0, r1, c7, c10, #0x5
        pop               {r4, r5, r11, pc}

asm_test::store::u64::relaxed:
        push              {r4, r5, r11, lr}
0:
        ldrexd            r4, r5, [r0]
        strexd            r4, r2, r3, [r0]
        cmp               r4, #0
        bne               0b
        pop               {r4, r5, r11, pc}

asm_test::store::u64::release:
        push              {r4, r5, r11, lr}
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
0:
        ldrexd            r4, r5, [r0]
        strexd            r4, r2, r3, [r0]
        cmp               r4, #0
        bne               0b
        pop               {r4, r5, r11, pc}

