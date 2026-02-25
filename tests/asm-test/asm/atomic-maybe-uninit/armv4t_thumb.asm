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
        ldr               r3, [pc, #0x48]         @ 7f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
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
        ldr               r3, [pc, #0x48]         @ 7f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
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
        ldr               r3, [pc, #0x48]         @ 7f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
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
        ldr               r3, [pc, #0x48]         @ 7f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
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
        ldr               r3, [pc, #0x48]         @ 7f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
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
        ldr               r3, [pc, #0x48]         @ 7f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
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
        ldr               r3, [pc, #0x48]         @ 7f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
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
        ldr               r3, [pc, #0x48]         @ 7f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
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
        ldr               r3, [pc, #0x48]         @ 7f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
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
        ldr               r3, [pc, #0x48]         @ 7f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
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
        ldr               r3, [pc, #0x48]         @ 7f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
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
        ldr               r3, [pc, #0x48]         @ 7f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
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
        ldr               r3, [pc, #0x48]         @ 7f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
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
        ldr               r3, [pc, #0x48]         @ 7f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
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
        ldr               r3, [pc, #0x48]         @ 7f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::acqrel_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x5c]         @ 7f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x4c]         @ 8f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0x0000ffff
8:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::seqcst_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x5c]         @ 7f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x4c]         @ 8f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0x0000ffff
8:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::acqrel_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x5c]         @ 7f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x4c]         @ 8f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0x0000ffff
8:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::acqrel_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x5c]         @ 7f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x4c]         @ 8f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0x0000ffff
8:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::acquire_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x5c]         @ 7f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x4c]         @ 8f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0x0000ffff
8:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::relaxed_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x5c]         @ 7f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x4c]         @ 8f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0x0000ffff
8:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::release_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x5c]         @ 7f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x4c]         @ 8f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0x0000ffff
8:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::seqcst_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x5c]         @ 7f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x4c]         @ 8f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0x0000ffff
8:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::seqcst_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x5c]         @ 7f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x4c]         @ 8f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0x0000ffff
8:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::acquire_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x5c]         @ 7f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x4c]         @ 8f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0x0000ffff
8:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::acquire_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x5c]         @ 7f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x4c]         @ 8f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0x0000ffff
8:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::relaxed_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x5c]         @ 7f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x4c]         @ 8f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0x0000ffff
8:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::relaxed_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x5c]         @ 7f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x4c]         @ 8f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0x0000ffff
8:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::release_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x5c]         @ 7f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x4c]         @ 8f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0x0000ffff
8:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::release_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x5c]         @ 7f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x4c]         @ 8f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0x0000ffff
8:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::acqrel_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x34]         @ 7f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               3f
        movs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r7
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r7
5:
        blo               0b
        movs              r0, #0x1
6:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::seqcst_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x34]         @ 7f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               3f
        movs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r7
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r7
5:
        blo               0b
        movs              r0, #0x1
6:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::acqrel_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x34]         @ 7f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               3f
        movs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r7
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r7
5:
        blo               0b
        movs              r0, #0x1
6:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::acqrel_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x34]         @ 7f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               3f
        movs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r7
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r7
5:
        blo               0b
        movs              r0, #0x1
6:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::acquire_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x34]         @ 7f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               3f
        movs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r7
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r7
5:
        blo               0b
        movs              r0, #0x1
6:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::relaxed_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x34]         @ 7f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               3f
        movs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r7
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r7
5:
        blo               0b
        movs              r0, #0x1
6:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::release_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x34]         @ 7f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               3f
        movs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r7
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r7
5:
        blo               0b
        movs              r0, #0x1
6:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::seqcst_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x34]         @ 7f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               3f
        movs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r7
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r7
5:
        blo               0b
        movs              r0, #0x1
6:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::seqcst_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x34]         @ 7f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               3f
        movs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r7
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r7
5:
        blo               0b
        movs              r0, #0x1
6:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::acquire_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x34]         @ 7f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               3f
        movs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r7
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r7
5:
        blo               0b
        movs              r0, #0x1
6:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::acquire_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x34]         @ 7f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               3f
        movs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r7
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r7
5:
        blo               0b
        movs              r0, #0x1
6:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::relaxed_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x34]         @ 7f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               3f
        movs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r7
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r7
5:
        blo               0b
        movs              r0, #0x1
6:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::relaxed_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x34]         @ 7f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               3f
        movs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r7
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r7
5:
        blo               0b
        movs              r0, #0x1
6:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::release_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x34]         @ 7f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               3f
        movs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r7
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r7
5:
        blo               0b
        movs              r0, #0x1
6:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::release_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x34]         @ 7f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               3f
        movs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r7
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r7
5:
        blo               0b
        movs              r0, #0x1
6:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0xffff0fc0

asm_test::compare_exchange::u64::acqrel_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x5c]         @ 8f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               7f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x50]         @ 9f
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
        bne               3f
        movs              r0, r4
        movs              r1, r7
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r0, r4
        movs              r1, r4
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7}
        pop               {r0}
        bx                r0
7:
        bl                7f
        mov               r8, r8
8:
        .word             0xffff0ffc
9:
        .word             0xffff0f60

asm_test::compare_exchange::u64::seqcst_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x5c]         @ 8f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               7f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x50]         @ 9f
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
        bne               3f
        movs              r0, r4
        movs              r1, r7
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r0, r4
        movs              r1, r4
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7}
        pop               {r0}
        bx                r0
7:
        bl                7f
        mov               r8, r8
8:
        .word             0xffff0ffc
9:
        .word             0xffff0f60

asm_test::compare_exchange::u64::acqrel_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x5c]         @ 8f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               7f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x50]         @ 9f
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
        bne               3f
        movs              r0, r4
        movs              r1, r7
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r0, r4
        movs              r1, r4
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7}
        pop               {r0}
        bx                r0
7:
        bl                7f
        mov               r8, r8
8:
        .word             0xffff0ffc
9:
        .word             0xffff0f60

asm_test::compare_exchange::u64::acqrel_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x5c]         @ 8f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               7f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x50]         @ 9f
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
        bne               3f
        movs              r0, r4
        movs              r1, r7
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r0, r4
        movs              r1, r4
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7}
        pop               {r0}
        bx                r0
7:
        bl                7f
        mov               r8, r8
8:
        .word             0xffff0ffc
9:
        .word             0xffff0f60

asm_test::compare_exchange::u64::acquire_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x5c]         @ 8f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               7f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x50]         @ 9f
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
        bne               3f
        movs              r0, r4
        movs              r1, r7
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r0, r4
        movs              r1, r4
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7}
        pop               {r0}
        bx                r0
7:
        bl                7f
        mov               r8, r8
8:
        .word             0xffff0ffc
9:
        .word             0xffff0f60

asm_test::compare_exchange::u64::relaxed_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x5c]         @ 8f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               7f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x50]         @ 9f
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
        bne               3f
        movs              r0, r4
        movs              r1, r7
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r0, r4
        movs              r1, r4
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7}
        pop               {r0}
        bx                r0
7:
        bl                7f
        mov               r8, r8
8:
        .word             0xffff0ffc
9:
        .word             0xffff0f60

asm_test::compare_exchange::u64::release_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x5c]         @ 8f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               7f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x50]         @ 9f
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
        bne               3f
        movs              r0, r4
        movs              r1, r7
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r0, r4
        movs              r1, r4
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7}
        pop               {r0}
        bx                r0
7:
        bl                7f
        mov               r8, r8
8:
        .word             0xffff0ffc
9:
        .word             0xffff0f60

asm_test::compare_exchange::u64::seqcst_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x5c]         @ 8f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               7f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x50]         @ 9f
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
        bne               3f
        movs              r0, r4
        movs              r1, r7
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r0, r4
        movs              r1, r4
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7}
        pop               {r0}
        bx                r0
7:
        bl                7f
        mov               r8, r8
8:
        .word             0xffff0ffc
9:
        .word             0xffff0f60

asm_test::compare_exchange::u64::seqcst_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x5c]         @ 8f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               7f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x50]         @ 9f
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
        bne               3f
        movs              r0, r4
        movs              r1, r7
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r0, r4
        movs              r1, r4
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7}
        pop               {r0}
        bx                r0
7:
        bl                7f
        mov               r8, r8
8:
        .word             0xffff0ffc
9:
        .word             0xffff0f60

asm_test::compare_exchange::u64::acquire_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x5c]         @ 8f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               7f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x50]         @ 9f
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
        bne               3f
        movs              r0, r4
        movs              r1, r7
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r0, r4
        movs              r1, r4
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7}
        pop               {r0}
        bx                r0
7:
        bl                7f
        mov               r8, r8
8:
        .word             0xffff0ffc
9:
        .word             0xffff0f60

asm_test::compare_exchange::u64::acquire_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x5c]         @ 8f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               7f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x50]         @ 9f
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
        bne               3f
        movs              r0, r4
        movs              r1, r7
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r0, r4
        movs              r1, r4
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7}
        pop               {r0}
        bx                r0
7:
        bl                7f
        mov               r8, r8
8:
        .word             0xffff0ffc
9:
        .word             0xffff0f60

asm_test::compare_exchange::u64::relaxed_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x5c]         @ 8f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               7f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x50]         @ 9f
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
        bne               3f
        movs              r0, r4
        movs              r1, r7
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r0, r4
        movs              r1, r4
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7}
        pop               {r0}
        bx                r0
7:
        bl                7f
        mov               r8, r8
8:
        .word             0xffff0ffc
9:
        .word             0xffff0f60

asm_test::compare_exchange::u64::relaxed_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x5c]         @ 8f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               7f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x50]         @ 9f
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
        bne               3f
        movs              r0, r4
        movs              r1, r7
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r0, r4
        movs              r1, r4
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7}
        pop               {r0}
        bx                r0
7:
        bl                7f
        mov               r8, r8
8:
        .word             0xffff0ffc
9:
        .word             0xffff0f60

asm_test::compare_exchange::u64::release_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x5c]         @ 8f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               7f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x50]         @ 9f
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
        bne               3f
        movs              r0, r4
        movs              r1, r7
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r0, r4
        movs              r1, r4
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7}
        pop               {r0}
        bx                r0
7:
        bl                7f
        mov               r8, r8
8:
        .word             0xffff0ffc
9:
        .word             0xffff0f60

asm_test::compare_exchange::u64::release_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x5c]         @ 8f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               7f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x50]         @ 9f
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
        bne               3f
        movs              r0, r4
        movs              r1, r7
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r0, r4
        movs              r1, r4
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7}
        pop               {r0}
        bx                r0
7:
        bl                7f
        mov               r8, r8
8:
        .word             0xffff0ffc
9:
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
        ldr               r3, [pc, #0x48]         @ 7f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
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
        ldr               r3, [pc, #0x48]         @ 7f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
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
        ldr               r3, [pc, #0x48]         @ 7f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
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
        ldr               r3, [pc, #0x48]         @ 7f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
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
        ldr               r3, [pc, #0x48]         @ 7f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
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
        ldr               r3, [pc, #0x48]         @ 7f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
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
        ldr               r3, [pc, #0x48]         @ 7f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
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
        ldr               r3, [pc, #0x48]         @ 7f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
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
        ldr               r3, [pc, #0x48]         @ 7f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
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
        ldr               r3, [pc, #0x48]         @ 7f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
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
        ldr               r3, [pc, #0x48]         @ 7f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
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
        ldr               r3, [pc, #0x48]         @ 7f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
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
        ldr               r3, [pc, #0x48]         @ 7f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
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
        ldr               r3, [pc, #0x48]         @ 7f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
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
        ldr               r3, [pc, #0x48]         @ 7f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x5c]         @ 7f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x4c]         @ 8f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0x0000ffff
8:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x5c]         @ 7f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x4c]         @ 8f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0x0000ffff
8:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x5c]         @ 7f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x4c]         @ 8f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0x0000ffff
8:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x5c]         @ 7f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x4c]         @ 8f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0x0000ffff
8:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x5c]         @ 7f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x4c]         @ 8f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0x0000ffff
8:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x5c]         @ 7f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x4c]         @ 8f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0x0000ffff
8:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::release_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x5c]         @ 7f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x4c]         @ 8f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0x0000ffff
8:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x5c]         @ 7f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x4c]         @ 8f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0x0000ffff
8:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x5c]         @ 7f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x4c]         @ 8f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0x0000ffff
8:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::acquire_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x5c]         @ 7f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x4c]         @ 8f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0x0000ffff
8:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x5c]         @ 7f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x4c]         @ 8f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0x0000ffff
8:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x5c]         @ 7f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x4c]         @ 8f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0x0000ffff
8:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x5c]         @ 7f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x4c]         @ 8f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0x0000ffff
8:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::release_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x5c]         @ 7f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x4c]         @ 8f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0x0000ffff
8:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::release_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        movs              r1, #0x3
        ldr               r7, [pc, #0x5c]         @ 7f
        ands              r5, r7
        lsls              r2, r0, #0x1e
        bics              r0, r1
        lsrs              r1, r2, #0x1b
        str               r1, [sp]
        lsls              r5, r1
        ands              r4, r7
        lsls              r4, r1
        lsls              r7, r1
        ldr               r3, [pc, #0x4c]         @ 8f
        movs              r2, r0
        sub               sp, #0x8
        str               r3, [sp]
0:
        ldr               r3, [sp]
        ldr               r0, [r2]
        movs              r6, r0
        ands              r6, r7
        cmp               r6, r5
        bne               3f
        mvns              r1, r7
        ands              r1, r0
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        rsbs              r1, r0, #0
        adcs              r1, r0
        ldr               r0, [sp]
        lsrs              r6, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0x0000ffff
8:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x34]         @ 7f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               3f
        movs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r7
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r7
5:
        blo               0b
        movs              r0, #0x1
6:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x34]         @ 7f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               3f
        movs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r7
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r7
5:
        blo               0b
        movs              r0, #0x1
6:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x34]         @ 7f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               3f
        movs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r7
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r7
5:
        blo               0b
        movs              r0, #0x1
6:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x34]         @ 7f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               3f
        movs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r7
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r7
5:
        blo               0b
        movs              r0, #0x1
6:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x34]         @ 7f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               3f
        movs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r7
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r7
5:
        blo               0b
        movs              r0, #0x1
6:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x34]         @ 7f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               3f
        movs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r7
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r7
5:
        blo               0b
        movs              r0, #0x1
6:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::release_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x34]         @ 7f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               3f
        movs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r7
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r7
5:
        blo               0b
        movs              r0, #0x1
6:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x34]         @ 7f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               3f
        movs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r7
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r7
5:
        blo               0b
        movs              r0, #0x1
6:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x34]         @ 7f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               3f
        movs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r7
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r7
5:
        blo               0b
        movs              r0, #0x1
6:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::acquire_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x34]         @ 7f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               3f
        movs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r7
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r7
5:
        blo               0b
        movs              r0, #0x1
6:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x34]         @ 7f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               3f
        movs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r7
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r7
5:
        blo               0b
        movs              r0, #0x1
6:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x34]         @ 7f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               3f
        movs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r7
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r7
5:
        blo               0b
        movs              r0, #0x1
6:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x34]         @ 7f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               3f
        movs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r7
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r7
5:
        blo               0b
        movs              r0, #0x1
6:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::release_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x34]         @ 7f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               3f
        movs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r7
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r7
5:
        blo               0b
        movs              r0, #0x1
6:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::release_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0x4
        movs              r4, r2
        movs              r5, r1
        ldr               r7, [pc, #0x34]         @ 7f
        movs              r2, r0
0:
        ldr               r6, [r2]
        movs              r0, r6
        cmp               r6, r5
        bne               3f
        movs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r7
2:
        blo               0b
        b                 6f
3:
        movs              r1, r0
        bl                4f
        b                 5f
4:
        bx                r7
5:
        blo               0b
        movs              r0, #0x1
6:
        rsbs              r1, r0, #0
        adcs              r1, r0
        movs              r0, r6
        add               sp, #0x4
        pop               {r4, r5, r6, r7}
        pop               {r2}
        bx                r2
        mov               r8, r8
7:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u64::acqrel_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x5c]         @ 8f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               7f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x50]         @ 9f
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
        bne               3f
        movs              r0, r4
        movs              r1, r7
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r0, r4
        movs              r1, r4
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7}
        pop               {r0}
        bx                r0
7:
        bl                7f
        mov               r8, r8
8:
        .word             0xffff0ffc
9:
        .word             0xffff0f60

asm_test::compare_exchange_weak::u64::seqcst_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x5c]         @ 8f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               7f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x50]         @ 9f
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
        bne               3f
        movs              r0, r4
        movs              r1, r7
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r0, r4
        movs              r1, r4
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7}
        pop               {r0}
        bx                r0
7:
        bl                7f
        mov               r8, r8
8:
        .word             0xffff0ffc
9:
        .word             0xffff0f60

asm_test::compare_exchange_weak::u64::acqrel_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x5c]         @ 8f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               7f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x50]         @ 9f
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
        bne               3f
        movs              r0, r4
        movs              r1, r7
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r0, r4
        movs              r1, r4
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7}
        pop               {r0}
        bx                r0
7:
        bl                7f
        mov               r8, r8
8:
        .word             0xffff0ffc
9:
        .word             0xffff0f60

asm_test::compare_exchange_weak::u64::acqrel_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x5c]         @ 8f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               7f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x50]         @ 9f
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
        bne               3f
        movs              r0, r4
        movs              r1, r7
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r0, r4
        movs              r1, r4
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7}
        pop               {r0}
        bx                r0
7:
        bl                7f
        mov               r8, r8
8:
        .word             0xffff0ffc
9:
        .word             0xffff0f60

asm_test::compare_exchange_weak::u64::acquire_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x5c]         @ 8f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               7f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x50]         @ 9f
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
        bne               3f
        movs              r0, r4
        movs              r1, r7
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r0, r4
        movs              r1, r4
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7}
        pop               {r0}
        bx                r0
7:
        bl                7f
        mov               r8, r8
8:
        .word             0xffff0ffc
9:
        .word             0xffff0f60

asm_test::compare_exchange_weak::u64::relaxed_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x5c]         @ 8f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               7f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x50]         @ 9f
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
        bne               3f
        movs              r0, r4
        movs              r1, r7
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r0, r4
        movs              r1, r4
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7}
        pop               {r0}
        bx                r0
7:
        bl                7f
        mov               r8, r8
8:
        .word             0xffff0ffc
9:
        .word             0xffff0f60

asm_test::compare_exchange_weak::u64::release_seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x5c]         @ 8f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               7f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x50]         @ 9f
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
        bne               3f
        movs              r0, r4
        movs              r1, r7
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r0, r4
        movs              r1, r4
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7}
        pop               {r0}
        bx                r0
7:
        bl                7f
        mov               r8, r8
8:
        .word             0xffff0ffc
9:
        .word             0xffff0f60

asm_test::compare_exchange_weak::u64::seqcst_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x5c]         @ 8f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               7f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x50]         @ 9f
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
        bne               3f
        movs              r0, r4
        movs              r1, r7
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r0, r4
        movs              r1, r4
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7}
        pop               {r0}
        bx                r0
7:
        bl                7f
        mov               r8, r8
8:
        .word             0xffff0ffc
9:
        .word             0xffff0f60

asm_test::compare_exchange_weak::u64::seqcst_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x5c]         @ 8f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               7f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x50]         @ 9f
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
        bne               3f
        movs              r0, r4
        movs              r1, r7
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r0, r4
        movs              r1, r4
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7}
        pop               {r0}
        bx                r0
7:
        bl                7f
        mov               r8, r8
8:
        .word             0xffff0ffc
9:
        .word             0xffff0f60

asm_test::compare_exchange_weak::u64::acquire_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x5c]         @ 8f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               7f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x50]         @ 9f
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
        bne               3f
        movs              r0, r4
        movs              r1, r7
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r0, r4
        movs              r1, r4
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7}
        pop               {r0}
        bx                r0
7:
        bl                7f
        mov               r8, r8
8:
        .word             0xffff0ffc
9:
        .word             0xffff0f60

asm_test::compare_exchange_weak::u64::acquire_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x5c]         @ 8f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               7f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x50]         @ 9f
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
        bne               3f
        movs              r0, r4
        movs              r1, r7
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r0, r4
        movs              r1, r4
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7}
        pop               {r0}
        bx                r0
7:
        bl                7f
        mov               r8, r8
8:
        .word             0xffff0ffc
9:
        .word             0xffff0f60

asm_test::compare_exchange_weak::u64::relaxed_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x5c]         @ 8f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               7f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x50]         @ 9f
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
        bne               3f
        movs              r0, r4
        movs              r1, r7
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r0, r4
        movs              r1, r4
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7}
        pop               {r0}
        bx                r0
7:
        bl                7f
        mov               r8, r8
8:
        .word             0xffff0ffc
9:
        .word             0xffff0f60

asm_test::compare_exchange_weak::u64::relaxed_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x5c]         @ 8f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               7f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x50]         @ 9f
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
        bne               3f
        movs              r0, r4
        movs              r1, r7
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r0, r4
        movs              r1, r4
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7}
        pop               {r0}
        bx                r0
7:
        bl                7f
        mov               r8, r8
8:
        .word             0xffff0ffc
9:
        .word             0xffff0f60

asm_test::compare_exchange_weak::u64::release_acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x5c]         @ 8f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               7f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x50]         @ 9f
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
        bne               3f
        movs              r0, r4
        movs              r1, r7
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r0, r4
        movs              r1, r4
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7}
        pop               {r0}
        bx                r0
7:
        bl                7f
        mov               r8, r8
8:
        .word             0xffff0ffc
9:
        .word             0xffff0f60

asm_test::compare_exchange_weak::u64::release_relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        ldr               r0, [pc, #0x5c]         @ 8f
        ldr               r0, [r0]
        cmp               r0, #0x4
        ble               7f
        movs              r5, r3
        movs              r6, r2
        mov               r7, sp
        ldr               r3, [pc, #0x50]         @ 9f
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
        bne               3f
        movs              r0, r4
        movs              r1, r7
        bl                1f
        b                 2f
1:
        bx                r3
2:
        blo               0b
        b                 6f
3:
        movs              r0, r4
        movs              r1, r4
        bl                4f
        b                 5f
4:
        bx                r3
5:
        blo               0b
        movs              r0, #0x1
6:
        add               sp, #0x8
        movs              r1, #0x1
        eors              r1, r0
        strb              r1, [r4, #0x8]
        add               sp, #0xc
        pop               {r4, r5, r6, r7}
        pop               {r0}
        bx                r0
7:
        bl                7f
        mov               r8, r8
8:
        .word             0xffff0ffc
9:
        .word             0xffff0f60

asm_test::load::u8::seqcst:
        push              {r7, lr}
        ldr               r1, [pc, #0x10]         @ 2f
        ldrb              r0, [r0]
        bl                0f
        b                 1f
0:
        bx                r1
1:
        pop               {r7}
        pop               {r1}
        bx                r1
2:
        .word             0xffff0fa0

asm_test::load::u8::acquire:
        push              {r7, lr}
        ldr               r1, [pc, #0x10]         @ 2f
        ldrb              r0, [r0]
        bl                0f
        b                 1f
0:
        bx                r1
1:
        pop               {r7}
        pop               {r1}
        bx                r1
2:
        .word             0xffff0fa0

asm_test::load::u8::relaxed:
        ldrb              r0, [r0]
        bx                lr

asm_test::load::u16::seqcst:
        push              {r7, lr}
        ldr               r1, [pc, #0x10]         @ 2f
        ldrh              r0, [r0]
        bl                0f
        b                 1f
0:
        bx                r1
1:
        pop               {r7}
        pop               {r1}
        bx                r1
2:
        .word             0xffff0fa0

asm_test::load::u16::acquire:
        push              {r7, lr}
        ldr               r1, [pc, #0x10]         @ 2f
        ldrh              r0, [r0]
        bl                0f
        b                 1f
0:
        bx                r1
1:
        pop               {r7}
        pop               {r1}
        bx                r1
2:
        .word             0xffff0fa0

asm_test::load::u16::relaxed:
        ldrh              r0, [r0]
        bx                lr

asm_test::load::u32::seqcst:
        push              {r7, lr}
        ldr               r1, [pc, #0x10]         @ 2f
        ldr               r0, [r0]
        bl                0f
        b                 1f
0:
        bx                r1
1:
        pop               {r7}
        pop               {r1}
        bx                r1
2:
        .word             0xffff0fa0

asm_test::load::u32::acquire:
        push              {r7, lr}
        ldr               r1, [pc, #0x10]         @ 2f
        ldr               r0, [r0]
        bl                0f
        b                 1f
0:
        bx                r1
1:
        pop               {r7}
        pop               {r1}
        bx                r1
2:
        .word             0xffff0fa0

asm_test::load::u32::relaxed:
        ldr               r0, [r0]
        bx                lr

asm_test::load::u64::seqcst:
        push              {r4, r5, r7, lr}
        sub               sp, #0x8
        ldr               r1, [pc, #0x30]         @ 4f
        ldr               r1, [r1]
        cmp               r1, #0x5
        blt               3f
        mov               r4, sp
        ldr               r5, [pc, #0x2c]         @ 5f
        movs              r2, r0
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        movs              r0, r4
        movs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r5
2:
        blo               0b
        ldr               r1, [sp, #0x4]
        ldr               r0, [sp]
        add               sp, #0x8
        pop               {r4, r5, r7}
        pop               {r2}
        bx                r2
3:
        bl                3f
4:
        .word             0xffff0ffc
5:
        .word             0xffff0f60

asm_test::load::u64::acquire:
        push              {r4, r5, r7, lr}
        sub               sp, #0x8
        ldr               r1, [pc, #0x30]         @ 4f
        ldr               r1, [r1]
        cmp               r1, #0x5
        blt               3f
        mov               r4, sp
        ldr               r5, [pc, #0x2c]         @ 5f
        movs              r2, r0
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        movs              r0, r4
        movs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r5
2:
        blo               0b
        ldr               r1, [sp, #0x4]
        ldr               r0, [sp]
        add               sp, #0x8
        pop               {r4, r5, r7}
        pop               {r2}
        bx                r2
3:
        bl                3f
4:
        .word             0xffff0ffc
5:
        .word             0xffff0f60

asm_test::load::u64::relaxed:
        push              {r4, r5, r7, lr}
        sub               sp, #0x8
        ldr               r1, [pc, #0x30]         @ 4f
        ldr               r1, [r1]
        cmp               r1, #0x5
        blt               3f
        mov               r4, sp
        ldr               r5, [pc, #0x2c]         @ 5f
        movs              r2, r0
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        movs              r0, r4
        movs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r5
2:
        blo               0b
        ldr               r1, [sp, #0x4]
        ldr               r0, [sp]
        add               sp, #0x8
        pop               {r4, r5, r7}
        pop               {r2}
        bx                r2
3:
        bl                3f
4:
        .word             0xffff0ffc
5:
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
        ldr               r7, [pc, #0x24]         @ 3f
        ldr               r6, [sp, #0x8]
0:
        ldr               r5, [r2]
        movs              r0, r5
        movs              r1, r0
        ands              r1, r6
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r7
2:
        blo               0b
        ldr               r0, [sp, #0x4]
        lsrs              r5, r0
        movs              r0, r5
        add               sp, #0xc
        pop               {r4, r5, r6, r7}
        pop               {r1}
        bx                r1
3:
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
        ldr               r7, [pc, #0x24]         @ 3f
        ldr               r6, [sp, #0x8]
0:
        ldr               r5, [r2]
        movs              r0, r5
        movs              r1, r0
        ands              r1, r6
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r7
2:
        blo               0b
        ldr               r0, [sp, #0x4]
        lsrs              r5, r0
        movs              r0, r5
        add               sp, #0xc
        pop               {r4, r5, r6, r7}
        pop               {r1}
        bx                r1
3:
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
        ldr               r7, [pc, #0x24]         @ 3f
        ldr               r6, [sp, #0x8]
0:
        ldr               r5, [r2]
        movs              r0, r5
        movs              r1, r0
        ands              r1, r6
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r7
2:
        blo               0b
        ldr               r0, [sp, #0x4]
        lsrs              r5, r0
        movs              r0, r5
        add               sp, #0xc
        pop               {r4, r5, r6, r7}
        pop               {r1}
        bx                r1
3:
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
        ldr               r7, [pc, #0x24]         @ 3f
        ldr               r6, [sp, #0x8]
0:
        ldr               r5, [r2]
        movs              r0, r5
        movs              r1, r0
        ands              r1, r6
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r7
2:
        blo               0b
        ldr               r0, [sp, #0x4]
        lsrs              r5, r0
        movs              r0, r5
        add               sp, #0xc
        pop               {r4, r5, r6, r7}
        pop               {r1}
        bx                r1
3:
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
        ldr               r7, [pc, #0x24]         @ 3f
        ldr               r6, [sp, #0x8]
0:
        ldr               r5, [r2]
        movs              r0, r5
        movs              r1, r0
        ands              r1, r6
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r7
2:
        blo               0b
        ldr               r0, [sp, #0x4]
        lsrs              r5, r0
        movs              r0, r5
        add               sp, #0xc
        pop               {r4, r5, r6, r7}
        pop               {r1}
        bx                r1
3:
        .word             0xffff0fc0

asm_test::swap::u16::acqrel:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r1
        movs              r1, #0x3
        ldr               r2, [pc, #0x38]         @ 3f
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
        ldr               r7, [pc, #0x28]         @ 4f
        ldr               r6, [sp, #0x8]
0:
        ldr               r5, [r2]
        movs              r0, r5
        movs              r1, r0
        ands              r1, r6
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r7
2:
        blo               0b
        ldr               r0, [sp, #0x4]
        lsrs              r5, r0
        movs              r0, r5
        add               sp, #0xc
        pop               {r4, r5, r6, r7}
        pop               {r1}
        bx                r1
3:
        .word             0x0000ffff
4:
        .word             0xffff0fc0

asm_test::swap::u16::seqcst:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r1
        movs              r1, #0x3
        ldr               r2, [pc, #0x38]         @ 3f
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
        ldr               r7, [pc, #0x28]         @ 4f
        ldr               r6, [sp, #0x8]
0:
        ldr               r5, [r2]
        movs              r0, r5
        movs              r1, r0
        ands              r1, r6
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r7
2:
        blo               0b
        ldr               r0, [sp, #0x4]
        lsrs              r5, r0
        movs              r0, r5
        add               sp, #0xc
        pop               {r4, r5, r6, r7}
        pop               {r1}
        bx                r1
3:
        .word             0x0000ffff
4:
        .word             0xffff0fc0

asm_test::swap::u16::acquire:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r1
        movs              r1, #0x3
        ldr               r2, [pc, #0x38]         @ 3f
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
        ldr               r7, [pc, #0x28]         @ 4f
        ldr               r6, [sp, #0x8]
0:
        ldr               r5, [r2]
        movs              r0, r5
        movs              r1, r0
        ands              r1, r6
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r7
2:
        blo               0b
        ldr               r0, [sp, #0x4]
        lsrs              r5, r0
        movs              r0, r5
        add               sp, #0xc
        pop               {r4, r5, r6, r7}
        pop               {r1}
        bx                r1
3:
        .word             0x0000ffff
4:
        .word             0xffff0fc0

asm_test::swap::u16::relaxed:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r1
        movs              r1, #0x3
        ldr               r2, [pc, #0x38]         @ 3f
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
        ldr               r7, [pc, #0x28]         @ 4f
        ldr               r6, [sp, #0x8]
0:
        ldr               r5, [r2]
        movs              r0, r5
        movs              r1, r0
        ands              r1, r6
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r7
2:
        blo               0b
        ldr               r0, [sp, #0x4]
        lsrs              r5, r0
        movs              r0, r5
        add               sp, #0xc
        pop               {r4, r5, r6, r7}
        pop               {r1}
        bx                r1
3:
        .word             0x0000ffff
4:
        .word             0xffff0fc0

asm_test::swap::u16::release:
        push              {r4, r5, r6, r7, lr}
        sub               sp, #0xc
        movs              r4, r1
        movs              r1, #0x3
        ldr               r2, [pc, #0x38]         @ 3f
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
        ldr               r7, [pc, #0x28]         @ 4f
        ldr               r6, [sp, #0x8]
0:
        ldr               r5, [r2]
        movs              r0, r5
        movs              r1, r0
        ands              r1, r6
        orrs              r1, r4
        bl                1f
        b                 2f
1:
        bx                r7
2:
        blo               0b
        ldr               r0, [sp, #0x4]
        lsrs              r5, r0
        movs              r0, r5
        add               sp, #0xc
        pop               {r4, r5, r6, r7}
        pop               {r1}
        bx                r1
3:
        .word             0x0000ffff
4:
        .word             0xffff0fc0

asm_test::swap::u32::acqrel:
        push              {r4, r5, r7, lr}
        ldr               r5, [pc, #0x18]         @ 3f
        movs              r2, r0
0:
        ldr               r4, [r2]
        movs              r0, r4
        bl                1f
        b                 2f
1:
        bx                r5
2:
        blo               0b
        movs              r0, r4
        pop               {r4, r5, r7}
        pop               {r1}
        bx                r1
3:
        .word             0xffff0fc0

asm_test::swap::u32::seqcst:
        push              {r4, r5, r7, lr}
        ldr               r5, [pc, #0x18]         @ 3f
        movs              r2, r0
0:
        ldr               r4, [r2]
        movs              r0, r4
        bl                1f
        b                 2f
1:
        bx                r5
2:
        blo               0b
        movs              r0, r4
        pop               {r4, r5, r7}
        pop               {r1}
        bx                r1
3:
        .word             0xffff0fc0

asm_test::swap::u32::acquire:
        push              {r4, r5, r7, lr}
        ldr               r5, [pc, #0x18]         @ 3f
        movs              r2, r0
0:
        ldr               r4, [r2]
        movs              r0, r4
        bl                1f
        b                 2f
1:
        bx                r5
2:
        blo               0b
        movs              r0, r4
        pop               {r4, r5, r7}
        pop               {r1}
        bx                r1
3:
        .word             0xffff0fc0

asm_test::swap::u32::relaxed:
        push              {r4, r5, r7, lr}
        ldr               r5, [pc, #0x18]         @ 3f
        movs              r2, r0
0:
        ldr               r4, [r2]
        movs              r0, r4
        bl                1f
        b                 2f
1:
        bx                r5
2:
        blo               0b
        movs              r0, r4
        pop               {r4, r5, r7}
        pop               {r1}
        bx                r1
3:
        .word             0xffff0fc0

asm_test::swap::u32::release:
        push              {r4, r5, r7, lr}
        ldr               r5, [pc, #0x18]         @ 3f
        movs              r2, r0
0:
        ldr               r4, [r2]
        movs              r0, r4
        bl                1f
        b                 2f
1:
        bx                r5
2:
        blo               0b
        movs              r0, r4
        pop               {r4, r5, r7}
        pop               {r1}
        bx                r1
3:
        .word             0xffff0fc0

asm_test::swap::u64::acqrel:
        push              {r4, r5, r6, lr}
        sub               sp, #0x10
        str               r3, [sp, #0x4]
        str               r2, [sp]
        ldr               r1, [pc, #0x34]         @ 4f
        ldr               r1, [r1]
        cmp               r1, #0x5
        blt               3f
        add               r4, sp, #0x8
        mov               r5, sp
        ldr               r6, [pc, #0x2c]         @ 5f
        movs              r2, r0
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        movs              r0, r4
        movs              r1, r5
        bl                1f
        b                 2f
1:
        bx                r6
2:
        blo               0b
        ldr               r1, [sp, #0xc]
        ldr               r0, [sp, #0x8]
        add               sp, #0x10
        pop               {r4, r5, r6}
        pop               {r2}
        bx                r2
3:
        bl                3f
        mov               r8, r8
4:
        .word             0xffff0ffc
5:
        .word             0xffff0f60

asm_test::swap::u64::seqcst:
        push              {r4, r5, r6, lr}
        sub               sp, #0x10
        str               r3, [sp, #0x4]
        str               r2, [sp]
        ldr               r1, [pc, #0x34]         @ 4f
        ldr               r1, [r1]
        cmp               r1, #0x5
        blt               3f
        add               r4, sp, #0x8
        mov               r5, sp
        ldr               r6, [pc, #0x2c]         @ 5f
        movs              r2, r0
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        movs              r0, r4
        movs              r1, r5
        bl                1f
        b                 2f
1:
        bx                r6
2:
        blo               0b
        ldr               r1, [sp, #0xc]
        ldr               r0, [sp, #0x8]
        add               sp, #0x10
        pop               {r4, r5, r6}
        pop               {r2}
        bx                r2
3:
        bl                3f
        mov               r8, r8
4:
        .word             0xffff0ffc
5:
        .word             0xffff0f60

asm_test::swap::u64::acquire:
        push              {r4, r5, r6, lr}
        sub               sp, #0x10
        str               r3, [sp, #0x4]
        str               r2, [sp]
        ldr               r1, [pc, #0x34]         @ 4f
        ldr               r1, [r1]
        cmp               r1, #0x5
        blt               3f
        add               r4, sp, #0x8
        mov               r5, sp
        ldr               r6, [pc, #0x2c]         @ 5f
        movs              r2, r0
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        movs              r0, r4
        movs              r1, r5
        bl                1f
        b                 2f
1:
        bx                r6
2:
        blo               0b
        ldr               r1, [sp, #0xc]
        ldr               r0, [sp, #0x8]
        add               sp, #0x10
        pop               {r4, r5, r6}
        pop               {r2}
        bx                r2
3:
        bl                3f
        mov               r8, r8
4:
        .word             0xffff0ffc
5:
        .word             0xffff0f60

asm_test::swap::u64::relaxed:
        push              {r4, r5, r6, lr}
        sub               sp, #0x10
        str               r3, [sp, #0x4]
        str               r2, [sp]
        ldr               r1, [pc, #0x34]         @ 4f
        ldr               r1, [r1]
        cmp               r1, #0x5
        blt               3f
        add               r4, sp, #0x8
        mov               r5, sp
        ldr               r6, [pc, #0x2c]         @ 5f
        movs              r2, r0
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        movs              r0, r4
        movs              r1, r5
        bl                1f
        b                 2f
1:
        bx                r6
2:
        blo               0b
        ldr               r1, [sp, #0xc]
        ldr               r0, [sp, #0x8]
        add               sp, #0x10
        pop               {r4, r5, r6}
        pop               {r2}
        bx                r2
3:
        bl                3f
        mov               r8, r8
4:
        .word             0xffff0ffc
5:
        .word             0xffff0f60

asm_test::swap::u64::release:
        push              {r4, r5, r6, lr}
        sub               sp, #0x10
        str               r3, [sp, #0x4]
        str               r2, [sp]
        ldr               r1, [pc, #0x34]         @ 4f
        ldr               r1, [r1]
        cmp               r1, #0x5
        blt               3f
        add               r4, sp, #0x8
        mov               r5, sp
        ldr               r6, [pc, #0x2c]         @ 5f
        movs              r2, r0
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        movs              r0, r4
        movs              r1, r5
        bl                1f
        b                 2f
1:
        bx                r6
2:
        blo               0b
        ldr               r1, [sp, #0xc]
        ldr               r0, [sp, #0x8]
        add               sp, #0x10
        pop               {r4, r5, r6}
        pop               {r2}
        bx                r2
3:
        bl                3f
        mov               r8, r8
4:
        .word             0xffff0ffc
5:
        .word             0xffff0f60

asm_test::store::u8::seqcst:
        push              {r7, lr}
        ldr               r2, [pc, #0x18]         @ 4f
        bl                0f
        b                 1f
0:
        bx                r2
1:
        strb              r1, [r0]
        bl                2f
        b                 3f
2:
        bx                r2
3:
        pop               {r7}
        pop               {r0}
        bx                r0
4:
        .word             0xffff0fa0

asm_test::store::u8::relaxed:
        strb              r1, [r0]
        bx                lr

asm_test::store::u8::release:
        push              {r7, lr}
        ldr               r2, [pc, #0x10]         @ 2f
        bl                0f
        b                 1f
0:
        bx                r2
1:
        strb              r1, [r0]
        pop               {r7}
        pop               {r0}
        bx                r0
2:
        .word             0xffff0fa0

asm_test::store::u16::seqcst:
        push              {r7, lr}
        ldr               r2, [pc, #0x18]         @ 4f
        bl                0f
        b                 1f
0:
        bx                r2
1:
        strh              r1, [r0]
        bl                2f
        b                 3f
2:
        bx                r2
3:
        pop               {r7}
        pop               {r0}
        bx                r0
4:
        .word             0xffff0fa0

asm_test::store::u16::relaxed:
        strh              r1, [r0]
        bx                lr

asm_test::store::u16::release:
        push              {r7, lr}
        ldr               r2, [pc, #0x10]         @ 2f
        bl                0f
        b                 1f
0:
        bx                r2
1:
        strh              r1, [r0]
        pop               {r7}
        pop               {r0}
        bx                r0
2:
        .word             0xffff0fa0

asm_test::store::u32::seqcst:
        push              {r7, lr}
        ldr               r2, [pc, #0x18]         @ 4f
        bl                0f
        b                 1f
0:
        bx                r2
1:
        str               r1, [r0]
        bl                2f
        b                 3f
2:
        bx                r2
3:
        pop               {r7}
        pop               {r0}
        bx                r0
4:
        .word             0xffff0fa0

asm_test::store::u32::relaxed:
        str               r1, [r0]
        bx                lr

asm_test::store::u32::release:
        push              {r7, lr}
        ldr               r2, [pc, #0x10]         @ 2f
        bl                0f
        b                 1f
0:
        bx                r2
1:
        str               r1, [r0]
        pop               {r7}
        pop               {r0}
        bx                r0
2:
        .word             0xffff0fa0

asm_test::store::u64::seqcst:
        push              {r4, r5, r6, lr}
        sub               sp, #0x10
        str               r3, [sp, #0x4]
        str               r2, [sp]
        ldr               r1, [pc, #0x30]         @ 4f
        ldr               r1, [r1]
        cmp               r1, #0x5
        blt               3f
        add               r4, sp, #0x8
        mov               r5, sp
        ldr               r6, [pc, #0x28]         @ 5f
        movs              r2, r0
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        movs              r0, r4
        movs              r1, r5
        bl                1f
        b                 2f
1:
        bx                r6
2:
        blo               0b
        add               sp, #0x10
        pop               {r4, r5, r6}
        pop               {r0}
        bx                r0
3:
        bl                3f
        mov               r8, r8
4:
        .word             0xffff0ffc
5:
        .word             0xffff0f60

asm_test::store::u64::relaxed:
        push              {r4, r5, r6, lr}
        sub               sp, #0x10
        str               r3, [sp, #0x4]
        str               r2, [sp]
        ldr               r1, [pc, #0x30]         @ 4f
        ldr               r1, [r1]
        cmp               r1, #0x5
        blt               3f
        add               r4, sp, #0x8
        mov               r5, sp
        ldr               r6, [pc, #0x28]         @ 5f
        movs              r2, r0
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        movs              r0, r4
        movs              r1, r5
        bl                1f
        b                 2f
1:
        bx                r6
2:
        blo               0b
        add               sp, #0x10
        pop               {r4, r5, r6}
        pop               {r0}
        bx                r0
3:
        bl                3f
        mov               r8, r8
4:
        .word             0xffff0ffc
5:
        .word             0xffff0f60

asm_test::store::u64::release:
        push              {r4, r5, r6, lr}
        sub               sp, #0x10
        str               r3, [sp, #0x4]
        str               r2, [sp]
        ldr               r1, [pc, #0x30]         @ 4f
        ldr               r1, [r1]
        cmp               r1, #0x5
        blt               3f
        add               r4, sp, #0x8
        mov               r5, sp
        ldr               r6, [pc, #0x28]         @ 5f
        movs              r2, r0
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r4]
        str               r1, [r4, #0x4]
        movs              r0, r4
        movs              r1, r5
        bl                1f
        b                 2f
1:
        bx                r6
2:
        blo               0b
        add               sp, #0x10
        pop               {r4, r5, r6}
        pop               {r0}
        bx                r0
3:
        bl                3f
        mov               r8, r8
4:
        .word             0xffff0ffc
5:
        .word             0xffff0f60
