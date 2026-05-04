asm_test::compare_exchange::u8::acqrel_seqcst:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x4
        str               r3, [sp]
        movs              r3, #0x3
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u8::seqcst_seqcst:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x4
        str               r3, [sp]
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u8::acqrel_acquire:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x2
        str               r3, [sp]
        movs              r3, #0x3
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u8::acqrel_relaxed:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x0
        str               r3, [sp]
        movs              r3, #0x3
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u8::acquire_seqcst:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x4
        str               r3, [sp]
        movs              r3, #0x2
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u8::relaxed_seqcst:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x4
        str               r3, [sp]
        movs              r3, #0x0
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u8::release_seqcst:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x4
        str               r3, [sp]
        movs              r3, #0x1
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u8::seqcst_acquire:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x2
        str               r3, [sp]
        movs              r3, #0x4
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u8::seqcst_relaxed:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x0
        str               r3, [sp]
        movs              r3, #0x4
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u8::acquire_acquire:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x2
        str               r3, [sp]
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u8::acquire_relaxed:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x0
        str               r3, [sp]
        movs              r3, #0x2
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u8::relaxed_acquire:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x2
        str               r3, [sp]
        movs              r3, #0x0
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u8::relaxed_relaxed:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x0
        str               r3, [sp]
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u8::release_acquire:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x2
        str               r3, [sp]
        movs              r3, #0x1
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u8::release_relaxed:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x0
        str               r3, [sp]
        movs              r3, #0x1
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u16::acqrel_seqcst:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x4
        str               r3, [sp]
        movs              r3, #0x3
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u16::seqcst_seqcst:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x4
        str               r3, [sp]
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u16::acqrel_acquire:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x2
        str               r3, [sp]
        movs              r3, #0x3
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u16::acqrel_relaxed:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x0
        str               r3, [sp]
        movs              r3, #0x3
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u16::acquire_seqcst:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x4
        str               r3, [sp]
        movs              r3, #0x2
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u16::relaxed_seqcst:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x4
        str               r3, [sp]
        movs              r3, #0x0
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u16::release_seqcst:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x4
        str               r3, [sp]
        movs              r3, #0x1
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u16::seqcst_acquire:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x2
        str               r3, [sp]
        movs              r3, #0x4
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u16::seqcst_relaxed:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x0
        str               r3, [sp]
        movs              r3, #0x4
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u16::acquire_acquire:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x2
        str               r3, [sp]
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u16::acquire_relaxed:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x0
        str               r3, [sp]
        movs              r3, #0x2
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u16::relaxed_acquire:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x2
        str               r3, [sp]
        movs              r3, #0x0
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u16::relaxed_relaxed:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x0
        str               r3, [sp]
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u16::release_acquire:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x2
        str               r3, [sp]
        movs              r3, #0x1
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u16::release_relaxed:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x0
        str               r3, [sp]
        movs              r3, #0x1
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u32::acqrel_seqcst:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x4
        str               r3, [sp]
        movs              r3, #0x3
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u32::seqcst_seqcst:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x4
        str               r3, [sp]
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u32::acqrel_acquire:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x2
        str               r3, [sp]
        movs              r3, #0x3
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u32::acqrel_relaxed:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x0
        str               r3, [sp]
        movs              r3, #0x3
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u32::acquire_seqcst:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x4
        str               r3, [sp]
        movs              r3, #0x2
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u32::relaxed_seqcst:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x4
        str               r3, [sp]
        movs              r3, #0x0
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u32::release_seqcst:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x4
        str               r3, [sp]
        movs              r3, #0x1
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u32::seqcst_acquire:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x2
        str               r3, [sp]
        movs              r3, #0x4
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u32::seqcst_relaxed:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x0
        str               r3, [sp]
        movs              r3, #0x4
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u32::acquire_acquire:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x2
        str               r3, [sp]
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u32::acquire_relaxed:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x0
        str               r3, [sp]
        movs              r3, #0x2
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u32::relaxed_acquire:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x2
        str               r3, [sp]
        movs              r3, #0x0
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u32::relaxed_relaxed:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x0
        str               r3, [sp]
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u32::release_acquire:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x2
        str               r3, [sp]
        movs              r3, #0x1
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u32::release_relaxed:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x0
        str               r3, [sp]
        movs              r3, #0x1
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange::u64::acqrel_seqcst:
        push              {r4, r6, r7, lr}
        add               r7, sp, #0x8
        sub               sp, #0x10
        movs              r4, #0x4
        str               r4, [sp, #0xc]
        movs              r4, #0x3
        str               r4, [sp, #0x8]
        ldr               r4, [r7, #0xc]
        str               r4, [sp, #0x4]
        ldr               r4, [r7, #0x8]
        str               r4, [sp]
0:
        bl                0f
        add               sp, #0x10
        pop               {r4, r6, r7, pc}

asm_test::compare_exchange::u64::seqcst_seqcst:
        push              {r4, r6, r7, lr}
        add               r7, sp, #0x8
        sub               sp, #0x10
        movs              r4, #0x4
        str               r4, [sp, #0xc]
        str               r4, [sp, #0x8]
        ldr               r4, [r7, #0xc]
        str               r4, [sp, #0x4]
        ldr               r4, [r7, #0x8]
        str               r4, [sp]
0:
        bl                0f
        add               sp, #0x10
        pop               {r4, r6, r7, pc}

asm_test::compare_exchange::u64::acqrel_acquire:
        push              {r4, r6, r7, lr}
        add               r7, sp, #0x8
        sub               sp, #0x10
        movs              r4, #0x2
        str               r4, [sp, #0xc]
        movs              r4, #0x3
        str               r4, [sp, #0x8]
        ldr               r4, [r7, #0xc]
        str               r4, [sp, #0x4]
        ldr               r4, [r7, #0x8]
        str               r4, [sp]
0:
        bl                0f
        add               sp, #0x10
        pop               {r4, r6, r7, pc}

asm_test::compare_exchange::u64::acqrel_relaxed:
        push              {r4, r6, r7, lr}
        add               r7, sp, #0x8
        sub               sp, #0x10
        movs              r4, #0x0
        str               r4, [sp, #0xc]
        movs              r4, #0x3
        str               r4, [sp, #0x8]
        ldr               r4, [r7, #0xc]
        str               r4, [sp, #0x4]
        ldr               r4, [r7, #0x8]
        str               r4, [sp]
0:
        bl                0f
        add               sp, #0x10
        pop               {r4, r6, r7, pc}

asm_test::compare_exchange::u64::acquire_seqcst:
        push              {r4, r6, r7, lr}
        add               r7, sp, #0x8
        sub               sp, #0x10
        movs              r4, #0x4
        str               r4, [sp, #0xc]
        movs              r4, #0x2
        str               r4, [sp, #0x8]
        ldr               r4, [r7, #0xc]
        str               r4, [sp, #0x4]
        ldr               r4, [r7, #0x8]
        str               r4, [sp]
0:
        bl                0f
        add               sp, #0x10
        pop               {r4, r6, r7, pc}

asm_test::compare_exchange::u64::relaxed_seqcst:
        push              {r4, r6, r7, lr}
        add               r7, sp, #0x8
        sub               sp, #0x10
        movs              r4, #0x4
        str               r4, [sp, #0xc]
        movs              r4, #0x0
        str               r4, [sp, #0x8]
        ldr               r4, [r7, #0xc]
        str               r4, [sp, #0x4]
        ldr               r4, [r7, #0x8]
        str               r4, [sp]
0:
        bl                0f
        add               sp, #0x10
        pop               {r4, r6, r7, pc}

asm_test::compare_exchange::u64::release_seqcst:
        push              {r4, r6, r7, lr}
        add               r7, sp, #0x8
        sub               sp, #0x10
        movs              r4, #0x4
        str               r4, [sp, #0xc]
        movs              r4, #0x1
        str               r4, [sp, #0x8]
        ldr               r4, [r7, #0xc]
        str               r4, [sp, #0x4]
        ldr               r4, [r7, #0x8]
        str               r4, [sp]
0:
        bl                0f
        add               sp, #0x10
        pop               {r4, r6, r7, pc}

asm_test::compare_exchange::u64::seqcst_acquire:
        push              {r4, r6, r7, lr}
        add               r7, sp, #0x8
        sub               sp, #0x10
        movs              r4, #0x2
        str               r4, [sp, #0xc]
        movs              r4, #0x4
        str               r4, [sp, #0x8]
        ldr               r4, [r7, #0xc]
        str               r4, [sp, #0x4]
        ldr               r4, [r7, #0x8]
        str               r4, [sp]
0:
        bl                0f
        add               sp, #0x10
        pop               {r4, r6, r7, pc}

asm_test::compare_exchange::u64::seqcst_relaxed:
        push              {r4, r6, r7, lr}
        add               r7, sp, #0x8
        sub               sp, #0x10
        movs              r4, #0x0
        str               r4, [sp, #0xc]
        movs              r4, #0x4
        str               r4, [sp, #0x8]
        ldr               r4, [r7, #0xc]
        str               r4, [sp, #0x4]
        ldr               r4, [r7, #0x8]
        str               r4, [sp]
0:
        bl                0f
        add               sp, #0x10
        pop               {r4, r6, r7, pc}

asm_test::compare_exchange::u64::acquire_acquire:
        push              {r4, r6, r7, lr}
        add               r7, sp, #0x8
        sub               sp, #0x10
        movs              r4, #0x2
        str               r4, [sp, #0xc]
        str               r4, [sp, #0x8]
        ldr               r4, [r7, #0xc]
        str               r4, [sp, #0x4]
        ldr               r4, [r7, #0x8]
        str               r4, [sp]
0:
        bl                0f
        add               sp, #0x10
        pop               {r4, r6, r7, pc}

asm_test::compare_exchange::u64::acquire_relaxed:
        push              {r4, r6, r7, lr}
        add               r7, sp, #0x8
        sub               sp, #0x10
        movs              r4, #0x0
        str               r4, [sp, #0xc]
        movs              r4, #0x2
        str               r4, [sp, #0x8]
        ldr               r4, [r7, #0xc]
        str               r4, [sp, #0x4]
        ldr               r4, [r7, #0x8]
        str               r4, [sp]
0:
        bl                0f
        add               sp, #0x10
        pop               {r4, r6, r7, pc}

asm_test::compare_exchange::u64::relaxed_acquire:
        push              {r4, r6, r7, lr}
        add               r7, sp, #0x8
        sub               sp, #0x10
        movs              r4, #0x2
        str               r4, [sp, #0xc]
        movs              r4, #0x0
        str               r4, [sp, #0x8]
        ldr               r4, [r7, #0xc]
        str               r4, [sp, #0x4]
        ldr               r4, [r7, #0x8]
        str               r4, [sp]
0:
        bl                0f
        add               sp, #0x10
        pop               {r4, r6, r7, pc}

asm_test::compare_exchange::u64::relaxed_relaxed:
        push              {r4, r6, r7, lr}
        add               r7, sp, #0x8
        sub               sp, #0x10
        movs              r4, #0x0
        str               r4, [sp, #0xc]
        str               r4, [sp, #0x8]
        ldr               r4, [r7, #0xc]
        str               r4, [sp, #0x4]
        ldr               r4, [r7, #0x8]
        str               r4, [sp]
0:
        bl                0f
        add               sp, #0x10
        pop               {r4, r6, r7, pc}

asm_test::compare_exchange::u64::release_acquire:
        push              {r4, r6, r7, lr}
        add               r7, sp, #0x8
        sub               sp, #0x10
        movs              r4, #0x2
        str               r4, [sp, #0xc]
        movs              r4, #0x1
        str               r4, [sp, #0x8]
        ldr               r4, [r7, #0xc]
        str               r4, [sp, #0x4]
        ldr               r4, [r7, #0x8]
        str               r4, [sp]
0:
        bl                0f
        add               sp, #0x10
        pop               {r4, r6, r7, pc}

asm_test::compare_exchange::u64::release_relaxed:
        push              {r4, r6, r7, lr}
        add               r7, sp, #0x8
        sub               sp, #0x10
        movs              r4, #0x0
        str               r4, [sp, #0xc]
        movs              r4, #0x1
        str               r4, [sp, #0x8]
        ldr               r4, [r7, #0xc]
        str               r4, [sp, #0x4]
        ldr               r4, [r7, #0x8]
        str               r4, [sp]
0:
        bl                0f
        add               sp, #0x10
        pop               {r4, r6, r7, pc}

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x4
        str               r3, [sp]
        movs              r3, #0x3
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x4
        str               r3, [sp]
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x2
        str               r3, [sp]
        movs              r3, #0x3
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x0
        str               r3, [sp]
        movs              r3, #0x3
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x4
        str               r3, [sp]
        movs              r3, #0x2
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x4
        str               r3, [sp]
        movs              r3, #0x0
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u8::release_seqcst:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x4
        str               r3, [sp]
        movs              r3, #0x1
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x2
        str               r3, [sp]
        movs              r3, #0x4
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x0
        str               r3, [sp]
        movs              r3, #0x4
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u8::acquire_acquire:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x2
        str               r3, [sp]
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x0
        str               r3, [sp]
        movs              r3, #0x2
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x2
        str               r3, [sp]
        movs              r3, #0x0
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x0
        str               r3, [sp]
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u8::release_acquire:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x2
        str               r3, [sp]
        movs              r3, #0x1
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u8::release_relaxed:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x0
        str               r3, [sp]
        movs              r3, #0x1
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x4
        str               r3, [sp]
        movs              r3, #0x3
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x4
        str               r3, [sp]
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x2
        str               r3, [sp]
        movs              r3, #0x3
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x0
        str               r3, [sp]
        movs              r3, #0x3
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x4
        str               r3, [sp]
        movs              r3, #0x2
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x4
        str               r3, [sp]
        movs              r3, #0x0
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::release_seqcst:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x4
        str               r3, [sp]
        movs              r3, #0x1
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x2
        str               r3, [sp]
        movs              r3, #0x4
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x0
        str               r3, [sp]
        movs              r3, #0x4
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::acquire_acquire:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x2
        str               r3, [sp]
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x0
        str               r3, [sp]
        movs              r3, #0x2
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x2
        str               r3, [sp]
        movs              r3, #0x0
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x0
        str               r3, [sp]
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::release_acquire:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x2
        str               r3, [sp]
        movs              r3, #0x1
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u16::release_relaxed:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x0
        str               r3, [sp]
        movs              r3, #0x1
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x4
        str               r3, [sp]
        movs              r3, #0x3
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x4
        str               r3, [sp]
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x2
        str               r3, [sp]
        movs              r3, #0x3
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x0
        str               r3, [sp]
        movs              r3, #0x3
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x4
        str               r3, [sp]
        movs              r3, #0x2
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x4
        str               r3, [sp]
        movs              r3, #0x0
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::release_seqcst:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x4
        str               r3, [sp]
        movs              r3, #0x1
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x2
        str               r3, [sp]
        movs              r3, #0x4
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x0
        str               r3, [sp]
        movs              r3, #0x4
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::acquire_acquire:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x2
        str               r3, [sp]
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x0
        str               r3, [sp]
        movs              r3, #0x2
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x2
        str               r3, [sp]
        movs              r3, #0x0
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x0
        str               r3, [sp]
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::release_acquire:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x2
        str               r3, [sp]
        movs              r3, #0x1
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u32::release_relaxed:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r3, #0x0
        str               r3, [sp]
        movs              r3, #0x1
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::compare_exchange_weak::u64::acqrel_seqcst:
        push              {r4, r6, r7, lr}
        add               r7, sp, #0x8
        sub               sp, #0x10
        movs              r4, #0x4
        str               r4, [sp, #0xc]
        movs              r4, #0x3
        str               r4, [sp, #0x8]
        ldr               r4, [r7, #0xc]
        str               r4, [sp, #0x4]
        ldr               r4, [r7, #0x8]
        str               r4, [sp]
0:
        bl                0f
        add               sp, #0x10
        pop               {r4, r6, r7, pc}

asm_test::compare_exchange_weak::u64::seqcst_seqcst:
        push              {r4, r6, r7, lr}
        add               r7, sp, #0x8
        sub               sp, #0x10
        movs              r4, #0x4
        str               r4, [sp, #0xc]
        str               r4, [sp, #0x8]
        ldr               r4, [r7, #0xc]
        str               r4, [sp, #0x4]
        ldr               r4, [r7, #0x8]
        str               r4, [sp]
0:
        bl                0f
        add               sp, #0x10
        pop               {r4, r6, r7, pc}

asm_test::compare_exchange_weak::u64::acqrel_acquire:
        push              {r4, r6, r7, lr}
        add               r7, sp, #0x8
        sub               sp, #0x10
        movs              r4, #0x2
        str               r4, [sp, #0xc]
        movs              r4, #0x3
        str               r4, [sp, #0x8]
        ldr               r4, [r7, #0xc]
        str               r4, [sp, #0x4]
        ldr               r4, [r7, #0x8]
        str               r4, [sp]
0:
        bl                0f
        add               sp, #0x10
        pop               {r4, r6, r7, pc}

asm_test::compare_exchange_weak::u64::acqrel_relaxed:
        push              {r4, r6, r7, lr}
        add               r7, sp, #0x8
        sub               sp, #0x10
        movs              r4, #0x0
        str               r4, [sp, #0xc]
        movs              r4, #0x3
        str               r4, [sp, #0x8]
        ldr               r4, [r7, #0xc]
        str               r4, [sp, #0x4]
        ldr               r4, [r7, #0x8]
        str               r4, [sp]
0:
        bl                0f
        add               sp, #0x10
        pop               {r4, r6, r7, pc}

asm_test::compare_exchange_weak::u64::acquire_seqcst:
        push              {r4, r6, r7, lr}
        add               r7, sp, #0x8
        sub               sp, #0x10
        movs              r4, #0x4
        str               r4, [sp, #0xc]
        movs              r4, #0x2
        str               r4, [sp, #0x8]
        ldr               r4, [r7, #0xc]
        str               r4, [sp, #0x4]
        ldr               r4, [r7, #0x8]
        str               r4, [sp]
0:
        bl                0f
        add               sp, #0x10
        pop               {r4, r6, r7, pc}

asm_test::compare_exchange_weak::u64::relaxed_seqcst:
        push              {r4, r6, r7, lr}
        add               r7, sp, #0x8
        sub               sp, #0x10
        movs              r4, #0x4
        str               r4, [sp, #0xc]
        movs              r4, #0x0
        str               r4, [sp, #0x8]
        ldr               r4, [r7, #0xc]
        str               r4, [sp, #0x4]
        ldr               r4, [r7, #0x8]
        str               r4, [sp]
0:
        bl                0f
        add               sp, #0x10
        pop               {r4, r6, r7, pc}

asm_test::compare_exchange_weak::u64::release_seqcst:
        push              {r4, r6, r7, lr}
        add               r7, sp, #0x8
        sub               sp, #0x10
        movs              r4, #0x4
        str               r4, [sp, #0xc]
        movs              r4, #0x1
        str               r4, [sp, #0x8]
        ldr               r4, [r7, #0xc]
        str               r4, [sp, #0x4]
        ldr               r4, [r7, #0x8]
        str               r4, [sp]
0:
        bl                0f
        add               sp, #0x10
        pop               {r4, r6, r7, pc}

asm_test::compare_exchange_weak::u64::seqcst_acquire:
        push              {r4, r6, r7, lr}
        add               r7, sp, #0x8
        sub               sp, #0x10
        movs              r4, #0x2
        str               r4, [sp, #0xc]
        movs              r4, #0x4
        str               r4, [sp, #0x8]
        ldr               r4, [r7, #0xc]
        str               r4, [sp, #0x4]
        ldr               r4, [r7, #0x8]
        str               r4, [sp]
0:
        bl                0f
        add               sp, #0x10
        pop               {r4, r6, r7, pc}

asm_test::compare_exchange_weak::u64::seqcst_relaxed:
        push              {r4, r6, r7, lr}
        add               r7, sp, #0x8
        sub               sp, #0x10
        movs              r4, #0x0
        str               r4, [sp, #0xc]
        movs              r4, #0x4
        str               r4, [sp, #0x8]
        ldr               r4, [r7, #0xc]
        str               r4, [sp, #0x4]
        ldr               r4, [r7, #0x8]
        str               r4, [sp]
0:
        bl                0f
        add               sp, #0x10
        pop               {r4, r6, r7, pc}

asm_test::compare_exchange_weak::u64::acquire_acquire:
        push              {r4, r6, r7, lr}
        add               r7, sp, #0x8
        sub               sp, #0x10
        movs              r4, #0x2
        str               r4, [sp, #0xc]
        str               r4, [sp, #0x8]
        ldr               r4, [r7, #0xc]
        str               r4, [sp, #0x4]
        ldr               r4, [r7, #0x8]
        str               r4, [sp]
0:
        bl                0f
        add               sp, #0x10
        pop               {r4, r6, r7, pc}

asm_test::compare_exchange_weak::u64::acquire_relaxed:
        push              {r4, r6, r7, lr}
        add               r7, sp, #0x8
        sub               sp, #0x10
        movs              r4, #0x0
        str               r4, [sp, #0xc]
        movs              r4, #0x2
        str               r4, [sp, #0x8]
        ldr               r4, [r7, #0xc]
        str               r4, [sp, #0x4]
        ldr               r4, [r7, #0x8]
        str               r4, [sp]
0:
        bl                0f
        add               sp, #0x10
        pop               {r4, r6, r7, pc}

asm_test::compare_exchange_weak::u64::relaxed_acquire:
        push              {r4, r6, r7, lr}
        add               r7, sp, #0x8
        sub               sp, #0x10
        movs              r4, #0x2
        str               r4, [sp, #0xc]
        movs              r4, #0x0
        str               r4, [sp, #0x8]
        ldr               r4, [r7, #0xc]
        str               r4, [sp, #0x4]
        ldr               r4, [r7, #0x8]
        str               r4, [sp]
0:
        bl                0f
        add               sp, #0x10
        pop               {r4, r6, r7, pc}

asm_test::compare_exchange_weak::u64::relaxed_relaxed:
        push              {r4, r6, r7, lr}
        add               r7, sp, #0x8
        sub               sp, #0x10
        movs              r4, #0x0
        str               r4, [sp, #0xc]
        str               r4, [sp, #0x8]
        ldr               r4, [r7, #0xc]
        str               r4, [sp, #0x4]
        ldr               r4, [r7, #0x8]
        str               r4, [sp]
0:
        bl                0f
        add               sp, #0x10
        pop               {r4, r6, r7, pc}

asm_test::compare_exchange_weak::u64::release_acquire:
        push              {r4, r6, r7, lr}
        add               r7, sp, #0x8
        sub               sp, #0x10
        movs              r4, #0x2
        str               r4, [sp, #0xc]
        movs              r4, #0x1
        str               r4, [sp, #0x8]
        ldr               r4, [r7, #0xc]
        str               r4, [sp, #0x4]
        ldr               r4, [r7, #0x8]
        str               r4, [sp]
0:
        bl                0f
        add               sp, #0x10
        pop               {r4, r6, r7, pc}

asm_test::compare_exchange_weak::u64::release_relaxed:
        push              {r4, r6, r7, lr}
        add               r7, sp, #0x8
        sub               sp, #0x10
        movs              r4, #0x0
        str               r4, [sp, #0xc]
        movs              r4, #0x1
        str               r4, [sp, #0x8]
        ldr               r4, [r7, #0xc]
        str               r4, [sp, #0x4]
        ldr               r4, [r7, #0x8]
        str               r4, [sp]
0:
        bl                0f
        add               sp, #0x10
        pop               {r4, r6, r7, pc}

asm_test::load::u8::seqcst:
        push              {r7, lr}
        add               r7, sp, #0x0
        movs              r1, #0x4
0:
        bl                0f
        pop               {r7, pc}

asm_test::load::u8::acquire:
        push              {r7, lr}
        add               r7, sp, #0x0
        movs              r1, #0x2
0:
        bl                0f
        pop               {r7, pc}

asm_test::load::u8::relaxed:
        push              {r7, lr}
        add               r7, sp, #0x0
        movs              r1, #0x0
0:
        bl                0f
        pop               {r7, pc}

asm_test::load::u16::seqcst:
        push              {r7, lr}
        add               r7, sp, #0x0
        movs              r1, #0x4
0:
        bl                0f
        pop               {r7, pc}

asm_test::load::u16::acquire:
        push              {r7, lr}
        add               r7, sp, #0x0
        movs              r1, #0x2
0:
        bl                0f
        pop               {r7, pc}

asm_test::load::u16::relaxed:
        push              {r7, lr}
        add               r7, sp, #0x0
        movs              r1, #0x0
0:
        bl                0f
        pop               {r7, pc}

asm_test::load::u32::seqcst:
        push              {r7, lr}
        add               r7, sp, #0x0
        movs              r1, #0x4
0:
        bl                0f
        pop               {r7, pc}

asm_test::load::u32::acquire:
        push              {r7, lr}
        add               r7, sp, #0x0
        movs              r1, #0x2
0:
        bl                0f
        pop               {r7, pc}

asm_test::load::u32::relaxed:
        push              {r7, lr}
        add               r7, sp, #0x0
        movs              r1, #0x0
0:
        bl                0f
        pop               {r7, pc}

asm_test::load::u64::seqcst:
        push              {r7, lr}
        add               r7, sp, #0x0
        movs              r1, #0x4
0:
        bl                0f
        pop               {r7, pc}

asm_test::load::u64::acquire:
        push              {r7, lr}
        add               r7, sp, #0x0
        movs              r1, #0x2
0:
        bl                0f
        pop               {r7, pc}

asm_test::load::u64::relaxed:
        push              {r7, lr}
        add               r7, sp, #0x0
        movs              r1, #0x0
0:
        bl                0f
        pop               {r7, pc}

asm_test::swap::u8::acqrel:
        push              {r7, lr}
        add               r7, sp, #0x0
        movs              r2, #0x3
0:
        bl                0f
        pop               {r7, pc}

asm_test::swap::u8::seqcst:
        push              {r7, lr}
        add               r7, sp, #0x0
        movs              r2, #0x4
0:
        bl                0f
        pop               {r7, pc}

asm_test::swap::u8::acquire:
        push              {r7, lr}
        add               r7, sp, #0x0
        movs              r2, #0x2
0:
        bl                0f
        pop               {r7, pc}

asm_test::swap::u8::relaxed:
        push              {r7, lr}
        add               r7, sp, #0x0
        movs              r2, #0x0
0:
        bl                0f
        pop               {r7, pc}

asm_test::swap::u8::release:
        push              {r7, lr}
        add               r7, sp, #0x0
        movs              r2, #0x1
0:
        bl                0f
        pop               {r7, pc}

asm_test::swap::u16::acqrel:
        push              {r7, lr}
        add               r7, sp, #0x0
        movs              r2, #0x3
0:
        bl                0f
        pop               {r7, pc}

asm_test::swap::u16::seqcst:
        push              {r7, lr}
        add               r7, sp, #0x0
        movs              r2, #0x4
0:
        bl                0f
        pop               {r7, pc}

asm_test::swap::u16::acquire:
        push              {r7, lr}
        add               r7, sp, #0x0
        movs              r2, #0x2
0:
        bl                0f
        pop               {r7, pc}

asm_test::swap::u16::relaxed:
        push              {r7, lr}
        add               r7, sp, #0x0
        movs              r2, #0x0
0:
        bl                0f
        pop               {r7, pc}

asm_test::swap::u16::release:
        push              {r7, lr}
        add               r7, sp, #0x0
        movs              r2, #0x1
0:
        bl                0f
        pop               {r7, pc}

asm_test::swap::u32::acqrel:
        push              {r7, lr}
        add               r7, sp, #0x0
        movs              r2, #0x3
0:
        bl                0f
        pop               {r7, pc}

asm_test::swap::u32::seqcst:
        push              {r7, lr}
        add               r7, sp, #0x0
        movs              r2, #0x4
0:
        bl                0f
        pop               {r7, pc}

asm_test::swap::u32::acquire:
        push              {r7, lr}
        add               r7, sp, #0x0
        movs              r2, #0x2
0:
        bl                0f
        pop               {r7, pc}

asm_test::swap::u32::relaxed:
        push              {r7, lr}
        add               r7, sp, #0x0
        movs              r2, #0x0
0:
        bl                0f
        pop               {r7, pc}

asm_test::swap::u32::release:
        push              {r7, lr}
        add               r7, sp, #0x0
        movs              r2, #0x1
0:
        bl                0f
        pop               {r7, pc}

asm_test::swap::u64::acqrel:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r1, #0x3
        str               r1, [sp]
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::swap::u64::seqcst:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r1, #0x4
        str               r1, [sp]
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::swap::u64::acquire:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r1, #0x2
        str               r1, [sp]
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::swap::u64::relaxed:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r1, #0x0
        str               r1, [sp]
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::swap::u64::release:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r1, #0x1
        str               r1, [sp]
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::store::u8::seqcst:
        push              {r7, lr}
        add               r7, sp, #0x0
        movs              r2, #0x4
0:
        bl                0f
        pop               {r7, pc}

asm_test::store::u8::relaxed:
        push              {r7, lr}
        add               r7, sp, #0x0
        movs              r2, #0x0
0:
        bl                0f
        pop               {r7, pc}

asm_test::store::u8::release:
        push              {r7, lr}
        add               r7, sp, #0x0
        movs              r2, #0x1
0:
        bl                0f
        pop               {r7, pc}

asm_test::store::u16::seqcst:
        push              {r7, lr}
        add               r7, sp, #0x0
        movs              r2, #0x4
0:
        bl                0f
        pop               {r7, pc}

asm_test::store::u16::relaxed:
        push              {r7, lr}
        add               r7, sp, #0x0
        movs              r2, #0x0
0:
        bl                0f
        pop               {r7, pc}

asm_test::store::u16::release:
        push              {r7, lr}
        add               r7, sp, #0x0
        movs              r2, #0x1
0:
        bl                0f
        pop               {r7, pc}

asm_test::store::u32::seqcst:
        push              {r7, lr}
        add               r7, sp, #0x0
        movs              r2, #0x4
0:
        bl                0f
        pop               {r7, pc}

asm_test::store::u32::relaxed:
        push              {r7, lr}
        add               r7, sp, #0x0
        movs              r2, #0x0
0:
        bl                0f
        pop               {r7, pc}

asm_test::store::u32::release:
        push              {r7, lr}
        add               r7, sp, #0x0
        movs              r2, #0x1
0:
        bl                0f
        pop               {r7, pc}

asm_test::store::u64::seqcst:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r1, #0x4
        str               r1, [sp]
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::store::u64::relaxed:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r1, #0x0
        str               r1, [sp]
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

asm_test::store::u64::release:
        push              {r7, lr}
        add               r7, sp, #0x0
        sub               sp, #0x8
        movs              r1, #0x1
        str               r1, [sp]
0:
        bl                0f
        add               sp, #0x8
        pop               {r7, pc}

<u64 as atomic_maybe_uninit::raw::AtomicLoad>::atomic_load:
        push              {r11, lr}
        mov               r11, sp
        tst               r1, #255
        beq               0f
        mov               r2, #0
        ldrexd            r0, r1, [r0]
        mcr               p15, #0x0, r2, c7, c10, #0x5
        pop               {r11, pc}
0:
        ldrexd            r0, r1, [r0]
        pop               {r11, pc}

<u64 as atomic_maybe_uninit::raw::AtomicSwap>::atomic_swap:
        push              {r4, r10, r11, lr}
        add               r11, sp, #8
        mov               r12, r0
        ldrb              r0, [r11, #0x8]
        add               r1, pc, #0
        ldr               pc, [r1, r0, lsl #2]
        .word             0x00000068
        .word             0x0000007c
        .word             0x0000004c
        .word             0x0000002c
        .word             0x0000002c
        mov               lr, #0
        mcr               p15, #0x0, lr, c7, c10, #0x5
0:
        ldrexd            r0, r1, [r12]
        strexd            r4, r2, r3, [r12]
        cmp               r4, #0
        bne               0b
        mcr               p15, #0x0, lr, c7, c10, #0x5
        pop               {r4, r10, r11, pc}
        mov               lr, #0
1:
        ldrexd            r0, r1, [r12]
        strexd            r4, r2, r3, [r12]
        cmp               r4, #0
        bne               1b
        mcr               p15, #0x0, lr, c7, c10, #0x5
        pop               {r4, r10, r11, pc}
2:
        ldrexd            r0, r1, [r12]
        strexd            lr, r2, r3, [r12]
        cmp               lr, #0
        bne               2b
        pop               {r4, r10, r11, pc}
        mov               lr, #0
        mcr               p15, #0x0, lr, c7, c10, #0x5
3:
        ldrexd            r0, r1, [r12]
        strexd            r4, r2, r3, [r12]
        cmp               r4, #0
        bne               3b
        pop               {r4, r10, r11, pc}

<u64 as atomic_maybe_uninit::raw::AtomicCompareExchange>::atomic_compare_exchange:
        push              {r4, r5, r6, r7, r8, r10, r11, lr}
        add               r11, sp, #24
        mov               r12, r3
        mov               lr, r2
        ldrb              r3, [r11, #0x10]
        ldr               r5, [r11, #0xc]
        ldr               r4, [r11, #0x8]
        cmp               r3, #0
        ldr               r2, [r11, #0x14]
        beq               6f
        mov               r8, #0
        cmp               r3, #1
        beq               2f
        cmp               r3, #2
        bne               10f
        tst               r2, #255
        beq               18f
0:
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r6, r2, lr
        orrs              r6, r6, r7
        mov               r6, #1
        bne               1f
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0
        bne               0b
1:
        mcr               p15, #0x0, r8, c7, c10, #0x5
        eor               r1, r6, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r10, r11, pc}
2:
        tst               r2, #255
        beq               13f
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r6, r2, lr
        orrs              r6, r6, r7
        mov               r6, #1
        bne               4f
        mcr               p15, #0x0, r8, c7, c10, #0x5
3:
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0
        beq               5f
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r6, r2, lr
        orrs              r6, r6, r7
        mov               r6, #1
        beq               3b
4:
        mcr               p15, #0x0, r8, c7, c10, #0x5
5:
        eor               r1, r6, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r10, r11, pc}
6:
        tst               r2, #255
        beq               16f
        mov               r8, #0
7:
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r6, r2, lr
        orrs              r6, r6, r7
        mov               r6, #1
        bne               8f
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0
        bne               7b
        b                 9f
8:
        mcr               p15, #0x0, r8, c7, c10, #0x5
9:
        eor               r1, r6, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r10, r11, pc}
10:
        tst               r2, #255
        beq               20f
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r6, r2, lr
        orrs              r6, r6, r7
        mov               r6, #1
        bne               12f
        mcr               p15, #0x0, r8, c7, c10, #0x5
11:
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0
        beq               12f
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r6, r2, lr
        orrs              r6, r6, r7
        mov               r6, #1
        beq               11b
12:
        mcr               p15, #0x0, r8, c7, c10, #0x5
        eor               r1, r6, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r10, r11, pc}
13:
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r6, r2, lr
        orrs              r6, r6, r7
        mov               r6, #1
        bne               15f
        mcr               p15, #0x0, r8, c7, c10, #0x5
14:
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0
        beq               15f
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r6, r2, lr
        orrs              r6, r6, r7
        mov               r6, #1
        beq               14b
15:
        eor               r1, r6, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r10, r11, pc}
16:
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r6, r2, lr
        orrs              r6, r6, r7
        mov               r6, #1
        bne               17f
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0
        bne               16b
17:
        eor               r1, r6, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r10, r11, pc}
18:
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r6, r2, lr
        orrs              r6, r6, r7
        mov               r6, #1
        bne               19f
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0
        bne               18b
        mcr               p15, #0x0, r8, c7, c10, #0x5
19:
        eor               r1, r6, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r10, r11, pc}
20:
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r6, r2, lr
        orrs              r6, r6, r7
        mov               r6, #1
        bne               23f
        mcr               p15, #0x0, r8, c7, c10, #0x5
21:
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0
        beq               22f
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r6, r2, lr
        orrs              r6, r6, r7
        mov               r6, #1
        beq               21b
        b                 23f
22:
        mcr               p15, #0x0, r8, c7, c10, #0x5
23:
        eor               r1, r6, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r10, r11, pc}

<u64 as atomic_maybe_uninit::raw::AtomicCompareExchange>::atomic_compare_exchange_weak:
        push              {r4, r5, r6, r7, r8, r10, r11, lr}
        add               r11, sp, #24
        mov               r12, r3
        mov               lr, r2
        ldrb              r3, [r11, #0x10]
        ldr               r5, [r11, #0xc]
        ldr               r4, [r11, #0x8]
        cmp               r3, #0
        ldr               r2, [r11, #0x14]
        beq               4f
        mov               r8, #0
        cmp               r3, #1
        beq               1f
        cmp               r3, #2
        bne               7f
        tst               r2, #255
        beq               13f
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r6, r2, lr
        orrs              r6, r6, r7
        mov               r6, #1
        bne               0f
        strexd            r6, r4, r5, [r1]
0:
        mcr               p15, #0x0, r8, c7, c10, #0x5
        eor               r1, r6, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r10, r11, pc}
1:
        tst               r2, #255
        beq               9f
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r6, r2, lr
        orrs              r6, r6, r7
        mov               r6, #1
        bne               2f
        mcr               p15, #0x0, r8, c7, c10, #0x5
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0
        beq               3f
2:
        mcr               p15, #0x0, r8, c7, c10, #0x5
3:
        eor               r1, r6, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r10, r11, pc}
4:
        tst               r2, #255
        beq               11f
        mov               r8, #0
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r6, r2, lr
        orrs              r6, r6, r7
        mov               r6, #1
        bne               5f
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0
        beq               6f
5:
        mcr               p15, #0x0, r8, c7, c10, #0x5
6:
        eor               r1, r6, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r10, r11, pc}
7:
        tst               r2, #255
        beq               15f
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r6, r2, lr
        orrs              r6, r6, r7
        mov               r6, #1
        bne               8f
        mcr               p15, #0x0, r8, c7, c10, #0x5
        strexd            r6, r4, r5, [r1]
8:
        mcr               p15, #0x0, r8, c7, c10, #0x5
        eor               r1, r6, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r10, r11, pc}
9:
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r6, r2, lr
        orrs              r6, r6, r7
        mov               r6, #1
        bne               10f
        mcr               p15, #0x0, r8, c7, c10, #0x5
        strexd            r6, r4, r5, [r1]
10:
        eor               r1, r6, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r10, r11, pc}
11:
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r6, r2, lr
        orrs              r6, r6, r7
        mov               r6, #1
        bne               12f
        strexd            r6, r4, r5, [r1]
12:
        eor               r1, r6, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r10, r11, pc}
13:
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r6, r2, lr
        orrs              r6, r6, r7
        mov               r6, #1
        bne               14f
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0
        bne               14f
        mcr               p15, #0x0, r8, c7, c10, #0x5
14:
        eor               r1, r6, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r10, r11, pc}
15:
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r6, r2, lr
        orrs              r6, r6, r7
        mov               r6, #1
        bne               16f
        mcr               p15, #0x0, r8, c7, c10, #0x5
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0
        bne               16f
        mcr               p15, #0x0, r8, c7, c10, #0x5
16:
        eor               r1, r6, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r10, r11, pc}

<u64 as atomic_maybe_uninit::raw::AtomicStore>::atomic_store:
        push              {r4, r5, r11, lr}
        add               r11, sp, #8
        ldrb              r1, [r11, #0x8]
        cmp               r1, #0
        beq               1f
        cmp               r1, #1
        bne               2f
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
0:
        ldrexd            r4, r5, [r0]
        strexd            r4, r2, r3, [r0]
        cmp               r4, #0
        bne               0b
        pop               {r4, r5, r11, pc}
1:
        ldrexd            r4, r5, [r0]
        strexd            r4, r2, r3, [r0]
        cmp               r4, #0
        bne               1b
        pop               {r4, r5, r11, pc}
2:
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
3:
        ldrexd            r4, r5, [r0]
        strexd            r4, r2, r3, [r0]
        cmp               r4, #0
        bne               3b
        mcr               p15, #0x0, r1, c7, c10, #0x5
        pop               {r4, r5, r11, pc}

<u8 as atomic_maybe_uninit::raw::AtomicSwap>::atomic_swap:
        push              {r11, lr}
        mov               r11, sp
        uxtb              r2, r2
        add               r3, pc, #0
        ldr               pc, [r3, r2, lsl #2]
        .word             0x0000006c
        .word             0x00000084
        .word             0x0000004c
        .word             0x00000028
        .word             0x00000028
        mov               r2, #0
        mcr               p15, #0x0, r2, c7, c10, #0x5
0:
        ldrexb            r12, [r0]
        strexb            r3, r1, [r0]
        cmp               r3, #0
        bne               0b
        mcr               p15, #0x0, r2, c7, c10, #0x5
        mov               r0, r12
        pop               {r11, pc}
        mov               r2, #0
1:
        ldrexb            r12, [r0]
        strexb            r3, r1, [r0]
        cmp               r3, #0
        bne               1b
        mcr               p15, #0x0, r2, c7, c10, #0x5
        mov               r0, r12
        pop               {r11, pc}
2:
        ldrexb            r12, [r0]
        strexb            r3, r1, [r0]
        cmp               r3, #0
        bne               2b
        mov               r0, r12
        pop               {r11, pc}
        mov               r3, #0
        mcr               p15, #0x0, r3, c7, c10, #0x5
3:
        ldrexb            r12, [r0]
        strexb            r2, r1, [r0]
        cmp               r2, #0
        bne               3b
        mov               r0, r12
        pop               {r11, pc}

<u8 as atomic_maybe_uninit::raw::AtomicCompareExchange>::atomic_compare_exchange:
        push              {r11, lr}
        mov               r11, sp
        uxtb              r12, r1
        ldr               r1, [r11, #0x8]
        uxtb              r3, r3
        cmp               r3, #0
        beq               6f
        cmp               r3, #1
        beq               2f
        cmp               r3, #2
        bne               10f
        tst               r1, #255
        beq               19f
        mov               r1, #1
        mov               r3, #0
0:
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               1f
        strexb            r1, r2, [r0]
        cmp               r1, #0
        bne               0b
1:
        mcr               p15, #0x0, r3, c7, c10, #0x5
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
2:
        tst               r1, #255
        beq               13f
        mov               r1, #1
        mov               r3, #0
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               4f
        mcr               p15, #0x0, r3, c7, c10, #0x5
3:
        strexb            r1, r2, [r0]
        cmp               r1, #0
        beq               5f
        ldrexb            lr, [r0]
        cmp               lr, r12
        beq               3b
4:
        mcr               p15, #0x0, r3, c7, c10, #0x5
5:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
6:
        tst               r1, #255
        beq               16f
        mov               r1, #1
        mov               r3, #0
7:
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               8f
        strexb            r1, r2, [r0]
        cmp               r1, #0
        bne               7b
        b                 9f
8:
        mcr               p15, #0x0, r3, c7, c10, #0x5
9:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
10:
        tst               r1, #255
        beq               22f
        mov               r1, #1
        mov               r3, #0
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               12f
        mcr               p15, #0x0, r3, c7, c10, #0x5
11:
        strexb            r1, r2, [r0]
        cmp               r1, #0
        beq               12f
        ldrexb            lr, [r0]
        cmp               lr, r12
        beq               11b
12:
        mcr               p15, #0x0, r3, c7, c10, #0x5
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
13:
        mov               r1, #1
        mov               r3, #0
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               15f
        mcr               p15, #0x0, r3, c7, c10, #0x5
14:
        strexb            r1, r2, [r0]
        cmp               r1, #0
        beq               15f
        ldrexb            lr, [r0]
        cmp               lr, r12
        beq               14b
15:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
16:
        mov               r1, #1
17:
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               18f
        strexb            r1, r2, [r0]
        cmp               r1, #0
        bne               17b
18:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
19:
        mov               r1, #1
        mov               r3, #0
20:
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               21f
        strexb            r1, r2, [r0]
        cmp               r1, #0
        bne               20b
        mcr               p15, #0x0, r3, c7, c10, #0x5
21:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
22:
        mov               r1, #1
        mov               r3, #0
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               25f
        mcr               p15, #0x0, r3, c7, c10, #0x5
23:
        strexb            r1, r2, [r0]
        cmp               r1, #0
        beq               24f
        ldrexb            lr, [r0]
        cmp               lr, r12
        beq               23b
        b                 25f
24:
        mcr               p15, #0x0, r3, c7, c10, #0x5
25:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

<u8 as atomic_maybe_uninit::raw::AtomicCompareExchange>::atomic_compare_exchange_weak:
        push              {r11, lr}
        mov               r11, sp
        uxtb              r12, r1
        ldr               r1, [r11, #0x8]
        uxtb              r3, r3
        cmp               r3, #0
        beq               4f
        cmp               r3, #1
        beq               1f
        cmp               r3, #2
        bne               7f
        tst               r1, #255
        beq               13f
        mov               r1, #1
        mov               r3, #0
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               0f
        strexb            r1, r2, [r0]
0:
        mcr               p15, #0x0, r3, c7, c10, #0x5
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
1:
        tst               r1, #255
        beq               9f
        mov               r1, #1
        mov               r3, #0
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               2f
        mcr               p15, #0x0, r3, c7, c10, #0x5
        strexb            r1, r2, [r0]
        cmp               r1, #0
        beq               3f
2:
        mcr               p15, #0x0, r3, c7, c10, #0x5
3:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
4:
        tst               r1, #255
        beq               11f
        mov               r1, #1
        mov               r3, #0
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               5f
        strexb            r1, r2, [r0]
        cmp               r1, #0
        beq               6f
5:
        mcr               p15, #0x0, r3, c7, c10, #0x5
6:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
7:
        tst               r1, #255
        beq               15f
        mov               r1, #1
        mov               r3, #0
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               8f
        mcr               p15, #0x0, r3, c7, c10, #0x5
        strexb            r1, r2, [r0]
8:
        mcr               p15, #0x0, r3, c7, c10, #0x5
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
9:
        mov               r1, #1
        mov               r3, #0
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               10f
        mcr               p15, #0x0, r3, c7, c10, #0x5
        strexb            r1, r2, [r0]
10:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
11:
        mov               r1, #1
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               12f
        strexb            r1, r2, [r0]
12:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
13:
        mov               r1, #1
        mov               r3, #0
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               14f
        strexb            r1, r2, [r0]
        cmp               r1, #0
        bne               14f
        mcr               p15, #0x0, r3, c7, c10, #0x5
14:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
15:
        mov               r1, #1
        mov               r3, #0
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               16f
        mcr               p15, #0x0, r3, c7, c10, #0x5
        strexb            r1, r2, [r0]
        cmp               r1, #0
        bne               16f
        mcr               p15, #0x0, r3, c7, c10, #0x5
16:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

<u8 as atomic_maybe_uninit::raw::AtomicLoad>::atomic_load:
        push              {r11, lr}
        mov               r11, sp
        tst               r1, #255
        beq               0f
        mov               r1, #0
        ldrb              r0, [r0]
        mcr               p15, #0x0, r1, c7, c10, #0x5
        pop               {r11, pc}
0:
        ldrb              r0, [r0]
        pop               {r11, pc}

<u8 as atomic_maybe_uninit::raw::AtomicStore>::atomic_store:
        push              {r11, lr}
        mov               r11, sp
        uxtb              r2, r2
        cmp               r2, #0
        beq               0f
        cmp               r2, #1
        bne               1f
        mov               r2, #0
        mcr               p15, #0x0, r2, c7, c10, #0x5
        strb              r1, [r0]
        pop               {r11, pc}
0:
        strb              r1, [r0]
        pop               {r11, pc}
1:
        mov               r2, #0
        mcr               p15, #0x0, r2, c7, c10, #0x5
        strb              r1, [r0]
        mcr               p15, #0x0, r2, c7, c10, #0x5
        pop               {r11, pc}

<u16 as atomic_maybe_uninit::raw::AtomicSwap>::atomic_swap:
        push              {r11, lr}
        mov               r11, sp
        uxtb              r2, r2
        add               r3, pc, #0
        ldr               pc, [r3, r2, lsl #2]
        .word             0x0000006c
        .word             0x00000084
        .word             0x0000004c
        .word             0x00000028
        .word             0x00000028
        mov               r2, #0
        mcr               p15, #0x0, r2, c7, c10, #0x5
0:
        ldrexh            r12, [r0]
        strexh            r3, r1, [r0]
        cmp               r3, #0
        bne               0b
        mcr               p15, #0x0, r2, c7, c10, #0x5
        mov               r0, r12
        pop               {r11, pc}
        mov               r2, #0
1:
        ldrexh            r12, [r0]
        strexh            r3, r1, [r0]
        cmp               r3, #0
        bne               1b
        mcr               p15, #0x0, r2, c7, c10, #0x5
        mov               r0, r12
        pop               {r11, pc}
2:
        ldrexh            r12, [r0]
        strexh            r3, r1, [r0]
        cmp               r3, #0
        bne               2b
        mov               r0, r12
        pop               {r11, pc}
        mov               r3, #0
        mcr               p15, #0x0, r3, c7, c10, #0x5
3:
        ldrexh            r12, [r0]
        strexh            r2, r1, [r0]
        cmp               r2, #0
        bne               3b
        mov               r0, r12
        pop               {r11, pc}

<u16 as atomic_maybe_uninit::raw::AtomicCompareExchange>::atomic_compare_exchange:
        push              {r11, lr}
        mov               r11, sp
        uxth              r12, r1
        ldr               r1, [r11, #0x8]
        uxtb              r3, r3
        cmp               r3, #0
        beq               6f
        cmp               r3, #1
        beq               2f
        cmp               r3, #2
        bne               10f
        tst               r1, #255
        beq               19f
        mov               r1, #1
        mov               r3, #0
0:
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               1f
        strexh            r1, r2, [r0]
        cmp               r1, #0
        bne               0b
1:
        mcr               p15, #0x0, r3, c7, c10, #0x5
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
2:
        tst               r1, #255
        beq               13f
        mov               r1, #1
        mov               r3, #0
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               4f
        mcr               p15, #0x0, r3, c7, c10, #0x5
3:
        strexh            r1, r2, [r0]
        cmp               r1, #0
        beq               5f
        ldrexh            lr, [r0]
        cmp               lr, r12
        beq               3b
4:
        mcr               p15, #0x0, r3, c7, c10, #0x5
5:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
6:
        tst               r1, #255
        beq               16f
        mov               r1, #1
        mov               r3, #0
7:
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               8f
        strexh            r1, r2, [r0]
        cmp               r1, #0
        bne               7b
        b                 9f
8:
        mcr               p15, #0x0, r3, c7, c10, #0x5
9:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
10:
        tst               r1, #255
        beq               22f
        mov               r1, #1
        mov               r3, #0
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               12f
        mcr               p15, #0x0, r3, c7, c10, #0x5
11:
        strexh            r1, r2, [r0]
        cmp               r1, #0
        beq               12f
        ldrexh            lr, [r0]
        cmp               lr, r12
        beq               11b
12:
        mcr               p15, #0x0, r3, c7, c10, #0x5
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
13:
        mov               r1, #1
        mov               r3, #0
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               15f
        mcr               p15, #0x0, r3, c7, c10, #0x5
14:
        strexh            r1, r2, [r0]
        cmp               r1, #0
        beq               15f
        ldrexh            lr, [r0]
        cmp               lr, r12
        beq               14b
15:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
16:
        mov               r1, #1
17:
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               18f
        strexh            r1, r2, [r0]
        cmp               r1, #0
        bne               17b
18:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
19:
        mov               r1, #1
        mov               r3, #0
20:
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               21f
        strexh            r1, r2, [r0]
        cmp               r1, #0
        bne               20b
        mcr               p15, #0x0, r3, c7, c10, #0x5
21:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
22:
        mov               r1, #1
        mov               r3, #0
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               25f
        mcr               p15, #0x0, r3, c7, c10, #0x5
23:
        strexh            r1, r2, [r0]
        cmp               r1, #0
        beq               24f
        ldrexh            lr, [r0]
        cmp               lr, r12
        beq               23b
        b                 25f
24:
        mcr               p15, #0x0, r3, c7, c10, #0x5
25:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

<u16 as atomic_maybe_uninit::raw::AtomicCompareExchange>::atomic_compare_exchange_weak:
        push              {r11, lr}
        mov               r11, sp
        uxth              r12, r1
        ldr               r1, [r11, #0x8]
        uxtb              r3, r3
        cmp               r3, #0
        beq               4f
        cmp               r3, #1
        beq               1f
        cmp               r3, #2
        bne               7f
        tst               r1, #255
        beq               13f
        mov               r1, #1
        mov               r3, #0
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               0f
        strexh            r1, r2, [r0]
0:
        mcr               p15, #0x0, r3, c7, c10, #0x5
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
1:
        tst               r1, #255
        beq               9f
        mov               r1, #1
        mov               r3, #0
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               2f
        mcr               p15, #0x0, r3, c7, c10, #0x5
        strexh            r1, r2, [r0]
        cmp               r1, #0
        beq               3f
2:
        mcr               p15, #0x0, r3, c7, c10, #0x5
3:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
4:
        tst               r1, #255
        beq               11f
        mov               r1, #1
        mov               r3, #0
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               5f
        strexh            r1, r2, [r0]
        cmp               r1, #0
        beq               6f
5:
        mcr               p15, #0x0, r3, c7, c10, #0x5
6:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
7:
        tst               r1, #255
        beq               15f
        mov               r1, #1
        mov               r3, #0
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               8f
        mcr               p15, #0x0, r3, c7, c10, #0x5
        strexh            r1, r2, [r0]
8:
        mcr               p15, #0x0, r3, c7, c10, #0x5
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
9:
        mov               r1, #1
        mov               r3, #0
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               10f
        mcr               p15, #0x0, r3, c7, c10, #0x5
        strexh            r1, r2, [r0]
10:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
11:
        mov               r1, #1
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               12f
        strexh            r1, r2, [r0]
12:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
13:
        mov               r1, #1
        mov               r3, #0
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               14f
        strexh            r1, r2, [r0]
        cmp               r1, #0
        bne               14f
        mcr               p15, #0x0, r3, c7, c10, #0x5
14:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
15:
        mov               r1, #1
        mov               r3, #0
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               16f
        mcr               p15, #0x0, r3, c7, c10, #0x5
        strexh            r1, r2, [r0]
        cmp               r1, #0
        bne               16f
        mcr               p15, #0x0, r3, c7, c10, #0x5
16:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}

<u16 as atomic_maybe_uninit::raw::AtomicLoad>::atomic_load:
        push              {r11, lr}
        mov               r11, sp
        tst               r1, #255
        beq               0f
        mov               r1, #0
        ldrh              r0, [r0]
        mcr               p15, #0x0, r1, c7, c10, #0x5
        pop               {r11, pc}
0:
        ldrh              r0, [r0]
        pop               {r11, pc}

<u16 as atomic_maybe_uninit::raw::AtomicStore>::atomic_store:
        push              {r11, lr}
        mov               r11, sp
        uxtb              r2, r2
        cmp               r2, #0
        beq               0f
        cmp               r2, #1
        bne               1f
        mov               r2, #0
        mcr               p15, #0x0, r2, c7, c10, #0x5
        strh              r1, [r0]
        pop               {r11, pc}
0:
        strh              r1, [r0]
        pop               {r11, pc}
1:
        mov               r2, #0
        mcr               p15, #0x0, r2, c7, c10, #0x5
        strh              r1, [r0]
        mcr               p15, #0x0, r2, c7, c10, #0x5
        pop               {r11, pc}

<u32 as atomic_maybe_uninit::raw::AtomicSwap>::atomic_swap:
        push              {r11, lr}
        mov               r11, sp
        uxtb              r2, r2
        add               r3, pc, #0
        ldr               pc, [r3, r2, lsl #2]
        .word             0x0000006c
        .word             0x00000084
        .word             0x0000004c
        .word             0x00000028
        .word             0x00000028
        mov               r2, #0
        mcr               p15, #0x0, r2, c7, c10, #0x5
0:
        ldrex             r12, [r0]
        strex             r3, r1, [r0]
        cmp               r3, #0
        bne               0b
        mcr               p15, #0x0, r2, c7, c10, #0x5
        mov               r0, r12
        pop               {r11, pc}
        mov               r2, #0
1:
        ldrex             r12, [r0]
        strex             r3, r1, [r0]
        cmp               r3, #0
        bne               1b
        mcr               p15, #0x0, r2, c7, c10, #0x5
        mov               r0, r12
        pop               {r11, pc}
2:
        ldrex             r12, [r0]
        strex             r3, r1, [r0]
        cmp               r3, #0
        bne               2b
        mov               r0, r12
        pop               {r11, pc}
        mov               r3, #0
        mcr               p15, #0x0, r3, c7, c10, #0x5
3:
        ldrex             r12, [r0]
        strex             r2, r1, [r0]
        cmp               r2, #0
        bne               3b
        mov               r0, r12
        pop               {r11, pc}

<u32 as atomic_maybe_uninit::raw::AtomicCompareExchange>::atomic_compare_exchange:
        push              {r11, lr}
        mov               r11, sp
        ldr               r12, [r11, #0x8]
        uxtb              r3, r3
        mov               lr, #1
        cmp               r3, #0
        beq               6f
        cmp               r3, #1
        beq               2f
        cmp               r3, #2
        bne               10f
        mov               r3, #0
        tst               r12, #255
        beq               18f
0:
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        strex             lr, r2, [r0]
        cmp               lr, #0
        bne               0b
1:
        mcr               p15, #0x0, r3, c7, c10, #0x5
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}
2:
        mov               r3, #0
        tst               r12, #255
        beq               13f
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               4f
        mcr               p15, #0x0, r3, c7, c10, #0x5
3:
        strex             lr, r2, [r0]
        cmp               lr, #0
        beq               5f
        ldrex             r12, [r0]
        cmp               r12, r1
        beq               3b
4:
        mcr               p15, #0x0, r3, c7, c10, #0x5
5:
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}
6:
        tst               r12, #255
        beq               16f
        mov               r3, #0
7:
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               8f
        strex             lr, r2, [r0]
        cmp               lr, #0
        bne               7b
        b                 9f
8:
        mcr               p15, #0x0, r3, c7, c10, #0x5
9:
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}
10:
        mov               r3, #0
        tst               r12, #255
        beq               20f
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               12f
        mcr               p15, #0x0, r3, c7, c10, #0x5
11:
        strex             lr, r2, [r0]
        cmp               lr, #0
        beq               12f
        ldrex             r12, [r0]
        cmp               r12, r1
        beq               11b
12:
        mcr               p15, #0x0, r3, c7, c10, #0x5
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}
13:
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               15f
        mcr               p15, #0x0, r3, c7, c10, #0x5
14:
        strex             lr, r2, [r0]
        cmp               lr, #0
        beq               15f
        ldrex             r12, [r0]
        cmp               r12, r1
        beq               14b
15:
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}
16:
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               17f
        strex             lr, r2, [r0]
        cmp               lr, #0
        bne               16b
17:
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}
18:
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               19f
        strex             lr, r2, [r0]
        cmp               lr, #0
        bne               18b
        mcr               p15, #0x0, r3, c7, c10, #0x5
19:
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}
20:
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               23f
        mcr               p15, #0x0, r3, c7, c10, #0x5
21:
        strex             lr, r2, [r0]
        cmp               lr, #0
        beq               22f
        ldrex             r12, [r0]
        cmp               r12, r1
        beq               21b
        b                 23f
22:
        mcr               p15, #0x0, r3, c7, c10, #0x5
23:
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}

<u32 as atomic_maybe_uninit::raw::AtomicCompareExchange>::atomic_compare_exchange_weak:
        push              {r11, lr}
        mov               r11, sp
        ldr               r12, [r11, #0x8]
        uxtb              r3, r3
        mov               lr, #1
        cmp               r3, #0
        beq               4f
        cmp               r3, #1
        beq               1f
        cmp               r3, #2
        bne               7f
        mov               r3, #0
        tst               r12, #255
        beq               13f
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        strex             lr, r2, [r0]
0:
        mcr               p15, #0x0, r3, c7, c10, #0x5
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}
1:
        mov               r3, #0
        tst               r12, #255
        beq               9f
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               2f
        mcr               p15, #0x0, r3, c7, c10, #0x5
        strex             lr, r2, [r0]
        cmp               lr, #0
        beq               3f
2:
        mcr               p15, #0x0, r3, c7, c10, #0x5
3:
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}
4:
        tst               r12, #255
        beq               11f
        mov               r3, #0
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               5f
        strex             lr, r2, [r0]
        cmp               lr, #0
        beq               6f
5:
        mcr               p15, #0x0, r3, c7, c10, #0x5
6:
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}
7:
        mov               r3, #0
        tst               r12, #255
        beq               15f
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               8f
        mcr               p15, #0x0, r3, c7, c10, #0x5
        strex             lr, r2, [r0]
8:
        mcr               p15, #0x0, r3, c7, c10, #0x5
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}
9:
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               10f
        mcr               p15, #0x0, r3, c7, c10, #0x5
        strex             lr, r2, [r0]
10:
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}
11:
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               12f
        strex             lr, r2, [r0]
12:
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}
13:
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               14f
        strex             lr, r2, [r0]
        cmp               lr, #0
        bne               14f
        mcr               p15, #0x0, r3, c7, c10, #0x5
14:
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}
15:
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               16f
        mcr               p15, #0x0, r3, c7, c10, #0x5
        strex             lr, r2, [r0]
        cmp               lr, #0
        bne               16f
        mcr               p15, #0x0, r3, c7, c10, #0x5
16:
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}

<u32 as atomic_maybe_uninit::raw::AtomicLoad>::atomic_load:
        push              {r11, lr}
        mov               r11, sp
        tst               r1, #255
        beq               0f
        mov               r1, #0
        ldr               r0, [r0]
        mcr               p15, #0x0, r1, c7, c10, #0x5
        pop               {r11, pc}
0:
        ldr               r0, [r0]
        pop               {r11, pc}

<u32 as atomic_maybe_uninit::raw::AtomicStore>::atomic_store:
        push              {r11, lr}
        mov               r11, sp
        uxtb              r2, r2
        cmp               r2, #0
        beq               0f
        cmp               r2, #1
        bne               1f
        mov               r2, #0
        mcr               p15, #0x0, r2, c7, c10, #0x5
        str               r1, [r0]
        pop               {r11, pc}
0:
        str               r1, [r0]
        pop               {r11, pc}
1:
        mov               r2, #0
        mcr               p15, #0x0, r2, c7, c10, #0x5
        str               r1, [r0]
        mcr               p15, #0x0, r2, c7, c10, #0x5
        pop               {r11, pc}
