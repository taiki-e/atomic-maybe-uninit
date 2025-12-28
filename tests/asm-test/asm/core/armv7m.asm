asm_test::compare_exchange::u8::acqrel_seqcst:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               sy
0:
        strexb            r1, r2, [r3]
        cbz               r1, 2f
        ldrexb            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}
2:
        movs              r1, #0x1
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange::u8::seqcst_seqcst:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               sy
0:
        strexb            r1, r2, [r3]
        cbz               r1, 2f
        ldrexb            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}
2:
        movs              r1, #0x1
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange::u8::acqrel_acquire:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               sy
0:
        strexb            r1, r2, [r3]
        cbz               r1, 2f
        ldrexb            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}
2:
        movs              r1, #0x1
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange::u8::acqrel_relaxed:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               sy
0:
        strexb            r1, r2, [r3]
        cbz               r1, 2f
        ldrexb            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        movs              r1, #0x0
        clrex
        pop               {r7, pc}
2:
        movs              r1, #0x1
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange::u8::acquire_seqcst:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        uxtb.w            r12, r1
0:
        ldrexb            r0, [r3]
        cmp               r0, r12
        bne               1f
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        bne               0b
        movs              r1, #0x1
        dmb               sy
        pop               {r7, pc}
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange::u8::relaxed_seqcst:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        uxtb.w            r12, r1
0:
        ldrexb            r0, [r3]
        cmp               r0, r12
        bne               1f
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r7, pc}
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange::u8::release_seqcst:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               sy
0:
        strexb            r1, r2, [r3]
        cbz               r1, 2f
        ldrexb            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}
2:
        movs              r1, #0x1
        pop               {r7, pc}

asm_test::compare_exchange::u8::seqcst_acquire:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               sy
0:
        strexb            r1, r2, [r3]
        cbz               r1, 2f
        ldrexb            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}
2:
        movs              r1, #0x1
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange::u8::seqcst_relaxed:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               sy
0:
        strexb            r1, r2, [r3]
        cbz               r1, 2f
        ldrexb            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        movs              r1, #0x0
        clrex
        pop               {r7, pc}
2:
        movs              r1, #0x1
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange::u8::acquire_acquire:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        uxtb.w            r12, r1
0:
        ldrexb            r0, [r3]
        cmp               r0, r12
        bne               1f
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        bne               0b
        movs              r1, #0x1
        dmb               sy
        pop               {r7, pc}
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange::u8::acquire_relaxed:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        uxtb.w            r12, r1
0:
        ldrexb            r0, [r3]
        cmp               r0, r12
        bne               1f
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        bne               0b
        movs              r1, #0x1
        dmb               sy
        pop               {r7, pc}
1:
        movs              r1, #0x0
        clrex
        pop               {r7, pc}

asm_test::compare_exchange::u8::relaxed_acquire:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        uxtb.w            r12, r1
0:
        ldrexb            r0, [r3]
        cmp               r0, r12
        bne               1f
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r7, pc}
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange::u8::relaxed_relaxed:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        uxtb.w            r12, r1
0:
        ldrexb            r0, [r3]
        cmp               r0, r12
        bne               1f
        strexb            r1, r2, [r3]
        cmp               r1, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r7, pc}
1:
        movs              r1, #0x0
        clrex
        pop               {r7, pc}

asm_test::compare_exchange::u8::release_acquire:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               sy
0:
        strexb            r1, r2, [r3]
        cbz               r1, 2f
        ldrexb            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}
2:
        movs              r1, #0x1
        pop               {r7, pc}

asm_test::compare_exchange::u8::release_relaxed:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               sy
0:
        strexb            r1, r2, [r3]
        cbz               r1, 2f
        ldrexb            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        movs              r1, #0x0
        clrex
        pop               {r7, pc}
2:
        movs              r1, #0x1
        pop               {r7, pc}

asm_test::compare_exchange::u16::acqrel_seqcst:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               sy
0:
        strexh            r1, r2, [r3]
        cbz               r1, 2f
        ldrexh            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}
2:
        movs              r1, #0x1
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange::u16::seqcst_seqcst:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               sy
0:
        strexh            r1, r2, [r3]
        cbz               r1, 2f
        ldrexh            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}
2:
        movs              r1, #0x1
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange::u16::acqrel_acquire:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               sy
0:
        strexh            r1, r2, [r3]
        cbz               r1, 2f
        ldrexh            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}
2:
        movs              r1, #0x1
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange::u16::acqrel_relaxed:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               sy
0:
        strexh            r1, r2, [r3]
        cbz               r1, 2f
        ldrexh            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        movs              r1, #0x0
        clrex
        pop               {r7, pc}
2:
        movs              r1, #0x1
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange::u16::acquire_seqcst:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        uxth.w            r12, r1
0:
        ldrexh            r0, [r3]
        cmp               r0, r12
        bne               1f
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        bne               0b
        movs              r1, #0x1
        dmb               sy
        pop               {r7, pc}
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange::u16::relaxed_seqcst:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        uxth.w            r12, r1
0:
        ldrexh            r0, [r3]
        cmp               r0, r12
        bne               1f
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r7, pc}
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange::u16::release_seqcst:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               sy
0:
        strexh            r1, r2, [r3]
        cbz               r1, 2f
        ldrexh            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}
2:
        movs              r1, #0x1
        pop               {r7, pc}

asm_test::compare_exchange::u16::seqcst_acquire:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               sy
0:
        strexh            r1, r2, [r3]
        cbz               r1, 2f
        ldrexh            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}
2:
        movs              r1, #0x1
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange::u16::seqcst_relaxed:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               sy
0:
        strexh            r1, r2, [r3]
        cbz               r1, 2f
        ldrexh            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        movs              r1, #0x0
        clrex
        pop               {r7, pc}
2:
        movs              r1, #0x1
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange::u16::acquire_acquire:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        uxth.w            r12, r1
0:
        ldrexh            r0, [r3]
        cmp               r0, r12
        bne               1f
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        bne               0b
        movs              r1, #0x1
        dmb               sy
        pop               {r7, pc}
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange::u16::acquire_relaxed:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        uxth.w            r12, r1
0:
        ldrexh            r0, [r3]
        cmp               r0, r12
        bne               1f
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        bne               0b
        movs              r1, #0x1
        dmb               sy
        pop               {r7, pc}
1:
        movs              r1, #0x0
        clrex
        pop               {r7, pc}

asm_test::compare_exchange::u16::relaxed_acquire:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        uxth.w            r12, r1
0:
        ldrexh            r0, [r3]
        cmp               r0, r12
        bne               1f
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r7, pc}
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange::u16::relaxed_relaxed:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        uxth.w            r12, r1
0:
        ldrexh            r0, [r3]
        cmp               r0, r12
        bne               1f
        strexh            r1, r2, [r3]
        cmp               r1, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r7, pc}
1:
        movs              r1, #0x0
        clrex
        pop               {r7, pc}

asm_test::compare_exchange::u16::release_acquire:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               sy
0:
        strexh            r1, r2, [r3]
        cbz               r1, 2f
        ldrexh            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}
2:
        movs              r1, #0x1
        pop               {r7, pc}

asm_test::compare_exchange::u16::release_relaxed:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth.w            r12, r1
        cmp               r0, r12
        bne               1f
        dmb               sy
0:
        strexh            r1, r2, [r3]
        cbz               r1, 2f
        ldrexh            r0, [r3]
        cmp               r0, r12
        beq               0b
1:
        movs              r1, #0x0
        clrex
        pop               {r7, pc}
2:
        movs              r1, #0x1
        pop               {r7, pc}

asm_test::compare_exchange::u32::acqrel_seqcst:
        push              {r7, lr}
        mov               r7, sp
        mov               r12, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               1f
        dmb               sy
0:
        strex             r3, r2, [r12]
        cbz               r3, 2f
        ldrex             r0, [r12]
        cmp               r0, r1
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}
2:
        movs              r1, #0x1
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange::u32::seqcst_seqcst:
        push              {r7, lr}
        mov               r7, sp
        mov               r12, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               1f
        dmb               sy
0:
        strex             r3, r2, [r12]
        cbz               r3, 2f
        ldrex             r0, [r12]
        cmp               r0, r1
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}
2:
        movs              r1, #0x1
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange::u32::acqrel_acquire:
        push              {r7, lr}
        mov               r7, sp
        mov               r12, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               1f
        dmb               sy
0:
        strex             r3, r2, [r12]
        cbz               r3, 2f
        ldrex             r0, [r12]
        cmp               r0, r1
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}
2:
        movs              r1, #0x1
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange::u32::acqrel_relaxed:
        push              {r7, lr}
        mov               r7, sp
        mov               r12, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               1f
        dmb               sy
0:
        strex             r3, r2, [r12]
        cbz               r3, 2f
        ldrex             r0, [r12]
        cmp               r0, r1
        beq               0b
1:
        movs              r1, #0x0
        clrex
        pop               {r7, pc}
2:
        movs              r1, #0x1
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange::u32::acquire_seqcst:
        push              {r7, lr}
        mov               r7, sp
        mov               r12, r0
0:
        ldrex             r0, [r12]
        cmp               r0, r1
        bne               1f
        strex             r3, r2, [r12]
        cmp               r3, #0x0
        bne               0b
        movs              r1, #0x1
        dmb               sy
        pop               {r7, pc}
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange::u32::relaxed_seqcst:
        push              {r7, lr}
        mov               r7, sp
        mov               r12, r0
0:
        ldrex             r0, [r12]
        cmp               r0, r1
        bne               1f
        strex             r3, r2, [r12]
        cmp               r3, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r7, pc}
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange::u32::release_seqcst:
        push              {r7, lr}
        mov               r7, sp
        mov               r12, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               1f
        dmb               sy
0:
        strex             r3, r2, [r12]
        cbz               r3, 2f
        ldrex             r0, [r12]
        cmp               r0, r1
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}
2:
        movs              r1, #0x1
        pop               {r7, pc}

asm_test::compare_exchange::u32::seqcst_acquire:
        push              {r7, lr}
        mov               r7, sp
        mov               r12, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               1f
        dmb               sy
0:
        strex             r3, r2, [r12]
        cbz               r3, 2f
        ldrex             r0, [r12]
        cmp               r0, r1
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}
2:
        movs              r1, #0x1
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange::u32::seqcst_relaxed:
        push              {r7, lr}
        mov               r7, sp
        mov               r12, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               1f
        dmb               sy
0:
        strex             r3, r2, [r12]
        cbz               r3, 2f
        ldrex             r0, [r12]
        cmp               r0, r1
        beq               0b
1:
        movs              r1, #0x0
        clrex
        pop               {r7, pc}
2:
        movs              r1, #0x1
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange::u32::acquire_acquire:
        push              {r7, lr}
        mov               r7, sp
        mov               r12, r0
0:
        ldrex             r0, [r12]
        cmp               r0, r1
        bne               1f
        strex             r3, r2, [r12]
        cmp               r3, #0x0
        bne               0b
        movs              r1, #0x1
        dmb               sy
        pop               {r7, pc}
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange::u32::acquire_relaxed:
        push              {r7, lr}
        mov               r7, sp
        mov               r12, r0
0:
        ldrex             r0, [r12]
        cmp               r0, r1
        bne               1f
        strex             r3, r2, [r12]
        cmp               r3, #0x0
        bne               0b
        movs              r1, #0x1
        dmb               sy
        pop               {r7, pc}
1:
        movs              r1, #0x0
        clrex
        pop               {r7, pc}

asm_test::compare_exchange::u32::relaxed_acquire:
        push              {r7, lr}
        mov               r7, sp
        mov               r12, r0
0:
        ldrex             r0, [r12]
        cmp               r0, r1
        bne               1f
        strex             r3, r2, [r12]
        cmp               r3, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r7, pc}
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange::u32::relaxed_relaxed:
        push              {r7, lr}
        mov               r7, sp
        mov               r12, r0
0:
        ldrex             r0, [r12]
        cmp               r0, r1
        bne               1f
        strex             r3, r2, [r12]
        cmp               r3, #0x0
        bne               0b
        movs              r1, #0x1
        pop               {r7, pc}
1:
        movs              r1, #0x0
        clrex
        pop               {r7, pc}

asm_test::compare_exchange::u32::release_acquire:
        push              {r7, lr}
        mov               r7, sp
        mov               r12, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               1f
        dmb               sy
0:
        strex             r3, r2, [r12]
        cbz               r3, 2f
        ldrex             r0, [r12]
        cmp               r0, r1
        beq               0b
1:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}
2:
        movs              r1, #0x1
        pop               {r7, pc}

asm_test::compare_exchange::u32::release_relaxed:
        push              {r7, lr}
        mov               r7, sp
        mov               r12, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               1f
        dmb               sy
0:
        strex             r3, r2, [r12]
        cbz               r3, 2f
        ldrex             r0, [r12]
        cmp               r0, r1
        beq               0b
1:
        movs              r1, #0x0
        clrex
        pop               {r7, pc}
2:
        movs              r1, #0x1
        pop               {r7, pc}

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               sy
        movs              r1, #0x0
        strexb            r12, r2, [r3]
        cmp.w             r12, #0x0
        it                eq
        moveq.w           r1, #0xffffffff
        dmb               sy
        pop               {r7, pc}
0:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               sy
        movs              r1, #0x0
        strexb            r12, r2, [r3]
        cmp.w             r12, #0x0
        it                eq
        moveq.w           r1, #0xffffffff
        dmb               sy
        pop               {r7, pc}
0:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               sy
        movs              r1, #0x0
        strexb            r12, r2, [r3]
        cmp.w             r12, #0x0
        it                eq
        moveq.w           r1, #0xffffffff
        dmb               sy
        pop               {r7, pc}
0:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               sy
        strexb            r1, r2, [r3]
        cbz               r1, 1f
        movs              r1, #0x0
        pop               {r7, pc}
0:
        clrex
        movs              r1, #0x0
        pop               {r7, pc}
1:
        movs              r1, #0x1
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        strexb            r12, r2, [r3]
        movs              r1, #0x0
        cmp.w             r12, #0x0
        it                eq
        moveq.w           r1, #0xffffffff
        dmb               sy
        pop               {r7, pc}
0:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        strexb            r1, r2, [r3]
        cbz               r1, 1f
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}
0:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}
1:
        movs              r1, #0x1
        pop               {r7, pc}

asm_test::compare_exchange_weak::u8::release_seqcst:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               sy
        strexb            r1, r2, [r3]
        cbz               r1, 1f
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}
0:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}
1:
        movs              r1, #0x1
        pop               {r7, pc}

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               sy
        movs              r1, #0x0
        strexb            r12, r2, [r3]
        cmp.w             r12, #0x0
        it                eq
        moveq.w           r1, #0xffffffff
        dmb               sy
        pop               {r7, pc}
0:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               sy
        strexb            r1, r2, [r3]
        cbz               r1, 1f
        movs              r1, #0x0
        pop               {r7, pc}
0:
        clrex
        movs              r1, #0x0
        pop               {r7, pc}
1:
        movs              r1, #0x1
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange_weak::u8::acquire_acquire:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        strexb            r12, r2, [r3]
        movs              r1, #0x0
        cmp.w             r12, #0x0
        it                eq
        moveq.w           r1, #0xffffffff
        dmb               sy
        pop               {r7, pc}
0:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        strexb            r1, r2, [r3]
        cbz               r1, 1f
        movs              r1, #0x0
        pop               {r7, pc}
0:
        clrex
        movs              r1, #0x0
        pop               {r7, pc}
1:
        movs              r1, #0x1
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        strexb            r1, r2, [r3]
        cbz               r1, 1f
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}
0:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}
1:
        movs              r1, #0x1
        pop               {r7, pc}

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        strexb            r12, r2, [r3]
        movs              r1, #0x0
        cmp.w             r12, #0x0
        it                eq
        moveq.w           r1, #0xffffffff
        pop               {r7, pc}
0:
        movs              r1, #0x0
        clrex
        pop               {r7, pc}

asm_test::compare_exchange_weak::u8::release_acquire:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               sy
        strexb            r1, r2, [r3]
        cbz               r1, 1f
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}
0:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}
1:
        movs              r1, #0x1
        pop               {r7, pc}

asm_test::compare_exchange_weak::u8::release_relaxed:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexb            r0, [r0]
        uxtb              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               sy
        movs              r1, #0x0
        strexb            r12, r2, [r3]
        cmp.w             r12, #0x0
        it                eq
        moveq.w           r1, #0xffffffff
        pop               {r7, pc}
0:
        movs              r1, #0x0
        clrex
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               sy
        movs              r1, #0x0
        strexh            r12, r2, [r3]
        cmp.w             r12, #0x0
        it                eq
        moveq.w           r1, #0xffffffff
        dmb               sy
        pop               {r7, pc}
0:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               sy
        movs              r1, #0x0
        strexh            r12, r2, [r3]
        cmp.w             r12, #0x0
        it                eq
        moveq.w           r1, #0xffffffff
        dmb               sy
        pop               {r7, pc}
0:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               sy
        movs              r1, #0x0
        strexh            r12, r2, [r3]
        cmp.w             r12, #0x0
        it                eq
        moveq.w           r1, #0xffffffff
        dmb               sy
        pop               {r7, pc}
0:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               sy
        strexh            r1, r2, [r3]
        cbz               r1, 1f
        movs              r1, #0x0
        pop               {r7, pc}
0:
        clrex
        movs              r1, #0x0
        pop               {r7, pc}
1:
        movs              r1, #0x1
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        strexh            r12, r2, [r3]
        movs              r1, #0x0
        cmp.w             r12, #0x0
        it                eq
        moveq.w           r1, #0xffffffff
        dmb               sy
        pop               {r7, pc}
0:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        strexh            r1, r2, [r3]
        cbz               r1, 1f
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}
0:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}
1:
        movs              r1, #0x1
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::release_seqcst:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               sy
        strexh            r1, r2, [r3]
        cbz               r1, 1f
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}
0:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}
1:
        movs              r1, #0x1
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               sy
        movs              r1, #0x0
        strexh            r12, r2, [r3]
        cmp.w             r12, #0x0
        it                eq
        moveq.w           r1, #0xffffffff
        dmb               sy
        pop               {r7, pc}
0:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               sy
        strexh            r1, r2, [r3]
        cbz               r1, 1f
        movs              r1, #0x0
        pop               {r7, pc}
0:
        clrex
        movs              r1, #0x0
        pop               {r7, pc}
1:
        movs              r1, #0x1
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::acquire_acquire:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        strexh            r12, r2, [r3]
        movs              r1, #0x0
        cmp.w             r12, #0x0
        it                eq
        moveq.w           r1, #0xffffffff
        dmb               sy
        pop               {r7, pc}
0:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        strexh            r1, r2, [r3]
        cbz               r1, 1f
        movs              r1, #0x0
        pop               {r7, pc}
0:
        clrex
        movs              r1, #0x0
        pop               {r7, pc}
1:
        movs              r1, #0x1
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        strexh            r1, r2, [r3]
        cbz               r1, 1f
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}
0:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}
1:
        movs              r1, #0x1
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        strexh            r12, r2, [r3]
        movs              r1, #0x0
        cmp.w             r12, #0x0
        it                eq
        moveq.w           r1, #0xffffffff
        pop               {r7, pc}
0:
        movs              r1, #0x0
        clrex
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::release_acquire:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               sy
        strexh            r1, r2, [r3]
        cbz               r1, 1f
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}
0:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}
1:
        movs              r1, #0x1
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::release_relaxed:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrexh            r0, [r0]
        uxth              r1, r1
        cmp               r0, r1
        bne               0f
        dmb               sy
        movs              r1, #0x0
        strexh            r12, r2, [r3]
        cmp.w             r12, #0x0
        it                eq
        moveq.w           r1, #0xffffffff
        pop               {r7, pc}
0:
        movs              r1, #0x0
        clrex
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        dmb               sy
        movs              r1, #0x0
        strex             r12, r2, [r3]
        cmp.w             r12, #0x0
        it                eq
        moveq.w           r1, #0xffffffff
        dmb               sy
        pop               {r7, pc}
0:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        dmb               sy
        movs              r1, #0x0
        strex             r12, r2, [r3]
        cmp.w             r12, #0x0
        it                eq
        moveq.w           r1, #0xffffffff
        dmb               sy
        pop               {r7, pc}
0:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        dmb               sy
        movs              r1, #0x0
        strex             r12, r2, [r3]
        cmp.w             r12, #0x0
        it                eq
        moveq.w           r1, #0xffffffff
        dmb               sy
        pop               {r7, pc}
0:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        dmb               sy
        strex             r1, r2, [r3]
        cbz               r1, 1f
        movs              r1, #0x0
        pop               {r7, pc}
0:
        clrex
        movs              r1, #0x0
        pop               {r7, pc}
1:
        movs              r1, #0x1
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        strex             r12, r2, [r3]
        movs              r1, #0x0
        cmp.w             r12, #0x0
        it                eq
        moveq.w           r1, #0xffffffff
        dmb               sy
        pop               {r7, pc}
0:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        strex             r1, r2, [r3]
        cbz               r1, 1f
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}
0:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}
1:
        movs              r1, #0x1
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::release_seqcst:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        dmb               sy
        strex             r1, r2, [r3]
        cbz               r1, 1f
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}
0:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}
1:
        movs              r1, #0x1
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        dmb               sy
        movs              r1, #0x0
        strex             r12, r2, [r3]
        cmp.w             r12, #0x0
        it                eq
        moveq.w           r1, #0xffffffff
        dmb               sy
        pop               {r7, pc}
0:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        dmb               sy
        strex             r1, r2, [r3]
        cbz               r1, 1f
        movs              r1, #0x0
        pop               {r7, pc}
0:
        clrex
        movs              r1, #0x0
        pop               {r7, pc}
1:
        movs              r1, #0x1
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::acquire_acquire:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        strex             r12, r2, [r3]
        movs              r1, #0x0
        cmp.w             r12, #0x0
        it                eq
        moveq.w           r1, #0xffffffff
        dmb               sy
        pop               {r7, pc}
0:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        strex             r1, r2, [r3]
        cbz               r1, 1f
        movs              r1, #0x0
        pop               {r7, pc}
0:
        clrex
        movs              r1, #0x0
        pop               {r7, pc}
1:
        movs              r1, #0x1
        dmb               sy
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        strex             r1, r2, [r3]
        cbz               r1, 1f
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}
0:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}
1:
        movs              r1, #0x1
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        strex             r12, r2, [r3]
        movs              r1, #0x0
        cmp.w             r12, #0x0
        it                eq
        moveq.w           r1, #0xffffffff
        pop               {r7, pc}
0:
        movs              r1, #0x0
        clrex
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::release_acquire:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        dmb               sy
        strex             r1, r2, [r3]
        cbz               r1, 1f
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}
0:
        clrex
        movs              r1, #0x0
        dmb               sy
        pop               {r7, pc}
1:
        movs              r1, #0x1
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::release_relaxed:
        push              {r7, lr}
        mov               r7, sp
        mov               r3, r0
        ldrex             r0, [r0]
        cmp               r0, r1
        bne               0f
        dmb               sy
        movs              r1, #0x0
        strex             r12, r2, [r3]
        cmp.w             r12, #0x0
        it                eq
        moveq.w           r1, #0xffffffff
        pop               {r7, pc}
0:
        movs              r1, #0x0
        clrex
        pop               {r7, pc}

asm_test::load::u8::seqcst:
        push              {r7, lr}
        mov               r7, sp
        ldrb              r0, [r0]
        dmb               sy
        pop               {r7, pc}

asm_test::load::u8::acquire:
        push              {r7, lr}
        mov               r7, sp
        ldrb              r0, [r0]
        dmb               sy
        pop               {r7, pc}

asm_test::load::u8::relaxed:
        push              {r7, lr}
        mov               r7, sp
        ldrb              r0, [r0]
        pop               {r7, pc}

asm_test::load::u16::seqcst:
        push              {r7, lr}
        mov               r7, sp
        ldrh              r0, [r0]
        dmb               sy
        pop               {r7, pc}

asm_test::load::u16::acquire:
        push              {r7, lr}
        mov               r7, sp
        ldrh              r0, [r0]
        dmb               sy
        pop               {r7, pc}

asm_test::load::u16::relaxed:
        push              {r7, lr}
        mov               r7, sp
        ldrh              r0, [r0]
        pop               {r7, pc}

asm_test::load::u32::seqcst:
        push              {r7, lr}
        mov               r7, sp
        ldr               r0, [r0]
        dmb               sy
        pop               {r7, pc}

asm_test::load::u32::acquire:
        push              {r7, lr}
        mov               r7, sp
        ldr               r0, [r0]
        dmb               sy
        pop               {r7, pc}

asm_test::load::u32::relaxed:
        push              {r7, lr}
        mov               r7, sp
        ldr               r0, [r0]
        pop               {r7, pc}

asm_test::swap::u8::acqrel:
        push              {r7, lr}
        mov               r7, sp
        dmb               sy
0:
        ldrexb            r2, [r0]
        strexb            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        dmb               sy
        pop               {r7, pc}

asm_test::swap::u8::seqcst:
        push              {r7, lr}
        mov               r7, sp
        dmb               sy
0:
        ldrexb            r2, [r0]
        strexb            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        dmb               sy
        pop               {r7, pc}

asm_test::swap::u8::acquire:
        push              {r7, lr}
        mov               r7, sp
        mov               r2, r0
0:
        ldrexb            r0, [r2]
        strexb            r3, r1, [r2]
        cmp               r3, #0x0
        bne               0b
        dmb               sy
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
        dmb               sy
0:
        ldrexb            r2, [r0]
        strexb            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        pop               {r7, pc}

asm_test::swap::u16::acqrel:
        push              {r7, lr}
        mov               r7, sp
        dmb               sy
0:
        ldrexh            r2, [r0]
        strexh            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        dmb               sy
        pop               {r7, pc}

asm_test::swap::u16::seqcst:
        push              {r7, lr}
        mov               r7, sp
        dmb               sy
0:
        ldrexh            r2, [r0]
        strexh            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        dmb               sy
        pop               {r7, pc}

asm_test::swap::u16::acquire:
        push              {r7, lr}
        mov               r7, sp
        mov               r2, r0
0:
        ldrexh            r0, [r2]
        strexh            r3, r1, [r2]
        cmp               r3, #0x0
        bne               0b
        dmb               sy
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
        dmb               sy
0:
        ldrexh            r2, [r0]
        strexh            r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        pop               {r7, pc}

asm_test::swap::u32::acqrel:
        push              {r7, lr}
        mov               r7, sp
        mov               r2, r0
        dmb               sy
0:
        ldrex             r0, [r2]
        strex             r3, r1, [r2]
        cmp               r3, #0x0
        bne               0b
        dmb               sy
        pop               {r7, pc}

asm_test::swap::u32::seqcst:
        push              {r7, lr}
        mov               r7, sp
        mov               r2, r0
        dmb               sy
0:
        ldrex             r0, [r2]
        strex             r3, r1, [r2]
        cmp               r3, #0x0
        bne               0b
        dmb               sy
        pop               {r7, pc}

asm_test::swap::u32::acquire:
        push              {r7, lr}
        mov               r7, sp
        mov               r2, r0
0:
        ldrex             r0, [r2]
        strex             r3, r1, [r2]
        cmp               r3, #0x0
        bne               0b
        dmb               sy
        pop               {r7, pc}

asm_test::swap::u32::relaxed:
        push              {r7, lr}
        mov               r7, sp
        mov               r2, r0
0:
        ldrex             r0, [r2]
        strex             r3, r1, [r2]
        cmp               r3, #0x0
        bne               0b
        pop               {r7, pc}

asm_test::swap::u32::release:
        push              {r7, lr}
        mov               r7, sp
        dmb               sy
0:
        ldrex             r2, [r0]
        strex             r3, r1, [r0]
        cmp               r3, #0x0
        bne               0b
        mov               r0, r2
        pop               {r7, pc}

asm_test::store::u8::seqcst:
        push              {r7, lr}
        mov               r7, sp
        dmb               sy
        strb              r1, [r0]
        dmb               sy
        pop               {r7, pc}

asm_test::store::u8::relaxed:
        push              {r7, lr}
        mov               r7, sp
        strb              r1, [r0]
        pop               {r7, pc}

asm_test::store::u8::release:
        push              {r7, lr}
        mov               r7, sp
        dmb               sy
        strb              r1, [r0]
        pop               {r7, pc}

asm_test::store::u16::seqcst:
        push              {r7, lr}
        mov               r7, sp
        dmb               sy
        strh              r1, [r0]
        dmb               sy
        pop               {r7, pc}

asm_test::store::u16::relaxed:
        push              {r7, lr}
        mov               r7, sp
        strh              r1, [r0]
        pop               {r7, pc}

asm_test::store::u16::release:
        push              {r7, lr}
        mov               r7, sp
        dmb               sy
        strh              r1, [r0]
        pop               {r7, pc}

asm_test::store::u32::seqcst:
        push              {r7, lr}
        mov               r7, sp
        dmb               sy
        str               r1, [r0]
        dmb               sy
        pop               {r7, pc}

asm_test::store::u32::relaxed:
        push              {r7, lr}
        mov               r7, sp
        str               r1, [r0]
        pop               {r7, pc}

asm_test::store::u32::release:
        push              {r7, lr}
        mov               r7, sp
        dmb               sy
        str               r1, [r0]
        pop               {r7, pc}

