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
        ldr               lr, [r11, #0x8]
        uxtb              r3, r3
        cmp               r3, #0
        beq               7f
        cmp               r3, #1
        beq               3f
        cmp               r3, #2
        bne               11f
        uxtb              r3, lr
        cmp               r3, #0
        beq               28f
        cmp               r3, #2
        cmpne             r3, #4
        bne               32f
        mov               r3, #0
        uxtb              r12, r1
0:
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               1f
        strexb            r1, r2, [r0]
        cmp               r1, #0
        bne               0b
        mcr               p15, #0x0, r3, c7, c10, #0x5
        b                 2f
1:
        mov               r1, #1
        mcr               p15, #0x0, r3, c7, c10, #0x5
2:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
3:
        uxtb              r3, lr
        cmp               r3, #0
        beq               20f
        cmp               r3, #2
        cmpne             r3, #4
        bne               32f
        mov               r3, #0
        uxtb              r12, r1
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               5f
        mcr               p15, #0x0, r3, c7, c10, #0x5
4:
        strexb            r1, r2, [r0]
        cmp               r1, #0
        beq               6f
        ldrexb            lr, [r0]
        cmp               lr, r12
        beq               4b
5:
        mov               r1, #1
        mcr               p15, #0x0, r3, c7, c10, #0x5
6:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
7:
        uxtb              r3, lr
        cmp               r3, #0
        beq               24f
        cmp               r3, #2
        cmpne             r3, #4
        bne               32f
        mov               r3, #0
        uxtb              r12, r1
8:
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               9f
        strexb            r1, r2, [r0]
        cmp               r1, #0
        bne               8b
        b                 10f
9:
        mov               r1, #1
        mcr               p15, #0x0, r3, c7, c10, #0x5
10:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
11:
        uxtb              r12, r1
        mov               r3, #0
        tst               lr, #255
        beq               15f
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               13f
        mcr               p15, #0x0, r3, c7, c10, #0x5
12:
        strexb            r1, r2, [r0]
        cmp               r1, #0
        beq               14f
        ldrexb            lr, [r0]
        cmp               lr, r12
        beq               12b
13:
        mov               r1, #1
14:
        mcr               p15, #0x0, r3, c7, c10, #0x5
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
15:
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               17f
        mcr               p15, #0x0, r3, c7, c10, #0x5
16:
        strexb            r1, r2, [r0]
        cmp               r1, #0
        beq               18f
        ldrexb            lr, [r0]
        cmp               lr, r12
        beq               16b
17:
        mov               r1, #1
        b                 19f
18:
        mcr               p15, #0x0, r3, c7, c10, #0x5
19:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
20:
        mov               r3, #0
        uxtb              r12, r1
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               22f
        mcr               p15, #0x0, r3, c7, c10, #0x5
21:
        strexb            r1, r2, [r0]
        cmp               r1, #0
        beq               23f
        ldrexb            lr, [r0]
        cmp               lr, r12
        beq               21b
22:
        mov               r1, #1
23:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
24:
        uxtb              r3, r1
25:
        ldrexb            lr, [r0]
        cmp               lr, r3
        bne               26f
        strexb            r1, r2, [r0]
        cmp               r1, #0
        bne               25b
        b                 27f
26:
        mov               r1, #1
27:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
28:
        mov               r3, #0
        uxtb              r12, r1
29:
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               30f
        strexb            r1, r2, [r0]
        cmp               r1, #0
        bne               29b
        mcr               p15, #0x0, r3, c7, c10, #0x5
        b                 31f
30:
        mov               r1, #1
31:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
32:
        ldr               r0, [pc, #0x8]          @ 0x28c <<u8 as atomic_maybe_uninit::raw::AtomicCompareExchange>::atomic_compare_exchange+0x28c>
        mov               r1, #40
        ldr               r2, [pc, #0x4]          @ 0x290 <<u8 as atomic_maybe_uninit::raw::AtomicCompareExchange>::atomic_compare_exchange+0x290>
33:
        bl                33f

<u8 as atomic_maybe_uninit::raw::AtomicCompareExchange>::atomic_compare_exchange_weak:
        push              {r11, lr}
        mov               r11, sp
        ldr               lr, [r11, #0x8]
        uxtb              r3, r3
        cmp               r3, #0
        beq               6f
        cmp               r3, #1
        beq               2f
        cmp               r3, #2
        bne               10f
        uxtb              r3, lr
        cmp               r3, #0
        beq               23f
        cmp               r3, #2
        cmpne             r3, #4
        bne               27f
        mov               r3, #0
        uxtb              r12, r1
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               0f
        strexb            r1, r2, [r0]
        b                 1f
0:
        mov               r1, #1
1:
        mcr               p15, #0x0, r3, c7, c10, #0x5
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
2:
        uxtb              r3, lr
        cmp               r3, #0
        beq               17f
        cmp               r3, #2
        cmpne             r3, #4
        bne               27f
        mov               r3, #0
        uxtb              r12, r1
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               3f
        mcr               p15, #0x0, r3, c7, c10, #0x5
        strexb            r1, r2, [r0]
        cmp               r1, #0
        beq               5f
        b                 4f
3:
        mov               r1, #1
4:
        mcr               p15, #0x0, r3, c7, c10, #0x5
5:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
6:
        uxtb              r3, lr
        cmp               r3, #0
        beq               20f
        cmp               r3, #2
        cmpne             r3, #4
        bne               27f
        mov               r3, #0
        uxtb              r12, r1
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               7f
        strexb            r1, r2, [r0]
        cmp               r1, #0
        beq               9f
        b                 8f
7:
        mov               r1, #1
8:
        mcr               p15, #0x0, r3, c7, c10, #0x5
9:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
10:
        uxtb              r12, r1
        mov               r3, #0
        tst               lr, #255
        beq               13f
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               11f
        mcr               p15, #0x0, r3, c7, c10, #0x5
        strexb            r1, r2, [r0]
        b                 12f
11:
        mov               r1, #1
12:
        mcr               p15, #0x0, r3, c7, c10, #0x5
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
13:
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               14f
        mcr               p15, #0x0, r3, c7, c10, #0x5
        strexb            r1, r2, [r0]
        cmp               r1, #0
        beq               15f
        b                 16f
14:
        mov               r1, #1
        b                 16f
15:
        mcr               p15, #0x0, r3, c7, c10, #0x5
16:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
17:
        mov               r3, #0
        uxtb              r12, r1
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               18f
        mcr               p15, #0x0, r3, c7, c10, #0x5
        strexb            r1, r2, [r0]
        b                 19f
18:
        mov               r1, #1
19:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
20:
        uxtb              r3, r1
        ldrexb            lr, [r0]
        cmp               lr, r3
        bne               21f
        strexb            r1, r2, [r0]
        b                 22f
21:
        mov               r1, #1
22:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
23:
        mov               r3, #0
        uxtb              r12, r1
        ldrexb            lr, [r0]
        cmp               lr, r12
        bne               24f
        strexb            r1, r2, [r0]
        cmp               r1, #0
        beq               25f
        b                 26f
24:
        mov               r1, #1
        b                 26f
25:
        mcr               p15, #0x0, r3, c7, c10, #0x5
26:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
27:
        ldr               r0, [pc, #0x8]          @ 0x24c <<u8 as atomic_maybe_uninit::raw::AtomicCompareExchange>::atomic_compare_exchange_weak+0x24c>
        mov               r1, #40
        ldr               r2, [pc, #0x4]          @ 0x250 <<u8 as atomic_maybe_uninit::raw::AtomicCompareExchange>::atomic_compare_exchange_weak+0x250>
28:
        bl                28f

<u8 as atomic_maybe_uninit::raw::AtomicLoad>::atomic_load:
        uxtb              r1, r1
        cmp               r1, #0
        beq               0f
        cmp               r1, #2
        cmpne             r1, #4
        bne               1f
        mov               r1, #0
        ldrb              r0, [r0]
        mcr               p15, #0x0, r1, c7, c10, #0x5
        bx                lr
0:
        ldrb              r0, [r0]
        bx                lr
1:
        push              {r11, lr}
        mov               r11, sp
        ldr               r0, [pc, #0x8]          @ 0x48 <<u8 as atomic_maybe_uninit::raw::AtomicLoad>::atomic_load+0x48>
        mov               r1, #40
        ldr               r2, [pc, #0x4]          @ 0x4c <<u8 as atomic_maybe_uninit::raw::AtomicLoad>::atomic_load+0x4c>
2:
        bl                2f

<u8 as atomic_maybe_uninit::raw::AtomicStore>::atomic_store:
        uxtb              r2, r2
        cmp               r2, #0
        beq               1f
        cmp               r2, #1
        beq               0f
        cmp               r2, #4
        bne               2f
        mov               r2, #0
        mcr               p15, #0x0, r2, c7, c10, #0x5
        strb              r1, [r0]
        mcr               p15, #0x0, r2, c7, c10, #0x5
        bx                lr
0:
        mov               r2, #0
        mcr               p15, #0x0, r2, c7, c10, #0x5
        strb              r1, [r0]
        bx                lr
1:
        strb              r1, [r0]
        bx                lr
2:
        push              {r11, lr}
        mov               r11, sp
        ldr               r0, [pc, #0x8]          @ 0x60 <<u8 as atomic_maybe_uninit::raw::AtomicStore>::atomic_store+0x60>
        mov               r1, #40
        ldr               r2, [pc, #0x4]          @ 0x64 <<u8 as atomic_maybe_uninit::raw::AtomicStore>::atomic_store+0x64>
3:
        bl                3f

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
        ldr               lr, [r11, #0x8]
        uxtb              r3, r3
        cmp               r3, #0
        beq               7f
        cmp               r3, #1
        beq               3f
        cmp               r3, #2
        bne               11f
        uxtb              r3, lr
        cmp               r3, #0
        beq               28f
        cmp               r3, #2
        cmpne             r3, #4
        bne               32f
        mov               r3, #0
        uxth              r12, r1
0:
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               1f
        strexh            r1, r2, [r0]
        cmp               r1, #0
        bne               0b
        mcr               p15, #0x0, r3, c7, c10, #0x5
        b                 2f
1:
        mov               r1, #1
        mcr               p15, #0x0, r3, c7, c10, #0x5
2:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
3:
        uxtb              r3, lr
        cmp               r3, #0
        beq               20f
        cmp               r3, #2
        cmpne             r3, #4
        bne               32f
        mov               r3, #0
        uxth              r12, r1
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               5f
        mcr               p15, #0x0, r3, c7, c10, #0x5
4:
        strexh            r1, r2, [r0]
        cmp               r1, #0
        beq               6f
        ldrexh            lr, [r0]
        cmp               lr, r12
        beq               4b
5:
        mov               r1, #1
        mcr               p15, #0x0, r3, c7, c10, #0x5
6:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
7:
        uxtb              r3, lr
        cmp               r3, #0
        beq               24f
        cmp               r3, #2
        cmpne             r3, #4
        bne               32f
        mov               r3, #0
        uxth              r12, r1
8:
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               9f
        strexh            r1, r2, [r0]
        cmp               r1, #0
        bne               8b
        b                 10f
9:
        mov               r1, #1
        mcr               p15, #0x0, r3, c7, c10, #0x5
10:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
11:
        uxth              r12, r1
        mov               r3, #0
        tst               lr, #255
        beq               15f
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               13f
        mcr               p15, #0x0, r3, c7, c10, #0x5
12:
        strexh            r1, r2, [r0]
        cmp               r1, #0
        beq               14f
        ldrexh            lr, [r0]
        cmp               lr, r12
        beq               12b
13:
        mov               r1, #1
14:
        mcr               p15, #0x0, r3, c7, c10, #0x5
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
15:
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               17f
        mcr               p15, #0x0, r3, c7, c10, #0x5
16:
        strexh            r1, r2, [r0]
        cmp               r1, #0
        beq               18f
        ldrexh            lr, [r0]
        cmp               lr, r12
        beq               16b
17:
        mov               r1, #1
        b                 19f
18:
        mcr               p15, #0x0, r3, c7, c10, #0x5
19:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
20:
        mov               r3, #0
        uxth              r12, r1
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               22f
        mcr               p15, #0x0, r3, c7, c10, #0x5
21:
        strexh            r1, r2, [r0]
        cmp               r1, #0
        beq               23f
        ldrexh            lr, [r0]
        cmp               lr, r12
        beq               21b
22:
        mov               r1, #1
23:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
24:
        uxth              r3, r1
25:
        ldrexh            lr, [r0]
        cmp               lr, r3
        bne               26f
        strexh            r1, r2, [r0]
        cmp               r1, #0
        bne               25b
        b                 27f
26:
        mov               r1, #1
27:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
28:
        mov               r3, #0
        uxth              r12, r1
29:
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               30f
        strexh            r1, r2, [r0]
        cmp               r1, #0
        bne               29b
        mcr               p15, #0x0, r3, c7, c10, #0x5
        b                 31f
30:
        mov               r1, #1
31:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
32:
        ldr               r0, [pc, #0x8]          @ 0x28c <<u16 as atomic_maybe_uninit::raw::AtomicCompareExchange>::atomic_compare_exchange+0x28c>
        mov               r1, #40
        ldr               r2, [pc, #0x4]          @ 0x290 <<u16 as atomic_maybe_uninit::raw::AtomicCompareExchange>::atomic_compare_exchange+0x290>
33:
        bl                33f

<u16 as atomic_maybe_uninit::raw::AtomicCompareExchange>::atomic_compare_exchange_weak:
        push              {r11, lr}
        mov               r11, sp
        ldr               lr, [r11, #0x8]
        uxtb              r3, r3
        cmp               r3, #0
        beq               6f
        cmp               r3, #1
        beq               2f
        cmp               r3, #2
        bne               10f
        uxtb              r3, lr
        cmp               r3, #0
        beq               23f
        cmp               r3, #2
        cmpne             r3, #4
        bne               27f
        mov               r3, #0
        uxth              r12, r1
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               0f
        strexh            r1, r2, [r0]
        b                 1f
0:
        mov               r1, #1
1:
        mcr               p15, #0x0, r3, c7, c10, #0x5
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
2:
        uxtb              r3, lr
        cmp               r3, #0
        beq               17f
        cmp               r3, #2
        cmpne             r3, #4
        bne               27f
        mov               r3, #0
        uxth              r12, r1
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               3f
        mcr               p15, #0x0, r3, c7, c10, #0x5
        strexh            r1, r2, [r0]
        cmp               r1, #0
        beq               5f
        b                 4f
3:
        mov               r1, #1
4:
        mcr               p15, #0x0, r3, c7, c10, #0x5
5:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
6:
        uxtb              r3, lr
        cmp               r3, #0
        beq               20f
        cmp               r3, #2
        cmpne             r3, #4
        bne               27f
        mov               r3, #0
        uxth              r12, r1
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               7f
        strexh            r1, r2, [r0]
        cmp               r1, #0
        beq               9f
        b                 8f
7:
        mov               r1, #1
8:
        mcr               p15, #0x0, r3, c7, c10, #0x5
9:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
10:
        uxth              r12, r1
        mov               r3, #0
        tst               lr, #255
        beq               13f
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               11f
        mcr               p15, #0x0, r3, c7, c10, #0x5
        strexh            r1, r2, [r0]
        b                 12f
11:
        mov               r1, #1
12:
        mcr               p15, #0x0, r3, c7, c10, #0x5
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
13:
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               14f
        mcr               p15, #0x0, r3, c7, c10, #0x5
        strexh            r1, r2, [r0]
        cmp               r1, #0
        beq               15f
        b                 16f
14:
        mov               r1, #1
        b                 16f
15:
        mcr               p15, #0x0, r3, c7, c10, #0x5
16:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
17:
        mov               r3, #0
        uxth              r12, r1
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               18f
        mcr               p15, #0x0, r3, c7, c10, #0x5
        strexh            r1, r2, [r0]
        b                 19f
18:
        mov               r1, #1
19:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
20:
        uxth              r3, r1
        ldrexh            lr, [r0]
        cmp               lr, r3
        bne               21f
        strexh            r1, r2, [r0]
        b                 22f
21:
        mov               r1, #1
22:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
23:
        mov               r3, #0
        uxth              r12, r1
        ldrexh            lr, [r0]
        cmp               lr, r12
        bne               24f
        strexh            r1, r2, [r0]
        cmp               r1, #0
        beq               25f
        b                 26f
24:
        mov               r1, #1
        b                 26f
25:
        mcr               p15, #0x0, r3, c7, c10, #0x5
26:
        clz               r0, r1
        lsr               r1, r0, #5
        mov               r0, lr
        pop               {r11, pc}
27:
        ldr               r0, [pc, #0x8]          @ 0x24c <<u16 as atomic_maybe_uninit::raw::AtomicCompareExchange>::atomic_compare_exchange_weak+0x24c>
        mov               r1, #40
        ldr               r2, [pc, #0x4]          @ 0x250 <<u16 as atomic_maybe_uninit::raw::AtomicCompareExchange>::atomic_compare_exchange_weak+0x250>
28:
        bl                28f

<u16 as atomic_maybe_uninit::raw::AtomicLoad>::atomic_load:
        uxtb              r1, r1
        cmp               r1, #0
        beq               0f
        cmp               r1, #2
        cmpne             r1, #4
        bne               1f
        mov               r1, #0
        ldrh              r0, [r0]
        mcr               p15, #0x0, r1, c7, c10, #0x5
        bx                lr
0:
        ldrh              r0, [r0]
        bx                lr
1:
        push              {r11, lr}
        mov               r11, sp
        ldr               r0, [pc, #0x8]          @ 0x48 <<u16 as atomic_maybe_uninit::raw::AtomicLoad>::atomic_load+0x48>
        mov               r1, #40
        ldr               r2, [pc, #0x4]          @ 0x4c <<u16 as atomic_maybe_uninit::raw::AtomicLoad>::atomic_load+0x4c>
2:
        bl                2f

<u16 as atomic_maybe_uninit::raw::AtomicStore>::atomic_store:
        uxtb              r2, r2
        cmp               r2, #0
        beq               1f
        cmp               r2, #1
        beq               0f
        cmp               r2, #4
        bne               2f
        mov               r2, #0
        mcr               p15, #0x0, r2, c7, c10, #0x5
        strh              r1, [r0]
        mcr               p15, #0x0, r2, c7, c10, #0x5
        bx                lr
0:
        mov               r2, #0
        mcr               p15, #0x0, r2, c7, c10, #0x5
        strh              r1, [r0]
        bx                lr
1:
        strh              r1, [r0]
        bx                lr
2:
        push              {r11, lr}
        mov               r11, sp
        ldr               r0, [pc, #0x8]          @ 0x60 <<u16 as atomic_maybe_uninit::raw::AtomicStore>::atomic_store+0x60>
        mov               r1, #40
        ldr               r2, [pc, #0x4]          @ 0x64 <<u16 as atomic_maybe_uninit::raw::AtomicStore>::atomic_store+0x64>
3:
        bl                3f

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
        cmp               r3, #0
        beq               7f
        cmp               r3, #1
        beq               3f
        cmp               r3, #2
        bne               11f
        uxtb              r3, r12
        cmp               r3, #0
        beq               27f
        cmp               r3, #2
        cmpne             r3, #4
        bne               31f
        mov               r3, #0
0:
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               1f
        strex             lr, r2, [r0]
        cmp               lr, #0
        bne               0b
        mcr               p15, #0x0, r3, c7, c10, #0x5
        b                 2f
1:
        mov               lr, #1
        mcr               p15, #0x0, r3, c7, c10, #0x5
2:
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}
3:
        uxtb              r3, r12
        cmp               r3, #0
        beq               20f
        cmp               r3, #2
        cmpne             r3, #4
        bne               31f
        mov               r3, #0
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               5f
        mcr               p15, #0x0, r3, c7, c10, #0x5
4:
        strex             lr, r2, [r0]
        cmp               lr, #0
        beq               6f
        ldrex             r12, [r0]
        cmp               r12, r1
        beq               4b
5:
        mov               lr, #1
        mcr               p15, #0x0, r3, c7, c10, #0x5
6:
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}
7:
        uxtb              r3, r12
        cmp               r3, #0
        beq               24f
        cmp               r3, #2
        cmpne             r3, #4
        bne               31f
        mov               r3, #0
8:
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               9f
        strex             lr, r2, [r0]
        cmp               lr, #0
        bne               8b
        b                 10f
9:
        mov               lr, #1
        mcr               p15, #0x0, r3, c7, c10, #0x5
10:
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}
11:
        mov               r3, #0
        tst               r12, #255
        beq               15f
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               13f
        mcr               p15, #0x0, r3, c7, c10, #0x5
12:
        strex             lr, r2, [r0]
        cmp               lr, #0
        beq               14f
        ldrex             r12, [r0]
        cmp               r12, r1
        beq               12b
13:
        mov               lr, #1
14:
        mcr               p15, #0x0, r3, c7, c10, #0x5
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}
15:
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               17f
        mcr               p15, #0x0, r3, c7, c10, #0x5
16:
        strex             lr, r2, [r0]
        cmp               lr, #0
        beq               18f
        ldrex             r12, [r0]
        cmp               r12, r1
        beq               16b
17:
        mov               lr, #1
        b                 19f
18:
        mcr               p15, #0x0, r3, c7, c10, #0x5
19:
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}
20:
        mov               r3, #0
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               22f
        mcr               p15, #0x0, r3, c7, c10, #0x5
21:
        strex             lr, r2, [r0]
        cmp               lr, #0
        beq               23f
        ldrex             r12, [r0]
        cmp               r12, r1
        beq               21b
22:
        mov               lr, #1
23:
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}
24:
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               25f
        strex             lr, r2, [r0]
        cmp               lr, #0
        bne               24b
        b                 26f
25:
        mov               lr, #1
26:
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}
27:
        mov               r3, #0
28:
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               29f
        strex             lr, r2, [r0]
        cmp               lr, #0
        bne               28b
        mcr               p15, #0x0, r3, c7, c10, #0x5
        b                 30f
29:
        mov               lr, #1
30:
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}
31:
        ldr               r0, [pc, #0x8]          @ 0x270 <<u32 as atomic_maybe_uninit::raw::AtomicCompareExchange>::atomic_compare_exchange+0x270>
        mov               r1, #40
        ldr               r2, [pc, #0x4]          @ 0x274 <<u32 as atomic_maybe_uninit::raw::AtomicCompareExchange>::atomic_compare_exchange+0x274>
32:
        bl                32f

<u32 as atomic_maybe_uninit::raw::AtomicCompareExchange>::atomic_compare_exchange_weak:
        push              {r11, lr}
        mov               r11, sp
        ldr               r12, [r11, #0x8]
        uxtb              r3, r3
        cmp               r3, #0
        beq               6f
        cmp               r3, #1
        beq               2f
        cmp               r3, #2
        bne               10f
        uxtb              r3, r12
        cmp               r3, #0
        beq               23f
        cmp               r3, #2
        cmpne             r3, #4
        bne               27f
        mov               r3, #0
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               0f
        strex             lr, r2, [r0]
        b                 1f
0:
        mov               lr, #1
1:
        mcr               p15, #0x0, r3, c7, c10, #0x5
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}
2:
        uxtb              r3, r12
        cmp               r3, #0
        beq               17f
        cmp               r3, #2
        cmpne             r3, #4
        bne               27f
        mov               r3, #0
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               3f
        mcr               p15, #0x0, r3, c7, c10, #0x5
        strex             lr, r2, [r0]
        cmp               lr, #0
        beq               5f
        b                 4f
3:
        mov               lr, #1
4:
        mcr               p15, #0x0, r3, c7, c10, #0x5
5:
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}
6:
        uxtb              r3, r12
        cmp               r3, #0
        beq               20f
        cmp               r3, #2
        cmpne             r3, #4
        bne               27f
        mov               r3, #0
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               7f
        strex             lr, r2, [r0]
        cmp               lr, #0
        beq               9f
        b                 8f
7:
        mov               lr, #1
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
        beq               13f
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               11f
        mcr               p15, #0x0, r3, c7, c10, #0x5
        strex             lr, r2, [r0]
        b                 12f
11:
        mov               lr, #1
12:
        mcr               p15, #0x0, r3, c7, c10, #0x5
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}
13:
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               14f
        mcr               p15, #0x0, r3, c7, c10, #0x5
        strex             lr, r2, [r0]
        cmp               lr, #0
        beq               15f
        b                 16f
14:
        mov               lr, #1
        b                 16f
15:
        mcr               p15, #0x0, r3, c7, c10, #0x5
16:
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}
17:
        mov               r3, #0
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               18f
        mcr               p15, #0x0, r3, c7, c10, #0x5
        strex             lr, r2, [r0]
        b                 19f
18:
        mov               lr, #1
19:
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}
20:
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               21f
        strex             lr, r2, [r0]
        b                 22f
21:
        mov               lr, #1
22:
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}
23:
        mov               r3, #0
        ldrex             r12, [r0]
        cmp               r12, r1
        bne               24f
        strex             lr, r2, [r0]
        cmp               lr, #0
        beq               25f
        b                 26f
24:
        mov               lr, #1
        b                 26f
25:
        mcr               p15, #0x0, r3, c7, c10, #0x5
26:
        clz               r0, lr
        lsr               r1, r0, #5
        mov               r0, r12
        pop               {r11, pc}
27:
        ldr               r0, [pc, #0x8]          @ 0x230 <<u32 as atomic_maybe_uninit::raw::AtomicCompareExchange>::atomic_compare_exchange_weak+0x230>
        mov               r1, #40
        ldr               r2, [pc, #0x4]          @ 0x234 <<u32 as atomic_maybe_uninit::raw::AtomicCompareExchange>::atomic_compare_exchange_weak+0x234>
28:
        bl                28f

<u32 as atomic_maybe_uninit::raw::AtomicLoad>::atomic_load:
        uxtb              r1, r1
        cmp               r1, #0
        beq               0f
        cmp               r1, #2
        cmpne             r1, #4
        bne               1f
        mov               r1, #0
        ldr               r0, [r0]
        mcr               p15, #0x0, r1, c7, c10, #0x5
        bx                lr
0:
        ldr               r0, [r0]
        bx                lr
1:
        push              {r11, lr}
        mov               r11, sp
        ldr               r0, [pc, #0x8]          @ 0x48 <<u32 as atomic_maybe_uninit::raw::AtomicLoad>::atomic_load+0x48>
        mov               r1, #40
        ldr               r2, [pc, #0x4]          @ 0x4c <<u32 as atomic_maybe_uninit::raw::AtomicLoad>::atomic_load+0x4c>
2:
        bl                2f

<u32 as atomic_maybe_uninit::raw::AtomicStore>::atomic_store:
        uxtb              r2, r2
        cmp               r2, #0
        beq               1f
        cmp               r2, #1
        beq               0f
        cmp               r2, #4
        bne               2f
        mov               r2, #0
        mcr               p15, #0x0, r2, c7, c10, #0x5
        str               r1, [r0]
        mcr               p15, #0x0, r2, c7, c10, #0x5
        bx                lr
0:
        mov               r2, #0
        mcr               p15, #0x0, r2, c7, c10, #0x5
        str               r1, [r0]
        bx                lr
1:
        str               r1, [r0]
        bx                lr
2:
        push              {r11, lr}
        mov               r11, sp
        ldr               r0, [pc, #0x8]          @ 0x60 <<u32 as atomic_maybe_uninit::raw::AtomicStore>::atomic_store+0x60>
        mov               r1, #40
        ldr               r2, [pc, #0x4]          @ 0x64 <<u32 as atomic_maybe_uninit::raw::AtomicStore>::atomic_store+0x64>
3:
        bl                3f

<u64 as atomic_maybe_uninit::raw::AtomicLoad>::atomic_load:
        uxtb              r1, r1
        cmp               r1, #0
        beq               0f
        cmp               r1, #2
        cmpne             r1, #4
        bne               1f
        mov               r2, #0
        ldrexd            r0, r1, [r0]
        mcr               p15, #0x0, r2, c7, c10, #0x5
        bx                lr
0:
        ldrexd            r0, r1, [r0]
        bx                lr
1:
        push              {r11, lr}
        mov               r11, sp
        ldr               r0, [pc, #0x8]          @ 0x48 <<u64 as atomic_maybe_uninit::raw::AtomicLoad>::atomic_load+0x48>
        mov               r1, #40
        ldr               r2, [pc, #0x4]          @ 0x4c <<u64 as atomic_maybe_uninit::raw::AtomicLoad>::atomic_load+0x4c>
2:
        bl                2f

<u64 as atomic_maybe_uninit::raw::AtomicStore>::atomic_store:
        push              {r4, r5, r11, lr}
        add               r11, sp, #8
        ldrb              r1, [r11, #0x8]
        cmp               r1, #0
        beq               3f
        cmp               r1, #1
        beq               1f
        cmp               r1, #4
        bne               4f
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
0:
        ldrexd            r4, r5, [r0]
        strexd            r4, r2, r3, [r0]
        cmp               r4, #0
        bne               0b
        mcr               p15, #0x0, r1, c7, c10, #0x5
        pop               {r4, r5, r11, pc}
1:
        mov               r1, #0
        mcr               p15, #0x0, r1, c7, c10, #0x5
2:
        ldrexd            r4, r5, [r0]
        strexd            r4, r2, r3, [r0]
        cmp               r4, #0
        bne               2b
        pop               {r4, r5, r11, pc}
3:
        ldrexd            r4, r5, [r0]
        strexd            r4, r2, r3, [r0]
        cmp               r4, #0
        bne               3b
        pop               {r4, r5, r11, pc}
4:
        ldr               r0, [pc, #0x8]          @ 0x84 <<u64 as atomic_maybe_uninit::raw::AtomicStore>::atomic_store+0x84>
        mov               r1, #40
        ldr               r2, [pc, #0x4]          @ 0x88 <<u64 as atomic_maybe_uninit::raw::AtomicStore>::atomic_store+0x88>
5:
        bl                5f

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
        beq               7f
        cmp               r3, #1
        beq               3f
        cmp               r3, #2
        bne               11f
        uxtb              r2, r2
        cmp               r2, #0
        beq               27f
        cmp               r2, #2
        cmpne             r2, #4
        bne               31f
        mov               r8, #0
0:
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r6, r2, lr
        orrs              r6, r6, r7
        bne               1f
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0
        bne               0b
        mcr               p15, #0x0, r8, c7, c10, #0x5
        b                 2f
1:
        mov               r6, #1
        mcr               p15, #0x0, r8, c7, c10, #0x5
2:
        eor               r1, r6, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r10, r11, pc}
3:
        uxtb              r2, r2
        cmp               r2, #0
        beq               20f
        cmp               r2, #2
        cmpne             r2, #4
        bne               31f
        mov               r8, #0
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r6, r2, lr
        orrs              r6, r6, r7
        bne               5f
        mcr               p15, #0x0, r8, c7, c10, #0x5
4:
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0
        beq               6f
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r6, r2, lr
        orrs              r6, r6, r7
        beq               4b
5:
        mov               r6, #1
        mcr               p15, #0x0, r8, c7, c10, #0x5
6:
        eor               r1, r6, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r10, r11, pc}
7:
        uxtb              r2, r2
        cmp               r2, #0
        beq               24f
        cmp               r2, #2
        cmpne             r2, #4
        bne               31f
        mov               r8, #0
8:
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r6, r2, lr
        orrs              r6, r6, r7
        bne               9f
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0
        bne               8b
        b                 10f
9:
        mov               r6, #1
        mcr               p15, #0x0, r8, c7, c10, #0x5
10:
        eor               r1, r6, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r10, r11, pc}
11:
        mov               r8, #0
        tst               r2, #255
        beq               15f
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r6, r2, lr
        orrs              r6, r6, r7
        bne               13f
        mcr               p15, #0x0, r8, c7, c10, #0x5
12:
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0
        beq               14f
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r6, r2, lr
        orrs              r6, r6, r7
        beq               12b
13:
        mov               r6, #1
14:
        mcr               p15, #0x0, r8, c7, c10, #0x5
        eor               r1, r6, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r10, r11, pc}
15:
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r6, r2, lr
        orrs              r6, r6, r7
        bne               17f
        mcr               p15, #0x0, r8, c7, c10, #0x5
16:
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0
        beq               18f
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r6, r2, lr
        orrs              r6, r6, r7
        beq               16b
17:
        mov               r6, #1
        b                 19f
18:
        mcr               p15, #0x0, r8, c7, c10, #0x5
19:
        eor               r1, r6, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r10, r11, pc}
20:
        mov               r8, #0
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r6, r2, lr
        orrs              r6, r6, r7
        bne               22f
        mcr               p15, #0x0, r8, c7, c10, #0x5
21:
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0
        beq               23f
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r6, r2, lr
        orrs              r6, r6, r7
        beq               21b
22:
        mov               r6, #1
23:
        eor               r1, r6, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r10, r11, pc}
24:
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r6, r2, lr
        orrs              r6, r6, r7
        bne               25f
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0
        bne               24b
        b                 26f
25:
        mov               r6, #1
26:
        eor               r1, r6, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r10, r11, pc}
27:
        mov               r8, #0
28:
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r6, r2, lr
        orrs              r6, r6, r7
        bne               29f
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0
        bne               28b
        mcr               p15, #0x0, r8, c7, c10, #0x5
        b                 30f
29:
        mov               r6, #1
30:
        eor               r1, r6, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r10, r11, pc}
31:
        ldr               r0, [pc, #0x8]          @ 0x2e0 <<u64 as atomic_maybe_uninit::raw::AtomicCompareExchange>::atomic_compare_exchange+0x2e0>
        mov               r1, #40
        ldr               r2, [pc, #0x4]          @ 0x2e4 <<u64 as atomic_maybe_uninit::raw::AtomicCompareExchange>::atomic_compare_exchange+0x2e4>
32:
        bl                32f

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
        beq               6f
        cmp               r3, #1
        beq               2f
        cmp               r3, #2
        bne               10f
        uxtb              r2, r2
        cmp               r2, #0
        beq               23f
        cmp               r2, #2
        cmpne             r2, #4
        bne               27f
        mov               r8, #0
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
        mcr               p15, #0x0, r8, c7, c10, #0x5
        eor               r1, r6, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r10, r11, pc}
2:
        uxtb              r2, r2
        cmp               r2, #0
        beq               17f
        cmp               r2, #2
        cmpne             r2, #4
        bne               27f
        mov               r8, #0
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r6, r2, lr
        orrs              r6, r6, r7
        bne               3f
        mcr               p15, #0x0, r8, c7, c10, #0x5
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0
        beq               5f
        b                 4f
3:
        mov               r6, #1
4:
        mcr               p15, #0x0, r8, c7, c10, #0x5
5:
        eor               r1, r6, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r10, r11, pc}
6:
        uxtb              r2, r2
        cmp               r2, #0
        beq               20f
        cmp               r2, #2
        cmpne             r2, #4
        bne               27f
        mov               r8, #0
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r6, r2, lr
        orrs              r6, r6, r7
        bne               7f
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0
        beq               9f
        b                 8f
7:
        mov               r6, #1
8:
        mcr               p15, #0x0, r8, c7, c10, #0x5
9:
        eor               r1, r6, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r10, r11, pc}
10:
        mov               r8, #0
        tst               r2, #255
        beq               13f
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r6, r2, lr
        orrs              r6, r6, r7
        bne               11f
        mcr               p15, #0x0, r8, c7, c10, #0x5
        strexd            r6, r4, r5, [r1]
        b                 12f
11:
        mov               r6, #1
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
        bne               14f
        mcr               p15, #0x0, r8, c7, c10, #0x5
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0
        beq               15f
        b                 16f
14:
        mov               r6, #1
        b                 16f
15:
        mcr               p15, #0x0, r8, c7, c10, #0x5
16:
        eor               r1, r6, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r10, r11, pc}
17:
        mov               r8, #0
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r6, r2, lr
        orrs              r6, r6, r7
        bne               18f
        mcr               p15, #0x0, r8, c7, c10, #0x5
        strexd            r6, r4, r5, [r1]
        b                 19f
18:
        mov               r6, #1
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
        bne               21f
        strexd            r6, r4, r5, [r1]
        b                 22f
21:
        mov               r6, #1
22:
        eor               r1, r6, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r10, r11, pc}
23:
        mov               r8, #0
        ldrexd            r2, r3, [r1]
        eor               r7, r3, r12
        eor               r6, r2, lr
        orrs              r6, r6, r7
        bne               24f
        strexd            r6, r4, r5, [r1]
        cmp               r6, #0
        beq               25f
        b                 26f
24:
        mov               r6, #1
        b                 26f
25:
        mcr               p15, #0x0, r8, c7, c10, #0x5
26:
        eor               r1, r6, #1
        strd              r2, r3, [r0]
        strb              r1, [r0, #0x8]
        pop               {r4, r5, r6, r7, r8, r10, r11, pc}
27:
        ldr               r0, [pc, #0x8]          @ 0x280 <<u64 as atomic_maybe_uninit::raw::AtomicCompareExchange>::atomic_compare_exchange_weak+0x280>
        mov               r1, #40
        ldr               r2, [pc, #0x4]          @ 0x284 <<u64 as atomic_maybe_uninit::raw::AtomicCompareExchange>::atomic_compare_exchange_weak+0x284>
28:
        bl                28f

