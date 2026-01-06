asm_test::compare_exchange::u8::acqrel_seqcst:
        push              {r4, lr}
        uxtb              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               1f
        blx               r1
0:
        strexb            r4, r2, [r0]
        cmp               r4, #0
        beq               2f
        ldrexb            r3, [r0]
        cmp               r3, r12
        beq               0b
1:
        mov               r4, #1
2:
        blx               r1
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange::u8::seqcst_seqcst:
        push              {r4, lr}
        uxtb              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               1f
        blx               r1
0:
        strexb            r4, r2, [r0]
        cmp               r4, #0
        beq               2f
        ldrexb            r3, [r0]
        cmp               r3, r12
        beq               0b
1:
        mov               r4, #1
2:
        blx               r1
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange::u8::acqrel_acquire:
        push              {r4, lr}
        uxtb              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               1f
        blx               r1
0:
        strexb            r4, r2, [r0]
        cmp               r4, #0
        beq               2f
        ldrexb            r3, [r0]
        cmp               r3, r12
        beq               0b
1:
        mov               r4, #1
2:
        blx               r1
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange::u8::acqrel_relaxed:
        push              {r4, lr}
        uxtb              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               1f
        blx               r1
0:
        strexb            r4, r2, [r0]
        cmp               r4, #0
        beq               2f
        ldrexb            r3, [r0]
        cmp               r3, r12
        beq               0b
1:
        mov               r4, #1
        b                 3f
2:
        blx               r1
3:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange::u8::acquire_seqcst:
        push              {r4, lr}
        uxtb              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
0:
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               1f
        strexb            r4, r2, [r0]
        cmp               r4, #0
        bne               0b
        blx               r1
        b                 2f
1:
        mov               r4, #1
        blx               r1
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange::u8::relaxed_seqcst:
        push              {r4, lr}
        uxtb              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
0:
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               1f
        strexb            r4, r2, [r0]
        cmp               r4, #0
        bne               0b
        b                 2f
1:
        mov               r4, #1
        blx               r1
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange::u8::release_seqcst:
        push              {r4, lr}
        uxtb              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               1f
        blx               r1
0:
        strexb            r4, r2, [r0]
        cmp               r4, #0
        beq               2f
        ldrexb            r3, [r0]
        cmp               r3, r12
        beq               0b
1:
        mov               r4, #1
        blx               r1
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange::u8::seqcst_acquire:
        push              {r4, lr}
        uxtb              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               1f
        blx               r1
0:
        strexb            r4, r2, [r0]
        cmp               r4, #0
        beq               2f
        ldrexb            r3, [r0]
        cmp               r3, r12
        beq               0b
1:
        mov               r4, #1
2:
        blx               r1
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange::u8::seqcst_relaxed:
        push              {r4, lr}
        uxtb              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               1f
        blx               r1
0:
        strexb            r4, r2, [r0]
        cmp               r4, #0
        beq               2f
        ldrexb            r3, [r0]
        cmp               r3, r12
        beq               0b
1:
        mov               r4, #1
        b                 3f
2:
        blx               r1
3:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange::u8::acquire_acquire:
        push              {r4, lr}
        uxtb              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
0:
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               1f
        strexb            r4, r2, [r0]
        cmp               r4, #0
        bne               0b
        blx               r1
        b                 2f
1:
        mov               r4, #1
        blx               r1
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange::u8::acquire_relaxed:
        push              {r4, lr}
        uxtb              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
0:
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               1f
        strexb            r4, r2, [r0]
        cmp               r4, #0
        bne               0b
        blx               r1
        b                 2f
1:
        mov               r4, #1
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange::u8::relaxed_acquire:
        push              {r4, lr}
        uxtb              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
0:
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               1f
        strexb            r4, r2, [r0]
        cmp               r4, #0
        bne               0b
        b                 2f
1:
        mov               r4, #1
        blx               r1
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

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
        push              {r4, lr}
        uxtb              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               1f
        blx               r1
0:
        strexb            r4, r2, [r0]
        cmp               r4, #0
        beq               2f
        ldrexb            r3, [r0]
        cmp               r3, r12
        beq               0b
1:
        mov               r4, #1
        blx               r1
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange::u8::release_relaxed:
        push              {r4, lr}
        uxtb              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               1f
        blx               r1
0:
        strexb            r4, r2, [r0]
        cmp               r4, #0
        beq               2f
        ldrexb            r3, [r0]
        cmp               r3, r12
        beq               0b
1:
        mov               r4, #1
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange::u16::acqrel_seqcst:
        push              {r4, lr}
        uxth              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               1f
        blx               r1
0:
        strexh            r4, r2, [r0]
        cmp               r4, #0
        beq               2f
        ldrexh            r3, [r0]
        cmp               r3, r12
        beq               0b
1:
        mov               r4, #1
2:
        blx               r1
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange::u16::seqcst_seqcst:
        push              {r4, lr}
        uxth              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               1f
        blx               r1
0:
        strexh            r4, r2, [r0]
        cmp               r4, #0
        beq               2f
        ldrexh            r3, [r0]
        cmp               r3, r12
        beq               0b
1:
        mov               r4, #1
2:
        blx               r1
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange::u16::acqrel_acquire:
        push              {r4, lr}
        uxth              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               1f
        blx               r1
0:
        strexh            r4, r2, [r0]
        cmp               r4, #0
        beq               2f
        ldrexh            r3, [r0]
        cmp               r3, r12
        beq               0b
1:
        mov               r4, #1
2:
        blx               r1
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange::u16::acqrel_relaxed:
        push              {r4, lr}
        uxth              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               1f
        blx               r1
0:
        strexh            r4, r2, [r0]
        cmp               r4, #0
        beq               2f
        ldrexh            r3, [r0]
        cmp               r3, r12
        beq               0b
1:
        mov               r4, #1
        b                 3f
2:
        blx               r1
3:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange::u16::acquire_seqcst:
        push              {r4, lr}
        uxth              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
0:
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               1f
        strexh            r4, r2, [r0]
        cmp               r4, #0
        bne               0b
        blx               r1
        b                 2f
1:
        mov               r4, #1
        blx               r1
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange::u16::relaxed_seqcst:
        push              {r4, lr}
        uxth              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
0:
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               1f
        strexh            r4, r2, [r0]
        cmp               r4, #0
        bne               0b
        b                 2f
1:
        mov               r4, #1
        blx               r1
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange::u16::release_seqcst:
        push              {r4, lr}
        uxth              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               1f
        blx               r1
0:
        strexh            r4, r2, [r0]
        cmp               r4, #0
        beq               2f
        ldrexh            r3, [r0]
        cmp               r3, r12
        beq               0b
1:
        mov               r4, #1
        blx               r1
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange::u16::seqcst_acquire:
        push              {r4, lr}
        uxth              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               1f
        blx               r1
0:
        strexh            r4, r2, [r0]
        cmp               r4, #0
        beq               2f
        ldrexh            r3, [r0]
        cmp               r3, r12
        beq               0b
1:
        mov               r4, #1
2:
        blx               r1
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange::u16::seqcst_relaxed:
        push              {r4, lr}
        uxth              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               1f
        blx               r1
0:
        strexh            r4, r2, [r0]
        cmp               r4, #0
        beq               2f
        ldrexh            r3, [r0]
        cmp               r3, r12
        beq               0b
1:
        mov               r4, #1
        b                 3f
2:
        blx               r1
3:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange::u16::acquire_acquire:
        push              {r4, lr}
        uxth              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
0:
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               1f
        strexh            r4, r2, [r0]
        cmp               r4, #0
        bne               0b
        blx               r1
        b                 2f
1:
        mov               r4, #1
        blx               r1
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange::u16::acquire_relaxed:
        push              {r4, lr}
        uxth              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
0:
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               1f
        strexh            r4, r2, [r0]
        cmp               r4, #0
        bne               0b
        blx               r1
        b                 2f
1:
        mov               r4, #1
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange::u16::relaxed_acquire:
        push              {r4, lr}
        uxth              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
0:
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               1f
        strexh            r4, r2, [r0]
        cmp               r4, #0
        bne               0b
        b                 2f
1:
        mov               r4, #1
        blx               r1
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

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
        push              {r4, lr}
        uxth              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               1f
        blx               r1
0:
        strexh            r4, r2, [r0]
        cmp               r4, #0
        beq               2f
        ldrexh            r3, [r0]
        cmp               r3, r12
        beq               0b
1:
        mov               r4, #1
        blx               r1
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange::u16::release_relaxed:
        push              {r4, lr}
        uxth              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               1f
        blx               r1
0:
        strexh            r4, r2, [r0]
        cmp               r4, #0
        beq               2f
        ldrexh            r3, [r0]
        cmp               r3, r12
        beq               0b
1:
        mov               r4, #1
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange::u32::acqrel_seqcst:
        push              {r4, lr}
        mvn               r3, #95
        sub               r3, r3, #61440
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        blx               r3
0:
        strex             r4, r2, [r0]
        cmp               r4, #0
        beq               2f
        ldrex             r12, [r0]
        cmp               r12, r1
        beq               0b
1:
        mov               r4, #1
2:
        blx               r3
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r4, pc}

asm_test::compare_exchange::u32::seqcst_seqcst:
        push              {r4, lr}
        mvn               r3, #95
        sub               r3, r3, #61440
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        blx               r3
0:
        strex             r4, r2, [r0]
        cmp               r4, #0
        beq               2f
        ldrex             r12, [r0]
        cmp               r12, r1
        beq               0b
1:
        mov               r4, #1
2:
        blx               r3
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r4, pc}

asm_test::compare_exchange::u32::acqrel_acquire:
        push              {r4, lr}
        mvn               r3, #95
        sub               r3, r3, #61440
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        blx               r3
0:
        strex             r4, r2, [r0]
        cmp               r4, #0
        beq               2f
        ldrex             r12, [r0]
        cmp               r12, r1
        beq               0b
1:
        mov               r4, #1
2:
        blx               r3
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r4, pc}

asm_test::compare_exchange::u32::acqrel_relaxed:
        push              {r4, lr}
        mvn               r3, #95
        sub               r3, r3, #61440
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        blx               r3
0:
        strex             r4, r2, [r0]
        cmp               r4, #0
        beq               2f
        ldrex             r12, [r0]
        cmp               r12, r1
        beq               0b
1:
        mov               r4, #1
        b                 3f
2:
        blx               r3
3:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r4, pc}

asm_test::compare_exchange::u32::acquire_seqcst:
        push              {r4, lr}
        mvn               r3, #95
        sub               r3, r3, #61440
0:
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        strex             r4, r2, [r0]
        cmp               r4, #0
        bne               0b
        blx               r3
        b                 2f
1:
        mov               r4, #1
        blx               r3
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r4, pc}

asm_test::compare_exchange::u32::relaxed_seqcst:
        push              {r4, lr}
        mvn               r3, #95
        sub               r3, r3, #61440
0:
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        strex             r4, r2, [r0]
        cmp               r4, #0
        bne               0b
        b                 2f
1:
        mov               r4, #1
        blx               r3
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r4, pc}

asm_test::compare_exchange::u32::release_seqcst:
        push              {r4, lr}
        mvn               r3, #95
        sub               r3, r3, #61440
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        blx               r3
0:
        strex             r4, r2, [r0]
        cmp               r4, #0
        beq               2f
        ldrex             r12, [r0]
        cmp               r12, r1
        beq               0b
1:
        mov               r4, #1
        blx               r3
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r4, pc}

asm_test::compare_exchange::u32::seqcst_acquire:
        push              {r4, lr}
        mvn               r3, #95
        sub               r3, r3, #61440
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        blx               r3
0:
        strex             r4, r2, [r0]
        cmp               r4, #0
        beq               2f
        ldrex             r12, [r0]
        cmp               r12, r1
        beq               0b
1:
        mov               r4, #1
2:
        blx               r3
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r4, pc}

asm_test::compare_exchange::u32::seqcst_relaxed:
        push              {r4, lr}
        mvn               r3, #95
        sub               r3, r3, #61440
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        blx               r3
0:
        strex             r4, r2, [r0]
        cmp               r4, #0
        beq               2f
        ldrex             r12, [r0]
        cmp               r12, r1
        beq               0b
1:
        mov               r4, #1
        b                 3f
2:
        blx               r3
3:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r4, pc}

asm_test::compare_exchange::u32::acquire_acquire:
        push              {r4, lr}
        mvn               r3, #95
        sub               r3, r3, #61440
0:
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        strex             r4, r2, [r0]
        cmp               r4, #0
        bne               0b
        blx               r3
        b                 2f
1:
        mov               r4, #1
        blx               r3
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r4, pc}

asm_test::compare_exchange::u32::acquire_relaxed:
        push              {r4, lr}
        mvn               r3, #95
        sub               r3, r3, #61440
0:
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        strex             r4, r2, [r0]
        cmp               r4, #0
        bne               0b
        blx               r3
        b                 2f
1:
        mov               r4, #1
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r4, pc}

asm_test::compare_exchange::u32::relaxed_acquire:
        push              {r4, lr}
        mvn               r3, #95
        sub               r3, r3, #61440
0:
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        strex             r4, r2, [r0]
        cmp               r4, #0
        bne               0b
        b                 2f
1:
        mov               r4, #1
        blx               r3
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r4, pc}

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
        push              {r4, lr}
        mvn               r3, #95
        sub               r3, r3, #61440
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        blx               r3
0:
        strex             r4, r2, [r0]
        cmp               r4, #0
        beq               2f
        ldrex             r12, [r0]
        cmp               r12, r1
        beq               0b
1:
        mov               r4, #1
        blx               r3
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r4, pc}

asm_test::compare_exchange::u32::release_relaxed:
        push              {r4, lr}
        mvn               r3, #95
        sub               r3, r3, #61440
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        blx               r3
0:
        strex             r4, r2, [r0]
        cmp               r4, #0
        beq               2f
        ldrex             r12, [r0]
        cmp               r12, r1
        beq               0b
1:
        mov               r4, #1
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r4, pc}

asm_test::compare_exchange::u64::acqrel_seqcst:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mvn               r7, #95
        mov               r12, r3
        sub               r7, r7, #61440
        mov               r8, r2
        ldr               r4, [sp, #0x20]
        ldr               r5, [sp, #0x24]
        ldrexd            r2, r3, [r1]
        eor               r6, r3, r12
        eor               r9, r2, r8
        orrs              r9, r9, r6
        bne               1f
        blx               r7
0:
        strexd            r9, r4, r5, [r1]
        cmp               r9, #0
        beq               2f
        ldrexd            r2, r3, [r1]
        eor               r6, r3, r12
        eor               r9, r2, r8
        orrs              r9, r9, r6
        beq               0b
1:
        mov               r9, #1
2:
        blx               r7
        eor               r1, r9, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}

asm_test::compare_exchange::u64::seqcst_seqcst:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mvn               r7, #95
        mov               r12, r3
        sub               r7, r7, #61440
        mov               r8, r2
        ldr               r4, [sp, #0x20]
        ldr               r5, [sp, #0x24]
        ldrexd            r2, r3, [r1]
        eor               r6, r3, r12
        eor               r9, r2, r8
        orrs              r9, r9, r6
        bne               1f
        blx               r7
0:
        strexd            r9, r4, r5, [r1]
        cmp               r9, #0
        beq               2f
        ldrexd            r2, r3, [r1]
        eor               r6, r3, r12
        eor               r9, r2, r8
        orrs              r9, r9, r6
        beq               0b
1:
        mov               r9, #1
2:
        blx               r7
        eor               r1, r9, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}

asm_test::compare_exchange::u64::acqrel_acquire:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mvn               r7, #95
        mov               r12, r3
        sub               r7, r7, #61440
        mov               r8, r2
        ldr               r4, [sp, #0x20]
        ldr               r5, [sp, #0x24]
        ldrexd            r2, r3, [r1]
        eor               r6, r3, r12
        eor               r9, r2, r8
        orrs              r9, r9, r6
        bne               1f
        blx               r7
0:
        strexd            r9, r4, r5, [r1]
        cmp               r9, #0
        beq               2f
        ldrexd            r2, r3, [r1]
        eor               r6, r3, r12
        eor               r9, r2, r8
        orrs              r9, r9, r6
        beq               0b
1:
        mov               r9, #1
2:
        blx               r7
        eor               r1, r9, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}

asm_test::compare_exchange::u64::acqrel_relaxed:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mvn               r7, #95
        mov               r12, r3
        sub               r7, r7, #61440
        mov               r8, r2
        ldr               r4, [sp, #0x20]
        ldr               r5, [sp, #0x24]
        ldrexd            r2, r3, [r1]
        eor               r6, r3, r12
        eor               r9, r2, r8
        orrs              r9, r9, r6
        bne               1f
        blx               r7
0:
        strexd            r9, r4, r5, [r1]
        cmp               r9, #0
        beq               2f
        ldrexd            r2, r3, [r1]
        eor               r6, r3, r12
        eor               r9, r2, r8
        orrs              r9, r9, r6
        beq               0b
1:
        mov               r9, #1
        b                 3f
2:
        blx               r7
3:
        eor               r1, r9, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}

asm_test::compare_exchange::u64::acquire_seqcst:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mvn               r7, #95
        mov               r12, r3
        sub               r7, r7, #61440
        mov               r8, r2
        ldr               r4, [sp, #0x20]
        ldr               r5, [sp, #0x24]
0:
        ldrexd            r2, r3, [r1]
        eor               r6, r3, r12
        eor               r9, r2, r8
        orrs              r9, r9, r6
        bne               1f
        strexd            r9, r4, r5, [r1]
        cmp               r9, #0
        bne               0b
        blx               r7
        b                 2f
1:
        mov               r9, #1
        blx               r7
2:
        eor               r1, r9, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}

asm_test::compare_exchange::u64::relaxed_seqcst:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mvn               r7, #95
        mov               r12, r3
        sub               r7, r7, #61440
        mov               r8, r2
        ldr               r4, [sp, #0x20]
        ldr               r5, [sp, #0x24]
0:
        ldrexd            r2, r3, [r1]
        eor               r6, r3, r12
        eor               r9, r2, r8
        orrs              r9, r9, r6
        bne               1f
        strexd            r9, r4, r5, [r1]
        cmp               r9, #0
        bne               0b
        b                 2f
1:
        mov               r9, #1
        blx               r7
2:
        eor               r1, r9, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}

asm_test::compare_exchange::u64::release_seqcst:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mvn               r7, #95
        mov               r12, r3
        sub               r7, r7, #61440
        mov               r8, r2
        ldr               r4, [sp, #0x20]
        ldr               r5, [sp, #0x24]
        ldrexd            r2, r3, [r1]
        eor               r6, r3, r12
        eor               r9, r2, r8
        orrs              r9, r9, r6
        bne               1f
        blx               r7
0:
        strexd            r9, r4, r5, [r1]
        cmp               r9, #0
        beq               2f
        ldrexd            r2, r3, [r1]
        eor               r6, r3, r12
        eor               r9, r2, r8
        orrs              r9, r9, r6
        beq               0b
1:
        mov               r9, #1
        blx               r7
2:
        eor               r1, r9, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}

asm_test::compare_exchange::u64::seqcst_acquire:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mvn               r7, #95
        mov               r12, r3
        sub               r7, r7, #61440
        mov               r8, r2
        ldr               r4, [sp, #0x20]
        ldr               r5, [sp, #0x24]
        ldrexd            r2, r3, [r1]
        eor               r6, r3, r12
        eor               r9, r2, r8
        orrs              r9, r9, r6
        bne               1f
        blx               r7
0:
        strexd            r9, r4, r5, [r1]
        cmp               r9, #0
        beq               2f
        ldrexd            r2, r3, [r1]
        eor               r6, r3, r12
        eor               r9, r2, r8
        orrs              r9, r9, r6
        beq               0b
1:
        mov               r9, #1
2:
        blx               r7
        eor               r1, r9, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}

asm_test::compare_exchange::u64::seqcst_relaxed:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mvn               r7, #95
        mov               r12, r3
        sub               r7, r7, #61440
        mov               r8, r2
        ldr               r4, [sp, #0x20]
        ldr               r5, [sp, #0x24]
        ldrexd            r2, r3, [r1]
        eor               r6, r3, r12
        eor               r9, r2, r8
        orrs              r9, r9, r6
        bne               1f
        blx               r7
0:
        strexd            r9, r4, r5, [r1]
        cmp               r9, #0
        beq               2f
        ldrexd            r2, r3, [r1]
        eor               r6, r3, r12
        eor               r9, r2, r8
        orrs              r9, r9, r6
        beq               0b
1:
        mov               r9, #1
        b                 3f
2:
        blx               r7
3:
        eor               r1, r9, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}

asm_test::compare_exchange::u64::acquire_acquire:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mvn               r7, #95
        mov               r12, r3
        sub               r7, r7, #61440
        mov               r8, r2
        ldr               r4, [sp, #0x20]
        ldr               r5, [sp, #0x24]
0:
        ldrexd            r2, r3, [r1]
        eor               r6, r3, r12
        eor               r9, r2, r8
        orrs              r9, r9, r6
        bne               1f
        strexd            r9, r4, r5, [r1]
        cmp               r9, #0
        bne               0b
        blx               r7
        b                 2f
1:
        mov               r9, #1
        blx               r7
2:
        eor               r1, r9, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}

asm_test::compare_exchange::u64::acquire_relaxed:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mvn               r7, #95
        mov               r12, r3
        sub               r7, r7, #61440
        mov               r8, r2
        ldr               r4, [sp, #0x20]
        ldr               r5, [sp, #0x24]
0:
        ldrexd            r2, r3, [r1]
        eor               r6, r3, r12
        eor               r9, r2, r8
        orrs              r9, r9, r6
        bne               1f
        strexd            r9, r4, r5, [r1]
        cmp               r9, #0
        bne               0b
        blx               r7
        b                 2f
1:
        mov               r9, #1
2:
        eor               r1, r9, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}

asm_test::compare_exchange::u64::relaxed_acquire:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mvn               r7, #95
        mov               r12, r3
        sub               r7, r7, #61440
        mov               r8, r2
        ldr               r4, [sp, #0x20]
        ldr               r5, [sp, #0x24]
0:
        ldrexd            r2, r3, [r1]
        eor               r6, r3, r12
        eor               r9, r2, r8
        orrs              r9, r9, r6
        bne               1f
        strexd            r9, r4, r5, [r1]
        cmp               r9, #0
        bne               0b
        b                 2f
1:
        mov               r9, #1
        blx               r7
2:
        eor               r1, r9, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}

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
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mvn               r7, #95
        mov               r12, r3
        sub               r7, r7, #61440
        mov               r8, r2
        ldr               r4, [sp, #0x20]
        ldr               r5, [sp, #0x24]
        ldrexd            r2, r3, [r1]
        eor               r6, r3, r12
        eor               r9, r2, r8
        orrs              r9, r9, r6
        bne               1f
        blx               r7
0:
        strexd            r9, r4, r5, [r1]
        cmp               r9, #0
        beq               2f
        ldrexd            r2, r3, [r1]
        eor               r6, r3, r12
        eor               r9, r2, r8
        orrs              r9, r9, r6
        beq               0b
1:
        mov               r9, #1
        blx               r7
2:
        eor               r1, r9, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}

asm_test::compare_exchange::u64::release_relaxed:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mvn               r7, #95
        mov               r12, r3
        sub               r7, r7, #61440
        mov               r8, r2
        ldr               r4, [sp, #0x20]
        ldr               r5, [sp, #0x24]
        ldrexd            r2, r3, [r1]
        eor               r6, r3, r12
        eor               r9, r2, r8
        orrs              r9, r9, r6
        bne               1f
        blx               r7
0:
        strexd            r9, r4, r5, [r1]
        cmp               r9, #0
        beq               2f
        ldrexd            r2, r3, [r1]
        eor               r6, r3, r12
        eor               r9, r2, r8
        orrs              r9, r9, r6
        beq               0b
1:
        mov               r9, #1
2:
        eor               r1, r9, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        push              {r4, lr}
        uxtb              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               0f
        blx               r1
        strexb            r4, r2, [r0]
        b                 1f
0:
        mov               r4, #1
1:
        blx               r1
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        push              {r4, lr}
        uxtb              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               0f
        blx               r1
        strexb            r4, r2, [r0]
        b                 1f
0:
        mov               r4, #1
1:
        blx               r1
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        push              {r4, lr}
        uxtb              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               0f
        blx               r1
        strexb            r4, r2, [r0]
        b                 1f
0:
        mov               r4, #1
1:
        blx               r1
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        push              {r4, lr}
        uxtb              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               0f
        blx               r1
        strexb            r4, r2, [r0]
        cmp               r4, #0
        beq               1f
        b                 2f
0:
        mov               r4, #1
        b                 2f
1:
        blx               r1
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        push              {r4, lr}
        uxtb              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               0f
        strexb            r4, r2, [r0]
        b                 1f
0:
        mov               r4, #1
1:
        blx               r1
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        push              {r4, lr}
        uxtb              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               0f
        strexb            r4, r2, [r0]
        cmp               r4, #0
        beq               2f
        b                 1f
0:
        mov               r4, #1
1:
        blx               r1
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u8::release_seqcst:
        push              {r4, lr}
        uxtb              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               0f
        blx               r1
        strexb            r4, r2, [r0]
        cmp               r4, #0
        beq               2f
        b                 1f
0:
        mov               r4, #1
1:
        blx               r1
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        push              {r4, lr}
        uxtb              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               0f
        blx               r1
        strexb            r4, r2, [r0]
        b                 1f
0:
        mov               r4, #1
1:
        blx               r1
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        push              {r4, lr}
        uxtb              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               0f
        blx               r1
        strexb            r4, r2, [r0]
        cmp               r4, #0
        beq               1f
        b                 2f
0:
        mov               r4, #1
        b                 2f
1:
        blx               r1
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u8::acquire_acquire:
        push              {r4, lr}
        uxtb              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               0f
        strexb            r4, r2, [r0]
        b                 1f
0:
        mov               r4, #1
1:
        blx               r1
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        push              {r4, lr}
        uxtb              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               0f
        strexb            r4, r2, [r0]
        cmp               r4, #0
        beq               1f
        b                 2f
0:
        mov               r4, #1
        b                 2f
1:
        blx               r1
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        push              {r4, lr}
        uxtb              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               0f
        strexb            r4, r2, [r0]
        cmp               r4, #0
        beq               2f
        b                 1f
0:
        mov               r4, #1
1:
        blx               r1
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

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
        push              {r4, lr}
        uxtb              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               0f
        blx               r1
        strexb            r4, r2, [r0]
        cmp               r4, #0
        beq               2f
        b                 1f
0:
        mov               r4, #1
1:
        blx               r1
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u8::release_relaxed:
        push              {r4, lr}
        uxtb              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexb            r3, [r0]
        cmp               r3, r12
        bne               0f
        blx               r1
        strexb            r4, r2, [r0]
        b                 1f
0:
        mov               r4, #1
1:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        push              {r4, lr}
        uxth              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               0f
        blx               r1
        strexh            r4, r2, [r0]
        b                 1f
0:
        mov               r4, #1
1:
        blx               r1
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        push              {r4, lr}
        uxth              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               0f
        blx               r1
        strexh            r4, r2, [r0]
        b                 1f
0:
        mov               r4, #1
1:
        blx               r1
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        push              {r4, lr}
        uxth              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               0f
        blx               r1
        strexh            r4, r2, [r0]
        b                 1f
0:
        mov               r4, #1
1:
        blx               r1
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        push              {r4, lr}
        uxth              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               0f
        blx               r1
        strexh            r4, r2, [r0]
        cmp               r4, #0
        beq               1f
        b                 2f
0:
        mov               r4, #1
        b                 2f
1:
        blx               r1
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        push              {r4, lr}
        uxth              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               0f
        strexh            r4, r2, [r0]
        b                 1f
0:
        mov               r4, #1
1:
        blx               r1
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        push              {r4, lr}
        uxth              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               0f
        strexh            r4, r2, [r0]
        cmp               r4, #0
        beq               2f
        b                 1f
0:
        mov               r4, #1
1:
        blx               r1
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u16::release_seqcst:
        push              {r4, lr}
        uxth              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               0f
        blx               r1
        strexh            r4, r2, [r0]
        cmp               r4, #0
        beq               2f
        b                 1f
0:
        mov               r4, #1
1:
        blx               r1
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        push              {r4, lr}
        uxth              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               0f
        blx               r1
        strexh            r4, r2, [r0]
        b                 1f
0:
        mov               r4, #1
1:
        blx               r1
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        push              {r4, lr}
        uxth              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               0f
        blx               r1
        strexh            r4, r2, [r0]
        cmp               r4, #0
        beq               1f
        b                 2f
0:
        mov               r4, #1
        b                 2f
1:
        blx               r1
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u16::acquire_acquire:
        push              {r4, lr}
        uxth              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               0f
        strexh            r4, r2, [r0]
        b                 1f
0:
        mov               r4, #1
1:
        blx               r1
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        push              {r4, lr}
        uxth              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               0f
        strexh            r4, r2, [r0]
        cmp               r4, #0
        beq               1f
        b                 2f
0:
        mov               r4, #1
        b                 2f
1:
        blx               r1
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        push              {r4, lr}
        uxth              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               0f
        strexh            r4, r2, [r0]
        cmp               r4, #0
        beq               2f
        b                 1f
0:
        mov               r4, #1
1:
        blx               r1
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

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
        push              {r4, lr}
        uxth              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               0f
        blx               r1
        strexh            r4, r2, [r0]
        cmp               r4, #0
        beq               2f
        b                 1f
0:
        mov               r4, #1
1:
        blx               r1
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u16::release_relaxed:
        push              {r4, lr}
        uxth              r12, r1
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrexh            r3, [r0]
        cmp               r3, r12
        bne               0f
        blx               r1
        strexh            r4, r2, [r0]
        b                 1f
0:
        mov               r4, #1
1:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        push              {r4, lr}
        mvn               r3, #95
        sub               r3, r3, #61440
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        blx               r3
        strex             r4, r2, [r0]
        b                 1f
0:
        mov               r4, #1
1:
        blx               r3
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r4, pc}

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        push              {r4, lr}
        mvn               r3, #95
        sub               r3, r3, #61440
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        blx               r3
        strex             r4, r2, [r0]
        b                 1f
0:
        mov               r4, #1
1:
        blx               r3
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r4, pc}

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        push              {r4, lr}
        mvn               r3, #95
        sub               r3, r3, #61440
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        blx               r3
        strex             r4, r2, [r0]
        b                 1f
0:
        mov               r4, #1
1:
        blx               r3
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r4, pc}

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        push              {r4, lr}
        mvn               r3, #95
        sub               r3, r3, #61440
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        blx               r3
        strex             r4, r2, [r0]
        cmp               r4, #0
        beq               1f
        b                 2f
0:
        mov               r4, #1
        b                 2f
1:
        blx               r3
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r4, pc}

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        push              {r4, lr}
        mvn               r3, #95
        sub               r3, r3, #61440
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        strex             r4, r2, [r0]
        b                 1f
0:
        mov               r4, #1
1:
        blx               r3
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r4, pc}

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        push              {r4, lr}
        mvn               r3, #95
        sub               r3, r3, #61440
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        strex             r4, r2, [r0]
        cmp               r4, #0
        beq               2f
        b                 1f
0:
        mov               r4, #1
1:
        blx               r3
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r4, pc}

asm_test::compare_exchange_weak::u32::release_seqcst:
        push              {r4, lr}
        mvn               r3, #95
        sub               r3, r3, #61440
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        blx               r3
        strex             r4, r2, [r0]
        cmp               r4, #0
        beq               2f
        b                 1f
0:
        mov               r4, #1
1:
        blx               r3
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r4, pc}

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        push              {r4, lr}
        mvn               r3, #95
        sub               r3, r3, #61440
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        blx               r3
        strex             r4, r2, [r0]
        b                 1f
0:
        mov               r4, #1
1:
        blx               r3
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r4, pc}

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        push              {r4, lr}
        mvn               r3, #95
        sub               r3, r3, #61440
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        blx               r3
        strex             r4, r2, [r0]
        cmp               r4, #0
        beq               1f
        b                 2f
0:
        mov               r4, #1
        b                 2f
1:
        blx               r3
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r4, pc}

asm_test::compare_exchange_weak::u32::acquire_acquire:
        push              {r4, lr}
        mvn               r3, #95
        sub               r3, r3, #61440
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        strex             r4, r2, [r0]
        b                 1f
0:
        mov               r4, #1
1:
        blx               r3
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r4, pc}

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        push              {r4, lr}
        mvn               r3, #95
        sub               r3, r3, #61440
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        strex             r4, r2, [r0]
        cmp               r4, #0
        beq               1f
        b                 2f
0:
        mov               r4, #1
        b                 2f
1:
        blx               r3
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r4, pc}

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        push              {r4, lr}
        mvn               r3, #95
        sub               r3, r3, #61440
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        strex             r4, r2, [r0]
        cmp               r4, #0
        beq               2f
        b                 1f
0:
        mov               r4, #1
1:
        blx               r3
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r4, pc}

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
        push              {r4, lr}
        mvn               r3, #95
        sub               r3, r3, #61440
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        blx               r3
        strex             r4, r2, [r0]
        cmp               r4, #0
        beq               2f
        b                 1f
0:
        mov               r4, #1
1:
        blx               r3
2:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r4, pc}

asm_test::compare_exchange_weak::u32::release_relaxed:
        push              {r4, lr}
        mvn               r3, #95
        sub               r3, r3, #61440
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        blx               r3
        strex             r4, r2, [r0]
        b                 1f
0:
        mov               r4, #1
1:
        clz               r0, r4
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r4, pc}

asm_test::compare_exchange_weak::u64::acqrel_seqcst:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mvn               r7, #95
        mov               r12, r3
        sub               r7, r7, #61440
        mov               r8, r2
        ldr               r4, [sp, #0x20]
        ldr               r5, [sp, #0x24]
        ldrexd            r2, r3, [r1]
        eor               r6, r3, r12
        eor               r9, r2, r8
        orrs              r9, r9, r6
        bne               0f
        blx               r7
        strexd            r9, r4, r5, [r1]
        b                 1f
0:
        mov               r9, #1
1:
        blx               r7
        eor               r1, r9, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}

asm_test::compare_exchange_weak::u64::seqcst_seqcst:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mvn               r7, #95
        mov               r12, r3
        sub               r7, r7, #61440
        mov               r8, r2
        ldr               r4, [sp, #0x20]
        ldr               r5, [sp, #0x24]
        ldrexd            r2, r3, [r1]
        eor               r6, r3, r12
        eor               r9, r2, r8
        orrs              r9, r9, r6
        bne               0f
        blx               r7
        strexd            r9, r4, r5, [r1]
        b                 1f
0:
        mov               r9, #1
1:
        blx               r7
        eor               r1, r9, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}

asm_test::compare_exchange_weak::u64::acqrel_acquire:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mvn               r7, #95
        mov               r12, r3
        sub               r7, r7, #61440
        mov               r8, r2
        ldr               r4, [sp, #0x20]
        ldr               r5, [sp, #0x24]
        ldrexd            r2, r3, [r1]
        eor               r6, r3, r12
        eor               r9, r2, r8
        orrs              r9, r9, r6
        bne               0f
        blx               r7
        strexd            r9, r4, r5, [r1]
        b                 1f
0:
        mov               r9, #1
1:
        blx               r7
        eor               r1, r9, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}

asm_test::compare_exchange_weak::u64::acqrel_relaxed:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mvn               r7, #95
        mov               r12, r3
        sub               r7, r7, #61440
        mov               r8, r2
        ldr               r4, [sp, #0x20]
        ldr               r5, [sp, #0x24]
        ldrexd            r2, r3, [r1]
        eor               r6, r3, r12
        eor               r9, r2, r8
        orrs              r9, r9, r6
        bne               0f
        blx               r7
        strexd            r9, r4, r5, [r1]
        cmp               r9, #0
        beq               1f
        b                 2f
0:
        mov               r9, #1
        b                 2f
1:
        blx               r7
2:
        eor               r1, r9, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}

asm_test::compare_exchange_weak::u64::acquire_seqcst:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mvn               r7, #95
        mov               r12, r3
        sub               r7, r7, #61440
        mov               r8, r2
        ldr               r4, [sp, #0x20]
        ldr               r5, [sp, #0x24]
        ldrexd            r2, r3, [r1]
        eor               r6, r3, r12
        eor               r9, r2, r8
        orrs              r9, r9, r6
        bne               0f
        strexd            r9, r4, r5, [r1]
        b                 1f
0:
        mov               r9, #1
1:
        blx               r7
        eor               r1, r9, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}

asm_test::compare_exchange_weak::u64::relaxed_seqcst:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mvn               r7, #95
        mov               r12, r3
        sub               r7, r7, #61440
        mov               r8, r2
        ldr               r4, [sp, #0x20]
        ldr               r5, [sp, #0x24]
        ldrexd            r2, r3, [r1]
        eor               r6, r3, r12
        eor               r9, r2, r8
        orrs              r9, r9, r6
        bne               0f
        strexd            r9, r4, r5, [r1]
        cmp               r9, #0
        beq               2f
        b                 1f
0:
        mov               r9, #1
1:
        blx               r7
2:
        eor               r1, r9, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}

asm_test::compare_exchange_weak::u64::release_seqcst:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mvn               r7, #95
        mov               r12, r3
        sub               r7, r7, #61440
        mov               r8, r2
        ldr               r4, [sp, #0x20]
        ldr               r5, [sp, #0x24]
        ldrexd            r2, r3, [r1]
        eor               r6, r3, r12
        eor               r9, r2, r8
        orrs              r9, r9, r6
        bne               0f
        blx               r7
        strexd            r9, r4, r5, [r1]
        cmp               r9, #0
        beq               2f
        b                 1f
0:
        mov               r9, #1
1:
        blx               r7
2:
        eor               r1, r9, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}

asm_test::compare_exchange_weak::u64::seqcst_acquire:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mvn               r7, #95
        mov               r12, r3
        sub               r7, r7, #61440
        mov               r8, r2
        ldr               r4, [sp, #0x20]
        ldr               r5, [sp, #0x24]
        ldrexd            r2, r3, [r1]
        eor               r6, r3, r12
        eor               r9, r2, r8
        orrs              r9, r9, r6
        bne               0f
        blx               r7
        strexd            r9, r4, r5, [r1]
        b                 1f
0:
        mov               r9, #1
1:
        blx               r7
        eor               r1, r9, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}

asm_test::compare_exchange_weak::u64::seqcst_relaxed:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mvn               r7, #95
        mov               r12, r3
        sub               r7, r7, #61440
        mov               r8, r2
        ldr               r4, [sp, #0x20]
        ldr               r5, [sp, #0x24]
        ldrexd            r2, r3, [r1]
        eor               r6, r3, r12
        eor               r9, r2, r8
        orrs              r9, r9, r6
        bne               0f
        blx               r7
        strexd            r9, r4, r5, [r1]
        cmp               r9, #0
        beq               1f
        b                 2f
0:
        mov               r9, #1
        b                 2f
1:
        blx               r7
2:
        eor               r1, r9, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}

asm_test::compare_exchange_weak::u64::acquire_acquire:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mvn               r7, #95
        mov               r12, r3
        sub               r7, r7, #61440
        mov               r8, r2
        ldr               r4, [sp, #0x20]
        ldr               r5, [sp, #0x24]
        ldrexd            r2, r3, [r1]
        eor               r6, r3, r12
        eor               r9, r2, r8
        orrs              r9, r9, r6
        bne               0f
        strexd            r9, r4, r5, [r1]
        b                 1f
0:
        mov               r9, #1
1:
        blx               r7
        eor               r1, r9, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}

asm_test::compare_exchange_weak::u64::acquire_relaxed:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mvn               r7, #95
        mov               r12, r3
        sub               r7, r7, #61440
        mov               r8, r2
        ldr               r4, [sp, #0x20]
        ldr               r5, [sp, #0x24]
        ldrexd            r2, r3, [r1]
        eor               r6, r3, r12
        eor               r9, r2, r8
        orrs              r9, r9, r6
        bne               0f
        strexd            r9, r4, r5, [r1]
        cmp               r9, #0
        beq               1f
        b                 2f
0:
        mov               r9, #1
        b                 2f
1:
        blx               r7
2:
        eor               r1, r9, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}

asm_test::compare_exchange_weak::u64::relaxed_acquire:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mvn               r7, #95
        mov               r12, r3
        sub               r7, r7, #61440
        mov               r8, r2
        ldr               r4, [sp, #0x20]
        ldr               r5, [sp, #0x24]
        ldrexd            r2, r3, [r1]
        eor               r6, r3, r12
        eor               r9, r2, r8
        orrs              r9, r9, r6
        bne               0f
        strexd            r9, r4, r5, [r1]
        cmp               r9, #0
        beq               2f
        b                 1f
0:
        mov               r9, #1
1:
        blx               r7
2:
        eor               r1, r9, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}

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
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mvn               r7, #95
        mov               r12, r3
        sub               r7, r7, #61440
        mov               r8, r2
        ldr               r4, [sp, #0x20]
        ldr               r5, [sp, #0x24]
        ldrexd            r2, r3, [r1]
        eor               r6, r3, r12
        eor               r9, r2, r8
        orrs              r9, r9, r6
        bne               0f
        blx               r7
        strexd            r9, r4, r5, [r1]
        cmp               r9, #0
        beq               2f
        b                 1f
0:
        mov               r9, #1
1:
        blx               r7
2:
        eor               r1, r9, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}

asm_test::compare_exchange_weak::u64::release_relaxed:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mvn               r7, #95
        mov               r12, r3
        sub               r7, r7, #61440
        mov               r8, r2
        ldr               r4, [sp, #0x20]
        ldr               r5, [sp, #0x24]
        ldrexd            r2, r3, [r1]
        eor               r6, r3, r12
        eor               r9, r2, r8
        orrs              r9, r9, r6
        bne               0f
        blx               r7
        strexd            r9, r4, r5, [r1]
        b                 1f
0:
        mov               r9, #1
1:
        eor               r1, r9, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}

asm_test::load::u8::seqcst:
        push              {r11, lr}
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrb              r0, [r0]
        blx               r1
        pop               {r11, pc}

asm_test::load::u8::acquire:
        push              {r11, lr}
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrb              r0, [r0]
        blx               r1
        pop               {r11, pc}

asm_test::load::u8::relaxed:
        ldrb              r0, [r0]
        bx                lr

asm_test::load::u16::seqcst:
        push              {r11, lr}
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrh              r0, [r0]
        blx               r1
        pop               {r11, pc}

asm_test::load::u16::acquire:
        push              {r11, lr}
        mvn               r1, #95
        sub               r1, r1, #61440
        ldrh              r0, [r0]
        blx               r1
        pop               {r11, pc}

asm_test::load::u16::relaxed:
        ldrh              r0, [r0]
        bx                lr

asm_test::load::u32::seqcst:
        push              {r11, lr}
        mvn               r1, #95
        sub               r1, r1, #61440
        ldr               r0, [r0]
        blx               r1
        pop               {r11, pc}

asm_test::load::u32::acquire:
        push              {r11, lr}
        mvn               r1, #95
        sub               r1, r1, #61440
        ldr               r0, [r0]
        blx               r1
        pop               {r11, pc}

asm_test::load::u32::relaxed:
        ldr               r0, [r0]
        bx                lr

asm_test::load::u64::seqcst:
        push              {r11, lr}
        mvn               r2, #95
        sub               r2, r2, #61440
        ldrexd            r0, r1, [r0]
        blx               r2
        pop               {r11, pc}

asm_test::load::u64::acquire:
        push              {r11, lr}
        mvn               r2, #95
        sub               r2, r2, #61440
        ldrexd            r0, r1, [r0]
        blx               r2
        pop               {r11, pc}

asm_test::load::u64::relaxed:
        ldrexd            r0, r1, [r0]
        bx                lr

asm_test::swap::u8::acqrel:
        push              {r11, lr}
        mvn               r3, #95
        sub               r3, r3, #61440
        blx               r3
0:
        ldrexb            r2, [r0]
        strexb            r12, r1, [r0]
        cmp               r12, #0
        bne               0b
        blx               r3
        mov               r0, r2
        pop               {r11, pc}

asm_test::swap::u8::seqcst:
        push              {r11, lr}
        mvn               r3, #95
        sub               r3, r3, #61440
        blx               r3
0:
        ldrexb            r2, [r0]
        strexb            r12, r1, [r0]
        cmp               r12, #0
        bne               0b
        blx               r3
        mov               r0, r2
        pop               {r11, pc}

asm_test::swap::u8::acquire:
        push              {r11, lr}
        mvn               r3, #95
        sub               r3, r3, #61440
0:
        ldrexb            r2, [r0]
        strexb            r12, r1, [r0]
        cmp               r12, #0
        bne               0b
        blx               r3
        mov               r0, r2
        pop               {r11, pc}

asm_test::swap::u8::relaxed:
0:
        ldrexb            r2, [r0]
        strexb            r3, r1, [r0]
        cmp               r3, #0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u8::release:
        push              {r11, lr}
        mvn               r3, #95
        sub               r3, r3, #61440
        blx               r3
0:
        ldrexb            r2, [r0]
        strexb            r12, r1, [r0]
        cmp               r12, #0
        bne               0b
        mov               r0, r2
        pop               {r11, pc}

asm_test::swap::u16::acqrel:
        push              {r11, lr}
        mvn               r3, #95
        sub               r3, r3, #61440
        blx               r3
0:
        ldrexh            r2, [r0]
        strexh            r12, r1, [r0]
        cmp               r12, #0
        bne               0b
        blx               r3
        mov               r0, r2
        pop               {r11, pc}

asm_test::swap::u16::seqcst:
        push              {r11, lr}
        mvn               r3, #95
        sub               r3, r3, #61440
        blx               r3
0:
        ldrexh            r2, [r0]
        strexh            r12, r1, [r0]
        cmp               r12, #0
        bne               0b
        blx               r3
        mov               r0, r2
        pop               {r11, pc}

asm_test::swap::u16::acquire:
        push              {r11, lr}
        mvn               r3, #95
        sub               r3, r3, #61440
0:
        ldrexh            r2, [r0]
        strexh            r12, r1, [r0]
        cmp               r12, #0
        bne               0b
        blx               r3
        mov               r0, r2
        pop               {r11, pc}

asm_test::swap::u16::relaxed:
0:
        ldrexh            r2, [r0]
        strexh            r3, r1, [r0]
        cmp               r3, #0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u16::release:
        push              {r11, lr}
        mvn               r3, #95
        sub               r3, r3, #61440
        blx               r3
0:
        ldrexh            r2, [r0]
        strexh            r12, r1, [r0]
        cmp               r12, #0
        bne               0b
        mov               r0, r2
        pop               {r11, pc}

asm_test::swap::u32::acqrel:
        push              {r11, lr}
        mvn               r3, #95
        sub               r3, r3, #61440
        blx               r3
0:
        ldrex             r2, [r0]
        strex             r12, r1, [r0]
        cmp               r12, #0
        bne               0b
        blx               r3
        mov               r0, r2
        pop               {r11, pc}

asm_test::swap::u32::seqcst:
        push              {r11, lr}
        mvn               r3, #95
        sub               r3, r3, #61440
        blx               r3
0:
        ldrex             r2, [r0]
        strex             r12, r1, [r0]
        cmp               r12, #0
        bne               0b
        blx               r3
        mov               r0, r2
        pop               {r11, pc}

asm_test::swap::u32::acquire:
        push              {r11, lr}
        mvn               r3, #95
        sub               r3, r3, #61440
0:
        ldrex             r2, [r0]
        strex             r12, r1, [r0]
        cmp               r12, #0
        bne               0b
        blx               r3
        mov               r0, r2
        pop               {r11, pc}

asm_test::swap::u32::relaxed:
0:
        ldrex             r2, [r0]
        strex             r3, r1, [r0]
        cmp               r3, #0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u32::release:
        push              {r11, lr}
        mvn               r3, #95
        sub               r3, r3, #61440
        blx               r3
0:
        ldrex             r2, [r0]
        strex             r12, r1, [r0]
        cmp               r12, #0
        bne               0b
        mov               r0, r2
        pop               {r11, pc}

asm_test::swap::u64::acqrel:
        push              {r4, r5, r11, lr}
        mvn               r4, #95
        mov               r12, r0
        sub               r4, r4, #61440
        blx               r4
0:
        ldrexd            r0, r1, [r12]
        strexd            r5, r2, r3, [r12]
        cmp               r5, #0
        bne               0b
        blx               r4
        pop               {r4, r5, r11, pc}

asm_test::swap::u64::seqcst:
        push              {r4, r5, r11, lr}
        mvn               r4, #95
        mov               r12, r0
        sub               r4, r4, #61440
        blx               r4
0:
        ldrexd            r0, r1, [r12]
        strexd            r5, r2, r3, [r12]
        cmp               r5, #0
        bne               0b
        blx               r4
        pop               {r4, r5, r11, pc}

asm_test::swap::u64::acquire:
        push              {r4, r5, r11, lr}
        mvn               r4, #95
        mov               r12, r0
        sub               r4, r4, #61440
0:
        ldrexd            r0, r1, [r12]
        strexd            r5, r2, r3, [r12]
        cmp               r5, #0
        bne               0b
        blx               r4
        pop               {r4, r5, r11, pc}

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
        mvn               r4, #95
        mov               r12, r0
        sub               r4, r4, #61440
        blx               r4
0:
        ldrexd            r0, r1, [r12]
        strexd            r5, r2, r3, [r12]
        cmp               r5, #0
        bne               0b
        pop               {r4, r5, r11, pc}

asm_test::store::u8::seqcst:
        push              {r11, lr}
        mvn               r2, #95
        sub               r2, r2, #61440
        blx               r2
        strb              r1, [r0]
        blx               r2
        pop               {r11, pc}

asm_test::store::u8::relaxed:
        strb              r1, [r0]
        bx                lr

asm_test::store::u8::release:
        push              {r11, lr}
        mvn               r2, #95
        sub               r2, r2, #61440
        blx               r2
        strb              r1, [r0]
        pop               {r11, pc}

asm_test::store::u16::seqcst:
        push              {r11, lr}
        mvn               r2, #95
        sub               r2, r2, #61440
        blx               r2
        strh              r1, [r0]
        blx               r2
        pop               {r11, pc}

asm_test::store::u16::relaxed:
        strh              r1, [r0]
        bx                lr

asm_test::store::u16::release:
        push              {r11, lr}
        mvn               r2, #95
        sub               r2, r2, #61440
        blx               r2
        strh              r1, [r0]
        pop               {r11, pc}

asm_test::store::u32::seqcst:
        push              {r11, lr}
        mvn               r2, #95
        sub               r2, r2, #61440
        blx               r2
        str               r1, [r0]
        blx               r2
        pop               {r11, pc}

asm_test::store::u32::relaxed:
        str               r1, [r0]
        bx                lr

asm_test::store::u32::release:
        push              {r11, lr}
        mvn               r2, #95
        sub               r2, r2, #61440
        blx               r2
        str               r1, [r0]
        pop               {r11, pc}

asm_test::store::u64::seqcst:
        push              {r4, r5, r11, lr}
        mvn               r1, #95
        sub               r1, r1, #61440
        blx               r1
0:
        ldrexd            r4, r5, [r0]
        strexd            r4, r2, r3, [r0]
        cmp               r4, #0
        bne               0b
        blx               r1
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
        mvn               r1, #95
        sub               r1, r1, #61440
        blx               r1
0:
        ldrexd            r4, r5, [r0]
        strexd            r4, r2, r3, [r0]
        cmp               r4, #0
        bne               0b
        pop               {r4, r5, r11, pc}

