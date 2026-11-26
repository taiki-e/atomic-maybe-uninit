asm_test::load::u8::seqcst:
        sync
        ld.b              r0, (r0, 0x0)
        sync
        rts

asm_test::load::u8::acquire:
        ld.b              r0, (r0, 0x0)
        sync
        rts

asm_test::load::u8::relaxed:
        ld.b              r0, (r0, 0x0)
        rts

asm_test::load::u16::seqcst:
        sync
        ld.h              r0, (r0, 0x0)
        sync
        rts

asm_test::load::u16::acquire:
        ld.h              r0, (r0, 0x0)
        sync
        rts

asm_test::load::u16::relaxed:
        ld.h              r0, (r0, 0x0)
        rts

asm_test::load::u32::seqcst:
        sync
        ld.w              r0, (r0, 0x0)
        sync
        rts

asm_test::load::u32::acquire:
        ld.w              r0, (r0, 0x0)
        sync
        rts

asm_test::load::u32::relaxed:
        ld.w              r0, (r0, 0x0)
        rts

asm_test::store::u8::seqcst:
        sync
        st.b              r1, (r0, 0x0)
        sync
        rts

asm_test::store::u8::relaxed:
        st.b              r1, (r0, 0x0)
        rts

asm_test::store::u8::release:
        sync
        st.b              r1, (r0, 0x0)
        rts

asm_test::store::u16::seqcst:
        sync
        st.h              r1, (r0, 0x0)
        sync
        rts

asm_test::store::u16::relaxed:
        st.h              r1, (r0, 0x0)
        rts

asm_test::store::u16::release:
        sync
        st.h              r1, (r0, 0x0)
        rts

asm_test::store::u32::seqcst:
        sync
        st.w              r1, (r0, 0x0)
        sync
        rts

asm_test::store::u32::relaxed:
        st.w              r1, (r0, 0x0)
        rts

asm_test::store::u32::release:
        sync
        st.w              r1, (r0, 0x0)
        rts
