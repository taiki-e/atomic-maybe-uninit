asm_test::compare_exchange::u8::acqrel_seqcst:
        push              {r4, lr}
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              lr, r1
        mov               r12, #0
        mov               r1, #0
        cmp               r0, lr
        bne               1f
        mcr               p15, #0x0, r1, c7, c10, #0x5
0:
        strexb            r4, r2, [r3]
        mov               r1, #1
        cmp               r4, #0
        beq               1f
        ldrexb            r0, [r3]
        mov               r1, #0
        cmp               r0, lr
        beq               0b
1:
        mcr               p15, #0x0, r12, c7, c10, #0x5
        pop               {r4, pc}

asm_test::compare_exchange::u8::seqcst_seqcst:
        push              {r4, lr}
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              lr, r1
        mov               r12, #0
        mov               r1, #0
        cmp               r0, lr
        bne               1f
        mcr               p15, #0x0, r1, c7, c10, #0x5
0:
        strexb            r4, r2, [r3]
        mov               r1, #1
        cmp               r4, #0
        beq               1f
        ldrexb            r0, [r3]
        mov               r1, #0
        cmp               r0, lr
        beq               0b
1:
        mcr               p15, #0x0, r12, c7, c10, #0x5
        pop               {r4, pc}

asm_test::compare_exchange::u8::acqrel_acquire:
        push              {r4, lr}
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              lr, r1
        mov               r12, #0
        mov               r1, #0
        cmp               r0, lr
        bne               1f
        mcr               p15, #0x0, r1, c7, c10, #0x5
0:
        strexb            r4, r2, [r3]
        mov               r1, #1
        cmp               r4, #0
        beq               1f
        ldrexb            r0, [r3]
        mov               r1, #0
        cmp               r0, lr
        beq               0b
1:
        mcr               p15, #0x0, r12, c7, c10, #0x5
        pop               {r4, pc}

asm_test::compare_exchange::u8::acqrel_relaxed:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r12, r1
        mov               r1, #0
        cmp               r0, r12
        bxne              lr
        mcr               p15, #0x0, r1, c7, c10, #0x5
0:
        strexb            r1, r2, [r3]
        cmp               r1, #0
        beq               1f
        ldrexb            r0, [r3]
        mov               r1, #0
        cmp               r0, r12
        beq               0b
        b                 2f
1:
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
        mov               r1, #1
2:
        bx                lr

asm_test::compare_exchange::u8::acquire_seqcst:
        push              {r4, lr}
        uxtb              lr, r1
        mov               r3, r0
        mov               r12, #0
        mov               r1, #1
0:
        ldrexb            r0, [r3]
        cmp               r0, lr
        bne               1f
        strexb            r4, r2, [r3]
        cmp               r4, #0
        mcreq             p15, #0x0, r12, c7, c10, #0x5
        popeq             {r4, pc}
        b                 0b
1:
        mov               r1, #0
        mcr               p15, #0x0, r12, c7, c10, #0x5
        pop               {r4, pc}

asm_test::compare_exchange::u8::relaxed_seqcst:
        push              {r11, lr}
        uxtb              r12, r1
        mov               r3, r0
        mov               r1, #1
0:
        ldrexb            r0, [r3]
        cmp               r0, r12
        bne               1f
        strexb            lr, r2, [r3]
        cmp               lr, #0
        popeq             {r11, pc}
        b                 0b
1:
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
        pop               {r11, pc}

asm_test::compare_exchange::u8::release_seqcst:
        push              {r11, lr}
        mov               lr, r0
        ldrexb            r0, [r0]
        uxtb              r12, r1
        cmp               r0, r12
        bne               1f
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
        mov               r1, #1
0:
        strexb            r3, r2, [lr]
        cmp               r3, #0
        popeq             {r11, pc}
        ldrexb            r0, [lr]
        cmp               r0, r12
        beq               0b
1:
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
        pop               {r11, pc}

asm_test::compare_exchange::u8::seqcst_acquire:
        push              {r4, lr}
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              lr, r1
        mov               r12, #0
        mov               r1, #0
        cmp               r0, lr
        bne               1f
        mcr               p15, #0x0, r1, c7, c10, #0x5
0:
        strexb            r4, r2, [r3]
        mov               r1, #1
        cmp               r4, #0
        beq               1f
        ldrexb            r0, [r3]
        mov               r1, #0
        cmp               r0, lr
        beq               0b
1:
        mcr               p15, #0x0, r12, c7, c10, #0x5
        pop               {r4, pc}

asm_test::compare_exchange::u8::seqcst_relaxed:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r12, r1
        mov               r1, #0
        cmp               r0, r12
        bxne              lr
        mcr               p15, #0x0, r1, c7, c10, #0x5
0:
        strexb            r1, r2, [r3]
        cmp               r1, #0
        beq               1f
        ldrexb            r0, [r3]
        mov               r1, #0
        cmp               r0, r12
        beq               0b
        b                 2f
1:
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
        mov               r1, #1
2:
        bx                lr

asm_test::compare_exchange::u8::acquire_acquire:
        push              {r4, lr}
        uxtb              lr, r1
        mov               r3, r0
        mov               r12, #0
        mov               r1, #1
0:
        ldrexb            r0, [r3]
        cmp               r0, lr
        bne               1f
        strexb            r4, r2, [r3]
        cmp               r4, #0
        mcreq             p15, #0x0, r12, c7, c10, #0x5
        popeq             {r4, pc}
        b                 0b
1:
        mov               r1, #0
        mcr               p15, #0x0, r12, c7, c10, #0x5
        pop               {r4, pc}

asm_test::compare_exchange::u8::acquire_relaxed:
        mov               r3, r0
        uxtb              r12, r1
0:
        ldrexb            r0, [r3]
        cmp               r0, r12
        movne             r1, #0
        bxne              lr
        strexb            r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #0
        mcreq             p15, #0x0, r1, c7, c10, #0x5
        moveq             r1, #1
        bxeq              lr
        b                 0b

asm_test::compare_exchange::u8::relaxed_acquire:
        push              {r11, lr}
        uxtb              r12, r1
        mov               r3, r0
        mov               r1, #1
0:
        ldrexb            r0, [r3]
        cmp               r0, r12
        bne               1f
        strexb            lr, r2, [r3]
        cmp               lr, #0
        popeq             {r11, pc}
        b                 0b
1:
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
        pop               {r11, pc}

asm_test::compare_exchange::u8::relaxed_relaxed:
        push              {r11, lr}
        uxtb              r12, r1
        mov               r3, r0
        mov               r1, #1
0:
        ldrexb            r0, [r3]
        cmp               r0, r12
        bne               1f
        strexb            lr, r2, [r3]
        cmp               lr, #0
        popeq             {r11, pc}
        b                 0b
1:
        mov               r1, #0
        pop               {r11, pc}

asm_test::compare_exchange::u8::release_acquire:
        push              {r11, lr}
        mov               lr, r0
        ldrexb            r0, [r0]
        uxtb              r12, r1
        cmp               r0, r12
        bne               1f
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
        mov               r1, #1
0:
        strexb            r3, r2, [lr]
        cmp               r3, #0
        popeq             {r11, pc}
        ldrexb            r0, [lr]
        cmp               r0, r12
        beq               0b
1:
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
        pop               {r11, pc}

asm_test::compare_exchange::u8::release_relaxed:
        push              {r11, lr}
        mov               lr, r0
        ldrexb            r0, [r0]
        uxtb              r12, r1
        mov               r1, #0
        cmp               r0, r12
        bne               1f
        mcr               p15, #0x0, r1, c7, c10, #0x5
0:
        strexb            r3, r2, [lr]
        mov               r1, #1
        cmp               r3, #0
        popeq             {r11, pc}
        ldrexb            r0, [lr]
        mov               r1, #0
        cmp               r0, r12
        beq               0b
1:
        pop               {r11, pc}

asm_test::compare_exchange::u16::acqrel_seqcst:
        push              {r4, lr}
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              lr, r1
        mov               r12, #0
        mov               r1, #0
        cmp               r0, lr
        bne               1f
        mcr               p15, #0x0, r1, c7, c10, #0x5
0:
        strexh            r4, r2, [r3]
        mov               r1, #1
        cmp               r4, #0
        beq               1f
        ldrexh            r0, [r3]
        mov               r1, #0
        cmp               r0, lr
        beq               0b
1:
        mcr               p15, #0x0, r12, c7, c10, #0x5
        pop               {r4, pc}

asm_test::compare_exchange::u16::seqcst_seqcst:
        push              {r4, lr}
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              lr, r1
        mov               r12, #0
        mov               r1, #0
        cmp               r0, lr
        bne               1f
        mcr               p15, #0x0, r1, c7, c10, #0x5
0:
        strexh            r4, r2, [r3]
        mov               r1, #1
        cmp               r4, #0
        beq               1f
        ldrexh            r0, [r3]
        mov               r1, #0
        cmp               r0, lr
        beq               0b
1:
        mcr               p15, #0x0, r12, c7, c10, #0x5
        pop               {r4, pc}

asm_test::compare_exchange::u16::acqrel_acquire:
        push              {r4, lr}
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              lr, r1
        mov               r12, #0
        mov               r1, #0
        cmp               r0, lr
        bne               1f
        mcr               p15, #0x0, r1, c7, c10, #0x5
0:
        strexh            r4, r2, [r3]
        mov               r1, #1
        cmp               r4, #0
        beq               1f
        ldrexh            r0, [r3]
        mov               r1, #0
        cmp               r0, lr
        beq               0b
1:
        mcr               p15, #0x0, r12, c7, c10, #0x5
        pop               {r4, pc}

asm_test::compare_exchange::u16::acqrel_relaxed:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r12, r1
        mov               r1, #0
        cmp               r0, r12
        bxne              lr
        mcr               p15, #0x0, r1, c7, c10, #0x5
0:
        strexh            r1, r2, [r3]
        cmp               r1, #0
        beq               1f
        ldrexh            r0, [r3]
        mov               r1, #0
        cmp               r0, r12
        beq               0b
        b                 2f
1:
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
        mov               r1, #1
2:
        bx                lr

asm_test::compare_exchange::u16::acquire_seqcst:
        push              {r4, lr}
        uxth              lr, r1
        mov               r3, r0
        mov               r12, #0
        mov               r1, #1
0:
        ldrexh            r0, [r3]
        cmp               r0, lr
        bne               1f
        strexh            r4, r2, [r3]
        cmp               r4, #0
        mcreq             p15, #0x0, r12, c7, c10, #0x5
        popeq             {r4, pc}
        b                 0b
1:
        mov               r1, #0
        mcr               p15, #0x0, r12, c7, c10, #0x5
        pop               {r4, pc}

asm_test::compare_exchange::u16::relaxed_seqcst:
        push              {r11, lr}
        uxth              r12, r1
        mov               r3, r0
        mov               r1, #1
0:
        ldrexh            r0, [r3]
        cmp               r0, r12
        bne               1f
        strexh            lr, r2, [r3]
        cmp               lr, #0
        popeq             {r11, pc}
        b                 0b
1:
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
        pop               {r11, pc}

asm_test::compare_exchange::u16::release_seqcst:
        push              {r11, lr}
        mov               lr, r0
        ldrexh            r0, [r0]
        uxth              r12, r1
        cmp               r0, r12
        bne               1f
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
        mov               r1, #1
0:
        strexh            r3, r2, [lr]
        cmp               r3, #0
        popeq             {r11, pc}
        ldrexh            r0, [lr]
        cmp               r0, r12
        beq               0b
1:
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
        pop               {r11, pc}

asm_test::compare_exchange::u16::seqcst_acquire:
        push              {r4, lr}
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              lr, r1
        mov               r12, #0
        mov               r1, #0
        cmp               r0, lr
        bne               1f
        mcr               p15, #0x0, r1, c7, c10, #0x5
0:
        strexh            r4, r2, [r3]
        mov               r1, #1
        cmp               r4, #0
        beq               1f
        ldrexh            r0, [r3]
        mov               r1, #0
        cmp               r0, lr
        beq               0b
1:
        mcr               p15, #0x0, r12, c7, c10, #0x5
        pop               {r4, pc}

asm_test::compare_exchange::u16::seqcst_relaxed:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r12, r1
        mov               r1, #0
        cmp               r0, r12
        bxne              lr
        mcr               p15, #0x0, r1, c7, c10, #0x5
0:
        strexh            r1, r2, [r3]
        cmp               r1, #0
        beq               1f
        ldrexh            r0, [r3]
        mov               r1, #0
        cmp               r0, r12
        beq               0b
        b                 2f
1:
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
        mov               r1, #1
2:
        bx                lr

asm_test::compare_exchange::u16::acquire_acquire:
        push              {r4, lr}
        uxth              lr, r1
        mov               r3, r0
        mov               r12, #0
        mov               r1, #1
0:
        ldrexh            r0, [r3]
        cmp               r0, lr
        bne               1f
        strexh            r4, r2, [r3]
        cmp               r4, #0
        mcreq             p15, #0x0, r12, c7, c10, #0x5
        popeq             {r4, pc}
        b                 0b
1:
        mov               r1, #0
        mcr               p15, #0x0, r12, c7, c10, #0x5
        pop               {r4, pc}

asm_test::compare_exchange::u16::acquire_relaxed:
        mov               r3, r0
        uxth              r12, r1
0:
        ldrexh            r0, [r3]
        cmp               r0, r12
        movne             r1, #0
        bxne              lr
        strexh            r1, r2, [r3]
        cmp               r1, #0
        moveq             r1, #0
        mcreq             p15, #0x0, r1, c7, c10, #0x5
        moveq             r1, #1
        bxeq              lr
        b                 0b

asm_test::compare_exchange::u16::relaxed_acquire:
        push              {r11, lr}
        uxth              r12, r1
        mov               r3, r0
        mov               r1, #1
0:
        ldrexh            r0, [r3]
        cmp               r0, r12
        bne               1f
        strexh            lr, r2, [r3]
        cmp               lr, #0
        popeq             {r11, pc}
        b                 0b
1:
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
        pop               {r11, pc}

asm_test::compare_exchange::u16::relaxed_relaxed:
        push              {r11, lr}
        uxth              r12, r1
        mov               r3, r0
        mov               r1, #1
0:
        ldrexh            r0, [r3]
        cmp               r0, r12
        bne               1f
        strexh            lr, r2, [r3]
        cmp               lr, #0
        popeq             {r11, pc}
        b                 0b
1:
        mov               r1, #0
        pop               {r11, pc}

asm_test::compare_exchange::u16::release_acquire:
        push              {r11, lr}
        mov               lr, r0
        ldrexh            r0, [r0]
        uxth              r12, r1
        cmp               r0, r12
        bne               1f
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
        mov               r1, #1
0:
        strexh            r3, r2, [lr]
        cmp               r3, #0
        popeq             {r11, pc}
        ldrexh            r0, [lr]
        cmp               r0, r12
        beq               0b
1:
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
        pop               {r11, pc}

asm_test::compare_exchange::u16::release_relaxed:
        push              {r11, lr}
        mov               lr, r0
        ldrexh            r0, [r0]
        uxth              r12, r1
        mov               r1, #0
        cmp               r0, r12
        bne               1f
        mcr               p15, #0x0, r1, c7, c10, #0x5
0:
        strexh            r3, r2, [lr]
        mov               r1, #1
        cmp               r3, #0
        popeq             {r11, pc}
        ldrexh            r0, [lr]
        mov               r1, #0
        cmp               r0, r12
        beq               0b
1:
        pop               {r11, pc}

asm_test::compare_exchange::u32::acqrel_seqcst:
        push              {r4, lr}
        mov               r12, r0
        ldrex             r0, [r0]
        mov               lr, #0
        mov               r3, #0
        cmp               r0, r1
        bne               1f
        mcr               p15, #0x0, r3, c7, c10, #0x5
0:
        strex             r4, r2, [r12]
        mov               r3, #1
        cmp               r4, #0
        beq               1f
        ldrex             r0, [r12]
        mov               r3, #0
        cmp               r0, r1
        beq               0b
1:
        mov               r1, r3
        mcr               p15, #0x0, lr, c7, c10, #0x5
        pop               {r4, pc}

asm_test::compare_exchange::u32::seqcst_seqcst:
        push              {r4, lr}
        mov               r12, r0
        ldrex             r0, [r0]
        mov               lr, #0
        mov               r3, #0
        cmp               r0, r1
        bne               1f
        mcr               p15, #0x0, r3, c7, c10, #0x5
0:
        strex             r4, r2, [r12]
        mov               r3, #1
        cmp               r4, #0
        beq               1f
        ldrex             r0, [r12]
        mov               r3, #0
        cmp               r0, r1
        beq               0b
1:
        mov               r1, r3
        mcr               p15, #0x0, lr, c7, c10, #0x5
        pop               {r4, pc}

asm_test::compare_exchange::u32::acqrel_acquire:
        push              {r4, lr}
        mov               r12, r0
        ldrex             r0, [r0]
        mov               lr, #0
        mov               r3, #0
        cmp               r0, r1
        bne               1f
        mcr               p15, #0x0, r3, c7, c10, #0x5
0:
        strex             r4, r2, [r12]
        mov               r3, #1
        cmp               r4, #0
        beq               1f
        ldrex             r0, [r12]
        mov               r3, #0
        cmp               r0, r1
        beq               0b
1:
        mov               r1, r3
        mcr               p15, #0x0, lr, c7, c10, #0x5
        pop               {r4, pc}

asm_test::compare_exchange::u32::acqrel_relaxed:
        push              {r11, lr}
        mov               lr, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               3f
        mov               r3, #0
        mov               r12, #0
        mcr               p15, #0x0, r3, c7, c10, #0x5
0:
        strex             r3, r2, [lr]
        cmp               r3, #0
        beq               1f
        ldrex             r0, [lr]
        cmp               r0, r1
        beq               0b
        b                 2f
1:
        mov               r1, #0
        mov               r12, #1
        mcr               p15, #0x0, r1, c7, c10, #0x5
2:
        mov               r1, r12
        pop               {r11, pc}
3:
        mov               r1, #0
        pop               {r11, pc}

asm_test::compare_exchange::u32::acquire_seqcst:
        push              {r4, lr}
        mov               r12, r0
        mov               lr, #0
        mov               r3, #1
0:
        ldrex             r0, [r12]
        cmp               r0, r1
        bne               1f
        strex             r4, r2, [r12]
        cmp               r4, #0
        bne               0b
        mov               r1, r3
        mcr               p15, #0x0, lr, c7, c10, #0x5
        pop               {r4, pc}
1:
        mov               r3, #0
        mov               r1, r3
        mcr               p15, #0x0, lr, c7, c10, #0x5
        pop               {r4, pc}

asm_test::compare_exchange::u32::relaxed_seqcst:
        push              {r11, lr}
        mov               r12, r0
        mov               r3, #1
0:
        ldrex             r0, [r12]
        cmp               r0, r1
        bne               1f
        strex             lr, r2, [r12]
        cmp               lr, #0
        bne               0b
        mov               r1, r3
        pop               {r11, pc}
1:
        mov               r3, #0
        mcr               p15, #0x0, r3, c7, c10, #0x5
        mov               r1, r3
        pop               {r11, pc}

asm_test::compare_exchange::u32::release_seqcst:
        push              {r11, lr}
        mov               r12, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               1f
        mov               r3, #0
        mcr               p15, #0x0, r3, c7, c10, #0x5
        mov               r3, #1
0:
        strex             lr, r2, [r12]
        cmp               lr, #0
        beq               2f
        ldrex             r0, [r12]
        cmp               r0, r1
        beq               0b
1:
        mov               r3, #0
        mcr               p15, #0x0, r3, c7, c10, #0x5
2:
        mov               r1, r3
        pop               {r11, pc}

asm_test::compare_exchange::u32::seqcst_acquire:
        push              {r4, lr}
        mov               r12, r0
        ldrex             r0, [r0]
        mov               lr, #0
        mov               r3, #0
        cmp               r0, r1
        bne               1f
        mcr               p15, #0x0, r3, c7, c10, #0x5
0:
        strex             r4, r2, [r12]
        mov               r3, #1
        cmp               r4, #0
        beq               1f
        ldrex             r0, [r12]
        mov               r3, #0
        cmp               r0, r1
        beq               0b
1:
        mov               r1, r3
        mcr               p15, #0x0, lr, c7, c10, #0x5
        pop               {r4, pc}

asm_test::compare_exchange::u32::seqcst_relaxed:
        push              {r11, lr}
        mov               lr, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               3f
        mov               r3, #0
        mov               r12, #0
        mcr               p15, #0x0, r3, c7, c10, #0x5
0:
        strex             r3, r2, [lr]
        cmp               r3, #0
        beq               1f
        ldrex             r0, [lr]
        cmp               r0, r1
        beq               0b
        b                 2f
1:
        mov               r1, #0
        mov               r12, #1
        mcr               p15, #0x0, r1, c7, c10, #0x5
2:
        mov               r1, r12
        pop               {r11, pc}
3:
        mov               r1, #0
        pop               {r11, pc}

asm_test::compare_exchange::u32::acquire_acquire:
        push              {r4, lr}
        mov               r12, r0
        mov               lr, #0
        mov               r3, #1
0:
        ldrex             r0, [r12]
        cmp               r0, r1
        bne               1f
        strex             r4, r2, [r12]
        cmp               r4, #0
        bne               0b
        mov               r1, r3
        mcr               p15, #0x0, lr, c7, c10, #0x5
        pop               {r4, pc}
1:
        mov               r3, #0
        mov               r1, r3
        mcr               p15, #0x0, lr, c7, c10, #0x5
        pop               {r4, pc}

asm_test::compare_exchange::u32::acquire_relaxed:
        mov               r12, r0
0:
        ldrex             r0, [r12]
        cmp               r0, r1
        movne             r1, #0
        bxne              lr
        strex             r3, r2, [r12]
        cmp               r3, #0
        moveq             r1, #0
        mcreq             p15, #0x0, r1, c7, c10, #0x5
        moveq             r1, #1
        bxeq              lr
        b                 0b

asm_test::compare_exchange::u32::relaxed_acquire:
        push              {r11, lr}
        mov               r12, r0
        mov               r3, #1
0:
        ldrex             r0, [r12]
        cmp               r0, r1
        bne               1f
        strex             lr, r2, [r12]
        cmp               lr, #0
        bne               0b
        mov               r1, r3
        pop               {r11, pc}
1:
        mov               r3, #0
        mcr               p15, #0x0, r3, c7, c10, #0x5
        mov               r1, r3
        pop               {r11, pc}

asm_test::compare_exchange::u32::relaxed_relaxed:
        push              {r11, lr}
        mov               r12, r0
        mov               r3, #1
0:
        ldrex             r0, [r12]
        cmp               r0, r1
        bne               1f
        strex             lr, r2, [r12]
        cmp               lr, #0
        moveq             r1, r3
        popeq             {r11, pc}
        b                 0b
1:
        mov               r1, #0
        pop               {r11, pc}

asm_test::compare_exchange::u32::release_acquire:
        push              {r11, lr}
        mov               r12, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               1f
        mov               r3, #0
        mcr               p15, #0x0, r3, c7, c10, #0x5
        mov               r3, #1
0:
        strex             lr, r2, [r12]
        cmp               lr, #0
        beq               2f
        ldrex             r0, [r12]
        cmp               r0, r1
        beq               0b
1:
        mov               r3, #0
        mcr               p15, #0x0, r3, c7, c10, #0x5
2:
        mov               r1, r3
        pop               {r11, pc}

asm_test::compare_exchange::u32::release_relaxed:
        push              {r11, lr}
        mov               r12, r0
        ldrex             r0, [r0]
        mov               r3, #0
        cmp               r0, r1
        bne               1f
        mcr               p15, #0x0, r3, c7, c10, #0x5
0:
        strex             lr, r2, [r12]
        mov               r3, #1
        cmp               lr, #0
        beq               1f
        ldrex             r0, [r12]
        mov               r3, #0
        cmp               r0, r1
        beq               0b
1:
        mov               r1, r3
        pop               {r11, pc}

asm_test::compare_exchange::u64::acqrel_seqcst:
        push              {r4, r6, r7, r8, r9, r10, r11, lr}
        ldrexd            r8, r9, [r1]
        mov               r12, #0
        eor               r7, r9, r3
        eor               r6, r8, r2
        orrs              r7, r6, r7
        bne               1f
        ldr               r11, [sp, #0x24]
        mov               r4, #0
        ldr               r10, [sp, #0x20]
        mcr               p15, #0x0, r4, c7, c10, #0x5
0:
        strexd            r6, r10, r11, [r1]
        mov               r4, #1
        cmp               r6, #0
        beq               2f
        ldrexd            r8, r9, [r1]
        mov               r4, #0
        eor               r7, r9, r3
        eor               r6, r8, r2
        orrs              r7, r6, r7
        beq               0b
        b                 2f
1:
        mov               r4, #0
2:
        mcr               p15, #0x0, r12, c7, c10, #0x5
        strd              r8, r9, [r0]
        strb              r4, [r0, #0x8]
        pop               {r4, r6, r7, r8, r9, r10, r11, pc}

asm_test::compare_exchange::u64::seqcst_seqcst:
        push              {r4, r6, r7, r8, r9, r10, r11, lr}
        ldrexd            r8, r9, [r1]
        mov               r12, #0
        eor               r7, r9, r3
        eor               r6, r8, r2
        orrs              r7, r6, r7
        bne               1f
        ldr               r11, [sp, #0x24]
        mov               r4, #0
        ldr               r10, [sp, #0x20]
        mcr               p15, #0x0, r4, c7, c10, #0x5
0:
        strexd            r6, r10, r11, [r1]
        mov               r4, #1
        cmp               r6, #0
        beq               2f
        ldrexd            r8, r9, [r1]
        mov               r4, #0
        eor               r7, r9, r3
        eor               r6, r8, r2
        orrs              r7, r6, r7
        beq               0b
        b                 2f
1:
        mov               r4, #0
2:
        mcr               p15, #0x0, r12, c7, c10, #0x5
        strd              r8, r9, [r0]
        strb              r4, [r0, #0x8]
        pop               {r4, r6, r7, r8, r9, r10, r11, pc}

asm_test::compare_exchange::u64::acqrel_acquire:
        push              {r4, r6, r7, r8, r9, r10, r11, lr}
        ldrexd            r8, r9, [r1]
        mov               r12, #0
        eor               r7, r9, r3
        eor               r6, r8, r2
        orrs              r7, r6, r7
        bne               1f
        ldr               r11, [sp, #0x24]
        mov               r4, #0
        ldr               r10, [sp, #0x20]
        mcr               p15, #0x0, r4, c7, c10, #0x5
0:
        strexd            r6, r10, r11, [r1]
        mov               r4, #1
        cmp               r6, #0
        beq               2f
        ldrexd            r8, r9, [r1]
        mov               r4, #0
        eor               r7, r9, r3
        eor               r6, r8, r2
        orrs              r7, r6, r7
        beq               0b
        b                 2f
1:
        mov               r4, #0
2:
        mcr               p15, #0x0, r12, c7, c10, #0x5
        strd              r8, r9, [r0]
        strb              r4, [r0, #0x8]
        pop               {r4, r6, r7, r8, r9, r10, r11, pc}

asm_test::compare_exchange::u64::acqrel_relaxed:
        push              {r4, r6, r7, r8, r9, lr}
        ldrexd            r8, r9, [r1]
        eor               r7, r9, r3
        eor               r6, r8, r2
        orrs              r7, r6, r7
        bne               3f
        ldr               r7, [sp, #0x1c]
        mov               r4, #0
        ldr               r6, [sp, #0x18]
        mcr               p15, #0x0, r4, c7, c10, #0x5
0:
        strexd            r4, r6, r7, [r1]
        cmp               r4, #0
        beq               1f
        ldrexd            r8, r9, [r1]
        eor               r12, r9, r3
        eor               r4, r8, r2
        orrs              r4, r4, r12
        mov               r12, #0
        beq               0b
        b                 2f
1:
        mov               r1, #0
        mov               r12, #1
        mcr               p15, #0x0, r1, c7, c10, #0x5
2:
        strb              r12, [r0, #0x8]
        strd              r8, r9, [r0]
        pop               {r4, r6, r7, r8, r9, pc}
3:
        mov               r12, #0
        strb              r12, [r0, #0x8]
        strd              r8, r9, [r0]
        pop               {r4, r6, r7, r8, r9, pc}

asm_test::compare_exchange::u64::acquire_seqcst:
        push              {r4, r5, r6, r8, r9, lr}
        ldr               r9, [sp, #0x1c]
        ldr               r8, [sp, #0x18]
0:
        ldrexd            r4, r5, [r1]
        eor               r12, r5, r3
        eor               r6, r4, r2
        orrs              r6, r6, r12
        mov               r12, #0
        bne               1f
        strexd            lr, r8, r9, [r1]
        mov               r6, #1
        cmp               lr, #0
        bne               0b
        mcr               p15, #0x0, r12, c7, c10, #0x5
        strd              r4, r5, [r0]
        strb              r6, [r0, #0x8]
        pop               {r4, r5, r6, r8, r9, pc}
1:
        mov               r6, #0
        mcr               p15, #0x0, r12, c7, c10, #0x5
        strd              r4, r5, [r0]
        strb              r6, [r0, #0x8]
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
        strexd            r12, r8, r9, [r1]
        mov               r6, #1
        cmp               r12, #0
        bne               0b
        strb              r6, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r8, r9, pc}
1:
        mov               r6, #0
        mcr               p15, #0x0, r6, c7, c10, #0x5
        strb              r6, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r8, r9, pc}

asm_test::compare_exchange::u64::release_seqcst:
        push              {r4, r6, r7, r8, r9, r10, r11, lr}
        ldrexd            r8, r9, [r1]
        eor               r7, r9, r3
        eor               r6, r8, r2
        orrs              r7, r6, r7
        bne               1f
        ldr               r11, [sp, #0x24]
        mov               r4, #0
        ldr               r10, [sp, #0x20]
        mcr               p15, #0x0, r4, c7, c10, #0x5
        mov               r4, #1
0:
        strexd            r6, r10, r11, [r1]
        cmp               r6, #0
        beq               2f
        ldrexd            r8, r9, [r1]
        eor               r7, r9, r3
        eor               r6, r8, r2
        orrs              r7, r6, r7
        beq               0b
1:
        mov               r4, #0
        mcr               p15, #0x0, r4, c7, c10, #0x5
2:
        strb              r4, [r0, #0x8]
        strd              r8, r9, [r0]
        pop               {r4, r6, r7, r8, r9, r10, r11, pc}

asm_test::compare_exchange::u64::seqcst_acquire:
        push              {r4, r6, r7, r8, r9, r10, r11, lr}
        ldrexd            r8, r9, [r1]
        mov               r12, #0
        eor               r7, r9, r3
        eor               r6, r8, r2
        orrs              r7, r6, r7
        bne               1f
        ldr               r11, [sp, #0x24]
        mov               r4, #0
        ldr               r10, [sp, #0x20]
        mcr               p15, #0x0, r4, c7, c10, #0x5
0:
        strexd            r6, r10, r11, [r1]
        mov               r4, #1
        cmp               r6, #0
        beq               2f
        ldrexd            r8, r9, [r1]
        mov               r4, #0
        eor               r7, r9, r3
        eor               r6, r8, r2
        orrs              r7, r6, r7
        beq               0b
        b                 2f
1:
        mov               r4, #0
2:
        mcr               p15, #0x0, r12, c7, c10, #0x5
        strd              r8, r9, [r0]
        strb              r4, [r0, #0x8]
        pop               {r4, r6, r7, r8, r9, r10, r11, pc}

asm_test::compare_exchange::u64::seqcst_relaxed:
        push              {r4, r6, r7, r8, r9, lr}
        ldrexd            r8, r9, [r1]
        eor               r7, r9, r3
        eor               r6, r8, r2
        orrs              r7, r6, r7
        bne               3f
        ldr               r7, [sp, #0x1c]
        mov               r4, #0
        ldr               r6, [sp, #0x18]
        mcr               p15, #0x0, r4, c7, c10, #0x5
0:
        strexd            r4, r6, r7, [r1]
        cmp               r4, #0
        beq               1f
        ldrexd            r8, r9, [r1]
        eor               r12, r9, r3
        eor               r4, r8, r2
        orrs              r4, r4, r12
        mov               r12, #0
        beq               0b
        b                 2f
1:
        mov               r1, #0
        mov               r12, #1
        mcr               p15, #0x0, r1, c7, c10, #0x5
2:
        strb              r12, [r0, #0x8]
        strd              r8, r9, [r0]
        pop               {r4, r6, r7, r8, r9, pc}
3:
        mov               r12, #0
        strb              r12, [r0, #0x8]
        strd              r8, r9, [r0]
        pop               {r4, r6, r7, r8, r9, pc}

asm_test::compare_exchange::u64::acquire_acquire:
        push              {r4, r5, r6, r8, r9, lr}
        ldr               r9, [sp, #0x1c]
        ldr               r8, [sp, #0x18]
0:
        ldrexd            r4, r5, [r1]
        eor               r12, r5, r3
        eor               r6, r4, r2
        orrs              r6, r6, r12
        mov               r12, #0
        bne               1f
        strexd            lr, r8, r9, [r1]
        mov               r6, #1
        cmp               lr, #0
        bne               0b
        mcr               p15, #0x0, r12, c7, c10, #0x5
        strd              r4, r5, [r0]
        strb              r6, [r0, #0x8]
        pop               {r4, r5, r6, r8, r9, pc}
1:
        mov               r6, #0
        mcr               p15, #0x0, r12, c7, c10, #0x5
        strd              r4, r5, [r0]
        strb              r6, [r0, #0x8]
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
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
        mov               r1, #1
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r8, r9, pc}
1:
        mov               r1, #0
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
        strexd            r12, r8, r9, [r1]
        mov               r6, #1
        cmp               r12, #0
        bne               0b
        strb              r6, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r8, r9, pc}
1:
        mov               r6, #0
        mcr               p15, #0x0, r6, c7, c10, #0x5
        strb              r6, [r0, #0x8]
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
        strexd            r12, r8, r9, [r1]
        mov               r6, #1
        cmp               r12, #0
        bne               0b
        strb              r6, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r8, r9, pc}
1:
        mov               r6, #0
        strb              r6, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r8, r9, pc}

asm_test::compare_exchange::u64::release_acquire:
        push              {r4, r6, r7, r8, r9, r10, r11, lr}
        ldrexd            r8, r9, [r1]
        eor               r7, r9, r3
        eor               r6, r8, r2
        orrs              r7, r6, r7
        bne               1f
        ldr               r11, [sp, #0x24]
        mov               r4, #0
        ldr               r10, [sp, #0x20]
        mcr               p15, #0x0, r4, c7, c10, #0x5
        mov               r4, #1
0:
        strexd            r6, r10, r11, [r1]
        cmp               r6, #0
        beq               2f
        ldrexd            r8, r9, [r1]
        eor               r7, r9, r3
        eor               r6, r8, r2
        orrs              r7, r6, r7
        beq               0b
1:
        mov               r4, #0
        mcr               p15, #0x0, r4, c7, c10, #0x5
2:
        strb              r4, [r0, #0x8]
        strd              r8, r9, [r0]
        pop               {r4, r6, r7, r8, r9, r10, r11, pc}

asm_test::compare_exchange::u64::release_relaxed:
        push              {r4, r6, r7, r8, r9, r10, r11, lr}
        ldrexd            r8, r9, [r1]
        eor               r7, r9, r3
        eor               r6, r8, r2
        orrs              r7, r6, r7
        bne               1f
        ldr               r11, [sp, #0x24]
        mov               r4, #0
        ldr               r10, [sp, #0x20]
        mcr               p15, #0x0, r4, c7, c10, #0x5
0:
        strexd            r6, r10, r11, [r1]
        mov               r4, #1
        cmp               r6, #0
        beq               2f
        ldrexd            r8, r9, [r1]
        mov               r4, #0
        eor               r7, r9, r3
        eor               r6, r8, r2
        orrs              r7, r6, r7
        beq               0b
        b                 2f
1:
        mov               r4, #0
2:
        strb              r4, [r0, #0x8]
        strd              r8, r9, [r0]
        pop               {r4, r6, r7, r8, r9, r10, r11, pc}

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        push              {r11, lr}
        mov               lr, r0
        ldrexb            r0, [r0]
        mov               r12, #0
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
        strexb            r3, r2, [lr]
        mcr               p15, #0x0, r12, c7, c10, #0x5
        cmp               r3, #0
        moveq             r1, #1
        pop               {r11, pc}
0:
        mov               r1, #0
        mcr               p15, #0x0, r12, c7, c10, #0x5
        pop               {r11, pc}

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        push              {r11, lr}
        mov               lr, r0
        ldrexb            r0, [r0]
        mov               r12, #0
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
        strexb            r3, r2, [lr]
        mcr               p15, #0x0, r12, c7, c10, #0x5
        cmp               r3, #0
        moveq             r1, #1
        pop               {r11, pc}
0:
        mov               r1, #0
        mcr               p15, #0x0, r12, c7, c10, #0x5
        pop               {r11, pc}

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        push              {r11, lr}
        mov               lr, r0
        ldrexb            r0, [r0]
        mov               r12, #0
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
        strexb            r3, r2, [lr]
        mcr               p15, #0x0, r12, c7, c10, #0x5
        cmp               r3, #0
        moveq             r1, #1
        pop               {r11, pc}
0:
        mov               r1, #0
        mcr               p15, #0x0, r12, c7, c10, #0x5
        pop               {r11, pc}

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        mov               r12, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        movne             r1, #0
        bxne              lr
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
        strexb            r3, r2, [r12]
        cmp               r3, #0
        mcreq             p15, #0x0, r1, c7, c10, #0x5
        moveq             r1, #1
        bx                lr

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        push              {r11, lr}
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        mov               r12, #0
        cmp               r0, r1
        mov               r1, #0
        bne               0f
        strexb            lr, r2, [r3]
        mov               r1, #1
        cmp               lr, #0
        movne             r1, #0
0:
        mcr               p15, #0x0, r12, c7, c10, #0x5
        pop               {r11, pc}

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        strexbeq          r12, r2, [r3]
        moveq             r1, #1
        cmpeq             r12, #0
        movne             r1, #0
        mcrne             p15, #0x0, r1, c7, c10, #0x5
        bx                lr

asm_test::compare_exchange_weak::u8::release_seqcst:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        moveq             r1, #0
        mcreq             p15, #0x0, r1, c7, c10, #0x5
        moveq             r1, #1
        strexbeq          r12, r2, [r3]
        cmpeq             r12, #0
        movne             r1, #0
        mcrne             p15, #0x0, r1, c7, c10, #0x5
        bx                lr

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        push              {r11, lr}
        mov               lr, r0
        ldrexb            r0, [r0]
        mov               r12, #0
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
        strexb            r3, r2, [lr]
        mcr               p15, #0x0, r12, c7, c10, #0x5
        cmp               r3, #0
        moveq             r1, #1
        pop               {r11, pc}
0:
        mov               r1, #0
        mcr               p15, #0x0, r12, c7, c10, #0x5
        pop               {r11, pc}

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        mov               r12, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        movne             r1, #0
        bxne              lr
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
        strexb            r3, r2, [r12]
        cmp               r3, #0
        mcreq             p15, #0x0, r1, c7, c10, #0x5
        moveq             r1, #1
        bx                lr

asm_test::compare_exchange_weak::u8::acquire_acquire:
        push              {r11, lr}
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        mov               r12, #0
        cmp               r0, r1
        mov               r1, #0
        bne               0f
        strexb            lr, r2, [r3]
        mov               r1, #1
        cmp               lr, #0
        movne             r1, #0
0:
        mcr               p15, #0x0, r12, c7, c10, #0x5
        pop               {r11, pc}

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        push              {r11, lr}
        mov               lr, r0
        ldrexb            r0, [r0]
        uxtb              r12, r1
        mov               r1, #0
        cmp               r0, r12
        strexbeq          r3, r2, [lr]
        cmpeq             r3, #0
        mcreq             p15, #0x0, r1, c7, c10, #0x5
        moveq             r1, #1
        pop               {r11, pc}

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        strexbeq          r12, r2, [r3]
        moveq             r1, #1
        cmpeq             r12, #0
        movne             r1, #0
        mcrne             p15, #0x0, r1, c7, c10, #0x5
        bx                lr

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r12, r1
        mov               r1, #0
        cmp               r0, r12
        bxne              lr
        strexb            r12, r2, [r3]
        mov               r1, #1
        cmp               r12, #0
        movne             r1, #0
        bx                lr

asm_test::compare_exchange_weak::u8::release_acquire:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        moveq             r1, #0
        mcreq             p15, #0x0, r1, c7, c10, #0x5
        moveq             r1, #1
        strexbeq          r12, r2, [r3]
        cmpeq             r12, #0
        movne             r1, #0
        mcrne             p15, #0x0, r1, c7, c10, #0x5
        bx                lr

asm_test::compare_exchange_weak::u8::release_relaxed:
        mov               r12, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        movne             r1, #0
        bxne              lr
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
        strexb            r3, r2, [r12]
        cmp               r3, #0
        moveq             r1, #1
        bx                lr

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        push              {r11, lr}
        mov               lr, r0
        ldrexh            r0, [r0]
        mov               r12, #0
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
        strexh            r3, r2, [lr]
        mcr               p15, #0x0, r12, c7, c10, #0x5
        cmp               r3, #0
        moveq             r1, #1
        pop               {r11, pc}
0:
        mov               r1, #0
        mcr               p15, #0x0, r12, c7, c10, #0x5
        pop               {r11, pc}

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        push              {r11, lr}
        mov               lr, r0
        ldrexh            r0, [r0]
        mov               r12, #0
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
        strexh            r3, r2, [lr]
        mcr               p15, #0x0, r12, c7, c10, #0x5
        cmp               r3, #0
        moveq             r1, #1
        pop               {r11, pc}
0:
        mov               r1, #0
        mcr               p15, #0x0, r12, c7, c10, #0x5
        pop               {r11, pc}

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        push              {r11, lr}
        mov               lr, r0
        ldrexh            r0, [r0]
        mov               r12, #0
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
        strexh            r3, r2, [lr]
        mcr               p15, #0x0, r12, c7, c10, #0x5
        cmp               r3, #0
        moveq             r1, #1
        pop               {r11, pc}
0:
        mov               r1, #0
        mcr               p15, #0x0, r12, c7, c10, #0x5
        pop               {r11, pc}

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        mov               r12, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        movne             r1, #0
        bxne              lr
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
        strexh            r3, r2, [r12]
        cmp               r3, #0
        mcreq             p15, #0x0, r1, c7, c10, #0x5
        moveq             r1, #1
        bx                lr

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        push              {r11, lr}
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        mov               r12, #0
        cmp               r0, r1
        mov               r1, #0
        bne               0f
        strexh            lr, r2, [r3]
        mov               r1, #1
        cmp               lr, #0
        movne             r1, #0
0:
        mcr               p15, #0x0, r12, c7, c10, #0x5
        pop               {r11, pc}

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        strexheq          r12, r2, [r3]
        moveq             r1, #1
        cmpeq             r12, #0
        movne             r1, #0
        mcrne             p15, #0x0, r1, c7, c10, #0x5
        bx                lr

asm_test::compare_exchange_weak::u16::release_seqcst:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        moveq             r1, #0
        mcreq             p15, #0x0, r1, c7, c10, #0x5
        moveq             r1, #1
        strexheq          r12, r2, [r3]
        cmpeq             r12, #0
        movne             r1, #0
        mcrne             p15, #0x0, r1, c7, c10, #0x5
        bx                lr

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        push              {r11, lr}
        mov               lr, r0
        ldrexh            r0, [r0]
        mov               r12, #0
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
        strexh            r3, r2, [lr]
        mcr               p15, #0x0, r12, c7, c10, #0x5
        cmp               r3, #0
        moveq             r1, #1
        pop               {r11, pc}
0:
        mov               r1, #0
        mcr               p15, #0x0, r12, c7, c10, #0x5
        pop               {r11, pc}

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        mov               r12, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        movne             r1, #0
        bxne              lr
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
        strexh            r3, r2, [r12]
        cmp               r3, #0
        mcreq             p15, #0x0, r1, c7, c10, #0x5
        moveq             r1, #1
        bx                lr

asm_test::compare_exchange_weak::u16::acquire_acquire:
        push              {r11, lr}
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        mov               r12, #0
        cmp               r0, r1
        mov               r1, #0
        bne               0f
        strexh            lr, r2, [r3]
        mov               r1, #1
        cmp               lr, #0
        movne             r1, #0
0:
        mcr               p15, #0x0, r12, c7, c10, #0x5
        pop               {r11, pc}

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        push              {r11, lr}
        mov               lr, r0
        ldrexh            r0, [r0]
        uxth              r12, r1
        mov               r1, #0
        cmp               r0, r12
        strexheq          r3, r2, [lr]
        cmpeq             r3, #0
        mcreq             p15, #0x0, r1, c7, c10, #0x5
        moveq             r1, #1
        pop               {r11, pc}

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        strexheq          r12, r2, [r3]
        moveq             r1, #1
        cmpeq             r12, #0
        movne             r1, #0
        mcrne             p15, #0x0, r1, c7, c10, #0x5
        bx                lr

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r12, r1
        mov               r1, #0
        cmp               r0, r12
        bxne              lr
        strexh            r12, r2, [r3]
        mov               r1, #1
        cmp               r12, #0
        movne             r1, #0
        bx                lr

asm_test::compare_exchange_weak::u16::release_acquire:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        moveq             r1, #0
        mcreq             p15, #0x0, r1, c7, c10, #0x5
        moveq             r1, #1
        strexheq          r12, r2, [r3]
        cmpeq             r12, #0
        movne             r1, #0
        mcrne             p15, #0x0, r1, c7, c10, #0x5
        bx                lr

asm_test::compare_exchange_weak::u16::release_relaxed:
        mov               r12, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        movne             r1, #0
        bxne              lr
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
        strexh            r3, r2, [r12]
        cmp               r3, #0
        moveq             r1, #1
        bx                lr

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        push              {r11, lr}
        mov               r3, r0
        ldrex             r0, [r0]
        mov               r12, #0
        cmp               r0, r1
        mov               r1, #0
        bne               0f
        mcr               p15, #0x0, r1, c7, c10, #0x5
        mov               r1, #1
        strex             lr, r2, [r3]
        cmp               lr, #0
        movne             r1, #0
0:
        mcr               p15, #0x0, r12, c7, c10, #0x5
        pop               {r11, pc}

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        push              {r11, lr}
        mov               r3, r0
        ldrex             r0, [r0]
        mov               r12, #0
        cmp               r0, r1
        mov               r1, #0
        bne               0f
        mcr               p15, #0x0, r1, c7, c10, #0x5
        mov               r1, #1
        strex             lr, r2, [r3]
        cmp               lr, #0
        movne             r1, #0
0:
        mcr               p15, #0x0, r12, c7, c10, #0x5
        pop               {r11, pc}

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        push              {r11, lr}
        mov               r3, r0
        ldrex             r0, [r0]
        mov               r12, #0
        cmp               r0, r1
        mov               r1, #0
        bne               0f
        mcr               p15, #0x0, r1, c7, c10, #0x5
        mov               r1, #1
        strex             lr, r2, [r3]
        cmp               lr, #0
        movne             r1, #0
0:
        mcr               p15, #0x0, r12, c7, c10, #0x5
        pop               {r11, pc}

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        mov               r12, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        movne             r1, #0
        bxne              lr
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
        strex             r3, r2, [r12]
        cmp               r3, #0
        mcreq             p15, #0x0, r1, c7, c10, #0x5
        moveq             r1, #1
        bx                lr

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        push              {r11, lr}
        mov               r3, r0
        ldrex             r0, [r0]
        mov               r12, #0
        cmp               r0, r1
        mov               r1, #0
        bne               0f
        strex             lr, r2, [r3]
        mov               r1, #1
        cmp               lr, #0
        movne             r1, #0
0:
        mcr               p15, #0x0, r12, c7, c10, #0x5
        pop               {r11, pc}

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        strexeq           r12, r2, [r3]
        moveq             r1, #1
        cmpeq             r12, #0
        movne             r1, #0
        mcrne             p15, #0x0, r1, c7, c10, #0x5
        bx                lr

asm_test::compare_exchange_weak::u32::release_seqcst:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        moveq             r1, #0
        mcreq             p15, #0x0, r1, c7, c10, #0x5
        moveq             r1, #1
        strexeq           r12, r2, [r3]
        cmpeq             r12, #0
        movne             r1, #0
        mcrne             p15, #0x0, r1, c7, c10, #0x5
        bx                lr

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        push              {r11, lr}
        mov               r3, r0
        ldrex             r0, [r0]
        mov               r12, #0
        cmp               r0, r1
        mov               r1, #0
        bne               0f
        mcr               p15, #0x0, r1, c7, c10, #0x5
        mov               r1, #1
        strex             lr, r2, [r3]
        cmp               lr, #0
        movne             r1, #0
0:
        mcr               p15, #0x0, r12, c7, c10, #0x5
        pop               {r11, pc}

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        mov               r12, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        movne             r1, #0
        bxne              lr
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
        strex             r3, r2, [r12]
        cmp               r3, #0
        mcreq             p15, #0x0, r1, c7, c10, #0x5
        moveq             r1, #1
        bx                lr

asm_test::compare_exchange_weak::u32::acquire_acquire:
        push              {r11, lr}
        mov               r3, r0
        ldrex             r0, [r0]
        mov               r12, #0
        cmp               r0, r1
        mov               r1, #0
        bne               0f
        strex             lr, r2, [r3]
        mov               r1, #1
        cmp               lr, #0
        movne             r1, #0
0:
        mcr               p15, #0x0, r12, c7, c10, #0x5
        pop               {r11, pc}

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        push              {r11, lr}
        mov               lr, r0
        ldrex             r0, [r0]
        mov               r12, r1
        mov               r1, #0
        cmp               r0, r12
        strexeq           r3, r2, [lr]
        cmpeq             r3, #0
        mcreq             p15, #0x0, r1, c7, c10, #0x5
        moveq             r1, #1
        pop               {r11, pc}

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        strexeq           r12, r2, [r3]
        moveq             r1, #1
        cmpeq             r12, #0
        movne             r1, #0
        mcrne             p15, #0x0, r1, c7, c10, #0x5
        bx                lr

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        mov               r3, r0
        ldrex             r0, [r0]
        mov               r12, r1
        mov               r1, #0
        cmp               r0, r12
        bxne              lr
        strex             r12, r2, [r3]
        mov               r1, #1
        cmp               r12, #0
        movne             r1, #0
        bx                lr

asm_test::compare_exchange_weak::u32::release_acquire:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        moveq             r1, #0
        mcreq             p15, #0x0, r1, c7, c10, #0x5
        moveq             r1, #1
        strexeq           r12, r2, [r3]
        cmpeq             r12, #0
        movne             r1, #0
        mcrne             p15, #0x0, r1, c7, c10, #0x5
        bx                lr

asm_test::compare_exchange_weak::u32::release_relaxed:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        moveq             r1, #0
        mcreq             p15, #0x0, r1, c7, c10, #0x5
        moveq             r1, #1
        strexeq           r12, r2, [r3]
        cmpeq             r12, #0
        movne             r1, #0
        bx                lr

asm_test::compare_exchange_weak::u64::acqrel_seqcst:
        push              {r4, r5, r6, r7, r11, lr}
        ldrexd            r4, r5, [r1]
        mov               r12, #0
        eor               r3, r5, r3
        eor               r2, r4, r2
        orrs              r2, r2, r3
        mov               r3, #0
        bne               0f
        ldr               r7, [sp, #0x1c]
        mcr               p15, #0x0, r3, c7, c10, #0x5
        ldr               r6, [sp, #0x18]
        mov               r3, #1
        strexd            r2, r6, r7, [r1]
        cmp               r2, #0
        movne             r3, #0
0:
        mcr               p15, #0x0, r12, c7, c10, #0x5
        strd              r4, r5, [r0]
        strb              r3, [r0, #0x8]
        pop               {r4, r5, r6, r7, r11, pc}

asm_test::compare_exchange_weak::u64::seqcst_seqcst:
        push              {r4, r5, r6, r7, r11, lr}
        ldrexd            r4, r5, [r1]
        mov               r12, #0
        eor               r3, r5, r3
        eor               r2, r4, r2
        orrs              r2, r2, r3
        mov               r3, #0
        bne               0f
        ldr               r7, [sp, #0x1c]
        mcr               p15, #0x0, r3, c7, c10, #0x5
        ldr               r6, [sp, #0x18]
        mov               r3, #1
        strexd            r2, r6, r7, [r1]
        cmp               r2, #0
        movne             r3, #0
0:
        mcr               p15, #0x0, r12, c7, c10, #0x5
        strd              r4, r5, [r0]
        strb              r3, [r0, #0x8]
        pop               {r4, r5, r6, r7, r11, pc}

asm_test::compare_exchange_weak::u64::acqrel_acquire:
        push              {r4, r5, r6, r7, r11, lr}
        ldrexd            r4, r5, [r1]
        mov               r12, #0
        eor               r3, r5, r3
        eor               r2, r4, r2
        orrs              r2, r2, r3
        mov               r3, #0
        bne               0f
        ldr               r7, [sp, #0x1c]
        mcr               p15, #0x0, r3, c7, c10, #0x5
        ldr               r6, [sp, #0x18]
        mov               r3, #1
        strexd            r2, r6, r7, [r1]
        cmp               r2, #0
        movne             r3, #0
0:
        mcr               p15, #0x0, r12, c7, c10, #0x5
        strd              r4, r5, [r0]
        strb              r3, [r0, #0x8]
        pop               {r4, r5, r6, r7, r11, pc}

asm_test::compare_exchange_weak::u64::acqrel_relaxed:
        push              {r4, r5, r6, r7, r11, lr}
        ldrexd            r4, r5, [r1]
        eor               r3, r5, r3
        eor               r2, r4, r2
        orrs              r2, r2, r3
        bne               0f
        ldr               r7, [sp, #0x1c]
        mov               r2, #0
        ldr               r6, [sp, #0x18]
        mcr               p15, #0x0, r2, c7, c10, #0x5
        strexd            r3, r6, r7, [r1]
        cmp               r3, #0
        moveq             r1, #0
        moveq             r2, #1
        mcreq             p15, #0x0, r1, c7, c10, #0x5
        strb              r2, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r7, r11, pc}
0:
        mov               r2, #0
        strb              r2, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r7, r11, pc}

asm_test::compare_exchange_weak::u64::acquire_seqcst:
        push              {r4, r5, r6, r7, r11, lr}
        ldrexd            r4, r5, [r1]
        mov               r12, #0
        eor               r3, r5, r3
        eor               r2, r4, r2
        orrs              r2, r2, r3
        mov               r3, #0
        bne               0f
        ldr               r7, [sp, #0x1c]
        mov               r3, #1
        ldr               r6, [sp, #0x18]
        strexd            r2, r6, r7, [r1]
        cmp               r2, #0
        movne             r3, #0
0:
        mcr               p15, #0x0, r12, c7, c10, #0x5
        strd              r4, r5, [r0]
        strb              r3, [r0, #0x8]
        pop               {r4, r5, r6, r7, r11, pc}

asm_test::compare_exchange_weak::u64::relaxed_seqcst:
        push              {r4, r5, r11, lr}
        ldrexd            r4, r5, [r1]
        eor               r3, r5, r3
        eor               r2, r4, r2
        orrs              r2, r2, r3
        ldreq             r3, [sp, #0x14]
        ldreq             r2, [sp, #0x10]
        strexdeq          r12, r2, r3, [r1]
        moveq             r1, #1
        cmpeq             r12, #0
        movne             r1, #0
        mcrne             p15, #0x0, r1, c7, c10, #0x5
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r11, pc}

asm_test::compare_exchange_weak::u64::release_seqcst:
        push              {r4, r6, r7, lr}
        ldrexd            r6, r7, [r1]
        eor               r3, r7, r3
        eor               r2, r6, r2
        orrs              r2, r2, r3
        ldreq             r3, [sp, #0x14]
        moveq             r4, #0
        ldreq             r2, [sp, #0x10]
        mcreq             p15, #0x0, r4, c7, c10, #0x5
        strexdeq          r4, r2, r3, [r1]
        moveq             r1, #1
        cmpeq             r4, #0
        movne             r1, #0
        mcrne             p15, #0x0, r1, c7, c10, #0x5
        strb              r1, [r0, #0x8]
        strd              r6, r7, [r0]
        pop               {r4, r6, r7, pc}

asm_test::compare_exchange_weak::u64::seqcst_acquire:
        push              {r4, r5, r6, r7, r11, lr}
        ldrexd            r4, r5, [r1]
        mov               r12, #0
        eor               r3, r5, r3
        eor               r2, r4, r2
        orrs              r2, r2, r3
        mov               r3, #0
        bne               0f
        ldr               r7, [sp, #0x1c]
        mcr               p15, #0x0, r3, c7, c10, #0x5
        ldr               r6, [sp, #0x18]
        mov               r3, #1
        strexd            r2, r6, r7, [r1]
        cmp               r2, #0
        movne             r3, #0
0:
        mcr               p15, #0x0, r12, c7, c10, #0x5
        strd              r4, r5, [r0]
        strb              r3, [r0, #0x8]
        pop               {r4, r5, r6, r7, r11, pc}

asm_test::compare_exchange_weak::u64::seqcst_relaxed:
        push              {r4, r5, r6, r7, r11, lr}
        ldrexd            r4, r5, [r1]
        eor               r3, r5, r3
        eor               r2, r4, r2
        orrs              r2, r2, r3
        bne               0f
        ldr               r7, [sp, #0x1c]
        mov               r2, #0
        ldr               r6, [sp, #0x18]
        mcr               p15, #0x0, r2, c7, c10, #0x5
        strexd            r3, r6, r7, [r1]
        cmp               r3, #0
        moveq             r1, #0
        moveq             r2, #1
        mcreq             p15, #0x0, r1, c7, c10, #0x5
        strb              r2, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r7, r11, pc}
0:
        mov               r2, #0
        strb              r2, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r7, r11, pc}

asm_test::compare_exchange_weak::u64::acquire_acquire:
        push              {r4, r5, r6, r7, r11, lr}
        ldrexd            r4, r5, [r1]
        mov               r12, #0
        eor               r3, r5, r3
        eor               r2, r4, r2
        orrs              r2, r2, r3
        mov               r3, #0
        bne               0f
        ldr               r7, [sp, #0x1c]
        mov               r3, #1
        ldr               r6, [sp, #0x18]
        strexd            r2, r6, r7, [r1]
        cmp               r2, #0
        movne             r3, #0
0:
        mcr               p15, #0x0, r12, c7, c10, #0x5
        strd              r4, r5, [r0]
        strb              r3, [r0, #0x8]
        pop               {r4, r5, r6, r7, r11, pc}

asm_test::compare_exchange_weak::u64::acquire_relaxed:
        push              {r4, r5, r6, r7, r11, lr}
        ldrexd            r4, r5, [r1]
        eor               r3, r5, r3
        eor               r2, r4, r2
        orrs              r2, r2, r3
        ldreq             r7, [sp, #0x1c]
        mov               r2, #0
        ldreq             r6, [sp, #0x18]
        strexdeq          r3, r6, r7, [r1]
        cmpeq             r3, #0
        moveq             r1, #0
        moveq             r2, #1
        mcreq             p15, #0x0, r1, c7, c10, #0x5
        strb              r2, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r6, r7, r11, pc}

asm_test::compare_exchange_weak::u64::relaxed_acquire:
        push              {r4, r5, r11, lr}
        ldrexd            r4, r5, [r1]
        eor               r3, r5, r3
        eor               r2, r4, r2
        orrs              r2, r2, r3
        ldreq             r3, [sp, #0x14]
        ldreq             r2, [sp, #0x10]
        strexdeq          r12, r2, r3, [r1]
        moveq             r1, #1
        cmpeq             r12, #0
        movne             r1, #0
        mcrne             p15, #0x0, r1, c7, c10, #0x5
        strb              r1, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r11, pc}

asm_test::compare_exchange_weak::u64::relaxed_relaxed:
        push              {r4, r5, r11, lr}
        ldrexd            r4, r5, [r1]
        eor               r3, r5, r3
        eor               r2, r4, r2
        orrs              r2, r2, r3
        mov               r2, #0
        bne               0f
        ldr               r3, [sp, #0x14]
        ldr               r2, [sp, #0x10]
        strexd            r12, r2, r3, [r1]
        mov               r2, #1
        cmp               r12, #0
        movne             r2, #0
0:
        strb              r2, [r0, #0x8]
        strd              r4, r5, [r0]
        pop               {r4, r5, r11, pc}

asm_test::compare_exchange_weak::u64::release_acquire:
        push              {r4, r6, r7, lr}
        ldrexd            r6, r7, [r1]
        eor               r3, r7, r3
        eor               r2, r6, r2
        orrs              r2, r2, r3
        ldreq             r3, [sp, #0x14]
        moveq             r4, #0
        ldreq             r2, [sp, #0x10]
        mcreq             p15, #0x0, r4, c7, c10, #0x5
        strexdeq          r4, r2, r3, [r1]
        moveq             r1, #1
        cmpeq             r4, #0
        movne             r1, #0
        mcrne             p15, #0x0, r1, c7, c10, #0x5
        strb              r1, [r0, #0x8]
        strd              r6, r7, [r0]
        pop               {r4, r6, r7, pc}

asm_test::compare_exchange_weak::u64::release_relaxed:
        push              {r4, r6, r7, lr}
        ldrexd            r6, r7, [r1]
        eor               r3, r7, r3
        eor               r2, r6, r2
        orrs              r2, r2, r3
        ldreq             r3, [sp, #0x14]
        moveq             r4, #0
        ldreq             r2, [sp, #0x10]
        mcreq             p15, #0x0, r4, c7, c10, #0x5
        strexdeq          r4, r2, r3, [r1]
        moveq             r1, #1
        cmpeq             r4, #0
        strd              r6, r7, [r0]
        movne             r1, #0
        strb              r1, [r0, #0x8]
        pop               {r4, r6, r7, pc}

asm_test::load::u8::seqcst:
        ldrb              r0, [r0]
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
        bx                lr

asm_test::load::u8::acquire:
        ldrb              r0, [r0]
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
        bx                lr

asm_test::load::u8::relaxed:
        ldrb              r0, [r0]
        bx                lr

asm_test::load::u16::seqcst:
        ldrh              r0, [r0]
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
        bx                lr

asm_test::load::u16::acquire:
        ldrh              r0, [r0]
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
        bx                lr

asm_test::load::u16::relaxed:
        ldrh              r0, [r0]
        bx                lr

asm_test::load::u32::seqcst:
        ldr               r0, [r0]
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
        bx                lr

asm_test::load::u32::acquire:
        ldr               r0, [r0]
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
        bx                lr

asm_test::load::u32::relaxed:
        ldr               r0, [r0]
        bx                lr

asm_test::load::u64::seqcst:
        ldrexd            r0, r1, [r0]
        mov               r2, #0
        mcr               p15, #0x0, r2, c7, c10, #0x5
        bx                lr

asm_test::load::u64::acquire:
        ldrexd            r0, r1, [r0]
        mov               r2, #0
        mcr               p15, #0x0, r2, c7, c10, #0x5
        bx                lr

asm_test::load::u64::relaxed:
        ldrexd            r0, r1, [r0]
        bx                lr

asm_test::swap::u8::acqrel:
        mov               r2, #0
        mcr               p15, #0x0, r2, c7, c10, #0x5
0:
        ldrexb            r2, [r0]
        strexb            r3, r1, [r0]
        cmp               r3, #0
        bne               0b
        mov               r0, #0
        mcr               p15, #0x0, r0, c7, c10, #0x5
        mov               r0, r2
        bx                lr

asm_test::swap::u8::seqcst:
        mov               r2, #0
        mcr               p15, #0x0, r2, c7, c10, #0x5
0:
        ldrexb            r2, [r0]
        strexb            r3, r1, [r0]
        cmp               r3, #0
        bne               0b
        mov               r0, #0
        mcr               p15, #0x0, r0, c7, c10, #0x5
        mov               r0, r2
        bx                lr

asm_test::swap::u8::acquire:
        mov               r2, r0
0:
        ldrexb            r0, [r2]
        strexb            r3, r1, [r2]
        cmp               r3, #0
        bne               0b
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
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
        mov               r2, #0
        mcr               p15, #0x0, r2, c7, c10, #0x5
0:
        ldrexb            r2, [r0]
        strexb            r3, r1, [r0]
        cmp               r3, #0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u16::acqrel:
        mov               r2, #0
        mcr               p15, #0x0, r2, c7, c10, #0x5
0:
        ldrexh            r2, [r0]
        strexh            r3, r1, [r0]
        cmp               r3, #0
        bne               0b
        mov               r0, #0
        mcr               p15, #0x0, r0, c7, c10, #0x5
        mov               r0, r2
        bx                lr

asm_test::swap::u16::seqcst:
        mov               r2, #0
        mcr               p15, #0x0, r2, c7, c10, #0x5
0:
        ldrexh            r2, [r0]
        strexh            r3, r1, [r0]
        cmp               r3, #0
        bne               0b
        mov               r0, #0
        mcr               p15, #0x0, r0, c7, c10, #0x5
        mov               r0, r2
        bx                lr

asm_test::swap::u16::acquire:
        mov               r2, r0
0:
        ldrexh            r0, [r2]
        strexh            r3, r1, [r2]
        cmp               r3, #0
        bne               0b
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
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
        mov               r2, #0
        mcr               p15, #0x0, r2, c7, c10, #0x5
0:
        ldrexh            r2, [r0]
        strexh            r3, r1, [r0]
        cmp               r3, #0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u32::acqrel:
        mov               r2, #0
        mcr               p15, #0x0, r2, c7, c10, #0x5
0:
        ldrex             r2, [r0]
        strex             r3, r1, [r0]
        cmp               r3, #0
        bne               0b
        mov               r0, #0
        mcr               p15, #0x0, r0, c7, c10, #0x5
        mov               r0, r2
        bx                lr

asm_test::swap::u32::seqcst:
        mov               r2, #0
        mcr               p15, #0x0, r2, c7, c10, #0x5
0:
        ldrex             r2, [r0]
        strex             r3, r1, [r0]
        cmp               r3, #0
        bne               0b
        mov               r0, #0
        mcr               p15, #0x0, r0, c7, c10, #0x5
        mov               r0, r2
        bx                lr

asm_test::swap::u32::acquire:
        mov               r2, r0
0:
        ldrex             r0, [r2]
        strex             r3, r1, [r2]
        cmp               r3, #0
        bne               0b
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
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
        mov               r2, #0
        mcr               p15, #0x0, r2, c7, c10, #0x5
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
        mov               r0, #0
        mcr               p15, #0x0, r0, c7, c10, #0x5
0:
        ldrexd            r0, r1, [r12]
        strexd            lr, r2, r3, [r12]
        cmp               lr, #0
        bne               0b
        mov               r2, #0
        mcr               p15, #0x0, r2, c7, c10, #0x5
        pop               {r11, pc}

asm_test::swap::u64::seqcst:
        push              {r11, lr}
        mov               r12, r0
        mov               r0, #0
        mcr               p15, #0x0, r0, c7, c10, #0x5
0:
        ldrexd            r0, r1, [r12]
        strexd            lr, r2, r3, [r12]
        cmp               lr, #0
        bne               0b
        mov               r2, #0
        mcr               p15, #0x0, r2, c7, c10, #0x5
        pop               {r11, pc}

asm_test::swap::u64::acquire:
        push              {r11, lr}
        mov               r12, r0
0:
        ldrexd            r0, r1, [r12]
        strexd            lr, r2, r3, [r12]
        cmp               lr, #0
        bne               0b
        mov               r2, #0
        mcr               p15, #0x0, r2, c7, c10, #0x5
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
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
0:
        ldrexd            r4, r5, [r0]
        strexd            r1, r2, r3, [r0]
        cmp               r1, #0
        bne               0b
        mov               r0, r4
        mov               r1, r5
        pop               {r4, r5, r11, pc}

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
        strexd            r1, r2, r3, [r0]
        cmp               r1, #0
        bne               0b
        mov               r0, #0
        mcr               p15, #0x0, r0, c7, c10, #0x5
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
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
0:
        ldrexd            r4, r5, [r0]
        strexd            r1, r2, r3, [r0]
        cmp               r1, #0
        bne               0b
        pop               {r4, r5, r11, pc}

