asm_test::compare_exchange::u8::acqrel_seqcst:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #24
        and               r5, r3, r0, lsl #3
        mov               r3, #255
        and               r6, r2, #255
        and               r7, r1, #255
        lsl               r8, r3, r5
        bic               r2, r0, #3
        ldr               r9, [pc, #0x50]         @ 3f
        lsl               r7, r7, r5
        lsl               r6, r6, r5
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r7
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r5
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u8::seqcst_seqcst:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #24
        and               r5, r3, r0, lsl #3
        mov               r3, #255
        and               r6, r2, #255
        and               r7, r1, #255
        lsl               r8, r3, r5
        bic               r2, r0, #3
        ldr               r9, [pc, #0x50]         @ 3f
        lsl               r7, r7, r5
        lsl               r6, r6, r5
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r7
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r5
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u8::acqrel_acquire:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #24
        and               r5, r3, r0, lsl #3
        mov               r3, #255
        and               r6, r2, #255
        and               r7, r1, #255
        lsl               r8, r3, r5
        bic               r2, r0, #3
        ldr               r9, [pc, #0x50]         @ 3f
        lsl               r7, r7, r5
        lsl               r6, r6, r5
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r7
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r5
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u8::acqrel_relaxed:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #24
        and               r5, r3, r0, lsl #3
        mov               r3, #255
        and               r6, r2, #255
        and               r7, r1, #255
        lsl               r8, r3, r5
        bic               r2, r0, #3
        ldr               r9, [pc, #0x50]         @ 3f
        lsl               r7, r7, r5
        lsl               r6, r6, r5
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r7
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r5
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u8::acquire_seqcst:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #24
        and               r5, r3, r0, lsl #3
        mov               r3, #255
        and               r6, r2, #255
        and               r7, r1, #255
        lsl               r8, r3, r5
        bic               r2, r0, #3
        ldr               r9, [pc, #0x50]         @ 3f
        lsl               r7, r7, r5
        lsl               r6, r6, r5
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r7
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r5
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u8::relaxed_seqcst:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #24
        and               r5, r3, r0, lsl #3
        mov               r3, #255
        and               r6, r2, #255
        and               r7, r1, #255
        lsl               r8, r3, r5
        bic               r2, r0, #3
        ldr               r9, [pc, #0x50]         @ 3f
        lsl               r7, r7, r5
        lsl               r6, r6, r5
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r7
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r5
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u8::release_seqcst:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #24
        and               r5, r3, r0, lsl #3
        mov               r3, #255
        and               r6, r2, #255
        and               r7, r1, #255
        lsl               r8, r3, r5
        bic               r2, r0, #3
        ldr               r9, [pc, #0x50]         @ 3f
        lsl               r7, r7, r5
        lsl               r6, r6, r5
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r7
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r5
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u8::seqcst_acquire:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #24
        and               r5, r3, r0, lsl #3
        mov               r3, #255
        and               r6, r2, #255
        and               r7, r1, #255
        lsl               r8, r3, r5
        bic               r2, r0, #3
        ldr               r9, [pc, #0x50]         @ 3f
        lsl               r7, r7, r5
        lsl               r6, r6, r5
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r7
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r5
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u8::seqcst_relaxed:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #24
        and               r5, r3, r0, lsl #3
        mov               r3, #255
        and               r6, r2, #255
        and               r7, r1, #255
        lsl               r8, r3, r5
        bic               r2, r0, #3
        ldr               r9, [pc, #0x50]         @ 3f
        lsl               r7, r7, r5
        lsl               r6, r6, r5
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r7
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r5
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u8::acquire_acquire:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #24
        and               r5, r3, r0, lsl #3
        mov               r3, #255
        and               r6, r2, #255
        and               r7, r1, #255
        lsl               r8, r3, r5
        bic               r2, r0, #3
        ldr               r9, [pc, #0x50]         @ 3f
        lsl               r7, r7, r5
        lsl               r6, r6, r5
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r7
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r5
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u8::acquire_relaxed:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #24
        and               r5, r3, r0, lsl #3
        mov               r3, #255
        and               r6, r2, #255
        and               r7, r1, #255
        lsl               r8, r3, r5
        bic               r2, r0, #3
        ldr               r9, [pc, #0x50]         @ 3f
        lsl               r7, r7, r5
        lsl               r6, r6, r5
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r7
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r5
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u8::relaxed_acquire:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #24
        and               r5, r3, r0, lsl #3
        mov               r3, #255
        and               r6, r2, #255
        and               r7, r1, #255
        lsl               r8, r3, r5
        bic               r2, r0, #3
        ldr               r9, [pc, #0x50]         @ 3f
        lsl               r7, r7, r5
        lsl               r6, r6, r5
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r7
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r5
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u8::relaxed_relaxed:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #24
        and               r5, r3, r0, lsl #3
        mov               r3, #255
        and               r6, r2, #255
        and               r7, r1, #255
        lsl               r8, r3, r5
        bic               r2, r0, #3
        ldr               r9, [pc, #0x50]         @ 3f
        lsl               r7, r7, r5
        lsl               r6, r6, r5
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r7
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r5
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u8::release_acquire:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #24
        and               r5, r3, r0, lsl #3
        mov               r3, #255
        and               r6, r2, #255
        and               r7, r1, #255
        lsl               r8, r3, r5
        bic               r2, r0, #3
        ldr               r9, [pc, #0x50]         @ 3f
        lsl               r7, r7, r5
        lsl               r6, r6, r5
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r7
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r5
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u8::release_relaxed:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #24
        and               r5, r3, r0, lsl #3
        mov               r3, #255
        and               r6, r2, #255
        and               r7, r1, #255
        lsl               r8, r3, r5
        bic               r2, r0, #3
        ldr               r9, [pc, #0x50]         @ 3f
        lsl               r7, r7, r5
        lsl               r6, r6, r5
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r7
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r5
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::acqrel_seqcst:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #255
        ldr               r9, [pc, #0x6c]         @ 3f
        orr               r3, r3, #65280
        and               r5, r1, r3
        mov               r1, #24
        and               r7, r1, r0, lsl #3
        and               r6, r2, r3
        bic               r2, r0, #3
        lsl               r8, r3, r7
        lsl               r5, r5, r7
        lsl               r6, r6, r7
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r5
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r7
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::seqcst_seqcst:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #255
        ldr               r9, [pc, #0x6c]         @ 3f
        orr               r3, r3, #65280
        and               r5, r1, r3
        mov               r1, #24
        and               r7, r1, r0, lsl #3
        and               r6, r2, r3
        bic               r2, r0, #3
        lsl               r8, r3, r7
        lsl               r5, r5, r7
        lsl               r6, r6, r7
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r5
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r7
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::acqrel_acquire:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #255
        ldr               r9, [pc, #0x6c]         @ 3f
        orr               r3, r3, #65280
        and               r5, r1, r3
        mov               r1, #24
        and               r7, r1, r0, lsl #3
        and               r6, r2, r3
        bic               r2, r0, #3
        lsl               r8, r3, r7
        lsl               r5, r5, r7
        lsl               r6, r6, r7
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r5
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r7
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::acqrel_relaxed:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #255
        ldr               r9, [pc, #0x6c]         @ 3f
        orr               r3, r3, #65280
        and               r5, r1, r3
        mov               r1, #24
        and               r7, r1, r0, lsl #3
        and               r6, r2, r3
        bic               r2, r0, #3
        lsl               r8, r3, r7
        lsl               r5, r5, r7
        lsl               r6, r6, r7
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r5
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r7
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::acquire_seqcst:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #255
        ldr               r9, [pc, #0x6c]         @ 3f
        orr               r3, r3, #65280
        and               r5, r1, r3
        mov               r1, #24
        and               r7, r1, r0, lsl #3
        and               r6, r2, r3
        bic               r2, r0, #3
        lsl               r8, r3, r7
        lsl               r5, r5, r7
        lsl               r6, r6, r7
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r5
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r7
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::relaxed_seqcst:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #255
        ldr               r9, [pc, #0x6c]         @ 3f
        orr               r3, r3, #65280
        and               r5, r1, r3
        mov               r1, #24
        and               r7, r1, r0, lsl #3
        and               r6, r2, r3
        bic               r2, r0, #3
        lsl               r8, r3, r7
        lsl               r5, r5, r7
        lsl               r6, r6, r7
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r5
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r7
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::release_seqcst:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #255
        ldr               r9, [pc, #0x6c]         @ 3f
        orr               r3, r3, #65280
        and               r5, r1, r3
        mov               r1, #24
        and               r7, r1, r0, lsl #3
        and               r6, r2, r3
        bic               r2, r0, #3
        lsl               r8, r3, r7
        lsl               r5, r5, r7
        lsl               r6, r6, r7
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r5
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r7
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::seqcst_acquire:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #255
        ldr               r9, [pc, #0x6c]         @ 3f
        orr               r3, r3, #65280
        and               r5, r1, r3
        mov               r1, #24
        and               r7, r1, r0, lsl #3
        and               r6, r2, r3
        bic               r2, r0, #3
        lsl               r8, r3, r7
        lsl               r5, r5, r7
        lsl               r6, r6, r7
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r5
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r7
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::seqcst_relaxed:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #255
        ldr               r9, [pc, #0x6c]         @ 3f
        orr               r3, r3, #65280
        and               r5, r1, r3
        mov               r1, #24
        and               r7, r1, r0, lsl #3
        and               r6, r2, r3
        bic               r2, r0, #3
        lsl               r8, r3, r7
        lsl               r5, r5, r7
        lsl               r6, r6, r7
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r5
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r7
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::acquire_acquire:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #255
        ldr               r9, [pc, #0x6c]         @ 3f
        orr               r3, r3, #65280
        and               r5, r1, r3
        mov               r1, #24
        and               r7, r1, r0, lsl #3
        and               r6, r2, r3
        bic               r2, r0, #3
        lsl               r8, r3, r7
        lsl               r5, r5, r7
        lsl               r6, r6, r7
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r5
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r7
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::acquire_relaxed:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #255
        ldr               r9, [pc, #0x6c]         @ 3f
        orr               r3, r3, #65280
        and               r5, r1, r3
        mov               r1, #24
        and               r7, r1, r0, lsl #3
        and               r6, r2, r3
        bic               r2, r0, #3
        lsl               r8, r3, r7
        lsl               r5, r5, r7
        lsl               r6, r6, r7
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r5
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r7
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::relaxed_acquire:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #255
        ldr               r9, [pc, #0x6c]         @ 3f
        orr               r3, r3, #65280
        and               r5, r1, r3
        mov               r1, #24
        and               r7, r1, r0, lsl #3
        and               r6, r2, r3
        bic               r2, r0, #3
        lsl               r8, r3, r7
        lsl               r5, r5, r7
        lsl               r6, r6, r7
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r5
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r7
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::relaxed_relaxed:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #255
        ldr               r9, [pc, #0x6c]         @ 3f
        orr               r3, r3, #65280
        and               r5, r1, r3
        mov               r1, #24
        and               r7, r1, r0, lsl #3
        and               r6, r2, r3
        bic               r2, r0, #3
        lsl               r8, r3, r7
        lsl               r5, r5, r7
        lsl               r6, r6, r7
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r5
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r7
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::release_acquire:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #255
        ldr               r9, [pc, #0x6c]         @ 3f
        orr               r3, r3, #65280
        and               r5, r1, r3
        mov               r1, #24
        and               r7, r1, r0, lsl #3
        and               r6, r2, r3
        bic               r2, r0, #3
        lsl               r8, r3, r7
        lsl               r5, r5, r7
        lsl               r6, r6, r7
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r5
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r7
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u16::release_relaxed:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #255
        ldr               r9, [pc, #0x6c]         @ 3f
        orr               r3, r3, #65280
        and               r5, r1, r3
        mov               r1, #24
        and               r7, r1, r0, lsl #3
        and               r6, r2, r3
        bic               r2, r0, #3
        lsl               r8, r3, r7
        lsl               r5, r5, r7
        lsl               r6, r6, r7
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r5
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r7
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::acqrel_seqcst:
        push              {r4, r5, r6, r7, r11, lr}
        mov               r4, r2
        mov               r5, r1
        ldr               r7, [pc, #0x40]         @ 3f
        mov               r2, r0
0:
        ldr               r6, [r2]
        mov               r0, r6
        cmp               r6, r5
        bne               1f
        mov               r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r7
        blo               0b
        mov               r0, #1
2:
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r6
        pop               {r4, r5, r6, r7, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::seqcst_seqcst:
        push              {r4, r5, r6, r7, r11, lr}
        mov               r4, r2
        mov               r5, r1
        ldr               r7, [pc, #0x40]         @ 3f
        mov               r2, r0
0:
        ldr               r6, [r2]
        mov               r0, r6
        cmp               r6, r5
        bne               1f
        mov               r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r7
        blo               0b
        mov               r0, #1
2:
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r6
        pop               {r4, r5, r6, r7, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::acqrel_acquire:
        push              {r4, r5, r6, r7, r11, lr}
        mov               r4, r2
        mov               r5, r1
        ldr               r7, [pc, #0x40]         @ 3f
        mov               r2, r0
0:
        ldr               r6, [r2]
        mov               r0, r6
        cmp               r6, r5
        bne               1f
        mov               r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r7
        blo               0b
        mov               r0, #1
2:
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r6
        pop               {r4, r5, r6, r7, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::acqrel_relaxed:
        push              {r4, r5, r6, r7, r11, lr}
        mov               r4, r2
        mov               r5, r1
        ldr               r7, [pc, #0x40]         @ 3f
        mov               r2, r0
0:
        ldr               r6, [r2]
        mov               r0, r6
        cmp               r6, r5
        bne               1f
        mov               r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r7
        blo               0b
        mov               r0, #1
2:
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r6
        pop               {r4, r5, r6, r7, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::acquire_seqcst:
        push              {r4, r5, r6, r7, r11, lr}
        mov               r4, r2
        mov               r5, r1
        ldr               r7, [pc, #0x40]         @ 3f
        mov               r2, r0
0:
        ldr               r6, [r2]
        mov               r0, r6
        cmp               r6, r5
        bne               1f
        mov               r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r7
        blo               0b
        mov               r0, #1
2:
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r6
        pop               {r4, r5, r6, r7, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::relaxed_seqcst:
        push              {r4, r5, r6, r7, r11, lr}
        mov               r4, r2
        mov               r5, r1
        ldr               r7, [pc, #0x40]         @ 3f
        mov               r2, r0
0:
        ldr               r6, [r2]
        mov               r0, r6
        cmp               r6, r5
        bne               1f
        mov               r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r7
        blo               0b
        mov               r0, #1
2:
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r6
        pop               {r4, r5, r6, r7, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::release_seqcst:
        push              {r4, r5, r6, r7, r11, lr}
        mov               r4, r2
        mov               r5, r1
        ldr               r7, [pc, #0x40]         @ 3f
        mov               r2, r0
0:
        ldr               r6, [r2]
        mov               r0, r6
        cmp               r6, r5
        bne               1f
        mov               r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r7
        blo               0b
        mov               r0, #1
2:
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r6
        pop               {r4, r5, r6, r7, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::seqcst_acquire:
        push              {r4, r5, r6, r7, r11, lr}
        mov               r4, r2
        mov               r5, r1
        ldr               r7, [pc, #0x40]         @ 3f
        mov               r2, r0
0:
        ldr               r6, [r2]
        mov               r0, r6
        cmp               r6, r5
        bne               1f
        mov               r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r7
        blo               0b
        mov               r0, #1
2:
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r6
        pop               {r4, r5, r6, r7, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::seqcst_relaxed:
        push              {r4, r5, r6, r7, r11, lr}
        mov               r4, r2
        mov               r5, r1
        ldr               r7, [pc, #0x40]         @ 3f
        mov               r2, r0
0:
        ldr               r6, [r2]
        mov               r0, r6
        cmp               r6, r5
        bne               1f
        mov               r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r7
        blo               0b
        mov               r0, #1
2:
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r6
        pop               {r4, r5, r6, r7, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::acquire_acquire:
        push              {r4, r5, r6, r7, r11, lr}
        mov               r4, r2
        mov               r5, r1
        ldr               r7, [pc, #0x40]         @ 3f
        mov               r2, r0
0:
        ldr               r6, [r2]
        mov               r0, r6
        cmp               r6, r5
        bne               1f
        mov               r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r7
        blo               0b
        mov               r0, #1
2:
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r6
        pop               {r4, r5, r6, r7, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::acquire_relaxed:
        push              {r4, r5, r6, r7, r11, lr}
        mov               r4, r2
        mov               r5, r1
        ldr               r7, [pc, #0x40]         @ 3f
        mov               r2, r0
0:
        ldr               r6, [r2]
        mov               r0, r6
        cmp               r6, r5
        bne               1f
        mov               r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r7
        blo               0b
        mov               r0, #1
2:
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r6
        pop               {r4, r5, r6, r7, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::relaxed_acquire:
        push              {r4, r5, r6, r7, r11, lr}
        mov               r4, r2
        mov               r5, r1
        ldr               r7, [pc, #0x40]         @ 3f
        mov               r2, r0
0:
        ldr               r6, [r2]
        mov               r0, r6
        cmp               r6, r5
        bne               1f
        mov               r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r7
        blo               0b
        mov               r0, #1
2:
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r6
        pop               {r4, r5, r6, r7, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::relaxed_relaxed:
        push              {r4, r5, r6, r7, r11, lr}
        mov               r4, r2
        mov               r5, r1
        ldr               r7, [pc, #0x40]         @ 3f
        mov               r2, r0
0:
        ldr               r6, [r2]
        mov               r0, r6
        cmp               r6, r5
        bne               1f
        mov               r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r7
        blo               0b
        mov               r0, #1
2:
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r6
        pop               {r4, r5, r6, r7, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::release_acquire:
        push              {r4, r5, r6, r7, r11, lr}
        mov               r4, r2
        mov               r5, r1
        ldr               r7, [pc, #0x40]         @ 3f
        mov               r2, r0
0:
        ldr               r6, [r2]
        mov               r0, r6
        cmp               r6, r5
        bne               1f
        mov               r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r7
        blo               0b
        mov               r0, #1
2:
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r6
        pop               {r4, r5, r6, r7, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u32::release_relaxed:
        push              {r4, r5, r6, r7, r11, lr}
        mov               r4, r2
        mov               r5, r1
        ldr               r7, [pc, #0x40]         @ 3f
        mov               r2, r0
0:
        ldr               r6, [r2]
        mov               r0, r6
        cmp               r6, r5
        bne               1f
        mov               r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r7
        blo               0b
        mov               r0, #1
2:
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r6
        pop               {r4, r5, r6, r7, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange::u64::acqrel_seqcst:
        push              {r4, r5, r6, r7, r11, lr}
        sub               sp, sp, #8
        mov               r12, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        mvn               r0, #3
        sub               r0, r0, #61440
        ldr               r0, [r0]
        cmp               r0, #4
        ble               3f
        mvn               r7, #159
        mov               r5, r2
        mov               r4, r3
        mov               r6, sp
        sub               r7, r7, #61440
        mov               r2, r1
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r12]
        str               r1, [r12, #0x4]
        eor               r0, r0, r5
        eor               r1, r1, r4
        orrs              r0, r0, r1
        mov               r0, r12
        bne               1f
        mov               r1, r6
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r12
        blx               r7
        blo               0b
        mov               r0, #1
2:
        eor               r0, r0, #1
        strb              r0, [r12, #0x8]
        add               sp, sp, #8
        pop               {r4, r5, r6, r7, r11, pc}
3:
        bl                3f

asm_test::compare_exchange::u64::seqcst_seqcst:
        push              {r4, r5, r6, r7, r11, lr}
        sub               sp, sp, #8
        mov               r12, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        mvn               r0, #3
        sub               r0, r0, #61440
        ldr               r0, [r0]
        cmp               r0, #4
        ble               3f
        mvn               r7, #159
        mov               r5, r2
        mov               r4, r3
        mov               r6, sp
        sub               r7, r7, #61440
        mov               r2, r1
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r12]
        str               r1, [r12, #0x4]
        eor               r0, r0, r5
        eor               r1, r1, r4
        orrs              r0, r0, r1
        mov               r0, r12
        bne               1f
        mov               r1, r6
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r12
        blx               r7
        blo               0b
        mov               r0, #1
2:
        eor               r0, r0, #1
        strb              r0, [r12, #0x8]
        add               sp, sp, #8
        pop               {r4, r5, r6, r7, r11, pc}
3:
        bl                3f

asm_test::compare_exchange::u64::acqrel_acquire:
        push              {r4, r5, r6, r7, r11, lr}
        sub               sp, sp, #8
        mov               r12, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        mvn               r0, #3
        sub               r0, r0, #61440
        ldr               r0, [r0]
        cmp               r0, #4
        ble               3f
        mvn               r7, #159
        mov               r5, r2
        mov               r4, r3
        mov               r6, sp
        sub               r7, r7, #61440
        mov               r2, r1
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r12]
        str               r1, [r12, #0x4]
        eor               r0, r0, r5
        eor               r1, r1, r4
        orrs              r0, r0, r1
        mov               r0, r12
        bne               1f
        mov               r1, r6
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r12
        blx               r7
        blo               0b
        mov               r0, #1
2:
        eor               r0, r0, #1
        strb              r0, [r12, #0x8]
        add               sp, sp, #8
        pop               {r4, r5, r6, r7, r11, pc}
3:
        bl                3f

asm_test::compare_exchange::u64::acqrel_relaxed:
        push              {r4, r5, r6, r7, r11, lr}
        sub               sp, sp, #8
        mov               r12, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        mvn               r0, #3
        sub               r0, r0, #61440
        ldr               r0, [r0]
        cmp               r0, #4
        ble               3f
        mvn               r7, #159
        mov               r5, r2
        mov               r4, r3
        mov               r6, sp
        sub               r7, r7, #61440
        mov               r2, r1
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r12]
        str               r1, [r12, #0x4]
        eor               r0, r0, r5
        eor               r1, r1, r4
        orrs              r0, r0, r1
        mov               r0, r12
        bne               1f
        mov               r1, r6
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r12
        blx               r7
        blo               0b
        mov               r0, #1
2:
        eor               r0, r0, #1
        strb              r0, [r12, #0x8]
        add               sp, sp, #8
        pop               {r4, r5, r6, r7, r11, pc}
3:
        bl                3f

asm_test::compare_exchange::u64::acquire_seqcst:
        push              {r4, r5, r6, r7, r11, lr}
        sub               sp, sp, #8
        mov               r12, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        mvn               r0, #3
        sub               r0, r0, #61440
        ldr               r0, [r0]
        cmp               r0, #4
        ble               3f
        mvn               r7, #159
        mov               r5, r2
        mov               r4, r3
        mov               r6, sp
        sub               r7, r7, #61440
        mov               r2, r1
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r12]
        str               r1, [r12, #0x4]
        eor               r0, r0, r5
        eor               r1, r1, r4
        orrs              r0, r0, r1
        mov               r0, r12
        bne               1f
        mov               r1, r6
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r12
        blx               r7
        blo               0b
        mov               r0, #1
2:
        eor               r0, r0, #1
        strb              r0, [r12, #0x8]
        add               sp, sp, #8
        pop               {r4, r5, r6, r7, r11, pc}
3:
        bl                3f

asm_test::compare_exchange::u64::relaxed_seqcst:
        push              {r4, r5, r6, r7, r11, lr}
        sub               sp, sp, #8
        mov               r12, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        mvn               r0, #3
        sub               r0, r0, #61440
        ldr               r0, [r0]
        cmp               r0, #4
        ble               3f
        mvn               r7, #159
        mov               r5, r2
        mov               r4, r3
        mov               r6, sp
        sub               r7, r7, #61440
        mov               r2, r1
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r12]
        str               r1, [r12, #0x4]
        eor               r0, r0, r5
        eor               r1, r1, r4
        orrs              r0, r0, r1
        mov               r0, r12
        bne               1f
        mov               r1, r6
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r12
        blx               r7
        blo               0b
        mov               r0, #1
2:
        eor               r0, r0, #1
        strb              r0, [r12, #0x8]
        add               sp, sp, #8
        pop               {r4, r5, r6, r7, r11, pc}
3:
        bl                3f

asm_test::compare_exchange::u64::release_seqcst:
        push              {r4, r5, r6, r7, r11, lr}
        sub               sp, sp, #8
        mov               r12, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        mvn               r0, #3
        sub               r0, r0, #61440
        ldr               r0, [r0]
        cmp               r0, #4
        ble               3f
        mvn               r7, #159
        mov               r5, r2
        mov               r4, r3
        mov               r6, sp
        sub               r7, r7, #61440
        mov               r2, r1
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r12]
        str               r1, [r12, #0x4]
        eor               r0, r0, r5
        eor               r1, r1, r4
        orrs              r0, r0, r1
        mov               r0, r12
        bne               1f
        mov               r1, r6
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r12
        blx               r7
        blo               0b
        mov               r0, #1
2:
        eor               r0, r0, #1
        strb              r0, [r12, #0x8]
        add               sp, sp, #8
        pop               {r4, r5, r6, r7, r11, pc}
3:
        bl                3f

asm_test::compare_exchange::u64::seqcst_acquire:
        push              {r4, r5, r6, r7, r11, lr}
        sub               sp, sp, #8
        mov               r12, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        mvn               r0, #3
        sub               r0, r0, #61440
        ldr               r0, [r0]
        cmp               r0, #4
        ble               3f
        mvn               r7, #159
        mov               r5, r2
        mov               r4, r3
        mov               r6, sp
        sub               r7, r7, #61440
        mov               r2, r1
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r12]
        str               r1, [r12, #0x4]
        eor               r0, r0, r5
        eor               r1, r1, r4
        orrs              r0, r0, r1
        mov               r0, r12
        bne               1f
        mov               r1, r6
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r12
        blx               r7
        blo               0b
        mov               r0, #1
2:
        eor               r0, r0, #1
        strb              r0, [r12, #0x8]
        add               sp, sp, #8
        pop               {r4, r5, r6, r7, r11, pc}
3:
        bl                3f

asm_test::compare_exchange::u64::seqcst_relaxed:
        push              {r4, r5, r6, r7, r11, lr}
        sub               sp, sp, #8
        mov               r12, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        mvn               r0, #3
        sub               r0, r0, #61440
        ldr               r0, [r0]
        cmp               r0, #4
        ble               3f
        mvn               r7, #159
        mov               r5, r2
        mov               r4, r3
        mov               r6, sp
        sub               r7, r7, #61440
        mov               r2, r1
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r12]
        str               r1, [r12, #0x4]
        eor               r0, r0, r5
        eor               r1, r1, r4
        orrs              r0, r0, r1
        mov               r0, r12
        bne               1f
        mov               r1, r6
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r12
        blx               r7
        blo               0b
        mov               r0, #1
2:
        eor               r0, r0, #1
        strb              r0, [r12, #0x8]
        add               sp, sp, #8
        pop               {r4, r5, r6, r7, r11, pc}
3:
        bl                3f

asm_test::compare_exchange::u64::acquire_acquire:
        push              {r4, r5, r6, r7, r11, lr}
        sub               sp, sp, #8
        mov               r12, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        mvn               r0, #3
        sub               r0, r0, #61440
        ldr               r0, [r0]
        cmp               r0, #4
        ble               3f
        mvn               r7, #159
        mov               r5, r2
        mov               r4, r3
        mov               r6, sp
        sub               r7, r7, #61440
        mov               r2, r1
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r12]
        str               r1, [r12, #0x4]
        eor               r0, r0, r5
        eor               r1, r1, r4
        orrs              r0, r0, r1
        mov               r0, r12
        bne               1f
        mov               r1, r6
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r12
        blx               r7
        blo               0b
        mov               r0, #1
2:
        eor               r0, r0, #1
        strb              r0, [r12, #0x8]
        add               sp, sp, #8
        pop               {r4, r5, r6, r7, r11, pc}
3:
        bl                3f

asm_test::compare_exchange::u64::acquire_relaxed:
        push              {r4, r5, r6, r7, r11, lr}
        sub               sp, sp, #8
        mov               r12, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        mvn               r0, #3
        sub               r0, r0, #61440
        ldr               r0, [r0]
        cmp               r0, #4
        ble               3f
        mvn               r7, #159
        mov               r5, r2
        mov               r4, r3
        mov               r6, sp
        sub               r7, r7, #61440
        mov               r2, r1
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r12]
        str               r1, [r12, #0x4]
        eor               r0, r0, r5
        eor               r1, r1, r4
        orrs              r0, r0, r1
        mov               r0, r12
        bne               1f
        mov               r1, r6
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r12
        blx               r7
        blo               0b
        mov               r0, #1
2:
        eor               r0, r0, #1
        strb              r0, [r12, #0x8]
        add               sp, sp, #8
        pop               {r4, r5, r6, r7, r11, pc}
3:
        bl                3f

asm_test::compare_exchange::u64::relaxed_acquire:
        push              {r4, r5, r6, r7, r11, lr}
        sub               sp, sp, #8
        mov               r12, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        mvn               r0, #3
        sub               r0, r0, #61440
        ldr               r0, [r0]
        cmp               r0, #4
        ble               3f
        mvn               r7, #159
        mov               r5, r2
        mov               r4, r3
        mov               r6, sp
        sub               r7, r7, #61440
        mov               r2, r1
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r12]
        str               r1, [r12, #0x4]
        eor               r0, r0, r5
        eor               r1, r1, r4
        orrs              r0, r0, r1
        mov               r0, r12
        bne               1f
        mov               r1, r6
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r12
        blx               r7
        blo               0b
        mov               r0, #1
2:
        eor               r0, r0, #1
        strb              r0, [r12, #0x8]
        add               sp, sp, #8
        pop               {r4, r5, r6, r7, r11, pc}
3:
        bl                3f

asm_test::compare_exchange::u64::relaxed_relaxed:
        push              {r4, r5, r6, r7, r11, lr}
        sub               sp, sp, #8
        mov               r12, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        mvn               r0, #3
        sub               r0, r0, #61440
        ldr               r0, [r0]
        cmp               r0, #4
        ble               3f
        mvn               r7, #159
        mov               r5, r2
        mov               r4, r3
        mov               r6, sp
        sub               r7, r7, #61440
        mov               r2, r1
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r12]
        str               r1, [r12, #0x4]
        eor               r0, r0, r5
        eor               r1, r1, r4
        orrs              r0, r0, r1
        mov               r0, r12
        bne               1f
        mov               r1, r6
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r12
        blx               r7
        blo               0b
        mov               r0, #1
2:
        eor               r0, r0, #1
        strb              r0, [r12, #0x8]
        add               sp, sp, #8
        pop               {r4, r5, r6, r7, r11, pc}
3:
        bl                3f

asm_test::compare_exchange::u64::release_acquire:
        push              {r4, r5, r6, r7, r11, lr}
        sub               sp, sp, #8
        mov               r12, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        mvn               r0, #3
        sub               r0, r0, #61440
        ldr               r0, [r0]
        cmp               r0, #4
        ble               3f
        mvn               r7, #159
        mov               r5, r2
        mov               r4, r3
        mov               r6, sp
        sub               r7, r7, #61440
        mov               r2, r1
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r12]
        str               r1, [r12, #0x4]
        eor               r0, r0, r5
        eor               r1, r1, r4
        orrs              r0, r0, r1
        mov               r0, r12
        bne               1f
        mov               r1, r6
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r12
        blx               r7
        blo               0b
        mov               r0, #1
2:
        eor               r0, r0, #1
        strb              r0, [r12, #0x8]
        add               sp, sp, #8
        pop               {r4, r5, r6, r7, r11, pc}
3:
        bl                3f

asm_test::compare_exchange::u64::release_relaxed:
        push              {r4, r5, r6, r7, r11, lr}
        sub               sp, sp, #8
        mov               r12, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        mvn               r0, #3
        sub               r0, r0, #61440
        ldr               r0, [r0]
        cmp               r0, #4
        ble               3f
        mvn               r7, #159
        mov               r5, r2
        mov               r4, r3
        mov               r6, sp
        sub               r7, r7, #61440
        mov               r2, r1
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r12]
        str               r1, [r12, #0x4]
        eor               r0, r0, r5
        eor               r1, r1, r4
        orrs              r0, r0, r1
        mov               r0, r12
        bne               1f
        mov               r1, r6
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r12
        blx               r7
        blo               0b
        mov               r0, #1
2:
        eor               r0, r0, #1
        strb              r0, [r12, #0x8]
        add               sp, sp, #8
        pop               {r4, r5, r6, r7, r11, pc}
3:
        bl                3f

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #24
        and               r5, r3, r0, lsl #3
        mov               r3, #255
        and               r6, r2, #255
        and               r7, r1, #255
        lsl               r8, r3, r5
        bic               r2, r0, #3
        ldr               r9, [pc, #0x50]         @ 3f
        lsl               r7, r7, r5
        lsl               r6, r6, r5
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r7
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r5
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #24
        and               r5, r3, r0, lsl #3
        mov               r3, #255
        and               r6, r2, #255
        and               r7, r1, #255
        lsl               r8, r3, r5
        bic               r2, r0, #3
        ldr               r9, [pc, #0x50]         @ 3f
        lsl               r7, r7, r5
        lsl               r6, r6, r5
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r7
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r5
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #24
        and               r5, r3, r0, lsl #3
        mov               r3, #255
        and               r6, r2, #255
        and               r7, r1, #255
        lsl               r8, r3, r5
        bic               r2, r0, #3
        ldr               r9, [pc, #0x50]         @ 3f
        lsl               r7, r7, r5
        lsl               r6, r6, r5
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r7
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r5
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #24
        and               r5, r3, r0, lsl #3
        mov               r3, #255
        and               r6, r2, #255
        and               r7, r1, #255
        lsl               r8, r3, r5
        bic               r2, r0, #3
        ldr               r9, [pc, #0x50]         @ 3f
        lsl               r7, r7, r5
        lsl               r6, r6, r5
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r7
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r5
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #24
        and               r5, r3, r0, lsl #3
        mov               r3, #255
        and               r6, r2, #255
        and               r7, r1, #255
        lsl               r8, r3, r5
        bic               r2, r0, #3
        ldr               r9, [pc, #0x50]         @ 3f
        lsl               r7, r7, r5
        lsl               r6, r6, r5
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r7
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r5
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #24
        and               r5, r3, r0, lsl #3
        mov               r3, #255
        and               r6, r2, #255
        and               r7, r1, #255
        lsl               r8, r3, r5
        bic               r2, r0, #3
        ldr               r9, [pc, #0x50]         @ 3f
        lsl               r7, r7, r5
        lsl               r6, r6, r5
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r7
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r5
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u8::release_seqcst:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #24
        and               r5, r3, r0, lsl #3
        mov               r3, #255
        and               r6, r2, #255
        and               r7, r1, #255
        lsl               r8, r3, r5
        bic               r2, r0, #3
        ldr               r9, [pc, #0x50]         @ 3f
        lsl               r7, r7, r5
        lsl               r6, r6, r5
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r7
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r5
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #24
        and               r5, r3, r0, lsl #3
        mov               r3, #255
        and               r6, r2, #255
        and               r7, r1, #255
        lsl               r8, r3, r5
        bic               r2, r0, #3
        ldr               r9, [pc, #0x50]         @ 3f
        lsl               r7, r7, r5
        lsl               r6, r6, r5
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r7
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r5
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #24
        and               r5, r3, r0, lsl #3
        mov               r3, #255
        and               r6, r2, #255
        and               r7, r1, #255
        lsl               r8, r3, r5
        bic               r2, r0, #3
        ldr               r9, [pc, #0x50]         @ 3f
        lsl               r7, r7, r5
        lsl               r6, r6, r5
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r7
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r5
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u8::acquire_acquire:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #24
        and               r5, r3, r0, lsl #3
        mov               r3, #255
        and               r6, r2, #255
        and               r7, r1, #255
        lsl               r8, r3, r5
        bic               r2, r0, #3
        ldr               r9, [pc, #0x50]         @ 3f
        lsl               r7, r7, r5
        lsl               r6, r6, r5
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r7
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r5
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #24
        and               r5, r3, r0, lsl #3
        mov               r3, #255
        and               r6, r2, #255
        and               r7, r1, #255
        lsl               r8, r3, r5
        bic               r2, r0, #3
        ldr               r9, [pc, #0x50]         @ 3f
        lsl               r7, r7, r5
        lsl               r6, r6, r5
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r7
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r5
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #24
        and               r5, r3, r0, lsl #3
        mov               r3, #255
        and               r6, r2, #255
        and               r7, r1, #255
        lsl               r8, r3, r5
        bic               r2, r0, #3
        ldr               r9, [pc, #0x50]         @ 3f
        lsl               r7, r7, r5
        lsl               r6, r6, r5
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r7
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r5
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #24
        and               r5, r3, r0, lsl #3
        mov               r3, #255
        and               r6, r2, #255
        and               r7, r1, #255
        lsl               r8, r3, r5
        bic               r2, r0, #3
        ldr               r9, [pc, #0x50]         @ 3f
        lsl               r7, r7, r5
        lsl               r6, r6, r5
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r7
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r5
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u8::release_acquire:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #24
        and               r5, r3, r0, lsl #3
        mov               r3, #255
        and               r6, r2, #255
        and               r7, r1, #255
        lsl               r8, r3, r5
        bic               r2, r0, #3
        ldr               r9, [pc, #0x50]         @ 3f
        lsl               r7, r7, r5
        lsl               r6, r6, r5
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r7
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r5
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u8::release_relaxed:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #24
        and               r5, r3, r0, lsl #3
        mov               r3, #255
        and               r6, r2, #255
        and               r7, r1, #255
        lsl               r8, r3, r5
        bic               r2, r0, #3
        ldr               r9, [pc, #0x50]         @ 3f
        lsl               r7, r7, r5
        lsl               r6, r6, r5
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r7
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r5
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #255
        ldr               r9, [pc, #0x6c]         @ 3f
        orr               r3, r3, #65280
        and               r5, r1, r3
        mov               r1, #24
        and               r7, r1, r0, lsl #3
        and               r6, r2, r3
        bic               r2, r0, #3
        lsl               r8, r3, r7
        lsl               r5, r5, r7
        lsl               r6, r6, r7
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r5
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r7
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #255
        ldr               r9, [pc, #0x6c]         @ 3f
        orr               r3, r3, #65280
        and               r5, r1, r3
        mov               r1, #24
        and               r7, r1, r0, lsl #3
        and               r6, r2, r3
        bic               r2, r0, #3
        lsl               r8, r3, r7
        lsl               r5, r5, r7
        lsl               r6, r6, r7
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r5
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r7
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #255
        ldr               r9, [pc, #0x6c]         @ 3f
        orr               r3, r3, #65280
        and               r5, r1, r3
        mov               r1, #24
        and               r7, r1, r0, lsl #3
        and               r6, r2, r3
        bic               r2, r0, #3
        lsl               r8, r3, r7
        lsl               r5, r5, r7
        lsl               r6, r6, r7
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r5
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r7
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #255
        ldr               r9, [pc, #0x6c]         @ 3f
        orr               r3, r3, #65280
        and               r5, r1, r3
        mov               r1, #24
        and               r7, r1, r0, lsl #3
        and               r6, r2, r3
        bic               r2, r0, #3
        lsl               r8, r3, r7
        lsl               r5, r5, r7
        lsl               r6, r6, r7
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r5
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r7
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #255
        ldr               r9, [pc, #0x6c]         @ 3f
        orr               r3, r3, #65280
        and               r5, r1, r3
        mov               r1, #24
        and               r7, r1, r0, lsl #3
        and               r6, r2, r3
        bic               r2, r0, #3
        lsl               r8, r3, r7
        lsl               r5, r5, r7
        lsl               r6, r6, r7
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r5
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r7
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #255
        ldr               r9, [pc, #0x6c]         @ 3f
        orr               r3, r3, #65280
        and               r5, r1, r3
        mov               r1, #24
        and               r7, r1, r0, lsl #3
        and               r6, r2, r3
        bic               r2, r0, #3
        lsl               r8, r3, r7
        lsl               r5, r5, r7
        lsl               r6, r6, r7
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r5
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r7
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::release_seqcst:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #255
        ldr               r9, [pc, #0x6c]         @ 3f
        orr               r3, r3, #65280
        and               r5, r1, r3
        mov               r1, #24
        and               r7, r1, r0, lsl #3
        and               r6, r2, r3
        bic               r2, r0, #3
        lsl               r8, r3, r7
        lsl               r5, r5, r7
        lsl               r6, r6, r7
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r5
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r7
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #255
        ldr               r9, [pc, #0x6c]         @ 3f
        orr               r3, r3, #65280
        and               r5, r1, r3
        mov               r1, #24
        and               r7, r1, r0, lsl #3
        and               r6, r2, r3
        bic               r2, r0, #3
        lsl               r8, r3, r7
        lsl               r5, r5, r7
        lsl               r6, r6, r7
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r5
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r7
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #255
        ldr               r9, [pc, #0x6c]         @ 3f
        orr               r3, r3, #65280
        and               r5, r1, r3
        mov               r1, #24
        and               r7, r1, r0, lsl #3
        and               r6, r2, r3
        bic               r2, r0, #3
        lsl               r8, r3, r7
        lsl               r5, r5, r7
        lsl               r6, r6, r7
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r5
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r7
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::acquire_acquire:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #255
        ldr               r9, [pc, #0x6c]         @ 3f
        orr               r3, r3, #65280
        and               r5, r1, r3
        mov               r1, #24
        and               r7, r1, r0, lsl #3
        and               r6, r2, r3
        bic               r2, r0, #3
        lsl               r8, r3, r7
        lsl               r5, r5, r7
        lsl               r6, r6, r7
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r5
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r7
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #255
        ldr               r9, [pc, #0x6c]         @ 3f
        orr               r3, r3, #65280
        and               r5, r1, r3
        mov               r1, #24
        and               r7, r1, r0, lsl #3
        and               r6, r2, r3
        bic               r2, r0, #3
        lsl               r8, r3, r7
        lsl               r5, r5, r7
        lsl               r6, r6, r7
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r5
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r7
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #255
        ldr               r9, [pc, #0x6c]         @ 3f
        orr               r3, r3, #65280
        and               r5, r1, r3
        mov               r1, #24
        and               r7, r1, r0, lsl #3
        and               r6, r2, r3
        bic               r2, r0, #3
        lsl               r8, r3, r7
        lsl               r5, r5, r7
        lsl               r6, r6, r7
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r5
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r7
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #255
        ldr               r9, [pc, #0x6c]         @ 3f
        orr               r3, r3, #65280
        and               r5, r1, r3
        mov               r1, #24
        and               r7, r1, r0, lsl #3
        and               r6, r2, r3
        bic               r2, r0, #3
        lsl               r8, r3, r7
        lsl               r5, r5, r7
        lsl               r6, r6, r7
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r5
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r7
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::release_acquire:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #255
        ldr               r9, [pc, #0x6c]         @ 3f
        orr               r3, r3, #65280
        and               r5, r1, r3
        mov               r1, #24
        and               r7, r1, r0, lsl #3
        and               r6, r2, r3
        bic               r2, r0, #3
        lsl               r8, r3, r7
        lsl               r5, r5, r7
        lsl               r6, r6, r7
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r5
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r7
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u16::release_relaxed:
        push              {r4, r5, r6, r7, r8, r9, r11, lr}
        mov               r3, #255
        ldr               r9, [pc, #0x6c]         @ 3f
        orr               r3, r3, #65280
        and               r5, r1, r3
        mov               r1, #24
        and               r7, r1, r0, lsl #3
        and               r6, r2, r3
        bic               r2, r0, #3
        lsl               r8, r3, r7
        lsl               r5, r5, r7
        lsl               r6, r6, r7
0:
        ldr               r0, [r2]
        and               r4, r0, r8
        cmp               r4, r5
        bne               1f
        mvn               r1, r8
        and               r1, r0, r1
        orr               r1, r1, r6
        blx               r9
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r9
        blo               0b
        mov               r0, #1
2:
        lsr               r4, r4, r7
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, r9, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        push              {r4, r5, r6, r7, r11, lr}
        mov               r4, r2
        mov               r5, r1
        ldr               r7, [pc, #0x40]         @ 3f
        mov               r2, r0
0:
        ldr               r6, [r2]
        mov               r0, r6
        cmp               r6, r5
        bne               1f
        mov               r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r7
        blo               0b
        mov               r0, #1
2:
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r6
        pop               {r4, r5, r6, r7, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        push              {r4, r5, r6, r7, r11, lr}
        mov               r4, r2
        mov               r5, r1
        ldr               r7, [pc, #0x40]         @ 3f
        mov               r2, r0
0:
        ldr               r6, [r2]
        mov               r0, r6
        cmp               r6, r5
        bne               1f
        mov               r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r7
        blo               0b
        mov               r0, #1
2:
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r6
        pop               {r4, r5, r6, r7, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        push              {r4, r5, r6, r7, r11, lr}
        mov               r4, r2
        mov               r5, r1
        ldr               r7, [pc, #0x40]         @ 3f
        mov               r2, r0
0:
        ldr               r6, [r2]
        mov               r0, r6
        cmp               r6, r5
        bne               1f
        mov               r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r7
        blo               0b
        mov               r0, #1
2:
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r6
        pop               {r4, r5, r6, r7, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        push              {r4, r5, r6, r7, r11, lr}
        mov               r4, r2
        mov               r5, r1
        ldr               r7, [pc, #0x40]         @ 3f
        mov               r2, r0
0:
        ldr               r6, [r2]
        mov               r0, r6
        cmp               r6, r5
        bne               1f
        mov               r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r7
        blo               0b
        mov               r0, #1
2:
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r6
        pop               {r4, r5, r6, r7, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        push              {r4, r5, r6, r7, r11, lr}
        mov               r4, r2
        mov               r5, r1
        ldr               r7, [pc, #0x40]         @ 3f
        mov               r2, r0
0:
        ldr               r6, [r2]
        mov               r0, r6
        cmp               r6, r5
        bne               1f
        mov               r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r7
        blo               0b
        mov               r0, #1
2:
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r6
        pop               {r4, r5, r6, r7, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        push              {r4, r5, r6, r7, r11, lr}
        mov               r4, r2
        mov               r5, r1
        ldr               r7, [pc, #0x40]         @ 3f
        mov               r2, r0
0:
        ldr               r6, [r2]
        mov               r0, r6
        cmp               r6, r5
        bne               1f
        mov               r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r7
        blo               0b
        mov               r0, #1
2:
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r6
        pop               {r4, r5, r6, r7, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::release_seqcst:
        push              {r4, r5, r6, r7, r11, lr}
        mov               r4, r2
        mov               r5, r1
        ldr               r7, [pc, #0x40]         @ 3f
        mov               r2, r0
0:
        ldr               r6, [r2]
        mov               r0, r6
        cmp               r6, r5
        bne               1f
        mov               r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r7
        blo               0b
        mov               r0, #1
2:
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r6
        pop               {r4, r5, r6, r7, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        push              {r4, r5, r6, r7, r11, lr}
        mov               r4, r2
        mov               r5, r1
        ldr               r7, [pc, #0x40]         @ 3f
        mov               r2, r0
0:
        ldr               r6, [r2]
        mov               r0, r6
        cmp               r6, r5
        bne               1f
        mov               r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r7
        blo               0b
        mov               r0, #1
2:
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r6
        pop               {r4, r5, r6, r7, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        push              {r4, r5, r6, r7, r11, lr}
        mov               r4, r2
        mov               r5, r1
        ldr               r7, [pc, #0x40]         @ 3f
        mov               r2, r0
0:
        ldr               r6, [r2]
        mov               r0, r6
        cmp               r6, r5
        bne               1f
        mov               r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r7
        blo               0b
        mov               r0, #1
2:
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r6
        pop               {r4, r5, r6, r7, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::acquire_acquire:
        push              {r4, r5, r6, r7, r11, lr}
        mov               r4, r2
        mov               r5, r1
        ldr               r7, [pc, #0x40]         @ 3f
        mov               r2, r0
0:
        ldr               r6, [r2]
        mov               r0, r6
        cmp               r6, r5
        bne               1f
        mov               r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r7
        blo               0b
        mov               r0, #1
2:
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r6
        pop               {r4, r5, r6, r7, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        push              {r4, r5, r6, r7, r11, lr}
        mov               r4, r2
        mov               r5, r1
        ldr               r7, [pc, #0x40]         @ 3f
        mov               r2, r0
0:
        ldr               r6, [r2]
        mov               r0, r6
        cmp               r6, r5
        bne               1f
        mov               r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r7
        blo               0b
        mov               r0, #1
2:
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r6
        pop               {r4, r5, r6, r7, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        push              {r4, r5, r6, r7, r11, lr}
        mov               r4, r2
        mov               r5, r1
        ldr               r7, [pc, #0x40]         @ 3f
        mov               r2, r0
0:
        ldr               r6, [r2]
        mov               r0, r6
        cmp               r6, r5
        bne               1f
        mov               r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r7
        blo               0b
        mov               r0, #1
2:
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r6
        pop               {r4, r5, r6, r7, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        push              {r4, r5, r6, r7, r11, lr}
        mov               r4, r2
        mov               r5, r1
        ldr               r7, [pc, #0x40]         @ 3f
        mov               r2, r0
0:
        ldr               r6, [r2]
        mov               r0, r6
        cmp               r6, r5
        bne               1f
        mov               r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r7
        blo               0b
        mov               r0, #1
2:
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r6
        pop               {r4, r5, r6, r7, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::release_acquire:
        push              {r4, r5, r6, r7, r11, lr}
        mov               r4, r2
        mov               r5, r1
        ldr               r7, [pc, #0x40]         @ 3f
        mov               r2, r0
0:
        ldr               r6, [r2]
        mov               r0, r6
        cmp               r6, r5
        bne               1f
        mov               r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r7
        blo               0b
        mov               r0, #1
2:
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r6
        pop               {r4, r5, r6, r7, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u32::release_relaxed:
        push              {r4, r5, r6, r7, r11, lr}
        mov               r4, r2
        mov               r5, r1
        ldr               r7, [pc, #0x40]         @ 3f
        mov               r2, r0
0:
        ldr               r6, [r2]
        mov               r0, r6
        cmp               r6, r5
        bne               1f
        mov               r1, r4
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r0
        blx               r7
        blo               0b
        mov               r0, #1
2:
        clz               r0, r0
        lsr               r1, r0, #5
        mov               r0, r6
        pop               {r4, r5, r6, r7, r11, pc}
3:
        .word             0xffff0fc0

asm_test::compare_exchange_weak::u64::acqrel_seqcst:
        push              {r4, r5, r6, r7, r11, lr}
        sub               sp, sp, #8
        mov               r12, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        mvn               r0, #3
        sub               r0, r0, #61440
        ldr               r0, [r0]
        cmp               r0, #4
        ble               3f
        mvn               r7, #159
        mov               r5, r2
        mov               r4, r3
        mov               r6, sp
        sub               r7, r7, #61440
        mov               r2, r1
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r12]
        str               r1, [r12, #0x4]
        eor               r0, r0, r5
        eor               r1, r1, r4
        orrs              r0, r0, r1
        mov               r0, r12
        bne               1f
        mov               r1, r6
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r12
        blx               r7
        blo               0b
        mov               r0, #1
2:
        eor               r0, r0, #1
        strb              r0, [r12, #0x8]
        add               sp, sp, #8
        pop               {r4, r5, r6, r7, r11, pc}
3:
        bl                3f

asm_test::compare_exchange_weak::u64::seqcst_seqcst:
        push              {r4, r5, r6, r7, r11, lr}
        sub               sp, sp, #8
        mov               r12, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        mvn               r0, #3
        sub               r0, r0, #61440
        ldr               r0, [r0]
        cmp               r0, #4
        ble               3f
        mvn               r7, #159
        mov               r5, r2
        mov               r4, r3
        mov               r6, sp
        sub               r7, r7, #61440
        mov               r2, r1
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r12]
        str               r1, [r12, #0x4]
        eor               r0, r0, r5
        eor               r1, r1, r4
        orrs              r0, r0, r1
        mov               r0, r12
        bne               1f
        mov               r1, r6
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r12
        blx               r7
        blo               0b
        mov               r0, #1
2:
        eor               r0, r0, #1
        strb              r0, [r12, #0x8]
        add               sp, sp, #8
        pop               {r4, r5, r6, r7, r11, pc}
3:
        bl                3f

asm_test::compare_exchange_weak::u64::acqrel_acquire:
        push              {r4, r5, r6, r7, r11, lr}
        sub               sp, sp, #8
        mov               r12, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        mvn               r0, #3
        sub               r0, r0, #61440
        ldr               r0, [r0]
        cmp               r0, #4
        ble               3f
        mvn               r7, #159
        mov               r5, r2
        mov               r4, r3
        mov               r6, sp
        sub               r7, r7, #61440
        mov               r2, r1
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r12]
        str               r1, [r12, #0x4]
        eor               r0, r0, r5
        eor               r1, r1, r4
        orrs              r0, r0, r1
        mov               r0, r12
        bne               1f
        mov               r1, r6
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r12
        blx               r7
        blo               0b
        mov               r0, #1
2:
        eor               r0, r0, #1
        strb              r0, [r12, #0x8]
        add               sp, sp, #8
        pop               {r4, r5, r6, r7, r11, pc}
3:
        bl                3f

asm_test::compare_exchange_weak::u64::acqrel_relaxed:
        push              {r4, r5, r6, r7, r11, lr}
        sub               sp, sp, #8
        mov               r12, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        mvn               r0, #3
        sub               r0, r0, #61440
        ldr               r0, [r0]
        cmp               r0, #4
        ble               3f
        mvn               r7, #159
        mov               r5, r2
        mov               r4, r3
        mov               r6, sp
        sub               r7, r7, #61440
        mov               r2, r1
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r12]
        str               r1, [r12, #0x4]
        eor               r0, r0, r5
        eor               r1, r1, r4
        orrs              r0, r0, r1
        mov               r0, r12
        bne               1f
        mov               r1, r6
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r12
        blx               r7
        blo               0b
        mov               r0, #1
2:
        eor               r0, r0, #1
        strb              r0, [r12, #0x8]
        add               sp, sp, #8
        pop               {r4, r5, r6, r7, r11, pc}
3:
        bl                3f

asm_test::compare_exchange_weak::u64::acquire_seqcst:
        push              {r4, r5, r6, r7, r11, lr}
        sub               sp, sp, #8
        mov               r12, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        mvn               r0, #3
        sub               r0, r0, #61440
        ldr               r0, [r0]
        cmp               r0, #4
        ble               3f
        mvn               r7, #159
        mov               r5, r2
        mov               r4, r3
        mov               r6, sp
        sub               r7, r7, #61440
        mov               r2, r1
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r12]
        str               r1, [r12, #0x4]
        eor               r0, r0, r5
        eor               r1, r1, r4
        orrs              r0, r0, r1
        mov               r0, r12
        bne               1f
        mov               r1, r6
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r12
        blx               r7
        blo               0b
        mov               r0, #1
2:
        eor               r0, r0, #1
        strb              r0, [r12, #0x8]
        add               sp, sp, #8
        pop               {r4, r5, r6, r7, r11, pc}
3:
        bl                3f

asm_test::compare_exchange_weak::u64::relaxed_seqcst:
        push              {r4, r5, r6, r7, r11, lr}
        sub               sp, sp, #8
        mov               r12, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        mvn               r0, #3
        sub               r0, r0, #61440
        ldr               r0, [r0]
        cmp               r0, #4
        ble               3f
        mvn               r7, #159
        mov               r5, r2
        mov               r4, r3
        mov               r6, sp
        sub               r7, r7, #61440
        mov               r2, r1
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r12]
        str               r1, [r12, #0x4]
        eor               r0, r0, r5
        eor               r1, r1, r4
        orrs              r0, r0, r1
        mov               r0, r12
        bne               1f
        mov               r1, r6
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r12
        blx               r7
        blo               0b
        mov               r0, #1
2:
        eor               r0, r0, #1
        strb              r0, [r12, #0x8]
        add               sp, sp, #8
        pop               {r4, r5, r6, r7, r11, pc}
3:
        bl                3f

asm_test::compare_exchange_weak::u64::release_seqcst:
        push              {r4, r5, r6, r7, r11, lr}
        sub               sp, sp, #8
        mov               r12, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        mvn               r0, #3
        sub               r0, r0, #61440
        ldr               r0, [r0]
        cmp               r0, #4
        ble               3f
        mvn               r7, #159
        mov               r5, r2
        mov               r4, r3
        mov               r6, sp
        sub               r7, r7, #61440
        mov               r2, r1
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r12]
        str               r1, [r12, #0x4]
        eor               r0, r0, r5
        eor               r1, r1, r4
        orrs              r0, r0, r1
        mov               r0, r12
        bne               1f
        mov               r1, r6
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r12
        blx               r7
        blo               0b
        mov               r0, #1
2:
        eor               r0, r0, #1
        strb              r0, [r12, #0x8]
        add               sp, sp, #8
        pop               {r4, r5, r6, r7, r11, pc}
3:
        bl                3f

asm_test::compare_exchange_weak::u64::seqcst_acquire:
        push              {r4, r5, r6, r7, r11, lr}
        sub               sp, sp, #8
        mov               r12, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        mvn               r0, #3
        sub               r0, r0, #61440
        ldr               r0, [r0]
        cmp               r0, #4
        ble               3f
        mvn               r7, #159
        mov               r5, r2
        mov               r4, r3
        mov               r6, sp
        sub               r7, r7, #61440
        mov               r2, r1
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r12]
        str               r1, [r12, #0x4]
        eor               r0, r0, r5
        eor               r1, r1, r4
        orrs              r0, r0, r1
        mov               r0, r12
        bne               1f
        mov               r1, r6
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r12
        blx               r7
        blo               0b
        mov               r0, #1
2:
        eor               r0, r0, #1
        strb              r0, [r12, #0x8]
        add               sp, sp, #8
        pop               {r4, r5, r6, r7, r11, pc}
3:
        bl                3f

asm_test::compare_exchange_weak::u64::seqcst_relaxed:
        push              {r4, r5, r6, r7, r11, lr}
        sub               sp, sp, #8
        mov               r12, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        mvn               r0, #3
        sub               r0, r0, #61440
        ldr               r0, [r0]
        cmp               r0, #4
        ble               3f
        mvn               r7, #159
        mov               r5, r2
        mov               r4, r3
        mov               r6, sp
        sub               r7, r7, #61440
        mov               r2, r1
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r12]
        str               r1, [r12, #0x4]
        eor               r0, r0, r5
        eor               r1, r1, r4
        orrs              r0, r0, r1
        mov               r0, r12
        bne               1f
        mov               r1, r6
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r12
        blx               r7
        blo               0b
        mov               r0, #1
2:
        eor               r0, r0, #1
        strb              r0, [r12, #0x8]
        add               sp, sp, #8
        pop               {r4, r5, r6, r7, r11, pc}
3:
        bl                3f

asm_test::compare_exchange_weak::u64::acquire_acquire:
        push              {r4, r5, r6, r7, r11, lr}
        sub               sp, sp, #8
        mov               r12, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        mvn               r0, #3
        sub               r0, r0, #61440
        ldr               r0, [r0]
        cmp               r0, #4
        ble               3f
        mvn               r7, #159
        mov               r5, r2
        mov               r4, r3
        mov               r6, sp
        sub               r7, r7, #61440
        mov               r2, r1
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r12]
        str               r1, [r12, #0x4]
        eor               r0, r0, r5
        eor               r1, r1, r4
        orrs              r0, r0, r1
        mov               r0, r12
        bne               1f
        mov               r1, r6
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r12
        blx               r7
        blo               0b
        mov               r0, #1
2:
        eor               r0, r0, #1
        strb              r0, [r12, #0x8]
        add               sp, sp, #8
        pop               {r4, r5, r6, r7, r11, pc}
3:
        bl                3f

asm_test::compare_exchange_weak::u64::acquire_relaxed:
        push              {r4, r5, r6, r7, r11, lr}
        sub               sp, sp, #8
        mov               r12, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        mvn               r0, #3
        sub               r0, r0, #61440
        ldr               r0, [r0]
        cmp               r0, #4
        ble               3f
        mvn               r7, #159
        mov               r5, r2
        mov               r4, r3
        mov               r6, sp
        sub               r7, r7, #61440
        mov               r2, r1
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r12]
        str               r1, [r12, #0x4]
        eor               r0, r0, r5
        eor               r1, r1, r4
        orrs              r0, r0, r1
        mov               r0, r12
        bne               1f
        mov               r1, r6
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r12
        blx               r7
        blo               0b
        mov               r0, #1
2:
        eor               r0, r0, #1
        strb              r0, [r12, #0x8]
        add               sp, sp, #8
        pop               {r4, r5, r6, r7, r11, pc}
3:
        bl                3f

asm_test::compare_exchange_weak::u64::relaxed_acquire:
        push              {r4, r5, r6, r7, r11, lr}
        sub               sp, sp, #8
        mov               r12, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        mvn               r0, #3
        sub               r0, r0, #61440
        ldr               r0, [r0]
        cmp               r0, #4
        ble               3f
        mvn               r7, #159
        mov               r5, r2
        mov               r4, r3
        mov               r6, sp
        sub               r7, r7, #61440
        mov               r2, r1
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r12]
        str               r1, [r12, #0x4]
        eor               r0, r0, r5
        eor               r1, r1, r4
        orrs              r0, r0, r1
        mov               r0, r12
        bne               1f
        mov               r1, r6
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r12
        blx               r7
        blo               0b
        mov               r0, #1
2:
        eor               r0, r0, #1
        strb              r0, [r12, #0x8]
        add               sp, sp, #8
        pop               {r4, r5, r6, r7, r11, pc}
3:
        bl                3f

asm_test::compare_exchange_weak::u64::relaxed_relaxed:
        push              {r4, r5, r6, r7, r11, lr}
        sub               sp, sp, #8
        mov               r12, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        mvn               r0, #3
        sub               r0, r0, #61440
        ldr               r0, [r0]
        cmp               r0, #4
        ble               3f
        mvn               r7, #159
        mov               r5, r2
        mov               r4, r3
        mov               r6, sp
        sub               r7, r7, #61440
        mov               r2, r1
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r12]
        str               r1, [r12, #0x4]
        eor               r0, r0, r5
        eor               r1, r1, r4
        orrs              r0, r0, r1
        mov               r0, r12
        bne               1f
        mov               r1, r6
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r12
        blx               r7
        blo               0b
        mov               r0, #1
2:
        eor               r0, r0, #1
        strb              r0, [r12, #0x8]
        add               sp, sp, #8
        pop               {r4, r5, r6, r7, r11, pc}
3:
        bl                3f

asm_test::compare_exchange_weak::u64::release_acquire:
        push              {r4, r5, r6, r7, r11, lr}
        sub               sp, sp, #8
        mov               r12, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        mvn               r0, #3
        sub               r0, r0, #61440
        ldr               r0, [r0]
        cmp               r0, #4
        ble               3f
        mvn               r7, #159
        mov               r5, r2
        mov               r4, r3
        mov               r6, sp
        sub               r7, r7, #61440
        mov               r2, r1
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r12]
        str               r1, [r12, #0x4]
        eor               r0, r0, r5
        eor               r1, r1, r4
        orrs              r0, r0, r1
        mov               r0, r12
        bne               1f
        mov               r1, r6
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r12
        blx               r7
        blo               0b
        mov               r0, #1
2:
        eor               r0, r0, #1
        strb              r0, [r12, #0x8]
        add               sp, sp, #8
        pop               {r4, r5, r6, r7, r11, pc}
3:
        bl                3f

asm_test::compare_exchange_weak::u64::release_relaxed:
        push              {r4, r5, r6, r7, r11, lr}
        sub               sp, sp, #8
        mov               r12, r0
        ldr               r0, [sp, #0x24]
        str               r0, [sp, #0x4]
        ldr               r0, [sp, #0x20]
        str               r0, [sp]
        mvn               r0, #3
        sub               r0, r0, #61440
        ldr               r0, [r0]
        cmp               r0, #4
        ble               3f
        mvn               r7, #159
        mov               r5, r2
        mov               r4, r3
        mov               r6, sp
        sub               r7, r7, #61440
        mov               r2, r1
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r12]
        str               r1, [r12, #0x4]
        eor               r0, r0, r5
        eor               r1, r1, r4
        orrs              r0, r0, r1
        mov               r0, r12
        bne               1f
        mov               r1, r6
        blx               r7
        blo               0b
        b                 2f
1:
        mov               r1, r12
        blx               r7
        blo               0b
        mov               r0, #1
2:
        eor               r0, r0, #1
        strb              r0, [r12, #0x8]
        add               sp, sp, #8
        pop               {r4, r5, r6, r7, r11, pc}
3:
        bl                3f

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
        push              {r4, lr}
        sub               sp, sp, #8
        mvn               r1, #3
        sub               r1, r1, #61440
        ldr               r1, [r1]
        cmp               r1, #5
        blt               1f
        mvn               r4, #159
        mov               r12, sp
        sub               r4, r4, #61440
        mov               r2, r0
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r12]
        str               r1, [r12, #0x4]
        mov               r0, r12
        mov               r1, r12
        blx               r4
        blo               0b
        pop               {r0, r1}
        pop               {r4, pc}
1:
        bl                1f

asm_test::load::u64::acquire:
        push              {r4, lr}
        sub               sp, sp, #8
        mvn               r1, #3
        sub               r1, r1, #61440
        ldr               r1, [r1]
        cmp               r1, #5
        blt               1f
        mvn               r4, #159
        mov               r12, sp
        sub               r4, r4, #61440
        mov               r2, r0
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r12]
        str               r1, [r12, #0x4]
        mov               r0, r12
        mov               r1, r12
        blx               r4
        blo               0b
        pop               {r0, r1}
        pop               {r4, pc}
1:
        bl                1f

asm_test::load::u64::relaxed:
        push              {r4, lr}
        sub               sp, sp, #8
        mvn               r1, #3
        sub               r1, r1, #61440
        ldr               r1, [r1]
        cmp               r1, #5
        blt               1f
        mvn               r4, #159
        mov               r12, sp
        sub               r4, r4, #61440
        mov               r2, r0
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r12]
        str               r1, [r12, #0x4]
        mov               r0, r12
        mov               r1, r12
        blx               r4
        blo               0b
        pop               {r0, r1}
        pop               {r4, pc}
1:
        bl                1f

asm_test::swap::u8::acqrel:
        push              {r4, r5, r6, r7, r8, lr}
        mov               r2, #24
        and               r5, r2, r0, lsl #3
        mov               r2, #255
        and               r7, r1, #255
        mvn               r6, r2, lsl r5
        bic               r2, r0, #3
        ldr               r8, [pc, #0x24]         @ 1f
        lsl               r7, r7, r5
0:
        ldr               r4, [r2]
        mov               r0, r4
        and               r1, r0, r6
        orr               r1, r1, r7
        blx               r8
        blo               0b
        lsr               r4, r4, r5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, pc}
1:
        .word             0xffff0fc0

asm_test::swap::u8::seqcst:
        push              {r4, r5, r6, r7, r8, lr}
        mov               r2, #24
        and               r5, r2, r0, lsl #3
        mov               r2, #255
        and               r7, r1, #255
        mvn               r6, r2, lsl r5
        bic               r2, r0, #3
        ldr               r8, [pc, #0x24]         @ 1f
        lsl               r7, r7, r5
0:
        ldr               r4, [r2]
        mov               r0, r4
        and               r1, r0, r6
        orr               r1, r1, r7
        blx               r8
        blo               0b
        lsr               r4, r4, r5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, pc}
1:
        .word             0xffff0fc0

asm_test::swap::u8::acquire:
        push              {r4, r5, r6, r7, r8, lr}
        mov               r2, #24
        and               r5, r2, r0, lsl #3
        mov               r2, #255
        and               r7, r1, #255
        mvn               r6, r2, lsl r5
        bic               r2, r0, #3
        ldr               r8, [pc, #0x24]         @ 1f
        lsl               r7, r7, r5
0:
        ldr               r4, [r2]
        mov               r0, r4
        and               r1, r0, r6
        orr               r1, r1, r7
        blx               r8
        blo               0b
        lsr               r4, r4, r5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, pc}
1:
        .word             0xffff0fc0

asm_test::swap::u8::relaxed:
        push              {r4, r5, r6, r7, r8, lr}
        mov               r2, #24
        and               r5, r2, r0, lsl #3
        mov               r2, #255
        and               r7, r1, #255
        mvn               r6, r2, lsl r5
        bic               r2, r0, #3
        ldr               r8, [pc, #0x24]         @ 1f
        lsl               r7, r7, r5
0:
        ldr               r4, [r2]
        mov               r0, r4
        and               r1, r0, r6
        orr               r1, r1, r7
        blx               r8
        blo               0b
        lsr               r4, r4, r5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, pc}
1:
        .word             0xffff0fc0

asm_test::swap::u8::release:
        push              {r4, r5, r6, r7, r8, lr}
        mov               r2, #24
        and               r5, r2, r0, lsl #3
        mov               r2, #255
        and               r7, r1, #255
        mvn               r6, r2, lsl r5
        bic               r2, r0, #3
        ldr               r8, [pc, #0x24]         @ 1f
        lsl               r7, r7, r5
0:
        ldr               r4, [r2]
        mov               r0, r4
        and               r1, r0, r6
        orr               r1, r1, r7
        blx               r8
        blo               0b
        lsr               r4, r4, r5
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, pc}
1:
        .word             0xffff0fc0

asm_test::swap::u16::acqrel:
        push              {r4, r5, r6, r7, r8, lr}
        mov               r2, #255
        ldr               r8, [pc, #0x3c]         @ 1f
        orr               r2, r2, #65280
        and               r5, r1, r2
        mov               r1, #24
        and               r6, r1, r0, lsl #3
        mvn               r7, r2, lsl r6
        bic               r2, r0, #3
        lsl               r5, r5, r6
0:
        ldr               r4, [r2]
        mov               r0, r4
        and               r1, r0, r7
        orr               r1, r1, r5
        blx               r8
        blo               0b
        lsr               r4, r4, r6
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, pc}
1:
        .word             0xffff0fc0

asm_test::swap::u16::seqcst:
        push              {r4, r5, r6, r7, r8, lr}
        mov               r2, #255
        ldr               r8, [pc, #0x3c]         @ 1f
        orr               r2, r2, #65280
        and               r5, r1, r2
        mov               r1, #24
        and               r6, r1, r0, lsl #3
        mvn               r7, r2, lsl r6
        bic               r2, r0, #3
        lsl               r5, r5, r6
0:
        ldr               r4, [r2]
        mov               r0, r4
        and               r1, r0, r7
        orr               r1, r1, r5
        blx               r8
        blo               0b
        lsr               r4, r4, r6
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, pc}
1:
        .word             0xffff0fc0

asm_test::swap::u16::acquire:
        push              {r4, r5, r6, r7, r8, lr}
        mov               r2, #255
        ldr               r8, [pc, #0x3c]         @ 1f
        orr               r2, r2, #65280
        and               r5, r1, r2
        mov               r1, #24
        and               r6, r1, r0, lsl #3
        mvn               r7, r2, lsl r6
        bic               r2, r0, #3
        lsl               r5, r5, r6
0:
        ldr               r4, [r2]
        mov               r0, r4
        and               r1, r0, r7
        orr               r1, r1, r5
        blx               r8
        blo               0b
        lsr               r4, r4, r6
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, pc}
1:
        .word             0xffff0fc0

asm_test::swap::u16::relaxed:
        push              {r4, r5, r6, r7, r8, lr}
        mov               r2, #255
        ldr               r8, [pc, #0x3c]         @ 1f
        orr               r2, r2, #65280
        and               r5, r1, r2
        mov               r1, #24
        and               r6, r1, r0, lsl #3
        mvn               r7, r2, lsl r6
        bic               r2, r0, #3
        lsl               r5, r5, r6
0:
        ldr               r4, [r2]
        mov               r0, r4
        and               r1, r0, r7
        orr               r1, r1, r5
        blx               r8
        blo               0b
        lsr               r4, r4, r6
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, pc}
1:
        .word             0xffff0fc0

asm_test::swap::u16::release:
        push              {r4, r5, r6, r7, r8, lr}
        mov               r2, #255
        ldr               r8, [pc, #0x3c]         @ 1f
        orr               r2, r2, #65280
        and               r5, r1, r2
        mov               r1, #24
        and               r6, r1, r0, lsl #3
        mvn               r7, r2, lsl r6
        bic               r2, r0, #3
        lsl               r5, r5, r6
0:
        ldr               r4, [r2]
        mov               r0, r4
        and               r1, r0, r7
        orr               r1, r1, r5
        blx               r8
        blo               0b
        lsr               r4, r4, r6
        mov               r0, r4
        pop               {r4, r5, r6, r7, r8, pc}
1:
        .word             0xffff0fc0

asm_test::swap::u32::acqrel:
        push              {r4, r5, r11, lr}
        ldr               r5, [pc, #0x18]         @ 1f
        mov               r2, r0
0:
        ldr               r4, [r2]
        mov               r0, r4
        blx               r5
        blo               0b
        mov               r0, r4
        pop               {r4, r5, r11, pc}
1:
        .word             0xffff0fc0

asm_test::swap::u32::seqcst:
        push              {r4, r5, r11, lr}
        ldr               r5, [pc, #0x18]         @ 1f
        mov               r2, r0
0:
        ldr               r4, [r2]
        mov               r0, r4
        blx               r5
        blo               0b
        mov               r0, r4
        pop               {r4, r5, r11, pc}
1:
        .word             0xffff0fc0

asm_test::swap::u32::acquire:
        push              {r4, r5, r11, lr}
        ldr               r5, [pc, #0x18]         @ 1f
        mov               r2, r0
0:
        ldr               r4, [r2]
        mov               r0, r4
        blx               r5
        blo               0b
        mov               r0, r4
        pop               {r4, r5, r11, pc}
1:
        .word             0xffff0fc0

asm_test::swap::u32::relaxed:
        push              {r4, r5, r11, lr}
        ldr               r5, [pc, #0x18]         @ 1f
        mov               r2, r0
0:
        ldr               r4, [r2]
        mov               r0, r4
        blx               r5
        blo               0b
        mov               r0, r4
        pop               {r4, r5, r11, pc}
1:
        .word             0xffff0fc0

asm_test::swap::u32::release:
        push              {r4, r5, r11, lr}
        ldr               r5, [pc, #0x18]         @ 1f
        mov               r2, r0
0:
        ldr               r4, [r2]
        mov               r0, r4
        blx               r5
        blo               0b
        mov               r0, r4
        pop               {r4, r5, r11, pc}
1:
        .word             0xffff0fc0

asm_test::swap::u64::acqrel:
        push              {r4, r5, r11, lr}
        sub               sp, sp, #16
        mvn               r1, #3
        stm               sp, {r2, r3}
        sub               r1, r1, #61440
        ldr               r1, [r1]
        cmp               r1, #5
        blt               1f
        mvn               r5, #159
        add               r12, sp, #8
        mov               r4, sp
        sub               r5, r5, #61440
        mov               r2, r0
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r12]
        str               r1, [r12, #0x4]
        mov               r0, r12
        mov               r1, r4
        blx               r5
        blo               0b
        ldr               r0, [sp, #0x8]
        ldr               r1, [sp, #0xc]
        add               sp, sp, #16
        pop               {r4, r5, r11, pc}
1:
        bl                1f

asm_test::swap::u64::seqcst:
        push              {r4, r5, r11, lr}
        sub               sp, sp, #16
        mvn               r1, #3
        stm               sp, {r2, r3}
        sub               r1, r1, #61440
        ldr               r1, [r1]
        cmp               r1, #5
        blt               1f
        mvn               r5, #159
        add               r12, sp, #8
        mov               r4, sp
        sub               r5, r5, #61440
        mov               r2, r0
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r12]
        str               r1, [r12, #0x4]
        mov               r0, r12
        mov               r1, r4
        blx               r5
        blo               0b
        ldr               r0, [sp, #0x8]
        ldr               r1, [sp, #0xc]
        add               sp, sp, #16
        pop               {r4, r5, r11, pc}
1:
        bl                1f

asm_test::swap::u64::acquire:
        push              {r4, r5, r11, lr}
        sub               sp, sp, #16
        mvn               r1, #3
        stm               sp, {r2, r3}
        sub               r1, r1, #61440
        ldr               r1, [r1]
        cmp               r1, #5
        blt               1f
        mvn               r5, #159
        add               r12, sp, #8
        mov               r4, sp
        sub               r5, r5, #61440
        mov               r2, r0
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r12]
        str               r1, [r12, #0x4]
        mov               r0, r12
        mov               r1, r4
        blx               r5
        blo               0b
        ldr               r0, [sp, #0x8]
        ldr               r1, [sp, #0xc]
        add               sp, sp, #16
        pop               {r4, r5, r11, pc}
1:
        bl                1f

asm_test::swap::u64::relaxed:
        push              {r4, r5, r11, lr}
        sub               sp, sp, #16
        mvn               r1, #3
        stm               sp, {r2, r3}
        sub               r1, r1, #61440
        ldr               r1, [r1]
        cmp               r1, #5
        blt               1f
        mvn               r5, #159
        add               r12, sp, #8
        mov               r4, sp
        sub               r5, r5, #61440
        mov               r2, r0
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r12]
        str               r1, [r12, #0x4]
        mov               r0, r12
        mov               r1, r4
        blx               r5
        blo               0b
        ldr               r0, [sp, #0x8]
        ldr               r1, [sp, #0xc]
        add               sp, sp, #16
        pop               {r4, r5, r11, pc}
1:
        bl                1f

asm_test::swap::u64::release:
        push              {r4, r5, r11, lr}
        sub               sp, sp, #16
        mvn               r1, #3
        stm               sp, {r2, r3}
        sub               r1, r1, #61440
        ldr               r1, [r1]
        cmp               r1, #5
        blt               1f
        mvn               r5, #159
        add               r12, sp, #8
        mov               r4, sp
        sub               r5, r5, #61440
        mov               r2, r0
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r12]
        str               r1, [r12, #0x4]
        mov               r0, r12
        mov               r1, r4
        blx               r5
        blo               0b
        ldr               r0, [sp, #0x8]
        ldr               r1, [sp, #0xc]
        add               sp, sp, #16
        pop               {r4, r5, r11, pc}
1:
        bl                1f

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
        sub               sp, sp, #16
        mvn               r1, #3
        stm               sp, {r2, r3}
        sub               r1, r1, #61440
        ldr               r1, [r1]
        cmp               r1, #5
        blt               1f
        mvn               r5, #159
        add               r12, sp, #8
        mov               r4, sp
        sub               r5, r5, #61440
        mov               r2, r0
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r12]
        str               r1, [r12, #0x4]
        mov               r0, r12
        mov               r1, r4
        blx               r5
        blo               0b
        add               sp, sp, #16
        pop               {r4, r5, r11, pc}
1:
        bl                1f

asm_test::store::u64::relaxed:
        push              {r4, r5, r11, lr}
        sub               sp, sp, #16
        mvn               r1, #3
        stm               sp, {r2, r3}
        sub               r1, r1, #61440
        ldr               r1, [r1]
        cmp               r1, #5
        blt               1f
        mvn               r5, #159
        add               r12, sp, #8
        mov               r4, sp
        sub               r5, r5, #61440
        mov               r2, r0
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r12]
        str               r1, [r12, #0x4]
        mov               r0, r12
        mov               r1, r4
        blx               r5
        blo               0b
        add               sp, sp, #16
        pop               {r4, r5, r11, pc}
1:
        bl                1f

asm_test::store::u64::release:
        push              {r4, r5, r11, lr}
        sub               sp, sp, #16
        mvn               r1, #3
        stm               sp, {r2, r3}
        sub               r1, r1, #61440
        ldr               r1, [r1]
        cmp               r1, #5
        blt               1f
        mvn               r5, #159
        add               r12, sp, #8
        mov               r4, sp
        sub               r5, r5, #61440
        mov               r2, r0
0:
        ldr               r0, [r2]
        ldr               r1, [r2, #0x4]
        str               r0, [r12]
        str               r1, [r12, #0x4]
        mov               r0, r12
        mov               r1, r4
        blx               r5
        blo               0b
        add               sp, sp, #16
        pop               {r4, r5, r11, pc}
1:
        bl                1f

