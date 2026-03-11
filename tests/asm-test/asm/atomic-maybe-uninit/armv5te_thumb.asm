asm_test::compare_exchange::u8::acqrel_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        movs              r7, #0xff
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x38]         @ 3f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u8::seqcst_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        movs              r7, #0xff
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x38]         @ 3f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u8::acqrel_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        movs              r7, #0xff
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x38]         @ 3f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u8::acqrel_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        movs              r7, #0xff
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x38]         @ 3f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u8::acquire_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        movs              r7, #0xff
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x38]         @ 3f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u8::relaxed_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        movs              r7, #0xff
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x38]         @ 3f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u8::release_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        movs              r7, #0xff
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x38]         @ 3f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u8::seqcst_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        movs              r7, #0xff
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x38]         @ 3f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u8::seqcst_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        movs              r7, #0xff
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x38]         @ 3f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u8::acquire_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        movs              r7, #0xff
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x38]         @ 3f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u8::acquire_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        movs              r7, #0xff
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x38]         @ 3f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u8::relaxed_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        movs              r7, #0xff
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x38]         @ 3f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u8::relaxed_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        movs              r7, #0xff
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x38]         @ 3f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u8::release_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        movs              r7, #0xff
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x38]         @ 3f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u8::release_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        movs              r7, #0xff
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x38]         @ 3f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::acqrel_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x4c]         @ 3f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x3c]         @ 4f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0x0000ffff
4:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::seqcst_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x4c]         @ 3f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x3c]         @ 4f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0x0000ffff
4:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::acqrel_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x4c]         @ 3f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x3c]         @ 4f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0x0000ffff
4:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::acqrel_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x4c]         @ 3f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x3c]         @ 4f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0x0000ffff
4:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::acquire_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x4c]         @ 3f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x3c]         @ 4f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0x0000ffff
4:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::relaxed_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x4c]         @ 3f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x3c]         @ 4f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0x0000ffff
4:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::release_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x4c]         @ 3f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x3c]         @ 4f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0x0000ffff
4:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::seqcst_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x4c]         @ 3f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x3c]         @ 4f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0x0000ffff
4:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::seqcst_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x4c]         @ 3f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x3c]         @ 4f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0x0000ffff
4:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::acquire_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x4c]         @ 3f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x3c]         @ 4f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0x0000ffff
4:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::acquire_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x4c]         @ 3f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x3c]         @ 4f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0x0000ffff
4:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::relaxed_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x4c]         @ 3f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x3c]         @ 4f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0x0000ffff
4:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::relaxed_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x4c]         @ 3f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x3c]         @ 4f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0x0000ffff
4:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::release_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x4c]         @ 3f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x3c]         @ 4f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0x0000ffff
4:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::release_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x4c]         @ 3f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x3c]         @ 4f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0x0000ffff
4:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::acqrel_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x24]         @ 3f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               1f
        movs              r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r7
        blo               0b
        movs              r0, #0x1
2:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::seqcst_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x24]         @ 3f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               1f
        movs              r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r7
        blo               0b
        movs              r0, #0x1
2:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::acqrel_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x24]         @ 3f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               1f
        movs              r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r7
        blo               0b
        movs              r0, #0x1
2:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::acqrel_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x24]         @ 3f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               1f
        movs              r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r7
        blo               0b
        movs              r0, #0x1
2:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::acquire_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x24]         @ 3f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               1f
        movs              r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r7
        blo               0b
        movs              r0, #0x1
2:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::relaxed_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x24]         @ 3f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               1f
        movs              r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r7
        blo               0b
        movs              r0, #0x1
2:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::release_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x24]         @ 3f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               1f
        movs              r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r7
        blo               0b
        movs              r0, #0x1
2:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::seqcst_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x24]         @ 3f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               1f
        movs              r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r7
        blo               0b
        movs              r0, #0x1
2:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::seqcst_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x24]         @ 3f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               1f
        movs              r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r7
        blo               0b
        movs              r0, #0x1
2:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::acquire_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x24]         @ 3f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               1f
        movs              r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r7
        blo               0b
        movs              r0, #0x1
2:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::acquire_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x24]         @ 3f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               1f
        movs              r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r7
        blo               0b
        movs              r0, #0x1
2:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::relaxed_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x24]         @ 3f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               1f
        movs              r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r7
        blo               0b
        movs              r0, #0x1
2:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::relaxed_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x24]         @ 3f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               1f
        movs              r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r7
        blo               0b
        movs              r0, #0x1
2:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::release_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x24]         @ 3f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               1f
        movs              r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r7
        blo               0b
        movs              r0, #0x1
2:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::release_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x24]         @ 3f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               1f
        movs              r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r7
        blo               0b
        movs              r0, #0x1
2:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u64::acqrel_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x4c]         @ 4f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               3f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x40]         @ 5f
        movs              r2, r1
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        eors              r0, r6
        eors              r1, r5
        orrs              r0, r1
        bne               1f
        movs              r0, r4
        movs              r1, r7
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r0, r4
        movs              r1, r4
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7, pc}
3:
        bl                3f
        mov               r8, r8
4:
        .word             0xffff0ffc
5:
        .word             0xffff0f60

asm_test::compare_exchange::u64::seqcst_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x4c]         @ 4f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               3f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x40]         @ 5f
        movs              r2, r1
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        eors              r0, r6
        eors              r1, r5
        orrs              r0, r1
        bne               1f
        movs              r0, r4
        movs              r1, r7
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r0, r4
        movs              r1, r4
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7, pc}
3:
        bl                3f
        mov               r8, r8
4:
        .word             0xffff0ffc
5:
        .word             0xffff0f60

asm_test::compare_exchange::u64::acqrel_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x4c]         @ 4f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               3f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x40]         @ 5f
        movs              r2, r1
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        eors              r0, r6
        eors              r1, r5
        orrs              r0, r1
        bne               1f
        movs              r0, r4
        movs              r1, r7
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r0, r4
        movs              r1, r4
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7, pc}
3:
        bl                3f
        mov               r8, r8
4:
        .word             0xffff0ffc
5:
        .word             0xffff0f60

asm_test::compare_exchange::u64::acqrel_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x4c]         @ 4f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               3f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x40]         @ 5f
        movs              r2, r1
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        eors              r0, r6
        eors              r1, r5
        orrs              r0, r1
        bne               1f
        movs              r0, r4
        movs              r1, r7
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r0, r4
        movs              r1, r4
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7, pc}
3:
        bl                3f
        mov               r8, r8
4:
        .word             0xffff0ffc
5:
        .word             0xffff0f60

asm_test::compare_exchange::u64::acquire_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x4c]         @ 4f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               3f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x40]         @ 5f
        movs              r2, r1
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        eors              r0, r6
        eors              r1, r5
        orrs              r0, r1
        bne               1f
        movs              r0, r4
        movs              r1, r7
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r0, r4
        movs              r1, r4
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7, pc}
3:
        bl                3f
        mov               r8, r8
4:
        .word             0xffff0ffc
5:
        .word             0xffff0f60

asm_test::compare_exchange::u64::relaxed_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x4c]         @ 4f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               3f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x40]         @ 5f
        movs              r2, r1
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        eors              r0, r6
        eors              r1, r5
        orrs              r0, r1
        bne               1f
        movs              r0, r4
        movs              r1, r7
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r0, r4
        movs              r1, r4
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7, pc}
3:
        bl                3f
        mov               r8, r8
4:
        .word             0xffff0ffc
5:
        .word             0xffff0f60

asm_test::compare_exchange::u64::release_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x4c]         @ 4f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               3f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x40]         @ 5f
        movs              r2, r1
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        eors              r0, r6
        eors              r1, r5
        orrs              r0, r1
        bne               1f
        movs              r0, r4
        movs              r1, r7
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r0, r4
        movs              r1, r4
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7, pc}
3:
        bl                3f
        mov               r8, r8
4:
        .word             0xffff0ffc
5:
        .word             0xffff0f60

asm_test::compare_exchange::u64::seqcst_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x4c]         @ 4f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               3f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x40]         @ 5f
        movs              r2, r1
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        eors              r0, r6
        eors              r1, r5
        orrs              r0, r1
        bne               1f
        movs              r0, r4
        movs              r1, r7
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r0, r4
        movs              r1, r4
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7, pc}
3:
        bl                3f
        mov               r8, r8
4:
        .word             0xffff0ffc
5:
        .word             0xffff0f60

asm_test::compare_exchange::u64::seqcst_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x4c]         @ 4f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               3f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x40]         @ 5f
        movs              r2, r1
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        eors              r0, r6
        eors              r1, r5
        orrs              r0, r1
        bne               1f
        movs              r0, r4
        movs              r1, r7
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r0, r4
        movs              r1, r4
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7, pc}
3:
        bl                3f
        mov               r8, r8
4:
        .word             0xffff0ffc
5:
        .word             0xffff0f60

asm_test::compare_exchange::u64::acquire_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x4c]         @ 4f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               3f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x40]         @ 5f
        movs              r2, r1
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        eors              r0, r6
        eors              r1, r5
        orrs              r0, r1
        bne               1f
        movs              r0, r4
        movs              r1, r7
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r0, r4
        movs              r1, r4
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7, pc}
3:
        bl                3f
        mov               r8, r8
4:
        .word             0xffff0ffc
5:
        .word             0xffff0f60

asm_test::compare_exchange::u64::acquire_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x4c]         @ 4f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               3f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x40]         @ 5f
        movs              r2, r1
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        eors              r0, r6
        eors              r1, r5
        orrs              r0, r1
        bne               1f
        movs              r0, r4
        movs              r1, r7
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r0, r4
        movs              r1, r4
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7, pc}
3:
        bl                3f
        mov               r8, r8
4:
        .word             0xffff0ffc
5:
        .word             0xffff0f60

asm_test::compare_exchange::u64::relaxed_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x4c]         @ 4f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               3f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x40]         @ 5f
        movs              r2, r1
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        eors              r0, r6
        eors              r1, r5
        orrs              r0, r1
        bne               1f
        movs              r0, r4
        movs              r1, r7
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r0, r4
        movs              r1, r4
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7, pc}
3:
        bl                3f
        mov               r8, r8
4:
        .word             0xffff0ffc
5:
        .word             0xffff0f60

asm_test::compare_exchange::u64::relaxed_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x4c]         @ 4f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               3f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x40]         @ 5f
        movs              r2, r1
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        eors              r0, r6
        eors              r1, r5
        orrs              r0, r1
        bne               1f
        movs              r0, r4
        movs              r1, r7
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r0, r4
        movs              r1, r4
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7, pc}
3:
        bl                3f
        mov               r8, r8
4:
        .word             0xffff0ffc
5:
        .word             0xffff0f60

asm_test::compare_exchange::u64::release_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x4c]         @ 4f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               3f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x40]         @ 5f
        movs              r2, r1
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        eors              r0, r6
        eors              r1, r5
        orrs              r0, r1
        bne               1f
        movs              r0, r4
        movs              r1, r7
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r0, r4
        movs              r1, r4
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7, pc}
3:
        bl                3f
        mov               r8, r8
4:
        .word             0xffff0ffc
5:
        .word             0xffff0f60

asm_test::compare_exchange::u64::release_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x4c]         @ 4f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               3f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x40]         @ 5f
        movs              r2, r1
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        eors              r0, r6
        eors              r1, r5
        orrs              r0, r1
        bne               1f
        movs              r0, r4
        movs              r1, r7
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r0, r4
        movs              r1, r4
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7, pc}
3:
        bl                3f
        mov               r8, r8
4:
        .word             0xffff0ffc
5:
        .word             0xffff0f60

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        movs              r7, #0xff
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x38]         @ 3f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        movs              r7, #0xff
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x38]         @ 3f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        movs              r7, #0xff
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x38]         @ 3f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        movs              r7, #0xff
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x38]         @ 3f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        movs              r7, #0xff
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x38]         @ 3f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        movs              r7, #0xff
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x38]         @ 3f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u8::release_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        movs              r7, #0xff
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x38]         @ 3f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        movs              r7, #0xff
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x38]         @ 3f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        movs              r7, #0xff
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x38]         @ 3f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u8::acquire_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        movs              r7, #0xff
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x38]         @ 3f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        movs              r7, #0xff
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x38]         @ 3f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        movs              r7, #0xff
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x38]         @ 3f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        movs              r7, #0xff
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x38]         @ 3f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u8::release_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        movs              r7, #0xff
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x38]         @ 3f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u8::release_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        movs              r7, #0xff
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x38]         @ 3f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x4c]         @ 3f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x3c]         @ 4f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0x0000ffff
4:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x4c]         @ 3f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x3c]         @ 4f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0x0000ffff
4:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x4c]         @ 3f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x3c]         @ 4f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0x0000ffff
4:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x4c]         @ 3f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x3c]         @ 4f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0x0000ffff
4:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x4c]         @ 3f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x3c]         @ 4f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0x0000ffff
4:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x4c]         @ 3f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x3c]         @ 4f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0x0000ffff
4:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::release_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x4c]         @ 3f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x3c]         @ 4f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0x0000ffff
4:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x4c]         @ 3f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x3c]         @ 4f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0x0000ffff
4:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x4c]         @ 3f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x3c]         @ 4f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0x0000ffff
4:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::acquire_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x4c]         @ 3f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x3c]         @ 4f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0x0000ffff
4:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x4c]         @ 3f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x3c]         @ 4f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0x0000ffff
4:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x4c]         @ 3f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x3c]         @ 4f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0x0000ffff
4:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x4c]         @ 3f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x3c]         @ 4f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0x0000ffff
4:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::release_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x4c]         @ 3f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x3c]         @ 4f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0x0000ffff
4:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::release_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x4c]         @ 3f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x3c]         @ 4f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               1f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0x0000ffff
4:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x24]         @ 3f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               1f
        movs              r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r7
        blo               0b
        movs              r0, #0x1
2:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x24]         @ 3f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               1f
        movs              r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r7
        blo               0b
        movs              r0, #0x1
2:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x24]         @ 3f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               1f
        movs              r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r7
        blo               0b
        movs              r0, #0x1
2:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x24]         @ 3f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               1f
        movs              r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r7
        blo               0b
        movs              r0, #0x1
2:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x24]         @ 3f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               1f
        movs              r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r7
        blo               0b
        movs              r0, #0x1
2:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x24]         @ 3f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               1f
        movs              r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r7
        blo               0b
        movs              r0, #0x1
2:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::release_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x24]         @ 3f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               1f
        movs              r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r7
        blo               0b
        movs              r0, #0x1
2:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x24]         @ 3f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               1f
        movs              r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r7
        blo               0b
        movs              r0, #0x1
2:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x24]         @ 3f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               1f
        movs              r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r7
        blo               0b
        movs              r0, #0x1
2:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::acquire_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x24]         @ 3f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               1f
        movs              r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r7
        blo               0b
        movs              r0, #0x1
2:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x24]         @ 3f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               1f
        movs              r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r7
        blo               0b
        movs              r0, #0x1
2:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x24]         @ 3f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               1f
        movs              r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r7
        blo               0b
        movs              r0, #0x1
2:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x24]         @ 3f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               1f
        movs              r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r7
        blo               0b
        movs              r0, #0x1
2:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::release_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x24]         @ 3f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               1f
        movs              r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r7
        blo               0b
        movs              r0, #0x1
2:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::release_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x24]         @ 3f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               1f
        movs              r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        movs              r1, r0
        blx               r7
        blo               0b
        movs              r0, #0x1
2:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u64::acqrel_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x4c]         @ 4f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               3f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x40]         @ 5f
        movs              r2, r1
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        eors              r0, r6
        eors              r1, r5
        orrs              r0, r1
        bne               1f
        movs              r0, r4
        movs              r1, r7
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r0, r4
        movs              r1, r4
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7, pc}
3:
        bl                3f
        mov               r8, r8
4:
        .word             0xffff0ffc
5:
        .word             0xffff0f60

asm_test::compare_exchange_weak::u64::seqcst_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x4c]         @ 4f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               3f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x40]         @ 5f
        movs              r2, r1
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        eors              r0, r6
        eors              r1, r5
        orrs              r0, r1
        bne               1f
        movs              r0, r4
        movs              r1, r7
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r0, r4
        movs              r1, r4
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7, pc}
3:
        bl                3f
        mov               r8, r8
4:
        .word             0xffff0ffc
5:
        .word             0xffff0f60

asm_test::compare_exchange_weak::u64::acqrel_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x4c]         @ 4f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               3f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x40]         @ 5f
        movs              r2, r1
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        eors              r0, r6
        eors              r1, r5
        orrs              r0, r1
        bne               1f
        movs              r0, r4
        movs              r1, r7
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r0, r4
        movs              r1, r4
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7, pc}
3:
        bl                3f
        mov               r8, r8
4:
        .word             0xffff0ffc
5:
        .word             0xffff0f60

asm_test::compare_exchange_weak::u64::acqrel_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x4c]         @ 4f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               3f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x40]         @ 5f
        movs              r2, r1
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        eors              r0, r6
        eors              r1, r5
        orrs              r0, r1
        bne               1f
        movs              r0, r4
        movs              r1, r7
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r0, r4
        movs              r1, r4
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7, pc}
3:
        bl                3f
        mov               r8, r8
4:
        .word             0xffff0ffc
5:
        .word             0xffff0f60

asm_test::compare_exchange_weak::u64::acquire_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x4c]         @ 4f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               3f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x40]         @ 5f
        movs              r2, r1
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        eors              r0, r6
        eors              r1, r5
        orrs              r0, r1
        bne               1f
        movs              r0, r4
        movs              r1, r7
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r0, r4
        movs              r1, r4
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7, pc}
3:
        bl                3f
        mov               r8, r8
4:
        .word             0xffff0ffc
5:
        .word             0xffff0f60

asm_test::compare_exchange_weak::u64::relaxed_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x4c]         @ 4f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               3f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x40]         @ 5f
        movs              r2, r1
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        eors              r0, r6
        eors              r1, r5
        orrs              r0, r1
        bne               1f
        movs              r0, r4
        movs              r1, r7
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r0, r4
        movs              r1, r4
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7, pc}
3:
        bl                3f
        mov               r8, r8
4:
        .word             0xffff0ffc
5:
        .word             0xffff0f60

asm_test::compare_exchange_weak::u64::release_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x4c]         @ 4f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               3f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x40]         @ 5f
        movs              r2, r1
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        eors              r0, r6
        eors              r1, r5
        orrs              r0, r1
        bne               1f
        movs              r0, r4
        movs              r1, r7
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r0, r4
        movs              r1, r4
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7, pc}
3:
        bl                3f
        mov               r8, r8
4:
        .word             0xffff0ffc
5:
        .word             0xffff0f60

asm_test::compare_exchange_weak::u64::seqcst_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x4c]         @ 4f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               3f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x40]         @ 5f
        movs              r2, r1
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        eors              r0, r6
        eors              r1, r5
        orrs              r0, r1
        bne               1f
        movs              r0, r4
        movs              r1, r7
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r0, r4
        movs              r1, r4
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7, pc}
3:
        bl                3f
        mov               r8, r8
4:
        .word             0xffff0ffc
5:
        .word             0xffff0f60

asm_test::compare_exchange_weak::u64::seqcst_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x4c]         @ 4f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               3f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x40]         @ 5f
        movs              r2, r1
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        eors              r0, r6
        eors              r1, r5
        orrs              r0, r1
        bne               1f
        movs              r0, r4
        movs              r1, r7
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r0, r4
        movs              r1, r4
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7, pc}
3:
        bl                3f
        mov               r8, r8
4:
        .word             0xffff0ffc
5:
        .word             0xffff0f60

asm_test::compare_exchange_weak::u64::acquire_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x4c]         @ 4f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               3f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x40]         @ 5f
        movs              r2, r1
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        eors              r0, r6
        eors              r1, r5
        orrs              r0, r1
        bne               1f
        movs              r0, r4
        movs              r1, r7
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r0, r4
        movs              r1, r4
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7, pc}
3:
        bl                3f
        mov               r8, r8
4:
        .word             0xffff0ffc
5:
        .word             0xffff0f60

asm_test::compare_exchange_weak::u64::acquire_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x4c]         @ 4f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               3f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x40]         @ 5f
        movs              r2, r1
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        eors              r0, r6
        eors              r1, r5
        orrs              r0, r1
        bne               1f
        movs              r0, r4
        movs              r1, r7
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r0, r4
        movs              r1, r4
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7, pc}
3:
        bl                3f
        mov               r8, r8
4:
        .word             0xffff0ffc
5:
        .word             0xffff0f60

asm_test::compare_exchange_weak::u64::relaxed_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x4c]         @ 4f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               3f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x40]         @ 5f
        movs              r2, r1
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        eors              r0, r6
        eors              r1, r5
        orrs              r0, r1
        bne               1f
        movs              r0, r4
        movs              r1, r7
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r0, r4
        movs              r1, r4
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7, pc}
3:
        bl                3f
        mov               r8, r8
4:
        .word             0xffff0ffc
5:
        .word             0xffff0f60

asm_test::compare_exchange_weak::u64::relaxed_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x4c]         @ 4f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               3f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x40]         @ 5f
        movs              r2, r1
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        eors              r0, r6
        eors              r1, r5
        orrs              r0, r1
        bne               1f
        movs              r0, r4
        movs              r1, r7
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r0, r4
        movs              r1, r4
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7, pc}
3:
        bl                3f
        mov               r8, r8
4:
        .word             0xffff0ffc
5:
        .word             0xffff0f60

asm_test::compare_exchange_weak::u64::release_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x4c]         @ 4f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               3f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x40]         @ 5f
        movs              r2, r1
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        eors              r0, r6
        eors              r1, r5
        orrs              r0, r1
        bne               1f
        movs              r0, r4
        movs              r1, r7
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r0, r4
        movs              r1, r4
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7, pc}
3:
        bl                3f
        mov               r8, r8
4:
        .word             0xffff0ffc
5:
        .word             0xffff0f60

asm_test::compare_exchange_weak::u64::release_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x4c]         @ 4f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               3f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x40]         @ 5f
        movs              r2, r1
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        eors              r0, r6
        eors              r1, r5
        orrs              r0, r1
        bne               1f
        movs              r0, r4
        movs              r1, r7
        blx               r3
        blo               0b
        b                 2f
1:
        movs              r0, r4
        movs              r1, r4
        blx               r3
        blo               0b
        movs              r0, #0x1
2:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7, pc}
3:
        bl                3f
        mov               r8, r8
4:
        .word             0xffff0ffc
5:
        .word             0xffff0f60

asm_test::load::u8::seqcst:
        push              {r7, lr}
        ldr               r1, [pc, #0x8]          @ 0f
        ldrb              r0, [r0]
        blx               r1
        pop               {r7, pc}
        mov               r8, r8
0:
        .word             0xffff0fa0

asm_test::load::u8::acquire:
        push              {r7, lr}
        ldr               r1, [pc, #0x8]          @ 0f
        ldrb              r0, [r0]
        blx               r1
        pop               {r7, pc}
        mov               r8, r8
0:
        .word             0xffff0fa0

asm_test::load::u8::relaxed:
        ldrb              r0, [r0]
        bx                lr

asm_test::load::u16::seqcst:
        push              {r7, lr}
        ldr               r1, [pc, #0x8]          @ 0f
        ldrh              r0, [r0]
        blx               r1
        pop               {r7, pc}
        mov               r8, r8
0:
        .word             0xffff0fa0

asm_test::load::u16::acquire:
        push              {r7, lr}
        ldr               r1, [pc, #0x8]          @ 0f
        ldrh              r0, [r0]
        blx               r1
        pop               {r7, pc}
        mov               r8, r8
0:
        .word             0xffff0fa0

asm_test::load::u16::relaxed:
        ldrh              r0, [r0]
        bx                lr

asm_test::load::u32::seqcst:
        push              {r7, lr}
        ldr               r1, [pc, #0x8]          @ 0f
        ldr               r0, [r0]
        blx               r1
        pop               {r7, pc}
        mov               r8, r8
0:
        .word             0xffff0fa0

asm_test::load::u32::acquire:
        push              {r7, lr}
        ldr               r1, [pc, #0x8]          @ 0f
        ldr               r0, [r0]
        blx               r1
        pop               {r7, pc}
        mov               r8, r8
0:
        .word             0xffff0fa0

asm_test::load::u32::relaxed:
        ldr               r0, [r0]
        bx                lr

asm_test::load::u64::seqcst:
        push              {r4, r5, r7, lr}
        sub               sp, #0x8
        ldr               r1, [pc, #0x28]         @ 2f
        ldr               r1, [r1]
        cmp               r1, #0x5
        blt               1f
        mov               r4, sp
        ldr               r5, [pc, #0x24]         @ 3f
        movs              r2, r0
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        movs              r0, r4
        movs              r1, r4
        blx               r5
        blo               0b
        ldr               r1, [sp, #0x4]
        ldr               r0, [sp]
        add               sp, #0x8
        pop               {r4, r5, r7, pc}
1:
        bl                1f
        mov               r8, r8
2:
        .word             0xffff0ffc
3:
        .word             0xffff0f60

asm_test::load::u64::acquire:
        push              {r4, r5, r7, lr}
        sub               sp, #0x8
        ldr               r1, [pc, #0x28]         @ 2f
        ldr               r1, [r1]
        cmp               r1, #0x5
        blt               1f
        mov               r4, sp
        ldr               r5, [pc, #0x24]         @ 3f
        movs              r2, r0
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        movs              r0, r4
        movs              r1, r4
        blx               r5
        blo               0b
        ldr               r1, [sp, #0x4]
        ldr               r0, [sp]
        add               sp, #0x8
        pop               {r4, r5, r7, pc}
1:
        bl                1f
        mov               r8, r8
2:
        .word             0xffff0ffc
3:
        .word             0xffff0f60

asm_test::load::u64::relaxed:
        push              {r4, r5, r7, lr}
        sub               sp, #0x8
        ldr               r1, [pc, #0x28]         @ 2f
        ldr               r1, [r1]
        cmp               r1, #0x5
        blt               1f
        mov               r4, sp
        ldr               r5, [pc, #0x24]         @ 3f
        movs              r2, r0
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        movs              r0, r4
        movs              r1, r4
        blx               r5
        blo               0b
        ldr               r1, [sp, #0x4]
        ldr               r0, [sp]
        add               sp, #0x8
        pop               {r4, r5, r7, pc}
1:
        bl                1f
        mov               r8, r8
2:
        .word             0xffff0ffc
3:
        .word             0xffff0f60

asm_test::swap::u8::acqrel:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r1
        movs              r1, #0x3
        movs              r2, #0xff
        ands              r4, r2
        lsls              r3, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r3, #0x1b
        str               r1, [sp, #0x4]
        lsls              r4, r1
        lsls              r2, r1
        mvns              r1, r2
        str               r1, [sp, #0x8]
        movs              r2, r0
        ldr               r7, [pc, #0x1c]         @ 1f
        ldr               r6, [sp, #0x8]
0:
        ldr               r5, [r2]
        movs              r0, r5
        movs              r1, r5
        ands              r1, r6
        orrs              r1, r4
        blx               r7
        blo               0b
        ldr               r0, [sp, #0x4]
        lsrs              r5, r0
        movs              r0, r5
        add               sp, #0xc
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
1:
        .word             0xffff0fc0

asm_test::swap::u8::seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r1
        movs              r1, #0x3
        movs              r2, #0xff
        ands              r4, r2
        lsls              r3, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r3, #0x1b
        str               r1, [sp, #0x4]
        lsls              r4, r1
        lsls              r2, r1
        mvns              r1, r2
        str               r1, [sp, #0x8]
        movs              r2, r0
        ldr               r7, [pc, #0x1c]         @ 1f
        ldr               r6, [sp, #0x8]
0:
        ldr               r5, [r2]
        movs              r0, r5
        movs              r1, r5
        ands              r1, r6
        orrs              r1, r4
        blx               r7
        blo               0b
        ldr               r0, [sp, #0x4]
        lsrs              r5, r0
        movs              r0, r5
        add               sp, #0xc
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
1:
        .word             0xffff0fc0

asm_test::swap::u8::acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r1
        movs              r1, #0x3
        movs              r2, #0xff
        ands              r4, r2
        lsls              r3, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r3, #0x1b
        str               r1, [sp, #0x4]
        lsls              r4, r1
        lsls              r2, r1
        mvns              r1, r2
        str               r1, [sp, #0x8]
        movs              r2, r0
        ldr               r7, [pc, #0x1c]         @ 1f
        ldr               r6, [sp, #0x8]
0:
        ldr               r5, [r2]
        movs              r0, r5
        movs              r1, r5
        ands              r1, r6
        orrs              r1, r4
        blx               r7
        blo               0b
        ldr               r0, [sp, #0x4]
        lsrs              r5, r0
        movs              r0, r5
        add               sp, #0xc
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
1:
        .word             0xffff0fc0

asm_test::swap::u8::relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r1
        movs              r1, #0x3
        movs              r2, #0xff
        ands              r4, r2
        lsls              r3, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r3, #0x1b
        str               r1, [sp, #0x4]
        lsls              r4, r1
        lsls              r2, r1
        mvns              r1, r2
        str               r1, [sp, #0x8]
        movs              r2, r0
        ldr               r7, [pc, #0x1c]         @ 1f
        ldr               r6, [sp, #0x8]
0:
        ldr               r5, [r2]
        movs              r0, r5
        movs              r1, r5
        ands              r1, r6
        orrs              r1, r4
        blx               r7
        blo               0b
        ldr               r0, [sp, #0x4]
        lsrs              r5, r0
        movs              r0, r5
        add               sp, #0xc
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
1:
        .word             0xffff0fc0

asm_test::swap::u8::release:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r1
        movs              r1, #0x3
        movs              r2, #0xff
        ands              r4, r2
        lsls              r3, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r3, #0x1b
        str               r1, [sp, #0x4]
        lsls              r4, r1
        lsls              r2, r1
        mvns              r1, r2
        str               r1, [sp, #0x8]
        movs              r2, r0
        ldr               r7, [pc, #0x1c]         @ 1f
        ldr               r6, [sp, #0x8]
0:
        ldr               r5, [r2]
        movs              r0, r5
        movs              r1, r5
        ands              r1, r6
        orrs              r1, r4
        blx               r7
        blo               0b
        ldr               r0, [sp, #0x4]
        lsrs              r5, r0
        movs              r0, r5
        add               sp, #0xc
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
1:
        .word             0xffff0fc0

asm_test::swap::u16::acqrel:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r1
        movs              r1, #0x3
        ldr               r2, [pc, #0x30]         @ 1f
        ands              r4, r2
        lsls              r3, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r3, #0x1b
        str               r1, [sp, #0x4]
        lsls              r4, r1
        lsls              r2, r1
        mvns              r1, r2
        str               r1, [sp, #0x8]
        movs              r2, r0
        ldr               r7, [pc, #0x20]         @ 2f
        ldr               r6, [sp, #0x8]
0:
        ldr               r5, [r2]
        movs              r0, r5
        movs              r1, r5
        ands              r1, r6
        orrs              r1, r4
        blx               r7
        blo               0b
        ldr               r0, [sp, #0x4]
        lsrs              r5, r0
        movs              r0, r5
        add               sp, #0xc
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
1:
        .word             0x0000ffff
2:
        .word             0xffff0fc0

asm_test::swap::u16::seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r1
        movs              r1, #0x3
        ldr               r2, [pc, #0x30]         @ 1f
        ands              r4, r2
        lsls              r3, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r3, #0x1b
        str               r1, [sp, #0x4]
        lsls              r4, r1
        lsls              r2, r1
        mvns              r1, r2
        str               r1, [sp, #0x8]
        movs              r2, r0
        ldr               r7, [pc, #0x20]         @ 2f
        ldr               r6, [sp, #0x8]
0:
        ldr               r5, [r2]
        movs              r0, r5
        movs              r1, r5
        ands              r1, r6
        orrs              r1, r4
        blx               r7
        blo               0b
        ldr               r0, [sp, #0x4]
        lsrs              r5, r0
        movs              r0, r5
        add               sp, #0xc
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
1:
        .word             0x0000ffff
2:
        .word             0xffff0fc0

asm_test::swap::u16::acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r1
        movs              r1, #0x3
        ldr               r2, [pc, #0x30]         @ 1f
        ands              r4, r2
        lsls              r3, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r3, #0x1b
        str               r1, [sp, #0x4]
        lsls              r4, r1
        lsls              r2, r1
        mvns              r1, r2
        str               r1, [sp, #0x8]
        movs              r2, r0
        ldr               r7, [pc, #0x20]         @ 2f
        ldr               r6, [sp, #0x8]
0:
        ldr               r5, [r2]
        movs              r0, r5
        movs              r1, r5
        ands              r1, r6
        orrs              r1, r4
        blx               r7
        blo               0b
        ldr               r0, [sp, #0x4]
        lsrs              r5, r0
        movs              r0, r5
        add               sp, #0xc
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
1:
        .word             0x0000ffff
2:
        .word             0xffff0fc0

asm_test::swap::u16::relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r1
        movs              r1, #0x3
        ldr               r2, [pc, #0x30]         @ 1f
        ands              r4, r2
        lsls              r3, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r3, #0x1b
        str               r1, [sp, #0x4]
        lsls              r4, r1
        lsls              r2, r1
        mvns              r1, r2
        str               r1, [sp, #0x8]
        movs              r2, r0
        ldr               r7, [pc, #0x20]         @ 2f
        ldr               r6, [sp, #0x8]
0:
        ldr               r5, [r2]
        movs              r0, r5
        movs              r1, r5
        ands              r1, r6
        orrs              r1, r4
        blx               r7
        blo               0b
        ldr               r0, [sp, #0x4]
        lsrs              r5, r0
        movs              r0, r5
        add               sp, #0xc
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
1:
        .word             0x0000ffff
2:
        .word             0xffff0fc0

asm_test::swap::u16::release:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r1
        movs              r1, #0x3
        ldr               r2, [pc, #0x30]         @ 1f
        ands              r4, r2
        lsls              r3, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r3, #0x1b
        str               r1, [sp, #0x4]
        lsls              r4, r1
        lsls              r2, r1
        mvns              r1, r2
        str               r1, [sp, #0x8]
        movs              r2, r0
        ldr               r7, [pc, #0x20]         @ 2f
        ldr               r6, [sp, #0x8]
0:
        ldr               r5, [r2]
        movs              r0, r5
        movs              r1, r5
        ands              r1, r6
        orrs              r1, r4
        blx               r7
        blo               0b
        ldr               r0, [sp, #0x4]
        lsrs              r5, r0
        movs              r0, r5
        add               sp, #0xc
        pop               {r4, r5, r6, r7, pc}
        mov               r8, r8
1:
        .word             0x0000ffff
2:
        .word             0xffff0fc0

asm_test::swap::u32::acqrel:
        push              {r4, r5, r7, lr}
        ldr               r5, [pc, #0x10]         @ 1f
        movs              r2, r0
0:
        ldr               r4, [r2]
        movs              r0, r4
        blx               r5
        blo               0b
        movs              r0, r4
        pop               {r4, r5, r7, pc}
        mov               r8, r8
1:
        .word             0xffff0fc0

asm_test::swap::u32::seqcst:
        push              {r4, r5, r7, lr}
        ldr               r5, [pc, #0x10]         @ 1f
        movs              r2, r0
0:
        ldr               r4, [r2]
        movs              r0, r4
        blx               r5
        blo               0b
        movs              r0, r4
        pop               {r4, r5, r7, pc}
        mov               r8, r8
1:
        .word             0xffff0fc0

asm_test::swap::u32::acquire:
        push              {r4, r5, r7, lr}
        ldr               r5, [pc, #0x10]         @ 1f
        movs              r2, r0
0:
        ldr               r4, [r2]
        movs              r0, r4
        blx               r5
        blo               0b
        movs              r0, r4
        pop               {r4, r5, r7, pc}
        mov               r8, r8
1:
        .word             0xffff0fc0

asm_test::swap::u32::relaxed:
        push              {r4, r5, r7, lr}
        ldr               r5, [pc, #0x10]         @ 1f
        movs              r2, r0
0:
        ldr               r4, [r2]
        movs              r0, r4
        blx               r5
        blo               0b
        movs              r0, r4
        pop               {r4, r5, r7, pc}
        mov               r8, r8
1:
        .word             0xffff0fc0

asm_test::swap::u32::release:
        push              {r4, r5, r7, lr}
        ldr               r5, [pc, #0x10]         @ 1f
        movs              r2, r0
0:
        ldr               r4, [r2]
        movs              r0, r4
        blx               r5
        blo               0b
        movs              r0, r4
        pop               {r4, r5, r7, pc}
        mov               r8, r8
1:
        .word             0xffff0fc0

asm_test::swap::u64::acqrel:
        push              {r4, r5, r6, lr}
        sub               sp, #0x10
        str               r3, [sp, #0x4]
        str               r2, [sp]
        ldr               r1, [pc, #0x28]         @ 2f
        ldr               r1, [r1]
        cmp               r1, #0x5
        blt               1f
        add               r4, sp, #0x8
        mov               r5, sp
        ldr               r6, [pc, #0x20]         @ 3f
        movs              r2, r0
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        movs              r0, r4
        movs              r1, r5
        blx               r6
        blo               0b
        ldr               r1, [sp, #0xc]
        ldr               r0, [sp, #0x8]
        add               sp, #0x10
        pop               {r4, r5, r6, pc}
1:
        bl                1f
2:
        .word             0xffff0ffc
3:
        .word             0xffff0f60

asm_test::swap::u64::seqcst:
        push              {r4, r5, r6, lr}
        sub               sp, #0x10
        str               r3, [sp, #0x4]
        str               r2, [sp]
        ldr               r1, [pc, #0x28]         @ 2f
        ldr               r1, [r1]
        cmp               r1, #0x5
        blt               1f
        add               r4, sp, #0x8
        mov               r5, sp
        ldr               r6, [pc, #0x20]         @ 3f
        movs              r2, r0
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        movs              r0, r4
        movs              r1, r5
        blx               r6
        blo               0b
        ldr               r1, [sp, #0xc]
        ldr               r0, [sp, #0x8]
        add               sp, #0x10
        pop               {r4, r5, r6, pc}
1:
        bl                1f
2:
        .word             0xffff0ffc
3:
        .word             0xffff0f60

asm_test::swap::u64::acquire:
        push              {r4, r5, r6, lr}
        sub               sp, #0x10
        str               r3, [sp, #0x4]
        str               r2, [sp]
        ldr               r1, [pc, #0x28]         @ 2f
        ldr               r1, [r1]
        cmp               r1, #0x5
        blt               1f
        add               r4, sp, #0x8
        mov               r5, sp
        ldr               r6, [pc, #0x20]         @ 3f
        movs              r2, r0
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        movs              r0, r4
        movs              r1, r5
        blx               r6
        blo               0b
        ldr               r1, [sp, #0xc]
        ldr               r0, [sp, #0x8]
        add               sp, #0x10
        pop               {r4, r5, r6, pc}
1:
        bl                1f
2:
        .word             0xffff0ffc
3:
        .word             0xffff0f60

asm_test::swap::u64::relaxed:
        push              {r4, r5, r6, lr}
        sub               sp, #0x10
        str               r3, [sp, #0x4]
        str               r2, [sp]
        ldr               r1, [pc, #0x28]         @ 2f
        ldr               r1, [r1]
        cmp               r1, #0x5
        blt               1f
        add               r4, sp, #0x8
        mov               r5, sp
        ldr               r6, [pc, #0x20]         @ 3f
        movs              r2, r0
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        movs              r0, r4
        movs              r1, r5
        blx               r6
        blo               0b
        ldr               r1, [sp, #0xc]
        ldr               r0, [sp, #0x8]
        add               sp, #0x10
        pop               {r4, r5, r6, pc}
1:
        bl                1f
2:
        .word             0xffff0ffc
3:
        .word             0xffff0f60

asm_test::swap::u64::release:
        push              {r4, r5, r6, lr}
        sub               sp, #0x10
        str               r3, [sp, #0x4]
        str               r2, [sp]
        ldr               r1, [pc, #0x28]         @ 2f
        ldr               r1, [r1]
        cmp               r1, #0x5
        blt               1f
        add               r4, sp, #0x8
        mov               r5, sp
        ldr               r6, [pc, #0x20]         @ 3f
        movs              r2, r0
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        movs              r0, r4
        movs              r1, r5
        blx               r6
        blo               0b
        ldr               r1, [sp, #0xc]
        ldr               r0, [sp, #0x8]
        add               sp, #0x10
        pop               {r4, r5, r6, pc}
1:
        bl                1f
2:
        .word             0xffff0ffc
3:
        .word             0xffff0f60

asm_test::store::u8::seqcst:
        push              {r7, lr}
        ldr               r2, [pc, #0x8]          @ 0f
        blx               r2
        strb              r1, [r0]
        blx               r2
        pop               {r7, pc}
0:
        .word             0xffff0fa0

asm_test::store::u8::relaxed:
        strb              r1, [r0]
        bx                lr

asm_test::store::u8::release:
        push              {r7, lr}
        ldr               r2, [pc, #0x8]          @ 0f
        blx               r2
        strb              r1, [r0]
        pop               {r7, pc}
        mov               r8, r8
0:
        .word             0xffff0fa0

asm_test::store::u16::seqcst:
        push              {r7, lr}
        ldr               r2, [pc, #0x8]          @ 0f
        blx               r2
        strh              r1, [r0]
        blx               r2
        pop               {r7, pc}
0:
        .word             0xffff0fa0

asm_test::store::u16::relaxed:
        strh              r1, [r0]
        bx                lr

asm_test::store::u16::release:
        push              {r7, lr}
        ldr               r2, [pc, #0x8]          @ 0f
        blx               r2
        strh              r1, [r0]
        pop               {r7, pc}
        mov               r8, r8
0:
        .word             0xffff0fa0

asm_test::store::u32::seqcst:
        push              {r7, lr}
        ldr               r2, [pc, #0x8]          @ 0f
        blx               r2
        str               r1, [r0]
        blx               r2
        pop               {r7, pc}
0:
        .word             0xffff0fa0

asm_test::store::u32::relaxed:
        str               r1, [r0]
        bx                lr

asm_test::store::u32::release:
        push              {r7, lr}
        ldr               r2, [pc, #0x8]          @ 0f
        blx               r2
        str               r1, [r0]
        pop               {r7, pc}
        mov               r8, r8
0:
        .word             0xffff0fa0

asm_test::store::u64::seqcst:
        push              {r4, r5, r6, lr}
        sub               sp, #0x10
        str               r3, [sp, #0x4]
        str               r2, [sp]
        ldr               r1, [pc, #0x24]         @ 2f
        ldr               r1, [r1]
        cmp               r1, #0x5
        blt               1f
        add               r4, sp, #0x8
        mov               r5, sp
        ldr               r6, [pc, #0x1c]         @ 3f
        movs              r2, r0
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        movs              r0, r4
        movs              r1, r5
        blx               r6
        blo               0b
        add               sp, #0x10
        pop               {r4, r5, r6, pc}
1:
        bl                1f
2:
        .word             0xffff0ffc
3:
        .word             0xffff0f60

asm_test::store::u64::relaxed:
        push              {r4, r5, r6, lr}
        sub               sp, #0x10
        str               r3, [sp, #0x4]
        str               r2, [sp]
        ldr               r1, [pc, #0x24]         @ 2f
        ldr               r1, [r1]
        cmp               r1, #0x5
        blt               1f
        add               r4, sp, #0x8
        mov               r5, sp
        ldr               r6, [pc, #0x1c]         @ 3f
        movs              r2, r0
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        movs              r0, r4
        movs              r1, r5
        blx               r6
        blo               0b
        add               sp, #0x10
        pop               {r4, r5, r6, pc}
1:
        bl                1f
2:
        .word             0xffff0ffc
3:
        .word             0xffff0f60

asm_test::store::u64::release:
        push              {r4, r5, r6, lr}
        sub               sp, #0x10
        str               r3, [sp, #0x4]
        str               r2, [sp]
        ldr               r1, [pc, #0x24]         @ 2f
        ldr               r1, [r1]
        cmp               r1, #0x5
        blt               1f
        add               r4, sp, #0x8
        mov               r5, sp
        ldr               r6, [pc, #0x1c]         @ 3f
        movs              r2, r0
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        movs              r0, r4
        movs              r1, r5
        blx               r6
        blo               0b
        add               sp, #0x10
        pop               {r4, r5, r6, pc}
1:
        bl                1f
2:
        .word             0xffff0ffc
3:
        .word             0xffff0f60
