asm_test::compare_exchange::u8::acqrel_seqcst:
        mv                a3, a1
        fence             rw, rw
        slli              a1, a1, 0x38
        amocas.b.aqrl     a3, a2, (a0)
        srai              a1, a1, 0x38
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u8::seqcst_seqcst:
        mv                a3, a1
        fence             rw, rw
        slli              a1, a1, 0x38
        amocas.b.aqrl     a3, a2, (a0)
        srai              a1, a1, 0x38
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u8::acqrel_acquire:
        mv                a3, a1
        slli              a1, a1, 0x38
        amocas.b.aqrl     a3, a2, (a0)
        srai              a1, a1, 0x38
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u8::acqrel_relaxed:
        mv                a3, a1
        slli              a1, a1, 0x38
        amocas.b.aqrl     a3, a2, (a0)
        srai              a1, a1, 0x38
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u8::acquire_seqcst:
        mv                a3, a1
        fence             rw, rw
        slli              a1, a1, 0x38
        amocas.b.aqrl     a3, a2, (a0)
        srai              a1, a1, 0x38
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u8::relaxed_seqcst:
        mv                a3, a1
        fence             rw, rw
        slli              a1, a1, 0x38
        amocas.b.aqrl     a3, a2, (a0)
        srai              a1, a1, 0x38
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u8::release_seqcst:
        mv                a3, a1
        fence             rw, rw
        slli              a1, a1, 0x38
        amocas.b.aqrl     a3, a2, (a0)
        srai              a1, a1, 0x38
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u8::seqcst_acquire:
        mv                a3, a1
        slli              a1, a1, 0x38
        amocas.b.aqrl     a3, a2, (a0)
        srai              a1, a1, 0x38
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u8::seqcst_relaxed:
        mv                a3, a1
        slli              a1, a1, 0x38
        amocas.b.aqrl     a3, a2, (a0)
        srai              a1, a1, 0x38
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u8::acquire_acquire:
        mv                a3, a1
        slli              a1, a1, 0x38
        amocas.b.aq       a3, a2, (a0)
        srai              a1, a1, 0x38
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u8::acquire_relaxed:
        mv                a3, a1
        slli              a1, a1, 0x38
        amocas.b.aq       a3, a2, (a0)
        srai              a1, a1, 0x38
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u8::relaxed_acquire:
        mv                a3, a1
        slli              a1, a1, 0x38
        amocas.b.aq       a3, a2, (a0)
        srai              a1, a1, 0x38
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u8::relaxed_relaxed:
        mv                a3, a1
        slli              a1, a1, 0x38
        amocas.b          a3, a2, (a0)
        srai              a1, a1, 0x38
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u8::release_acquire:
        mv                a3, a1
        slli              a1, a1, 0x38
        amocas.b.aqrl     a3, a2, (a0)
        srai              a1, a1, 0x38
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u8::release_relaxed:
        mv                a3, a1
        slli              a1, a1, 0x38
        amocas.b.rl       a3, a2, (a0)
        srai              a1, a1, 0x38
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u16::acqrel_seqcst:
        mv                a3, a1
        fence             rw, rw
        slli              a1, a1, 0x30
        amocas.h.aqrl     a3, a2, (a0)
        srai              a1, a1, 0x30
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u16::seqcst_seqcst:
        mv                a3, a1
        fence             rw, rw
        slli              a1, a1, 0x30
        amocas.h.aqrl     a3, a2, (a0)
        srai              a1, a1, 0x30
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u16::acqrel_acquire:
        mv                a3, a1
        slli              a1, a1, 0x30
        amocas.h.aqrl     a3, a2, (a0)
        srai              a1, a1, 0x30
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u16::acqrel_relaxed:
        mv                a3, a1
        slli              a1, a1, 0x30
        amocas.h.aqrl     a3, a2, (a0)
        srai              a1, a1, 0x30
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u16::acquire_seqcst:
        mv                a3, a1
        fence             rw, rw
        slli              a1, a1, 0x30
        amocas.h.aqrl     a3, a2, (a0)
        srai              a1, a1, 0x30
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u16::relaxed_seqcst:
        mv                a3, a1
        fence             rw, rw
        slli              a1, a1, 0x30
        amocas.h.aqrl     a3, a2, (a0)
        srai              a1, a1, 0x30
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u16::release_seqcst:
        mv                a3, a1
        fence             rw, rw
        slli              a1, a1, 0x30
        amocas.h.aqrl     a3, a2, (a0)
        srai              a1, a1, 0x30
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u16::seqcst_acquire:
        mv                a3, a1
        slli              a1, a1, 0x30
        amocas.h.aqrl     a3, a2, (a0)
        srai              a1, a1, 0x30
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u16::seqcst_relaxed:
        mv                a3, a1
        slli              a1, a1, 0x30
        amocas.h.aqrl     a3, a2, (a0)
        srai              a1, a1, 0x30
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u16::acquire_acquire:
        mv                a3, a1
        slli              a1, a1, 0x30
        amocas.h.aq       a3, a2, (a0)
        srai              a1, a1, 0x30
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u16::acquire_relaxed:
        mv                a3, a1
        slli              a1, a1, 0x30
        amocas.h.aq       a3, a2, (a0)
        srai              a1, a1, 0x30
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u16::relaxed_acquire:
        mv                a3, a1
        slli              a1, a1, 0x30
        amocas.h.aq       a3, a2, (a0)
        srai              a1, a1, 0x30
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u16::relaxed_relaxed:
        mv                a3, a1
        slli              a1, a1, 0x30
        amocas.h          a3, a2, (a0)
        srai              a1, a1, 0x30
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u16::release_acquire:
        mv                a3, a1
        slli              a1, a1, 0x30
        amocas.h.aqrl     a3, a2, (a0)
        srai              a1, a1, 0x30
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u16::release_relaxed:
        mv                a3, a1
        slli              a1, a1, 0x30
        amocas.h.rl       a3, a2, (a0)
        srai              a1, a1, 0x30
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::acqrel_seqcst:
        fence             rw, rw
        mv                a3, a1
        amocas.w.aqrl     a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::seqcst_seqcst:
        fence             rw, rw
        mv                a3, a1
        amocas.w.aqrl     a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::acqrel_acquire:
        mv                a3, a1
        amocas.w.aqrl     a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::acqrel_relaxed:
        mv                a3, a1
        amocas.w.aqrl     a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::acquire_seqcst:
        fence             rw, rw
        mv                a3, a1
        amocas.w.aqrl     a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::relaxed_seqcst:
        fence             rw, rw
        mv                a3, a1
        amocas.w.aqrl     a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::release_seqcst:
        fence             rw, rw
        mv                a3, a1
        amocas.w.aqrl     a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::seqcst_acquire:
        mv                a3, a1
        amocas.w.aqrl     a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::seqcst_relaxed:
        mv                a3, a1
        amocas.w.aqrl     a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::acquire_acquire:
        mv                a3, a1
        amocas.w.aq       a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::acquire_relaxed:
        mv                a3, a1
        amocas.w.aq       a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::relaxed_acquire:
        mv                a3, a1
        amocas.w.aq       a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::relaxed_relaxed:
        mv                a3, a1
        amocas.w          a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::release_acquire:
        mv                a3, a1
        amocas.w.aqrl     a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::release_relaxed:
        mv                a3, a1
        amocas.w.rl       a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u64::acqrel_seqcst:
        fence             rw, rw
        mv                a3, a1
        amocas.d.aqrl     a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u64::seqcst_seqcst:
        fence             rw, rw
        mv                a3, a1
        amocas.d.aqrl     a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u64::acqrel_acquire:
        mv                a3, a1
        amocas.d.aqrl     a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u64::acqrel_relaxed:
        mv                a3, a1
        amocas.d.aqrl     a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u64::acquire_seqcst:
        fence             rw, rw
        mv                a3, a1
        amocas.d.aqrl     a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u64::relaxed_seqcst:
        fence             rw, rw
        mv                a3, a1
        amocas.d.aqrl     a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u64::release_seqcst:
        fence             rw, rw
        mv                a3, a1
        amocas.d.aqrl     a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u64::seqcst_acquire:
        mv                a3, a1
        amocas.d.aqrl     a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u64::seqcst_relaxed:
        mv                a3, a1
        amocas.d.aqrl     a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u64::acquire_acquire:
        mv                a3, a1
        amocas.d.aq       a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u64::acquire_relaxed:
        mv                a3, a1
        amocas.d.aq       a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u64::relaxed_acquire:
        mv                a3, a1
        amocas.d.aq       a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u64::relaxed_relaxed:
        mv                a3, a1
        amocas.d          a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u64::release_acquire:
        mv                a3, a1
        amocas.d.aqrl     a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u64::release_relaxed:
        mv                a3, a1
        amocas.d.rl       a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        mv                a3, a1
        fence             rw, rw
        slli              a1, a1, 0x38
        amocas.b.aqrl     a3, a2, (a0)
        srai              a1, a1, 0x38
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        mv                a3, a1
        fence             rw, rw
        slli              a1, a1, 0x38
        amocas.b.aqrl     a3, a2, (a0)
        srai              a1, a1, 0x38
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        mv                a3, a1
        slli              a1, a1, 0x38
        amocas.b.aqrl     a3, a2, (a0)
        srai              a1, a1, 0x38
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        mv                a3, a1
        slli              a1, a1, 0x38
        amocas.b.aqrl     a3, a2, (a0)
        srai              a1, a1, 0x38
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        mv                a3, a1
        fence             rw, rw
        slli              a1, a1, 0x38
        amocas.b.aqrl     a3, a2, (a0)
        srai              a1, a1, 0x38
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        mv                a3, a1
        fence             rw, rw
        slli              a1, a1, 0x38
        amocas.b.aqrl     a3, a2, (a0)
        srai              a1, a1, 0x38
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u8::release_seqcst:
        mv                a3, a1
        fence             rw, rw
        slli              a1, a1, 0x38
        amocas.b.aqrl     a3, a2, (a0)
        srai              a1, a1, 0x38
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        mv                a3, a1
        slli              a1, a1, 0x38
        amocas.b.aqrl     a3, a2, (a0)
        srai              a1, a1, 0x38
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        mv                a3, a1
        slli              a1, a1, 0x38
        amocas.b.aqrl     a3, a2, (a0)
        srai              a1, a1, 0x38
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u8::acquire_acquire:
        mv                a3, a1
        slli              a1, a1, 0x38
        amocas.b.aq       a3, a2, (a0)
        srai              a1, a1, 0x38
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        mv                a3, a1
        slli              a1, a1, 0x38
        amocas.b.aq       a3, a2, (a0)
        srai              a1, a1, 0x38
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        mv                a3, a1
        slli              a1, a1, 0x38
        amocas.b.aq       a3, a2, (a0)
        srai              a1, a1, 0x38
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        mv                a3, a1
        slli              a1, a1, 0x38
        amocas.b          a3, a2, (a0)
        srai              a1, a1, 0x38
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u8::release_acquire:
        mv                a3, a1
        slli              a1, a1, 0x38
        amocas.b.aqrl     a3, a2, (a0)
        srai              a1, a1, 0x38
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u8::release_relaxed:
        mv                a3, a1
        slli              a1, a1, 0x38
        amocas.b.rl       a3, a2, (a0)
        srai              a1, a1, 0x38
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        mv                a3, a1
        fence             rw, rw
        slli              a1, a1, 0x30
        amocas.h.aqrl     a3, a2, (a0)
        srai              a1, a1, 0x30
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        mv                a3, a1
        fence             rw, rw
        slli              a1, a1, 0x30
        amocas.h.aqrl     a3, a2, (a0)
        srai              a1, a1, 0x30
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        mv                a3, a1
        slli              a1, a1, 0x30
        amocas.h.aqrl     a3, a2, (a0)
        srai              a1, a1, 0x30
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        mv                a3, a1
        slli              a1, a1, 0x30
        amocas.h.aqrl     a3, a2, (a0)
        srai              a1, a1, 0x30
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        mv                a3, a1
        fence             rw, rw
        slli              a1, a1, 0x30
        amocas.h.aqrl     a3, a2, (a0)
        srai              a1, a1, 0x30
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        mv                a3, a1
        fence             rw, rw
        slli              a1, a1, 0x30
        amocas.h.aqrl     a3, a2, (a0)
        srai              a1, a1, 0x30
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u16::release_seqcst:
        mv                a3, a1
        fence             rw, rw
        slli              a1, a1, 0x30
        amocas.h.aqrl     a3, a2, (a0)
        srai              a1, a1, 0x30
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        mv                a3, a1
        slli              a1, a1, 0x30
        amocas.h.aqrl     a3, a2, (a0)
        srai              a1, a1, 0x30
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        mv                a3, a1
        slli              a1, a1, 0x30
        amocas.h.aqrl     a3, a2, (a0)
        srai              a1, a1, 0x30
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u16::acquire_acquire:
        mv                a3, a1
        slli              a1, a1, 0x30
        amocas.h.aq       a3, a2, (a0)
        srai              a1, a1, 0x30
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        mv                a3, a1
        slli              a1, a1, 0x30
        amocas.h.aq       a3, a2, (a0)
        srai              a1, a1, 0x30
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        mv                a3, a1
        slli              a1, a1, 0x30
        amocas.h.aq       a3, a2, (a0)
        srai              a1, a1, 0x30
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        mv                a3, a1
        slli              a1, a1, 0x30
        amocas.h          a3, a2, (a0)
        srai              a1, a1, 0x30
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u16::release_acquire:
        mv                a3, a1
        slli              a1, a1, 0x30
        amocas.h.aqrl     a3, a2, (a0)
        srai              a1, a1, 0x30
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u16::release_relaxed:
        mv                a3, a1
        slli              a1, a1, 0x30
        amocas.h.rl       a3, a2, (a0)
        srai              a1, a1, 0x30
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        fence             rw, rw
        mv                a3, a1
        amocas.w.aqrl     a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        fence             rw, rw
        mv                a3, a1
        amocas.w.aqrl     a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        mv                a3, a1
        amocas.w.aqrl     a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        mv                a3, a1
        amocas.w.aqrl     a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        fence             rw, rw
        mv                a3, a1
        amocas.w.aqrl     a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        fence             rw, rw
        mv                a3, a1
        amocas.w.aqrl     a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::release_seqcst:
        fence             rw, rw
        mv                a3, a1
        amocas.w.aqrl     a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        mv                a3, a1
        amocas.w.aqrl     a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        mv                a3, a1
        amocas.w.aqrl     a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::acquire_acquire:
        mv                a3, a1
        amocas.w.aq       a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        mv                a3, a1
        amocas.w.aq       a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        mv                a3, a1
        amocas.w.aq       a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        mv                a3, a1
        amocas.w          a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::release_acquire:
        mv                a3, a1
        amocas.w.aqrl     a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::release_relaxed:
        mv                a3, a1
        amocas.w.rl       a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u64::acqrel_seqcst:
        fence             rw, rw
        mv                a3, a1
        amocas.d.aqrl     a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u64::seqcst_seqcst:
        fence             rw, rw
        mv                a3, a1
        amocas.d.aqrl     a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u64::acqrel_acquire:
        mv                a3, a1
        amocas.d.aqrl     a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u64::acqrel_relaxed:
        mv                a3, a1
        amocas.d.aqrl     a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u64::acquire_seqcst:
        fence             rw, rw
        mv                a3, a1
        amocas.d.aqrl     a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u64::relaxed_seqcst:
        fence             rw, rw
        mv                a3, a1
        amocas.d.aqrl     a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u64::release_seqcst:
        fence             rw, rw
        mv                a3, a1
        amocas.d.aqrl     a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u64::seqcst_acquire:
        mv                a3, a1
        amocas.d.aqrl     a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u64::seqcst_relaxed:
        mv                a3, a1
        amocas.d.aqrl     a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u64::acquire_acquire:
        mv                a3, a1
        amocas.d.aq       a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u64::acquire_relaxed:
        mv                a3, a1
        amocas.d.aq       a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u64::relaxed_acquire:
        mv                a3, a1
        amocas.d.aq       a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u64::relaxed_relaxed:
        mv                a3, a1
        amocas.d          a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u64::release_acquire:
        mv                a3, a1
        amocas.d.aqrl     a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u64::release_relaxed:
        mv                a3, a1
        amocas.d.rl       a3, a2, (a0)
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::load::u8::seqcst:
        fence             rw, rw
        lb                a0, 0x0(a0)
        fence             r, rw
        ret

asm_test::load::u8::acquire:
        lb                a0, 0x0(a0)
        fence             r, rw
        ret

asm_test::load::u8::relaxed:
        lb                a0, 0x0(a0)
        ret

asm_test::load::u16::seqcst:
        fence             rw, rw
        lh                a0, 0x0(a0)
        fence             r, rw
        ret

asm_test::load::u16::acquire:
        lh                a0, 0x0(a0)
        fence             r, rw
        ret

asm_test::load::u16::relaxed:
        lh                a0, 0x0(a0)
        ret

asm_test::load::u32::seqcst:
        fence             rw, rw
        lw                a0, 0x0(a0)
        fence             r, rw
        ret

asm_test::load::u32::acquire:
        lw                a0, 0x0(a0)
        fence             r, rw
        ret

asm_test::load::u32::relaxed:
        lw                a0, 0x0(a0)
        ret

asm_test::load::u64::seqcst:
        fence             rw, rw
        ld                a0, 0x0(a0)
        fence             r, rw
        ret

asm_test::load::u64::acquire:
        ld                a0, 0x0(a0)
        fence             r, rw
        ret

asm_test::load::u64::relaxed:
        ld                a0, 0x0(a0)
        ret

asm_test::swap::u8::acqrel:
        amoswap.b.aqrl    a0, a1, (a0)
        ret

asm_test::swap::u8::seqcst:
        amoswap.b.aqrl    a0, a1, (a0)
        ret

asm_test::swap::u8::acquire:
        amoswap.b.aq      a0, a1, (a0)
        ret

asm_test::swap::u8::relaxed:
        amoswap.b         a0, a1, (a0)
        ret

asm_test::swap::u8::release:
        amoswap.b.rl      a0, a1, (a0)
        ret

asm_test::swap::u16::acqrel:
        amoswap.h.aqrl    a0, a1, (a0)
        ret

asm_test::swap::u16::seqcst:
        amoswap.h.aqrl    a0, a1, (a0)
        ret

asm_test::swap::u16::acquire:
        amoswap.h.aq      a0, a1, (a0)
        ret

asm_test::swap::u16::relaxed:
        amoswap.h         a0, a1, (a0)
        ret

asm_test::swap::u16::release:
        amoswap.h.rl      a0, a1, (a0)
        ret

asm_test::swap::u32::acqrel:
        amoswap.w.aqrl    a0, a1, (a0)
        ret

asm_test::swap::u32::seqcst:
        amoswap.w.aqrl    a0, a1, (a0)
        ret

asm_test::swap::u32::acquire:
        amoswap.w.aq      a0, a1, (a0)
        ret

asm_test::swap::u32::relaxed:
        amoswap.w         a0, a1, (a0)
        ret

asm_test::swap::u32::release:
        amoswap.w.rl      a0, a1, (a0)
        ret

asm_test::swap::u64::acqrel:
        amoswap.d.aqrl    a0, a1, (a0)
        ret

asm_test::swap::u64::seqcst:
        amoswap.d.aqrl    a0, a1, (a0)
        ret

asm_test::swap::u64::acquire:
        amoswap.d.aq      a0, a1, (a0)
        ret

asm_test::swap::u64::relaxed:
        amoswap.d         a0, a1, (a0)
        ret

asm_test::swap::u64::release:
        amoswap.d.rl      a0, a1, (a0)
        ret

asm_test::store::u8::seqcst:
        fence             rw, w
        sb                a1, 0x0(a0)
        fence             rw, rw
        ret

asm_test::store::u8::relaxed:
        sb                a1, 0x0(a0)
        ret

asm_test::store::u8::release:
        fence             rw, w
        sb                a1, 0x0(a0)
        ret

asm_test::store::u16::seqcst:
        fence             rw, w
        sh                a1, 0x0(a0)
        fence             rw, rw
        ret

asm_test::store::u16::relaxed:
        sh                a1, 0x0(a0)
        ret

asm_test::store::u16::release:
        fence             rw, w
        sh                a1, 0x0(a0)
        ret

asm_test::store::u32::seqcst:
        fence             rw, w
        sw                a1, 0x0(a0)
        fence             rw, rw
        ret

asm_test::store::u32::relaxed:
        sw                a1, 0x0(a0)
        ret

asm_test::store::u32::release:
        fence             rw, w
        sw                a1, 0x0(a0)
        ret

asm_test::store::u64::seqcst:
        fence             rw, w
        sd                a1, 0x0(a0)
        fence             rw, rw
        ret

asm_test::store::u64::relaxed:
        sd                a1, 0x0(a0)
        ret

asm_test::store::u64::release:
        fence             rw, w
        sd                a1, 0x0(a0)
        ret

