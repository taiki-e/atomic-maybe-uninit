asm_test::compare_exchange::u8::acqrel_seqcst:
        mov               w8, w1
        casalb            w8, w2, [x0]
        cmp               w8, w1, uxtb
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u8::seqcst_seqcst:
        mov               w8, w1
        casalb            w8, w2, [x0]
        cmp               w8, w1, uxtb
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u8::acqrel_acquire:
        mov               w8, w1
        casalb            w8, w2, [x0]
        cmp               w8, w1, uxtb
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u8::acqrel_relaxed:
        mov               w8, w1
        casalb            w8, w2, [x0]
        cmp               w8, w1, uxtb
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u8::acquire_seqcst:
        mov               w8, w1
        casalb            w8, w2, [x0]
        cmp               w8, w1, uxtb
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u8::relaxed_seqcst:
        mov               w8, w1
        casalb            w8, w2, [x0]
        cmp               w8, w1, uxtb
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u8::release_seqcst:
        mov               w8, w1
        casalb            w8, w2, [x0]
        cmp               w8, w1, uxtb
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u8::seqcst_acquire:
        mov               w8, w1
        casalb            w8, w2, [x0]
        cmp               w8, w1, uxtb
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u8::seqcst_relaxed:
        mov               w8, w1
        casalb            w8, w2, [x0]
        cmp               w8, w1, uxtb
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u8::acquire_acquire:
        mov               w8, w1
        casab             w8, w2, [x0]
        cmp               w8, w1, uxtb
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u8::acquire_relaxed:
        mov               w8, w1
        casab             w8, w2, [x0]
        cmp               w8, w1, uxtb
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u8::relaxed_acquire:
        mov               w8, w1
        casab             w8, w2, [x0]
        cmp               w8, w1, uxtb
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u8::relaxed_relaxed:
        mov               w8, w1
        casb              w8, w2, [x0]
        cmp               w8, w1, uxtb
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u8::release_acquire:
        mov               w8, w1
        casalb            w8, w2, [x0]
        cmp               w8, w1, uxtb
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u8::release_relaxed:
        mov               w8, w1
        caslb             w8, w2, [x0]
        cmp               w8, w1, uxtb
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u16::acqrel_seqcst:
        mov               w8, w1
        casalh            w8, w2, [x0]
        cmp               w8, w1, uxth
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u16::seqcst_seqcst:
        mov               w8, w1
        casalh            w8, w2, [x0]
        cmp               w8, w1, uxth
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u16::acqrel_acquire:
        mov               w8, w1
        casalh            w8, w2, [x0]
        cmp               w8, w1, uxth
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u16::acqrel_relaxed:
        mov               w8, w1
        casalh            w8, w2, [x0]
        cmp               w8, w1, uxth
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u16::acquire_seqcst:
        mov               w8, w1
        casalh            w8, w2, [x0]
        cmp               w8, w1, uxth
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u16::relaxed_seqcst:
        mov               w8, w1
        casalh            w8, w2, [x0]
        cmp               w8, w1, uxth
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u16::release_seqcst:
        mov               w8, w1
        casalh            w8, w2, [x0]
        cmp               w8, w1, uxth
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u16::seqcst_acquire:
        mov               w8, w1
        casalh            w8, w2, [x0]
        cmp               w8, w1, uxth
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u16::seqcst_relaxed:
        mov               w8, w1
        casalh            w8, w2, [x0]
        cmp               w8, w1, uxth
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u16::acquire_acquire:
        mov               w8, w1
        casah             w8, w2, [x0]
        cmp               w8, w1, uxth
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u16::acquire_relaxed:
        mov               w8, w1
        casah             w8, w2, [x0]
        cmp               w8, w1, uxth
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u16::relaxed_acquire:
        mov               w8, w1
        casah             w8, w2, [x0]
        cmp               w8, w1, uxth
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u16::relaxed_relaxed:
        mov               w8, w1
        cash              w8, w2, [x0]
        cmp               w8, w1, uxth
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u16::release_acquire:
        mov               w8, w1
        casalh            w8, w2, [x0]
        cmp               w8, w1, uxth
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u16::release_relaxed:
        mov               w8, w1
        caslh             w8, w2, [x0]
        cmp               w8, w1, uxth
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u32::acqrel_seqcst:
        mov               w8, w1
        casal             w8, w2, [x0]
        cmp               w8, w1
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u32::seqcst_seqcst:
        mov               w8, w1
        casal             w8, w2, [x0]
        cmp               w8, w1
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u32::acqrel_acquire:
        mov               w8, w1
        casal             w8, w2, [x0]
        cmp               w8, w1
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u32::acqrel_relaxed:
        mov               w8, w1
        casal             w8, w2, [x0]
        cmp               w8, w1
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u32::acquire_seqcst:
        mov               w8, w1
        casal             w8, w2, [x0]
        cmp               w8, w1
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u32::relaxed_seqcst:
        mov               w8, w1
        casal             w8, w2, [x0]
        cmp               w8, w1
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u32::release_seqcst:
        mov               w8, w1
        casal             w8, w2, [x0]
        cmp               w8, w1
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u32::seqcst_acquire:
        mov               w8, w1
        casal             w8, w2, [x0]
        cmp               w8, w1
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u32::seqcst_relaxed:
        mov               w8, w1
        casal             w8, w2, [x0]
        cmp               w8, w1
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u32::acquire_acquire:
        mov               w8, w1
        casa              w8, w2, [x0]
        cmp               w8, w1
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u32::acquire_relaxed:
        mov               w8, w1
        casa              w8, w2, [x0]
        cmp               w8, w1
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u32::relaxed_acquire:
        mov               w8, w1
        casa              w8, w2, [x0]
        cmp               w8, w1
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u32::relaxed_relaxed:
        mov               w8, w1
        cas               w8, w2, [x0]
        cmp               w8, w1
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u32::release_acquire:
        mov               w8, w1
        casal             w8, w2, [x0]
        cmp               w8, w1
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u32::release_relaxed:
        mov               w8, w1
        casl              w8, w2, [x0]
        cmp               w8, w1
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u64::acqrel_seqcst:
        mov               x8, x1
        casal             x8, x2, [x0]
        cmp               x8, x1
        cset              w9, eq
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u64::seqcst_seqcst:
        mov               x8, x1
        casal             x8, x2, [x0]
        cmp               x8, x1
        cset              w9, eq
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u64::acqrel_acquire:
        mov               x8, x1
        casal             x8, x2, [x0]
        cmp               x8, x1
        cset              w9, eq
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u64::acqrel_relaxed:
        mov               x8, x1
        casal             x8, x2, [x0]
        cmp               x8, x1
        cset              w9, eq
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u64::acquire_seqcst:
        mov               x8, x1
        casal             x8, x2, [x0]
        cmp               x8, x1
        cset              w9, eq
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u64::relaxed_seqcst:
        mov               x8, x1
        casal             x8, x2, [x0]
        cmp               x8, x1
        cset              w9, eq
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u64::release_seqcst:
        mov               x8, x1
        casal             x8, x2, [x0]
        cmp               x8, x1
        cset              w9, eq
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u64::seqcst_acquire:
        mov               x8, x1
        casal             x8, x2, [x0]
        cmp               x8, x1
        cset              w9, eq
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u64::seqcst_relaxed:
        mov               x8, x1
        casal             x8, x2, [x0]
        cmp               x8, x1
        cset              w9, eq
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u64::acquire_acquire:
        mov               x8, x1
        casa              x8, x2, [x0]
        cmp               x8, x1
        cset              w9, eq
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u64::acquire_relaxed:
        mov               x8, x1
        casa              x8, x2, [x0]
        cmp               x8, x1
        cset              w9, eq
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u64::relaxed_acquire:
        mov               x8, x1
        casa              x8, x2, [x0]
        cmp               x8, x1
        cset              w9, eq
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u64::relaxed_relaxed:
        mov               x8, x1
        cas               x8, x2, [x0]
        cmp               x8, x1
        cset              w9, eq
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u64::release_acquire:
        mov               x8, x1
        casal             x8, x2, [x0]
        cmp               x8, x1
        cset              w9, eq
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u64::release_relaxed:
        mov               x8, x1
        casl              x8, x2, [x0]
        cmp               x8, x1
        cset              w9, eq
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange::u128::acqrel_seqcst:
        mov               x10, x8
        mov               x8, x2
        mov               x9, x3
        caspal            x8, x9, x4, x5, [x0]
        cmp               x8, x2
        ccmp              x9, x3, #0x0, eq
        cset              w11, eq
        stp               x8, x9, [x10]
        strb              w11, [x10, #0x10]
        ret

asm_test::compare_exchange::u128::seqcst_seqcst:
        mov               x10, x8
        mov               x8, x2
        mov               x9, x3
        caspal            x8, x9, x4, x5, [x0]
        cmp               x8, x2
        ccmp              x9, x3, #0x0, eq
        cset              w11, eq
        stp               x8, x9, [x10]
        strb              w11, [x10, #0x10]
        ret

asm_test::compare_exchange::u128::acqrel_acquire:
        mov               x10, x8
        mov               x8, x2
        mov               x9, x3
        caspal            x8, x9, x4, x5, [x0]
        cmp               x8, x2
        ccmp              x9, x3, #0x0, eq
        cset              w11, eq
        stp               x8, x9, [x10]
        strb              w11, [x10, #0x10]
        ret

asm_test::compare_exchange::u128::acqrel_relaxed:
        mov               x10, x8
        mov               x8, x2
        mov               x9, x3
        caspal            x8, x9, x4, x5, [x0]
        cmp               x8, x2
        ccmp              x9, x3, #0x0, eq
        cset              w11, eq
        stp               x8, x9, [x10]
        strb              w11, [x10, #0x10]
        ret

asm_test::compare_exchange::u128::acquire_seqcst:
        mov               x10, x8
        mov               x8, x2
        mov               x9, x3
        caspal            x8, x9, x4, x5, [x0]
        cmp               x8, x2
        ccmp              x9, x3, #0x0, eq
        cset              w11, eq
        stp               x8, x9, [x10]
        strb              w11, [x10, #0x10]
        ret

asm_test::compare_exchange::u128::relaxed_seqcst:
        mov               x10, x8
        mov               x8, x2
        mov               x9, x3
        caspal            x8, x9, x4, x5, [x0]
        cmp               x8, x2
        ccmp              x9, x3, #0x0, eq
        cset              w11, eq
        stp               x8, x9, [x10]
        strb              w11, [x10, #0x10]
        ret

asm_test::compare_exchange::u128::release_seqcst:
        mov               x10, x8
        mov               x8, x2
        mov               x9, x3
        caspal            x8, x9, x4, x5, [x0]
        cmp               x8, x2
        ccmp              x9, x3, #0x0, eq
        cset              w11, eq
        stp               x8, x9, [x10]
        strb              w11, [x10, #0x10]
        ret

asm_test::compare_exchange::u128::seqcst_acquire:
        mov               x10, x8
        mov               x8, x2
        mov               x9, x3
        caspal            x8, x9, x4, x5, [x0]
        cmp               x8, x2
        ccmp              x9, x3, #0x0, eq
        cset              w11, eq
        stp               x8, x9, [x10]
        strb              w11, [x10, #0x10]
        ret

asm_test::compare_exchange::u128::seqcst_relaxed:
        mov               x10, x8
        mov               x8, x2
        mov               x9, x3
        caspal            x8, x9, x4, x5, [x0]
        cmp               x8, x2
        ccmp              x9, x3, #0x0, eq
        cset              w11, eq
        stp               x8, x9, [x10]
        strb              w11, [x10, #0x10]
        ret

asm_test::compare_exchange::u128::acquire_acquire:
        mov               x10, x8
        mov               x8, x2
        mov               x9, x3
        caspa             x8, x9, x4, x5, [x0]
        cmp               x8, x2
        ccmp              x9, x3, #0x0, eq
        cset              w11, eq
        stp               x8, x9, [x10]
        strb              w11, [x10, #0x10]
        ret

asm_test::compare_exchange::u128::acquire_relaxed:
        mov               x10, x8
        mov               x8, x2
        mov               x9, x3
        caspa             x8, x9, x4, x5, [x0]
        cmp               x8, x2
        ccmp              x9, x3, #0x0, eq
        cset              w11, eq
        stp               x8, x9, [x10]
        strb              w11, [x10, #0x10]
        ret

asm_test::compare_exchange::u128::relaxed_acquire:
        mov               x10, x8
        mov               x8, x2
        mov               x9, x3
        caspa             x8, x9, x4, x5, [x0]
        cmp               x8, x2
        ccmp              x9, x3, #0x0, eq
        cset              w11, eq
        stp               x8, x9, [x10]
        strb              w11, [x10, #0x10]
        ret

asm_test::compare_exchange::u128::relaxed_relaxed:
        mov               x10, x8
        mov               x8, x2
        mov               x9, x3
        casp              x8, x9, x4, x5, [x0]
        cmp               x8, x2
        ccmp              x9, x3, #0x0, eq
        cset              w11, eq
        stp               x8, x9, [x10]
        strb              w11, [x10, #0x10]
        ret

asm_test::compare_exchange::u128::release_acquire:
        mov               x10, x8
        mov               x8, x2
        mov               x9, x3
        caspal            x8, x9, x4, x5, [x0]
        cmp               x8, x2
        ccmp              x9, x3, #0x0, eq
        cset              w11, eq
        stp               x8, x9, [x10]
        strb              w11, [x10, #0x10]
        ret

asm_test::compare_exchange::u128::release_relaxed:
        mov               x10, x8
        mov               x8, x2
        mov               x9, x3
        caspl             x8, x9, x4, x5, [x0]
        cmp               x8, x2
        ccmp              x9, x3, #0x0, eq
        cset              w11, eq
        stp               x8, x9, [x10]
        strb              w11, [x10, #0x10]
        ret

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        mov               w8, w1
        casalb            w8, w2, [x0]
        cmp               w8, w1, uxtb
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        mov               w8, w1
        casalb            w8, w2, [x0]
        cmp               w8, w1, uxtb
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        mov               w8, w1
        casalb            w8, w2, [x0]
        cmp               w8, w1, uxtb
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        mov               w8, w1
        casalb            w8, w2, [x0]
        cmp               w8, w1, uxtb
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        mov               w8, w1
        casalb            w8, w2, [x0]
        cmp               w8, w1, uxtb
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        mov               w8, w1
        casalb            w8, w2, [x0]
        cmp               w8, w1, uxtb
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u8::release_seqcst:
        mov               w8, w1
        casalb            w8, w2, [x0]
        cmp               w8, w1, uxtb
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        mov               w8, w1
        casalb            w8, w2, [x0]
        cmp               w8, w1, uxtb
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        mov               w8, w1
        casalb            w8, w2, [x0]
        cmp               w8, w1, uxtb
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u8::acquire_acquire:
        mov               w8, w1
        casab             w8, w2, [x0]
        cmp               w8, w1, uxtb
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        mov               w8, w1
        casab             w8, w2, [x0]
        cmp               w8, w1, uxtb
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        mov               w8, w1
        casab             w8, w2, [x0]
        cmp               w8, w1, uxtb
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        mov               w8, w1
        casb              w8, w2, [x0]
        cmp               w8, w1, uxtb
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u8::release_acquire:
        mov               w8, w1
        casalb            w8, w2, [x0]
        cmp               w8, w1, uxtb
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u8::release_relaxed:
        mov               w8, w1
        caslb             w8, w2, [x0]
        cmp               w8, w1, uxtb
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        mov               w8, w1
        casalh            w8, w2, [x0]
        cmp               w8, w1, uxth
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        mov               w8, w1
        casalh            w8, w2, [x0]
        cmp               w8, w1, uxth
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        mov               w8, w1
        casalh            w8, w2, [x0]
        cmp               w8, w1, uxth
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        mov               w8, w1
        casalh            w8, w2, [x0]
        cmp               w8, w1, uxth
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        mov               w8, w1
        casalh            w8, w2, [x0]
        cmp               w8, w1, uxth
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        mov               w8, w1
        casalh            w8, w2, [x0]
        cmp               w8, w1, uxth
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u16::release_seqcst:
        mov               w8, w1
        casalh            w8, w2, [x0]
        cmp               w8, w1, uxth
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        mov               w8, w1
        casalh            w8, w2, [x0]
        cmp               w8, w1, uxth
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        mov               w8, w1
        casalh            w8, w2, [x0]
        cmp               w8, w1, uxth
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u16::acquire_acquire:
        mov               w8, w1
        casah             w8, w2, [x0]
        cmp               w8, w1, uxth
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        mov               w8, w1
        casah             w8, w2, [x0]
        cmp               w8, w1, uxth
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        mov               w8, w1
        casah             w8, w2, [x0]
        cmp               w8, w1, uxth
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        mov               w8, w1
        cash              w8, w2, [x0]
        cmp               w8, w1, uxth
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u16::release_acquire:
        mov               w8, w1
        casalh            w8, w2, [x0]
        cmp               w8, w1, uxth
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u16::release_relaxed:
        mov               w8, w1
        caslh             w8, w2, [x0]
        cmp               w8, w1, uxth
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        mov               w8, w1
        casal             w8, w2, [x0]
        cmp               w8, w1
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        mov               w8, w1
        casal             w8, w2, [x0]
        cmp               w8, w1
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        mov               w8, w1
        casal             w8, w2, [x0]
        cmp               w8, w1
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        mov               w8, w1
        casal             w8, w2, [x0]
        cmp               w8, w1
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        mov               w8, w1
        casal             w8, w2, [x0]
        cmp               w8, w1
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        mov               w8, w1
        casal             w8, w2, [x0]
        cmp               w8, w1
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u32::release_seqcst:
        mov               w8, w1
        casal             w8, w2, [x0]
        cmp               w8, w1
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        mov               w8, w1
        casal             w8, w2, [x0]
        cmp               w8, w1
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        mov               w8, w1
        casal             w8, w2, [x0]
        cmp               w8, w1
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u32::acquire_acquire:
        mov               w8, w1
        casa              w8, w2, [x0]
        cmp               w8, w1
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        mov               w8, w1
        casa              w8, w2, [x0]
        cmp               w8, w1
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        mov               w8, w1
        casa              w8, w2, [x0]
        cmp               w8, w1
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        mov               w8, w1
        cas               w8, w2, [x0]
        cmp               w8, w1
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u32::release_acquire:
        mov               w8, w1
        casal             w8, w2, [x0]
        cmp               w8, w1
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u32::release_relaxed:
        mov               w8, w1
        casl              w8, w2, [x0]
        cmp               w8, w1
        cset              w9, eq
        mov               w0, w8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u64::acqrel_seqcst:
        mov               x8, x1
        casal             x8, x2, [x0]
        cmp               x8, x1
        cset              w9, eq
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u64::seqcst_seqcst:
        mov               x8, x1
        casal             x8, x2, [x0]
        cmp               x8, x1
        cset              w9, eq
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u64::acqrel_acquire:
        mov               x8, x1
        casal             x8, x2, [x0]
        cmp               x8, x1
        cset              w9, eq
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u64::acqrel_relaxed:
        mov               x8, x1
        casal             x8, x2, [x0]
        cmp               x8, x1
        cset              w9, eq
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u64::acquire_seqcst:
        mov               x8, x1
        casal             x8, x2, [x0]
        cmp               x8, x1
        cset              w9, eq
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u64::relaxed_seqcst:
        mov               x8, x1
        casal             x8, x2, [x0]
        cmp               x8, x1
        cset              w9, eq
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u64::release_seqcst:
        mov               x8, x1
        casal             x8, x2, [x0]
        cmp               x8, x1
        cset              w9, eq
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u64::seqcst_acquire:
        mov               x8, x1
        casal             x8, x2, [x0]
        cmp               x8, x1
        cset              w9, eq
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u64::seqcst_relaxed:
        mov               x8, x1
        casal             x8, x2, [x0]
        cmp               x8, x1
        cset              w9, eq
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u64::acquire_acquire:
        mov               x8, x1
        casa              x8, x2, [x0]
        cmp               x8, x1
        cset              w9, eq
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u64::acquire_relaxed:
        mov               x8, x1
        casa              x8, x2, [x0]
        cmp               x8, x1
        cset              w9, eq
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u64::relaxed_acquire:
        mov               x8, x1
        casa              x8, x2, [x0]
        cmp               x8, x1
        cset              w9, eq
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u64::relaxed_relaxed:
        mov               x8, x1
        cas               x8, x2, [x0]
        cmp               x8, x1
        cset              w9, eq
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u64::release_acquire:
        mov               x8, x1
        casal             x8, x2, [x0]
        cmp               x8, x1
        cset              w9, eq
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u64::release_relaxed:
        mov               x8, x1
        casl              x8, x2, [x0]
        cmp               x8, x1
        cset              w9, eq
        mov               x0, x8
        cmp               w9, #0x0
        cset              w1, ne
        ret

asm_test::compare_exchange_weak::u128::acqrel_seqcst:
        mov               x10, x8
        mov               x8, x2
        mov               x9, x3
        caspal            x8, x9, x4, x5, [x0]
        cmp               x8, x2
        ccmp              x9, x3, #0x0, eq
        cset              w11, eq
        stp               x8, x9, [x10]
        strb              w11, [x10, #0x10]
        ret

asm_test::compare_exchange_weak::u128::seqcst_seqcst:
        mov               x10, x8
        mov               x8, x2
        mov               x9, x3
        caspal            x8, x9, x4, x5, [x0]
        cmp               x8, x2
        ccmp              x9, x3, #0x0, eq
        cset              w11, eq
        stp               x8, x9, [x10]
        strb              w11, [x10, #0x10]
        ret

asm_test::compare_exchange_weak::u128::acqrel_acquire:
        mov               x10, x8
        mov               x8, x2
        mov               x9, x3
        caspal            x8, x9, x4, x5, [x0]
        cmp               x8, x2
        ccmp              x9, x3, #0x0, eq
        cset              w11, eq
        stp               x8, x9, [x10]
        strb              w11, [x10, #0x10]
        ret

asm_test::compare_exchange_weak::u128::acqrel_relaxed:
        mov               x10, x8
        mov               x8, x2
        mov               x9, x3
        caspal            x8, x9, x4, x5, [x0]
        cmp               x8, x2
        ccmp              x9, x3, #0x0, eq
        cset              w11, eq
        stp               x8, x9, [x10]
        strb              w11, [x10, #0x10]
        ret

asm_test::compare_exchange_weak::u128::acquire_seqcst:
        mov               x10, x8
        mov               x8, x2
        mov               x9, x3
        caspal            x8, x9, x4, x5, [x0]
        cmp               x8, x2
        ccmp              x9, x3, #0x0, eq
        cset              w11, eq
        stp               x8, x9, [x10]
        strb              w11, [x10, #0x10]
        ret

asm_test::compare_exchange_weak::u128::relaxed_seqcst:
        mov               x10, x8
        mov               x8, x2
        mov               x9, x3
        caspal            x8, x9, x4, x5, [x0]
        cmp               x8, x2
        ccmp              x9, x3, #0x0, eq
        cset              w11, eq
        stp               x8, x9, [x10]
        strb              w11, [x10, #0x10]
        ret

asm_test::compare_exchange_weak::u128::release_seqcst:
        mov               x10, x8
        mov               x8, x2
        mov               x9, x3
        caspal            x8, x9, x4, x5, [x0]
        cmp               x8, x2
        ccmp              x9, x3, #0x0, eq
        cset              w11, eq
        stp               x8, x9, [x10]
        strb              w11, [x10, #0x10]
        ret

asm_test::compare_exchange_weak::u128::seqcst_acquire:
        mov               x10, x8
        mov               x8, x2
        mov               x9, x3
        caspal            x8, x9, x4, x5, [x0]
        cmp               x8, x2
        ccmp              x9, x3, #0x0, eq
        cset              w11, eq
        stp               x8, x9, [x10]
        strb              w11, [x10, #0x10]
        ret

asm_test::compare_exchange_weak::u128::seqcst_relaxed:
        mov               x10, x8
        mov               x8, x2
        mov               x9, x3
        caspal            x8, x9, x4, x5, [x0]
        cmp               x8, x2
        ccmp              x9, x3, #0x0, eq
        cset              w11, eq
        stp               x8, x9, [x10]
        strb              w11, [x10, #0x10]
        ret

asm_test::compare_exchange_weak::u128::acquire_acquire:
        mov               x10, x8
        mov               x8, x2
        mov               x9, x3
        caspa             x8, x9, x4, x5, [x0]
        cmp               x8, x2
        ccmp              x9, x3, #0x0, eq
        cset              w11, eq
        stp               x8, x9, [x10]
        strb              w11, [x10, #0x10]
        ret

asm_test::compare_exchange_weak::u128::acquire_relaxed:
        mov               x10, x8
        mov               x8, x2
        mov               x9, x3
        caspa             x8, x9, x4, x5, [x0]
        cmp               x8, x2
        ccmp              x9, x3, #0x0, eq
        cset              w11, eq
        stp               x8, x9, [x10]
        strb              w11, [x10, #0x10]
        ret

asm_test::compare_exchange_weak::u128::relaxed_acquire:
        mov               x10, x8
        mov               x8, x2
        mov               x9, x3
        caspa             x8, x9, x4, x5, [x0]
        cmp               x8, x2
        ccmp              x9, x3, #0x0, eq
        cset              w11, eq
        stp               x8, x9, [x10]
        strb              w11, [x10, #0x10]
        ret

asm_test::compare_exchange_weak::u128::relaxed_relaxed:
        mov               x10, x8
        mov               x8, x2
        mov               x9, x3
        casp              x8, x9, x4, x5, [x0]
        cmp               x8, x2
        ccmp              x9, x3, #0x0, eq
        cset              w11, eq
        stp               x8, x9, [x10]
        strb              w11, [x10, #0x10]
        ret

asm_test::compare_exchange_weak::u128::release_acquire:
        mov               x10, x8
        mov               x8, x2
        mov               x9, x3
        caspal            x8, x9, x4, x5, [x0]
        cmp               x8, x2
        ccmp              x9, x3, #0x0, eq
        cset              w11, eq
        stp               x8, x9, [x10]
        strb              w11, [x10, #0x10]
        ret

asm_test::compare_exchange_weak::u128::release_relaxed:
        mov               x10, x8
        mov               x8, x2
        mov               x9, x3
        caspl             x8, x9, x4, x5, [x0]
        cmp               x8, x2
        ccmp              x9, x3, #0x0, eq
        cset              w11, eq
        stp               x8, x9, [x10]
        strb              w11, [x10, #0x10]
        ret

asm_test::load::u8::seqcst:
        ldarb             w0, [x0]
        ret

asm_test::load::u8::acquire:
        ldarb             w0, [x0]
        ret

asm_test::load::u8::relaxed:
        ldrb              w0, [x0]
        ret

asm_test::load::u16::seqcst:
        ldarh             w0, [x0]
        ret

asm_test::load::u16::acquire:
        ldarh             w0, [x0]
        ret

asm_test::load::u16::relaxed:
        ldrh              w0, [x0]
        ret

asm_test::load::u32::seqcst:
        ldar              w0, [x0]
        ret

asm_test::load::u32::acquire:
        ldar              w0, [x0]
        ret

asm_test::load::u32::relaxed:
        ldr               w0, [x0]
        ret

asm_test::load::u64::seqcst:
        ldar              x0, [x0]
        ret

asm_test::load::u64::acquire:
        ldar              x0, [x0]
        ret

asm_test::load::u64::relaxed:
        ldr               x0, [x0]
        ret

asm_test::load::u128::seqcst:
        ldar              x8, [x0]
        ldp               x0, x1, [x0]
        dmb               ishld
        ret

asm_test::load::u128::acquire:
        ldp               x0, x1, [x0]
        dmb               ishld
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
        mov               x1, x3
        swppal            x2, x1, [x0]
        mov               x0, x2
        ret

asm_test::swap::u128::seqcst:
        mov               x1, x3
        swppal            x2, x1, [x0]
        mov               x0, x2
        ret

asm_test::swap::u128::acquire:
        mov               x1, x3
        swppa             x2, x1, [x0]
        mov               x0, x2
        ret

asm_test::swap::u128::relaxed:
        mov               x1, x3
        swpp              x2, x1, [x0]
        mov               x0, x2
        ret

asm_test::swap::u128::release:
        mov               x1, x3
        swppl             x2, x1, [x0]
        mov               x0, x2
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
        swppal            x2, x3, [x0]
        ret

asm_test::store::u128::relaxed:
        stp               x2, x3, [x0]
        ret

asm_test::store::u128::release:
        swppl             x2, x3, [x0]
        ret

