asm_test::compare_exchange::u8::acqrel_seqcst:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 255
        lsl               r13, r0, r12
        zextb             r1, r1
        zextb             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
        sync
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange::u8::seqcst_seqcst:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 255
        lsl               r13, r0, r12
        zextb             r1, r1
        zextb             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
        sync
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange::u8::acqrel_acquire:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 255
        lsl               r13, r0, r12
        zextb             r1, r1
        zextb             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
        sync
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange::u8::acqrel_relaxed:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 255
        lsl               r13, r0, r12
        zextb             r1, r1
        zextb             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
        sync
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange::u8::acquire_seqcst:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 255
        lsl               r13, r0, r12
        zextb             r1, r1
        zextb             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
        sync
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange::u8::relaxed_seqcst:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 255
        lsl               r13, r0, r12
        zextb             r1, r1
        zextb             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
        sync
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange::u8::release_seqcst:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 255
        lsl               r13, r0, r12
        zextb             r1, r1
        zextb             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
        sync
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange::u8::seqcst_acquire:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 255
        lsl               r13, r0, r12
        zextb             r1, r1
        zextb             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
        sync
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange::u8::seqcst_relaxed:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 255
        lsl               r13, r0, r12
        zextb             r1, r1
        zextb             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
        sync
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange::u8::acquire_acquire:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 255
        lsl               r13, r0, r12
        zextb             r1, r1
        zextb             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange::u8::acquire_relaxed:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 255
        lsl               r13, r0, r12
        zextb             r1, r1
        zextb             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange::u8::relaxed_acquire:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 255
        lsl               r13, r0, r12
        zextb             r1, r1
        zextb             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange::u8::relaxed_relaxed:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 255
        lsl               r13, r0, r12
        zextb             r1, r1
        zextb             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange::u8::release_acquire:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 255
        lsl               r13, r0, r12
        zextb             r1, r1
        zextb             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
        sync
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange::u8::release_relaxed:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 255
        lsl               r13, r0, r12
        zextb             r1, r1
        zextb             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
        sync
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange::u16::acqrel_seqcst:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 65535
        lsl               r13, r0, r12
        zexth             r1, r1
        zexth             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
        sync
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange::u16::seqcst_seqcst:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 65535
        lsl               r13, r0, r12
        zexth             r1, r1
        zexth             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
        sync
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange::u16::acqrel_acquire:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 65535
        lsl               r13, r0, r12
        zexth             r1, r1
        zexth             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
        sync
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange::u16::acqrel_relaxed:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 65535
        lsl               r13, r0, r12
        zexth             r1, r1
        zexth             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
        sync
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange::u16::acquire_seqcst:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 65535
        lsl               r13, r0, r12
        zexth             r1, r1
        zexth             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
        sync
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange::u16::relaxed_seqcst:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 65535
        lsl               r13, r0, r12
        zexth             r1, r1
        zexth             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
        sync
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange::u16::release_seqcst:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 65535
        lsl               r13, r0, r12
        zexth             r1, r1
        zexth             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
        sync
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange::u16::seqcst_acquire:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 65535
        lsl               r13, r0, r12
        zexth             r1, r1
        zexth             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
        sync
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange::u16::seqcst_relaxed:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 65535
        lsl               r13, r0, r12
        zexth             r1, r1
        zexth             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
        sync
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange::u16::acquire_acquire:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 65535
        lsl               r13, r0, r12
        zexth             r1, r1
        zexth             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange::u16::acquire_relaxed:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 65535
        lsl               r13, r0, r12
        zexth             r1, r1
        zexth             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange::u16::relaxed_acquire:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 65535
        lsl               r13, r0, r12
        zexth             r1, r1
        zexth             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange::u16::relaxed_relaxed:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 65535
        lsl               r13, r0, r12
        zexth             r1, r1
        zexth             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange::u16::release_acquire:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 65535
        lsl               r13, r0, r12
        zexth             r1, r1
        zexth             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
        sync
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange::u16::release_relaxed:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 65535
        lsl               r13, r0, r12
        zexth             r1, r1
        zexth             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
        sync
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange::u32::acqrel_seqcst:
        movi              r12, 0
        sync
0:
        ldex.w            r3, (r0, 0x0)
        cmpne             r3, r1
        bt                1f
        or                r12, r2, r2
        stex.w            r12, (r0, 0x0)
        bez               r12, 0b
1:
        sync
        cmpnei            r12, 0
        mov               r0, r3
        mvc               r1
        rts

asm_test::compare_exchange::u32::seqcst_seqcst:
        movi              r12, 0
        sync
0:
        ldex.w            r3, (r0, 0x0)
        cmpne             r3, r1
        bt                1f
        or                r12, r2, r2
        stex.w            r12, (r0, 0x0)
        bez               r12, 0b
1:
        sync
        cmpnei            r12, 0
        mov               r0, r3
        mvc               r1
        rts

asm_test::compare_exchange::u32::acqrel_acquire:
        movi              r12, 0
        sync
0:
        ldex.w            r3, (r0, 0x0)
        cmpne             r3, r1
        bt                1f
        or                r12, r2, r2
        stex.w            r12, (r0, 0x0)
        bez               r12, 0b
1:
        sync
        cmpnei            r12, 0
        mov               r0, r3
        mvc               r1
        rts

asm_test::compare_exchange::u32::acqrel_relaxed:
        movi              r12, 0
        sync
0:
        ldex.w            r3, (r0, 0x0)
        cmpne             r3, r1
        bt                1f
        or                r12, r2, r2
        stex.w            r12, (r0, 0x0)
        bez               r12, 0b
1:
        sync
        cmpnei            r12, 0
        mov               r0, r3
        mvc               r1
        rts

asm_test::compare_exchange::u32::acquire_seqcst:
        movi              r12, 0
        sync
0:
        ldex.w            r3, (r0, 0x0)
        cmpne             r3, r1
        bt                1f
        or                r12, r2, r2
        stex.w            r12, (r0, 0x0)
        bez               r12, 0b
1:
        sync
        cmpnei            r12, 0
        mov               r0, r3
        mvc               r1
        rts

asm_test::compare_exchange::u32::relaxed_seqcst:
        movi              r12, 0
        sync
0:
        ldex.w            r3, (r0, 0x0)
        cmpne             r3, r1
        bt                1f
        or                r12, r2, r2
        stex.w            r12, (r0, 0x0)
        bez               r12, 0b
1:
        sync
        cmpnei            r12, 0
        mov               r0, r3
        mvc               r1
        rts

asm_test::compare_exchange::u32::release_seqcst:
        movi              r12, 0
        sync
0:
        ldex.w            r3, (r0, 0x0)
        cmpne             r3, r1
        bt                1f
        or                r12, r2, r2
        stex.w            r12, (r0, 0x0)
        bez               r12, 0b
1:
        sync
        cmpnei            r12, 0
        mov               r0, r3
        mvc               r1
        rts

asm_test::compare_exchange::u32::seqcst_acquire:
        movi              r12, 0
        sync
0:
        ldex.w            r3, (r0, 0x0)
        cmpne             r3, r1
        bt                1f
        or                r12, r2, r2
        stex.w            r12, (r0, 0x0)
        bez               r12, 0b
1:
        sync
        cmpnei            r12, 0
        mov               r0, r3
        mvc               r1
        rts

asm_test::compare_exchange::u32::seqcst_relaxed:
        movi              r12, 0
        sync
0:
        ldex.w            r3, (r0, 0x0)
        cmpne             r3, r1
        bt                1f
        or                r12, r2, r2
        stex.w            r12, (r0, 0x0)
        bez               r12, 0b
1:
        sync
        cmpnei            r12, 0
        mov               r0, r3
        mvc               r1
        rts

asm_test::compare_exchange::u32::acquire_acquire:
        movi              r12, 0
0:
        ldex.w            r3, (r0, 0x0)
        cmpne             r3, r1
        bt                1f
        or                r12, r2, r2
        stex.w            r12, (r0, 0x0)
        bez               r12, 0b
1:
        sync
        cmpnei            r12, 0
        mov               r0, r3
        mvc               r1
        rts

asm_test::compare_exchange::u32::acquire_relaxed:
        movi              r12, 0
0:
        ldex.w            r3, (r0, 0x0)
        cmpne             r3, r1
        bt                1f
        or                r12, r2, r2
        stex.w            r12, (r0, 0x0)
        bez               r12, 0b
1:
        sync
        cmpnei            r12, 0
        mov               r0, r3
        mvc               r1
        rts

asm_test::compare_exchange::u32::relaxed_acquire:
        movi              r12, 0
0:
        ldex.w            r3, (r0, 0x0)
        cmpne             r3, r1
        bt                1f
        or                r12, r2, r2
        stex.w            r12, (r0, 0x0)
        bez               r12, 0b
1:
        sync
        cmpnei            r12, 0
        mov               r0, r3
        mvc               r1
        rts

asm_test::compare_exchange::u32::relaxed_relaxed:
        movi              r12, 0
0:
        ldex.w            r3, (r0, 0x0)
        cmpne             r3, r1
        bt                1f
        or                r12, r2, r2
        stex.w            r12, (r0, 0x0)
        bez               r12, 0b
1:
        cmpnei            r12, 0
        mov               r0, r3
        mvc               r1
        rts

asm_test::compare_exchange::u32::release_acquire:
        movi              r12, 0
        sync
0:
        ldex.w            r3, (r0, 0x0)
        cmpne             r3, r1
        bt                1f
        or                r12, r2, r2
        stex.w            r12, (r0, 0x0)
        bez               r12, 0b
1:
        sync
        cmpnei            r12, 0
        mov               r0, r3
        mvc               r1
        rts

asm_test::compare_exchange::u32::release_relaxed:
        movi              r12, 0
        sync
0:
        ldex.w            r3, (r0, 0x0)
        cmpne             r3, r1
        bt                1f
        or                r12, r2, r2
        stex.w            r12, (r0, 0x0)
        bez               r12, 0b
1:
        cmpnei            r12, 0
        mov               r0, r3
        mvc               r1
        rts

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 255
        lsl               r13, r0, r12
        zextb             r1, r1
        zextb             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
        sync
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 255
        lsl               r13, r0, r12
        zextb             r1, r1
        zextb             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
        sync
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 255
        lsl               r13, r0, r12
        zextb             r1, r1
        zextb             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
        sync
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 255
        lsl               r13, r0, r12
        zextb             r1, r1
        zextb             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
        sync
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 255
        lsl               r13, r0, r12
        zextb             r1, r1
        zextb             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
        sync
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 255
        lsl               r13, r0, r12
        zextb             r1, r1
        zextb             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
        sync
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange_weak::u8::release_seqcst:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 255
        lsl               r13, r0, r12
        zextb             r1, r1
        zextb             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
        sync
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 255
        lsl               r13, r0, r12
        zextb             r1, r1
        zextb             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
        sync
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 255
        lsl               r13, r0, r12
        zextb             r1, r1
        zextb             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
        sync
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange_weak::u8::acquire_acquire:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 255
        lsl               r13, r0, r12
        zextb             r1, r1
        zextb             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 255
        lsl               r13, r0, r12
        zextb             r1, r1
        zextb             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 255
        lsl               r13, r0, r12
        zextb             r1, r1
        zextb             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 255
        lsl               r13, r0, r12
        zextb             r1, r1
        zextb             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange_weak::u8::release_acquire:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 255
        lsl               r13, r0, r12
        zextb             r1, r1
        zextb             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
        sync
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange_weak::u8::release_relaxed:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 255
        lsl               r13, r0, r12
        zextb             r1, r1
        zextb             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
        sync
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 65535
        lsl               r13, r0, r12
        zexth             r1, r1
        zexth             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
        sync
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 65535
        lsl               r13, r0, r12
        zexth             r1, r1
        zexth             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
        sync
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 65535
        lsl               r13, r0, r12
        zexth             r1, r1
        zexth             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
        sync
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 65535
        lsl               r13, r0, r12
        zexth             r1, r1
        zexth             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
        sync
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 65535
        lsl               r13, r0, r12
        zexth             r1, r1
        zexth             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
        sync
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 65535
        lsl               r13, r0, r12
        zexth             r1, r1
        zexth             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
        sync
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange_weak::u16::release_seqcst:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 65535
        lsl               r13, r0, r12
        zexth             r1, r1
        zexth             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
        sync
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 65535
        lsl               r13, r0, r12
        zexth             r1, r1
        zexth             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
        sync
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 65535
        lsl               r13, r0, r12
        zexth             r1, r1
        zexth             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
        sync
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange_weak::u16::acquire_acquire:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 65535
        lsl               r13, r0, r12
        zexth             r1, r1
        zexth             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 65535
        lsl               r13, r0, r12
        zexth             r1, r1
        zexth             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 65535
        lsl               r13, r0, r12
        zexth             r1, r1
        zexth             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 65535
        lsl               r13, r0, r12
        zexth             r1, r1
        zexth             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange_weak::u16::release_acquire:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 65535
        lsl               r13, r0, r12
        zexth             r1, r1
        zexth             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
        sync
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        sync
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange_weak::u16::release_relaxed:
        andni             r3, r0, 3
        lsli              r0, r0, 3
        andi              r12, r0, 24
        movi              r0, 65535
        lsl               r13, r0, r12
        zexth             r1, r1
        zexth             r2, r2
        lsl               r1, r1, r12
        lsl               r2, r2, r12
        sync
0:
        ldex.w            r18, (r3, 0x0)
        and               r0, r18, r13
        cmpne             r0, r1
        bt                1f
        andn              r18, r18, r13
        or                r18, r18, r2
        stex.w            r18, (r3, 0x0)
        bez               r18, 0b
        br                2f
1:
        movi              r18, 0
2:
        lsr               r0, r0, r12
        cmpnei            r18, 0
        mvc               r1
        rts

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        movi              r12, 0
        sync
0:
        ldex.w            r3, (r0, 0x0)
        cmpne             r3, r1
        bt                1f
        or                r12, r2, r2
        stex.w            r12, (r0, 0x0)
        bez               r12, 0b
1:
        sync
        cmpnei            r12, 0
        mov               r0, r3
        mvc               r1
        rts

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        movi              r12, 0
        sync
0:
        ldex.w            r3, (r0, 0x0)
        cmpne             r3, r1
        bt                1f
        or                r12, r2, r2
        stex.w            r12, (r0, 0x0)
        bez               r12, 0b
1:
        sync
        cmpnei            r12, 0
        mov               r0, r3
        mvc               r1
        rts

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        movi              r12, 0
        sync
0:
        ldex.w            r3, (r0, 0x0)
        cmpne             r3, r1
        bt                1f
        or                r12, r2, r2
        stex.w            r12, (r0, 0x0)
        bez               r12, 0b
1:
        sync
        cmpnei            r12, 0
        mov               r0, r3
        mvc               r1
        rts

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        movi              r12, 0
        sync
0:
        ldex.w            r3, (r0, 0x0)
        cmpne             r3, r1
        bt                1f
        or                r12, r2, r2
        stex.w            r12, (r0, 0x0)
        bez               r12, 0b
1:
        sync
        cmpnei            r12, 0
        mov               r0, r3
        mvc               r1
        rts

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        movi              r12, 0
        sync
0:
        ldex.w            r3, (r0, 0x0)
        cmpne             r3, r1
        bt                1f
        or                r12, r2, r2
        stex.w            r12, (r0, 0x0)
        bez               r12, 0b
1:
        sync
        cmpnei            r12, 0
        mov               r0, r3
        mvc               r1
        rts

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        movi              r12, 0
        sync
0:
        ldex.w            r3, (r0, 0x0)
        cmpne             r3, r1
        bt                1f
        or                r12, r2, r2
        stex.w            r12, (r0, 0x0)
        bez               r12, 0b
1:
        sync
        cmpnei            r12, 0
        mov               r0, r3
        mvc               r1
        rts

asm_test::compare_exchange_weak::u32::release_seqcst:
        movi              r12, 0
        sync
0:
        ldex.w            r3, (r0, 0x0)
        cmpne             r3, r1
        bt                1f
        or                r12, r2, r2
        stex.w            r12, (r0, 0x0)
        bez               r12, 0b
1:
        sync
        cmpnei            r12, 0
        mov               r0, r3
        mvc               r1
        rts

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        movi              r12, 0
        sync
0:
        ldex.w            r3, (r0, 0x0)
        cmpne             r3, r1
        bt                1f
        or                r12, r2, r2
        stex.w            r12, (r0, 0x0)
        bez               r12, 0b
1:
        sync
        cmpnei            r12, 0
        mov               r0, r3
        mvc               r1
        rts

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        movi              r12, 0
        sync
0:
        ldex.w            r3, (r0, 0x0)
        cmpne             r3, r1
        bt                1f
        or                r12, r2, r2
        stex.w            r12, (r0, 0x0)
        bez               r12, 0b
1:
        sync
        cmpnei            r12, 0
        mov               r0, r3
        mvc               r1
        rts

asm_test::compare_exchange_weak::u32::acquire_acquire:
        movi              r12, 0
0:
        ldex.w            r3, (r0, 0x0)
        cmpne             r3, r1
        bt                1f
        or                r12, r2, r2
        stex.w            r12, (r0, 0x0)
        bez               r12, 0b
1:
        sync
        cmpnei            r12, 0
        mov               r0, r3
        mvc               r1
        rts

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        movi              r12, 0
0:
        ldex.w            r3, (r0, 0x0)
        cmpne             r3, r1
        bt                1f
        or                r12, r2, r2
        stex.w            r12, (r0, 0x0)
        bez               r12, 0b
1:
        sync
        cmpnei            r12, 0
        mov               r0, r3
        mvc               r1
        rts

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        movi              r12, 0
0:
        ldex.w            r3, (r0, 0x0)
        cmpne             r3, r1
        bt                1f
        or                r12, r2, r2
        stex.w            r12, (r0, 0x0)
        bez               r12, 0b
1:
        sync
        cmpnei            r12, 0
        mov               r0, r3
        mvc               r1
        rts

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        movi              r12, 0
0:
        ldex.w            r3, (r0, 0x0)
        cmpne             r3, r1
        bt                1f
        or                r12, r2, r2
        stex.w            r12, (r0, 0x0)
        bez               r12, 0b
1:
        cmpnei            r12, 0
        mov               r0, r3
        mvc               r1
        rts

asm_test::compare_exchange_weak::u32::release_acquire:
        movi              r12, 0
        sync
0:
        ldex.w            r3, (r0, 0x0)
        cmpne             r3, r1
        bt                1f
        or                r12, r2, r2
        stex.w            r12, (r0, 0x0)
        bez               r12, 0b
1:
        sync
        cmpnei            r12, 0
        mov               r0, r3
        mvc               r1
        rts

asm_test::compare_exchange_weak::u32::release_relaxed:
        movi              r12, 0
        sync
0:
        ldex.w            r3, (r0, 0x0)
        cmpne             r3, r1
        bt                1f
        or                r12, r2, r2
        stex.w            r12, (r0, 0x0)
        bez               r12, 0b
1:
        cmpnei            r12, 0
        mov               r0, r3
        mvc               r1
        rts

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

asm_test::swap::u8::acqrel:
        andni             r2, r0, 3
        lsli              r0, r0, 3
        andi              r3, r0, 24
        movi              r0, 255
        lsl               r12, r0, r3
        zextb             r1, r1
        lsl               r1, r1, r3
        sync
0:
        ldex.w            r0, (r2, 0x0)
        andn              r13, r0, r12
        or                r13, r13, r1
        stex.w            r13, (r2, 0x0)
        bez               r13, 0b
        sync
        lsr               r0, r0, r3
        rts

asm_test::swap::u8::seqcst:
        andni             r2, r0, 3
        lsli              r0, r0, 3
        andi              r3, r0, 24
        movi              r0, 255
        lsl               r12, r0, r3
        zextb             r1, r1
        lsl               r1, r1, r3
        sync
0:
        ldex.w            r0, (r2, 0x0)
        andn              r13, r0, r12
        or                r13, r13, r1
        stex.w            r13, (r2, 0x0)
        bez               r13, 0b
        sync
        lsr               r0, r0, r3
        rts

asm_test::swap::u8::acquire:
        andni             r2, r0, 3
        lsli              r0, r0, 3
        andi              r3, r0, 24
        movi              r0, 255
        lsl               r12, r0, r3
        zextb             r1, r1
        lsl               r1, r1, r3
0:
        ldex.w            r0, (r2, 0x0)
        andn              r13, r0, r12
        or                r13, r13, r1
        stex.w            r13, (r2, 0x0)
        bez               r13, 0b
        sync
        lsr               r0, r0, r3
        rts

asm_test::swap::u8::relaxed:
        andni             r2, r0, 3
        lsli              r0, r0, 3
        andi              r3, r0, 24
        movi              r0, 255
        lsl               r12, r0, r3
        zextb             r1, r1
        lsl               r1, r1, r3
0:
        ldex.w            r0, (r2, 0x0)
        andn              r13, r0, r12
        or                r13, r13, r1
        stex.w            r13, (r2, 0x0)
        bez               r13, 0b
        lsr               r0, r0, r3
        rts

asm_test::swap::u8::release:
        andni             r2, r0, 3
        lsli              r0, r0, 3
        andi              r3, r0, 24
        movi              r0, 255
        lsl               r12, r0, r3
        zextb             r1, r1
        lsl               r1, r1, r3
        sync
0:
        ldex.w            r0, (r2, 0x0)
        andn              r13, r0, r12
        or                r13, r13, r1
        stex.w            r13, (r2, 0x0)
        bez               r13, 0b
        lsr               r0, r0, r3
        rts

asm_test::swap::u16::acqrel:
        andni             r2, r0, 3
        lsli              r0, r0, 3
        andi              r3, r0, 24
        movi              r0, 65535
        lsl               r12, r0, r3
        zexth             r1, r1
        lsl               r1, r1, r3
        sync
0:
        ldex.w            r0, (r2, 0x0)
        andn              r13, r0, r12
        or                r13, r13, r1
        stex.w            r13, (r2, 0x0)
        bez               r13, 0b
        sync
        lsr               r0, r0, r3
        rts

asm_test::swap::u16::seqcst:
        andni             r2, r0, 3
        lsli              r0, r0, 3
        andi              r3, r0, 24
        movi              r0, 65535
        lsl               r12, r0, r3
        zexth             r1, r1
        lsl               r1, r1, r3
        sync
0:
        ldex.w            r0, (r2, 0x0)
        andn              r13, r0, r12
        or                r13, r13, r1
        stex.w            r13, (r2, 0x0)
        bez               r13, 0b
        sync
        lsr               r0, r0, r3
        rts

asm_test::swap::u16::acquire:
        andni             r2, r0, 3
        lsli              r0, r0, 3
        andi              r3, r0, 24
        movi              r0, 65535
        lsl               r12, r0, r3
        zexth             r1, r1
        lsl               r1, r1, r3
0:
        ldex.w            r0, (r2, 0x0)
        andn              r13, r0, r12
        or                r13, r13, r1
        stex.w            r13, (r2, 0x0)
        bez               r13, 0b
        sync
        lsr               r0, r0, r3
        rts

asm_test::swap::u16::relaxed:
        andni             r2, r0, 3
        lsli              r0, r0, 3
        andi              r3, r0, 24
        movi              r0, 65535
        lsl               r12, r0, r3
        zexth             r1, r1
        lsl               r1, r1, r3
0:
        ldex.w            r0, (r2, 0x0)
        andn              r13, r0, r12
        or                r13, r13, r1
        stex.w            r13, (r2, 0x0)
        bez               r13, 0b
        lsr               r0, r0, r3
        rts

asm_test::swap::u16::release:
        andni             r2, r0, 3
        lsli              r0, r0, 3
        andi              r3, r0, 24
        movi              r0, 65535
        lsl               r12, r0, r3
        zexth             r1, r1
        lsl               r1, r1, r3
        sync
0:
        ldex.w            r0, (r2, 0x0)
        andn              r13, r0, r12
        or                r13, r13, r1
        stex.w            r13, (r2, 0x0)
        bez               r13, 0b
        lsr               r0, r0, r3
        rts

asm_test::swap::u32::acqrel:
        sync
0:
        ldex.w            r2, (r0, 0x0)
        or                r3, r1, r1
        stex.w            r3, (r0, 0x0)
        bez               r3, 0b
        sync
        mov               r0, r2
        rts

asm_test::swap::u32::seqcst:
        sync
0:
        ldex.w            r2, (r0, 0x0)
        or                r3, r1, r1
        stex.w            r3, (r0, 0x0)
        bez               r3, 0b
        sync
        mov               r0, r2
        rts

asm_test::swap::u32::acquire:
0:
        ldex.w            r2, (r0, 0x0)
        or                r3, r1, r1
        stex.w            r3, (r0, 0x0)
        bez               r3, 0b
        sync
        mov               r0, r2
        rts

asm_test::swap::u32::relaxed:
0:
        ldex.w            r2, (r0, 0x0)
        or                r3, r1, r1
        stex.w            r3, (r0, 0x0)
        bez               r3, 0b
        mov               r0, r2
        rts

asm_test::swap::u32::release:
        sync
0:
        ldex.w            r2, (r0, 0x0)
        or                r3, r1, r1
        stex.w            r3, (r0, 0x0)
        bez               r3, 0b
        mov               r0, r2
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

