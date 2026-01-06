asm_test::compare_exchange::u8::acqrel_seqcst:
        push              {r7, lr}
        mov               r7, sp
        uxtb              r1, r1
0:
        ldaexb            r12, [r0]
        cmp               r12, r1
        bne               1f
        stlexb            r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange::u8::seqcst_seqcst:
        push              {r7, lr}
        mov               r7, sp
        uxtb              r1, r1
0:
        ldaexb            r12, [r0]
        cmp               r12, r1
        bne               1f
        stlexb            r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange::u8::acqrel_acquire:
        push              {r7, lr}
        mov               r7, sp
        uxtb              r1, r1
0:
        ldaexb            r12, [r0]
        cmp               r12, r1
        bne               1f
        stlexb            r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange::u8::acqrel_relaxed:
        push              {r7, lr}
        mov               r7, sp
        uxtb              r1, r1
0:
        ldaexb            r12, [r0]
        cmp               r12, r1
        bne               1f
        stlexb            r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange::u8::acquire_seqcst:
        push              {r7, lr}
        mov               r7, sp
        uxtb              r1, r1
0:
        ldaexb            r12, [r0]
        cmp               r12, r1
        bne               1f
        stlexb            r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange::u8::relaxed_seqcst:
        push              {r7, lr}
        mov               r7, sp
        uxtb              r1, r1
0:
        ldaexb            r12, [r0]
        cmp               r12, r1
        bne               1f
        stlexb            r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange::u8::release_seqcst:
        push              {r7, lr}
        mov               r7, sp
        uxtb              r1, r1
0:
        ldaexb            r12, [r0]
        cmp               r12, r1
        bne               1f
        stlexb            r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange::u8::seqcst_acquire:
        push              {r7, lr}
        mov               r7, sp
        uxtb              r1, r1
0:
        ldaexb            r12, [r0]
        cmp               r12, r1
        bne               1f
        stlexb            r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange::u8::seqcst_relaxed:
        push              {r7, lr}
        mov               r7, sp
        uxtb              r1, r1
0:
        ldaexb            r12, [r0]
        cmp               r12, r1
        bne               1f
        stlexb            r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange::u8::acquire_acquire:
        push              {r7, lr}
        mov               r7, sp
        uxtb              r1, r1
0:
        ldaexb            r12, [r0]
        cmp               r12, r1
        bne               1f
        strexb            r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange::u8::acquire_relaxed:
        push              {r7, lr}
        mov               r7, sp
        uxtb              r1, r1
0:
        ldaexb            r12, [r0]
        cmp               r12, r1
        bne               1f
        strexb            r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange::u8::relaxed_acquire:
        push              {r7, lr}
        mov               r7, sp
        uxtb              r1, r1
0:
        ldaexb            r12, [r0]
        cmp               r12, r1
        bne               1f
        strexb            r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange::u8::relaxed_relaxed:
        push              {r7, lr}
        mov               r7, sp
        uxtb              r1, r1
0:
        ldrexb            r12, [r0]
        cmp               r12, r1
        bne               1f
        strexb            r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange::u8::release_acquire:
        push              {r7, lr}
        mov               r7, sp
        uxtb              r1, r1
0:
        ldaexb            r12, [r0]
        cmp               r12, r1
        bne               1f
        stlexb            r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange::u8::release_relaxed:
        push              {r7, lr}
        mov               r7, sp
        uxtb              r1, r1
0:
        ldrexb            r12, [r0]
        cmp               r12, r1
        bne               1f
        stlexb            r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange::u16::acqrel_seqcst:
        push              {r7, lr}
        mov               r7, sp
        uxth              r1, r1
0:
        ldaexh            r12, [r0]
        cmp               r12, r1
        bne               1f
        stlexh            r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange::u16::seqcst_seqcst:
        push              {r7, lr}
        mov               r7, sp
        uxth              r1, r1
0:
        ldaexh            r12, [r0]
        cmp               r12, r1
        bne               1f
        stlexh            r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange::u16::acqrel_acquire:
        push              {r7, lr}
        mov               r7, sp
        uxth              r1, r1
0:
        ldaexh            r12, [r0]
        cmp               r12, r1
        bne               1f
        stlexh            r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange::u16::acqrel_relaxed:
        push              {r7, lr}
        mov               r7, sp
        uxth              r1, r1
0:
        ldaexh            r12, [r0]
        cmp               r12, r1
        bne               1f
        stlexh            r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange::u16::acquire_seqcst:
        push              {r7, lr}
        mov               r7, sp
        uxth              r1, r1
0:
        ldaexh            r12, [r0]
        cmp               r12, r1
        bne               1f
        stlexh            r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange::u16::relaxed_seqcst:
        push              {r7, lr}
        mov               r7, sp
        uxth              r1, r1
0:
        ldaexh            r12, [r0]
        cmp               r12, r1
        bne               1f
        stlexh            r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange::u16::release_seqcst:
        push              {r7, lr}
        mov               r7, sp
        uxth              r1, r1
0:
        ldaexh            r12, [r0]
        cmp               r12, r1
        bne               1f
        stlexh            r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange::u16::seqcst_acquire:
        push              {r7, lr}
        mov               r7, sp
        uxth              r1, r1
0:
        ldaexh            r12, [r0]
        cmp               r12, r1
        bne               1f
        stlexh            r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange::u16::seqcst_relaxed:
        push              {r7, lr}
        mov               r7, sp
        uxth              r1, r1
0:
        ldaexh            r12, [r0]
        cmp               r12, r1
        bne               1f
        stlexh            r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange::u16::acquire_acquire:
        push              {r7, lr}
        mov               r7, sp
        uxth              r1, r1
0:
        ldaexh            r12, [r0]
        cmp               r12, r1
        bne               1f
        strexh            r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange::u16::acquire_relaxed:
        push              {r7, lr}
        mov               r7, sp
        uxth              r1, r1
0:
        ldaexh            r12, [r0]
        cmp               r12, r1
        bne               1f
        strexh            r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange::u16::relaxed_acquire:
        push              {r7, lr}
        mov               r7, sp
        uxth              r1, r1
0:
        ldaexh            r12, [r0]
        cmp               r12, r1
        bne               1f
        strexh            r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange::u16::relaxed_relaxed:
        push              {r7, lr}
        mov               r7, sp
        uxth              r1, r1
0:
        ldrexh            r12, [r0]
        cmp               r12, r1
        bne               1f
        strexh            r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange::u16::release_acquire:
        push              {r7, lr}
        mov               r7, sp
        uxth              r1, r1
0:
        ldaexh            r12, [r0]
        cmp               r12, r1
        bne               1f
        stlexh            r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange::u16::release_relaxed:
        push              {r7, lr}
        mov               r7, sp
        uxth              r1, r1
0:
        ldrexh            r12, [r0]
        cmp               r12, r1
        bne               1f
        stlexh            r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange::u32::acqrel_seqcst:
        push              {r7, lr}
        mov               r7, sp
0:
        ldaex             r12, [r0]
        cmp               r12, r1
        bne               1f
        stlex             r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange::u32::seqcst_seqcst:
        push              {r7, lr}
        mov               r7, sp
0:
        ldaex             r12, [r0]
        cmp               r12, r1
        bne               1f
        stlex             r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange::u32::acqrel_acquire:
        push              {r7, lr}
        mov               r7, sp
0:
        ldaex             r12, [r0]
        cmp               r12, r1
        bne               1f
        stlex             r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange::u32::acqrel_relaxed:
        push              {r7, lr}
        mov               r7, sp
0:
        ldaex             r12, [r0]
        cmp               r12, r1
        bne               1f
        stlex             r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange::u32::acquire_seqcst:
        push              {r7, lr}
        mov               r7, sp
0:
        ldaex             r12, [r0]
        cmp               r12, r1
        bne               1f
        stlex             r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange::u32::relaxed_seqcst:
        push              {r7, lr}
        mov               r7, sp
0:
        ldaex             r12, [r0]
        cmp               r12, r1
        bne               1f
        stlex             r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange::u32::release_seqcst:
        push              {r7, lr}
        mov               r7, sp
0:
        ldaex             r12, [r0]
        cmp               r12, r1
        bne               1f
        stlex             r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange::u32::seqcst_acquire:
        push              {r7, lr}
        mov               r7, sp
0:
        ldaex             r12, [r0]
        cmp               r12, r1
        bne               1f
        stlex             r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange::u32::seqcst_relaxed:
        push              {r7, lr}
        mov               r7, sp
0:
        ldaex             r12, [r0]
        cmp               r12, r1
        bne               1f
        stlex             r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange::u32::acquire_acquire:
        push              {r7, lr}
        mov               r7, sp
0:
        ldaex             r12, [r0]
        cmp               r12, r1
        bne               1f
        strex             r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange::u32::acquire_relaxed:
        push              {r7, lr}
        mov               r7, sp
0:
        ldaex             r12, [r0]
        cmp               r12, r1
        bne               1f
        strex             r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange::u32::relaxed_acquire:
        push              {r7, lr}
        mov               r7, sp
0:
        ldaex             r12, [r0]
        cmp               r12, r1
        bne               1f
        strex             r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange::u32::relaxed_relaxed:
        push              {r7, lr}
        mov               r7, sp
0:
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        strex             r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange::u32::release_acquire:
        push              {r7, lr}
        mov               r7, sp
0:
        ldaex             r12, [r0]
        cmp               r12, r1
        bne               1f
        stlex             r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange::u32::release_relaxed:
        push              {r7, lr}
        mov               r7, sp
0:
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        stlex             r3, r2, [r0]
        cmp               r3, #0x0
        bne               0b
        b                 2f
1:
        clrex
        mov.w             r3, #0x1
2:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        push              {r7, lr}
        mov               r7, sp
        uxtb              r1, r1
        ldaexb            r12, [r0]
        cmp               r12, r1
        bne               0f
        stlexb            r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        push              {r7, lr}
        mov               r7, sp
        uxtb              r1, r1
        ldaexb            r12, [r0]
        cmp               r12, r1
        bne               0f
        stlexb            r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        push              {r7, lr}
        mov               r7, sp
        uxtb              r1, r1
        ldaexb            r12, [r0]
        cmp               r12, r1
        bne               0f
        stlexb            r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        push              {r7, lr}
        mov               r7, sp
        uxtb              r1, r1
        ldaexb            r12, [r0]
        cmp               r12, r1
        bne               0f
        stlexb            r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        push              {r7, lr}
        mov               r7, sp
        uxtb              r1, r1
        ldaexb            r12, [r0]
        cmp               r12, r1
        bne               0f
        stlexb            r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        push              {r7, lr}
        mov               r7, sp
        uxtb              r1, r1
        ldaexb            r12, [r0]
        cmp               r12, r1
        bne               0f
        stlexb            r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange_weak::u8::release_seqcst:
        push              {r7, lr}
        mov               r7, sp
        uxtb              r1, r1
        ldaexb            r12, [r0]
        cmp               r12, r1
        bne               0f
        stlexb            r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        push              {r7, lr}
        mov               r7, sp
        uxtb              r1, r1
        ldaexb            r12, [r0]
        cmp               r12, r1
        bne               0f
        stlexb            r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        push              {r7, lr}
        mov               r7, sp
        uxtb              r1, r1
        ldaexb            r12, [r0]
        cmp               r12, r1
        bne               0f
        stlexb            r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange_weak::u8::acquire_acquire:
        push              {r7, lr}
        mov               r7, sp
        uxtb              r1, r1
        ldaexb            r12, [r0]
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
        pop               {r7, pc}

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        push              {r7, lr}
        mov               r7, sp
        uxtb              r1, r1
        ldaexb            r12, [r0]
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
        pop               {r7, pc}

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        push              {r7, lr}
        mov               r7, sp
        uxtb              r1, r1
        ldaexb            r12, [r0]
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
        pop               {r7, pc}

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        push              {r7, lr}
        mov               r7, sp
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
        pop               {r7, pc}

asm_test::compare_exchange_weak::u8::release_acquire:
        push              {r7, lr}
        mov               r7, sp
        uxtb              r1, r1
        ldaexb            r12, [r0]
        cmp               r12, r1
        bne               0f
        stlexb            r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange_weak::u8::release_relaxed:
        push              {r7, lr}
        mov               r7, sp
        uxtb              r1, r1
        ldrexb            r12, [r0]
        cmp               r12, r1
        bne               0f
        stlexb            r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        push              {r7, lr}
        mov               r7, sp
        uxth              r1, r1
        ldaexh            r12, [r0]
        cmp               r12, r1
        bne               0f
        stlexh            r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        push              {r7, lr}
        mov               r7, sp
        uxth              r1, r1
        ldaexh            r12, [r0]
        cmp               r12, r1
        bne               0f
        stlexh            r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        push              {r7, lr}
        mov               r7, sp
        uxth              r1, r1
        ldaexh            r12, [r0]
        cmp               r12, r1
        bne               0f
        stlexh            r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        push              {r7, lr}
        mov               r7, sp
        uxth              r1, r1
        ldaexh            r12, [r0]
        cmp               r12, r1
        bne               0f
        stlexh            r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        push              {r7, lr}
        mov               r7, sp
        uxth              r1, r1
        ldaexh            r12, [r0]
        cmp               r12, r1
        bne               0f
        stlexh            r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        push              {r7, lr}
        mov               r7, sp
        uxth              r1, r1
        ldaexh            r12, [r0]
        cmp               r12, r1
        bne               0f
        stlexh            r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::release_seqcst:
        push              {r7, lr}
        mov               r7, sp
        uxth              r1, r1
        ldaexh            r12, [r0]
        cmp               r12, r1
        bne               0f
        stlexh            r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        push              {r7, lr}
        mov               r7, sp
        uxth              r1, r1
        ldaexh            r12, [r0]
        cmp               r12, r1
        bne               0f
        stlexh            r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        push              {r7, lr}
        mov               r7, sp
        uxth              r1, r1
        ldaexh            r12, [r0]
        cmp               r12, r1
        bne               0f
        stlexh            r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::acquire_acquire:
        push              {r7, lr}
        mov               r7, sp
        uxth              r1, r1
        ldaexh            r12, [r0]
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
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        push              {r7, lr}
        mov               r7, sp
        uxth              r1, r1
        ldaexh            r12, [r0]
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
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        push              {r7, lr}
        mov               r7, sp
        uxth              r1, r1
        ldaexh            r12, [r0]
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
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        push              {r7, lr}
        mov               r7, sp
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
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::release_acquire:
        push              {r7, lr}
        mov               r7, sp
        uxth              r1, r1
        ldaexh            r12, [r0]
        cmp               r12, r1
        bne               0f
        stlexh            r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::release_relaxed:
        push              {r7, lr}
        mov               r7, sp
        uxth              r1, r1
        ldrexh            r12, [r0]
        cmp               r12, r1
        bne               0f
        stlexh            r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        push              {r7, lr}
        mov               r7, sp
        ldaex             r12, [r0]
        cmp               r12, r1
        bne               0f
        stlex             r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        push              {r7, lr}
        mov               r7, sp
        ldaex             r12, [r0]
        cmp               r12, r1
        bne               0f
        stlex             r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        push              {r7, lr}
        mov               r7, sp
        ldaex             r12, [r0]
        cmp               r12, r1
        bne               0f
        stlex             r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        push              {r7, lr}
        mov               r7, sp
        ldaex             r12, [r0]
        cmp               r12, r1
        bne               0f
        stlex             r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        push              {r7, lr}
        mov               r7, sp
        ldaex             r12, [r0]
        cmp               r12, r1
        bne               0f
        stlex             r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        push              {r7, lr}
        mov               r7, sp
        ldaex             r12, [r0]
        cmp               r12, r1
        bne               0f
        stlex             r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::release_seqcst:
        push              {r7, lr}
        mov               r7, sp
        ldaex             r12, [r0]
        cmp               r12, r1
        bne               0f
        stlex             r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        push              {r7, lr}
        mov               r7, sp
        ldaex             r12, [r0]
        cmp               r12, r1
        bne               0f
        stlex             r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        push              {r7, lr}
        mov               r7, sp
        ldaex             r12, [r0]
        cmp               r12, r1
        bne               0f
        stlex             r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::acquire_acquire:
        push              {r7, lr}
        mov               r7, sp
        ldaex             r12, [r0]
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
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        push              {r7, lr}
        mov               r7, sp
        ldaex             r12, [r0]
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
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        push              {r7, lr}
        mov               r7, sp
        ldaex             r12, [r0]
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
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        push              {r7, lr}
        mov               r7, sp
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
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::release_acquire:
        push              {r7, lr}
        mov               r7, sp
        ldaex             r12, [r0]
        cmp               r12, r1
        bne               0f
        stlex             r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::release_relaxed:
        push              {r7, lr}
        mov               r7, sp
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        stlex             r3, r2, [r0]
        b                 1f
0:
        clrex
        mov.w             r3, #0x1
1:
        clz               r0, r3
        lsrs              r1, r0, #0x5
        mov               r0, r12
        pop               {r7, pc}

asm_test::load::u8::seqcst:
        push              {r7, lr}
        mov               r7, sp
        ldab              r0, [r0]
        pop               {r7, pc}

asm_test::load::u8::acquire:
        push              {r7, lr}
        mov               r7, sp
        ldab              r0, [r0]
        pop               {r7, pc}

asm_test::load::u8::relaxed:
        push              {r7, lr}
        mov               r7, sp
        ldrb              r0, [r0]
        pop               {r7, pc}

asm_test::load::u16::seqcst:
        push              {r7, lr}
        mov               r7, sp
        ldah              r0, [r0]
        pop               {r7, pc}

asm_test::load::u16::acquire:
        push              {r7, lr}
        mov               r7, sp
        ldah              r0, [r0]
        pop               {r7, pc}

asm_test::load::u16::relaxed:
        push              {r7, lr}
        mov               r7, sp
        ldrh              r0, [r0]
        pop               {r7, pc}

asm_test::load::u32::seqcst:
        push              {r7, lr}
        mov               r7, sp
        lda               r0, [r0]
        pop               {r7, pc}

asm_test::load::u32::acquire:
        push              {r7, lr}
        mov               r7, sp
        lda               r0, [r0]
        pop               {r7, pc}

asm_test::load::u32::relaxed:
        push              {r7, lr}
        mov               r7, sp
        ldr               r0, [r0]
        pop               {r7, pc}

asm_test::swap::u8::acqrel:
        push              {r7, lr}
        mov               r7, sp
0:
        ldaexb            r2, [r0]
        stlexb            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        pop               {r7, pc}

asm_test::swap::u8::seqcst:
        push              {r7, lr}
        mov               r7, sp
0:
        ldaexb            r2, [r0]
        stlexb            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        pop               {r7, pc}

asm_test::swap::u8::acquire:
        push              {r7, lr}
        mov               r7, sp
0:
        ldaexb            r2, [r0]
        strexb            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        pop               {r7, pc}

asm_test::swap::u8::relaxed:
        push              {r7, lr}
        mov               r7, sp
0:
        ldrexb            r2, [r0]
        strexb            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        pop               {r7, pc}

asm_test::swap::u8::release:
        push              {r7, lr}
        mov               r7, sp
0:
        ldrexb            r2, [r0]
        stlexb            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        pop               {r7, pc}

asm_test::swap::u16::acqrel:
        push              {r7, lr}
        mov               r7, sp
0:
        ldaexh            r2, [r0]
        stlexh            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        pop               {r7, pc}

asm_test::swap::u16::seqcst:
        push              {r7, lr}
        mov               r7, sp
0:
        ldaexh            r2, [r0]
        stlexh            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        pop               {r7, pc}

asm_test::swap::u16::acquire:
        push              {r7, lr}
        mov               r7, sp
0:
        ldaexh            r2, [r0]
        strexh            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        pop               {r7, pc}

asm_test::swap::u16::relaxed:
        push              {r7, lr}
        mov               r7, sp
0:
        ldrexh            r2, [r0]
        strexh            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        pop               {r7, pc}

asm_test::swap::u16::release:
        push              {r7, lr}
        mov               r7, sp
0:
        ldrexh            r2, [r0]
        stlexh            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        pop               {r7, pc}

asm_test::swap::u32::acqrel:
        push              {r7, lr}
        mov               r7, sp
0:
        ldaex             r2, [r0]
        stlex             r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        pop               {r7, pc}

asm_test::swap::u32::seqcst:
        push              {r7, lr}
        mov               r7, sp
0:
        ldaex             r2, [r0]
        stlex             r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        pop               {r7, pc}

asm_test::swap::u32::acquire:
        push              {r7, lr}
        mov               r7, sp
0:
        ldaex             r2, [r0]
        strex             r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        pop               {r7, pc}

asm_test::swap::u32::relaxed:
        push              {r7, lr}
        mov               r7, sp
0:
        ldrex             r2, [r0]
        strex             r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        pop               {r7, pc}

asm_test::swap::u32::release:
        push              {r7, lr}
        mov               r7, sp
0:
        ldrex             r2, [r0]
        stlex             r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        pop               {r7, pc}

asm_test::store::u8::seqcst:
        push              {r7, lr}
        mov               r7, sp
        stlb              r1, [r0]
        pop               {r7, pc}

asm_test::store::u8::relaxed:
        push              {r7, lr}
        mov               r7, sp
        strb              r1, [r0]
        pop               {r7, pc}

asm_test::store::u8::release:
        push              {r7, lr}
        mov               r7, sp
        stlb              r1, [r0]
        pop               {r7, pc}

asm_test::store::u16::seqcst:
        push              {r7, lr}
        mov               r7, sp
        stlh              r1, [r0]
        pop               {r7, pc}

asm_test::store::u16::relaxed:
        push              {r7, lr}
        mov               r7, sp
        strh              r1, [r0]
        pop               {r7, pc}

asm_test::store::u16::release:
        push              {r7, lr}
        mov               r7, sp
        stlh              r1, [r0]
        pop               {r7, pc}

asm_test::store::u32::seqcst:
        push              {r7, lr}
        mov               r7, sp
        stl               r1, [r0]
        pop               {r7, pc}

asm_test::store::u32::relaxed:
        push              {r7, lr}
        mov               r7, sp
        str               r1, [r0]
        pop               {r7, pc}

asm_test::store::u32::release:
        push              {r7, lr}
        mov               r7, sp
        stl               r1, [r0]
        pop               {r7, pc}

