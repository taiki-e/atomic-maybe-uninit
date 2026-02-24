asm_test::compare_exchange::u8::acqrel_seqcst:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        movs              r1, #0xff
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange::u8::seqcst_seqcst:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        movs              r1, #0xff
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange::u8::acqrel_acquire:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        movs              r1, #0xff
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange::u8::acqrel_relaxed:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        movs              r1, #0xff
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange::u8::acquire_seqcst:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        movs              r1, #0xff
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange::u8::relaxed_seqcst:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        movs              r1, #0xff
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange::u8::release_seqcst:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        movs              r1, #0xff
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange::u8::seqcst_acquire:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        movs              r1, #0xff
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange::u8::seqcst_relaxed:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        movs              r1, #0xff
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange::u8::acquire_acquire:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        movs              r1, #0xff
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange::u8::acquire_relaxed:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        movs              r1, #0xff
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange::u8::relaxed_acquire:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        movs              r1, #0xff
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange::u8::relaxed_relaxed:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        movs              r1, #0xff
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange::u8::release_acquire:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        movs              r1, #0xff
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange::u8::release_relaxed:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        movs              r1, #0xff
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange::u16::acqrel_seqcst:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        ldr               r1, [pc, #0xc]          @ 1f
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2
1:
        .word             0x0000ffff

asm_test::compare_exchange::u16::seqcst_seqcst:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        ldr               r1, [pc, #0xc]          @ 1f
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2
1:
        .word             0x0000ffff

asm_test::compare_exchange::u16::acqrel_acquire:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        ldr               r1, [pc, #0xc]          @ 1f
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2
1:
        .word             0x0000ffff

asm_test::compare_exchange::u16::acqrel_relaxed:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        ldr               r1, [pc, #0xc]          @ 1f
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2
1:
        .word             0x0000ffff

asm_test::compare_exchange::u16::acquire_seqcst:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        ldr               r1, [pc, #0xc]          @ 1f
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2
1:
        .word             0x0000ffff

asm_test::compare_exchange::u16::relaxed_seqcst:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        ldr               r1, [pc, #0xc]          @ 1f
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2
1:
        .word             0x0000ffff

asm_test::compare_exchange::u16::release_seqcst:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        ldr               r1, [pc, #0xc]          @ 1f
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2
1:
        .word             0x0000ffff

asm_test::compare_exchange::u16::seqcst_acquire:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        ldr               r1, [pc, #0xc]          @ 1f
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2
1:
        .word             0x0000ffff

asm_test::compare_exchange::u16::seqcst_relaxed:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        ldr               r1, [pc, #0xc]          @ 1f
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2
1:
        .word             0x0000ffff

asm_test::compare_exchange::u16::acquire_acquire:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        ldr               r1, [pc, #0xc]          @ 1f
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2
1:
        .word             0x0000ffff

asm_test::compare_exchange::u16::acquire_relaxed:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        ldr               r1, [pc, #0xc]          @ 1f
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2
1:
        .word             0x0000ffff

asm_test::compare_exchange::u16::relaxed_acquire:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        ldr               r1, [pc, #0xc]          @ 1f
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2
1:
        .word             0x0000ffff

asm_test::compare_exchange::u16::relaxed_relaxed:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        ldr               r1, [pc, #0xc]          @ 1f
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2
1:
        .word             0x0000ffff

asm_test::compare_exchange::u16::release_acquire:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        ldr               r1, [pc, #0xc]          @ 1f
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2
1:
        .word             0x0000ffff

asm_test::compare_exchange::u16::release_relaxed:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        ldr               r1, [pc, #0xc]          @ 1f
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2
1:
        .word             0x0000ffff

asm_test::compare_exchange::u32::acqrel_seqcst:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        subs              r2, r0, r4
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange::u32::seqcst_seqcst:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        subs              r2, r0, r4
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange::u32::acqrel_acquire:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        subs              r2, r0, r4
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange::u32::acqrel_relaxed:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        subs              r2, r0, r4
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange::u32::acquire_seqcst:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        subs              r2, r0, r4
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange::u32::relaxed_seqcst:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        subs              r2, r0, r4
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange::u32::release_seqcst:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        subs              r2, r0, r4
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange::u32::seqcst_acquire:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        subs              r2, r0, r4
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange::u32::seqcst_relaxed:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        subs              r2, r0, r4
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange::u32::acquire_acquire:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        subs              r2, r0, r4
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange::u32::acquire_relaxed:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        subs              r2, r0, r4
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange::u32::relaxed_acquire:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        subs              r2, r0, r4
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange::u32::relaxed_relaxed:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        subs              r2, r0, r4
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange::u32::release_acquire:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        subs              r2, r0, r4
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange::u32::release_relaxed:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        subs              r2, r0, r4
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        movs              r1, #0xff
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        movs              r1, #0xff
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        movs              r1, #0xff
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        movs              r1, #0xff
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        movs              r1, #0xff
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        movs              r1, #0xff
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange_weak::u8::release_seqcst:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        movs              r1, #0xff
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        movs              r1, #0xff
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        movs              r1, #0xff
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange_weak::u8::acquire_acquire:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        movs              r1, #0xff
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        movs              r1, #0xff
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        movs              r1, #0xff
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        movs              r1, #0xff
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange_weak::u8::release_acquire:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        movs              r1, #0xff
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange_weak::u8::release_relaxed:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        movs              r1, #0xff
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        ldr               r1, [pc, #0xc]          @ 1f
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2
1:
        .word             0x0000ffff

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        ldr               r1, [pc, #0xc]          @ 1f
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2
1:
        .word             0x0000ffff

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        ldr               r1, [pc, #0xc]          @ 1f
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2
1:
        .word             0x0000ffff

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        ldr               r1, [pc, #0xc]          @ 1f
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2
1:
        .word             0x0000ffff

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        ldr               r1, [pc, #0xc]          @ 1f
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2
1:
        .word             0x0000ffff

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        ldr               r1, [pc, #0xc]          @ 1f
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2
1:
        .word             0x0000ffff

asm_test::compare_exchange_weak::u16::release_seqcst:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        ldr               r1, [pc, #0xc]          @ 1f
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2
1:
        .word             0x0000ffff

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        ldr               r1, [pc, #0xc]          @ 1f
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2
1:
        .word             0x0000ffff

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        ldr               r1, [pc, #0xc]          @ 1f
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2
1:
        .word             0x0000ffff

asm_test::compare_exchange_weak::u16::acquire_acquire:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        ldr               r1, [pc, #0xc]          @ 1f
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2
1:
        .word             0x0000ffff

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        ldr               r1, [pc, #0xc]          @ 1f
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2
1:
        .word             0x0000ffff

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        ldr               r1, [pc, #0xc]          @ 1f
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2
1:
        .word             0x0000ffff

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        ldr               r1, [pc, #0xc]          @ 1f
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2
1:
        .word             0x0000ffff

asm_test::compare_exchange_weak::u16::release_acquire:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        ldr               r1, [pc, #0xc]          @ 1f
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2
1:
        .word             0x0000ffff

asm_test::compare_exchange_weak::u16::release_relaxed:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        ldr               r1, [pc, #0xc]          @ 1f
        ands              r1, r4
        subs              r2, r0, r1
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2
1:
        .word             0x0000ffff

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        subs              r2, r0, r4
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        subs              r2, r0, r4
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        subs              r2, r0, r4
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        subs              r2, r0, r4
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        subs              r2, r0, r4
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        subs              r2, r0, r4
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange_weak::u32::release_seqcst:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        subs              r2, r0, r4
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        subs              r2, r0, r4
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        subs              r2, r0, r4
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange_weak::u32::acquire_acquire:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        subs              r2, r0, r4
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        subs              r2, r0, r4
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        subs              r2, r0, r4
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        subs              r2, r0, r4
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange_weak::u32::release_acquire:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        subs              r2, r0, r4
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::compare_exchange_weak::u32::release_relaxed:
        push              {r4, lr}
        movs              r4, r1
0:
        bl                0f
        subs              r2, r0, r4
        rsbs              r1, r2, #0
        adcs              r1, r2
        pop               {r4}
        pop               {r2}
        bx                r2

asm_test::load::u8::seqcst:
        push              {r7, lr}
        movs              r1, #0x0
        movs              r2, r1
0:
        bl                0f
        pop               {r7}
        pop               {r1}
        bx                r1

asm_test::load::u8::acquire:
        push              {r7, lr}
        movs              r1, #0x0
        movs              r2, r1
0:
        bl                0f
        pop               {r7}
        pop               {r1}
        bx                r1

asm_test::load::u8::relaxed:
        ldrb              r0, [r0]
        bx                lr

asm_test::load::u16::seqcst:
        push              {r7, lr}
        movs              r1, #0x0
        movs              r2, r1
0:
        bl                0f
        pop               {r7}
        pop               {r1}
        bx                r1

asm_test::load::u16::acquire:
        push              {r7, lr}
        movs              r1, #0x0
        movs              r2, r1
0:
        bl                0f
        pop               {r7}
        pop               {r1}
        bx                r1

asm_test::load::u16::relaxed:
        ldrh              r0, [r0]
        bx                lr

asm_test::load::u32::seqcst:
        push              {r7, lr}
        movs              r1, #0x0
        movs              r2, r1
0:
        bl                0f
        pop               {r7}
        pop               {r1}
        bx                r1

asm_test::load::u32::acquire:
        push              {r7, lr}
        movs              r1, #0x0
        movs              r2, r1
0:
        bl                0f
        pop               {r7}
        pop               {r1}
        bx                r1

asm_test::load::u32::relaxed:
        ldr               r0, [r0]
        bx                lr

asm_test::swap::u8::acqrel:
        push              {r7, lr}
0:
        bl                0f
        pop               {r7}
        pop               {r1}
        bx                r1

asm_test::swap::u8::seqcst:
        push              {r7, lr}
0:
        bl                0f
        pop               {r7}
        pop               {r1}
        bx                r1

asm_test::swap::u8::acquire:
        push              {r7, lr}
0:
        bl                0f
        pop               {r7}
        pop               {r1}
        bx                r1

asm_test::swap::u8::relaxed:
        push              {r7, lr}
0:
        bl                0f
        pop               {r7}
        pop               {r1}
        bx                r1

asm_test::swap::u8::release:
        push              {r7, lr}
0:
        bl                0f
        pop               {r7}
        pop               {r1}
        bx                r1

asm_test::swap::u16::acqrel:
        push              {r7, lr}
0:
        bl                0f
        pop               {r7}
        pop               {r1}
        bx                r1

asm_test::swap::u16::seqcst:
        push              {r7, lr}
0:
        bl                0f
        pop               {r7}
        pop               {r1}
        bx                r1

asm_test::swap::u16::acquire:
        push              {r7, lr}
0:
        bl                0f
        pop               {r7}
        pop               {r1}
        bx                r1

asm_test::swap::u16::relaxed:
        push              {r7, lr}
0:
        bl                0f
        pop               {r7}
        pop               {r1}
        bx                r1

asm_test::swap::u16::release:
        push              {r7, lr}
0:
        bl                0f
        pop               {r7}
        pop               {r1}
        bx                r1

asm_test::swap::u32::acqrel:
        push              {r7, lr}
0:
        bl                0f
        pop               {r7}
        pop               {r1}
        bx                r1

asm_test::swap::u32::seqcst:
        push              {r7, lr}
0:
        bl                0f
        pop               {r7}
        pop               {r1}
        bx                r1

asm_test::swap::u32::acquire:
        push              {r7, lr}
0:
        bl                0f
        pop               {r7}
        pop               {r1}
        bx                r1

asm_test::swap::u32::relaxed:
        push              {r7, lr}
0:
        bl                0f
        pop               {r7}
        pop               {r1}
        bx                r1

asm_test::swap::u32::release:
        push              {r7, lr}
0:
        bl                0f
        pop               {r7}
        pop               {r1}
        bx                r1

asm_test::store::u8::seqcst:
        push              {r7, lr}
0:
        bl                0f
        pop               {r7}
        pop               {r0}
        bx                r0

asm_test::store::u8::relaxed:
        strb              r1, [r0]
        bx                lr

asm_test::store::u8::release:
        push              {r7, lr}
0:
        bl                0f
        pop               {r7}
        pop               {r0}
        bx                r0

asm_test::store::u16::seqcst:
        push              {r7, lr}
0:
        bl                0f
        pop               {r7}
        pop               {r0}
        bx                r0

asm_test::store::u16::relaxed:
        strh              r1, [r0]
        bx                lr

asm_test::store::u16::release:
        push              {r7, lr}
0:
        bl                0f
        pop               {r7}
        pop               {r0}
        bx                r0

asm_test::store::u32::seqcst:
        push              {r7, lr}
0:
        bl                0f
        pop               {r7}
        pop               {r0}
        bx                r0

asm_test::store::u32::relaxed:
        str               r1, [r0]
        bx                lr

asm_test::store::u32::release:
        push              {r7, lr}
0:
        bl                0f
        pop               {r7}
        pop               {r0}
        bx                r0

