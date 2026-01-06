asm_test::compare_exchange::u8::acqrel_seqcst:
        mov               w8, w1
        casalb            w8, w2, [x0]
        cmp               w8, w1, uxtb
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u8::seqcst_seqcst:
        mov               w8, w1
        casalb            w8, w2, [x0]
        cmp               w8, w1, uxtb
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u8::acqrel_acquire:
        mov               w8, w1
        casalb            w8, w2, [x0]
        cmp               w8, w1, uxtb
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u8::acqrel_relaxed:
        mov               w8, w1
        casalb            w8, w2, [x0]
        cmp               w8, w1, uxtb
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u8::acquire_seqcst:
        mov               w8, w1
        casalb            w8, w2, [x0]
        cmp               w8, w1, uxtb
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u8::relaxed_seqcst:
        mov               w8, w1
        casalb            w8, w2, [x0]
        cmp               w8, w1, uxtb
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u8::release_seqcst:
        mov               w8, w1
        casalb            w8, w2, [x0]
        cmp               w8, w1, uxtb
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u8::seqcst_acquire:
        mov               w8, w1
        casalb            w8, w2, [x0]
        cmp               w8, w1, uxtb
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u8::seqcst_relaxed:
        mov               w8, w1
        casalb            w8, w2, [x0]
        cmp               w8, w1, uxtb
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u8::acquire_acquire:
        mov               w8, w1
        casab             w8, w2, [x0]
        cmp               w8, w1, uxtb
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u8::acquire_relaxed:
        mov               w8, w1
        casab             w8, w2, [x0]
        cmp               w8, w1, uxtb
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u8::relaxed_acquire:
        mov               w8, w1
        casab             w8, w2, [x0]
        cmp               w8, w1, uxtb
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u8::relaxed_relaxed:
        mov               w8, w1
        casb              w8, w2, [x0]
        cmp               w8, w1, uxtb
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u8::release_acquire:
        mov               w8, w1
        casalb            w8, w2, [x0]
        cmp               w8, w1, uxtb
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u8::release_relaxed:
        mov               w8, w1
        caslb             w8, w2, [x0]
        cmp               w8, w1, uxtb
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u16::acqrel_seqcst:
        mov               w8, w1
        casalh            w8, w2, [x0]
        cmp               w8, w1, uxth
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u16::seqcst_seqcst:
        mov               w8, w1
        casalh            w8, w2, [x0]
        cmp               w8, w1, uxth
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u16::acqrel_acquire:
        mov               w8, w1
        casalh            w8, w2, [x0]
        cmp               w8, w1, uxth
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u16::acqrel_relaxed:
        mov               w8, w1
        casalh            w8, w2, [x0]
        cmp               w8, w1, uxth
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u16::acquire_seqcst:
        mov               w8, w1
        casalh            w8, w2, [x0]
        cmp               w8, w1, uxth
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u16::relaxed_seqcst:
        mov               w8, w1
        casalh            w8, w2, [x0]
        cmp               w8, w1, uxth
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u16::release_seqcst:
        mov               w8, w1
        casalh            w8, w2, [x0]
        cmp               w8, w1, uxth
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u16::seqcst_acquire:
        mov               w8, w1
        casalh            w8, w2, [x0]
        cmp               w8, w1, uxth
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u16::seqcst_relaxed:
        mov               w8, w1
        casalh            w8, w2, [x0]
        cmp               w8, w1, uxth
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u16::acquire_acquire:
        mov               w8, w1
        casah             w8, w2, [x0]
        cmp               w8, w1, uxth
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u16::acquire_relaxed:
        mov               w8, w1
        casah             w8, w2, [x0]
        cmp               w8, w1, uxth
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u16::relaxed_acquire:
        mov               w8, w1
        casah             w8, w2, [x0]
        cmp               w8, w1, uxth
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u16::relaxed_relaxed:
        mov               w8, w1
        cash              w8, w2, [x0]
        cmp               w8, w1, uxth
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u16::release_acquire:
        mov               w8, w1
        casalh            w8, w2, [x0]
        cmp               w8, w1, uxth
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u16::release_relaxed:
        mov               w8, w1
        caslh             w8, w2, [x0]
        cmp               w8, w1, uxth
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u32::acqrel_seqcst:
        mov               w8, w1
        casal             w8, w2, [x0]
        cmp               w8, w1
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u32::seqcst_seqcst:
        mov               w8, w1
        casal             w8, w2, [x0]
        cmp               w8, w1
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u32::acqrel_acquire:
        mov               w8, w1
        casal             w8, w2, [x0]
        cmp               w8, w1
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u32::acqrel_relaxed:
        mov               w8, w1
        casal             w8, w2, [x0]
        cmp               w8, w1
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u32::acquire_seqcst:
        mov               w8, w1
        casal             w8, w2, [x0]
        cmp               w8, w1
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u32::relaxed_seqcst:
        mov               w8, w1
        casal             w8, w2, [x0]
        cmp               w8, w1
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u32::release_seqcst:
        mov               w8, w1
        casal             w8, w2, [x0]
        cmp               w8, w1
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u32::seqcst_acquire:
        mov               w8, w1
        casal             w8, w2, [x0]
        cmp               w8, w1
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u32::seqcst_relaxed:
        mov               w8, w1
        casal             w8, w2, [x0]
        cmp               w8, w1
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u32::acquire_acquire:
        mov               w8, w1
        casa              w8, w2, [x0]
        cmp               w8, w1
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u32::acquire_relaxed:
        mov               w8, w1
        casa              w8, w2, [x0]
        cmp               w8, w1
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u32::relaxed_acquire:
        mov               w8, w1
        casa              w8, w2, [x0]
        cmp               w8, w1
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u32::relaxed_relaxed:
        mov               w8, w1
        cas               w8, w2, [x0]
        cmp               w8, w1
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u32::release_acquire:
        mov               w8, w1
        casal             w8, w2, [x0]
        cmp               w8, w1
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u32::release_relaxed:
        mov               w8, w1
        casl              w8, w2, [x0]
        cmp               w8, w1
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange::u64::acqrel_seqcst:
        mov               x8, x1
        casal             x8, x2, [x0]
        cmp               x8, x1
        mov               x0, x8
        cset              w1, eq
        ret

asm_test::compare_exchange::u64::seqcst_seqcst:
        mov               x8, x1
        casal             x8, x2, [x0]
        cmp               x8, x1
        mov               x0, x8
        cset              w1, eq
        ret

asm_test::compare_exchange::u64::acqrel_acquire:
        mov               x8, x1
        casal             x8, x2, [x0]
        cmp               x8, x1
        mov               x0, x8
        cset              w1, eq
        ret

asm_test::compare_exchange::u64::acqrel_relaxed:
        mov               x8, x1
        casal             x8, x2, [x0]
        cmp               x8, x1
        mov               x0, x8
        cset              w1, eq
        ret

asm_test::compare_exchange::u64::acquire_seqcst:
        mov               x8, x1
        casal             x8, x2, [x0]
        cmp               x8, x1
        mov               x0, x8
        cset              w1, eq
        ret

asm_test::compare_exchange::u64::relaxed_seqcst:
        mov               x8, x1
        casal             x8, x2, [x0]
        cmp               x8, x1
        mov               x0, x8
        cset              w1, eq
        ret

asm_test::compare_exchange::u64::release_seqcst:
        mov               x8, x1
        casal             x8, x2, [x0]
        cmp               x8, x1
        mov               x0, x8
        cset              w1, eq
        ret

asm_test::compare_exchange::u64::seqcst_acquire:
        mov               x8, x1
        casal             x8, x2, [x0]
        cmp               x8, x1
        mov               x0, x8
        cset              w1, eq
        ret

asm_test::compare_exchange::u64::seqcst_relaxed:
        mov               x8, x1
        casal             x8, x2, [x0]
        cmp               x8, x1
        mov               x0, x8
        cset              w1, eq
        ret

asm_test::compare_exchange::u64::acquire_acquire:
        mov               x8, x1
        casa              x8, x2, [x0]
        cmp               x8, x1
        mov               x0, x8
        cset              w1, eq
        ret

asm_test::compare_exchange::u64::acquire_relaxed:
        mov               x8, x1
        casa              x8, x2, [x0]
        cmp               x8, x1
        mov               x0, x8
        cset              w1, eq
        ret

asm_test::compare_exchange::u64::relaxed_acquire:
        mov               x8, x1
        casa              x8, x2, [x0]
        cmp               x8, x1
        mov               x0, x8
        cset              w1, eq
        ret

asm_test::compare_exchange::u64::relaxed_relaxed:
        mov               x8, x1
        cas               x8, x2, [x0]
        cmp               x8, x1
        mov               x0, x8
        cset              w1, eq
        ret

asm_test::compare_exchange::u64::release_acquire:
        mov               x8, x1
        casal             x8, x2, [x0]
        cmp               x8, x1
        mov               x0, x8
        cset              w1, eq
        ret

asm_test::compare_exchange::u64::release_relaxed:
        mov               x8, x1
        casl              x8, x2, [x0]
        cmp               x8, x1
        mov               x0, x8
        cset              w1, eq
        ret

asm_test::compare_exchange::u128::acqrel_seqcst:
        mov               x6, x2
        mov               x7, x3
        caspal            x6, x7, x4, x5, [x0]
        cmp               x6, x2
        stp               x6, x7, [x8]
        ccmp              x7, x3, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange::u128::seqcst_seqcst:
        mov               x6, x2
        mov               x7, x3
        caspal            x6, x7, x4, x5, [x0]
        cmp               x6, x2
        stp               x6, x7, [x8]
        ccmp              x7, x3, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange::u128::acqrel_acquire:
        mov               x6, x2
        mov               x7, x3
        caspal            x6, x7, x4, x5, [x0]
        cmp               x6, x2
        stp               x6, x7, [x8]
        ccmp              x7, x3, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange::u128::acqrel_relaxed:
        mov               x6, x2
        mov               x7, x3
        caspal            x6, x7, x4, x5, [x0]
        cmp               x6, x2
        stp               x6, x7, [x8]
        ccmp              x7, x3, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange::u128::acquire_seqcst:
        mov               x6, x2
        mov               x7, x3
        caspal            x6, x7, x4, x5, [x0]
        cmp               x6, x2
        stp               x6, x7, [x8]
        ccmp              x7, x3, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange::u128::relaxed_seqcst:
        mov               x6, x2
        mov               x7, x3
        caspal            x6, x7, x4, x5, [x0]
        cmp               x6, x2
        stp               x6, x7, [x8]
        ccmp              x7, x3, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange::u128::release_seqcst:
        mov               x6, x2
        mov               x7, x3
        caspal            x6, x7, x4, x5, [x0]
        cmp               x6, x2
        stp               x6, x7, [x8]
        ccmp              x7, x3, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange::u128::seqcst_acquire:
        mov               x6, x2
        mov               x7, x3
        caspal            x6, x7, x4, x5, [x0]
        cmp               x6, x2
        stp               x6, x7, [x8]
        ccmp              x7, x3, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange::u128::seqcst_relaxed:
        mov               x6, x2
        mov               x7, x3
        caspal            x6, x7, x4, x5, [x0]
        cmp               x6, x2
        stp               x6, x7, [x8]
        ccmp              x7, x3, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange::u128::acquire_acquire:
        mov               x6, x2
        mov               x7, x3
        caspa             x6, x7, x4, x5, [x0]
        cmp               x6, x2
        stp               x6, x7, [x8]
        ccmp              x7, x3, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange::u128::acquire_relaxed:
        mov               x6, x2
        mov               x7, x3
        caspa             x6, x7, x4, x5, [x0]
        cmp               x6, x2
        stp               x6, x7, [x8]
        ccmp              x7, x3, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange::u128::relaxed_acquire:
        mov               x6, x2
        mov               x7, x3
        caspa             x6, x7, x4, x5, [x0]
        cmp               x6, x2
        stp               x6, x7, [x8]
        ccmp              x7, x3, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange::u128::relaxed_relaxed:
        mov               x6, x2
        mov               x7, x3
        casp              x6, x7, x4, x5, [x0]
        cmp               x6, x2
        stp               x6, x7, [x8]
        ccmp              x7, x3, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange::u128::release_acquire:
        mov               x6, x2
        mov               x7, x3
        caspal            x6, x7, x4, x5, [x0]
        cmp               x6, x2
        stp               x6, x7, [x8]
        ccmp              x7, x3, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange::u128::release_relaxed:
        mov               x6, x2
        mov               x7, x3
        caspl             x6, x7, x4, x5, [x0]
        cmp               x6, x2
        stp               x6, x7, [x8]
        ccmp              x7, x3, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        mov               w8, w1
        casalb            w8, w2, [x0]
        cmp               w8, w1, uxtb
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        mov               w8, w1
        casalb            w8, w2, [x0]
        cmp               w8, w1, uxtb
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        mov               w8, w1
        casalb            w8, w2, [x0]
        cmp               w8, w1, uxtb
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        mov               w8, w1
        casalb            w8, w2, [x0]
        cmp               w8, w1, uxtb
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        mov               w8, w1
        casalb            w8, w2, [x0]
        cmp               w8, w1, uxtb
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        mov               w8, w1
        casalb            w8, w2, [x0]
        cmp               w8, w1, uxtb
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u8::release_seqcst:
        mov               w8, w1
        casalb            w8, w2, [x0]
        cmp               w8, w1, uxtb
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        mov               w8, w1
        casalb            w8, w2, [x0]
        cmp               w8, w1, uxtb
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        mov               w8, w1
        casalb            w8, w2, [x0]
        cmp               w8, w1, uxtb
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u8::acquire_acquire:
        mov               w8, w1
        casab             w8, w2, [x0]
        cmp               w8, w1, uxtb
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        mov               w8, w1
        casab             w8, w2, [x0]
        cmp               w8, w1, uxtb
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        mov               w8, w1
        casab             w8, w2, [x0]
        cmp               w8, w1, uxtb
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        mov               w8, w1
        casb              w8, w2, [x0]
        cmp               w8, w1, uxtb
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u8::release_acquire:
        mov               w8, w1
        casalb            w8, w2, [x0]
        cmp               w8, w1, uxtb
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u8::release_relaxed:
        mov               w8, w1
        caslb             w8, w2, [x0]
        cmp               w8, w1, uxtb
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        mov               w8, w1
        casalh            w8, w2, [x0]
        cmp               w8, w1, uxth
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        mov               w8, w1
        casalh            w8, w2, [x0]
        cmp               w8, w1, uxth
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        mov               w8, w1
        casalh            w8, w2, [x0]
        cmp               w8, w1, uxth
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        mov               w8, w1
        casalh            w8, w2, [x0]
        cmp               w8, w1, uxth
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        mov               w8, w1
        casalh            w8, w2, [x0]
        cmp               w8, w1, uxth
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        mov               w8, w1
        casalh            w8, w2, [x0]
        cmp               w8, w1, uxth
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u16::release_seqcst:
        mov               w8, w1
        casalh            w8, w2, [x0]
        cmp               w8, w1, uxth
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        mov               w8, w1
        casalh            w8, w2, [x0]
        cmp               w8, w1, uxth
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        mov               w8, w1
        casalh            w8, w2, [x0]
        cmp               w8, w1, uxth
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u16::acquire_acquire:
        mov               w8, w1
        casah             w8, w2, [x0]
        cmp               w8, w1, uxth
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        mov               w8, w1
        casah             w8, w2, [x0]
        cmp               w8, w1, uxth
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        mov               w8, w1
        casah             w8, w2, [x0]
        cmp               w8, w1, uxth
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        mov               w8, w1
        cash              w8, w2, [x0]
        cmp               w8, w1, uxth
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u16::release_acquire:
        mov               w8, w1
        casalh            w8, w2, [x0]
        cmp               w8, w1, uxth
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u16::release_relaxed:
        mov               w8, w1
        caslh             w8, w2, [x0]
        cmp               w8, w1, uxth
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        mov               w8, w1
        casal             w8, w2, [x0]
        cmp               w8, w1
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        mov               w8, w1
        casal             w8, w2, [x0]
        cmp               w8, w1
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        mov               w8, w1
        casal             w8, w2, [x0]
        cmp               w8, w1
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        mov               w8, w1
        casal             w8, w2, [x0]
        cmp               w8, w1
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        mov               w8, w1
        casal             w8, w2, [x0]
        cmp               w8, w1
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        mov               w8, w1
        casal             w8, w2, [x0]
        cmp               w8, w1
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u32::release_seqcst:
        mov               w8, w1
        casal             w8, w2, [x0]
        cmp               w8, w1
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        mov               w8, w1
        casal             w8, w2, [x0]
        cmp               w8, w1
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        mov               w8, w1
        casal             w8, w2, [x0]
        cmp               w8, w1
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u32::acquire_acquire:
        mov               w8, w1
        casa              w8, w2, [x0]
        cmp               w8, w1
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        mov               w8, w1
        casa              w8, w2, [x0]
        cmp               w8, w1
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        mov               w8, w1
        casa              w8, w2, [x0]
        cmp               w8, w1
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        mov               w8, w1
        cas               w8, w2, [x0]
        cmp               w8, w1
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u32::release_acquire:
        mov               w8, w1
        casal             w8, w2, [x0]
        cmp               w8, w1
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u32::release_relaxed:
        mov               w8, w1
        casl              w8, w2, [x0]
        cmp               w8, w1
        mov               w0, w8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u64::acqrel_seqcst:
        mov               x8, x1
        casal             x8, x2, [x0]
        cmp               x8, x1
        mov               x0, x8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u64::seqcst_seqcst:
        mov               x8, x1
        casal             x8, x2, [x0]
        cmp               x8, x1
        mov               x0, x8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u64::acqrel_acquire:
        mov               x8, x1
        casal             x8, x2, [x0]
        cmp               x8, x1
        mov               x0, x8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u64::acqrel_relaxed:
        mov               x8, x1
        casal             x8, x2, [x0]
        cmp               x8, x1
        mov               x0, x8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u64::acquire_seqcst:
        mov               x8, x1
        casal             x8, x2, [x0]
        cmp               x8, x1
        mov               x0, x8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u64::relaxed_seqcst:
        mov               x8, x1
        casal             x8, x2, [x0]
        cmp               x8, x1
        mov               x0, x8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u64::release_seqcst:
        mov               x8, x1
        casal             x8, x2, [x0]
        cmp               x8, x1
        mov               x0, x8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u64::seqcst_acquire:
        mov               x8, x1
        casal             x8, x2, [x0]
        cmp               x8, x1
        mov               x0, x8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u64::seqcst_relaxed:
        mov               x8, x1
        casal             x8, x2, [x0]
        cmp               x8, x1
        mov               x0, x8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u64::acquire_acquire:
        mov               x8, x1
        casa              x8, x2, [x0]
        cmp               x8, x1
        mov               x0, x8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u64::acquire_relaxed:
        mov               x8, x1
        casa              x8, x2, [x0]
        cmp               x8, x1
        mov               x0, x8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u64::relaxed_acquire:
        mov               x8, x1
        casa              x8, x2, [x0]
        cmp               x8, x1
        mov               x0, x8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u64::relaxed_relaxed:
        mov               x8, x1
        cas               x8, x2, [x0]
        cmp               x8, x1
        mov               x0, x8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u64::release_acquire:
        mov               x8, x1
        casal             x8, x2, [x0]
        cmp               x8, x1
        mov               x0, x8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u64::release_relaxed:
        mov               x8, x1
        casl              x8, x2, [x0]
        cmp               x8, x1
        mov               x0, x8
        cset              w1, eq
        ret

asm_test::compare_exchange_weak::u128::acqrel_seqcst:
        mov               x6, x2
        mov               x7, x3
        caspal            x6, x7, x4, x5, [x0]
        cmp               x6, x2
        stp               x6, x7, [x8]
        ccmp              x7, x3, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u128::seqcst_seqcst:
        mov               x6, x2
        mov               x7, x3
        caspal            x6, x7, x4, x5, [x0]
        cmp               x6, x2
        stp               x6, x7, [x8]
        ccmp              x7, x3, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u128::acqrel_acquire:
        mov               x6, x2
        mov               x7, x3
        caspal            x6, x7, x4, x5, [x0]
        cmp               x6, x2
        stp               x6, x7, [x8]
        ccmp              x7, x3, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u128::acqrel_relaxed:
        mov               x6, x2
        mov               x7, x3
        caspal            x6, x7, x4, x5, [x0]
        cmp               x6, x2
        stp               x6, x7, [x8]
        ccmp              x7, x3, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u128::acquire_seqcst:
        mov               x6, x2
        mov               x7, x3
        caspal            x6, x7, x4, x5, [x0]
        cmp               x6, x2
        stp               x6, x7, [x8]
        ccmp              x7, x3, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u128::relaxed_seqcst:
        mov               x6, x2
        mov               x7, x3
        caspal            x6, x7, x4, x5, [x0]
        cmp               x6, x2
        stp               x6, x7, [x8]
        ccmp              x7, x3, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u128::release_seqcst:
        mov               x6, x2
        mov               x7, x3
        caspal            x6, x7, x4, x5, [x0]
        cmp               x6, x2
        stp               x6, x7, [x8]
        ccmp              x7, x3, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u128::seqcst_acquire:
        mov               x6, x2
        mov               x7, x3
        caspal            x6, x7, x4, x5, [x0]
        cmp               x6, x2
        stp               x6, x7, [x8]
        ccmp              x7, x3, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u128::seqcst_relaxed:
        mov               x6, x2
        mov               x7, x3
        caspal            x6, x7, x4, x5, [x0]
        cmp               x6, x2
        stp               x6, x7, [x8]
        ccmp              x7, x3, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u128::acquire_acquire:
        mov               x6, x2
        mov               x7, x3
        caspa             x6, x7, x4, x5, [x0]
        cmp               x6, x2
        stp               x6, x7, [x8]
        ccmp              x7, x3, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u128::acquire_relaxed:
        mov               x6, x2
        mov               x7, x3
        caspa             x6, x7, x4, x5, [x0]
        cmp               x6, x2
        stp               x6, x7, [x8]
        ccmp              x7, x3, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u128::relaxed_acquire:
        mov               x6, x2
        mov               x7, x3
        caspa             x6, x7, x4, x5, [x0]
        cmp               x6, x2
        stp               x6, x7, [x8]
        ccmp              x7, x3, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u128::relaxed_relaxed:
        mov               x6, x2
        mov               x7, x3
        casp              x6, x7, x4, x5, [x0]
        cmp               x6, x2
        stp               x6, x7, [x8]
        ccmp              x7, x3, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u128::release_acquire:
        mov               x6, x2
        mov               x7, x3
        caspal            x6, x7, x4, x5, [x0]
        cmp               x6, x2
        stp               x6, x7, [x8]
        ccmp              x7, x3, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
        ret

asm_test::compare_exchange_weak::u128::release_relaxed:
        mov               x6, x2
        mov               x7, x3
        caspl             x6, x7, x4, x5, [x0]
        cmp               x6, x2
        stp               x6, x7, [x8]
        ccmp              x7, x3, #0x0, eq
        cset              w9, eq
        strb              w9, [x8, #0x10]
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
        ldp               x0, x1, [x0]
        dmb               ish
        ret

asm_test::load::u128::acquire:
        ldiapp            x0, x1, [x0]
        ret

asm_test::load::u128::relaxed:
        ldp               x0, x1, [x0]
        ret

asm_test::swap::u8::acqrel:
        swpalb            w1, w0, [x0]
        ret

asm_test::swap::u8::seqcst:
        swpalb            w1, w0, [x0]
        ret

asm_test::swap::u8::acquire:
        swpab             w1, w0, [x0]
        ret

asm_test::swap::u8::relaxed:
        swpb              w1, w0, [x0]
        ret

asm_test::swap::u8::release:
        swplb             w1, w0, [x0]
        ret

asm_test::swap::u16::acqrel:
        swpalh            w1, w0, [x0]
        ret

asm_test::swap::u16::seqcst:
        swpalh            w1, w0, [x0]
        ret

asm_test::swap::u16::acquire:
        swpah             w1, w0, [x0]
        ret

asm_test::swap::u16::relaxed:
        swph              w1, w0, [x0]
        ret

asm_test::swap::u16::release:
        swplh             w1, w0, [x0]
        ret

asm_test::swap::u32::acqrel:
        swpal             w1, w0, [x0]
        ret

asm_test::swap::u32::seqcst:
        swpal             w1, w0, [x0]
        ret

asm_test::swap::u32::acquire:
        swpa              w1, w0, [x0]
        ret

asm_test::swap::u32::relaxed:
        swp               w1, w0, [x0]
        ret

asm_test::swap::u32::release:
        swpl              w1, w0, [x0]
        ret

asm_test::swap::u64::acqrel:
        swpal             x1, x0, [x0]
        ret

asm_test::swap::u64::seqcst:
        swpal             x1, x0, [x0]
        ret

asm_test::swap::u64::acquire:
        swpa              x1, x0, [x0]
        ret

asm_test::swap::u64::relaxed:
        swp               x1, x0, [x0]
        ret

asm_test::swap::u64::release:
        swpl              x1, x0, [x0]
        ret

asm_test::swap::u128::acqrel:
        ldp               x4, x5, [x0]
0:
        mov               x7, x5
        mov               x6, x4
        mov               x5, x7
        caspal            x4, x5, x2, x3, [x0]
        cmp               x5, x7
        ccmp              x4, x6, #0x0, eq
        b.ne              0b
        mov               x0, x4
        mov               x1, x5
        ret

asm_test::swap::u128::seqcst:
        ldp               x4, x5, [x0]
0:
        mov               x7, x5
        mov               x6, x4
        mov               x5, x7
        caspal            x4, x5, x2, x3, [x0]
        cmp               x5, x7
        ccmp              x4, x6, #0x0, eq
        b.ne              0b
        mov               x0, x4
        mov               x1, x5
        ret

asm_test::swap::u128::acquire:
        ldp               x4, x5, [x0]
0:
        mov               x7, x5
        mov               x6, x4
        mov               x5, x7
        caspa             x4, x5, x2, x3, [x0]
        cmp               x5, x7
        ccmp              x4, x6, #0x0, eq
        b.ne              0b
        mov               x0, x4
        mov               x1, x5
        ret

asm_test::swap::u128::relaxed:
        ldp               x4, x5, [x0]
0:
        mov               x7, x5
        mov               x6, x4
        mov               x5, x7
        casp              x4, x5, x2, x3, [x0]
        cmp               x5, x7
        ccmp              x4, x6, #0x0, eq
        b.ne              0b
        mov               x0, x4
        mov               x1, x5
        ret

asm_test::swap::u128::release:
        ldp               x4, x5, [x0]
0:
        mov               x7, x5
        mov               x6, x4
        mov               x5, x7
        caspl             x4, x5, x2, x3, [x0]
        cmp               x5, x7
        ccmp              x4, x6, #0x0, eq
        b.ne              0b
        mov               x0, x4
        mov               x1, x5
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
        dmb               ish
        stp               x2, x3, [x0]
        dmb               ish
        ret

asm_test::store::u128::relaxed:
        stp               x2, x3, [x0]
        ret

asm_test::store::u128::release:
        stilp             x2, x3, [x0]
        ret

