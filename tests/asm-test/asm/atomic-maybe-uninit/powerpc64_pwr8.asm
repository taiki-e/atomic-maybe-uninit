asm_test::compare_exchange::u8::acqrel_seqcst:
        clrlwi            4, 4, 24
        sync
0:
        lbarx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        stbcx.            5, 0, 3
        bf                2, 0b
1:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u8::seqcst_seqcst:
        clrlwi            4, 4, 24
        sync
0:
        lbarx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        stbcx.            5, 0, 3
        bf                2, 0b
1:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u8::acqrel_acquire:
        clrlwi            4, 4, 24
        lwsync
0:
        lbarx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        stbcx.            5, 0, 3
        bf                2, 0b
1:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u8::acqrel_relaxed:
        clrlwi            4, 4, 24
        lwsync
0:
        lbarx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        stbcx.            5, 0, 3
        bf                2, 0b
        isync
1:
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u8::acquire_seqcst:
        clrlwi            4, 4, 24
        sync
0:
        lbarx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        stbcx.            5, 0, 3
        bf                2, 0b
1:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u8::relaxed_seqcst:
        clrlwi            4, 4, 24
        sync
0:
        lbarx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        stbcx.            5, 0, 3
        bf                2, 0b
1:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u8::release_seqcst:
        clrlwi            4, 4, 24
        sync
0:
        lbarx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        stbcx.            5, 0, 3
        bf                2, 0b
1:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u8::seqcst_acquire:
        clrlwi            4, 4, 24
        sync
0:
        lbarx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        stbcx.            5, 0, 3
        bf                2, 0b
1:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u8::seqcst_relaxed:
        clrlwi            4, 4, 24
        sync
0:
        lbarx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        stbcx.            5, 0, 3
        bf                2, 0b
        isync
1:
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u8::acquire_acquire:
        clrlwi            4, 4, 24
0:
        lbarx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        stbcx.            5, 0, 3
        bf                2, 0b
1:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u8::acquire_relaxed:
        clrlwi            4, 4, 24
0:
        lbarx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        stbcx.            5, 0, 3
        bf                2, 0b
        isync
1:
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u8::relaxed_acquire:
        clrlwi            4, 4, 24
0:
        lbarx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        stbcx.            5, 0, 3
        bf                2, 0b
1:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u8::relaxed_relaxed:
        clrlwi            4, 4, 24
0:
        lbarx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        stbcx.            5, 0, 3
        bf                2, 0b
1:
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u8::release_acquire:
        clrlwi            4, 4, 24
        lwsync
0:
        lbarx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        stbcx.            5, 0, 3
        bf                2, 0b
1:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u8::release_relaxed:
        clrlwi            4, 4, 24
        lwsync
0:
        lbarx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        stbcx.            5, 0, 3
        bf                2, 0b
1:
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u16::acqrel_seqcst:
        clrlwi            4, 4, 16
        sync
0:
        lharx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        sthcx.            5, 0, 3
        bf                2, 0b
1:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u16::seqcst_seqcst:
        clrlwi            4, 4, 16
        sync
0:
        lharx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        sthcx.            5, 0, 3
        bf                2, 0b
1:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u16::acqrel_acquire:
        clrlwi            4, 4, 16
        lwsync
0:
        lharx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        sthcx.            5, 0, 3
        bf                2, 0b
1:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u16::acqrel_relaxed:
        clrlwi            4, 4, 16
        lwsync
0:
        lharx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        sthcx.            5, 0, 3
        bf                2, 0b
        isync
1:
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u16::acquire_seqcst:
        clrlwi            4, 4, 16
        sync
0:
        lharx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        sthcx.            5, 0, 3
        bf                2, 0b
1:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u16::relaxed_seqcst:
        clrlwi            4, 4, 16
        sync
0:
        lharx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        sthcx.            5, 0, 3
        bf                2, 0b
1:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u16::release_seqcst:
        clrlwi            4, 4, 16
        sync
0:
        lharx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        sthcx.            5, 0, 3
        bf                2, 0b
1:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u16::seqcst_acquire:
        clrlwi            4, 4, 16
        sync
0:
        lharx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        sthcx.            5, 0, 3
        bf                2, 0b
1:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u16::seqcst_relaxed:
        clrlwi            4, 4, 16
        sync
0:
        lharx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        sthcx.            5, 0, 3
        bf                2, 0b
        isync
1:
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u16::acquire_acquire:
        clrlwi            4, 4, 16
0:
        lharx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        sthcx.            5, 0, 3
        bf                2, 0b
1:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u16::acquire_relaxed:
        clrlwi            4, 4, 16
0:
        lharx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        sthcx.            5, 0, 3
        bf                2, 0b
        isync
1:
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u16::relaxed_acquire:
        clrlwi            4, 4, 16
0:
        lharx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        sthcx.            5, 0, 3
        bf                2, 0b
1:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u16::relaxed_relaxed:
        clrlwi            4, 4, 16
0:
        lharx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        sthcx.            5, 0, 3
        bf                2, 0b
1:
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u16::release_acquire:
        clrlwi            4, 4, 16
        lwsync
0:
        lharx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        sthcx.            5, 0, 3
        bf                2, 0b
1:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u16::release_relaxed:
        clrlwi            4, 4, 16
        lwsync
0:
        lharx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        sthcx.            5, 0, 3
        bf                2, 0b
1:
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u32::acqrel_seqcst:
        sync
0:
        lwarx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        stwcx.            5, 0, 3
        bf                2, 0b
1:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u32::seqcst_seqcst:
        sync
0:
        lwarx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        stwcx.            5, 0, 3
        bf                2, 0b
1:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u32::acqrel_acquire:
        lwsync
0:
        lwarx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        stwcx.            5, 0, 3
        bf                2, 0b
1:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u32::acqrel_relaxed:
        lwsync
0:
        lwarx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        stwcx.            5, 0, 3
        bf                2, 0b
        isync
1:
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u32::acquire_seqcst:
        sync
0:
        lwarx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        stwcx.            5, 0, 3
        bf                2, 0b
1:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u32::relaxed_seqcst:
        sync
0:
        lwarx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        stwcx.            5, 0, 3
        bf                2, 0b
1:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u32::release_seqcst:
        sync
0:
        lwarx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        stwcx.            5, 0, 3
        bf                2, 0b
1:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u32::seqcst_acquire:
        sync
0:
        lwarx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        stwcx.            5, 0, 3
        bf                2, 0b
1:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u32::seqcst_relaxed:
        sync
0:
        lwarx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        stwcx.            5, 0, 3
        bf                2, 0b
        isync
1:
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u32::acquire_acquire:
0:
        lwarx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        stwcx.            5, 0, 3
        bf                2, 0b
1:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u32::acquire_relaxed:
0:
        lwarx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        stwcx.            5, 0, 3
        bf                2, 0b
        isync
1:
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u32::relaxed_acquire:
0:
        lwarx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        stwcx.            5, 0, 3
        bf                2, 0b
1:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u32::relaxed_relaxed:
0:
        lwarx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        stwcx.            5, 0, 3
        bf                2, 0b
1:
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u32::release_acquire:
        lwsync
0:
        lwarx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        stwcx.            5, 0, 3
        bf                2, 0b
1:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u32::release_relaxed:
        lwsync
0:
        lwarx             6, 0, 3
        cmpw              4, 6
        bf                2, 1f
        stwcx.            5, 0, 3
        bf                2, 0b
1:
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u64::acqrel_seqcst:
        sync
0:
        ldarx             6, 0, 3
        cmpd              4, 6
        bf                2, 1f
        stdcx.            5, 0, 3
        bf                2, 0b
1:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u64::seqcst_seqcst:
        sync
0:
        ldarx             6, 0, 3
        cmpd              4, 6
        bf                2, 1f
        stdcx.            5, 0, 3
        bf                2, 0b
1:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u64::acqrel_acquire:
        lwsync
0:
        ldarx             6, 0, 3
        cmpd              4, 6
        bf                2, 1f
        stdcx.            5, 0, 3
        bf                2, 0b
1:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u64::acqrel_relaxed:
        lwsync
0:
        ldarx             6, 0, 3
        cmpd              4, 6
        bf                2, 1f
        stdcx.            5, 0, 3
        bf                2, 0b
        isync
1:
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u64::acquire_seqcst:
        sync
0:
        ldarx             6, 0, 3
        cmpd              4, 6
        bf                2, 1f
        stdcx.            5, 0, 3
        bf                2, 0b
1:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u64::relaxed_seqcst:
        sync
0:
        ldarx             6, 0, 3
        cmpd              4, 6
        bf                2, 1f
        stdcx.            5, 0, 3
        bf                2, 0b
1:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u64::release_seqcst:
        sync
0:
        ldarx             6, 0, 3
        cmpd              4, 6
        bf                2, 1f
        stdcx.            5, 0, 3
        bf                2, 0b
1:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u64::seqcst_acquire:
        sync
0:
        ldarx             6, 0, 3
        cmpd              4, 6
        bf                2, 1f
        stdcx.            5, 0, 3
        bf                2, 0b
1:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u64::seqcst_relaxed:
        sync
0:
        ldarx             6, 0, 3
        cmpd              4, 6
        bf                2, 1f
        stdcx.            5, 0, 3
        bf                2, 0b
        isync
1:
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u64::acquire_acquire:
0:
        ldarx             6, 0, 3
        cmpd              4, 6
        bf                2, 1f
        stdcx.            5, 0, 3
        bf                2, 0b
1:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u64::acquire_relaxed:
0:
        ldarx             6, 0, 3
        cmpd              4, 6
        bf                2, 1f
        stdcx.            5, 0, 3
        bf                2, 0b
        isync
1:
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u64::relaxed_acquire:
0:
        ldarx             6, 0, 3
        cmpd              4, 6
        bf                2, 1f
        stdcx.            5, 0, 3
        bf                2, 0b
1:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u64::relaxed_relaxed:
0:
        ldarx             6, 0, 3
        cmpd              4, 6
        bf                2, 1f
        stdcx.            5, 0, 3
        bf                2, 0b
1:
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u64::release_acquire:
        lwsync
0:
        ldarx             6, 0, 3
        cmpd              4, 6
        bf                2, 1f
        stdcx.            5, 0, 3
        bf                2, 0b
1:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u64::release_relaxed:
        lwsync
0:
        ldarx             6, 0, 3
        cmpd              4, 6
        bf                2, 1f
        stdcx.            5, 0, 3
        bf                2, 0b
1:
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange::u128::acqrel_seqcst:
        mr                9, 7
        mr                10, 6
        mr                7, 8
        mr                6, 9
        sync
0:
        lqarx             8, 0, 4
        xor               12, 9, 10
        xor               11, 8, 5
        or.               12, 12, 11
        bf                2, 1f
        stqcx.            6, 0, 4
        bf                2, 0b
1:
        isync
        mfcr              12
        rlwinm            4, 12, 3, 31, 31
        std               9, 8(3)
        std               8, 0(3)
        stb               4, 16(3)
        blr

asm_test::compare_exchange::u128::seqcst_seqcst:
        mr                9, 7
        mr                10, 6
        mr                7, 8
        mr                6, 9
        sync
0:
        lqarx             8, 0, 4
        xor               12, 9, 10
        xor               11, 8, 5
        or.               12, 12, 11
        bf                2, 1f
        stqcx.            6, 0, 4
        bf                2, 0b
1:
        isync
        mfcr              12
        rlwinm            4, 12, 3, 31, 31
        std               9, 8(3)
        std               8, 0(3)
        stb               4, 16(3)
        blr

asm_test::compare_exchange::u128::acqrel_acquire:
        mr                9, 7
        mr                10, 6
        mr                7, 8
        mr                6, 9
        lwsync
0:
        lqarx             8, 0, 4
        xor               12, 9, 10
        xor               11, 8, 5
        or.               12, 12, 11
        bf                2, 1f
        stqcx.            6, 0, 4
        bf                2, 0b
1:
        isync
        mfcr              12
        rlwinm            4, 12, 3, 31, 31
        std               9, 8(3)
        std               8, 0(3)
        stb               4, 16(3)
        blr

asm_test::compare_exchange::u128::acqrel_relaxed:
        mr                9, 7
        mr                10, 6
        mr                7, 8
        mr                6, 9
        lwsync
0:
        lqarx             8, 0, 4
        xor               12, 9, 10
        xor               11, 8, 5
        or.               12, 12, 11
        bf                2, 1f
        stqcx.            6, 0, 4
        bf                2, 0b
        isync
1:
        mfcr              12
        rlwinm            4, 12, 3, 31, 31
        std               9, 8(3)
        std               8, 0(3)
        stb               4, 16(3)
        blr

asm_test::compare_exchange::u128::acquire_seqcst:
        mr                9, 7
        mr                10, 6
        mr                7, 8
        mr                6, 9
        sync
0:
        lqarx             8, 0, 4
        xor               12, 9, 10
        xor               11, 8, 5
        or.               12, 12, 11
        bf                2, 1f
        stqcx.            6, 0, 4
        bf                2, 0b
1:
        isync
        mfcr              12
        rlwinm            4, 12, 3, 31, 31
        std               9, 8(3)
        std               8, 0(3)
        stb               4, 16(3)
        blr

asm_test::compare_exchange::u128::relaxed_seqcst:
        mr                9, 7
        mr                10, 6
        mr                7, 8
        mr                6, 9
        sync
0:
        lqarx             8, 0, 4
        xor               12, 9, 10
        xor               11, 8, 5
        or.               12, 12, 11
        bf                2, 1f
        stqcx.            6, 0, 4
        bf                2, 0b
1:
        isync
        mfcr              12
        rlwinm            4, 12, 3, 31, 31
        std               9, 8(3)
        std               8, 0(3)
        stb               4, 16(3)
        blr

asm_test::compare_exchange::u128::release_seqcst:
        mr                9, 7
        mr                10, 6
        mr                7, 8
        mr                6, 9
        sync
0:
        lqarx             8, 0, 4
        xor               12, 9, 10
        xor               11, 8, 5
        or.               12, 12, 11
        bf                2, 1f
        stqcx.            6, 0, 4
        bf                2, 0b
1:
        isync
        mfcr              12
        rlwinm            4, 12, 3, 31, 31
        std               9, 8(3)
        std               8, 0(3)
        stb               4, 16(3)
        blr

asm_test::compare_exchange::u128::seqcst_acquire:
        mr                9, 7
        mr                10, 6
        mr                7, 8
        mr                6, 9
        sync
0:
        lqarx             8, 0, 4
        xor               12, 9, 10
        xor               11, 8, 5
        or.               12, 12, 11
        bf                2, 1f
        stqcx.            6, 0, 4
        bf                2, 0b
1:
        isync
        mfcr              12
        rlwinm            4, 12, 3, 31, 31
        std               9, 8(3)
        std               8, 0(3)
        stb               4, 16(3)
        blr

asm_test::compare_exchange::u128::seqcst_relaxed:
        mr                9, 7
        mr                10, 6
        mr                7, 8
        mr                6, 9
        sync
0:
        lqarx             8, 0, 4
        xor               12, 9, 10
        xor               11, 8, 5
        or.               12, 12, 11
        bf                2, 1f
        stqcx.            6, 0, 4
        bf                2, 0b
        isync
1:
        mfcr              12
        rlwinm            4, 12, 3, 31, 31
        std               9, 8(3)
        std               8, 0(3)
        stb               4, 16(3)
        blr

asm_test::compare_exchange::u128::acquire_acquire:
        mr                9, 7
        mr                10, 6
        mr                7, 8
        mr                6, 9
0:
        lqarx             8, 0, 4
        xor               12, 9, 10
        xor               11, 8, 5
        or.               12, 12, 11
        bf                2, 1f
        stqcx.            6, 0, 4
        bf                2, 0b
1:
        isync
        mfcr              12
        rlwinm            4, 12, 3, 31, 31
        std               9, 8(3)
        std               8, 0(3)
        stb               4, 16(3)
        blr

asm_test::compare_exchange::u128::acquire_relaxed:
        mr                9, 7
        mr                10, 6
        mr                7, 8
        mr                6, 9
0:
        lqarx             8, 0, 4
        xor               12, 9, 10
        xor               11, 8, 5
        or.               12, 12, 11
        bf                2, 1f
        stqcx.            6, 0, 4
        bf                2, 0b
        isync
1:
        mfcr              12
        rlwinm            4, 12, 3, 31, 31
        std               9, 8(3)
        std               8, 0(3)
        stb               4, 16(3)
        blr

asm_test::compare_exchange::u128::relaxed_acquire:
        mr                9, 7
        mr                10, 6
        mr                7, 8
        mr                6, 9
0:
        lqarx             8, 0, 4
        xor               12, 9, 10
        xor               11, 8, 5
        or.               12, 12, 11
        bf                2, 1f
        stqcx.            6, 0, 4
        bf                2, 0b
1:
        isync
        mfcr              12
        rlwinm            4, 12, 3, 31, 31
        std               9, 8(3)
        std               8, 0(3)
        stb               4, 16(3)
        blr

asm_test::compare_exchange::u128::relaxed_relaxed:
        mr                9, 7
        mr                10, 6
        mr                7, 8
        mr                6, 9
0:
        lqarx             8, 0, 4
        xor               12, 9, 10
        xor               11, 8, 5
        or.               12, 12, 11
        bf                2, 1f
        stqcx.            6, 0, 4
        bf                2, 0b
1:
        mfcr              12
        rlwinm            4, 12, 3, 31, 31
        std               9, 8(3)
        std               8, 0(3)
        stb               4, 16(3)
        blr

asm_test::compare_exchange::u128::release_acquire:
        mr                9, 7
        mr                10, 6
        mr                7, 8
        mr                6, 9
        lwsync
0:
        lqarx             8, 0, 4
        xor               12, 9, 10
        xor               11, 8, 5
        or.               12, 12, 11
        bf                2, 1f
        stqcx.            6, 0, 4
        bf                2, 0b
1:
        isync
        mfcr              12
        rlwinm            4, 12, 3, 31, 31
        std               9, 8(3)
        std               8, 0(3)
        stb               4, 16(3)
        blr

asm_test::compare_exchange::u128::release_relaxed:
        mr                9, 7
        mr                10, 6
        mr                7, 8
        mr                6, 9
        lwsync
0:
        lqarx             8, 0, 4
        xor               12, 9, 10
        xor               11, 8, 5
        or.               12, 12, 11
        bf                2, 1f
        stqcx.            6, 0, 4
        bf                2, 0b
1:
        mfcr              12
        rlwinm            4, 12, 3, 31, 31
        std               9, 8(3)
        std               8, 0(3)
        stb               4, 16(3)
        blr

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        clrlwi            4, 4, 24
        sync
        lbarx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        stbcx.            5, 0, 3
0:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        clrlwi            4, 4, 24
        sync
        lbarx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        stbcx.            5, 0, 3
0:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        clrlwi            4, 4, 24
        lwsync
        lbarx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        stbcx.            5, 0, 3
0:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        clrlwi            4, 4, 24
        lwsync
        lbarx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        stbcx.            5, 0, 3
        isync
0:
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        clrlwi            4, 4, 24
        sync
        lbarx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        stbcx.            5, 0, 3
0:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        clrlwi            4, 4, 24
        sync
        lbarx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        stbcx.            5, 0, 3
0:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u8::release_seqcst:
        clrlwi            4, 4, 24
        sync
        lbarx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        stbcx.            5, 0, 3
0:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        clrlwi            4, 4, 24
        sync
        lbarx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        stbcx.            5, 0, 3
0:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        clrlwi            4, 4, 24
        sync
        lbarx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        stbcx.            5, 0, 3
        isync
0:
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u8::acquire_acquire:
        clrlwi            4, 4, 24
        lbarx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        stbcx.            5, 0, 3
0:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        clrlwi            4, 4, 24
        lbarx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        stbcx.            5, 0, 3
        isync
0:
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        clrlwi            4, 4, 24
        lbarx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        stbcx.            5, 0, 3
0:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        clrlwi            4, 4, 24
        lbarx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        stbcx.            5, 0, 3
0:
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u8::release_acquire:
        clrlwi            4, 4, 24
        lwsync
        lbarx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        stbcx.            5, 0, 3
0:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u8::release_relaxed:
        clrlwi            4, 4, 24
        lwsync
        lbarx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        stbcx.            5, 0, 3
0:
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        clrlwi            4, 4, 16
        sync
        lharx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        sthcx.            5, 0, 3
0:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        clrlwi            4, 4, 16
        sync
        lharx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        sthcx.            5, 0, 3
0:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        clrlwi            4, 4, 16
        lwsync
        lharx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        sthcx.            5, 0, 3
0:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        clrlwi            4, 4, 16
        lwsync
        lharx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        sthcx.            5, 0, 3
        isync
0:
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        clrlwi            4, 4, 16
        sync
        lharx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        sthcx.            5, 0, 3
0:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        clrlwi            4, 4, 16
        sync
        lharx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        sthcx.            5, 0, 3
0:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u16::release_seqcst:
        clrlwi            4, 4, 16
        sync
        lharx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        sthcx.            5, 0, 3
0:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        clrlwi            4, 4, 16
        sync
        lharx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        sthcx.            5, 0, 3
0:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        clrlwi            4, 4, 16
        sync
        lharx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        sthcx.            5, 0, 3
        isync
0:
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u16::acquire_acquire:
        clrlwi            4, 4, 16
        lharx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        sthcx.            5, 0, 3
0:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        clrlwi            4, 4, 16
        lharx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        sthcx.            5, 0, 3
        isync
0:
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        clrlwi            4, 4, 16
        lharx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        sthcx.            5, 0, 3
0:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        clrlwi            4, 4, 16
        lharx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        sthcx.            5, 0, 3
0:
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u16::release_acquire:
        clrlwi            4, 4, 16
        lwsync
        lharx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        sthcx.            5, 0, 3
0:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u16::release_relaxed:
        clrlwi            4, 4, 16
        lwsync
        lharx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        sthcx.            5, 0, 3
0:
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        sync
        lwarx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        stwcx.            5, 0, 3
0:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        sync
        lwarx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        stwcx.            5, 0, 3
0:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        lwsync
        lwarx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        stwcx.            5, 0, 3
0:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        lwsync
        lwarx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        stwcx.            5, 0, 3
        isync
0:
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        sync
        lwarx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        stwcx.            5, 0, 3
0:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        sync
        lwarx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        stwcx.            5, 0, 3
0:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u32::release_seqcst:
        sync
        lwarx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        stwcx.            5, 0, 3
0:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        sync
        lwarx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        stwcx.            5, 0, 3
0:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        sync
        lwarx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        stwcx.            5, 0, 3
        isync
0:
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u32::acquire_acquire:
        lwarx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        stwcx.            5, 0, 3
0:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        lwarx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        stwcx.            5, 0, 3
        isync
0:
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        lwarx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        stwcx.            5, 0, 3
0:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        lwarx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        stwcx.            5, 0, 3
0:
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u32::release_acquire:
        lwsync
        lwarx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        stwcx.            5, 0, 3
0:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u32::release_relaxed:
        lwsync
        lwarx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        stwcx.            5, 0, 3
0:
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u64::acqrel_seqcst:
        sync
        ldarx             6, 0, 3
        cmpd              4, 6
        bf                2, 0f
        stdcx.            5, 0, 3
0:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u64::seqcst_seqcst:
        sync
        ldarx             6, 0, 3
        cmpd              4, 6
        bf                2, 0f
        stdcx.            5, 0, 3
0:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u64::acqrel_acquire:
        lwsync
        ldarx             6, 0, 3
        cmpd              4, 6
        bf                2, 0f
        stdcx.            5, 0, 3
0:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u64::acqrel_relaxed:
        lwsync
        ldarx             6, 0, 3
        cmpd              4, 6
        bf                2, 0f
        stdcx.            5, 0, 3
        isync
0:
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u64::acquire_seqcst:
        sync
        ldarx             6, 0, 3
        cmpd              4, 6
        bf                2, 0f
        stdcx.            5, 0, 3
0:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u64::relaxed_seqcst:
        sync
        ldarx             6, 0, 3
        cmpd              4, 6
        bf                2, 0f
        stdcx.            5, 0, 3
0:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u64::release_seqcst:
        sync
        ldarx             6, 0, 3
        cmpd              4, 6
        bf                2, 0f
        stdcx.            5, 0, 3
0:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u64::seqcst_acquire:
        sync
        ldarx             6, 0, 3
        cmpd              4, 6
        bf                2, 0f
        stdcx.            5, 0, 3
0:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u64::seqcst_relaxed:
        sync
        ldarx             6, 0, 3
        cmpd              4, 6
        bf                2, 0f
        stdcx.            5, 0, 3
        isync
0:
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u64::acquire_acquire:
        ldarx             6, 0, 3
        cmpd              4, 6
        bf                2, 0f
        stdcx.            5, 0, 3
0:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u64::acquire_relaxed:
        ldarx             6, 0, 3
        cmpd              4, 6
        bf                2, 0f
        stdcx.            5, 0, 3
        isync
0:
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u64::relaxed_acquire:
        ldarx             6, 0, 3
        cmpd              4, 6
        bf                2, 0f
        stdcx.            5, 0, 3
0:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u64::relaxed_relaxed:
        ldarx             6, 0, 3
        cmpd              4, 6
        bf                2, 0f
        stdcx.            5, 0, 3
0:
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u64::release_acquire:
        lwsync
        ldarx             6, 0, 3
        cmpd              4, 6
        bf                2, 0f
        stdcx.            5, 0, 3
0:
        isync
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u64::release_relaxed:
        lwsync
        ldarx             6, 0, 3
        cmpd              4, 6
        bf                2, 0f
        stdcx.            5, 0, 3
0:
        mfcr              3
        rlwinm            4, 3, 3, 31, 31
        mr                3, 6
        blr

asm_test::compare_exchange_weak::u128::acqrel_seqcst:
        mr                9, 7
        mr                10, 6
        mr                7, 8
        mr                6, 9
        sync
        lqarx             8, 0, 4
        xor               12, 9, 10
        xor               11, 8, 5
        or.               12, 12, 11
        bf                2, 0f
        stqcx.            6, 0, 4
0:
        isync
        mfcr              12
        rlwinm            4, 12, 3, 31, 31
        std               9, 8(3)
        std               8, 0(3)
        stb               4, 16(3)
        blr

asm_test::compare_exchange_weak::u128::seqcst_seqcst:
        mr                9, 7
        mr                10, 6
        mr                7, 8
        mr                6, 9
        sync
        lqarx             8, 0, 4
        xor               12, 9, 10
        xor               11, 8, 5
        or.               12, 12, 11
        bf                2, 0f
        stqcx.            6, 0, 4
0:
        isync
        mfcr              12
        rlwinm            4, 12, 3, 31, 31
        std               9, 8(3)
        std               8, 0(3)
        stb               4, 16(3)
        blr

asm_test::compare_exchange_weak::u128::acqrel_acquire:
        mr                9, 7
        mr                10, 6
        mr                7, 8
        mr                6, 9
        lwsync
        lqarx             8, 0, 4
        xor               12, 9, 10
        xor               11, 8, 5
        or.               12, 12, 11
        bf                2, 0f
        stqcx.            6, 0, 4
0:
        isync
        mfcr              12
        rlwinm            4, 12, 3, 31, 31
        std               9, 8(3)
        std               8, 0(3)
        stb               4, 16(3)
        blr

asm_test::compare_exchange_weak::u128::acqrel_relaxed:
        mr                9, 7
        mr                10, 6
        mr                7, 8
        mr                6, 9
        lwsync
        lqarx             8, 0, 4
        xor               12, 9, 10
        xor               11, 8, 5
        or.               12, 12, 11
        bf                2, 0f
        stqcx.            6, 0, 4
        isync
0:
        mfcr              12
        rlwinm            4, 12, 3, 31, 31
        std               9, 8(3)
        std               8, 0(3)
        stb               4, 16(3)
        blr

asm_test::compare_exchange_weak::u128::acquire_seqcst:
        mr                9, 7
        mr                10, 6
        mr                7, 8
        mr                6, 9
        sync
        lqarx             8, 0, 4
        xor               12, 9, 10
        xor               11, 8, 5
        or.               12, 12, 11
        bf                2, 0f
        stqcx.            6, 0, 4
0:
        isync
        mfcr              12
        rlwinm            4, 12, 3, 31, 31
        std               9, 8(3)
        std               8, 0(3)
        stb               4, 16(3)
        blr

asm_test::compare_exchange_weak::u128::relaxed_seqcst:
        mr                9, 7
        mr                10, 6
        mr                7, 8
        mr                6, 9
        sync
        lqarx             8, 0, 4
        xor               12, 9, 10
        xor               11, 8, 5
        or.               12, 12, 11
        bf                2, 0f
        stqcx.            6, 0, 4
0:
        isync
        mfcr              12
        rlwinm            4, 12, 3, 31, 31
        std               9, 8(3)
        std               8, 0(3)
        stb               4, 16(3)
        blr

asm_test::compare_exchange_weak::u128::release_seqcst:
        mr                9, 7
        mr                10, 6
        mr                7, 8
        mr                6, 9
        sync
        lqarx             8, 0, 4
        xor               12, 9, 10
        xor               11, 8, 5
        or.               12, 12, 11
        bf                2, 0f
        stqcx.            6, 0, 4
0:
        isync
        mfcr              12
        rlwinm            4, 12, 3, 31, 31
        std               9, 8(3)
        std               8, 0(3)
        stb               4, 16(3)
        blr

asm_test::compare_exchange_weak::u128::seqcst_acquire:
        mr                9, 7
        mr                10, 6
        mr                7, 8
        mr                6, 9
        sync
        lqarx             8, 0, 4
        xor               12, 9, 10
        xor               11, 8, 5
        or.               12, 12, 11
        bf                2, 0f
        stqcx.            6, 0, 4
0:
        isync
        mfcr              12
        rlwinm            4, 12, 3, 31, 31
        std               9, 8(3)
        std               8, 0(3)
        stb               4, 16(3)
        blr

asm_test::compare_exchange_weak::u128::seqcst_relaxed:
        mr                9, 7
        mr                10, 6
        mr                7, 8
        mr                6, 9
        sync
        lqarx             8, 0, 4
        xor               12, 9, 10
        xor               11, 8, 5
        or.               12, 12, 11
        bf                2, 0f
        stqcx.            6, 0, 4
        isync
0:
        mfcr              12
        rlwinm            4, 12, 3, 31, 31
        std               9, 8(3)
        std               8, 0(3)
        stb               4, 16(3)
        blr

asm_test::compare_exchange_weak::u128::acquire_acquire:
        mr                9, 7
        mr                10, 6
        mr                7, 8
        mr                6, 9
        lqarx             8, 0, 4
        xor               12, 9, 10
        xor               11, 8, 5
        or.               12, 12, 11
        bf                2, 0f
        stqcx.            6, 0, 4
0:
        isync
        mfcr              12
        rlwinm            4, 12, 3, 31, 31
        std               9, 8(3)
        std               8, 0(3)
        stb               4, 16(3)
        blr

asm_test::compare_exchange_weak::u128::acquire_relaxed:
        mr                9, 7
        mr                10, 6
        mr                7, 8
        mr                6, 9
        lqarx             8, 0, 4
        xor               12, 9, 10
        xor               11, 8, 5
        or.               12, 12, 11
        bf                2, 0f
        stqcx.            6, 0, 4
        isync
0:
        mfcr              12
        rlwinm            4, 12, 3, 31, 31
        std               9, 8(3)
        std               8, 0(3)
        stb               4, 16(3)
        blr

asm_test::compare_exchange_weak::u128::relaxed_acquire:
        mr                9, 7
        mr                10, 6
        mr                7, 8
        mr                6, 9
        lqarx             8, 0, 4
        xor               12, 9, 10
        xor               11, 8, 5
        or.               12, 12, 11
        bf                2, 0f
        stqcx.            6, 0, 4
0:
        isync
        mfcr              12
        rlwinm            4, 12, 3, 31, 31
        std               9, 8(3)
        std               8, 0(3)
        stb               4, 16(3)
        blr

asm_test::compare_exchange_weak::u128::relaxed_relaxed:
        mr                9, 7
        mr                10, 6
        mr                7, 8
        mr                6, 9
        lqarx             8, 0, 4
        xor               12, 9, 10
        xor               11, 8, 5
        or.               12, 12, 11
        bf                2, 0f
        stqcx.            6, 0, 4
0:
        mfcr              12
        rlwinm            4, 12, 3, 31, 31
        std               9, 8(3)
        std               8, 0(3)
        stb               4, 16(3)
        blr

asm_test::compare_exchange_weak::u128::release_acquire:
        mr                9, 7
        mr                10, 6
        mr                7, 8
        mr                6, 9
        lwsync
        lqarx             8, 0, 4
        xor               12, 9, 10
        xor               11, 8, 5
        or.               12, 12, 11
        bf                2, 0f
        stqcx.            6, 0, 4
0:
        isync
        mfcr              12
        rlwinm            4, 12, 3, 31, 31
        std               9, 8(3)
        std               8, 0(3)
        stb               4, 16(3)
        blr

asm_test::compare_exchange_weak::u128::release_relaxed:
        mr                9, 7
        mr                10, 6
        mr                7, 8
        mr                6, 9
        lwsync
        lqarx             8, 0, 4
        xor               12, 9, 10
        xor               11, 8, 5
        or.               12, 12, 11
        bf                2, 0f
        stqcx.            6, 0, 4
0:
        mfcr              12
        rlwinm            4, 12, 3, 31, 31
        std               9, 8(3)
        std               8, 0(3)
        stb               4, 16(3)
        blr

asm_test::load::u8::seqcst:
        sync
        lbz               3, 0(3)
        cmpw              3, 3
        bf-               2, 0f
0:
        isync
        blr

asm_test::load::u8::acquire:
        lbz               3, 0(3)
        cmpw              3, 3
        bf-               2, 0f
0:
        isync
        blr

asm_test::load::u8::relaxed:
        lbz               3, 0(3)
        blr

asm_test::load::u16::seqcst:
        sync
        lhz               3, 0(3)
        cmpw              3, 3
        bf-               2, 0f
0:
        isync
        blr

asm_test::load::u16::acquire:
        lhz               3, 0(3)
        cmpw              3, 3
        bf-               2, 0f
0:
        isync
        blr

asm_test::load::u16::relaxed:
        lhz               3, 0(3)
        blr

asm_test::load::u32::seqcst:
        sync
        lwz               3, 0(3)
        cmpw              3, 3
        bf-               2, 0f
0:
        isync
        blr

asm_test::load::u32::acquire:
        lwz               3, 0(3)
        cmpw              3, 3
        bf-               2, 0f
0:
        isync
        blr

asm_test::load::u32::relaxed:
        lwz               3, 0(3)
        blr

asm_test::load::u64::seqcst:
        sync
        ld                3, 0(3)
        cmpw              3, 3
        bf-               2, 0f
0:
        isync
        blr

asm_test::load::u64::acquire:
        ld                3, 0(3)
        cmpw              3, 3
        bf-               2, 0f
0:
        isync
        blr

asm_test::load::u64::relaxed:
        ld                3, 0(3)
        blr

asm_test::load::u128::seqcst:
        sync
        lq                4, 0(3)
        cmpw              4, 4
        bf-               2, 0f
0:
        isync
        mr                3, 4
        mr                4, 5
        blr

asm_test::load::u128::acquire:
        lq                4, 0(3)
        cmpw              4, 4
        bf-               2, 0f
0:
        isync
        mr                3, 4
        mr                4, 5
        blr

asm_test::load::u128::relaxed:
        lq                4, 0(3)
        mr                3, 4
        mr                4, 5
        blr

asm_test::swap::u8::acqrel:
        lwsync
0:
        lbarx             5, 0, 3
        stbcx.            4, 0, 3
        bf                2, 0b
        isync
        mr                3, 5
        blr

asm_test::swap::u8::seqcst:
        sync
0:
        lbarx             5, 0, 3
        stbcx.            4, 0, 3
        bf                2, 0b
        isync
        mr                3, 5
        blr

asm_test::swap::u8::acquire:
0:
        lbarx             5, 0, 3
        stbcx.            4, 0, 3
        bf                2, 0b
        isync
        mr                3, 5
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
        isync
        mr                3, 5
        blr

asm_test::swap::u16::seqcst:
        sync
0:
        lharx             5, 0, 3
        sthcx.            4, 0, 3
        bf                2, 0b
        isync
        mr                3, 5
        blr

asm_test::swap::u16::acquire:
0:
        lharx             5, 0, 3
        sthcx.            4, 0, 3
        bf                2, 0b
        isync
        mr                3, 5
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
        isync
        mr                3, 5
        blr

asm_test::swap::u32::seqcst:
        sync
0:
        lwarx             5, 0, 3
        stwcx.            4, 0, 3
        bf                2, 0b
        isync
        mr                3, 5
        blr

asm_test::swap::u32::acquire:
0:
        lwarx             5, 0, 3
        stwcx.            4, 0, 3
        bf                2, 0b
        isync
        mr                3, 5
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
        isync
        mr                3, 5
        blr

asm_test::swap::u64::seqcst:
        sync
0:
        ldarx             5, 0, 3
        stdcx.            4, 0, 3
        bf                2, 0b
        isync
        mr                3, 5
        blr

asm_test::swap::u64::acquire:
0:
        ldarx             5, 0, 3
        stdcx.            4, 0, 3
        bf                2, 0b
        isync
        mr                3, 5
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
        mr                8, 4
        mr                9, 5
        lwsync
0:
        lqarx             6, 0, 3
        stqcx.            8, 0, 3
        bf                2, 0b
        isync
        mr                4, 7
        mr                3, 6
        blr

asm_test::swap::u128::seqcst:
        mr                8, 4
        mr                9, 5
        sync
0:
        lqarx             6, 0, 3
        stqcx.            8, 0, 3
        bf                2, 0b
        isync
        mr                4, 7
        mr                3, 6
        blr

asm_test::swap::u128::acquire:
        mr                8, 4
        mr                9, 5
0:
        lqarx             6, 0, 3
        stqcx.            8, 0, 3
        bf                2, 0b
        isync
        mr                4, 7
        mr                3, 6
        blr

asm_test::swap::u128::relaxed:
        mr                8, 4
        mr                9, 5
0:
        lqarx             6, 0, 3
        stqcx.            8, 0, 3
        bf                2, 0b
        mr                4, 7
        mr                3, 6
        blr

asm_test::swap::u128::release:
        mr                8, 4
        mr                9, 5
        lwsync
0:
        lqarx             6, 0, 3
        stqcx.            8, 0, 3
        bf                2, 0b
        mr                4, 7
        mr                3, 6
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
        stq               4, 0(3)
        blr

asm_test::store::u128::relaxed:
        stq               4, 0(3)
        blr

asm_test::store::u128::release:
        lwsync
        stq               4, 0(3)
        blr

