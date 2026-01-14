asm_test::compare_exchange::u8::acqrel_seqcst:
        mr                6, 3
        lbarx             3, 0, 3
        clrlwi            4, 4, 24
        cmplw             3, 4
        bf                2, 1f
        lwsync
        clrlwi            5, 5, 24
        nop
0:
        stbcx.            5, 0, 6
        bt                2, 2f
        lbarx             3, 0, 6
        cmplw             3, 4
        bt                2, 0b
1:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
2:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u8::seqcst_seqcst:
        mr                6, 3
        lbarx             3, 0, 3
        clrlwi            4, 4, 24
        cmplw             3, 4
        bf                2, 1f
        sync
        clrlwi            5, 5, 24
        nop
0:
        stbcx.            5, 0, 6
        bt                2, 2f
        lbarx             3, 0, 6
        cmplw             3, 4
        bt                2, 0b
1:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
2:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u8::acqrel_acquire:
        mr                6, 3
        lbarx             3, 0, 3
        clrlwi            4, 4, 24
        cmplw             3, 4
        bf                2, 1f
        lwsync
        clrlwi            5, 5, 24
        nop
0:
        stbcx.            5, 0, 6
        bt                2, 2f
        lbarx             3, 0, 6
        cmplw             3, 4
        bt                2, 0b
1:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
2:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u8::acqrel_relaxed:
        mr                6, 3
        lbarx             3, 0, 3
        clrlwi            4, 4, 24
        cmplw             3, 4
        bf                2, 1f
        lwsync
        clrlwi            5, 5, 24
        nop
0:
        stbcx.            5, 0, 6
        bt                2, 2f
        lbarx             3, 0, 6
        cmplw             3, 4
        bt                2, 0b
1:
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
2:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u8::acquire_seqcst:
        mr                6, 3
        clrlwi            5, 5, 24
        clrlwi            4, 4, 24
        nop
        nop
        nop
        nop
        nop
0:
        lbarx             3, 0, 6
        cmplw             3, 4
        bf                2, 1f
        stbcx.            5, 0, 6
        bf                2, 0b
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u8::relaxed_seqcst:
        mr                6, 3
        clrlwi            5, 5, 24
        clrlwi            4, 4, 24
        nop
        nop
        nop
        nop
        nop
0:
        lbarx             3, 0, 6
        cmplw             3, 4
        bf                2, 1f
        stbcx.            5, 0, 6
        bf                2, 0b
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u8::release_seqcst:
        mr                6, 3
        lbarx             3, 0, 3
        clrlwi            4, 4, 24
        cmplw             3, 4
        bf                2, 1f
        lwsync
        clrlwi            5, 5, 24
        nop
0:
        stbcx.            5, 0, 6
        bt                2, 2f
        lbarx             3, 0, 6
        cmplw             3, 4
        bt                2, 0b
1:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
2:
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u8::seqcst_acquire:
        mr                6, 3
        lbarx             3, 0, 3
        clrlwi            4, 4, 24
        cmplw             3, 4
        bf                2, 1f
        sync
        clrlwi            5, 5, 24
        nop
0:
        stbcx.            5, 0, 6
        bt                2, 2f
        lbarx             3, 0, 6
        cmplw             3, 4
        bt                2, 0b
1:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
2:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u8::seqcst_relaxed:
        mr                6, 3
        lbarx             3, 0, 3
        clrlwi            4, 4, 24
        cmplw             3, 4
        bf                2, 1f
        sync
        clrlwi            5, 5, 24
        nop
0:
        stbcx.            5, 0, 6
        bt                2, 2f
        lbarx             3, 0, 6
        cmplw             3, 4
        bt                2, 0b
1:
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
2:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u8::acquire_acquire:
        mr                6, 3
        clrlwi            5, 5, 24
        clrlwi            4, 4, 24
        nop
        nop
        nop
        nop
        nop
0:
        lbarx             3, 0, 6
        cmplw             3, 4
        bf                2, 1f
        stbcx.            5, 0, 6
        bf                2, 0b
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u8::acquire_relaxed:
        mr                6, 3
        clrlwi            5, 5, 24
        clrlwi            4, 4, 24
        nop
        nop
        nop
        nop
        nop
0:
        lbarx             3, 0, 6
        cmplw             3, 4
        bf                2, 1f
        stbcx.            5, 0, 6
        bf                2, 0b
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u8::relaxed_acquire:
        mr                6, 3
        clrlwi            5, 5, 24
        clrlwi            4, 4, 24
        nop
        nop
        nop
        nop
        nop
0:
        lbarx             3, 0, 6
        cmplw             3, 4
        bf                2, 1f
        stbcx.            5, 0, 6
        bf                2, 0b
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u8::relaxed_relaxed:
        mr                6, 3
        clrlwi            5, 5, 24
        clrlwi            4, 4, 24
        nop
        nop
        nop
        nop
        nop
0:
        lbarx             3, 0, 6
        cmplw             3, 4
        bf                2, 1f
        stbcx.            5, 0, 6
        bf                2, 0b
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u8::release_acquire:
        mr                6, 3
        lbarx             3, 0, 3
        clrlwi            4, 4, 24
        cmplw             3, 4
        bf                2, 1f
        lwsync
        clrlwi            5, 5, 24
        nop
0:
        stbcx.            5, 0, 6
        bt                2, 2f
        lbarx             3, 0, 6
        cmplw             3, 4
        bt                2, 0b
1:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
2:
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u8::release_relaxed:
        mr                6, 3
        lbarx             3, 0, 3
        clrlwi            4, 4, 24
        cmplw             3, 4
        bf                2, 1f
        lwsync
        clrlwi            5, 5, 24
        nop
0:
        stbcx.            5, 0, 6
        bt                2, 2f
        lbarx             3, 0, 6
        cmplw             3, 4
        bt                2, 0b
1:
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
2:
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u16::acqrel_seqcst:
        mr                6, 3
        lharx             3, 0, 3
        clrlwi            4, 4, 16
        cmplw             3, 4
        bf                2, 1f
        lwsync
        clrlwi            5, 5, 16
        nop
0:
        sthcx.            5, 0, 6
        bt                2, 2f
        lharx             3, 0, 6
        cmplw             3, 4
        bt                2, 0b
1:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
2:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u16::seqcst_seqcst:
        mr                6, 3
        lharx             3, 0, 3
        clrlwi            4, 4, 16
        cmplw             3, 4
        bf                2, 1f
        sync
        clrlwi            5, 5, 16
        nop
0:
        sthcx.            5, 0, 6
        bt                2, 2f
        lharx             3, 0, 6
        cmplw             3, 4
        bt                2, 0b
1:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
2:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u16::acqrel_acquire:
        mr                6, 3
        lharx             3, 0, 3
        clrlwi            4, 4, 16
        cmplw             3, 4
        bf                2, 1f
        lwsync
        clrlwi            5, 5, 16
        nop
0:
        sthcx.            5, 0, 6
        bt                2, 2f
        lharx             3, 0, 6
        cmplw             3, 4
        bt                2, 0b
1:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
2:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u16::acqrel_relaxed:
        mr                6, 3
        lharx             3, 0, 3
        clrlwi            4, 4, 16
        cmplw             3, 4
        bf                2, 1f
        lwsync
        clrlwi            5, 5, 16
        nop
0:
        sthcx.            5, 0, 6
        bt                2, 2f
        lharx             3, 0, 6
        cmplw             3, 4
        bt                2, 0b
1:
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
2:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u16::acquire_seqcst:
        mr                6, 3
        clrlwi            5, 5, 16
        clrlwi            4, 4, 16
        nop
        nop
        nop
        nop
        nop
0:
        lharx             3, 0, 6
        cmplw             3, 4
        bf                2, 1f
        sthcx.            5, 0, 6
        bf                2, 0b
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u16::relaxed_seqcst:
        mr                6, 3
        clrlwi            5, 5, 16
        clrlwi            4, 4, 16
        nop
        nop
        nop
        nop
        nop
0:
        lharx             3, 0, 6
        cmplw             3, 4
        bf                2, 1f
        sthcx.            5, 0, 6
        bf                2, 0b
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u16::release_seqcst:
        mr                6, 3
        lharx             3, 0, 3
        clrlwi            4, 4, 16
        cmplw             3, 4
        bf                2, 1f
        lwsync
        clrlwi            5, 5, 16
        nop
0:
        sthcx.            5, 0, 6
        bt                2, 2f
        lharx             3, 0, 6
        cmplw             3, 4
        bt                2, 0b
1:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
2:
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u16::seqcst_acquire:
        mr                6, 3
        lharx             3, 0, 3
        clrlwi            4, 4, 16
        cmplw             3, 4
        bf                2, 1f
        sync
        clrlwi            5, 5, 16
        nop
0:
        sthcx.            5, 0, 6
        bt                2, 2f
        lharx             3, 0, 6
        cmplw             3, 4
        bt                2, 0b
1:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
2:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u16::seqcst_relaxed:
        mr                6, 3
        lharx             3, 0, 3
        clrlwi            4, 4, 16
        cmplw             3, 4
        bf                2, 1f
        sync
        clrlwi            5, 5, 16
        nop
0:
        sthcx.            5, 0, 6
        bt                2, 2f
        lharx             3, 0, 6
        cmplw             3, 4
        bt                2, 0b
1:
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
2:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u16::acquire_acquire:
        mr                6, 3
        clrlwi            5, 5, 16
        clrlwi            4, 4, 16
        nop
        nop
        nop
        nop
        nop
0:
        lharx             3, 0, 6
        cmplw             3, 4
        bf                2, 1f
        sthcx.            5, 0, 6
        bf                2, 0b
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u16::acquire_relaxed:
        mr                6, 3
        clrlwi            5, 5, 16
        clrlwi            4, 4, 16
        nop
        nop
        nop
        nop
        nop
0:
        lharx             3, 0, 6
        cmplw             3, 4
        bf                2, 1f
        sthcx.            5, 0, 6
        bf                2, 0b
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u16::relaxed_acquire:
        mr                6, 3
        clrlwi            5, 5, 16
        clrlwi            4, 4, 16
        nop
        nop
        nop
        nop
        nop
0:
        lharx             3, 0, 6
        cmplw             3, 4
        bf                2, 1f
        sthcx.            5, 0, 6
        bf                2, 0b
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u16::relaxed_relaxed:
        mr                6, 3
        clrlwi            5, 5, 16
        clrlwi            4, 4, 16
        nop
        nop
        nop
        nop
        nop
0:
        lharx             3, 0, 6
        cmplw             3, 4
        bf                2, 1f
        sthcx.            5, 0, 6
        bf                2, 0b
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u16::release_acquire:
        mr                6, 3
        lharx             3, 0, 3
        clrlwi            4, 4, 16
        cmplw             3, 4
        bf                2, 1f
        lwsync
        clrlwi            5, 5, 16
        nop
0:
        sthcx.            5, 0, 6
        bt                2, 2f
        lharx             3, 0, 6
        cmplw             3, 4
        bt                2, 0b
1:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
2:
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u16::release_relaxed:
        mr                6, 3
        lharx             3, 0, 3
        clrlwi            4, 4, 16
        cmplw             3, 4
        bf                2, 1f
        lwsync
        clrlwi            5, 5, 16
        nop
0:
        sthcx.            5, 0, 6
        bt                2, 2f
        lharx             3, 0, 6
        cmplw             3, 4
        bt                2, 0b
1:
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
2:
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u32::acqrel_seqcst:
        mr                6, 3
        lwarx             3, 0, 3
        cmplw             3, 4
        bf                2, 1f
        lwsync
        nop
        nop
        nop
0:
        stwcx.            5, 0, 6
        bt                2, 2f
        lwarx             3, 0, 6
        cmplw             3, 4
        bt                2, 0b
1:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
2:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u32::seqcst_seqcst:
        mr                6, 3
        lwarx             3, 0, 3
        cmplw             3, 4
        bf                2, 1f
        sync
        nop
        nop
        nop
0:
        stwcx.            5, 0, 6
        bt                2, 2f
        lwarx             3, 0, 6
        cmplw             3, 4
        bt                2, 0b
1:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
2:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u32::acqrel_acquire:
        mr                6, 3
        lwarx             3, 0, 3
        cmplw             3, 4
        bf                2, 1f
        lwsync
        nop
        nop
        nop
0:
        stwcx.            5, 0, 6
        bt                2, 2f
        lwarx             3, 0, 6
        cmplw             3, 4
        bt                2, 0b
1:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
2:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u32::acqrel_relaxed:
        mr                6, 3
        lwarx             3, 0, 3
        cmplw             3, 4
        bf                2, 1f
        lwsync
        nop
        nop
        nop
0:
        stwcx.            5, 0, 6
        bt                2, 2f
        lwarx             3, 0, 6
        cmplw             3, 4
        bt                2, 0b
1:
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
2:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u32::acquire_seqcst:
        mr                6, 3
        nop
        nop
        nop
        nop
        nop
        nop
        nop
0:
        lwarx             3, 0, 6
        cmplw             3, 4
        bf                2, 1f
        stwcx.            5, 0, 6
        bf                2, 0b
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u32::relaxed_seqcst:
        mr                6, 3
        nop
        nop
        nop
        nop
        nop
        nop
        nop
0:
        lwarx             3, 0, 6
        cmplw             3, 4
        bf                2, 1f
        stwcx.            5, 0, 6
        bf                2, 0b
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u32::release_seqcst:
        mr                6, 3
        lwarx             3, 0, 3
        cmplw             3, 4
        bf                2, 1f
        lwsync
        nop
        nop
        nop
0:
        stwcx.            5, 0, 6
        bt                2, 2f
        lwarx             3, 0, 6
        cmplw             3, 4
        bt                2, 0b
1:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
2:
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u32::seqcst_acquire:
        mr                6, 3
        lwarx             3, 0, 3
        cmplw             3, 4
        bf                2, 1f
        sync
        nop
        nop
        nop
0:
        stwcx.            5, 0, 6
        bt                2, 2f
        lwarx             3, 0, 6
        cmplw             3, 4
        bt                2, 0b
1:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
2:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u32::seqcst_relaxed:
        mr                6, 3
        lwarx             3, 0, 3
        cmplw             3, 4
        bf                2, 1f
        sync
        nop
        nop
        nop
0:
        stwcx.            5, 0, 6
        bt                2, 2f
        lwarx             3, 0, 6
        cmplw             3, 4
        bt                2, 0b
1:
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
2:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u32::acquire_acquire:
        mr                6, 3
        nop
        nop
        nop
        nop
        nop
        nop
        nop
0:
        lwarx             3, 0, 6
        cmplw             3, 4
        bf                2, 1f
        stwcx.            5, 0, 6
        bf                2, 0b
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u32::acquire_relaxed:
        mr                6, 3
        nop
        nop
        nop
        nop
        nop
        nop
        nop
0:
        lwarx             3, 0, 6
        cmplw             3, 4
        bf                2, 1f
        stwcx.            5, 0, 6
        bf                2, 0b
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u32::relaxed_acquire:
        mr                6, 3
        nop
        nop
        nop
        nop
        nop
        nop
        nop
0:
        lwarx             3, 0, 6
        cmplw             3, 4
        bf                2, 1f
        stwcx.            5, 0, 6
        bf                2, 0b
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u32::relaxed_relaxed:
        mr                6, 3
        nop
        nop
        nop
        nop
        nop
        nop
        nop
0:
        lwarx             3, 0, 6
        cmplw             3, 4
        bf                2, 1f
        stwcx.            5, 0, 6
        bf                2, 0b
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u32::release_acquire:
        mr                6, 3
        lwarx             3, 0, 3
        cmplw             3, 4
        bf                2, 1f
        lwsync
        nop
        nop
        nop
0:
        stwcx.            5, 0, 6
        bt                2, 2f
        lwarx             3, 0, 6
        cmplw             3, 4
        bt                2, 0b
1:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
2:
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u32::release_relaxed:
        mr                6, 3
        lwarx             3, 0, 3
        cmplw             3, 4
        bf                2, 1f
        lwsync
        nop
        nop
        nop
0:
        stwcx.            5, 0, 6
        bt                2, 2f
        lwarx             3, 0, 6
        cmplw             3, 4
        bt                2, 0b
1:
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
2:
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u64::acqrel_seqcst:
        mr                6, 3
        ldarx             3, 0, 3
        cmpld             3, 4
        bf                2, 1f
        lwsync
        nop
        nop
        nop
0:
        stdcx.            5, 0, 6
        bt                2, 2f
        ldarx             3, 0, 6
        cmpld             3, 4
        bt                2, 0b
1:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
2:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u64::seqcst_seqcst:
        mr                6, 3
        ldarx             3, 0, 3
        cmpld             3, 4
        bf                2, 1f
        sync
        nop
        nop
        nop
0:
        stdcx.            5, 0, 6
        bt                2, 2f
        ldarx             3, 0, 6
        cmpld             3, 4
        bt                2, 0b
1:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
2:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u64::acqrel_acquire:
        mr                6, 3
        ldarx             3, 0, 3
        cmpld             3, 4
        bf                2, 1f
        lwsync
        nop
        nop
        nop
0:
        stdcx.            5, 0, 6
        bt                2, 2f
        ldarx             3, 0, 6
        cmpld             3, 4
        bt                2, 0b
1:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
2:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u64::acqrel_relaxed:
        mr                6, 3
        ldarx             3, 0, 3
        cmpld             3, 4
        bf                2, 1f
        lwsync
        nop
        nop
        nop
0:
        stdcx.            5, 0, 6
        bt                2, 2f
        ldarx             3, 0, 6
        cmpld             3, 4
        bt                2, 0b
1:
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
2:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u64::acquire_seqcst:
        mr                6, 3
        nop
        nop
        nop
        nop
        nop
        nop
        nop
0:
        ldarx             3, 0, 6
        cmpld             3, 4
        bf                2, 1f
        stdcx.            5, 0, 6
        bf                2, 0b
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u64::relaxed_seqcst:
        mr                6, 3
        nop
        nop
        nop
        nop
        nop
        nop
        nop
0:
        ldarx             3, 0, 6
        cmpld             3, 4
        bf                2, 1f
        stdcx.            5, 0, 6
        bf                2, 0b
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u64::release_seqcst:
        mr                6, 3
        ldarx             3, 0, 3
        cmpld             3, 4
        bf                2, 1f
        lwsync
        nop
        nop
        nop
0:
        stdcx.            5, 0, 6
        bt                2, 2f
        ldarx             3, 0, 6
        cmpld             3, 4
        bt                2, 0b
1:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
2:
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u64::seqcst_acquire:
        mr                6, 3
        ldarx             3, 0, 3
        cmpld             3, 4
        bf                2, 1f
        sync
        nop
        nop
        nop
0:
        stdcx.            5, 0, 6
        bt                2, 2f
        ldarx             3, 0, 6
        cmpld             3, 4
        bt                2, 0b
1:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
2:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u64::seqcst_relaxed:
        mr                6, 3
        ldarx             3, 0, 3
        cmpld             3, 4
        bf                2, 1f
        sync
        nop
        nop
        nop
0:
        stdcx.            5, 0, 6
        bt                2, 2f
        ldarx             3, 0, 6
        cmpld             3, 4
        bt                2, 0b
1:
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
2:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u64::acquire_acquire:
        mr                6, 3
        nop
        nop
        nop
        nop
        nop
        nop
        nop
0:
        ldarx             3, 0, 6
        cmpld             3, 4
        bf                2, 1f
        stdcx.            5, 0, 6
        bf                2, 0b
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u64::acquire_relaxed:
        mr                6, 3
        nop
        nop
        nop
        nop
        nop
        nop
        nop
0:
        ldarx             3, 0, 6
        cmpld             3, 4
        bf                2, 1f
        stdcx.            5, 0, 6
        bf                2, 0b
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u64::relaxed_acquire:
        mr                6, 3
        nop
        nop
        nop
        nop
        nop
        nop
        nop
0:
        ldarx             3, 0, 6
        cmpld             3, 4
        bf                2, 1f
        stdcx.            5, 0, 6
        bf                2, 0b
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u64::relaxed_relaxed:
        mr                6, 3
        nop
        nop
        nop
        nop
        nop
        nop
        nop
0:
        ldarx             3, 0, 6
        cmpld             3, 4
        bf                2, 1f
        stdcx.            5, 0, 6
        bf                2, 0b
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u64::release_acquire:
        mr                6, 3
        ldarx             3, 0, 3
        cmpld             3, 4
        bf                2, 1f
        lwsync
        nop
        nop
        nop
0:
        stdcx.            5, 0, 6
        bt                2, 2f
        ldarx             3, 0, 6
        cmpld             3, 4
        bt                2, 0b
1:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
2:
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u64::release_relaxed:
        mr                6, 3
        ldarx             3, 0, 3
        cmpld             3, 4
        bf                2, 1f
        lwsync
        nop
        nop
        nop
0:
        stdcx.            5, 0, 6
        bt                2, 2f
        ldarx             3, 0, 6
        cmpld             3, 4
        bt                2, 0b
1:
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
2:
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u128::acqrel_seqcst:
        std               28, -32(1)
        std               29, -24(1)
        sync
0:
        lqarx             10, 0, 4
        xor               29, 11, 5
        xor               28, 10, 6
        or.               29, 29, 28
        bf                2, 1f
        mr                29, 7
        mr                28, 8
        stqcx.            28, 0, 4
        bf                2, 0b
1:
        lwsync
        ld                29, -24(1)
        ld                28, -32(1)
        xor               4, 6, 10
        xor               5, 5, 11
        std               10, 8(3)
        std               11, 0(3)
        or                4, 5, 4
        cntlzd            4, 4
        rldicl            4, 4, 58, 63
        stb               4, 16(3)
        blr

asm_test::compare_exchange::u128::seqcst_seqcst:
        std               28, -32(1)
        std               29, -24(1)
        sync
0:
        lqarx             10, 0, 4
        xor               29, 11, 5
        xor               28, 10, 6
        or.               29, 29, 28
        bf                2, 1f
        mr                29, 7
        mr                28, 8
        stqcx.            28, 0, 4
        bf                2, 0b
1:
        lwsync
        ld                29, -24(1)
        ld                28, -32(1)
        xor               4, 6, 10
        xor               5, 5, 11
        std               10, 8(3)
        std               11, 0(3)
        or                4, 5, 4
        cntlzd            4, 4
        rldicl            4, 4, 58, 63
        stb               4, 16(3)
        blr

asm_test::compare_exchange::u128::acqrel_acquire:
        std               28, -32(1)
        std               29, -24(1)
        lwsync
0:
        lqarx             10, 0, 4
        xor               29, 11, 5
        xor               28, 10, 6
        or.               29, 29, 28
        bf                2, 1f
        mr                29, 7
        mr                28, 8
        stqcx.            28, 0, 4
        bf                2, 0b
1:
        lwsync
        ld                29, -24(1)
        ld                28, -32(1)
        xor               4, 6, 10
        xor               5, 5, 11
        std               10, 8(3)
        std               11, 0(3)
        or                4, 5, 4
        cntlzd            4, 4
        rldicl            4, 4, 58, 63
        stb               4, 16(3)
        blr

asm_test::compare_exchange::u128::acqrel_relaxed:
        std               28, -32(1)
        std               29, -24(1)
        lwsync
0:
        lqarx             10, 0, 4
        xor               29, 11, 5
        xor               28, 10, 6
        or.               29, 29, 28
        bf                2, 1f
        mr                29, 7
        mr                28, 8
        stqcx.            28, 0, 4
        bf                2, 0b
1:
        lwsync
        ld                29, -24(1)
        ld                28, -32(1)
        xor               4, 6, 10
        xor               5, 5, 11
        std               10, 8(3)
        std               11, 0(3)
        or                4, 5, 4
        cntlzd            4, 4
        rldicl            4, 4, 58, 63
        stb               4, 16(3)
        blr

asm_test::compare_exchange::u128::acquire_seqcst:
        std               28, -32(1)
        std               29, -24(1)
        sync
0:
        lqarx             10, 0, 4
        xor               29, 11, 5
        xor               28, 10, 6
        or.               29, 29, 28
        bf                2, 1f
        mr                29, 7
        mr                28, 8
        stqcx.            28, 0, 4
        bf                2, 0b
1:
        lwsync
        ld                29, -24(1)
        ld                28, -32(1)
        xor               4, 6, 10
        xor               5, 5, 11
        std               10, 8(3)
        std               11, 0(3)
        or                4, 5, 4
        cntlzd            4, 4
        rldicl            4, 4, 58, 63
        stb               4, 16(3)
        blr

asm_test::compare_exchange::u128::relaxed_seqcst:
        std               28, -32(1)
        std               29, -24(1)
        sync
0:
        lqarx             10, 0, 4
        xor               29, 11, 5
        xor               28, 10, 6
        or.               29, 29, 28
        bf                2, 1f
        mr                29, 7
        mr                28, 8
        stqcx.            28, 0, 4
        bf                2, 0b
1:
        lwsync
        ld                29, -24(1)
        ld                28, -32(1)
        xor               4, 6, 10
        xor               5, 5, 11
        std               10, 8(3)
        std               11, 0(3)
        or                4, 5, 4
        cntlzd            4, 4
        rldicl            4, 4, 58, 63
        stb               4, 16(3)
        blr

asm_test::compare_exchange::u128::release_seqcst:
        std               28, -32(1)
        std               29, -24(1)
        sync
0:
        lqarx             10, 0, 4
        xor               29, 11, 5
        xor               28, 10, 6
        or.               29, 29, 28
        bf                2, 1f
        mr                29, 7
        mr                28, 8
        stqcx.            28, 0, 4
        bf                2, 0b
1:
        lwsync
        ld                29, -24(1)
        ld                28, -32(1)
        xor               4, 6, 10
        xor               5, 5, 11
        std               10, 8(3)
        std               11, 0(3)
        or                4, 5, 4
        cntlzd            4, 4
        rldicl            4, 4, 58, 63
        stb               4, 16(3)
        blr

asm_test::compare_exchange::u128::seqcst_acquire:
        std               28, -32(1)
        std               29, -24(1)
        sync
0:
        lqarx             10, 0, 4
        xor               29, 11, 5
        xor               28, 10, 6
        or.               29, 29, 28
        bf                2, 1f
        mr                29, 7
        mr                28, 8
        stqcx.            28, 0, 4
        bf                2, 0b
1:
        lwsync
        ld                29, -24(1)
        ld                28, -32(1)
        xor               4, 6, 10
        xor               5, 5, 11
        std               10, 8(3)
        std               11, 0(3)
        or                4, 5, 4
        cntlzd            4, 4
        rldicl            4, 4, 58, 63
        stb               4, 16(3)
        blr

asm_test::compare_exchange::u128::seqcst_relaxed:
        std               28, -32(1)
        std               29, -24(1)
        sync
0:
        lqarx             10, 0, 4
        xor               29, 11, 5
        xor               28, 10, 6
        or.               29, 29, 28
        bf                2, 1f
        mr                29, 7
        mr                28, 8
        stqcx.            28, 0, 4
        bf                2, 0b
1:
        lwsync
        ld                29, -24(1)
        ld                28, -32(1)
        xor               4, 6, 10
        xor               5, 5, 11
        std               10, 8(3)
        std               11, 0(3)
        or                4, 5, 4
        cntlzd            4, 4
        rldicl            4, 4, 58, 63
        stb               4, 16(3)
        blr

asm_test::compare_exchange::u128::acquire_acquire:
        std               28, -32(1)
        std               29, -24(1)
0:
        lqarx             10, 0, 4
        xor               29, 11, 5
        xor               28, 10, 6
        or.               29, 29, 28
        bf                2, 1f
        mr                29, 7
        mr                28, 8
        stqcx.            28, 0, 4
        bf                2, 0b
1:
        lwsync
        ld                29, -24(1)
        ld                28, -32(1)
        xor               4, 6, 10
        xor               5, 5, 11
        std               10, 8(3)
        std               11, 0(3)
        or                4, 5, 4
        cntlzd            4, 4
        rldicl            4, 4, 58, 63
        stb               4, 16(3)
        blr

asm_test::compare_exchange::u128::acquire_relaxed:
        std               28, -32(1)
        std               29, -24(1)
0:
        lqarx             10, 0, 4
        xor               29, 11, 5
        xor               28, 10, 6
        or.               29, 29, 28
        bf                2, 1f
        mr                29, 7
        mr                28, 8
        stqcx.            28, 0, 4
        bf                2, 0b
1:
        lwsync
        ld                29, -24(1)
        ld                28, -32(1)
        xor               4, 6, 10
        xor               5, 5, 11
        std               10, 8(3)
        std               11, 0(3)
        or                4, 5, 4
        cntlzd            4, 4
        rldicl            4, 4, 58, 63
        stb               4, 16(3)
        blr

asm_test::compare_exchange::u128::relaxed_acquire:
        std               28, -32(1)
        std               29, -24(1)
0:
        lqarx             10, 0, 4
        xor               29, 11, 5
        xor               28, 10, 6
        or.               29, 29, 28
        bf                2, 1f
        mr                29, 7
        mr                28, 8
        stqcx.            28, 0, 4
        bf                2, 0b
1:
        lwsync
        ld                29, -24(1)
        ld                28, -32(1)
        xor               4, 6, 10
        xor               5, 5, 11
        std               10, 8(3)
        std               11, 0(3)
        or                4, 5, 4
        cntlzd            4, 4
        rldicl            4, 4, 58, 63
        stb               4, 16(3)
        blr

asm_test::compare_exchange::u128::relaxed_relaxed:
        std               28, -32(1)
        std               29, -24(1)
0:
        lqarx             10, 0, 4
        xor               29, 11, 5
        xor               28, 10, 6
        or.               29, 29, 28
        bf                2, 1f
        mr                29, 7
        mr                28, 8
        stqcx.            28, 0, 4
        bf                2, 0b
1:
        ld                29, -24(1)
        ld                28, -32(1)
        xor               4, 6, 10
        xor               5, 5, 11
        std               10, 8(3)
        std               11, 0(3)
        or                4, 5, 4
        cntlzd            4, 4
        rldicl            4, 4, 58, 63
        stb               4, 16(3)
        blr

asm_test::compare_exchange::u128::release_acquire:
        std               28, -32(1)
        std               29, -24(1)
        lwsync
0:
        lqarx             10, 0, 4
        xor               29, 11, 5
        xor               28, 10, 6
        or.               29, 29, 28
        bf                2, 1f
        mr                29, 7
        mr                28, 8
        stqcx.            28, 0, 4
        bf                2, 0b
1:
        lwsync
        ld                29, -24(1)
        ld                28, -32(1)
        xor               4, 6, 10
        xor               5, 5, 11
        std               10, 8(3)
        std               11, 0(3)
        or                4, 5, 4
        cntlzd            4, 4
        rldicl            4, 4, 58, 63
        stb               4, 16(3)
        blr

asm_test::compare_exchange::u128::release_relaxed:
        std               28, -32(1)
        std               29, -24(1)
        lwsync
0:
        lqarx             10, 0, 4
        xor               29, 11, 5
        xor               28, 10, 6
        or.               29, 29, 28
        bf                2, 1f
        mr                29, 7
        mr                28, 8
        stqcx.            28, 0, 4
        bf                2, 0b
1:
        ld                29, -24(1)
        ld                28, -32(1)
        xor               4, 6, 10
        xor               5, 5, 11
        std               10, 8(3)
        std               11, 0(3)
        or                4, 5, 4
        cntlzd            4, 4
        rldicl            4, 4, 58, 63
        stb               4, 16(3)
        blr

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        mr                6, 3
        lbarx             3, 0, 3
        clrlwi            4, 4, 24
        cmplw             3, 4
        bf                2, 0f
        clrlwi            4, 5, 24
        lwsync
        stbcx.            4, 0, 6
        bt                2, 1f
0:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        mr                6, 3
        lbarx             3, 0, 3
        clrlwi            4, 4, 24
        cmplw             3, 4
        bf                2, 0f
        clrlwi            4, 5, 24
        sync
        stbcx.            4, 0, 6
        bt                2, 1f
0:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        mr                6, 3
        lbarx             3, 0, 3
        clrlwi            4, 4, 24
        cmplw             3, 4
        bf                2, 0f
        clrlwi            4, 5, 24
        lwsync
        stbcx.            4, 0, 6
        bt                2, 1f
0:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        mr                6, 3
        lbarx             3, 0, 3
        clrlwi            4, 4, 24
        crclr             20
        cmplw             3, 4
        bf                2, 0f
        clrlwi            4, 5, 24
        lwsync
        stbcx.            4, 0, 6
        bt                2, 1f
0:
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        mr                6, 3
        lbarx             3, 0, 3
        clrlwi            4, 4, 24
        cmplw             3, 4
        bf                2, 0f
        clrlwi            4, 5, 24
        stbcx.            4, 0, 6
        bt                2, 1f
0:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        mr                6, 3
        lbarx             3, 0, 3
        clrlwi            4, 4, 24
        cmplw             3, 4
        bf                2, 0f
        clrlwi            4, 5, 24
        stbcx.            4, 0, 6
        bt                2, 1f
0:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u8::release_seqcst:
        mr                6, 3
        lbarx             3, 0, 3
        clrlwi            4, 4, 24
        cmplw             3, 4
        bf                2, 0f
        clrlwi            4, 5, 24
        lwsync
        stbcx.            4, 0, 6
        bt                2, 1f
0:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        mr                6, 3
        lbarx             3, 0, 3
        clrlwi            4, 4, 24
        cmplw             3, 4
        bf                2, 0f
        clrlwi            4, 5, 24
        sync
        stbcx.            4, 0, 6
        bt                2, 1f
0:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        mr                6, 3
        lbarx             3, 0, 3
        clrlwi            4, 4, 24
        crclr             20
        cmplw             3, 4
        bf                2, 0f
        clrlwi            4, 5, 24
        sync
        stbcx.            4, 0, 6
        bt                2, 1f
0:
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u8::acquire_acquire:
        mr                6, 3
        lbarx             3, 0, 3
        clrlwi            4, 4, 24
        cmplw             3, 4
        bf                2, 0f
        clrlwi            4, 5, 24
        stbcx.            4, 0, 6
        bt                2, 1f
0:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        mr                6, 3
        lbarx             3, 0, 3
        clrlwi            4, 4, 24
        crclr             20
        cmplw             3, 4
        bf                2, 0f
        clrlwi            4, 5, 24
        stbcx.            4, 0, 6
        bt                2, 1f
0:
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        mr                6, 3
        lbarx             3, 0, 3
        clrlwi            4, 4, 24
        cmplw             3, 4
        bf                2, 0f
        clrlwi            4, 5, 24
        stbcx.            4, 0, 6
        bt                2, 1f
0:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        mr                6, 3
        lbarx             3, 0, 3
        clrlwi            4, 4, 24
        cmplw             3, 4
        bf                2, 0f
        clrlwi            4, 5, 24
        stbcx.            4, 0, 6
        bt                2, 1f
0:
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u8::release_acquire:
        mr                6, 3
        lbarx             3, 0, 3
        clrlwi            4, 4, 24
        cmplw             3, 4
        bf                2, 0f
        clrlwi            4, 5, 24
        lwsync
        stbcx.            4, 0, 6
        bt                2, 1f
0:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u8::release_relaxed:
        mr                6, 3
        lbarx             3, 0, 3
        clrlwi            4, 4, 24
        cmplw             3, 4
        bf                2, 0f
        clrlwi            4, 5, 24
        lwsync
        stbcx.            4, 0, 6
        bt                2, 1f
0:
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        mr                6, 3
        lharx             3, 0, 3
        clrlwi            4, 4, 16
        cmplw             3, 4
        bf                2, 0f
        clrlwi            4, 5, 16
        lwsync
        sthcx.            4, 0, 6
        bt                2, 1f
0:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        mr                6, 3
        lharx             3, 0, 3
        clrlwi            4, 4, 16
        cmplw             3, 4
        bf                2, 0f
        clrlwi            4, 5, 16
        sync
        sthcx.            4, 0, 6
        bt                2, 1f
0:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        mr                6, 3
        lharx             3, 0, 3
        clrlwi            4, 4, 16
        cmplw             3, 4
        bf                2, 0f
        clrlwi            4, 5, 16
        lwsync
        sthcx.            4, 0, 6
        bt                2, 1f
0:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        mr                6, 3
        lharx             3, 0, 3
        clrlwi            4, 4, 16
        crclr             20
        cmplw             3, 4
        bf                2, 0f
        clrlwi            4, 5, 16
        lwsync
        sthcx.            4, 0, 6
        bt                2, 1f
0:
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        mr                6, 3
        lharx             3, 0, 3
        clrlwi            4, 4, 16
        cmplw             3, 4
        bf                2, 0f
        clrlwi            4, 5, 16
        sthcx.            4, 0, 6
        bt                2, 1f
0:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        mr                6, 3
        lharx             3, 0, 3
        clrlwi            4, 4, 16
        cmplw             3, 4
        bf                2, 0f
        clrlwi            4, 5, 16
        sthcx.            4, 0, 6
        bt                2, 1f
0:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u16::release_seqcst:
        mr                6, 3
        lharx             3, 0, 3
        clrlwi            4, 4, 16
        cmplw             3, 4
        bf                2, 0f
        clrlwi            4, 5, 16
        lwsync
        sthcx.            4, 0, 6
        bt                2, 1f
0:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        mr                6, 3
        lharx             3, 0, 3
        clrlwi            4, 4, 16
        cmplw             3, 4
        bf                2, 0f
        clrlwi            4, 5, 16
        sync
        sthcx.            4, 0, 6
        bt                2, 1f
0:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        mr                6, 3
        lharx             3, 0, 3
        clrlwi            4, 4, 16
        crclr             20
        cmplw             3, 4
        bf                2, 0f
        clrlwi            4, 5, 16
        sync
        sthcx.            4, 0, 6
        bt                2, 1f
0:
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u16::acquire_acquire:
        mr                6, 3
        lharx             3, 0, 3
        clrlwi            4, 4, 16
        cmplw             3, 4
        bf                2, 0f
        clrlwi            4, 5, 16
        sthcx.            4, 0, 6
        bt                2, 1f
0:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        mr                6, 3
        lharx             3, 0, 3
        clrlwi            4, 4, 16
        crclr             20
        cmplw             3, 4
        bf                2, 0f
        clrlwi            4, 5, 16
        sthcx.            4, 0, 6
        bt                2, 1f
0:
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        mr                6, 3
        lharx             3, 0, 3
        clrlwi            4, 4, 16
        cmplw             3, 4
        bf                2, 0f
        clrlwi            4, 5, 16
        sthcx.            4, 0, 6
        bt                2, 1f
0:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        mr                6, 3
        lharx             3, 0, 3
        clrlwi            4, 4, 16
        cmplw             3, 4
        bf                2, 0f
        clrlwi            4, 5, 16
        sthcx.            4, 0, 6
        bt                2, 1f
0:
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u16::release_acquire:
        mr                6, 3
        lharx             3, 0, 3
        clrlwi            4, 4, 16
        cmplw             3, 4
        bf                2, 0f
        clrlwi            4, 5, 16
        lwsync
        sthcx.            4, 0, 6
        bt                2, 1f
0:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u16::release_relaxed:
        mr                6, 3
        lharx             3, 0, 3
        clrlwi            4, 4, 16
        cmplw             3, 4
        bf                2, 0f
        clrlwi            4, 5, 16
        lwsync
        sthcx.            4, 0, 6
        bt                2, 1f
0:
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        mr                6, 3
        lwarx             3, 0, 3
        cmplw             3, 4
        bf                2, 0f
        lwsync
        stwcx.            5, 0, 6
        bt                2, 1f
0:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        mr                6, 3
        lwarx             3, 0, 3
        cmplw             3, 4
        bf                2, 0f
        sync
        stwcx.            5, 0, 6
        bt                2, 1f
0:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        mr                6, 3
        lwarx             3, 0, 3
        cmplw             3, 4
        bf                2, 0f
        lwsync
        stwcx.            5, 0, 6
        bt                2, 1f
0:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        mr                6, 3
        lwarx             3, 0, 3
        crclr             20
        cmplw             3, 4
        bf                2, 0f
        lwsync
        stwcx.            5, 0, 6
        bt                2, 1f
0:
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        mr                6, 3
        lwarx             3, 0, 3
        cmplw             3, 4
        bf                2, 0f
        stwcx.            5, 0, 6
        bt                2, 1f
0:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        mr                6, 3
        lwarx             3, 0, 3
        cmplw             3, 4
        bf                2, 0f
        stwcx.            5, 0, 6
        bt                2, 1f
0:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u32::release_seqcst:
        mr                6, 3
        lwarx             3, 0, 3
        cmplw             3, 4
        bf                2, 0f
        lwsync
        stwcx.            5, 0, 6
        bt                2, 1f
0:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        mr                6, 3
        lwarx             3, 0, 3
        cmplw             3, 4
        bf                2, 0f
        sync
        stwcx.            5, 0, 6
        bt                2, 1f
0:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        mr                6, 3
        lwarx             3, 0, 3
        crclr             20
        cmplw             3, 4
        bf                2, 0f
        sync
        stwcx.            5, 0, 6
        bt                2, 1f
0:
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u32::acquire_acquire:
        mr                6, 3
        lwarx             3, 0, 3
        cmplw             3, 4
        bf                2, 0f
        stwcx.            5, 0, 6
        bt                2, 1f
0:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        mr                6, 3
        lwarx             3, 0, 3
        crclr             20
        cmplw             3, 4
        bf                2, 0f
        stwcx.            5, 0, 6
        bt                2, 1f
0:
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        mr                6, 3
        lwarx             3, 0, 3
        cmplw             3, 4
        bf                2, 0f
        stwcx.            5, 0, 6
        bt                2, 1f
0:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        mr                6, 3
        lwarx             3, 0, 3
        cmplw             3, 4
        bf                2, 0f
        stwcx.            5, 0, 6
        bt                2, 1f
0:
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u32::release_acquire:
        mr                6, 3
        lwarx             3, 0, 3
        cmplw             3, 4
        bf                2, 0f
        lwsync
        stwcx.            5, 0, 6
        bt                2, 1f
0:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u32::release_relaxed:
        mr                6, 3
        lwarx             3, 0, 3
        cmplw             3, 4
        bf                2, 0f
        lwsync
        stwcx.            5, 0, 6
        bt                2, 1f
0:
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u64::acqrel_seqcst:
        mr                6, 3
        ldarx             3, 0, 3
        cmpld             3, 4
        bf                2, 0f
        lwsync
        stdcx.            5, 0, 6
        bt                2, 1f
0:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u64::seqcst_seqcst:
        mr                6, 3
        ldarx             3, 0, 3
        cmpld             3, 4
        bf                2, 0f
        sync
        stdcx.            5, 0, 6
        bt                2, 1f
0:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u64::acqrel_acquire:
        mr                6, 3
        ldarx             3, 0, 3
        cmpld             3, 4
        bf                2, 0f
        lwsync
        stdcx.            5, 0, 6
        bt                2, 1f
0:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u64::acqrel_relaxed:
        mr                6, 3
        ldarx             3, 0, 3
        crclr             20
        cmpld             3, 4
        bf                2, 0f
        lwsync
        stdcx.            5, 0, 6
        bt                2, 1f
0:
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u64::acquire_seqcst:
        mr                6, 3
        ldarx             3, 0, 3
        cmpld             3, 4
        bf                2, 0f
        stdcx.            5, 0, 6
        bt                2, 1f
0:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u64::relaxed_seqcst:
        mr                6, 3
        ldarx             3, 0, 3
        cmpld             3, 4
        bf                2, 0f
        stdcx.            5, 0, 6
        bt                2, 1f
0:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u64::release_seqcst:
        mr                6, 3
        ldarx             3, 0, 3
        cmpld             3, 4
        bf                2, 0f
        lwsync
        stdcx.            5, 0, 6
        bt                2, 1f
0:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u64::seqcst_acquire:
        mr                6, 3
        ldarx             3, 0, 3
        cmpld             3, 4
        bf                2, 0f
        sync
        stdcx.            5, 0, 6
        bt                2, 1f
0:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u64::seqcst_relaxed:
        mr                6, 3
        ldarx             3, 0, 3
        crclr             20
        cmpld             3, 4
        bf                2, 0f
        sync
        stdcx.            5, 0, 6
        bt                2, 1f
0:
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u64::acquire_acquire:
        mr                6, 3
        ldarx             3, 0, 3
        cmpld             3, 4
        bf                2, 0f
        stdcx.            5, 0, 6
        bt                2, 1f
0:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u64::acquire_relaxed:
        mr                6, 3
        ldarx             3, 0, 3
        crclr             20
        cmpld             3, 4
        bf                2, 0f
        stdcx.            5, 0, 6
        bt                2, 1f
0:
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u64::relaxed_acquire:
        mr                6, 3
        ldarx             3, 0, 3
        cmpld             3, 4
        bf                2, 0f
        stdcx.            5, 0, 6
        bt                2, 1f
0:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u64::relaxed_relaxed:
        mr                6, 3
        ldarx             3, 0, 3
        cmpld             3, 4
        bf                2, 0f
        stdcx.            5, 0, 6
        bt                2, 1f
0:
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u64::release_acquire:
        mr                6, 3
        ldarx             3, 0, 3
        cmpld             3, 4
        bf                2, 0f
        lwsync
        stdcx.            5, 0, 6
        bt                2, 1f
0:
        lwsync
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u64::release_relaxed:
        mr                6, 3
        ldarx             3, 0, 3
        cmpld             3, 4
        bf                2, 0f
        lwsync
        stdcx.            5, 0, 6
        bt                2, 1f
0:
        crclr             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u128::acqrel_seqcst:
        std               28, -32(1)
        std               29, -24(1)
        sync
0:
        lqarx             10, 0, 4
        xor               29, 11, 5
        xor               28, 10, 6
        or.               29, 29, 28
        bf                2, 1f
        mr                29, 7
        mr                28, 8
        stqcx.            28, 0, 4
        bf                2, 0b
1:
        lwsync
        ld                29, -24(1)
        ld                28, -32(1)
        xor               4, 6, 10
        xor               5, 5, 11
        std               10, 8(3)
        std               11, 0(3)
        or                4, 5, 4
        cntlzd            4, 4
        rldicl            4, 4, 58, 63
        stb               4, 16(3)
        blr

asm_test::compare_exchange_weak::u128::seqcst_seqcst:
        std               28, -32(1)
        std               29, -24(1)
        sync
0:
        lqarx             10, 0, 4
        xor               29, 11, 5
        xor               28, 10, 6
        or.               29, 29, 28
        bf                2, 1f
        mr                29, 7
        mr                28, 8
        stqcx.            28, 0, 4
        bf                2, 0b
1:
        lwsync
        ld                29, -24(1)
        ld                28, -32(1)
        xor               4, 6, 10
        xor               5, 5, 11
        std               10, 8(3)
        std               11, 0(3)
        or                4, 5, 4
        cntlzd            4, 4
        rldicl            4, 4, 58, 63
        stb               4, 16(3)
        blr

asm_test::compare_exchange_weak::u128::acqrel_acquire:
        std               28, -32(1)
        std               29, -24(1)
        lwsync
0:
        lqarx             10, 0, 4
        xor               29, 11, 5
        xor               28, 10, 6
        or.               29, 29, 28
        bf                2, 1f
        mr                29, 7
        mr                28, 8
        stqcx.            28, 0, 4
        bf                2, 0b
1:
        lwsync
        ld                29, -24(1)
        ld                28, -32(1)
        xor               4, 6, 10
        xor               5, 5, 11
        std               10, 8(3)
        std               11, 0(3)
        or                4, 5, 4
        cntlzd            4, 4
        rldicl            4, 4, 58, 63
        stb               4, 16(3)
        blr

asm_test::compare_exchange_weak::u128::acqrel_relaxed:
        std               28, -32(1)
        std               29, -24(1)
        lwsync
0:
        lqarx             10, 0, 4
        xor               29, 11, 5
        xor               28, 10, 6
        or.               29, 29, 28
        bf                2, 1f
        mr                29, 7
        mr                28, 8
        stqcx.            28, 0, 4
        bf                2, 0b
1:
        lwsync
        ld                29, -24(1)
        ld                28, -32(1)
        xor               4, 6, 10
        xor               5, 5, 11
        std               10, 8(3)
        std               11, 0(3)
        or                4, 5, 4
        cntlzd            4, 4
        rldicl            4, 4, 58, 63
        stb               4, 16(3)
        blr

asm_test::compare_exchange_weak::u128::acquire_seqcst:
        std               28, -32(1)
        std               29, -24(1)
        sync
0:
        lqarx             10, 0, 4
        xor               29, 11, 5
        xor               28, 10, 6
        or.               29, 29, 28
        bf                2, 1f
        mr                29, 7
        mr                28, 8
        stqcx.            28, 0, 4
        bf                2, 0b
1:
        lwsync
        ld                29, -24(1)
        ld                28, -32(1)
        xor               4, 6, 10
        xor               5, 5, 11
        std               10, 8(3)
        std               11, 0(3)
        or                4, 5, 4
        cntlzd            4, 4
        rldicl            4, 4, 58, 63
        stb               4, 16(3)
        blr

asm_test::compare_exchange_weak::u128::relaxed_seqcst:
        std               28, -32(1)
        std               29, -24(1)
        sync
0:
        lqarx             10, 0, 4
        xor               29, 11, 5
        xor               28, 10, 6
        or.               29, 29, 28
        bf                2, 1f
        mr                29, 7
        mr                28, 8
        stqcx.            28, 0, 4
        bf                2, 0b
1:
        lwsync
        ld                29, -24(1)
        ld                28, -32(1)
        xor               4, 6, 10
        xor               5, 5, 11
        std               10, 8(3)
        std               11, 0(3)
        or                4, 5, 4
        cntlzd            4, 4
        rldicl            4, 4, 58, 63
        stb               4, 16(3)
        blr

asm_test::compare_exchange_weak::u128::release_seqcst:
        std               28, -32(1)
        std               29, -24(1)
        sync
0:
        lqarx             10, 0, 4
        xor               29, 11, 5
        xor               28, 10, 6
        or.               29, 29, 28
        bf                2, 1f
        mr                29, 7
        mr                28, 8
        stqcx.            28, 0, 4
        bf                2, 0b
1:
        lwsync
        ld                29, -24(1)
        ld                28, -32(1)
        xor               4, 6, 10
        xor               5, 5, 11
        std               10, 8(3)
        std               11, 0(3)
        or                4, 5, 4
        cntlzd            4, 4
        rldicl            4, 4, 58, 63
        stb               4, 16(3)
        blr

asm_test::compare_exchange_weak::u128::seqcst_acquire:
        std               28, -32(1)
        std               29, -24(1)
        sync
0:
        lqarx             10, 0, 4
        xor               29, 11, 5
        xor               28, 10, 6
        or.               29, 29, 28
        bf                2, 1f
        mr                29, 7
        mr                28, 8
        stqcx.            28, 0, 4
        bf                2, 0b
1:
        lwsync
        ld                29, -24(1)
        ld                28, -32(1)
        xor               4, 6, 10
        xor               5, 5, 11
        std               10, 8(3)
        std               11, 0(3)
        or                4, 5, 4
        cntlzd            4, 4
        rldicl            4, 4, 58, 63
        stb               4, 16(3)
        blr

asm_test::compare_exchange_weak::u128::seqcst_relaxed:
        std               28, -32(1)
        std               29, -24(1)
        sync
0:
        lqarx             10, 0, 4
        xor               29, 11, 5
        xor               28, 10, 6
        or.               29, 29, 28
        bf                2, 1f
        mr                29, 7
        mr                28, 8
        stqcx.            28, 0, 4
        bf                2, 0b
1:
        lwsync
        ld                29, -24(1)
        ld                28, -32(1)
        xor               4, 6, 10
        xor               5, 5, 11
        std               10, 8(3)
        std               11, 0(3)
        or                4, 5, 4
        cntlzd            4, 4
        rldicl            4, 4, 58, 63
        stb               4, 16(3)
        blr

asm_test::compare_exchange_weak::u128::acquire_acquire:
        std               28, -32(1)
        std               29, -24(1)
0:
        lqarx             10, 0, 4
        xor               29, 11, 5
        xor               28, 10, 6
        or.               29, 29, 28
        bf                2, 1f
        mr                29, 7
        mr                28, 8
        stqcx.            28, 0, 4
        bf                2, 0b
1:
        lwsync
        ld                29, -24(1)
        ld                28, -32(1)
        xor               4, 6, 10
        xor               5, 5, 11
        std               10, 8(3)
        std               11, 0(3)
        or                4, 5, 4
        cntlzd            4, 4
        rldicl            4, 4, 58, 63
        stb               4, 16(3)
        blr

asm_test::compare_exchange_weak::u128::acquire_relaxed:
        std               28, -32(1)
        std               29, -24(1)
0:
        lqarx             10, 0, 4
        xor               29, 11, 5
        xor               28, 10, 6
        or.               29, 29, 28
        bf                2, 1f
        mr                29, 7
        mr                28, 8
        stqcx.            28, 0, 4
        bf                2, 0b
1:
        lwsync
        ld                29, -24(1)
        ld                28, -32(1)
        xor               4, 6, 10
        xor               5, 5, 11
        std               10, 8(3)
        std               11, 0(3)
        or                4, 5, 4
        cntlzd            4, 4
        rldicl            4, 4, 58, 63
        stb               4, 16(3)
        blr

asm_test::compare_exchange_weak::u128::relaxed_acquire:
        std               28, -32(1)
        std               29, -24(1)
0:
        lqarx             10, 0, 4
        xor               29, 11, 5
        xor               28, 10, 6
        or.               29, 29, 28
        bf                2, 1f
        mr                29, 7
        mr                28, 8
        stqcx.            28, 0, 4
        bf                2, 0b
1:
        lwsync
        ld                29, -24(1)
        ld                28, -32(1)
        xor               4, 6, 10
        xor               5, 5, 11
        std               10, 8(3)
        std               11, 0(3)
        or                4, 5, 4
        cntlzd            4, 4
        rldicl            4, 4, 58, 63
        stb               4, 16(3)
        blr

asm_test::compare_exchange_weak::u128::relaxed_relaxed:
        std               28, -32(1)
        std               29, -24(1)
0:
        lqarx             10, 0, 4
        xor               29, 11, 5
        xor               28, 10, 6
        or.               29, 29, 28
        bf                2, 1f
        mr                29, 7
        mr                28, 8
        stqcx.            28, 0, 4
        bf                2, 0b
1:
        ld                29, -24(1)
        ld                28, -32(1)
        xor               4, 6, 10
        xor               5, 5, 11
        std               10, 8(3)
        std               11, 0(3)
        or                4, 5, 4
        cntlzd            4, 4
        rldicl            4, 4, 58, 63
        stb               4, 16(3)
        blr

asm_test::compare_exchange_weak::u128::release_acquire:
        std               28, -32(1)
        std               29, -24(1)
        lwsync
0:
        lqarx             10, 0, 4
        xor               29, 11, 5
        xor               28, 10, 6
        or.               29, 29, 28
        bf                2, 1f
        mr                29, 7
        mr                28, 8
        stqcx.            28, 0, 4
        bf                2, 0b
1:
        lwsync
        ld                29, -24(1)
        ld                28, -32(1)
        xor               4, 6, 10
        xor               5, 5, 11
        std               10, 8(3)
        std               11, 0(3)
        or                4, 5, 4
        cntlzd            4, 4
        rldicl            4, 4, 58, 63
        stb               4, 16(3)
        blr

asm_test::compare_exchange_weak::u128::release_relaxed:
        std               28, -32(1)
        std               29, -24(1)
        lwsync
0:
        lqarx             10, 0, 4
        xor               29, 11, 5
        xor               28, 10, 6
        or.               29, 29, 28
        bf                2, 1f
        mr                29, 7
        mr                28, 8
        stqcx.            28, 0, 4
        bf                2, 0b
1:
        ld                29, -24(1)
        ld                28, -32(1)
        xor               4, 6, 10
        xor               5, 5, 11
        std               10, 8(3)
        std               11, 0(3)
        or                4, 5, 4
        cntlzd            4, 4
        rldicl            4, 4, 58, 63
        stb               4, 16(3)
        blr

asm_test::load::u8::seqcst:
        sync
        lbz               3, 0(3)
        cmpd              7, 3, 3
        bf-               30, 0f
0:
        isync
        blr

asm_test::load::u8::acquire:
        lbz               3, 0(3)
        cmpd              7, 3, 3
        bf-               30, 0f
0:
        isync
        blr

asm_test::load::u8::relaxed:
        lbz               3, 0(3)
        blr

asm_test::load::u16::seqcst:
        sync
        lhz               3, 0(3)
        cmpd              7, 3, 3
        bf-               30, 0f
0:
        isync
        blr

asm_test::load::u16::acquire:
        lhz               3, 0(3)
        cmpd              7, 3, 3
        bf-               30, 0f
0:
        isync
        blr

asm_test::load::u16::relaxed:
        lhz               3, 0(3)
        blr

asm_test::load::u32::seqcst:
        sync
        lwz               3, 0(3)
        cmpd              7, 3, 3
        bf-               30, 0f
0:
        isync
        blr

asm_test::load::u32::acquire:
        lwz               3, 0(3)
        cmpd              7, 3, 3
        bf-               30, 0f
0:
        isync
        blr

asm_test::load::u32::relaxed:
        lwz               3, 0(3)
        blr

asm_test::load::u64::seqcst:
        sync
        ld                3, 0(3)
        cmpd              7, 3, 3
        bf-               30, 0f
0:
        isync
        blr

asm_test::load::u64::acquire:
        ld                3, 0(3)
        cmpd              7, 3, 3
        bf-               30, 0f
0:
        isync
        blr

asm_test::load::u64::relaxed:
        ld                3, 0(3)
        blr

asm_test::load::u128::seqcst:
        sync
        lq                4, 0(3)
        cmpd              7, 5, 5
        mr                3, 5
        bf-               30, 0f
0:
        isync
        blr

asm_test::load::u128::acquire:
        lq                4, 0(3)
        cmpd              7, 5, 5
        mr                3, 5
        bf-               30, 0f
0:
        isync
        blr

asm_test::load::u128::relaxed:
        lq                4, 0(3)
        mr                3, 5
        blr

asm_test::swap::u8::acqrel:
        lwsync
0:
        lbarx             5, 0, 3
        stbcx.            4, 0, 3
        bf                2, 0b
        lwsync
        mr                3, 5
        blr

asm_test::swap::u8::seqcst:
        sync
0:
        lbarx             5, 0, 3
        stbcx.            4, 0, 3
        bf                2, 0b
        lwsync
        mr                3, 5
        blr

asm_test::swap::u8::acquire:
        mr                5, 3
0:
        lbarx             3, 0, 5
        stbcx.            4, 0, 5
        bf                2, 0b
        lwsync
        blr

asm_test::swap::u8::relaxed:
0:
        lbarx             5, 0, 3
        stbcx.            4, 0, 3
        bf                2, 0b
        mr                3, 5
        blr

asm_test::swap::u8::release:
        lwsync
0:
        lbarx             5, 0, 3
        stbcx.            4, 0, 3
        bf                2, 0b
        mr                3, 5
        blr

asm_test::swap::u16::acqrel:
        lwsync
0:
        lharx             5, 0, 3
        sthcx.            4, 0, 3
        bf                2, 0b
        lwsync
        mr                3, 5
        blr

asm_test::swap::u16::seqcst:
        sync
0:
        lharx             5, 0, 3
        sthcx.            4, 0, 3
        bf                2, 0b
        lwsync
        mr                3, 5
        blr

asm_test::swap::u16::acquire:
        mr                5, 3
0:
        lharx             3, 0, 5
        sthcx.            4, 0, 5
        bf                2, 0b
        lwsync
        blr

asm_test::swap::u16::relaxed:
0:
        lharx             5, 0, 3
        sthcx.            4, 0, 3
        bf                2, 0b
        mr                3, 5
        blr

asm_test::swap::u16::release:
        lwsync
0:
        lharx             5, 0, 3
        sthcx.            4, 0, 3
        bf                2, 0b
        mr                3, 5
        blr

asm_test::swap::u32::acqrel:
        lwsync
0:
        lwarx             5, 0, 3
        stwcx.            4, 0, 3
        bf                2, 0b
        lwsync
        mr                3, 5
        blr

asm_test::swap::u32::seqcst:
        sync
0:
        lwarx             5, 0, 3
        stwcx.            4, 0, 3
        bf                2, 0b
        lwsync
        mr                3, 5
        blr

asm_test::swap::u32::acquire:
        mr                5, 3
0:
        lwarx             3, 0, 5
        stwcx.            4, 0, 5
        bf                2, 0b
        lwsync
        blr

asm_test::swap::u32::relaxed:
0:
        lwarx             5, 0, 3
        stwcx.            4, 0, 3
        bf                2, 0b
        mr                3, 5
        blr

asm_test::swap::u32::release:
        lwsync
0:
        lwarx             5, 0, 3
        stwcx.            4, 0, 3
        bf                2, 0b
        mr                3, 5
        blr

asm_test::swap::u64::acqrel:
        lwsync
0:
        ldarx             5, 0, 3
        stdcx.            4, 0, 3
        bf                2, 0b
        lwsync
        mr                3, 5
        blr

asm_test::swap::u64::seqcst:
        sync
0:
        ldarx             5, 0, 3
        stdcx.            4, 0, 3
        bf                2, 0b
        lwsync
        mr                3, 5
        blr

asm_test::swap::u64::acquire:
        mr                5, 3
0:
        ldarx             3, 0, 5
        stdcx.            4, 0, 5
        bf                2, 0b
        lwsync
        blr

asm_test::swap::u64::relaxed:
0:
        ldarx             5, 0, 3
        stdcx.            4, 0, 3
        bf                2, 0b
        mr                3, 5
        blr

asm_test::swap::u64::release:
        lwsync
0:
        ldarx             5, 0, 3
        stdcx.            4, 0, 3
        bf                2, 0b
        mr                3, 5
        blr

asm_test::swap::u128::acqrel:
        lwsync
0:
        lqarx             6, 0, 3
        mr                9, 4
        mr                8, 5
        stqcx.            8, 0, 3
        bf                2, 0b
        lwsync
        mr                3, 7
        mr                4, 6
        blr

asm_test::swap::u128::seqcst:
        sync
0:
        lqarx             6, 0, 3
        mr                9, 4
        mr                8, 5
        stqcx.            8, 0, 3
        bf                2, 0b
        lwsync
        mr                3, 7
        mr                4, 6
        blr

asm_test::swap::u128::acquire:
0:
        lqarx             6, 0, 3
        mr                9, 4
        mr                8, 5
        stqcx.            8, 0, 3
        bf                2, 0b
        lwsync
        mr                3, 7
        mr                4, 6
        blr

asm_test::swap::u128::relaxed:
0:
        lqarx             6, 0, 3
        mr                9, 4
        mr                8, 5
        stqcx.            8, 0, 3
        bf                2, 0b
        mr                3, 7
        mr                4, 6
        blr

asm_test::swap::u128::release:
        lwsync
0:
        lqarx             6, 0, 3
        mr                9, 4
        mr                8, 5
        stqcx.            8, 0, 3
        bf                2, 0b
        mr                3, 7
        mr                4, 6
        blr

asm_test::store::u8::seqcst:
        sync
        stb               4, 0(3)
        blr

asm_test::store::u8::relaxed:
        stb               4, 0(3)
        blr

asm_test::store::u8::release:
        lwsync
        stb               4, 0(3)
        blr

asm_test::store::u16::seqcst:
        sync
        sth               4, 0(3)
        blr

asm_test::store::u16::relaxed:
        sth               4, 0(3)
        blr

asm_test::store::u16::release:
        lwsync
        sth               4, 0(3)
        blr

asm_test::store::u32::seqcst:
        sync
        stw               4, 0(3)
        blr

asm_test::store::u32::relaxed:
        stw               4, 0(3)
        blr

asm_test::store::u32::release:
        lwsync
        stw               4, 0(3)
        blr

asm_test::store::u64::seqcst:
        sync
        std               4, 0(3)
        blr

asm_test::store::u64::relaxed:
        std               4, 0(3)
        blr

asm_test::store::u64::release:
        lwsync
        std               4, 0(3)
        blr

asm_test::store::u128::seqcst:
        sync
        xor               4, 4, 5
        xor               5, 4, 5
        xor               4, 4, 5
        stq               4, 0(3)
        blr

asm_test::store::u128::relaxed:
        xor               4, 4, 5
        xor               5, 4, 5
        xor               4, 4, 5
        stq               4, 0(3)
        blr

asm_test::store::u128::release:
        lwsync
        xor               4, 4, 5
        xor               5, 4, 5
        xor               4, 4, 5
        stq               4, 0(3)
        blr

