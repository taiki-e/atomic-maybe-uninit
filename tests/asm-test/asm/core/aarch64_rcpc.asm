asm_test::compare_exchange::u8::acqrel_seqcst:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxtb
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u8::seqcst_seqcst:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxtb
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u8::acqrel_acquire:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxtb
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u8::acqrel_relaxed:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxtb
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u8::acquire_seqcst:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxtb
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u8::relaxed_seqcst:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxtb
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u8::release_seqcst:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxtb
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u8::seqcst_acquire:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxtb
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u8::seqcst_relaxed:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxtb
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u8::acquire_acquire:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxtb
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u8::acquire_relaxed:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxtb
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u8::relaxed_acquire:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxtb
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u8::relaxed_relaxed:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxtb
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u8::release_acquire:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxtb
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u8::release_relaxed:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxtb
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u16::acqrel_seqcst:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxth
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u16::seqcst_seqcst:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxth
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u16::acqrel_acquire:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxth
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u16::acqrel_relaxed:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxth
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u16::acquire_seqcst:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxth
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u16::relaxed_seqcst:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxth
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u16::release_seqcst:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxth
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u16::seqcst_acquire:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxth
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u16::seqcst_relaxed:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxth
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u16::acquire_acquire:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxth
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u16::acquire_relaxed:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxth
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u16::relaxed_acquire:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxth
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u16::relaxed_relaxed:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxth
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u16::release_acquire:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxth
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u16::release_relaxed:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxth
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u32::acqrel_seqcst:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u32::seqcst_seqcst:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u32::acqrel_acquire:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u32::acqrel_relaxed:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u32::acquire_seqcst:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u32::relaxed_seqcst:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u32::release_seqcst:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u32::seqcst_acquire:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u32::seqcst_relaxed:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u32::acquire_acquire:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u32::acquire_relaxed:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u32::relaxed_acquire:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u32::relaxed_relaxed:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u32::release_acquire:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u32::release_relaxed:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u64::acqrel_seqcst:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               x19, x1
        mov               x0, x1
        mov               x1, x2
        mov               x2, x8
0:
        bl                0f
        cmp               x0, x19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u64::seqcst_seqcst:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               x19, x1
        mov               x0, x1
        mov               x1, x2
        mov               x2, x8
0:
        bl                0f
        cmp               x0, x19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u64::acqrel_acquire:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               x19, x1
        mov               x0, x1
        mov               x1, x2
        mov               x2, x8
0:
        bl                0f
        cmp               x0, x19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u64::acqrel_relaxed:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               x19, x1
        mov               x0, x1
        mov               x1, x2
        mov               x2, x8
0:
        bl                0f
        cmp               x0, x19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u64::acquire_seqcst:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               x19, x1
        mov               x0, x1
        mov               x1, x2
        mov               x2, x8
0:
        bl                0f
        cmp               x0, x19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u64::relaxed_seqcst:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               x19, x1
        mov               x0, x1
        mov               x1, x2
        mov               x2, x8
0:
        bl                0f
        cmp               x0, x19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u64::release_seqcst:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               x19, x1
        mov               x0, x1
        mov               x1, x2
        mov               x2, x8
0:
        bl                0f
        cmp               x0, x19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u64::seqcst_acquire:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               x19, x1
        mov               x0, x1
        mov               x1, x2
        mov               x2, x8
0:
        bl                0f
        cmp               x0, x19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u64::seqcst_relaxed:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               x19, x1
        mov               x0, x1
        mov               x1, x2
        mov               x2, x8
0:
        bl                0f
        cmp               x0, x19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u64::acquire_acquire:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               x19, x1
        mov               x0, x1
        mov               x1, x2
        mov               x2, x8
0:
        bl                0f
        cmp               x0, x19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u64::acquire_relaxed:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               x19, x1
        mov               x0, x1
        mov               x1, x2
        mov               x2, x8
0:
        bl                0f
        cmp               x0, x19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u64::relaxed_acquire:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               x19, x1
        mov               x0, x1
        mov               x1, x2
        mov               x2, x8
0:
        bl                0f
        cmp               x0, x19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u64::relaxed_relaxed:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               x19, x1
        mov               x0, x1
        mov               x1, x2
        mov               x2, x8
0:
        bl                0f
        cmp               x0, x19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u64::release_acquire:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               x19, x1
        mov               x0, x1
        mov               x1, x2
        mov               x2, x8
0:
        bl                0f
        cmp               x0, x19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u64::release_relaxed:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               x19, x1
        mov               x0, x1
        mov               x1, x2
        mov               x2, x8
0:
        bl                0f
        cmp               x0, x19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange::u128::acqrel_seqcst:
        stp               x29, x30, [sp, #-0x30]!
        str               x21, [sp, #0x10]
        stp               x20, x19, [sp, #0x20]
        mov               x29, sp
        mov               x9, x0
        mov               x19, x3
        mov               x20, x2
        mov               x0, x2
        mov               x1, x3
        mov               x2, x4
        mov               x3, x5
        mov               x4, x9
        mov               x21, x8
0:
        bl                0f
        cmp               x0, x20
        stp               x0, x1, [x21]
        ccmp              x1, x19, #0x0, eq
        cset              w8, eq
        strb              w8, [x21, #0x10]
        ldp               x20, x19, [sp, #0x20]
        ldr               x21, [sp, #0x10]
        ldp               x29, x30, [sp], #0x30
        ret

asm_test::compare_exchange::u128::seqcst_seqcst:
        stp               x29, x30, [sp, #-0x30]!
        str               x21, [sp, #0x10]
        stp               x20, x19, [sp, #0x20]
        mov               x29, sp
        mov               x9, x0
        mov               x19, x3
        mov               x20, x2
        mov               x0, x2
        mov               x1, x3
        mov               x2, x4
        mov               x3, x5
        mov               x4, x9
        mov               x21, x8
0:
        bl                0f
        cmp               x0, x20
        stp               x0, x1, [x21]
        ccmp              x1, x19, #0x0, eq
        cset              w8, eq
        strb              w8, [x21, #0x10]
        ldp               x20, x19, [sp, #0x20]
        ldr               x21, [sp, #0x10]
        ldp               x29, x30, [sp], #0x30
        ret

asm_test::compare_exchange::u128::acqrel_acquire:
        stp               x29, x30, [sp, #-0x30]!
        str               x21, [sp, #0x10]
        stp               x20, x19, [sp, #0x20]
        mov               x29, sp
        mov               x9, x0
        mov               x19, x3
        mov               x20, x2
        mov               x0, x2
        mov               x1, x3
        mov               x2, x4
        mov               x3, x5
        mov               x4, x9
        mov               x21, x8
0:
        bl                0f
        cmp               x0, x20
        stp               x0, x1, [x21]
        ccmp              x1, x19, #0x0, eq
        cset              w8, eq
        strb              w8, [x21, #0x10]
        ldp               x20, x19, [sp, #0x20]
        ldr               x21, [sp, #0x10]
        ldp               x29, x30, [sp], #0x30
        ret

asm_test::compare_exchange::u128::acqrel_relaxed:
        stp               x29, x30, [sp, #-0x30]!
        str               x21, [sp, #0x10]
        stp               x20, x19, [sp, #0x20]
        mov               x29, sp
        mov               x9, x0
        mov               x19, x3
        mov               x20, x2
        mov               x0, x2
        mov               x1, x3
        mov               x2, x4
        mov               x3, x5
        mov               x4, x9
        mov               x21, x8
0:
        bl                0f
        cmp               x0, x20
        stp               x0, x1, [x21]
        ccmp              x1, x19, #0x0, eq
        cset              w8, eq
        strb              w8, [x21, #0x10]
        ldp               x20, x19, [sp, #0x20]
        ldr               x21, [sp, #0x10]
        ldp               x29, x30, [sp], #0x30
        ret

asm_test::compare_exchange::u128::acquire_seqcst:
        stp               x29, x30, [sp, #-0x30]!
        str               x21, [sp, #0x10]
        stp               x20, x19, [sp, #0x20]
        mov               x29, sp
        mov               x9, x0
        mov               x19, x3
        mov               x20, x2
        mov               x0, x2
        mov               x1, x3
        mov               x2, x4
        mov               x3, x5
        mov               x4, x9
        mov               x21, x8
0:
        bl                0f
        cmp               x0, x20
        stp               x0, x1, [x21]
        ccmp              x1, x19, #0x0, eq
        cset              w8, eq
        strb              w8, [x21, #0x10]
        ldp               x20, x19, [sp, #0x20]
        ldr               x21, [sp, #0x10]
        ldp               x29, x30, [sp], #0x30
        ret

asm_test::compare_exchange::u128::relaxed_seqcst:
        stp               x29, x30, [sp, #-0x30]!
        str               x21, [sp, #0x10]
        stp               x20, x19, [sp, #0x20]
        mov               x29, sp
        mov               x9, x0
        mov               x19, x3
        mov               x20, x2
        mov               x0, x2
        mov               x1, x3
        mov               x2, x4
        mov               x3, x5
        mov               x4, x9
        mov               x21, x8
0:
        bl                0f
        cmp               x0, x20
        stp               x0, x1, [x21]
        ccmp              x1, x19, #0x0, eq
        cset              w8, eq
        strb              w8, [x21, #0x10]
        ldp               x20, x19, [sp, #0x20]
        ldr               x21, [sp, #0x10]
        ldp               x29, x30, [sp], #0x30
        ret

asm_test::compare_exchange::u128::release_seqcst:
        stp               x29, x30, [sp, #-0x30]!
        str               x21, [sp, #0x10]
        stp               x20, x19, [sp, #0x20]
        mov               x29, sp
        mov               x9, x0
        mov               x19, x3
        mov               x20, x2
        mov               x0, x2
        mov               x1, x3
        mov               x2, x4
        mov               x3, x5
        mov               x4, x9
        mov               x21, x8
0:
        bl                0f
        cmp               x0, x20
        stp               x0, x1, [x21]
        ccmp              x1, x19, #0x0, eq
        cset              w8, eq
        strb              w8, [x21, #0x10]
        ldp               x20, x19, [sp, #0x20]
        ldr               x21, [sp, #0x10]
        ldp               x29, x30, [sp], #0x30
        ret

asm_test::compare_exchange::u128::seqcst_acquire:
        stp               x29, x30, [sp, #-0x30]!
        str               x21, [sp, #0x10]
        stp               x20, x19, [sp, #0x20]
        mov               x29, sp
        mov               x9, x0
        mov               x19, x3
        mov               x20, x2
        mov               x0, x2
        mov               x1, x3
        mov               x2, x4
        mov               x3, x5
        mov               x4, x9
        mov               x21, x8
0:
        bl                0f
        cmp               x0, x20
        stp               x0, x1, [x21]
        ccmp              x1, x19, #0x0, eq
        cset              w8, eq
        strb              w8, [x21, #0x10]
        ldp               x20, x19, [sp, #0x20]
        ldr               x21, [sp, #0x10]
        ldp               x29, x30, [sp], #0x30
        ret

asm_test::compare_exchange::u128::seqcst_relaxed:
        stp               x29, x30, [sp, #-0x30]!
        str               x21, [sp, #0x10]
        stp               x20, x19, [sp, #0x20]
        mov               x29, sp
        mov               x9, x0
        mov               x19, x3
        mov               x20, x2
        mov               x0, x2
        mov               x1, x3
        mov               x2, x4
        mov               x3, x5
        mov               x4, x9
        mov               x21, x8
0:
        bl                0f
        cmp               x0, x20
        stp               x0, x1, [x21]
        ccmp              x1, x19, #0x0, eq
        cset              w8, eq
        strb              w8, [x21, #0x10]
        ldp               x20, x19, [sp, #0x20]
        ldr               x21, [sp, #0x10]
        ldp               x29, x30, [sp], #0x30
        ret

asm_test::compare_exchange::u128::acquire_acquire:
        stp               x29, x30, [sp, #-0x30]!
        str               x21, [sp, #0x10]
        stp               x20, x19, [sp, #0x20]
        mov               x29, sp
        mov               x9, x0
        mov               x19, x3
        mov               x20, x2
        mov               x0, x2
        mov               x1, x3
        mov               x2, x4
        mov               x3, x5
        mov               x4, x9
        mov               x21, x8
0:
        bl                0f
        cmp               x0, x20
        stp               x0, x1, [x21]
        ccmp              x1, x19, #0x0, eq
        cset              w8, eq
        strb              w8, [x21, #0x10]
        ldp               x20, x19, [sp, #0x20]
        ldr               x21, [sp, #0x10]
        ldp               x29, x30, [sp], #0x30
        ret

asm_test::compare_exchange::u128::acquire_relaxed:
        stp               x29, x30, [sp, #-0x30]!
        str               x21, [sp, #0x10]
        stp               x20, x19, [sp, #0x20]
        mov               x29, sp
        mov               x9, x0
        mov               x19, x3
        mov               x20, x2
        mov               x0, x2
        mov               x1, x3
        mov               x2, x4
        mov               x3, x5
        mov               x4, x9
        mov               x21, x8
0:
        bl                0f
        cmp               x0, x20
        stp               x0, x1, [x21]
        ccmp              x1, x19, #0x0, eq
        cset              w8, eq
        strb              w8, [x21, #0x10]
        ldp               x20, x19, [sp, #0x20]
        ldr               x21, [sp, #0x10]
        ldp               x29, x30, [sp], #0x30
        ret

asm_test::compare_exchange::u128::relaxed_acquire:
        stp               x29, x30, [sp, #-0x30]!
        str               x21, [sp, #0x10]
        stp               x20, x19, [sp, #0x20]
        mov               x29, sp
        mov               x9, x0
        mov               x19, x3
        mov               x20, x2
        mov               x0, x2
        mov               x1, x3
        mov               x2, x4
        mov               x3, x5
        mov               x4, x9
        mov               x21, x8
0:
        bl                0f
        cmp               x0, x20
        stp               x0, x1, [x21]
        ccmp              x1, x19, #0x0, eq
        cset              w8, eq
        strb              w8, [x21, #0x10]
        ldp               x20, x19, [sp, #0x20]
        ldr               x21, [sp, #0x10]
        ldp               x29, x30, [sp], #0x30
        ret

asm_test::compare_exchange::u128::relaxed_relaxed:
        stp               x29, x30, [sp, #-0x30]!
        str               x21, [sp, #0x10]
        stp               x20, x19, [sp, #0x20]
        mov               x29, sp
        mov               x9, x0
        mov               x19, x3
        mov               x20, x2
        mov               x0, x2
        mov               x1, x3
        mov               x2, x4
        mov               x3, x5
        mov               x4, x9
        mov               x21, x8
0:
        bl                0f
        cmp               x0, x20
        stp               x0, x1, [x21]
        ccmp              x1, x19, #0x0, eq
        cset              w8, eq
        strb              w8, [x21, #0x10]
        ldp               x20, x19, [sp, #0x20]
        ldr               x21, [sp, #0x10]
        ldp               x29, x30, [sp], #0x30
        ret

asm_test::compare_exchange::u128::release_acquire:
        stp               x29, x30, [sp, #-0x30]!
        str               x21, [sp, #0x10]
        stp               x20, x19, [sp, #0x20]
        mov               x29, sp
        mov               x9, x0
        mov               x19, x3
        mov               x20, x2
        mov               x0, x2
        mov               x1, x3
        mov               x2, x4
        mov               x3, x5
        mov               x4, x9
        mov               x21, x8
0:
        bl                0f
        cmp               x0, x20
        stp               x0, x1, [x21]
        ccmp              x1, x19, #0x0, eq
        cset              w8, eq
        strb              w8, [x21, #0x10]
        ldp               x20, x19, [sp, #0x20]
        ldr               x21, [sp, #0x10]
        ldp               x29, x30, [sp], #0x30
        ret

asm_test::compare_exchange::u128::release_relaxed:
        stp               x29, x30, [sp, #-0x30]!
        str               x21, [sp, #0x10]
        stp               x20, x19, [sp, #0x20]
        mov               x29, sp
        mov               x9, x0
        mov               x19, x3
        mov               x20, x2
        mov               x0, x2
        mov               x1, x3
        mov               x2, x4
        mov               x3, x5
        mov               x4, x9
        mov               x21, x8
0:
        bl                0f
        cmp               x0, x20
        stp               x0, x1, [x21]
        ccmp              x1, x19, #0x0, eq
        cset              w8, eq
        strb              w8, [x21, #0x10]
        ldp               x20, x19, [sp, #0x20]
        ldr               x21, [sp, #0x10]
        ldp               x29, x30, [sp], #0x30
        ret

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxtb
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxtb
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxtb
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxtb
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxtb
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxtb
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u8::release_seqcst:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxtb
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxtb
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxtb
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u8::acquire_acquire:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxtb
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxtb
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxtb
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxtb
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u8::release_acquire:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxtb
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u8::release_relaxed:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxtb
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxth
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxth
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxth
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxth
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxth
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxth
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u16::release_seqcst:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxth
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxth
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxth
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u16::acquire_acquire:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxth
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxth
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxth
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxth
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u16::release_acquire:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxth
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u16::release_relaxed:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19, uxth
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u32::release_seqcst:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u32::acquire_acquire:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u32::release_acquire:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u32::release_relaxed:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               w19, w1
        mov               w0, w1
        mov               w1, w2
        mov               x2, x8
0:
        bl                0f
        cmp               w0, w19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u64::acqrel_seqcst:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               x19, x1
        mov               x0, x1
        mov               x1, x2
        mov               x2, x8
0:
        bl                0f
        cmp               x0, x19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u64::seqcst_seqcst:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               x19, x1
        mov               x0, x1
        mov               x1, x2
        mov               x2, x8
0:
        bl                0f
        cmp               x0, x19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u64::acqrel_acquire:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               x19, x1
        mov               x0, x1
        mov               x1, x2
        mov               x2, x8
0:
        bl                0f
        cmp               x0, x19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u64::acqrel_relaxed:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               x19, x1
        mov               x0, x1
        mov               x1, x2
        mov               x2, x8
0:
        bl                0f
        cmp               x0, x19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u64::acquire_seqcst:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               x19, x1
        mov               x0, x1
        mov               x1, x2
        mov               x2, x8
0:
        bl                0f
        cmp               x0, x19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u64::relaxed_seqcst:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               x19, x1
        mov               x0, x1
        mov               x1, x2
        mov               x2, x8
0:
        bl                0f
        cmp               x0, x19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u64::release_seqcst:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               x19, x1
        mov               x0, x1
        mov               x1, x2
        mov               x2, x8
0:
        bl                0f
        cmp               x0, x19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u64::seqcst_acquire:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               x19, x1
        mov               x0, x1
        mov               x1, x2
        mov               x2, x8
0:
        bl                0f
        cmp               x0, x19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u64::seqcst_relaxed:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               x19, x1
        mov               x0, x1
        mov               x1, x2
        mov               x2, x8
0:
        bl                0f
        cmp               x0, x19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u64::acquire_acquire:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               x19, x1
        mov               x0, x1
        mov               x1, x2
        mov               x2, x8
0:
        bl                0f
        cmp               x0, x19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u64::acquire_relaxed:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               x19, x1
        mov               x0, x1
        mov               x1, x2
        mov               x2, x8
0:
        bl                0f
        cmp               x0, x19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u64::relaxed_acquire:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               x19, x1
        mov               x0, x1
        mov               x1, x2
        mov               x2, x8
0:
        bl                0f
        cmp               x0, x19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u64::relaxed_relaxed:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               x19, x1
        mov               x0, x1
        mov               x1, x2
        mov               x2, x8
0:
        bl                0f
        cmp               x0, x19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u64::release_acquire:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               x19, x1
        mov               x0, x1
        mov               x1, x2
        mov               x2, x8
0:
        bl                0f
        cmp               x0, x19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u64::release_relaxed:
        stp               x29, x30, [sp, #-0x20]!
        str               x19, [sp, #0x10]
        mov               x29, sp
        mov               x8, x0
        mov               x19, x1
        mov               x0, x1
        mov               x1, x2
        mov               x2, x8
0:
        bl                0f
        cmp               x0, x19
        cset              w1, eq
        ldr               x19, [sp, #0x10]
        ldp               x29, x30, [sp], #0x20
        ret

asm_test::compare_exchange_weak::u128::acqrel_seqcst:
        stp               x29, x30, [sp, #-0x30]!
        str               x21, [sp, #0x10]
        stp               x20, x19, [sp, #0x20]
        mov               x29, sp
        mov               x9, x0
        mov               x19, x3
        mov               x20, x2
        mov               x0, x2
        mov               x1, x3
        mov               x2, x4
        mov               x3, x5
        mov               x4, x9
        mov               x21, x8
0:
        bl                0f
        cmp               x0, x20
        stp               x0, x1, [x21]
        ccmp              x1, x19, #0x0, eq
        cset              w8, eq
        strb              w8, [x21, #0x10]
        ldp               x20, x19, [sp, #0x20]
        ldr               x21, [sp, #0x10]
        ldp               x29, x30, [sp], #0x30
        ret

asm_test::compare_exchange_weak::u128::seqcst_seqcst:
        stp               x29, x30, [sp, #-0x30]!
        str               x21, [sp, #0x10]
        stp               x20, x19, [sp, #0x20]
        mov               x29, sp
        mov               x9, x0
        mov               x19, x3
        mov               x20, x2
        mov               x0, x2
        mov               x1, x3
        mov               x2, x4
        mov               x3, x5
        mov               x4, x9
        mov               x21, x8
0:
        bl                0f
        cmp               x0, x20
        stp               x0, x1, [x21]
        ccmp              x1, x19, #0x0, eq
        cset              w8, eq
        strb              w8, [x21, #0x10]
        ldp               x20, x19, [sp, #0x20]
        ldr               x21, [sp, #0x10]
        ldp               x29, x30, [sp], #0x30
        ret

asm_test::compare_exchange_weak::u128::acqrel_acquire:
        stp               x29, x30, [sp, #-0x30]!
        str               x21, [sp, #0x10]
        stp               x20, x19, [sp, #0x20]
        mov               x29, sp
        mov               x9, x0
        mov               x19, x3
        mov               x20, x2
        mov               x0, x2
        mov               x1, x3
        mov               x2, x4
        mov               x3, x5
        mov               x4, x9
        mov               x21, x8
0:
        bl                0f
        cmp               x0, x20
        stp               x0, x1, [x21]
        ccmp              x1, x19, #0x0, eq
        cset              w8, eq
        strb              w8, [x21, #0x10]
        ldp               x20, x19, [sp, #0x20]
        ldr               x21, [sp, #0x10]
        ldp               x29, x30, [sp], #0x30
        ret

asm_test::compare_exchange_weak::u128::acqrel_relaxed:
        stp               x29, x30, [sp, #-0x30]!
        str               x21, [sp, #0x10]
        stp               x20, x19, [sp, #0x20]
        mov               x29, sp
        mov               x9, x0
        mov               x19, x3
        mov               x20, x2
        mov               x0, x2
        mov               x1, x3
        mov               x2, x4
        mov               x3, x5
        mov               x4, x9
        mov               x21, x8
0:
        bl                0f
        cmp               x0, x20
        stp               x0, x1, [x21]
        ccmp              x1, x19, #0x0, eq
        cset              w8, eq
        strb              w8, [x21, #0x10]
        ldp               x20, x19, [sp, #0x20]
        ldr               x21, [sp, #0x10]
        ldp               x29, x30, [sp], #0x30
        ret

asm_test::compare_exchange_weak::u128::acquire_seqcst:
        stp               x29, x30, [sp, #-0x30]!
        str               x21, [sp, #0x10]
        stp               x20, x19, [sp, #0x20]
        mov               x29, sp
        mov               x9, x0
        mov               x19, x3
        mov               x20, x2
        mov               x0, x2
        mov               x1, x3
        mov               x2, x4
        mov               x3, x5
        mov               x4, x9
        mov               x21, x8
0:
        bl                0f
        cmp               x0, x20
        stp               x0, x1, [x21]
        ccmp              x1, x19, #0x0, eq
        cset              w8, eq
        strb              w8, [x21, #0x10]
        ldp               x20, x19, [sp, #0x20]
        ldr               x21, [sp, #0x10]
        ldp               x29, x30, [sp], #0x30
        ret

asm_test::compare_exchange_weak::u128::relaxed_seqcst:
        stp               x29, x30, [sp, #-0x30]!
        str               x21, [sp, #0x10]
        stp               x20, x19, [sp, #0x20]
        mov               x29, sp
        mov               x9, x0
        mov               x19, x3
        mov               x20, x2
        mov               x0, x2
        mov               x1, x3
        mov               x2, x4
        mov               x3, x5
        mov               x4, x9
        mov               x21, x8
0:
        bl                0f
        cmp               x0, x20
        stp               x0, x1, [x21]
        ccmp              x1, x19, #0x0, eq
        cset              w8, eq
        strb              w8, [x21, #0x10]
        ldp               x20, x19, [sp, #0x20]
        ldr               x21, [sp, #0x10]
        ldp               x29, x30, [sp], #0x30
        ret

asm_test::compare_exchange_weak::u128::release_seqcst:
        stp               x29, x30, [sp, #-0x30]!
        str               x21, [sp, #0x10]
        stp               x20, x19, [sp, #0x20]
        mov               x29, sp
        mov               x9, x0
        mov               x19, x3
        mov               x20, x2
        mov               x0, x2
        mov               x1, x3
        mov               x2, x4
        mov               x3, x5
        mov               x4, x9
        mov               x21, x8
0:
        bl                0f
        cmp               x0, x20
        stp               x0, x1, [x21]
        ccmp              x1, x19, #0x0, eq
        cset              w8, eq
        strb              w8, [x21, #0x10]
        ldp               x20, x19, [sp, #0x20]
        ldr               x21, [sp, #0x10]
        ldp               x29, x30, [sp], #0x30
        ret

asm_test::compare_exchange_weak::u128::seqcst_acquire:
        stp               x29, x30, [sp, #-0x30]!
        str               x21, [sp, #0x10]
        stp               x20, x19, [sp, #0x20]
        mov               x29, sp
        mov               x9, x0
        mov               x19, x3
        mov               x20, x2
        mov               x0, x2
        mov               x1, x3
        mov               x2, x4
        mov               x3, x5
        mov               x4, x9
        mov               x21, x8
0:
        bl                0f
        cmp               x0, x20
        stp               x0, x1, [x21]
        ccmp              x1, x19, #0x0, eq
        cset              w8, eq
        strb              w8, [x21, #0x10]
        ldp               x20, x19, [sp, #0x20]
        ldr               x21, [sp, #0x10]
        ldp               x29, x30, [sp], #0x30
        ret

asm_test::compare_exchange_weak::u128::seqcst_relaxed:
        stp               x29, x30, [sp, #-0x30]!
        str               x21, [sp, #0x10]
        stp               x20, x19, [sp, #0x20]
        mov               x29, sp
        mov               x9, x0
        mov               x19, x3
        mov               x20, x2
        mov               x0, x2
        mov               x1, x3
        mov               x2, x4
        mov               x3, x5
        mov               x4, x9
        mov               x21, x8
0:
        bl                0f
        cmp               x0, x20
        stp               x0, x1, [x21]
        ccmp              x1, x19, #0x0, eq
        cset              w8, eq
        strb              w8, [x21, #0x10]
        ldp               x20, x19, [sp, #0x20]
        ldr               x21, [sp, #0x10]
        ldp               x29, x30, [sp], #0x30
        ret

asm_test::compare_exchange_weak::u128::acquire_acquire:
        stp               x29, x30, [sp, #-0x30]!
        str               x21, [sp, #0x10]
        stp               x20, x19, [sp, #0x20]
        mov               x29, sp
        mov               x9, x0
        mov               x19, x3
        mov               x20, x2
        mov               x0, x2
        mov               x1, x3
        mov               x2, x4
        mov               x3, x5
        mov               x4, x9
        mov               x21, x8
0:
        bl                0f
        cmp               x0, x20
        stp               x0, x1, [x21]
        ccmp              x1, x19, #0x0, eq
        cset              w8, eq
        strb              w8, [x21, #0x10]
        ldp               x20, x19, [sp, #0x20]
        ldr               x21, [sp, #0x10]
        ldp               x29, x30, [sp], #0x30
        ret

asm_test::compare_exchange_weak::u128::acquire_relaxed:
        stp               x29, x30, [sp, #-0x30]!
        str               x21, [sp, #0x10]
        stp               x20, x19, [sp, #0x20]
        mov               x29, sp
        mov               x9, x0
        mov               x19, x3
        mov               x20, x2
        mov               x0, x2
        mov               x1, x3
        mov               x2, x4
        mov               x3, x5
        mov               x4, x9
        mov               x21, x8
0:
        bl                0f
        cmp               x0, x20
        stp               x0, x1, [x21]
        ccmp              x1, x19, #0x0, eq
        cset              w8, eq
        strb              w8, [x21, #0x10]
        ldp               x20, x19, [sp, #0x20]
        ldr               x21, [sp, #0x10]
        ldp               x29, x30, [sp], #0x30
        ret

asm_test::compare_exchange_weak::u128::relaxed_acquire:
        stp               x29, x30, [sp, #-0x30]!
        str               x21, [sp, #0x10]
        stp               x20, x19, [sp, #0x20]
        mov               x29, sp
        mov               x9, x0
        mov               x19, x3
        mov               x20, x2
        mov               x0, x2
        mov               x1, x3
        mov               x2, x4
        mov               x3, x5
        mov               x4, x9
        mov               x21, x8
0:
        bl                0f
        cmp               x0, x20
        stp               x0, x1, [x21]
        ccmp              x1, x19, #0x0, eq
        cset              w8, eq
        strb              w8, [x21, #0x10]
        ldp               x20, x19, [sp, #0x20]
        ldr               x21, [sp, #0x10]
        ldp               x29, x30, [sp], #0x30
        ret

asm_test::compare_exchange_weak::u128::relaxed_relaxed:
        stp               x29, x30, [sp, #-0x30]!
        str               x21, [sp, #0x10]
        stp               x20, x19, [sp, #0x20]
        mov               x29, sp
        mov               x9, x0
        mov               x19, x3
        mov               x20, x2
        mov               x0, x2
        mov               x1, x3
        mov               x2, x4
        mov               x3, x5
        mov               x4, x9
        mov               x21, x8
0:
        bl                0f
        cmp               x0, x20
        stp               x0, x1, [x21]
        ccmp              x1, x19, #0x0, eq
        cset              w8, eq
        strb              w8, [x21, #0x10]
        ldp               x20, x19, [sp, #0x20]
        ldr               x21, [sp, #0x10]
        ldp               x29, x30, [sp], #0x30
        ret

asm_test::compare_exchange_weak::u128::release_acquire:
        stp               x29, x30, [sp, #-0x30]!
        str               x21, [sp, #0x10]
        stp               x20, x19, [sp, #0x20]
        mov               x29, sp
        mov               x9, x0
        mov               x19, x3
        mov               x20, x2
        mov               x0, x2
        mov               x1, x3
        mov               x2, x4
        mov               x3, x5
        mov               x4, x9
        mov               x21, x8
0:
        bl                0f
        cmp               x0, x20
        stp               x0, x1, [x21]
        ccmp              x1, x19, #0x0, eq
        cset              w8, eq
        strb              w8, [x21, #0x10]
        ldp               x20, x19, [sp, #0x20]
        ldr               x21, [sp, #0x10]
        ldp               x29, x30, [sp], #0x30
        ret

asm_test::compare_exchange_weak::u128::release_relaxed:
        stp               x29, x30, [sp, #-0x30]!
        str               x21, [sp, #0x10]
        stp               x20, x19, [sp, #0x20]
        mov               x29, sp
        mov               x9, x0
        mov               x19, x3
        mov               x20, x2
        mov               x0, x2
        mov               x1, x3
        mov               x2, x4
        mov               x3, x5
        mov               x4, x9
        mov               x21, x8
0:
        bl                0f
        cmp               x0, x20
        stp               x0, x1, [x21]
        ccmp              x1, x19, #0x0, eq
        cset              w8, eq
        strb              w8, [x21, #0x10]
        ldp               x20, x19, [sp, #0x20]
        ldr               x21, [sp, #0x10]
        ldp               x29, x30, [sp], #0x30
        ret

asm_test::load::u8::seqcst:
        ldarb             w0, [x0]
        ret

asm_test::load::u8::acquire:
        ldaprb            w0, [x0]
        ret

asm_test::load::u8::relaxed:
        ldrb              w0, [x0]
        ret

asm_test::load::u16::seqcst:
        ldarh             w0, [x0]
        ret

asm_test::load::u16::acquire:
        ldaprh            w0, [x0]
        ret

asm_test::load::u16::relaxed:
        ldrh              w0, [x0]
        ret

asm_test::load::u32::seqcst:
        ldar              w0, [x0]
        ret

asm_test::load::u32::acquire:
        ldapr             w0, [x0]
        ret

asm_test::load::u32::relaxed:
        ldr               w0, [x0]
        ret

asm_test::load::u64::seqcst:
        ldar              x0, [x0]
        ret

asm_test::load::u64::acquire:
        ldapr             x0, [x0]
        ret

asm_test::load::u64::relaxed:
        ldr               x0, [x0]
        ret

asm_test::load::u128::seqcst:
        mov               x8, x0
0:
        ldaxp             x0, x1, [x8]
        stlxp             w9, x0, x1, [x8]
        cbnz              w9, 0b
        ret

asm_test::load::u128::acquire:
        mov               x8, x0
0:
        ldaxp             x0, x1, [x8]
        stxp              w9, x0, x1, [x8]
        cbnz              w9, 0b
        ret

asm_test::load::u128::relaxed:
        mov               x8, x0
0:
        ldxp              x0, x1, [x8]
        stxp              w9, x0, x1, [x8]
        cbnz              w9, 0b
        ret

asm_test::swap::u8::acqrel:
        stp               x29, x30, [sp, #-0x10]!
        mov               x29, sp
        mov               x8, x0
        mov               w0, w1
        mov               x1, x8
0:
        bl                0f
        ldp               x29, x30, [sp], #0x10
        ret

asm_test::swap::u8::seqcst:
        stp               x29, x30, [sp, #-0x10]!
        mov               x29, sp
        mov               x8, x0
        mov               w0, w1
        mov               x1, x8
0:
        bl                0f
        ldp               x29, x30, [sp], #0x10
        ret

asm_test::swap::u8::acquire:
        stp               x29, x30, [sp, #-0x10]!
        mov               x29, sp
        mov               x8, x0
        mov               w0, w1
        mov               x1, x8
0:
        bl                0f
        ldp               x29, x30, [sp], #0x10
        ret

asm_test::swap::u8::relaxed:
        stp               x29, x30, [sp, #-0x10]!
        mov               x29, sp
        mov               x8, x0
        mov               w0, w1
        mov               x1, x8
0:
        bl                0f
        ldp               x29, x30, [sp], #0x10
        ret

asm_test::swap::u8::release:
        stp               x29, x30, [sp, #-0x10]!
        mov               x29, sp
        mov               x8, x0
        mov               w0, w1
        mov               x1, x8
0:
        bl                0f
        ldp               x29, x30, [sp], #0x10
        ret

asm_test::swap::u16::acqrel:
        stp               x29, x30, [sp, #-0x10]!
        mov               x29, sp
        mov               x8, x0
        mov               w0, w1
        mov               x1, x8
0:
        bl                0f
        ldp               x29, x30, [sp], #0x10
        ret

asm_test::swap::u16::seqcst:
        stp               x29, x30, [sp, #-0x10]!
        mov               x29, sp
        mov               x8, x0
        mov               w0, w1
        mov               x1, x8
0:
        bl                0f
        ldp               x29, x30, [sp], #0x10
        ret

asm_test::swap::u16::acquire:
        stp               x29, x30, [sp, #-0x10]!
        mov               x29, sp
        mov               x8, x0
        mov               w0, w1
        mov               x1, x8
0:
        bl                0f
        ldp               x29, x30, [sp], #0x10
        ret

asm_test::swap::u16::relaxed:
        stp               x29, x30, [sp, #-0x10]!
        mov               x29, sp
        mov               x8, x0
        mov               w0, w1
        mov               x1, x8
0:
        bl                0f
        ldp               x29, x30, [sp], #0x10
        ret

asm_test::swap::u16::release:
        stp               x29, x30, [sp, #-0x10]!
        mov               x29, sp
        mov               x8, x0
        mov               w0, w1
        mov               x1, x8
0:
        bl                0f
        ldp               x29, x30, [sp], #0x10
        ret

asm_test::swap::u32::acqrel:
        stp               x29, x30, [sp, #-0x10]!
        mov               x29, sp
        mov               x8, x0
        mov               w0, w1
        mov               x1, x8
0:
        bl                0f
        ldp               x29, x30, [sp], #0x10
        ret

asm_test::swap::u32::seqcst:
        stp               x29, x30, [sp, #-0x10]!
        mov               x29, sp
        mov               x8, x0
        mov               w0, w1
        mov               x1, x8
0:
        bl                0f
        ldp               x29, x30, [sp], #0x10
        ret

asm_test::swap::u32::acquire:
        stp               x29, x30, [sp, #-0x10]!
        mov               x29, sp
        mov               x8, x0
        mov               w0, w1
        mov               x1, x8
0:
        bl                0f
        ldp               x29, x30, [sp], #0x10
        ret

asm_test::swap::u32::relaxed:
        stp               x29, x30, [sp, #-0x10]!
        mov               x29, sp
        mov               x8, x0
        mov               w0, w1
        mov               x1, x8
0:
        bl                0f
        ldp               x29, x30, [sp], #0x10
        ret

asm_test::swap::u32::release:
        stp               x29, x30, [sp, #-0x10]!
        mov               x29, sp
        mov               x8, x0
        mov               w0, w1
        mov               x1, x8
0:
        bl                0f
        ldp               x29, x30, [sp], #0x10
        ret

asm_test::swap::u64::acqrel:
        stp               x29, x30, [sp, #-0x10]!
        mov               x29, sp
        mov               x8, x0
        mov               x0, x1
        mov               x1, x8
0:
        bl                0f
        ldp               x29, x30, [sp], #0x10
        ret

asm_test::swap::u64::seqcst:
        stp               x29, x30, [sp, #-0x10]!
        mov               x29, sp
        mov               x8, x0
        mov               x0, x1
        mov               x1, x8
0:
        bl                0f
        ldp               x29, x30, [sp], #0x10
        ret

asm_test::swap::u64::acquire:
        stp               x29, x30, [sp, #-0x10]!
        mov               x29, sp
        mov               x8, x0
        mov               x0, x1
        mov               x1, x8
0:
        bl                0f
        ldp               x29, x30, [sp], #0x10
        ret

asm_test::swap::u64::relaxed:
        stp               x29, x30, [sp, #-0x10]!
        mov               x29, sp
        mov               x8, x0
        mov               x0, x1
        mov               x1, x8
0:
        bl                0f
        ldp               x29, x30, [sp], #0x10
        ret

asm_test::swap::u64::release:
        stp               x29, x30, [sp, #-0x10]!
        mov               x29, sp
        mov               x8, x0
        mov               x0, x1
        mov               x1, x8
0:
        bl                0f
        ldp               x29, x30, [sp], #0x10
        ret

asm_test::swap::u128::acqrel:
0:
        ldaxp             x8, x1, [x0]
        stlxp             w9, x2, x3, [x0]
        cbnz              w9, 0b
        mov               x0, x8
        ret

asm_test::swap::u128::seqcst:
0:
        ldaxp             x8, x1, [x0]
        stlxp             w9, x2, x3, [x0]
        cbnz              w9, 0b
        mov               x0, x8
        ret

asm_test::swap::u128::acquire:
0:
        ldaxp             x8, x1, [x0]
        stxp              w9, x2, x3, [x0]
        cbnz              w9, 0b
        mov               x0, x8
        ret

asm_test::swap::u128::relaxed:
0:
        ldxp              x8, x1, [x0]
        stxp              w9, x2, x3, [x0]
        cbnz              w9, 0b
        mov               x0, x8
        ret

asm_test::swap::u128::release:
0:
        ldxp              x8, x1, [x0]
        stlxp             w9, x2, x3, [x0]
        cbnz              w9, 0b
        mov               x0, x8
        ret

asm_test::store::u8::seqcst:
        stlrb             w1, [x0]
        ret

asm_test::store::u8::relaxed:
        strb              w1, [x0]
        ret

asm_test::store::u8::release:
        stlrb             w1, [x0]
        ret

asm_test::store::u16::seqcst:
        stlrh             w1, [x0]
        ret

asm_test::store::u16::relaxed:
        strh              w1, [x0]
        ret

asm_test::store::u16::release:
        stlrh             w1, [x0]
        ret

asm_test::store::u32::seqcst:
        stlr              w1, [x0]
        ret

asm_test::store::u32::relaxed:
        str               w1, [x0]
        ret

asm_test::store::u32::release:
        stlr              w1, [x0]
        ret

asm_test::store::u64::seqcst:
        stlr              x1, [x0]
        ret

asm_test::store::u64::relaxed:
        str               x1, [x0]
        ret

asm_test::store::u64::release:
        stlr              x1, [x0]
        ret

asm_test::store::u128::seqcst:
0:
        ldaxp             xzr, x8, [x0]
        stlxp             w8, x2, x3, [x0]
        cbnz              w8, 0b
        ret

asm_test::store::u128::relaxed:
0:
        ldxp              xzr, x8, [x0]
        stxp              w8, x2, x3, [x0]
        cbnz              w8, 0b
        ret

asm_test::store::u128::release:
0:
        ldxp              xzr, x8, [x0]
        stlxp             w8, x2, x3, [x0]
        cbnz              w8, 0b
        ret

