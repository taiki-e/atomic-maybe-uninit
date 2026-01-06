asm_test::compare_exchange::u8::acqrel_seqcst:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        and               r1, r4, #255
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange::u8::seqcst_seqcst:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        and               r1, r4, #255
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange::u8::acqrel_acquire:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        and               r1, r4, #255
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange::u8::acqrel_relaxed:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        and               r1, r4, #255
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange::u8::acquire_seqcst:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        and               r1, r4, #255
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange::u8::relaxed_seqcst:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        and               r1, r4, #255
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange::u8::release_seqcst:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        and               r1, r4, #255
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange::u8::seqcst_acquire:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        and               r1, r4, #255
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange::u8::seqcst_relaxed:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        and               r1, r4, #255
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange::u8::acquire_acquire:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        and               r1, r4, #255
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange::u8::acquire_relaxed:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        and               r1, r4, #255
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange::u8::relaxed_acquire:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        and               r1, r4, #255
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange::u8::relaxed_relaxed:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        and               r1, r4, #255
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange::u8::release_acquire:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        and               r1, r4, #255
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange::u8::release_relaxed:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        and               r1, r4, #255
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange::u16::acqrel_seqcst:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        mov               r1, #255
        orr               r1, r1, #65280
        and               r1, r4, r1
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange::u16::seqcst_seqcst:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        mov               r1, #255
        orr               r1, r1, #65280
        and               r1, r4, r1
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange::u16::acqrel_acquire:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        mov               r1, #255
        orr               r1, r1, #65280
        and               r1, r4, r1
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange::u16::acqrel_relaxed:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        mov               r1, #255
        orr               r1, r1, #65280
        and               r1, r4, r1
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange::u16::acquire_seqcst:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        mov               r1, #255
        orr               r1, r1, #65280
        and               r1, r4, r1
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange::u16::relaxed_seqcst:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        mov               r1, #255
        orr               r1, r1, #65280
        and               r1, r4, r1
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange::u16::release_seqcst:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        mov               r1, #255
        orr               r1, r1, #65280
        and               r1, r4, r1
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange::u16::seqcst_acquire:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        mov               r1, #255
        orr               r1, r1, #65280
        and               r1, r4, r1
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange::u16::seqcst_relaxed:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        mov               r1, #255
        orr               r1, r1, #65280
        and               r1, r4, r1
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange::u16::acquire_acquire:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        mov               r1, #255
        orr               r1, r1, #65280
        and               r1, r4, r1
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange::u16::acquire_relaxed:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        mov               r1, #255
        orr               r1, r1, #65280
        and               r1, r4, r1
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange::u16::relaxed_acquire:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        mov               r1, #255
        orr               r1, r1, #65280
        and               r1, r4, r1
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange::u16::relaxed_relaxed:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        mov               r1, #255
        orr               r1, r1, #65280
        and               r1, r4, r1
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange::u16::release_acquire:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        mov               r1, #255
        orr               r1, r1, #65280
        and               r1, r4, r1
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange::u16::release_relaxed:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        mov               r1, #255
        orr               r1, r1, #65280
        and               r1, r4, r1
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange::u32::acqrel_seqcst:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        sub               r1, r0, r4
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange::u32::seqcst_seqcst:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        sub               r1, r0, r4
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange::u32::acqrel_acquire:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        sub               r1, r0, r4
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange::u32::acqrel_relaxed:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        sub               r1, r0, r4
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange::u32::acquire_seqcst:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        sub               r1, r0, r4
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange::u32::relaxed_seqcst:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        sub               r1, r0, r4
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange::u32::release_seqcst:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        sub               r1, r0, r4
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange::u32::seqcst_acquire:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        sub               r1, r0, r4
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange::u32::seqcst_relaxed:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        sub               r1, r0, r4
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange::u32::acquire_acquire:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        sub               r1, r0, r4
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange::u32::acquire_relaxed:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        sub               r1, r0, r4
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange::u32::relaxed_acquire:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        sub               r1, r0, r4
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange::u32::relaxed_relaxed:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        sub               r1, r0, r4
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange::u32::release_acquire:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        sub               r1, r0, r4
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange::u32::release_relaxed:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        sub               r1, r0, r4
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        and               r1, r4, #255
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        and               r1, r4, #255
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        and               r1, r4, #255
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        and               r1, r4, #255
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        and               r1, r4, #255
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        and               r1, r4, #255
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u8::release_seqcst:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        and               r1, r4, #255
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        and               r1, r4, #255
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        and               r1, r4, #255
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u8::acquire_acquire:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        and               r1, r4, #255
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        and               r1, r4, #255
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        and               r1, r4, #255
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        and               r1, r4, #255
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u8::release_acquire:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        and               r1, r4, #255
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u8::release_relaxed:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        and               r1, r4, #255
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        mov               r1, #255
        orr               r1, r1, #65280
        and               r1, r4, r1
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        mov               r1, #255
        orr               r1, r1, #65280
        and               r1, r4, r1
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        mov               r1, #255
        orr               r1, r1, #65280
        and               r1, r4, r1
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        mov               r1, #255
        orr               r1, r1, #65280
        and               r1, r4, r1
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        mov               r1, #255
        orr               r1, r1, #65280
        and               r1, r4, r1
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        mov               r1, #255
        orr               r1, r1, #65280
        and               r1, r4, r1
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u16::release_seqcst:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        mov               r1, #255
        orr               r1, r1, #65280
        and               r1, r4, r1
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        mov               r1, #255
        orr               r1, r1, #65280
        and               r1, r4, r1
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        mov               r1, #255
        orr               r1, r1, #65280
        and               r1, r4, r1
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u16::acquire_acquire:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        mov               r1, #255
        orr               r1, r1, #65280
        and               r1, r4, r1
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        mov               r1, #255
        orr               r1, r1, #65280
        and               r1, r4, r1
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        mov               r1, #255
        orr               r1, r1, #65280
        and               r1, r4, r1
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        mov               r1, #255
        orr               r1, r1, #65280
        and               r1, r4, r1
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u16::release_acquire:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        mov               r1, #255
        orr               r1, r1, #65280
        and               r1, r4, r1
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u16::release_relaxed:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        mov               r1, #255
        orr               r1, r1, #65280
        and               r1, r4, r1
        sub               r1, r0, r1
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        sub               r1, r0, r4
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        sub               r1, r0, r4
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        sub               r1, r0, r4
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        sub               r1, r0, r4
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        sub               r1, r0, r4
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        sub               r1, r0, r4
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u32::release_seqcst:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        sub               r1, r0, r4
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        sub               r1, r0, r4
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        sub               r1, r0, r4
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u32::acquire_acquire:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        sub               r1, r0, r4
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        sub               r1, r0, r4
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        sub               r1, r0, r4
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        sub               r1, r0, r4
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u32::release_acquire:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        sub               r1, r0, r4
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::compare_exchange_weak::u32::release_relaxed:
        push              {r4, lr}
        mov               r4, r1
0:
        bl                0f
        sub               r1, r0, r4
        rsbs              r2, r1, #0
        adc               r1, r1, r2
        pop               {r4, lr}
        bx                lr

asm_test::load::u8::seqcst:
        push              {r11, lr}
        mov               r1, #0
        mov               r2, #0
0:
        bl                0f
        pop               {r11, lr}
        bx                lr

asm_test::load::u8::acquire:
        push              {r11, lr}
        mov               r1, #0
        mov               r2, #0
0:
        bl                0f
        pop               {r11, lr}
        bx                lr

asm_test::load::u8::relaxed:
        ldrb              r0, [r0]
        bx                lr

asm_test::load::u16::seqcst:
        push              {r11, lr}
        mov               r1, #0
        mov               r2, #0
0:
        bl                0f
        pop               {r11, lr}
        bx                lr

asm_test::load::u16::acquire:
        push              {r11, lr}
        mov               r1, #0
        mov               r2, #0
0:
        bl                0f
        pop               {r11, lr}
        bx                lr

asm_test::load::u16::relaxed:
        ldrh              r0, [r0]
        bx                lr

asm_test::load::u32::seqcst:
        push              {r11, lr}
        mov               r1, #0
        mov               r2, #0
0:
        bl                0f
        pop               {r11, lr}
        bx                lr

asm_test::load::u32::acquire:
        push              {r11, lr}
        mov               r1, #0
        mov               r2, #0
0:
        bl                0f
        pop               {r11, lr}
        bx                lr

asm_test::load::u32::relaxed:
        ldr               r0, [r0]
        bx                lr

asm_test::swap::u8::acqrel:
        push              {r11, lr}
0:
        bl                0f
        pop               {r11, lr}
        bx                lr

asm_test::swap::u8::seqcst:
        push              {r11, lr}
0:
        bl                0f
        pop               {r11, lr}
        bx                lr

asm_test::swap::u8::acquire:
        push              {r11, lr}
0:
        bl                0f
        pop               {r11, lr}
        bx                lr

asm_test::swap::u8::relaxed:
        push              {r11, lr}
0:
        bl                0f
        pop               {r11, lr}
        bx                lr

asm_test::swap::u8::release:
        push              {r11, lr}
0:
        bl                0f
        pop               {r11, lr}
        bx                lr

asm_test::swap::u16::acqrel:
        push              {r11, lr}
0:
        bl                0f
        pop               {r11, lr}
        bx                lr

asm_test::swap::u16::seqcst:
        push              {r11, lr}
0:
        bl                0f
        pop               {r11, lr}
        bx                lr

asm_test::swap::u16::acquire:
        push              {r11, lr}
0:
        bl                0f
        pop               {r11, lr}
        bx                lr

asm_test::swap::u16::relaxed:
        push              {r11, lr}
0:
        bl                0f
        pop               {r11, lr}
        bx                lr

asm_test::swap::u16::release:
        push              {r11, lr}
0:
        bl                0f
        pop               {r11, lr}
        bx                lr

asm_test::swap::u32::acqrel:
        push              {r11, lr}
0:
        bl                0f
        pop               {r11, lr}
        bx                lr

asm_test::swap::u32::seqcst:
        push              {r11, lr}
0:
        bl                0f
        pop               {r11, lr}
        bx                lr

asm_test::swap::u32::acquire:
        push              {r11, lr}
0:
        bl                0f
        pop               {r11, lr}
        bx                lr

asm_test::swap::u32::relaxed:
        push              {r11, lr}
0:
        bl                0f
        pop               {r11, lr}
        bx                lr

asm_test::swap::u32::release:
        push              {r11, lr}
0:
        bl                0f
        pop               {r11, lr}
        bx                lr

asm_test::store::u8::seqcst:
        push              {r11, lr}
0:
        bl                0f
        pop               {r11, lr}
        bx                lr

asm_test::store::u8::relaxed:
        strb              r1, [r0]
        bx                lr

asm_test::store::u8::release:
        push              {r11, lr}
0:
        bl                0f
        pop               {r11, lr}
        bx                lr

asm_test::store::u16::seqcst:
        push              {r11, lr}
0:
        bl                0f
        pop               {r11, lr}
        bx                lr

asm_test::store::u16::relaxed:
        strh              r1, [r0]
        bx                lr

asm_test::store::u16::release:
        push              {r11, lr}
0:
        bl                0f
        pop               {r11, lr}
        bx                lr

asm_test::store::u32::seqcst:
        push              {r11, lr}
0:
        bl                0f
        pop               {r11, lr}
        bx                lr

asm_test::store::u32::relaxed:
        str               r1, [r0]
        bx                lr

asm_test::store::u32::release:
        push              {r11, lr}
0:
        bl                0f
        pop               {r11, lr}
        bx                lr

