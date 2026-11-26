asm_test::compare_exchange::u8::acqrel_seqcst:
        push              {r4, lr}
        mov               r3, r0
        uxtb              r1, r1
0:
        ldaexb            r0, [r3]
        cmp               r0, r1
        bne               1f
        stlexb            r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange::u8::seqcst_seqcst:
        push              {r4, lr}
        mov               r3, r0
        uxtb              r1, r1
0:
        ldaexb            r0, [r3]
        cmp               r0, r1
        bne               1f
        stlexb            r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange::u8::acqrel_acquire:
        push              {r4, lr}
        mov               r3, r0
        uxtb              r1, r1
0:
        ldaexb            r0, [r3]
        cmp               r0, r1
        bne               1f
        stlexb            r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange::u8::acqrel_relaxed:
        push              {r4, lr}
        mov               r3, r0
        uxtb              r1, r1
0:
        ldaexb            r0, [r3]
        cmp               r0, r1
        bne               1f
        stlexb            r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange::u8::acquire_seqcst:
        push              {r4, lr}
        mov               r3, r0
        uxtb              r1, r1
0:
        ldaexb            r0, [r3]
        cmp               r0, r1
        bne               1f
        stlexb            r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange::u8::relaxed_seqcst:
        push              {r4, lr}
        mov               r3, r0
        uxtb              r1, r1
0:
        ldaexb            r0, [r3]
        cmp               r0, r1
        bne               1f
        stlexb            r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange::u8::release_seqcst:
        push              {r4, lr}
        mov               r3, r0
        uxtb              r1, r1
0:
        ldaexb            r0, [r3]
        cmp               r0, r1
        bne               1f
        stlexb            r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange::u8::seqcst_acquire:
        push              {r4, lr}
        mov               r3, r0
        uxtb              r1, r1
0:
        ldaexb            r0, [r3]
        cmp               r0, r1
        bne               1f
        stlexb            r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange::u8::seqcst_relaxed:
        push              {r4, lr}
        mov               r3, r0
        uxtb              r1, r1
0:
        ldaexb            r0, [r3]
        cmp               r0, r1
        bne               1f
        stlexb            r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange::u8::acquire_acquire:
        push              {r4, lr}
        mov               r3, r0
        uxtb              r1, r1
0:
        ldaexb            r0, [r3]
        cmp               r0, r1
        bne               1f
        strexb            r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange::u8::acquire_relaxed:
        push              {r4, lr}
        mov               r3, r0
        uxtb              r1, r1
0:
        ldaexb            r0, [r3]
        cmp               r0, r1
        bne               1f
        strexb            r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange::u8::relaxed_acquire:
        push              {r4, lr}
        mov               r3, r0
        uxtb              r1, r1
0:
        ldaexb            r0, [r3]
        cmp               r0, r1
        bne               1f
        strexb            r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange::u8::relaxed_relaxed:
        push              {r4, lr}
        mov               r3, r0
        uxtb              r1, r1
0:
        ldrexb            r0, [r3]
        cmp               r0, r1
        bne               1f
        strexb            r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange::u8::release_acquire:
        push              {r4, lr}
        mov               r3, r0
        uxtb              r1, r1
0:
        ldaexb            r0, [r3]
        cmp               r0, r1
        bne               1f
        stlexb            r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange::u8::release_relaxed:
        push              {r4, lr}
        mov               r3, r0
        uxtb              r1, r1
0:
        ldrexb            r0, [r3]
        cmp               r0, r1
        bne               1f
        stlexb            r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange::u16::acqrel_seqcst:
        push              {r4, lr}
        mov               r3, r0
        uxth              r1, r1
0:
        ldaexh            r0, [r3]
        cmp               r0, r1
        bne               1f
        stlexh            r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange::u16::seqcst_seqcst:
        push              {r4, lr}
        mov               r3, r0
        uxth              r1, r1
0:
        ldaexh            r0, [r3]
        cmp               r0, r1
        bne               1f
        stlexh            r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange::u16::acqrel_acquire:
        push              {r4, lr}
        mov               r3, r0
        uxth              r1, r1
0:
        ldaexh            r0, [r3]
        cmp               r0, r1
        bne               1f
        stlexh            r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange::u16::acqrel_relaxed:
        push              {r4, lr}
        mov               r3, r0
        uxth              r1, r1
0:
        ldaexh            r0, [r3]
        cmp               r0, r1
        bne               1f
        stlexh            r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange::u16::acquire_seqcst:
        push              {r4, lr}
        mov               r3, r0
        uxth              r1, r1
0:
        ldaexh            r0, [r3]
        cmp               r0, r1
        bne               1f
        stlexh            r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange::u16::relaxed_seqcst:
        push              {r4, lr}
        mov               r3, r0
        uxth              r1, r1
0:
        ldaexh            r0, [r3]
        cmp               r0, r1
        bne               1f
        stlexh            r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange::u16::release_seqcst:
        push              {r4, lr}
        mov               r3, r0
        uxth              r1, r1
0:
        ldaexh            r0, [r3]
        cmp               r0, r1
        bne               1f
        stlexh            r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange::u16::seqcst_acquire:
        push              {r4, lr}
        mov               r3, r0
        uxth              r1, r1
0:
        ldaexh            r0, [r3]
        cmp               r0, r1
        bne               1f
        stlexh            r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange::u16::seqcst_relaxed:
        push              {r4, lr}
        mov               r3, r0
        uxth              r1, r1
0:
        ldaexh            r0, [r3]
        cmp               r0, r1
        bne               1f
        stlexh            r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange::u16::acquire_acquire:
        push              {r4, lr}
        mov               r3, r0
        uxth              r1, r1
0:
        ldaexh            r0, [r3]
        cmp               r0, r1
        bne               1f
        strexh            r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange::u16::acquire_relaxed:
        push              {r4, lr}
        mov               r3, r0
        uxth              r1, r1
0:
        ldaexh            r0, [r3]
        cmp               r0, r1
        bne               1f
        strexh            r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange::u16::relaxed_acquire:
        push              {r4, lr}
        mov               r3, r0
        uxth              r1, r1
0:
        ldaexh            r0, [r3]
        cmp               r0, r1
        bne               1f
        strexh            r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange::u16::relaxed_relaxed:
        push              {r4, lr}
        mov               r3, r0
        uxth              r1, r1
0:
        ldrexh            r0, [r3]
        cmp               r0, r1
        bne               1f
        strexh            r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange::u16::release_acquire:
        push              {r4, lr}
        mov               r3, r0
        uxth              r1, r1
0:
        ldaexh            r0, [r3]
        cmp               r0, r1
        bne               1f
        stlexh            r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange::u16::release_relaxed:
        push              {r4, lr}
        mov               r3, r0
        uxth              r1, r1
0:
        ldrexh            r0, [r3]
        cmp               r0, r1
        bne               1f
        stlexh            r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange::u32::acqrel_seqcst:
        push              {r4, lr}
        mov               r3, r0
0:
        ldaex             r0, [r3]
        cmp               r0, r1
        bne               1f
        stlex             r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange::u32::seqcst_seqcst:
        push              {r4, lr}
        mov               r3, r0
0:
        ldaex             r0, [r3]
        cmp               r0, r1
        bne               1f
        stlex             r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange::u32::acqrel_acquire:
        push              {r4, lr}
        mov               r3, r0
0:
        ldaex             r0, [r3]
        cmp               r0, r1
        bne               1f
        stlex             r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange::u32::acqrel_relaxed:
        push              {r4, lr}
        mov               r3, r0
0:
        ldaex             r0, [r3]
        cmp               r0, r1
        bne               1f
        stlex             r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange::u32::acquire_seqcst:
        push              {r4, lr}
        mov               r3, r0
0:
        ldaex             r0, [r3]
        cmp               r0, r1
        bne               1f
        stlex             r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange::u32::relaxed_seqcst:
        push              {r4, lr}
        mov               r3, r0
0:
        ldaex             r0, [r3]
        cmp               r0, r1
        bne               1f
        stlex             r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange::u32::release_seqcst:
        push              {r4, lr}
        mov               r3, r0
0:
        ldaex             r0, [r3]
        cmp               r0, r1
        bne               1f
        stlex             r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange::u32::seqcst_acquire:
        push              {r4, lr}
        mov               r3, r0
0:
        ldaex             r0, [r3]
        cmp               r0, r1
        bne               1f
        stlex             r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange::u32::seqcst_relaxed:
        push              {r4, lr}
        mov               r3, r0
0:
        ldaex             r0, [r3]
        cmp               r0, r1
        bne               1f
        stlex             r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange::u32::acquire_acquire:
        push              {r4, lr}
        mov               r3, r0
0:
        ldaex             r0, [r3]
        cmp               r0, r1
        bne               1f
        strex             r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange::u32::acquire_relaxed:
        push              {r4, lr}
        mov               r3, r0
0:
        ldaex             r0, [r3]
        cmp               r0, r1
        bne               1f
        strex             r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange::u32::relaxed_acquire:
        push              {r4, lr}
        mov               r3, r0
0:
        ldaex             r0, [r3]
        cmp               r0, r1
        bne               1f
        strex             r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange::u32::relaxed_relaxed:
        push              {r4, lr}
        mov               r3, r0
0:
        ldrex             r0, [r3]
        cmp               r0, r1
        bne               1f
        strex             r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange::u32::release_acquire:
        push              {r4, lr}
        mov               r3, r0
0:
        ldaex             r0, [r3]
        cmp               r0, r1
        bne               1f
        stlex             r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange::u32::release_relaxed:
        push              {r4, lr}
        mov               r3, r0
0:
        ldrex             r0, [r3]
        cmp               r0, r1
        bne               1f
        stlex             r4, r2, [r3]
        cmp               r4, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r4, pc}
1:
        movs              r1, #0x0
        pop               {r4, pc}

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        mov               r3, r0
        ldaexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        stlexb            r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        mov               r3, r0
        ldaexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        stlexb            r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        mov               r3, r0
        ldaexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        stlexb            r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        mov               r3, r0
        ldaexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        stlexb            r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        mov               r3, r0
        ldaexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        stlexb            r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        mov               r3, r0
        ldaexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        stlexb            r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u8::release_seqcst:
        mov               r3, r0
        ldaexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        stlexb            r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        mov               r3, r0
        ldaexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        stlexb            r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        mov               r3, r0
        ldaexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        stlexb            r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u8::acquire_acquire:
        mov               r3, r0
        ldaexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        strexb            r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        mov               r3, r0
        ldaexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        strexb            r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        mov               r3, r0
        ldaexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        strexb            r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        strexb            r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u8::release_acquire:
        mov               r3, r0
        ldaexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        stlexb            r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u8::release_relaxed:
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        stlexb            r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        mov               r3, r0
        ldaexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        stlexh            r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        mov               r3, r0
        ldaexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        stlexh            r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        mov               r3, r0
        ldaexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        stlexh            r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        mov               r3, r0
        ldaexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        stlexh            r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        mov               r3, r0
        ldaexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        stlexh            r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        mov               r3, r0
        ldaexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        stlexh            r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u16::release_seqcst:
        mov               r3, r0
        ldaexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        stlexh            r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        mov               r3, r0
        ldaexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        stlexh            r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        mov               r3, r0
        ldaexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        stlexh            r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u16::acquire_acquire:
        mov               r3, r0
        ldaexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        strexh            r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        mov               r3, r0
        ldaexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        strexh            r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        mov               r3, r0
        ldaexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        strexh            r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        strexh            r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u16::release_acquire:
        mov               r3, r0
        ldaexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        stlexh            r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u16::release_relaxed:
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        stlexh            r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        mov               r3, r0
        ldaex             r0, [r0]
        cmp               r0, r1
        bne               0f
        stlex             r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        mov               r3, r0
        ldaex             r0, [r0]
        cmp               r0, r1
        bne               0f
        stlex             r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        mov               r3, r0
        ldaex             r0, [r0]
        cmp               r0, r1
        bne               0f
        stlex             r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        mov               r3, r0
        ldaex             r0, [r0]
        cmp               r0, r1
        bne               0f
        stlex             r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        mov               r3, r0
        ldaex             r0, [r0]
        cmp               r0, r1
        bne               0f
        stlex             r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        mov               r3, r0
        ldaex             r0, [r0]
        cmp               r0, r1
        bne               0f
        stlex             r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u32::release_seqcst:
        mov               r3, r0
        ldaex             r0, [r0]
        cmp               r0, r1
        bne               0f
        stlex             r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        mov               r3, r0
        ldaex             r0, [r0]
        cmp               r0, r1
        bne               0f
        stlex             r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        mov               r3, r0
        ldaex             r0, [r0]
        cmp               r0, r1
        bne               0f
        stlex             r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u32::acquire_acquire:
        mov               r3, r0
        ldaex             r0, [r0]
        cmp               r0, r1
        bne               0f
        strex             r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        mov               r3, r0
        ldaex             r0, [r0]
        cmp               r0, r1
        bne               0f
        strex             r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        mov               r3, r0
        ldaex             r0, [r0]
        cmp               r0, r1
        bne               0f
        strex             r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        strex             r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u32::release_acquire:
        mov               r3, r0
        ldaex             r0, [r0]
        cmp               r0, r1
        bne               0f
        stlex             r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

asm_test::compare_exchange_weak::u32::release_relaxed:
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        stlex             r1, r2, [r3]
        cbnz              r1, 0f
        movs              r1, #0x1
        bx                lr
0:
        movs              r1, #0x0
        bx                lr

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

asm_test::swap::u8::acqrel:
0:
        ldaexb            r2, [r0]
        stlexb            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u8::seqcst:
0:
        ldaexb            r2, [r0]
        stlexb            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u8::acquire:
0:
        ldaexb            r2, [r0]
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
        stlexb            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u16::acqrel:
0:
        ldaexh            r2, [r0]
        stlexh            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u16::seqcst:
0:
        ldaexh            r2, [r0]
        stlexh            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u16::acquire:
0:
        ldaexh            r2, [r0]
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
        stlexh            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u32::acqrel:
0:
        ldaex             r2, [r0]
        stlex             r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u32::seqcst:
0:
        ldaex             r2, [r0]
        stlex             r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        bx                lr

asm_test::swap::u32::acquire:
0:
        ldaex             r2, [r0]
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
        stlex             r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        bx                lr

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
