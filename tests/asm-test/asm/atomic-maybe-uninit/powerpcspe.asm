asm_test::compare_exchange::u8::acqrel_seqcst:
        rlwinm            7, 3, 0, 0, 29
        not               3, 3
        li                6, 255
        clrlwi            4, 4, 24
        rlwinm            8, 3, 3, 27, 28
        clrlwi            5, 5, 24
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        sync
0:
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
        bf                2, 0b
1:
        isync
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u8::seqcst_seqcst:
        rlwinm            7, 3, 0, 0, 29
        not               3, 3
        li                6, 255
        clrlwi            4, 4, 24
        rlwinm            8, 3, 3, 27, 28
        clrlwi            5, 5, 24
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        sync
0:
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
        bf                2, 0b
1:
        isync
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u8::acqrel_acquire:
        rlwinm            7, 3, 0, 0, 29
        not               3, 3
        li                6, 255
        clrlwi            4, 4, 24
        rlwinm            8, 3, 3, 27, 28
        clrlwi            5, 5, 24
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        sync
0:
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
        bf                2, 0b
1:
        isync
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u8::acqrel_relaxed:
        rlwinm            7, 3, 0, 0, 29
        not               3, 3
        li                6, 255
        clrlwi            4, 4, 24
        rlwinm            8, 3, 3, 27, 28
        clrlwi            5, 5, 24
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        sync
0:
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
        bf                2, 0b
        isync
1:
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u8::acquire_seqcst:
        rlwinm            7, 3, 0, 0, 29
        not               3, 3
        li                6, 255
        clrlwi            4, 4, 24
        rlwinm            8, 3, 3, 27, 28
        clrlwi            5, 5, 24
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        sync
0:
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
        bf                2, 0b
1:
        isync
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u8::relaxed_seqcst:
        rlwinm            7, 3, 0, 0, 29
        not               3, 3
        li                6, 255
        clrlwi            4, 4, 24
        rlwinm            8, 3, 3, 27, 28
        clrlwi            5, 5, 24
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        sync
0:
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
        bf                2, 0b
1:
        isync
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u8::release_seqcst:
        rlwinm            7, 3, 0, 0, 29
        not               3, 3
        li                6, 255
        clrlwi            4, 4, 24
        rlwinm            8, 3, 3, 27, 28
        clrlwi            5, 5, 24
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        sync
0:
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
        bf                2, 0b
1:
        isync
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u8::seqcst_acquire:
        rlwinm            7, 3, 0, 0, 29
        not               3, 3
        li                6, 255
        clrlwi            4, 4, 24
        rlwinm            8, 3, 3, 27, 28
        clrlwi            5, 5, 24
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        sync
0:
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
        bf                2, 0b
1:
        isync
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u8::seqcst_relaxed:
        rlwinm            7, 3, 0, 0, 29
        not               3, 3
        li                6, 255
        clrlwi            4, 4, 24
        rlwinm            8, 3, 3, 27, 28
        clrlwi            5, 5, 24
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        sync
0:
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
        bf                2, 0b
        isync
1:
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u8::acquire_acquire:
        rlwinm            7, 3, 0, 0, 29
        not               3, 3
        li                6, 255
        clrlwi            4, 4, 24
        rlwinm            8, 3, 3, 27, 28
        clrlwi            5, 5, 24
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
0:
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
        bf                2, 0b
1:
        isync
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u8::acquire_relaxed:
        rlwinm            7, 3, 0, 0, 29
        not               3, 3
        li                6, 255
        clrlwi            4, 4, 24
        rlwinm            8, 3, 3, 27, 28
        clrlwi            5, 5, 24
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
0:
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
        bf                2, 0b
        isync
1:
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u8::relaxed_acquire:
        rlwinm            7, 3, 0, 0, 29
        not               3, 3
        li                6, 255
        clrlwi            4, 4, 24
        rlwinm            8, 3, 3, 27, 28
        clrlwi            5, 5, 24
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
0:
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
        bf                2, 0b
1:
        isync
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u8::relaxed_relaxed:
        rlwinm            7, 3, 0, 0, 29
        not               3, 3
        li                6, 255
        clrlwi            4, 4, 24
        rlwinm            8, 3, 3, 27, 28
        clrlwi            5, 5, 24
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
0:
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
        bf                2, 0b
1:
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u8::release_acquire:
        rlwinm            7, 3, 0, 0, 29
        not               3, 3
        li                6, 255
        clrlwi            4, 4, 24
        rlwinm            8, 3, 3, 27, 28
        clrlwi            5, 5, 24
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        sync
0:
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
        bf                2, 0b
1:
        isync
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u8::release_relaxed:
        rlwinm            7, 3, 0, 0, 29
        not               3, 3
        li                6, 255
        clrlwi            4, 4, 24
        rlwinm            8, 3, 3, 27, 28
        clrlwi            5, 5, 24
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        sync
0:
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
        bf                2, 0b
1:
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u16::acqrel_seqcst:
        lis               6, 0
        rlwinm            7, 3, 0, 0, 29
        rlwinm            3, 3, 3, 27, 28
        ori               6, 6, 65535
        clrlwi            4, 4, 16
        xori              8, 3, 16
        clrlwi            5, 5, 16
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        sync
0:
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
        bf                2, 0b
1:
        isync
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u16::seqcst_seqcst:
        lis               6, 0
        rlwinm            7, 3, 0, 0, 29
        rlwinm            3, 3, 3, 27, 28
        ori               6, 6, 65535
        clrlwi            4, 4, 16
        xori              8, 3, 16
        clrlwi            5, 5, 16
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        sync
0:
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
        bf                2, 0b
1:
        isync
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u16::acqrel_acquire:
        lis               6, 0
        rlwinm            7, 3, 0, 0, 29
        rlwinm            3, 3, 3, 27, 28
        ori               6, 6, 65535
        clrlwi            4, 4, 16
        xori              8, 3, 16
        clrlwi            5, 5, 16
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        sync
0:
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
        bf                2, 0b
1:
        isync
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u16::acqrel_relaxed:
        lis               6, 0
        rlwinm            7, 3, 0, 0, 29
        rlwinm            3, 3, 3, 27, 28
        ori               6, 6, 65535
        clrlwi            4, 4, 16
        xori              8, 3, 16
        clrlwi            5, 5, 16
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        sync
0:
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
        bf                2, 0b
        isync
1:
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u16::acquire_seqcst:
        lis               6, 0
        rlwinm            7, 3, 0, 0, 29
        rlwinm            3, 3, 3, 27, 28
        ori               6, 6, 65535
        clrlwi            4, 4, 16
        xori              8, 3, 16
        clrlwi            5, 5, 16
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        sync
0:
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
        bf                2, 0b
1:
        isync
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u16::relaxed_seqcst:
        lis               6, 0
        rlwinm            7, 3, 0, 0, 29
        rlwinm            3, 3, 3, 27, 28
        ori               6, 6, 65535
        clrlwi            4, 4, 16
        xori              8, 3, 16
        clrlwi            5, 5, 16
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        sync
0:
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
        bf                2, 0b
1:
        isync
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u16::release_seqcst:
        lis               6, 0
        rlwinm            7, 3, 0, 0, 29
        rlwinm            3, 3, 3, 27, 28
        ori               6, 6, 65535
        clrlwi            4, 4, 16
        xori              8, 3, 16
        clrlwi            5, 5, 16
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        sync
0:
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
        bf                2, 0b
1:
        isync
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u16::seqcst_acquire:
        lis               6, 0
        rlwinm            7, 3, 0, 0, 29
        rlwinm            3, 3, 3, 27, 28
        ori               6, 6, 65535
        clrlwi            4, 4, 16
        xori              8, 3, 16
        clrlwi            5, 5, 16
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        sync
0:
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
        bf                2, 0b
1:
        isync
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u16::seqcst_relaxed:
        lis               6, 0
        rlwinm            7, 3, 0, 0, 29
        rlwinm            3, 3, 3, 27, 28
        ori               6, 6, 65535
        clrlwi            4, 4, 16
        xori              8, 3, 16
        clrlwi            5, 5, 16
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        sync
0:
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
        bf                2, 0b
        isync
1:
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u16::acquire_acquire:
        lis               6, 0
        rlwinm            7, 3, 0, 0, 29
        rlwinm            3, 3, 3, 27, 28
        ori               6, 6, 65535
        clrlwi            4, 4, 16
        xori              8, 3, 16
        clrlwi            5, 5, 16
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
0:
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
        bf                2, 0b
1:
        isync
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u16::acquire_relaxed:
        lis               6, 0
        rlwinm            7, 3, 0, 0, 29
        rlwinm            3, 3, 3, 27, 28
        ori               6, 6, 65535
        clrlwi            4, 4, 16
        xori              8, 3, 16
        clrlwi            5, 5, 16
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
0:
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
        bf                2, 0b
        isync
1:
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u16::relaxed_acquire:
        lis               6, 0
        rlwinm            7, 3, 0, 0, 29
        rlwinm            3, 3, 3, 27, 28
        ori               6, 6, 65535
        clrlwi            4, 4, 16
        xori              8, 3, 16
        clrlwi            5, 5, 16
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
0:
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
        bf                2, 0b
1:
        isync
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u16::relaxed_relaxed:
        lis               6, 0
        rlwinm            7, 3, 0, 0, 29
        rlwinm            3, 3, 3, 27, 28
        ori               6, 6, 65535
        clrlwi            4, 4, 16
        xori              8, 3, 16
        clrlwi            5, 5, 16
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
0:
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
        bf                2, 0b
1:
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u16::release_acquire:
        lis               6, 0
        rlwinm            7, 3, 0, 0, 29
        rlwinm            3, 3, 3, 27, 28
        ori               6, 6, 65535
        clrlwi            4, 4, 16
        xori              8, 3, 16
        clrlwi            5, 5, 16
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        sync
0:
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
        bf                2, 0b
1:
        isync
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange::u16::release_relaxed:
        lis               6, 0
        rlwinm            7, 3, 0, 0, 29
        rlwinm            3, 3, 3, 27, 28
        ori               6, 6, 65535
        clrlwi            4, 4, 16
        xori              8, 3, 16
        clrlwi            5, 5, 16
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        sync
0:
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 1f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
        bf                2, 0b
1:
        srw               3, 3, 8
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

asm_test::compare_exchange::u32::acqrel_relaxed:
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

asm_test::compare_exchange::u32::release_relaxed:
        sync
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

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        rlwinm            7, 3, 0, 0, 29
        not               3, 3
        li                6, 255
        clrlwi            4, 4, 24
        rlwinm            8, 3, 3, 27, 28
        clrlwi            5, 5, 24
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        sync
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
0:
        isync
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        rlwinm            7, 3, 0, 0, 29
        not               3, 3
        li                6, 255
        clrlwi            4, 4, 24
        rlwinm            8, 3, 3, 27, 28
        clrlwi            5, 5, 24
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        sync
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
0:
        isync
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        rlwinm            7, 3, 0, 0, 29
        not               3, 3
        li                6, 255
        clrlwi            4, 4, 24
        rlwinm            8, 3, 3, 27, 28
        clrlwi            5, 5, 24
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        sync
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
0:
        isync
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        rlwinm            7, 3, 0, 0, 29
        not               3, 3
        li                6, 255
        clrlwi            4, 4, 24
        rlwinm            8, 3, 3, 27, 28
        clrlwi            5, 5, 24
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        sync
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
        isync
0:
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        rlwinm            7, 3, 0, 0, 29
        not               3, 3
        li                6, 255
        clrlwi            4, 4, 24
        rlwinm            8, 3, 3, 27, 28
        clrlwi            5, 5, 24
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        sync
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
0:
        isync
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        rlwinm            7, 3, 0, 0, 29
        not               3, 3
        li                6, 255
        clrlwi            4, 4, 24
        rlwinm            8, 3, 3, 27, 28
        clrlwi            5, 5, 24
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        sync
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
0:
        isync
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u8::release_seqcst:
        rlwinm            7, 3, 0, 0, 29
        not               3, 3
        li                6, 255
        clrlwi            4, 4, 24
        rlwinm            8, 3, 3, 27, 28
        clrlwi            5, 5, 24
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        sync
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
0:
        isync
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        rlwinm            7, 3, 0, 0, 29
        not               3, 3
        li                6, 255
        clrlwi            4, 4, 24
        rlwinm            8, 3, 3, 27, 28
        clrlwi            5, 5, 24
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        sync
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
0:
        isync
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        rlwinm            7, 3, 0, 0, 29
        not               3, 3
        li                6, 255
        clrlwi            4, 4, 24
        rlwinm            8, 3, 3, 27, 28
        clrlwi            5, 5, 24
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        sync
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
        isync
0:
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u8::acquire_acquire:
        rlwinm            7, 3, 0, 0, 29
        not               3, 3
        li                6, 255
        clrlwi            4, 4, 24
        rlwinm            8, 3, 3, 27, 28
        clrlwi            5, 5, 24
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
0:
        isync
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        rlwinm            7, 3, 0, 0, 29
        not               3, 3
        li                6, 255
        clrlwi            4, 4, 24
        rlwinm            8, 3, 3, 27, 28
        clrlwi            5, 5, 24
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
        isync
0:
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        rlwinm            7, 3, 0, 0, 29
        not               3, 3
        li                6, 255
        clrlwi            4, 4, 24
        rlwinm            8, 3, 3, 27, 28
        clrlwi            5, 5, 24
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
0:
        isync
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        rlwinm            7, 3, 0, 0, 29
        not               3, 3
        li                6, 255
        clrlwi            4, 4, 24
        rlwinm            8, 3, 3, 27, 28
        clrlwi            5, 5, 24
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
0:
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u8::release_acquire:
        rlwinm            7, 3, 0, 0, 29
        not               3, 3
        li                6, 255
        clrlwi            4, 4, 24
        rlwinm            8, 3, 3, 27, 28
        clrlwi            5, 5, 24
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        sync
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
0:
        isync
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u8::release_relaxed:
        rlwinm            7, 3, 0, 0, 29
        not               3, 3
        li                6, 255
        clrlwi            4, 4, 24
        rlwinm            8, 3, 3, 27, 28
        clrlwi            5, 5, 24
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        sync
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
0:
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        lis               6, 0
        rlwinm            7, 3, 0, 0, 29
        rlwinm            3, 3, 3, 27, 28
        ori               6, 6, 65535
        clrlwi            4, 4, 16
        xori              8, 3, 16
        clrlwi            5, 5, 16
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        sync
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
0:
        isync
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        lis               6, 0
        rlwinm            7, 3, 0, 0, 29
        rlwinm            3, 3, 3, 27, 28
        ori               6, 6, 65535
        clrlwi            4, 4, 16
        xori              8, 3, 16
        clrlwi            5, 5, 16
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        sync
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
0:
        isync
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        lis               6, 0
        rlwinm            7, 3, 0, 0, 29
        rlwinm            3, 3, 3, 27, 28
        ori               6, 6, 65535
        clrlwi            4, 4, 16
        xori              8, 3, 16
        clrlwi            5, 5, 16
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        sync
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
0:
        isync
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        lis               6, 0
        rlwinm            7, 3, 0, 0, 29
        rlwinm            3, 3, 3, 27, 28
        ori               6, 6, 65535
        clrlwi            4, 4, 16
        xori              8, 3, 16
        clrlwi            5, 5, 16
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        sync
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
        isync
0:
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        lis               6, 0
        rlwinm            7, 3, 0, 0, 29
        rlwinm            3, 3, 3, 27, 28
        ori               6, 6, 65535
        clrlwi            4, 4, 16
        xori              8, 3, 16
        clrlwi            5, 5, 16
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        sync
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
0:
        isync
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        lis               6, 0
        rlwinm            7, 3, 0, 0, 29
        rlwinm            3, 3, 3, 27, 28
        ori               6, 6, 65535
        clrlwi            4, 4, 16
        xori              8, 3, 16
        clrlwi            5, 5, 16
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        sync
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
0:
        isync
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u16::release_seqcst:
        lis               6, 0
        rlwinm            7, 3, 0, 0, 29
        rlwinm            3, 3, 3, 27, 28
        ori               6, 6, 65535
        clrlwi            4, 4, 16
        xori              8, 3, 16
        clrlwi            5, 5, 16
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        sync
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
0:
        isync
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        lis               6, 0
        rlwinm            7, 3, 0, 0, 29
        rlwinm            3, 3, 3, 27, 28
        ori               6, 6, 65535
        clrlwi            4, 4, 16
        xori              8, 3, 16
        clrlwi            5, 5, 16
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        sync
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
0:
        isync
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        lis               6, 0
        rlwinm            7, 3, 0, 0, 29
        rlwinm            3, 3, 3, 27, 28
        ori               6, 6, 65535
        clrlwi            4, 4, 16
        xori              8, 3, 16
        clrlwi            5, 5, 16
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        sync
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
        isync
0:
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u16::acquire_acquire:
        lis               6, 0
        rlwinm            7, 3, 0, 0, 29
        rlwinm            3, 3, 3, 27, 28
        ori               6, 6, 65535
        clrlwi            4, 4, 16
        xori              8, 3, 16
        clrlwi            5, 5, 16
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
0:
        isync
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        lis               6, 0
        rlwinm            7, 3, 0, 0, 29
        rlwinm            3, 3, 3, 27, 28
        ori               6, 6, 65535
        clrlwi            4, 4, 16
        xori              8, 3, 16
        clrlwi            5, 5, 16
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
        isync
0:
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        lis               6, 0
        rlwinm            7, 3, 0, 0, 29
        rlwinm            3, 3, 3, 27, 28
        ori               6, 6, 65535
        clrlwi            4, 4, 16
        xori              8, 3, 16
        clrlwi            5, 5, 16
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
0:
        isync
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        lis               6, 0
        rlwinm            7, 3, 0, 0, 29
        rlwinm            3, 3, 3, 27, 28
        ori               6, 6, 65535
        clrlwi            4, 4, 16
        xori              8, 3, 16
        clrlwi            5, 5, 16
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
0:
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u16::release_acquire:
        lis               6, 0
        rlwinm            7, 3, 0, 0, 29
        rlwinm            3, 3, 3, 27, 28
        ori               6, 6, 65535
        clrlwi            4, 4, 16
        xori              8, 3, 16
        clrlwi            5, 5, 16
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        sync
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
0:
        isync
        srw               3, 3, 8
        mfcr              9
        rlwinm            4, 9, 3, 31, 31
        blr

asm_test::compare_exchange_weak::u16::release_relaxed:
        lis               6, 0
        rlwinm            7, 3, 0, 0, 29
        rlwinm            3, 3, 3, 27, 28
        ori               6, 6, 65535
        clrlwi            4, 4, 16
        xori              8, 3, 16
        clrlwi            5, 5, 16
        slw               6, 6, 8
        slw               4, 4, 8
        slw               5, 5, 8
        sync
        lwarx             3, 0, 7
        and               9, 3, 6
        cmpw              9, 4
        bf                2, 0f
        andc              9, 3, 6
        or                9, 9, 5
        stwcx.            9, 0, 7
0:
        srw               3, 3, 8
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

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
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

asm_test::compare_exchange_weak::u32::release_relaxed:
        sync
        lwarx             6, 0, 3
        cmpw              4, 6
        bf                2, 0f
        stwcx.            5, 0, 3
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

asm_test::swap::u8::acqrel:
        rlwinm            6, 3, 0, 0, 29
        not               3, 3
        li                5, 255
        rlwinm            7, 3, 3, 27, 28
        clrlwi            4, 4, 24
        slw               5, 5, 7
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

asm_test::swap::u8::seqcst:
        rlwinm            6, 3, 0, 0, 29
        not               3, 3
        li                5, 255
        rlwinm            7, 3, 3, 27, 28
        clrlwi            4, 4, 24
        slw               5, 5, 7
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

asm_test::swap::u8::acquire:
        rlwinm            6, 3, 0, 0, 29
        not               3, 3
        li                5, 255
        rlwinm            7, 3, 3, 27, 28
        clrlwi            4, 4, 24
        slw               5, 5, 7
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

asm_test::swap::u8::relaxed:
        rlwinm            6, 3, 0, 0, 29
        not               3, 3
        li                5, 255
        rlwinm            7, 3, 3, 27, 28
        clrlwi            4, 4, 24
        slw               5, 5, 7
        slw               4, 4, 7
0:
        lwarx             3, 0, 6
        andc              8, 3, 5
        or                8, 4, 8
        stwcx.            8, 0, 6
        bf                2, 0b
        srw               3, 3, 7
        blr

asm_test::swap::u8::release:
        rlwinm            6, 3, 0, 0, 29
        not               3, 3
        li                5, 255
        rlwinm            7, 3, 3, 27, 28
        clrlwi            4, 4, 24
        slw               5, 5, 7
        slw               4, 4, 7
        sync
0:
        lwarx             3, 0, 6
        andc              8, 3, 5
        or                8, 4, 8
        stwcx.            8, 0, 6
        bf                2, 0b
        srw               3, 3, 7
        blr

asm_test::swap::u16::acqrel:
        lis               5, 0
        rlwinm            6, 3, 0, 0, 29
        rlwinm            3, 3, 3, 27, 28
        ori               5, 5, 65535
        xori              7, 3, 16
        clrlwi            4, 4, 16
        slw               5, 5, 7
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

asm_test::swap::u16::seqcst:
        lis               5, 0
        rlwinm            6, 3, 0, 0, 29
        rlwinm            3, 3, 3, 27, 28
        ori               5, 5, 65535
        xori              7, 3, 16
        clrlwi            4, 4, 16
        slw               5, 5, 7
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
        lis               5, 0
        rlwinm            6, 3, 0, 0, 29
        rlwinm            3, 3, 3, 27, 28
        ori               5, 5, 65535
        xori              7, 3, 16
        clrlwi            4, 4, 16
        slw               5, 5, 7
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
        lis               5, 0
        rlwinm            6, 3, 0, 0, 29
        rlwinm            3, 3, 3, 27, 28
        ori               5, 5, 65535
        xori              7, 3, 16
        clrlwi            4, 4, 16
        slw               5, 5, 7
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
        lis               5, 0
        rlwinm            6, 3, 0, 0, 29
        rlwinm            3, 3, 3, 27, 28
        ori               5, 5, 65535
        xori              7, 3, 16
        clrlwi            4, 4, 16
        slw               5, 5, 7
        slw               4, 4, 7
        sync
0:
        lwarx             3, 0, 6
        andc              8, 3, 5
        or                8, 4, 8
        stwcx.            8, 0, 6
        bf                2, 0b
        srw               3, 3, 7
        blr

asm_test::swap::u32::acqrel:
        sync
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
        sync
0:
        lwarx             5, 0, 3
        stwcx.            4, 0, 3
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
        sync
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
        sync
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
        sync
        stw               4, 0(3)
        blr

