asm_test::compare_exchange::u8::acqrel_seqcst:
        push              {r4, lr}
        uxtb              r1, r1
0:
        ldaexb            r4, [r0]
        cmp               r4, r1
        bne               1f
        stlexb            r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange::u8::seqcst_seqcst:
        push              {r4, lr}
        uxtb              r1, r1
0:
        ldaexb            r4, [r0]
        cmp               r4, r1
        bne               1f
        stlexb            r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange::u8::acqrel_acquire:
        push              {r4, lr}
        uxtb              r1, r1
0:
        ldaexb            r4, [r0]
        cmp               r4, r1
        bne               1f
        stlexb            r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange::u8::acqrel_relaxed:
        push              {r4, lr}
        uxtb              r1, r1
0:
        ldaexb            r4, [r0]
        cmp               r4, r1
        bne               1f
        stlexb            r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange::u8::acquire_seqcst:
        push              {r4, lr}
        uxtb              r1, r1
0:
        ldaexb            r4, [r0]
        cmp               r4, r1
        bne               1f
        stlexb            r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange::u8::relaxed_seqcst:
        push              {r4, lr}
        uxtb              r1, r1
0:
        ldaexb            r4, [r0]
        cmp               r4, r1
        bne               1f
        stlexb            r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange::u8::release_seqcst:
        push              {r4, lr}
        uxtb              r1, r1
0:
        ldaexb            r4, [r0]
        cmp               r4, r1
        bne               1f
        stlexb            r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange::u8::seqcst_acquire:
        push              {r4, lr}
        uxtb              r1, r1
0:
        ldaexb            r4, [r0]
        cmp               r4, r1
        bne               1f
        stlexb            r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange::u8::seqcst_relaxed:
        push              {r4, lr}
        uxtb              r1, r1
0:
        ldaexb            r4, [r0]
        cmp               r4, r1
        bne               1f
        stlexb            r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange::u8::acquire_acquire:
        push              {r4, lr}
        uxtb              r1, r1
0:
        ldaexb            r4, [r0]
        cmp               r4, r1
        bne               1f
        strexb            r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange::u8::acquire_relaxed:
        push              {r4, lr}
        uxtb              r1, r1
0:
        ldaexb            r4, [r0]
        cmp               r4, r1
        bne               1f
        strexb            r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange::u8::relaxed_acquire:
        push              {r4, lr}
        uxtb              r1, r1
0:
        ldaexb            r4, [r0]
        cmp               r4, r1
        bne               1f
        strexb            r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange::u8::relaxed_relaxed:
        push              {r4, lr}
        uxtb              r1, r1
0:
        ldrexb            r4, [r0]
        cmp               r4, r1
        bne               1f
        strexb            r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange::u8::release_acquire:
        push              {r4, lr}
        uxtb              r1, r1
0:
        ldaexb            r4, [r0]
        cmp               r4, r1
        bne               1f
        stlexb            r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange::u8::release_relaxed:
        push              {r4, lr}
        uxtb              r1, r1
0:
        ldrexb            r4, [r0]
        cmp               r4, r1
        bne               1f
        stlexb            r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange::u16::acqrel_seqcst:
        push              {r4, lr}
        uxth              r1, r1
0:
        ldaexh            r4, [r0]
        cmp               r4, r1
        bne               1f
        stlexh            r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange::u16::seqcst_seqcst:
        push              {r4, lr}
        uxth              r1, r1
0:
        ldaexh            r4, [r0]
        cmp               r4, r1
        bne               1f
        stlexh            r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange::u16::acqrel_acquire:
        push              {r4, lr}
        uxth              r1, r1
0:
        ldaexh            r4, [r0]
        cmp               r4, r1
        bne               1f
        stlexh            r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange::u16::acqrel_relaxed:
        push              {r4, lr}
        uxth              r1, r1
0:
        ldaexh            r4, [r0]
        cmp               r4, r1
        bne               1f
        stlexh            r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange::u16::acquire_seqcst:
        push              {r4, lr}
        uxth              r1, r1
0:
        ldaexh            r4, [r0]
        cmp               r4, r1
        bne               1f
        stlexh            r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange::u16::relaxed_seqcst:
        push              {r4, lr}
        uxth              r1, r1
0:
        ldaexh            r4, [r0]
        cmp               r4, r1
        bne               1f
        stlexh            r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange::u16::release_seqcst:
        push              {r4, lr}
        uxth              r1, r1
0:
        ldaexh            r4, [r0]
        cmp               r4, r1
        bne               1f
        stlexh            r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange::u16::seqcst_acquire:
        push              {r4, lr}
        uxth              r1, r1
0:
        ldaexh            r4, [r0]
        cmp               r4, r1
        bne               1f
        stlexh            r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange::u16::seqcst_relaxed:
        push              {r4, lr}
        uxth              r1, r1
0:
        ldaexh            r4, [r0]
        cmp               r4, r1
        bne               1f
        stlexh            r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange::u16::acquire_acquire:
        push              {r4, lr}
        uxth              r1, r1
0:
        ldaexh            r4, [r0]
        cmp               r4, r1
        bne               1f
        strexh            r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange::u16::acquire_relaxed:
        push              {r4, lr}
        uxth              r1, r1
0:
        ldaexh            r4, [r0]
        cmp               r4, r1
        bne               1f
        strexh            r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange::u16::relaxed_acquire:
        push              {r4, lr}
        uxth              r1, r1
0:
        ldaexh            r4, [r0]
        cmp               r4, r1
        bne               1f
        strexh            r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange::u16::relaxed_relaxed:
        push              {r4, lr}
        uxth              r1, r1
0:
        ldrexh            r4, [r0]
        cmp               r4, r1
        bne               1f
        strexh            r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange::u16::release_acquire:
        push              {r4, lr}
        uxth              r1, r1
0:
        ldaexh            r4, [r0]
        cmp               r4, r1
        bne               1f
        stlexh            r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange::u16::release_relaxed:
        push              {r4, lr}
        uxth              r1, r1
0:
        ldrexh            r4, [r0]
        cmp               r4, r1
        bne               1f
        stlexh            r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange::u32::acqrel_seqcst:
        push              {r4, lr}
0:
        ldaex             r4, [r0]
        cmp               r4, r1
        bne               1f
        stlex             r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange::u32::seqcst_seqcst:
        push              {r4, lr}
0:
        ldaex             r4, [r0]
        cmp               r4, r1
        bne               1f
        stlex             r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange::u32::acqrel_acquire:
        push              {r4, lr}
0:
        ldaex             r4, [r0]
        cmp               r4, r1
        bne               1f
        stlex             r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange::u32::acqrel_relaxed:
        push              {r4, lr}
0:
        ldaex             r4, [r0]
        cmp               r4, r1
        bne               1f
        stlex             r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange::u32::acquire_seqcst:
        push              {r4, lr}
0:
        ldaex             r4, [r0]
        cmp               r4, r1
        bne               1f
        stlex             r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange::u32::relaxed_seqcst:
        push              {r4, lr}
0:
        ldaex             r4, [r0]
        cmp               r4, r1
        bne               1f
        stlex             r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange::u32::release_seqcst:
        push              {r4, lr}
0:
        ldaex             r4, [r0]
        cmp               r4, r1
        bne               1f
        stlex             r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange::u32::seqcst_acquire:
        push              {r4, lr}
0:
        ldaex             r4, [r0]
        cmp               r4, r1
        bne               1f
        stlex             r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange::u32::seqcst_relaxed:
        push              {r4, lr}
0:
        ldaex             r4, [r0]
        cmp               r4, r1
        bne               1f
        stlex             r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange::u32::acquire_acquire:
        push              {r4, lr}
0:
        ldaex             r4, [r0]
        cmp               r4, r1
        bne               1f
        strex             r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange::u32::acquire_relaxed:
        push              {r4, lr}
0:
        ldaex             r4, [r0]
        cmp               r4, r1
        bne               1f
        strex             r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange::u32::relaxed_acquire:
        push              {r4, lr}
0:
        ldaex             r4, [r0]
        cmp               r4, r1
        bne               1f
        strex             r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange::u32::relaxed_relaxed:
        push              {r4, lr}
0:
        ldrex             r4, [r0]
        cmp               r4, r1
        bne               1f
        strex             r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange::u32::release_acquire:
        push              {r4, lr}
0:
        ldaex             r4, [r0]
        cmp               r4, r1
        bne               1f
        stlex             r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange::u32::release_relaxed:
        push              {r4, lr}
0:
        ldrex             r4, [r0]
        cmp               r4, r1
        bne               1f
        stlex             r3, r2, [r0]
        cbz               r3, 2f
        b                 0b
1:
        clrex
        movs              r3, #0x1
2:
        rsbs              r1, r3, #0
        adcs              r1, r3
        mov               r0, r4
        pop               {r4, pc}

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        push              {r4, lr}
        uxtb              r1, r1
        ldaexb            r3, [r0]
        cmp               r3, r1
        bne               0f
        stlexb            r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        push              {r4, lr}
        uxtb              r1, r1
        ldaexb            r3, [r0]
        cmp               r3, r1
        bne               0f
        stlexb            r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        push              {r4, lr}
        uxtb              r1, r1
        ldaexb            r3, [r0]
        cmp               r3, r1
        bne               0f
        stlexb            r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        push              {r4, lr}
        uxtb              r1, r1
        ldaexb            r3, [r0]
        cmp               r3, r1
        bne               0f
        stlexb            r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        push              {r4, lr}
        uxtb              r1, r1
        ldaexb            r3, [r0]
        cmp               r3, r1
        bne               0f
        stlexb            r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        push              {r4, lr}
        uxtb              r1, r1
        ldaexb            r3, [r0]
        cmp               r3, r1
        bne               0f
        stlexb            r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u8::release_seqcst:
        push              {r4, lr}
        uxtb              r1, r1
        ldaexb            r3, [r0]
        cmp               r3, r1
        bne               0f
        stlexb            r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        push              {r4, lr}
        uxtb              r1, r1
        ldaexb            r3, [r0]
        cmp               r3, r1
        bne               0f
        stlexb            r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        push              {r4, lr}
        uxtb              r1, r1
        ldaexb            r3, [r0]
        cmp               r3, r1
        bne               0f
        stlexb            r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u8::acquire_acquire:
        push              {r4, lr}
        uxtb              r1, r1
        ldaexb            r3, [r0]
        cmp               r3, r1
        bne               0f
        strexb            r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        push              {r4, lr}
        uxtb              r1, r1
        ldaexb            r3, [r0]
        cmp               r3, r1
        bne               0f
        strexb            r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        push              {r4, lr}
        uxtb              r1, r1
        ldaexb            r3, [r0]
        cmp               r3, r1
        bne               0f
        strexb            r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        push              {r4, lr}
        uxtb              r1, r1
        ldrexb            r3, [r0]
        cmp               r3, r1
        bne               0f
        strexb            r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u8::release_acquire:
        push              {r4, lr}
        uxtb              r1, r1
        ldaexb            r3, [r0]
        cmp               r3, r1
        bne               0f
        stlexb            r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u8::release_relaxed:
        push              {r4, lr}
        uxtb              r1, r1
        ldrexb            r3, [r0]
        cmp               r3, r1
        bne               0f
        stlexb            r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        push              {r4, lr}
        uxth              r1, r1
        ldaexh            r3, [r0]
        cmp               r3, r1
        bne               0f
        stlexh            r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        push              {r4, lr}
        uxth              r1, r1
        ldaexh            r3, [r0]
        cmp               r3, r1
        bne               0f
        stlexh            r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        push              {r4, lr}
        uxth              r1, r1
        ldaexh            r3, [r0]
        cmp               r3, r1
        bne               0f
        stlexh            r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        push              {r4, lr}
        uxth              r1, r1
        ldaexh            r3, [r0]
        cmp               r3, r1
        bne               0f
        stlexh            r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        push              {r4, lr}
        uxth              r1, r1
        ldaexh            r3, [r0]
        cmp               r3, r1
        bne               0f
        stlexh            r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        push              {r4, lr}
        uxth              r1, r1
        ldaexh            r3, [r0]
        cmp               r3, r1
        bne               0f
        stlexh            r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u16::release_seqcst:
        push              {r4, lr}
        uxth              r1, r1
        ldaexh            r3, [r0]
        cmp               r3, r1
        bne               0f
        stlexh            r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        push              {r4, lr}
        uxth              r1, r1
        ldaexh            r3, [r0]
        cmp               r3, r1
        bne               0f
        stlexh            r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        push              {r4, lr}
        uxth              r1, r1
        ldaexh            r3, [r0]
        cmp               r3, r1
        bne               0f
        stlexh            r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u16::acquire_acquire:
        push              {r4, lr}
        uxth              r1, r1
        ldaexh            r3, [r0]
        cmp               r3, r1
        bne               0f
        strexh            r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        push              {r4, lr}
        uxth              r1, r1
        ldaexh            r3, [r0]
        cmp               r3, r1
        bne               0f
        strexh            r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        push              {r4, lr}
        uxth              r1, r1
        ldaexh            r3, [r0]
        cmp               r3, r1
        bne               0f
        strexh            r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        push              {r4, lr}
        uxth              r1, r1
        ldrexh            r3, [r0]
        cmp               r3, r1
        bne               0f
        strexh            r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u16::release_acquire:
        push              {r4, lr}
        uxth              r1, r1
        ldaexh            r3, [r0]
        cmp               r3, r1
        bne               0f
        stlexh            r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u16::release_relaxed:
        push              {r4, lr}
        uxth              r1, r1
        ldrexh            r3, [r0]
        cmp               r3, r1
        bne               0f
        stlexh            r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        push              {r4, lr}
        ldaex             r3, [r0]
        cmp               r3, r1
        bne               0f
        stlex             r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        push              {r4, lr}
        ldaex             r3, [r0]
        cmp               r3, r1
        bne               0f
        stlex             r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        push              {r4, lr}
        ldaex             r3, [r0]
        cmp               r3, r1
        bne               0f
        stlex             r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        push              {r4, lr}
        ldaex             r3, [r0]
        cmp               r3, r1
        bne               0f
        stlex             r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        push              {r4, lr}
        ldaex             r3, [r0]
        cmp               r3, r1
        bne               0f
        stlex             r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        push              {r4, lr}
        ldaex             r3, [r0]
        cmp               r3, r1
        bne               0f
        stlex             r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u32::release_seqcst:
        push              {r4, lr}
        ldaex             r3, [r0]
        cmp               r3, r1
        bne               0f
        stlex             r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        push              {r4, lr}
        ldaex             r3, [r0]
        cmp               r3, r1
        bne               0f
        stlex             r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        push              {r4, lr}
        ldaex             r3, [r0]
        cmp               r3, r1
        bne               0f
        stlex             r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u32::acquire_acquire:
        push              {r4, lr}
        ldaex             r3, [r0]
        cmp               r3, r1
        bne               0f
        strex             r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        push              {r4, lr}
        ldaex             r3, [r0]
        cmp               r3, r1
        bne               0f
        strex             r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        push              {r4, lr}
        ldaex             r3, [r0]
        cmp               r3, r1
        bne               0f
        strex             r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        push              {r4, lr}
        ldrex             r3, [r0]
        cmp               r3, r1
        bne               0f
        strex             r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u32::release_acquire:
        push              {r4, lr}
        ldaex             r3, [r0]
        cmp               r3, r1
        bne               0f
        stlex             r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

asm_test::compare_exchange_weak::u32::release_relaxed:
        push              {r4, lr}
        ldrex             r3, [r0]
        cmp               r3, r1
        bne               0f
        stlex             r4, r2, [r0]
        b                 1f
0:
        clrex
        movs              r4, #0x1
1:
        rsbs              r1, r4, #0
        adcs              r1, r4
        mov               r0, r3
        pop               {r4, pc}

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
