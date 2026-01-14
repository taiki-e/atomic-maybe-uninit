asm_test::compare_exchange::u8::acqrel_seqcst:
        not               7, 3
        li                6, 255
        rlwinm            7, 7, 3, 27, 28
        clrlwi            4, 4, 24
        clrlwi            5, 5, 24
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        sync
0:
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
        bf                2, 0b
1:
        isync
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u8::seqcst_seqcst:
        not               7, 3
        li                6, 255
        rlwinm            7, 7, 3, 27, 28
        clrlwi            4, 4, 24
        clrlwi            5, 5, 24
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        sync
0:
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
        bf                2, 0b
1:
        isync
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u8::acqrel_acquire:
        not               7, 3
        li                6, 255
        rlwinm            7, 7, 3, 27, 28
        clrlwi            4, 4, 24
        clrlwi            5, 5, 24
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        lwsync
0:
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
        bf                2, 0b
1:
        isync
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u8::acqrel_relaxed:
        not               7, 3
        li                6, 255
        rlwinm            7, 7, 3, 27, 28
        clrlwi            4, 4, 24
        clrlwi            5, 5, 24
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        lwsync
0:
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
        bf                2, 0b
        isync
1:
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u8::acquire_seqcst:
        not               7, 3
        li                6, 255
        rlwinm            7, 7, 3, 27, 28
        clrlwi            4, 4, 24
        clrlwi            5, 5, 24
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        sync
0:
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
        bf                2, 0b
1:
        isync
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u8::relaxed_seqcst:
        not               7, 3
        li                6, 255
        rlwinm            7, 7, 3, 27, 28
        clrlwi            4, 4, 24
        clrlwi            5, 5, 24
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        sync
0:
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
        bf                2, 0b
1:
        isync
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u8::release_seqcst:
        not               7, 3
        li                6, 255
        rlwinm            7, 7, 3, 27, 28
        clrlwi            4, 4, 24
        clrlwi            5, 5, 24
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        sync
0:
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
        bf                2, 0b
1:
        isync
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u8::seqcst_acquire:
        not               7, 3
        li                6, 255
        rlwinm            7, 7, 3, 27, 28
        clrlwi            4, 4, 24
        clrlwi            5, 5, 24
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        sync
0:
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
        bf                2, 0b
1:
        isync
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u8::seqcst_relaxed:
        not               7, 3
        li                6, 255
        rlwinm            7, 7, 3, 27, 28
        clrlwi            4, 4, 24
        clrlwi            5, 5, 24
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        sync
0:
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
        bf                2, 0b
        isync
1:
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u8::acquire_acquire:
        not               7, 3
        li                6, 255
        rlwinm            7, 7, 3, 27, 28
        clrlwi            4, 4, 24
        clrlwi            5, 5, 24
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
0:
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
        bf                2, 0b
1:
        isync
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u8::acquire_relaxed:
        not               7, 3
        li                6, 255
        rlwinm            7, 7, 3, 27, 28
        clrlwi            4, 4, 24
        clrlwi            5, 5, 24
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
0:
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
        bf                2, 0b
        isync
1:
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u8::relaxed_acquire:
        not               7, 3
        li                6, 255
        rlwinm            7, 7, 3, 27, 28
        clrlwi            4, 4, 24
        clrlwi            5, 5, 24
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
0:
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
        bf                2, 0b
1:
        isync
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u8::relaxed_relaxed:
        not               7, 3
        li                6, 255
        rlwinm            7, 7, 3, 27, 28
        clrlwi            4, 4, 24
        clrlwi            5, 5, 24
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
0:
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
        bf                2, 0b
1:
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u8::release_acquire:
        not               7, 3
        li                6, 255
        rlwinm            7, 7, 3, 27, 28
        clrlwi            4, 4, 24
        clrlwi            5, 5, 24
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        lwsync
0:
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
        bf                2, 0b
1:
        isync
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u8::release_relaxed:
        not               7, 3
        li                6, 255
        rlwinm            7, 7, 3, 27, 28
        clrlwi            4, 4, 24
        clrlwi            5, 5, 24
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        lwsync
0:
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
        bf                2, 0b
1:
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u16::acqrel_seqcst:
        li                6, 0
        rlwinm            7, 3, 3, 27, 28
        ori               6, 6, 65535
        xori              7, 7, 16
        clrlwi            4, 4, 16
        clrlwi            5, 5, 16
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        sync
0:
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
        bf                2, 0b
1:
        isync
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u16::seqcst_seqcst:
        li                6, 0
        rlwinm            7, 3, 3, 27, 28
        ori               6, 6, 65535
        xori              7, 7, 16
        clrlwi            4, 4, 16
        clrlwi            5, 5, 16
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        sync
0:
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
        bf                2, 0b
1:
        isync
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u16::acqrel_acquire:
        li                6, 0
        rlwinm            7, 3, 3, 27, 28
        ori               6, 6, 65535
        xori              7, 7, 16
        clrlwi            4, 4, 16
        clrlwi            5, 5, 16
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        lwsync
0:
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
        bf                2, 0b
1:
        isync
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u16::acqrel_relaxed:
        li                6, 0
        rlwinm            7, 3, 3, 27, 28
        ori               6, 6, 65535
        xori              7, 7, 16
        clrlwi            4, 4, 16
        clrlwi            5, 5, 16
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        lwsync
0:
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
        bf                2, 0b
        isync
1:
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u16::acquire_seqcst:
        li                6, 0
        rlwinm            7, 3, 3, 27, 28
        ori               6, 6, 65535
        xori              7, 7, 16
        clrlwi            4, 4, 16
        clrlwi            5, 5, 16
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        sync
0:
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
        bf                2, 0b
1:
        isync
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u16::relaxed_seqcst:
        li                6, 0
        rlwinm            7, 3, 3, 27, 28
        ori               6, 6, 65535
        xori              7, 7, 16
        clrlwi            4, 4, 16
        clrlwi            5, 5, 16
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        sync
0:
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
        bf                2, 0b
1:
        isync
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u16::release_seqcst:
        li                6, 0
        rlwinm            7, 3, 3, 27, 28
        ori               6, 6, 65535
        xori              7, 7, 16
        clrlwi            4, 4, 16
        clrlwi            5, 5, 16
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        sync
0:
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
        bf                2, 0b
1:
        isync
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u16::seqcst_acquire:
        li                6, 0
        rlwinm            7, 3, 3, 27, 28
        ori               6, 6, 65535
        xori              7, 7, 16
        clrlwi            4, 4, 16
        clrlwi            5, 5, 16
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        sync
0:
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
        bf                2, 0b
1:
        isync
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u16::seqcst_relaxed:
        li                6, 0
        rlwinm            7, 3, 3, 27, 28
        ori               6, 6, 65535
        xori              7, 7, 16
        clrlwi            4, 4, 16
        clrlwi            5, 5, 16
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        sync
0:
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
        bf                2, 0b
        isync
1:
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u16::acquire_acquire:
        li                6, 0
        rlwinm            7, 3, 3, 27, 28
        ori               6, 6, 65535
        xori              7, 7, 16
        clrlwi            4, 4, 16
        clrlwi            5, 5, 16
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
0:
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
        bf                2, 0b
1:
        isync
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u16::acquire_relaxed:
        li                6, 0
        rlwinm            7, 3, 3, 27, 28
        ori               6, 6, 65535
        xori              7, 7, 16
        clrlwi            4, 4, 16
        clrlwi            5, 5, 16
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
0:
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
        bf                2, 0b
        isync
1:
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u16::relaxed_acquire:
        li                6, 0
        rlwinm            7, 3, 3, 27, 28
        ori               6, 6, 65535
        xori              7, 7, 16
        clrlwi            4, 4, 16
        clrlwi            5, 5, 16
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
0:
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
        bf                2, 0b
1:
        isync
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u16::relaxed_relaxed:
        li                6, 0
        rlwinm            7, 3, 3, 27, 28
        ori               6, 6, 65535
        xori              7, 7, 16
        clrlwi            4, 4, 16
        clrlwi            5, 5, 16
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
0:
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
        bf                2, 0b
1:
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u16::release_acquire:
        li                6, 0
        rlwinm            7, 3, 3, 27, 28
        ori               6, 6, 65535
        xori              7, 7, 16
        clrlwi            4, 4, 16
        clrlwi            5, 5, 16
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        lwsync
0:
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
        bf                2, 0b
1:
        isync
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u16::release_relaxed:
        li                6, 0
        rlwinm            7, 3, 3, 27, 28
        ori               6, 6, 65535
        xori              7, 7, 16
        clrlwi            4, 4, 16
        clrlwi            5, 5, 16
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        lwsync
0:
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
        bf                2, 0b
1:
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
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

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        not               7, 3
        li                6, 255
        rlwinm            7, 7, 3, 27, 28
        clrlwi            4, 4, 24
        clrlwi            5, 5, 24
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        sync
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
0:
        isync
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        not               7, 3
        li                6, 255
        rlwinm            7, 7, 3, 27, 28
        clrlwi            4, 4, 24
        clrlwi            5, 5, 24
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        sync
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
0:
        isync
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        not               7, 3
        li                6, 255
        rlwinm            7, 7, 3, 27, 28
        clrlwi            4, 4, 24
        clrlwi            5, 5, 24
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        lwsync
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
0:
        isync
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        not               7, 3
        li                6, 255
        rlwinm            7, 7, 3, 27, 28
        clrlwi            4, 4, 24
        clrlwi            5, 5, 24
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        lwsync
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
        isync
0:
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        not               7, 3
        li                6, 255
        rlwinm            7, 7, 3, 27, 28
        clrlwi            4, 4, 24
        clrlwi            5, 5, 24
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        sync
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
0:
        isync
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        not               7, 3
        li                6, 255
        rlwinm            7, 7, 3, 27, 28
        clrlwi            4, 4, 24
        clrlwi            5, 5, 24
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        sync
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
0:
        isync
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u8::release_seqcst:
        not               7, 3
        li                6, 255
        rlwinm            7, 7, 3, 27, 28
        clrlwi            4, 4, 24
        clrlwi            5, 5, 24
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        sync
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
0:
        isync
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        not               7, 3
        li                6, 255
        rlwinm            7, 7, 3, 27, 28
        clrlwi            4, 4, 24
        clrlwi            5, 5, 24
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        sync
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
0:
        isync
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        not               7, 3
        li                6, 255
        rlwinm            7, 7, 3, 27, 28
        clrlwi            4, 4, 24
        clrlwi            5, 5, 24
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        sync
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
        isync
0:
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u8::acquire_acquire:
        not               7, 3
        li                6, 255
        rlwinm            7, 7, 3, 27, 28
        clrlwi            4, 4, 24
        clrlwi            5, 5, 24
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
0:
        isync
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        not               7, 3
        li                6, 255
        rlwinm            7, 7, 3, 27, 28
        clrlwi            4, 4, 24
        clrlwi            5, 5, 24
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
        isync
0:
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        not               7, 3
        li                6, 255
        rlwinm            7, 7, 3, 27, 28
        clrlwi            4, 4, 24
        clrlwi            5, 5, 24
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
0:
        isync
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        not               7, 3
        li                6, 255
        rlwinm            7, 7, 3, 27, 28
        clrlwi            4, 4, 24
        clrlwi            5, 5, 24
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
0:
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u8::release_acquire:
        not               7, 3
        li                6, 255
        rlwinm            7, 7, 3, 27, 28
        clrlwi            4, 4, 24
        clrlwi            5, 5, 24
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        lwsync
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
0:
        isync
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u8::release_relaxed:
        not               7, 3
        li                6, 255
        rlwinm            7, 7, 3, 27, 28
        clrlwi            4, 4, 24
        clrlwi            5, 5, 24
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        lwsync
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
0:
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        li                6, 0
        rlwinm            7, 3, 3, 27, 28
        ori               6, 6, 65535
        xori              7, 7, 16
        clrlwi            4, 4, 16
        clrlwi            5, 5, 16
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        sync
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
0:
        isync
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        li                6, 0
        rlwinm            7, 3, 3, 27, 28
        ori               6, 6, 65535
        xori              7, 7, 16
        clrlwi            4, 4, 16
        clrlwi            5, 5, 16
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        sync
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
0:
        isync
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        li                6, 0
        rlwinm            7, 3, 3, 27, 28
        ori               6, 6, 65535
        xori              7, 7, 16
        clrlwi            4, 4, 16
        clrlwi            5, 5, 16
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        lwsync
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
0:
        isync
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        li                6, 0
        rlwinm            7, 3, 3, 27, 28
        ori               6, 6, 65535
        xori              7, 7, 16
        clrlwi            4, 4, 16
        clrlwi            5, 5, 16
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        lwsync
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
        isync
0:
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        li                6, 0
        rlwinm            7, 3, 3, 27, 28
        ori               6, 6, 65535
        xori              7, 7, 16
        clrlwi            4, 4, 16
        clrlwi            5, 5, 16
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        sync
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
0:
        isync
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        li                6, 0
        rlwinm            7, 3, 3, 27, 28
        ori               6, 6, 65535
        xori              7, 7, 16
        clrlwi            4, 4, 16
        clrlwi            5, 5, 16
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        sync
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
0:
        isync
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u16::release_seqcst:
        li                6, 0
        rlwinm            7, 3, 3, 27, 28
        ori               6, 6, 65535
        xori              7, 7, 16
        clrlwi            4, 4, 16
        clrlwi            5, 5, 16
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        sync
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
0:
        isync
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        li                6, 0
        rlwinm            7, 3, 3, 27, 28
        ori               6, 6, 65535
        xori              7, 7, 16
        clrlwi            4, 4, 16
        clrlwi            5, 5, 16
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        sync
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
0:
        isync
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        li                6, 0
        rlwinm            7, 3, 3, 27, 28
        ori               6, 6, 65535
        xori              7, 7, 16
        clrlwi            4, 4, 16
        clrlwi            5, 5, 16
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        sync
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
        isync
0:
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u16::acquire_acquire:
        li                6, 0
        rlwinm            7, 3, 3, 27, 28
        ori               6, 6, 65535
        xori              7, 7, 16
        clrlwi            4, 4, 16
        clrlwi            5, 5, 16
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
0:
        isync
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        li                6, 0
        rlwinm            7, 3, 3, 27, 28
        ori               6, 6, 65535
        xori              7, 7, 16
        clrlwi            4, 4, 16
        clrlwi            5, 5, 16
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
        isync
0:
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        li                6, 0
        rlwinm            7, 3, 3, 27, 28
        ori               6, 6, 65535
        xori              7, 7, 16
        clrlwi            4, 4, 16
        clrlwi            5, 5, 16
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
0:
        isync
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        li                6, 0
        rlwinm            7, 3, 3, 27, 28
        ori               6, 6, 65535
        xori              7, 7, 16
        clrlwi            4, 4, 16
        clrlwi            5, 5, 16
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
0:
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u16::release_acquire:
        li                6, 0
        rlwinm            7, 3, 3, 27, 28
        ori               6, 6, 65535
        xori              7, 7, 16
        clrlwi            4, 4, 16
        clrlwi            5, 5, 16
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        lwsync
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
0:
        isync
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u16::release_relaxed:
        li                6, 0
        rlwinm            7, 3, 3, 27, 28
        ori               6, 6, 65535
        xori              7, 7, 16
        clrlwi            4, 4, 16
        clrlwi            5, 5, 16
        rldicr            8, 3, 0, 61
        sld               6, 6, 7
        slw               4, 4, 7
        slw               5, 5, 7
        lwsync
        lwarx             3, 0, 8
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 8
0:
        srw               3, 3, 7
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
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

asm_test::swap::u8::acqrel:
        not               6, 3
        li                5, 255
        rlwinm            6, 6, 3, 27, 28
        clrlwi            4, 4, 24
        rldicr            7, 3, 0, 61
        sld               5, 5, 6
        slw               4, 4, 6
        lwsync
0:
        lwarx             3, 0, 7
        andc              8, 3, 5
        or                8, 4, 8
        stwcx.            8, 0, 7
        bf                2, 0b
        isync
        srw               3, 3, 6
        blr

asm_test::swap::u8::seqcst:
        not               6, 3
        li                5, 255
        rlwinm            6, 6, 3, 27, 28
        clrlwi            4, 4, 24
        rldicr            7, 3, 0, 61
        sld               5, 5, 6
        slw               4, 4, 6
        sync
0:
        lwarx             3, 0, 7
        andc              8, 3, 5
        or                8, 4, 8
        stwcx.            8, 0, 7
        bf                2, 0b
        isync
        srw               3, 3, 6
        blr

asm_test::swap::u8::acquire:
        not               6, 3
        li                5, 255
        rlwinm            6, 6, 3, 27, 28
        clrlwi            4, 4, 24
        rldicr            7, 3, 0, 61
        sld               5, 5, 6
        slw               4, 4, 6
0:
        lwarx             3, 0, 7
        andc              8, 3, 5
        or                8, 4, 8
        stwcx.            8, 0, 7
        bf                2, 0b
        isync
        srw               3, 3, 6
        blr

asm_test::swap::u8::relaxed:
        not               6, 3
        li                5, 255
        rlwinm            6, 6, 3, 27, 28
        clrlwi            4, 4, 24
        rldicr            7, 3, 0, 61
        sld               5, 5, 6
        slw               4, 4, 6
0:
        lwarx             3, 0, 7
        andc              8, 3, 5
        or                8, 4, 8
        stwcx.            8, 0, 7
        bf                2, 0b
        srw               3, 3, 6
        blr

asm_test::swap::u8::release:
        not               6, 3
        li                5, 255
        rlwinm            6, 6, 3, 27, 28
        clrlwi            4, 4, 24
        rldicr            7, 3, 0, 61
        sld               5, 5, 6
        slw               4, 4, 6
        lwsync
0:
        lwarx             3, 0, 7
        andc              8, 3, 5
        or                8, 4, 8
        stwcx.            8, 0, 7
        bf                2, 0b
        srw               3, 3, 6
        blr

asm_test::swap::u16::acqrel:
        li                5, 0
        rldicr            6, 3, 0, 61
        rlwinm            3, 3, 3, 27, 28
        ori               5, 5, 65535
        xori              7, 3, 16
        clrlwi            4, 4, 16
        sld               5, 5, 7
        slw               4, 4, 7
        lwsync
0:
        lwarx             3, 0, 6
        andc              8, 3, 5
        or                8, 4, 8
        stwcx.            8, 0, 6
        bf                2, 0b
        isync
        srw               3, 3, 7
        blr

asm_test::swap::u16::seqcst:
        li                5, 0
        rldicr            6, 3, 0, 61
        rlwinm            3, 3, 3, 27, 28
        ori               5, 5, 65535
        xori              7, 3, 16
        clrlwi            4, 4, 16
        sld               5, 5, 7
        slw               4, 4, 7
        sync
0:
        lwarx             3, 0, 6
        andc              8, 3, 5
        or                8, 4, 8
        stwcx.            8, 0, 6
        bf                2, 0b
        isync
        srw               3, 3, 7
        blr

asm_test::swap::u16::acquire:
        li                5, 0
        rldicr            6, 3, 0, 61
        rlwinm            3, 3, 3, 27, 28
        ori               5, 5, 65535
        xori              7, 3, 16
        clrlwi            4, 4, 16
        sld               5, 5, 7
        slw               4, 4, 7
0:
        lwarx             3, 0, 6
        andc              8, 3, 5
        or                8, 4, 8
        stwcx.            8, 0, 6
        bf                2, 0b
        isync
        srw               3, 3, 7
        blr

asm_test::swap::u16::relaxed:
        li                5, 0
        rldicr            6, 3, 0, 61
        rlwinm            3, 3, 3, 27, 28
        ori               5, 5, 65535
        xori              7, 3, 16
        clrlwi            4, 4, 16
        sld               5, 5, 7
        slw               4, 4, 7
0:
        lwarx             3, 0, 6
        andc              8, 3, 5
        or                8, 4, 8
        stwcx.            8, 0, 6
        bf                2, 0b
        srw               3, 3, 7
        blr

asm_test::swap::u16::release:
        li                5, 0
        rldicr            6, 3, 0, 61
        rlwinm            3, 3, 3, 27, 28
        ori               5, 5, 65535
        xori              7, 3, 16
        clrlwi            4, 4, 16
        sld               5, 5, 7
        slw               4, 4, 7
        lwsync
0:
        lwarx             3, 0, 6
        andc              8, 3, 5
        or                8, 4, 8
        stwcx.            8, 0, 6
        bf                2, 0b
        srw               3, 3, 7
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

