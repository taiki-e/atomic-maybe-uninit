asm_test::compare_exchange::u8::acqrel_seqcst:
        rldicr            6, 3, 0, 61
        clrlwi            7, 4, 24
        lwarx             4, 0, 6
        not               3, 3
        rlwinm            3, 3, 3, 27, 28
        srw               8, 4, 3
        clrlwi            8, 8, 24
        cmplw             8, 7
        bf-               2, 1f
        li                8, 255
        clrlwi            9, 5, 24
        lwsync
        slw               5, 8, 3
        slw               8, 9, 3
        not               5, 5
0:
        and               9, 4, 5
        or                9, 9, 8
        stwcx.            9, 0, 6
        bt+               2, 2f
        lwarx             4, 0, 6
        srw               9, 4, 3
        clrlwi            9, 9, 24
        cmplw             9, 7
        bt+               2, 0b
1:
        crclr             20
        lwsync
        b                 3f
2:
        lwsync
        crset             20
3:
        srw               3, 4, 3
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange::u8::seqcst_seqcst:
        rldicr            6, 3, 0, 61
        clrlwi            7, 4, 24
        lwarx             4, 0, 6
        not               3, 3
        rlwinm            3, 3, 3, 27, 28
        srw               8, 4, 3
        clrlwi            8, 8, 24
        cmplw             8, 7
        bf-               2, 1f
        li                8, 255
        clrlwi            9, 5, 24
        sync
        slw               5, 8, 3
        slw               8, 9, 3
        not               5, 5
0:
        and               9, 4, 5
        or                9, 9, 8
        stwcx.            9, 0, 6
        bt+               2, 2f
        lwarx             4, 0, 6
        srw               9, 4, 3
        clrlwi            9, 9, 24
        cmplw             9, 7
        bt+               2, 0b
1:
        crclr             20
        lwsync
        b                 3f
2:
        lwsync
        crset             20
3:
        srw               3, 4, 3
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange::u8::acqrel_acquire:
        rldicr            6, 3, 0, 61
        clrlwi            7, 4, 24
        lwarx             4, 0, 6
        not               3, 3
        rlwinm            3, 3, 3, 27, 28
        srw               8, 4, 3
        clrlwi            8, 8, 24
        cmplw             8, 7
        bf-               2, 1f
        li                8, 255
        clrlwi            9, 5, 24
        lwsync
        slw               5, 8, 3
        slw               8, 9, 3
        not               5, 5
0:
        and               9, 4, 5
        or                9, 9, 8
        stwcx.            9, 0, 6
        bt+               2, 2f
        lwarx             4, 0, 6
        srw               9, 4, 3
        clrlwi            9, 9, 24
        cmplw             9, 7
        bt+               2, 0b
1:
        crclr             20
        lwsync
        b                 3f
2:
        lwsync
        crset             20
3:
        srw               3, 4, 3
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange::u8::acqrel_relaxed:
        rldicr            6, 3, 0, 61
        clrlwi            7, 4, 24
        lwarx             4, 0, 6
        not               3, 3
        rlwinm            3, 3, 3, 27, 28
        srw               8, 4, 3
        clrlwi            8, 8, 24
        cmplw             8, 7
        bf-               2, 1f
        li                8, 255
        clrlwi            9, 5, 24
        lwsync
        slw               5, 8, 3
        slw               8, 9, 3
        not               5, 5
0:
        and               9, 4, 5
        or                9, 9, 8
        stwcx.            9, 0, 6
        bt+               2, 2f
        lwarx             4, 0, 6
        srw               9, 4, 3
        clrlwi            9, 9, 24
        cmplw             9, 7
        bt+               2, 0b
1:
        crclr             20
        b                 3f
2:
        lwsync
        crset             20
3:
        srw               3, 4, 3
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange::u8::acquire_seqcst:
        not               6, 3
        li                8, 255
        rlwinm            6, 6, 3, 27, 28
        rldicr            7, 3, 0, 61
        slw               3, 8, 6
        clrlwi            8, 5, 24
        not               5, 3
        slw               8, 8, 6
        clrlwi            4, 4, 24
0:
        lwarx             9, 0, 7
        srw               3, 9, 6
        clrlwi            10, 3, 24
        cmplw             10, 4
        bf-               2, 2f
        and               9, 9, 5
        or                9, 9, 8
        stwcx.            9, 0, 7
        bf-               2, 0b
        lwsync
        crset             20
1:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
2:
        crclr             20
        lwsync
        b                 1b

asm_test::compare_exchange::u8::relaxed_seqcst:
        not               6, 3
        li                8, 255
        crset             20
        rlwinm            6, 6, 3, 27, 28
        rldicr            7, 3, 0, 61
        slw               3, 8, 6
        clrlwi            8, 5, 24
        not               5, 3
        slw               8, 8, 6
        clrlwi            4, 4, 24
0:
        lwarx             9, 0, 7
        srw               3, 9, 6
        clrlwi            10, 3, 24
        cmplw             10, 4
        bf-               2, 2f
        and               9, 9, 5
        or                9, 9, 8
        stwcx.            9, 0, 7
        bf-               2, 0b
1:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
2:
        crclr             20
        lwsync
        b                 1b

asm_test::compare_exchange::u8::release_seqcst:
        rldicr            6, 3, 0, 61
        clrlwi            7, 4, 24
        lwarx             4, 0, 6
        not               3, 3
        rlwinm            3, 3, 3, 27, 28
        srw               8, 4, 3
        clrlwi            8, 8, 24
        cmplw             8, 7
        bf-               2, 1f
        li                8, 255
        clrlwi            9, 5, 24
        crset             20
        lwsync
        slw               5, 8, 3
        slw               8, 9, 3
        not               5, 5
0:
        and               9, 4, 5
        or                9, 9, 8
        stwcx.            9, 0, 6
        bt+               2, 2f
        lwarx             4, 0, 6
        srw               9, 4, 3
        clrlwi            9, 9, 24
        cmplw             9, 7
        bt+               2, 0b
1:
        crclr             20
        lwsync
2:
        srw               3, 4, 3
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange::u8::seqcst_acquire:
        rldicr            6, 3, 0, 61
        clrlwi            7, 4, 24
        lwarx             4, 0, 6
        not               3, 3
        rlwinm            3, 3, 3, 27, 28
        srw               8, 4, 3
        clrlwi            8, 8, 24
        cmplw             8, 7
        bf-               2, 1f
        li                8, 255
        clrlwi            9, 5, 24
        sync
        slw               5, 8, 3
        slw               8, 9, 3
        not               5, 5
0:
        and               9, 4, 5
        or                9, 9, 8
        stwcx.            9, 0, 6
        bt+               2, 2f
        lwarx             4, 0, 6
        srw               9, 4, 3
        clrlwi            9, 9, 24
        cmplw             9, 7
        bt+               2, 0b
1:
        crclr             20
        lwsync
        b                 3f
2:
        lwsync
        crset             20
3:
        srw               3, 4, 3
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange::u8::seqcst_relaxed:
        rldicr            6, 3, 0, 61
        clrlwi            7, 4, 24
        lwarx             4, 0, 6
        not               3, 3
        rlwinm            3, 3, 3, 27, 28
        srw               8, 4, 3
        clrlwi            8, 8, 24
        cmplw             8, 7
        bf-               2, 1f
        li                8, 255
        clrlwi            9, 5, 24
        sync
        slw               5, 8, 3
        slw               8, 9, 3
        not               5, 5
0:
        and               9, 4, 5
        or                9, 9, 8
        stwcx.            9, 0, 6
        bt+               2, 2f
        lwarx             4, 0, 6
        srw               9, 4, 3
        clrlwi            9, 9, 24
        cmplw             9, 7
        bt+               2, 0b
1:
        crclr             20
        b                 3f
2:
        lwsync
        crset             20
3:
        srw               3, 4, 3
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange::u8::acquire_acquire:
        not               6, 3
        li                8, 255
        rlwinm            6, 6, 3, 27, 28
        rldicr            7, 3, 0, 61
        slw               3, 8, 6
        clrlwi            8, 5, 24
        not               5, 3
        slw               8, 8, 6
        clrlwi            4, 4, 24
0:
        lwarx             9, 0, 7
        srw               3, 9, 6
        clrlwi            10, 3, 24
        cmplw             10, 4
        bf-               2, 2f
        and               9, 9, 5
        or                9, 9, 8
        stwcx.            9, 0, 7
        bf-               2, 0b
        lwsync
        crset             20
1:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
2:
        crclr             20
        lwsync
        b                 1b

asm_test::compare_exchange::u8::acquire_relaxed:
        not               6, 3
        li                8, 255
        rlwinm            6, 6, 3, 27, 28
        rldicr            7, 3, 0, 61
        slw               3, 8, 6
        clrlwi            8, 5, 24
        not               5, 3
        slw               8, 8, 6
        clrlwi            4, 4, 24
0:
        lwarx             9, 0, 7
        srw               3, 9, 6
        clrlwi            10, 3, 24
        cmplw             10, 4
        bf-               2, 2f
        and               9, 9, 5
        or                9, 9, 8
        stwcx.            9, 0, 7
        bf-               2, 0b
        lwsync
        crset             20
1:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
2:
        crclr             20
        b                 1b

asm_test::compare_exchange::u8::relaxed_acquire:
        not               6, 3
        li                8, 255
        crset             20
        rlwinm            6, 6, 3, 27, 28
        rldicr            7, 3, 0, 61
        slw               3, 8, 6
        clrlwi            8, 5, 24
        not               5, 3
        slw               8, 8, 6
        clrlwi            4, 4, 24
0:
        lwarx             9, 0, 7
        srw               3, 9, 6
        clrlwi            10, 3, 24
        cmplw             10, 4
        bf-               2, 2f
        and               9, 9, 5
        or                9, 9, 8
        stwcx.            9, 0, 7
        bf-               2, 0b
1:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
2:
        crclr             20
        lwsync
        b                 1b

asm_test::compare_exchange::u8::relaxed_relaxed:
        not               6, 3
        li                8, 255
        crset             20
        rlwinm            6, 6, 3, 27, 28
        rldicr            7, 3, 0, 61
        slw               3, 8, 6
        clrlwi            8, 5, 24
        not               5, 3
        slw               8, 8, 6
        clrlwi            4, 4, 24
0:
        lwarx             9, 0, 7
        srw               3, 9, 6
        clrlwi            10, 3, 24
        cmplw             10, 4
        bf-               2, 2f
        and               9, 9, 5
        or                9, 9, 8
        stwcx.            9, 0, 7
        bf-               2, 0b
1:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
2:
        crclr             20
        b                 1b

asm_test::compare_exchange::u8::release_acquire:
        rldicr            6, 3, 0, 61
        clrlwi            7, 4, 24
        lwarx             4, 0, 6
        not               3, 3
        rlwinm            3, 3, 3, 27, 28
        srw               8, 4, 3
        clrlwi            8, 8, 24
        cmplw             8, 7
        bf-               2, 1f
        li                8, 255
        clrlwi            9, 5, 24
        crset             20
        lwsync
        slw               5, 8, 3
        slw               8, 9, 3
        not               5, 5
0:
        and               9, 4, 5
        or                9, 9, 8
        stwcx.            9, 0, 6
        bt+               2, 2f
        lwarx             4, 0, 6
        srw               9, 4, 3
        clrlwi            9, 9, 24
        cmplw             9, 7
        bt+               2, 0b
1:
        crclr             20
        lwsync
2:
        srw               3, 4, 3
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange::u8::release_relaxed:
        rldicr            6, 3, 0, 61
        clrlwi            7, 4, 24
        lwarx             4, 0, 6
        not               3, 3
        rlwinm            3, 3, 3, 27, 28
        srw               8, 4, 3
        clrlwi            8, 8, 24
        cmplw             8, 7
        bf-               2, 1f
        li                8, 255
        clrlwi            9, 5, 24
        crset             20
        lwsync
        slw               5, 8, 3
        slw               8, 9, 3
        not               5, 5
0:
        and               9, 4, 5
        or                9, 9, 8
        stwcx.            9, 0, 6
        bt+               2, 2f
        lwarx             4, 0, 6
        srw               9, 4, 3
        clrlwi            9, 9, 24
        cmplw             9, 7
        bt+               2, 0b
1:
        crclr             20
2:
        srw               3, 4, 3
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange::u16::acqrel_seqcst:
        rldicr            7, 3, 0, 61
        clrlwi            6, 4, 16
        clrlwi            4, 3, 30
        lwarx             3, 0, 7
        xori              4, 4, 2
        slwi              4, 4, 3
        srw               8, 3, 4
        clrlwi            8, 8, 16
        cmplw             8, 6
        bf-               2, 1f
        lis               8, 0
        clrlwi            9, 5, 16
        lwsync
        ori               8, 8, 65535
        slw               5, 8, 4
        not               5, 5
        slw               8, 9, 4
0:
        and               9, 3, 5
        or                9, 9, 8
        stwcx.            9, 0, 7
        bt+               2, 2f
        lwarx             3, 0, 7
        srw               9, 3, 4
        clrlwi            9, 9, 16
        cmplw             9, 6
        bt+               2, 0b
1:
        crclr             20
        lwsync
        b                 3f
2:
        lwsync
        crset             20
3:
        srw               3, 3, 4
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange::u16::seqcst_seqcst:
        rldicr            7, 3, 0, 61
        clrlwi            6, 4, 16
        clrlwi            4, 3, 30
        lwarx             3, 0, 7
        xori              4, 4, 2
        slwi              4, 4, 3
        srw               8, 3, 4
        clrlwi            8, 8, 16
        cmplw             8, 6
        bf-               2, 1f
        lis               8, 0
        clrlwi            9, 5, 16
        sync
        ori               8, 8, 65535
        slw               5, 8, 4
        not               5, 5
        slw               8, 9, 4
0:
        and               9, 3, 5
        or                9, 9, 8
        stwcx.            9, 0, 7
        bt+               2, 2f
        lwarx             3, 0, 7
        srw               9, 3, 4
        clrlwi            9, 9, 16
        cmplw             9, 6
        bt+               2, 0b
1:
        crclr             20
        lwsync
        b                 3f
2:
        lwsync
        crset             20
3:
        srw               3, 3, 4
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange::u16::acqrel_acquire:
        rldicr            7, 3, 0, 61
        clrlwi            6, 4, 16
        clrlwi            4, 3, 30
        lwarx             3, 0, 7
        xori              4, 4, 2
        slwi              4, 4, 3
        srw               8, 3, 4
        clrlwi            8, 8, 16
        cmplw             8, 6
        bf-               2, 1f
        lis               8, 0
        clrlwi            9, 5, 16
        lwsync
        ori               8, 8, 65535
        slw               5, 8, 4
        not               5, 5
        slw               8, 9, 4
0:
        and               9, 3, 5
        or                9, 9, 8
        stwcx.            9, 0, 7
        bt+               2, 2f
        lwarx             3, 0, 7
        srw               9, 3, 4
        clrlwi            9, 9, 16
        cmplw             9, 6
        bt+               2, 0b
1:
        crclr             20
        lwsync
        b                 3f
2:
        lwsync
        crset             20
3:
        srw               3, 3, 4
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange::u16::acqrel_relaxed:
        rldicr            7, 3, 0, 61
        clrlwi            6, 4, 16
        clrlwi            4, 3, 30
        lwarx             3, 0, 7
        xori              4, 4, 2
        slwi              4, 4, 3
        srw               8, 3, 4
        clrlwi            8, 8, 16
        cmplw             8, 6
        bf-               2, 1f
        lis               8, 0
        clrlwi            9, 5, 16
        lwsync
        ori               8, 8, 65535
        slw               5, 8, 4
        not               5, 5
        slw               8, 9, 4
0:
        and               9, 3, 5
        or                9, 9, 8
        stwcx.            9, 0, 7
        bt+               2, 2f
        lwarx             3, 0, 7
        srw               9, 3, 4
        clrlwi            9, 9, 16
        cmplw             9, 6
        bt+               2, 0b
1:
        crclr             20
        b                 3f
2:
        lwsync
        crset             20
3:
        srw               3, 3, 4
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange::u16::acquire_seqcst:
        clrlwi            7, 3, 30
        lis               6, 0
        xori              7, 7, 2
        ori               8, 6, 65535
        slwi              6, 7, 3
        rldicr            7, 3, 0, 61
        slw               3, 8, 6
        clrlwi            8, 5, 16
        not               5, 3
        slw               8, 8, 6
        clrlwi            4, 4, 16
0:
        lwarx             9, 0, 7
        srw               3, 9, 6
        clrlwi            10, 3, 16
        cmplw             10, 4
        bf-               2, 2f
        and               9, 9, 5
        or                9, 9, 8
        stwcx.            9, 0, 7
        bf-               2, 0b
        lwsync
        crset             20
1:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
2:
        crclr             20
        lwsync
        b                 1b

asm_test::compare_exchange::u16::relaxed_seqcst:
        clrlwi            7, 3, 30
        lis               6, 0
        crset             20
        xori              7, 7, 2
        ori               8, 6, 65535
        slwi              6, 7, 3
        rldicr            7, 3, 0, 61
        slw               3, 8, 6
        clrlwi            8, 5, 16
        not               5, 3
        slw               8, 8, 6
        clrlwi            4, 4, 16
0:
        lwarx             9, 0, 7
        srw               3, 9, 6
        clrlwi            10, 3, 16
        cmplw             10, 4
        bf-               2, 2f
        and               9, 9, 5
        or                9, 9, 8
        stwcx.            9, 0, 7
        bf-               2, 0b
1:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
2:
        crclr             20
        lwsync
        b                 1b

asm_test::compare_exchange::u16::release_seqcst:
        rldicr            7, 3, 0, 61
        clrlwi            6, 4, 16
        clrlwi            4, 3, 30
        lwarx             3, 0, 7
        xori              4, 4, 2
        slwi              4, 4, 3
        srw               8, 3, 4
        clrlwi            8, 8, 16
        cmplw             8, 6
        bf-               2, 1f
        lis               8, 0
        clrlwi            9, 5, 16
        crset             20
        lwsync
        ori               8, 8, 65535
        slw               5, 8, 4
        not               5, 5
        slw               8, 9, 4
0:
        and               9, 3, 5
        or                9, 9, 8
        stwcx.            9, 0, 7
        bt+               2, 2f
        lwarx             3, 0, 7
        srw               9, 3, 4
        clrlwi            9, 9, 16
        cmplw             9, 6
        bt+               2, 0b
1:
        crclr             20
        lwsync
2:
        srw               3, 3, 4
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange::u16::seqcst_acquire:
        rldicr            7, 3, 0, 61
        clrlwi            6, 4, 16
        clrlwi            4, 3, 30
        lwarx             3, 0, 7
        xori              4, 4, 2
        slwi              4, 4, 3
        srw               8, 3, 4
        clrlwi            8, 8, 16
        cmplw             8, 6
        bf-               2, 1f
        lis               8, 0
        clrlwi            9, 5, 16
        sync
        ori               8, 8, 65535
        slw               5, 8, 4
        not               5, 5
        slw               8, 9, 4
0:
        and               9, 3, 5
        or                9, 9, 8
        stwcx.            9, 0, 7
        bt+               2, 2f
        lwarx             3, 0, 7
        srw               9, 3, 4
        clrlwi            9, 9, 16
        cmplw             9, 6
        bt+               2, 0b
1:
        crclr             20
        lwsync
        b                 3f
2:
        lwsync
        crset             20
3:
        srw               3, 3, 4
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange::u16::seqcst_relaxed:
        rldicr            7, 3, 0, 61
        clrlwi            6, 4, 16
        clrlwi            4, 3, 30
        lwarx             3, 0, 7
        xori              4, 4, 2
        slwi              4, 4, 3
        srw               8, 3, 4
        clrlwi            8, 8, 16
        cmplw             8, 6
        bf-               2, 1f
        lis               8, 0
        clrlwi            9, 5, 16
        sync
        ori               8, 8, 65535
        slw               5, 8, 4
        not               5, 5
        slw               8, 9, 4
0:
        and               9, 3, 5
        or                9, 9, 8
        stwcx.            9, 0, 7
        bt+               2, 2f
        lwarx             3, 0, 7
        srw               9, 3, 4
        clrlwi            9, 9, 16
        cmplw             9, 6
        bt+               2, 0b
1:
        crclr             20
        b                 3f
2:
        lwsync
        crset             20
3:
        srw               3, 3, 4
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange::u16::acquire_acquire:
        clrlwi            7, 3, 30
        lis               6, 0
        xori              7, 7, 2
        ori               8, 6, 65535
        slwi              6, 7, 3
        rldicr            7, 3, 0, 61
        slw               3, 8, 6
        clrlwi            8, 5, 16
        not               5, 3
        slw               8, 8, 6
        clrlwi            4, 4, 16
0:
        lwarx             9, 0, 7
        srw               3, 9, 6
        clrlwi            10, 3, 16
        cmplw             10, 4
        bf-               2, 2f
        and               9, 9, 5
        or                9, 9, 8
        stwcx.            9, 0, 7
        bf-               2, 0b
        lwsync
        crset             20
1:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
2:
        crclr             20
        lwsync
        b                 1b

asm_test::compare_exchange::u16::acquire_relaxed:
        clrlwi            7, 3, 30
        lis               6, 0
        xori              7, 7, 2
        ori               8, 6, 65535
        slwi              6, 7, 3
        rldicr            7, 3, 0, 61
        slw               3, 8, 6
        clrlwi            8, 5, 16
        not               5, 3
        slw               8, 8, 6
        clrlwi            4, 4, 16
0:
        lwarx             9, 0, 7
        srw               3, 9, 6
        clrlwi            10, 3, 16
        cmplw             10, 4
        bf-               2, 2f
        and               9, 9, 5
        or                9, 9, 8
        stwcx.            9, 0, 7
        bf-               2, 0b
        lwsync
        crset             20
1:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
2:
        crclr             20
        b                 1b

asm_test::compare_exchange::u16::relaxed_acquire:
        clrlwi            7, 3, 30
        lis               6, 0
        crset             20
        xori              7, 7, 2
        ori               8, 6, 65535
        slwi              6, 7, 3
        rldicr            7, 3, 0, 61
        slw               3, 8, 6
        clrlwi            8, 5, 16
        not               5, 3
        slw               8, 8, 6
        clrlwi            4, 4, 16
0:
        lwarx             9, 0, 7
        srw               3, 9, 6
        clrlwi            10, 3, 16
        cmplw             10, 4
        bf-               2, 2f
        and               9, 9, 5
        or                9, 9, 8
        stwcx.            9, 0, 7
        bf-               2, 0b
1:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
2:
        crclr             20
        lwsync
        b                 1b

asm_test::compare_exchange::u16::relaxed_relaxed:
        clrlwi            7, 3, 30
        lis               6, 0
        crset             20
        xori              7, 7, 2
        ori               8, 6, 65535
        slwi              6, 7, 3
        rldicr            7, 3, 0, 61
        slw               3, 8, 6
        clrlwi            8, 5, 16
        not               5, 3
        slw               8, 8, 6
        clrlwi            4, 4, 16
0:
        lwarx             9, 0, 7
        srw               3, 9, 6
        clrlwi            10, 3, 16
        cmplw             10, 4
        bf-               2, 2f
        and               9, 9, 5
        or                9, 9, 8
        stwcx.            9, 0, 7
        bf-               2, 0b
1:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
2:
        crclr             20
        b                 1b

asm_test::compare_exchange::u16::release_acquire:
        rldicr            7, 3, 0, 61
        clrlwi            6, 4, 16
        clrlwi            4, 3, 30
        lwarx             3, 0, 7
        xori              4, 4, 2
        slwi              4, 4, 3
        srw               8, 3, 4
        clrlwi            8, 8, 16
        cmplw             8, 6
        bf-               2, 1f
        lis               8, 0
        clrlwi            9, 5, 16
        crset             20
        lwsync
        ori               8, 8, 65535
        slw               5, 8, 4
        not               5, 5
        slw               8, 9, 4
0:
        and               9, 3, 5
        or                9, 9, 8
        stwcx.            9, 0, 7
        bt+               2, 2f
        lwarx             3, 0, 7
        srw               9, 3, 4
        clrlwi            9, 9, 16
        cmplw             9, 6
        bt+               2, 0b
1:
        crclr             20
        lwsync
2:
        srw               3, 3, 4
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange::u16::release_relaxed:
        rldicr            7, 3, 0, 61
        clrlwi            6, 4, 16
        clrlwi            4, 3, 30
        lwarx             3, 0, 7
        xori              4, 4, 2
        slwi              4, 4, 3
        srw               8, 3, 4
        clrlwi            8, 8, 16
        cmplw             8, 6
        bf-               2, 1f
        lis               8, 0
        clrlwi            9, 5, 16
        crset             20
        lwsync
        ori               8, 8, 65535
        slw               5, 8, 4
        not               5, 5
        slw               8, 9, 4
0:
        and               9, 3, 5
        or                9, 9, 8
        stwcx.            9, 0, 7
        bt+               2, 2f
        lwarx             3, 0, 7
        srw               9, 3, 4
        clrlwi            9, 9, 16
        cmplw             9, 6
        bt+               2, 0b
1:
        crclr             20
2:
        srw               3, 3, 4
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange::u32::acqrel_seqcst:
        mr                6, 3
        lwarx             3, 0, 3
        cmplw             3, 4
        bf-               2, 1f
        lwsync
0:
        stwcx.            5, 0, 6
        bt+               2, 2f
        lwarx             3, 0, 6
        cmplw             3, 4
        bt+               2, 0b
1:
        crclr             20
        lwsync
        b                 3f
2:
        lwsync
        crset             20
3:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange::u32::seqcst_seqcst:
        mr                6, 3
        lwarx             3, 0, 3
        cmplw             3, 4
        bf-               2, 1f
        sync
0:
        stwcx.            5, 0, 6
        bt+               2, 2f
        lwarx             3, 0, 6
        cmplw             3, 4
        bt+               2, 0b
1:
        crclr             20
        lwsync
        b                 3f
2:
        lwsync
        crset             20
3:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange::u32::acqrel_acquire:
        mr                6, 3
        lwarx             3, 0, 3
        cmplw             3, 4
        bf-               2, 1f
        lwsync
0:
        stwcx.            5, 0, 6
        bt+               2, 2f
        lwarx             3, 0, 6
        cmplw             3, 4
        bt+               2, 0b
1:
        crclr             20
        lwsync
        b                 3f
2:
        lwsync
        crset             20
3:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange::u32::acqrel_relaxed:
        mr                6, 3
        lwarx             3, 0, 3
        cmplw             3, 4
        bf-               2, 1f
        lwsync
0:
        stwcx.            5, 0, 6
        bt+               2, 2f
        lwarx             3, 0, 6
        cmplw             3, 4
        bt+               2, 0b
1:
        crclr             20
        b                 3f
2:
        lwsync
        crset             20
3:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange::u32::acquire_seqcst:
        mr                6, 3
0:
        lwarx             3, 0, 6
        cmplw             3, 4
        bf-               2, 2f
        stwcx.            5, 0, 6
        bf-               2, 0b
        lwsync
        crset             20
1:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
2:
        crclr             20
        lwsync
        b                 1b

asm_test::compare_exchange::u32::relaxed_seqcst:
        mr                6, 3
        crset             20
0:
        lwarx             3, 0, 6
        cmplw             3, 4
        bf-               2, 2f
        stwcx.            5, 0, 6
        bf-               2, 0b
1:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
2:
        crclr             20
        lwsync
        b                 1b

asm_test::compare_exchange::u32::release_seqcst:
        mr                6, 3
        lwarx             3, 0, 3
        cmplw             3, 4
        bf-               2, 1f
        crset             20
        lwsync
0:
        stwcx.            5, 0, 6
        bt+               2, 2f
        lwarx             3, 0, 6
        cmplw             3, 4
        bt+               2, 0b
1:
        crclr             20
        lwsync
2:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange::u32::seqcst_acquire:
        mr                6, 3
        lwarx             3, 0, 3
        cmplw             3, 4
        bf-               2, 1f
        sync
0:
        stwcx.            5, 0, 6
        bt+               2, 2f
        lwarx             3, 0, 6
        cmplw             3, 4
        bt+               2, 0b
1:
        crclr             20
        lwsync
        b                 3f
2:
        lwsync
        crset             20
3:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange::u32::seqcst_relaxed:
        mr                6, 3
        lwarx             3, 0, 3
        cmplw             3, 4
        bf-               2, 1f
        sync
0:
        stwcx.            5, 0, 6
        bt+               2, 2f
        lwarx             3, 0, 6
        cmplw             3, 4
        bt+               2, 0b
1:
        crclr             20
        b                 3f
2:
        lwsync
        crset             20
3:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange::u32::acquire_acquire:
        mr                6, 3
0:
        lwarx             3, 0, 6
        cmplw             3, 4
        bf-               2, 2f
        stwcx.            5, 0, 6
        bf-               2, 0b
        lwsync
        crset             20
1:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
2:
        crclr             20
        lwsync
        b                 1b

asm_test::compare_exchange::u32::acquire_relaxed:
        mr                6, 3
0:
        lwarx             3, 0, 6
        cmplw             3, 4
        bf-               2, 2f
        stwcx.            5, 0, 6
        bf-               2, 0b
        lwsync
        crset             20
1:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
2:
        crclr             20
        b                 1b

asm_test::compare_exchange::u32::relaxed_acquire:
        mr                6, 3
        crset             20
0:
        lwarx             3, 0, 6
        cmplw             3, 4
        bf-               2, 2f
        stwcx.            5, 0, 6
        bf-               2, 0b
1:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
2:
        crclr             20
        lwsync
        b                 1b

asm_test::compare_exchange::u32::relaxed_relaxed:
        mr                6, 3
        crset             20
0:
        lwarx             3, 0, 6
        cmplw             3, 4
        bf-               2, 2f
        stwcx.            5, 0, 6
        bf-               2, 0b
1:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
2:
        crclr             20
        b                 1b

asm_test::compare_exchange::u32::release_acquire:
        mr                6, 3
        lwarx             3, 0, 3
        cmplw             3, 4
        bf-               2, 1f
        crset             20
        lwsync
0:
        stwcx.            5, 0, 6
        bt+               2, 2f
        lwarx             3, 0, 6
        cmplw             3, 4
        bt+               2, 0b
1:
        crclr             20
        lwsync
2:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange::u32::release_relaxed:
        mr                6, 3
        lwarx             3, 0, 3
        cmplw             3, 4
        bf-               2, 1f
        crset             20
        lwsync
0:
        stwcx.            5, 0, 6
        bt+               2, 2f
        lwarx             3, 0, 6
        cmplw             3, 4
        bt+               2, 0b
1:
        crclr             20
2:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange::u64::acqrel_seqcst:
        mr                6, 3
        ldarx             3, 0, 3
        cmpld             3, 4
        bf-               2, 1f
        lwsync
0:
        stdcx.            5, 0, 6
        bt+               2, 2f
        ldarx             3, 0, 6
        cmpld             3, 4
        bt+               2, 0b
1:
        crclr             20
        lwsync
        b                 3f
2:
        lwsync
        crset             20
3:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange::u64::seqcst_seqcst:
        mr                6, 3
        ldarx             3, 0, 3
        cmpld             3, 4
        bf-               2, 1f
        sync
0:
        stdcx.            5, 0, 6
        bt+               2, 2f
        ldarx             3, 0, 6
        cmpld             3, 4
        bt+               2, 0b
1:
        crclr             20
        lwsync
        b                 3f
2:
        lwsync
        crset             20
3:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange::u64::acqrel_acquire:
        mr                6, 3
        ldarx             3, 0, 3
        cmpld             3, 4
        bf-               2, 1f
        lwsync
0:
        stdcx.            5, 0, 6
        bt+               2, 2f
        ldarx             3, 0, 6
        cmpld             3, 4
        bt+               2, 0b
1:
        crclr             20
        lwsync
        b                 3f
2:
        lwsync
        crset             20
3:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange::u64::acqrel_relaxed:
        mr                6, 3
        ldarx             3, 0, 3
        cmpld             3, 4
        bf-               2, 1f
        lwsync
0:
        stdcx.            5, 0, 6
        bt+               2, 2f
        ldarx             3, 0, 6
        cmpld             3, 4
        bt+               2, 0b
1:
        crclr             20
        b                 3f
2:
        lwsync
        crset             20
3:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange::u64::acquire_seqcst:
        mr                6, 3
0:
        ldarx             3, 0, 6
        cmpld             3, 4
        bf-               2, 2f
        stdcx.            5, 0, 6
        bf-               2, 0b
        lwsync
        crset             20
1:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
2:
        crclr             20
        lwsync
        b                 1b

asm_test::compare_exchange::u64::relaxed_seqcst:
        mr                6, 3
        crset             20
0:
        ldarx             3, 0, 6
        cmpld             3, 4
        bf-               2, 2f
        stdcx.            5, 0, 6
        bf-               2, 0b
1:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
2:
        crclr             20
        lwsync
        b                 1b

asm_test::compare_exchange::u64::release_seqcst:
        mr                6, 3
        ldarx             3, 0, 3
        cmpld             3, 4
        bf-               2, 1f
        crset             20
        lwsync
0:
        stdcx.            5, 0, 6
        bt+               2, 2f
        ldarx             3, 0, 6
        cmpld             3, 4
        bt+               2, 0b
1:
        crclr             20
        lwsync
2:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange::u64::seqcst_acquire:
        mr                6, 3
        ldarx             3, 0, 3
        cmpld             3, 4
        bf-               2, 1f
        sync
0:
        stdcx.            5, 0, 6
        bt+               2, 2f
        ldarx             3, 0, 6
        cmpld             3, 4
        bt+               2, 0b
1:
        crclr             20
        lwsync
        b                 3f
2:
        lwsync
        crset             20
3:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange::u64::seqcst_relaxed:
        mr                6, 3
        ldarx             3, 0, 3
        cmpld             3, 4
        bf-               2, 1f
        sync
0:
        stdcx.            5, 0, 6
        bt+               2, 2f
        ldarx             3, 0, 6
        cmpld             3, 4
        bt+               2, 0b
1:
        crclr             20
        b                 3f
2:
        lwsync
        crset             20
3:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange::u64::acquire_acquire:
        mr                6, 3
0:
        ldarx             3, 0, 6
        cmpld             3, 4
        bf-               2, 2f
        stdcx.            5, 0, 6
        bf-               2, 0b
        lwsync
        crset             20
1:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
2:
        crclr             20
        lwsync
        b                 1b

asm_test::compare_exchange::u64::acquire_relaxed:
        mr                6, 3
0:
        ldarx             3, 0, 6
        cmpld             3, 4
        bf-               2, 2f
        stdcx.            5, 0, 6
        bf-               2, 0b
        lwsync
        crset             20
1:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
2:
        crclr             20
        b                 1b

asm_test::compare_exchange::u64::relaxed_acquire:
        mr                6, 3
        crset             20
0:
        ldarx             3, 0, 6
        cmpld             3, 4
        bf-               2, 2f
        stdcx.            5, 0, 6
        bf-               2, 0b
1:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
2:
        crclr             20
        lwsync
        b                 1b

asm_test::compare_exchange::u64::relaxed_relaxed:
        mr                6, 3
        crset             20
0:
        ldarx             3, 0, 6
        cmpld             3, 4
        bf-               2, 2f
        stdcx.            5, 0, 6
        bf-               2, 0b
1:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
2:
        crclr             20
        b                 1b

asm_test::compare_exchange::u64::release_acquire:
        mr                6, 3
        ldarx             3, 0, 3
        cmpld             3, 4
        bf-               2, 1f
        crset             20
        lwsync
0:
        stdcx.            5, 0, 6
        bt+               2, 2f
        ldarx             3, 0, 6
        cmpld             3, 4
        bt+               2, 0b
1:
        crclr             20
        lwsync
2:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange::u64::release_relaxed:
        mr                6, 3
        ldarx             3, 0, 3
        cmpld             3, 4
        bf-               2, 1f
        crset             20
        lwsync
0:
        stdcx.            5, 0, 6
        bt+               2, 2f
        ldarx             3, 0, 6
        cmpld             3, 4
        bt+               2, 0b
1:
        crclr             20
2:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        rldicr            6, 3, 0, 61
        clrlwi            8, 4, 24
        lwarx             4, 0, 6
        not               3, 3
        rlwinm            7, 3, 3, 27, 28
        srw               3, 4, 7
        clrlwi            9, 3, 24
        cmplw             9, 8
        bf-               2, 1f
        li                8, 255
        clrlwi            5, 5, 24
        lwsync
        slw               8, 8, 7
        slw               5, 5, 7
        not               8, 8
        and               4, 4, 8
        or                4, 4, 5
        stwcx.            4, 0, 6
        bf-               2, 1f
        lwsync
        crset             20
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        lwsync
        b                 0b

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        rldicr            6, 3, 0, 61
        clrlwi            8, 4, 24
        lwarx             4, 0, 6
        not               3, 3
        rlwinm            7, 3, 3, 27, 28
        srw               3, 4, 7
        clrlwi            9, 3, 24
        cmplw             9, 8
        bf-               2, 1f
        li                8, 255
        clrlwi            5, 5, 24
        sync
        slw               8, 8, 7
        slw               5, 5, 7
        not               8, 8
        and               4, 4, 8
        or                4, 4, 5
        stwcx.            4, 0, 6
        bf-               2, 1f
        lwsync
        crset             20
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        lwsync
        b                 0b

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        rldicr            6, 3, 0, 61
        clrlwi            8, 4, 24
        lwarx             4, 0, 6
        not               3, 3
        rlwinm            7, 3, 3, 27, 28
        srw               3, 4, 7
        clrlwi            9, 3, 24
        cmplw             9, 8
        bf-               2, 1f
        li                8, 255
        clrlwi            5, 5, 24
        lwsync
        slw               8, 8, 7
        slw               5, 5, 7
        not               8, 8
        and               4, 4, 8
        or                4, 4, 5
        stwcx.            4, 0, 6
        bf-               2, 1f
        lwsync
        crset             20
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        lwsync
        b                 0b

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        rldicr            6, 3, 0, 61
        clrlwi            8, 4, 24
        crclr             20
        lwarx             4, 0, 6
        not               3, 3
        rlwinm            7, 3, 3, 27, 28
        srw               3, 4, 7
        clrlwi            9, 3, 24
        cmplw             9, 8
        bf-               2, 0f
        li                8, 255
        clrlwi            5, 5, 24
        lwsync
        slw               8, 8, 7
        slw               5, 5, 7
        not               8, 8
        and               4, 4, 8
        or                4, 4, 5
        stwcx.            4, 0, 6
        bf-               2, 0f
        crset             20
        lwsync
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        rldicr            6, 3, 0, 61
        clrlwi            8, 4, 24
        lwarx             4, 0, 6
        not               3, 3
        rlwinm            7, 3, 3, 27, 28
        srw               3, 4, 7
        clrlwi            9, 3, 24
        cmplw             9, 8
        bf-               2, 1f
        li                8, 255
        clrlwi            5, 5, 24
        slw               8, 8, 7
        slw               5, 5, 7
        not               8, 8
        and               4, 4, 8
        or                4, 4, 5
        stwcx.            4, 0, 6
        bf-               2, 1f
        lwsync
        crset             20
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        lwsync
        b                 0b

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        rldicr            6, 3, 0, 61
        clrlwi            8, 4, 24
        lwarx             4, 0, 6
        not               3, 3
        rlwinm            7, 3, 3, 27, 28
        srw               3, 4, 7
        clrlwi            9, 3, 24
        cmplw             9, 8
        bf-               2, 1f
        li                8, 255
        clrlwi            5, 5, 24
        crset             20
        slw               8, 8, 7
        slw               5, 5, 7
        not               8, 8
        and               4, 4, 8
        or                4, 4, 5
        stwcx.            4, 0, 6
        bf-               2, 1f
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        lwsync
        b                 0b

asm_test::compare_exchange_weak::u8::release_seqcst:
        rldicr            6, 3, 0, 61
        clrlwi            8, 4, 24
        lwarx             4, 0, 6
        not               3, 3
        rlwinm            7, 3, 3, 27, 28
        srw               3, 4, 7
        clrlwi            9, 3, 24
        cmplw             9, 8
        bf-               2, 1f
        li                8, 255
        clrlwi            5, 5, 24
        lwsync
        crset             20
        slw               8, 8, 7
        slw               5, 5, 7
        not               8, 8
        and               4, 4, 8
        or                4, 4, 5
        stwcx.            4, 0, 6
        bf-               2, 1f
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        lwsync
        b                 0b

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        rldicr            6, 3, 0, 61
        clrlwi            8, 4, 24
        lwarx             4, 0, 6
        not               3, 3
        rlwinm            7, 3, 3, 27, 28
        srw               3, 4, 7
        clrlwi            9, 3, 24
        cmplw             9, 8
        bf-               2, 1f
        li                8, 255
        clrlwi            5, 5, 24
        sync
        slw               8, 8, 7
        slw               5, 5, 7
        not               8, 8
        and               4, 4, 8
        or                4, 4, 5
        stwcx.            4, 0, 6
        bf-               2, 1f
        lwsync
        crset             20
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        lwsync
        b                 0b

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        rldicr            6, 3, 0, 61
        clrlwi            8, 4, 24
        crclr             20
        lwarx             4, 0, 6
        not               3, 3
        rlwinm            7, 3, 3, 27, 28
        srw               3, 4, 7
        clrlwi            9, 3, 24
        cmplw             9, 8
        bf-               2, 0f
        li                8, 255
        clrlwi            5, 5, 24
        sync
        slw               8, 8, 7
        slw               5, 5, 7
        not               8, 8
        and               4, 4, 8
        or                4, 4, 5
        stwcx.            4, 0, 6
        bf-               2, 0f
        crset             20
        lwsync
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange_weak::u8::acquire_acquire:
        rldicr            6, 3, 0, 61
        clrlwi            8, 4, 24
        lwarx             4, 0, 6
        not               3, 3
        rlwinm            7, 3, 3, 27, 28
        srw               3, 4, 7
        clrlwi            9, 3, 24
        cmplw             9, 8
        bf-               2, 1f
        li                8, 255
        clrlwi            5, 5, 24
        slw               8, 8, 7
        slw               5, 5, 7
        not               8, 8
        and               4, 4, 8
        or                4, 4, 5
        stwcx.            4, 0, 6
        bf-               2, 1f
        lwsync
        crset             20
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        lwsync
        b                 0b

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        rldicr            6, 3, 0, 61
        clrlwi            8, 4, 24
        crclr             20
        lwarx             4, 0, 6
        not               3, 3
        rlwinm            7, 3, 3, 27, 28
        srw               3, 4, 7
        clrlwi            9, 3, 24
        cmplw             9, 8
        bf-               2, 0f
        li                8, 255
        clrlwi            5, 5, 24
        slw               8, 8, 7
        slw               5, 5, 7
        not               8, 8
        and               4, 4, 8
        or                4, 4, 5
        stwcx.            4, 0, 6
        bf-               2, 0f
        crset             20
        lwsync
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        rldicr            6, 3, 0, 61
        clrlwi            8, 4, 24
        lwarx             4, 0, 6
        not               3, 3
        rlwinm            7, 3, 3, 27, 28
        srw               3, 4, 7
        clrlwi            9, 3, 24
        cmplw             9, 8
        bf-               2, 1f
        li                8, 255
        clrlwi            5, 5, 24
        crset             20
        slw               8, 8, 7
        slw               5, 5, 7
        not               8, 8
        and               4, 4, 8
        or                4, 4, 5
        stwcx.            4, 0, 6
        bf-               2, 1f
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        lwsync
        b                 0b

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        rldicr            6, 3, 0, 61
        clrlwi            8, 4, 24
        lwarx             4, 0, 6
        not               3, 3
        rlwinm            7, 3, 3, 27, 28
        srw               3, 4, 7
        clrlwi            9, 3, 24
        cmplw             9, 8
        bf-               2, 1f
        li                8, 255
        clrlwi            5, 5, 24
        crset             20
        slw               8, 8, 7
        slw               5, 5, 7
        not               8, 8
        and               4, 4, 8
        or                4, 4, 5
        stwcx.            4, 0, 6
        bf-               2, 1f
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        b                 0b

asm_test::compare_exchange_weak::u8::release_acquire:
        rldicr            6, 3, 0, 61
        clrlwi            8, 4, 24
        lwarx             4, 0, 6
        not               3, 3
        rlwinm            7, 3, 3, 27, 28
        srw               3, 4, 7
        clrlwi            9, 3, 24
        cmplw             9, 8
        bf-               2, 1f
        li                8, 255
        clrlwi            5, 5, 24
        lwsync
        crset             20
        slw               8, 8, 7
        slw               5, 5, 7
        not               8, 8
        and               4, 4, 8
        or                4, 4, 5
        stwcx.            4, 0, 6
        bf-               2, 1f
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        lwsync
        b                 0b

asm_test::compare_exchange_weak::u8::release_relaxed:
        rldicr            6, 3, 0, 61
        clrlwi            8, 4, 24
        lwarx             4, 0, 6
        not               3, 3
        rlwinm            7, 3, 3, 27, 28
        srw               3, 4, 7
        clrlwi            9, 3, 24
        cmplw             9, 8
        bf-               2, 1f
        li                8, 255
        clrlwi            5, 5, 24
        lwsync
        crset             20
        slw               8, 8, 7
        slw               5, 5, 7
        not               8, 8
        and               4, 4, 8
        or                4, 4, 5
        stwcx.            4, 0, 6
        bf-               2, 1f
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        b                 0b

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        clrlwi            8, 4, 16
        rldicr            4, 3, 0, 61
        lwarx             6, 0, 4
        clrlwi            3, 3, 30
        xori              3, 3, 2
        slwi              7, 3, 3
        srw               3, 6, 7
        clrlwi            9, 3, 16
        cmplw             9, 8
        bf-               2, 1f
        lis               8, 0
        clrlwi            5, 5, 16
        lwsync
        ori               8, 8, 65535
        slw               5, 5, 7
        slw               8, 8, 7
        not               8, 8
        and               6, 6, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
        bf-               2, 1f
        lwsync
        crset             20
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        lwsync
        b                 0b

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        clrlwi            8, 4, 16
        rldicr            4, 3, 0, 61
        lwarx             6, 0, 4
        clrlwi            3, 3, 30
        xori              3, 3, 2
        slwi              7, 3, 3
        srw               3, 6, 7
        clrlwi            9, 3, 16
        cmplw             9, 8
        bf-               2, 1f
        lis               8, 0
        clrlwi            5, 5, 16
        sync
        ori               8, 8, 65535
        slw               5, 5, 7
        slw               8, 8, 7
        not               8, 8
        and               6, 6, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
        bf-               2, 1f
        lwsync
        crset             20
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        lwsync
        b                 0b

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        clrlwi            8, 4, 16
        rldicr            4, 3, 0, 61
        lwarx             6, 0, 4
        clrlwi            3, 3, 30
        xori              3, 3, 2
        slwi              7, 3, 3
        srw               3, 6, 7
        clrlwi            9, 3, 16
        cmplw             9, 8
        bf-               2, 1f
        lis               8, 0
        clrlwi            5, 5, 16
        lwsync
        ori               8, 8, 65535
        slw               5, 5, 7
        slw               8, 8, 7
        not               8, 8
        and               6, 6, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
        bf-               2, 1f
        lwsync
        crset             20
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        lwsync
        b                 0b

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        clrlwi            8, 4, 16
        rldicr            4, 3, 0, 61
        crclr             20
        lwarx             6, 0, 4
        clrlwi            3, 3, 30
        xori              3, 3, 2
        slwi              7, 3, 3
        srw               3, 6, 7
        clrlwi            9, 3, 16
        cmplw             9, 8
        bf-               2, 0f
        lis               8, 0
        clrlwi            5, 5, 16
        lwsync
        ori               8, 8, 65535
        slw               5, 5, 7
        slw               8, 8, 7
        not               8, 8
        and               6, 6, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
        bf-               2, 0f
        crset             20
        lwsync
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        clrlwi            8, 4, 16
        rldicr            4, 3, 0, 61
        lwarx             6, 0, 4
        clrlwi            3, 3, 30
        xori              3, 3, 2
        slwi              7, 3, 3
        srw               3, 6, 7
        clrlwi            9, 3, 16
        cmplw             9, 8
        bf-               2, 1f
        lis               8, 0
        clrlwi            5, 5, 16
        ori               8, 8, 65535
        slw               5, 5, 7
        slw               8, 8, 7
        not               8, 8
        and               6, 6, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
        bf-               2, 1f
        lwsync
        crset             20
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        lwsync
        b                 0b

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        clrlwi            8, 4, 16
        rldicr            4, 3, 0, 61
        lwarx             6, 0, 4
        clrlwi            3, 3, 30
        xori              3, 3, 2
        slwi              7, 3, 3
        srw               3, 6, 7
        clrlwi            9, 3, 16
        cmplw             9, 8
        bf-               2, 1f
        lis               8, 0
        clrlwi            5, 5, 16
        crset             20
        ori               8, 8, 65535
        slw               5, 5, 7
        slw               8, 8, 7
        not               8, 8
        and               6, 6, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
        bf-               2, 1f
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        lwsync
        b                 0b

asm_test::compare_exchange_weak::u16::release_seqcst:
        clrlwi            8, 4, 16
        rldicr            4, 3, 0, 61
        lwarx             6, 0, 4
        clrlwi            3, 3, 30
        xori              3, 3, 2
        slwi              7, 3, 3
        srw               3, 6, 7
        clrlwi            9, 3, 16
        cmplw             9, 8
        bf-               2, 1f
        lis               8, 0
        clrlwi            5, 5, 16
        lwsync
        crset             20
        ori               8, 8, 65535
        slw               5, 5, 7
        slw               8, 8, 7
        not               8, 8
        and               6, 6, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
        bf-               2, 1f
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        lwsync
        b                 0b

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        clrlwi            8, 4, 16
        rldicr            4, 3, 0, 61
        lwarx             6, 0, 4
        clrlwi            3, 3, 30
        xori              3, 3, 2
        slwi              7, 3, 3
        srw               3, 6, 7
        clrlwi            9, 3, 16
        cmplw             9, 8
        bf-               2, 1f
        lis               8, 0
        clrlwi            5, 5, 16
        sync
        ori               8, 8, 65535
        slw               5, 5, 7
        slw               8, 8, 7
        not               8, 8
        and               6, 6, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
        bf-               2, 1f
        lwsync
        crset             20
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        lwsync
        b                 0b

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        clrlwi            8, 4, 16
        rldicr            4, 3, 0, 61
        crclr             20
        lwarx             6, 0, 4
        clrlwi            3, 3, 30
        xori              3, 3, 2
        slwi              7, 3, 3
        srw               3, 6, 7
        clrlwi            9, 3, 16
        cmplw             9, 8
        bf-               2, 0f
        lis               8, 0
        clrlwi            5, 5, 16
        sync
        ori               8, 8, 65535
        slw               5, 5, 7
        slw               8, 8, 7
        not               8, 8
        and               6, 6, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
        bf-               2, 0f
        crset             20
        lwsync
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange_weak::u16::acquire_acquire:
        clrlwi            8, 4, 16
        rldicr            4, 3, 0, 61
        lwarx             6, 0, 4
        clrlwi            3, 3, 30
        xori              3, 3, 2
        slwi              7, 3, 3
        srw               3, 6, 7
        clrlwi            9, 3, 16
        cmplw             9, 8
        bf-               2, 1f
        lis               8, 0
        clrlwi            5, 5, 16
        ori               8, 8, 65535
        slw               5, 5, 7
        slw               8, 8, 7
        not               8, 8
        and               6, 6, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
        bf-               2, 1f
        lwsync
        crset             20
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        lwsync
        b                 0b

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        clrlwi            8, 4, 16
        rldicr            4, 3, 0, 61
        crclr             20
        lwarx             6, 0, 4
        clrlwi            3, 3, 30
        xori              3, 3, 2
        slwi              7, 3, 3
        srw               3, 6, 7
        clrlwi            9, 3, 16
        cmplw             9, 8
        bf-               2, 0f
        lis               8, 0
        clrlwi            5, 5, 16
        ori               8, 8, 65535
        slw               5, 5, 7
        slw               8, 8, 7
        not               8, 8
        and               6, 6, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
        bf-               2, 0f
        crset             20
        lwsync
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        clrlwi            8, 4, 16
        rldicr            4, 3, 0, 61
        lwarx             6, 0, 4
        clrlwi            3, 3, 30
        xori              3, 3, 2
        slwi              7, 3, 3
        srw               3, 6, 7
        clrlwi            9, 3, 16
        cmplw             9, 8
        bf-               2, 1f
        lis               8, 0
        clrlwi            5, 5, 16
        crset             20
        ori               8, 8, 65535
        slw               5, 5, 7
        slw               8, 8, 7
        not               8, 8
        and               6, 6, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
        bf-               2, 1f
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        lwsync
        b                 0b

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        clrlwi            8, 4, 16
        rldicr            4, 3, 0, 61
        lwarx             6, 0, 4
        clrlwi            3, 3, 30
        xori              3, 3, 2
        slwi              7, 3, 3
        srw               3, 6, 7
        clrlwi            9, 3, 16
        cmplw             9, 8
        bf-               2, 1f
        lis               8, 0
        clrlwi            5, 5, 16
        crset             20
        ori               8, 8, 65535
        slw               5, 5, 7
        slw               8, 8, 7
        not               8, 8
        and               6, 6, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
        bf-               2, 1f
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        b                 0b

asm_test::compare_exchange_weak::u16::release_acquire:
        clrlwi            8, 4, 16
        rldicr            4, 3, 0, 61
        lwarx             6, 0, 4
        clrlwi            3, 3, 30
        xori              3, 3, 2
        slwi              7, 3, 3
        srw               3, 6, 7
        clrlwi            9, 3, 16
        cmplw             9, 8
        bf-               2, 1f
        lis               8, 0
        clrlwi            5, 5, 16
        lwsync
        crset             20
        ori               8, 8, 65535
        slw               5, 5, 7
        slw               8, 8, 7
        not               8, 8
        and               6, 6, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
        bf-               2, 1f
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        lwsync
        b                 0b

asm_test::compare_exchange_weak::u16::release_relaxed:
        clrlwi            8, 4, 16
        rldicr            4, 3, 0, 61
        lwarx             6, 0, 4
        clrlwi            3, 3, 30
        xori              3, 3, 2
        slwi              7, 3, 3
        srw               3, 6, 7
        clrlwi            9, 3, 16
        cmplw             9, 8
        bf-               2, 1f
        lis               8, 0
        clrlwi            5, 5, 16
        lwsync
        crset             20
        ori               8, 8, 65535
        slw               5, 5, 7
        slw               8, 8, 7
        not               8, 8
        and               6, 6, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
        bf-               2, 1f
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        b                 0b

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        mr                6, 3
        lwarx             3, 0, 3
        cmplw             3, 4
        bf-               2, 1f
        lwsync
        stwcx.            5, 0, 6
        bf-               2, 1f
        lwsync
        crset             20
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        lwsync
        b                 0b

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        mr                6, 3
        lwarx             3, 0, 3
        cmplw             3, 4
        bf-               2, 1f
        sync
        stwcx.            5, 0, 6
        bf-               2, 1f
        lwsync
        crset             20
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        lwsync
        b                 0b

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        mr                6, 3
        lwarx             3, 0, 3
        cmplw             3, 4
        bf-               2, 1f
        lwsync
        stwcx.            5, 0, 6
        bf-               2, 1f
        lwsync
        crset             20
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        lwsync
        b                 0b

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        mr                6, 3
        lwarx             3, 0, 3
        crclr             20
        cmplw             3, 4
        bf-               2, 0f
        lwsync
        stwcx.            5, 0, 6
        bf-               2, 0f
        crset             20
        lwsync
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        mr                6, 3
        lwarx             3, 0, 3
        cmplw             3, 4
        bf-               2, 1f
        stwcx.            5, 0, 6
        bf-               2, 1f
        lwsync
        crset             20
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        lwsync
        b                 0b

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        mr                6, 3
        lwarx             3, 0, 3
        cmplw             3, 4
        bf-               2, 1f
        stwcx.            5, 0, 6
        crset             20
        bf-               2, 1f
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        lwsync
        b                 0b

asm_test::compare_exchange_weak::u32::release_seqcst:
        mr                6, 3
        lwarx             3, 0, 3
        cmplw             3, 4
        bf-               2, 1f
        lwsync
        crset             20
        stwcx.            5, 0, 6
        bf-               2, 1f
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        lwsync
        b                 0b

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        mr                6, 3
        lwarx             3, 0, 3
        cmplw             3, 4
        bf-               2, 1f
        sync
        stwcx.            5, 0, 6
        bf-               2, 1f
        lwsync
        crset             20
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        lwsync
        b                 0b

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        mr                6, 3
        lwarx             3, 0, 3
        crclr             20
        cmplw             3, 4
        bf-               2, 0f
        sync
        stwcx.            5, 0, 6
        bf-               2, 0f
        crset             20
        lwsync
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange_weak::u32::acquire_acquire:
        mr                6, 3
        lwarx             3, 0, 3
        cmplw             3, 4
        bf-               2, 1f
        stwcx.            5, 0, 6
        bf-               2, 1f
        lwsync
        crset             20
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        lwsync
        b                 0b

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        mr                6, 3
        lwarx             3, 0, 3
        crclr             20
        cmplw             3, 4
        bf-               2, 0f
        stwcx.            5, 0, 6
        bf-               2, 0f
        crset             20
        lwsync
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        mr                6, 3
        lwarx             3, 0, 3
        cmplw             3, 4
        bf-               2, 1f
        stwcx.            5, 0, 6
        crset             20
        bf-               2, 1f
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        lwsync
        b                 0b

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        mr                6, 3
        lwarx             3, 0, 3
        cmplw             3, 4
        bf-               2, 1f
        stwcx.            5, 0, 6
        crset             20
        bf-               2, 1f
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        b                 0b

asm_test::compare_exchange_weak::u32::release_acquire:
        mr                6, 3
        lwarx             3, 0, 3
        cmplw             3, 4
        bf-               2, 1f
        lwsync
        crset             20
        stwcx.            5, 0, 6
        bf-               2, 1f
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        lwsync
        b                 0b

asm_test::compare_exchange_weak::u32::release_relaxed:
        mr                6, 3
        lwarx             3, 0, 3
        cmplw             3, 4
        bf-               2, 1f
        lwsync
        crset             20
        stwcx.            5, 0, 6
        bf-               2, 1f
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        b                 0b

asm_test::compare_exchange_weak::u64::acqrel_seqcst:
        mr                6, 3
        ldarx             3, 0, 3
        cmpld             3, 4
        bf-               2, 1f
        lwsync
        stdcx.            5, 0, 6
        bf-               2, 1f
        lwsync
        crset             20
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        lwsync
        b                 0b

asm_test::compare_exchange_weak::u64::seqcst_seqcst:
        mr                6, 3
        ldarx             3, 0, 3
        cmpld             3, 4
        bf-               2, 1f
        sync
        stdcx.            5, 0, 6
        bf-               2, 1f
        lwsync
        crset             20
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        lwsync
        b                 0b

asm_test::compare_exchange_weak::u64::acqrel_acquire:
        mr                6, 3
        ldarx             3, 0, 3
        cmpld             3, 4
        bf-               2, 1f
        lwsync
        stdcx.            5, 0, 6
        bf-               2, 1f
        lwsync
        crset             20
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        lwsync
        b                 0b

asm_test::compare_exchange_weak::u64::acqrel_relaxed:
        mr                6, 3
        ldarx             3, 0, 3
        crclr             20
        cmpld             3, 4
        bf-               2, 0f
        lwsync
        stdcx.            5, 0, 6
        bf-               2, 0f
        crset             20
        lwsync
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange_weak::u64::acquire_seqcst:
        mr                6, 3
        ldarx             3, 0, 3
        cmpld             3, 4
        bf-               2, 1f
        stdcx.            5, 0, 6
        bf-               2, 1f
        lwsync
        crset             20
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        lwsync
        b                 0b

asm_test::compare_exchange_weak::u64::relaxed_seqcst:
        mr                6, 3
        ldarx             3, 0, 3
        cmpld             3, 4
        bf-               2, 1f
        stdcx.            5, 0, 6
        crset             20
        bf-               2, 1f
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        lwsync
        b                 0b

asm_test::compare_exchange_weak::u64::release_seqcst:
        mr                6, 3
        ldarx             3, 0, 3
        cmpld             3, 4
        bf-               2, 1f
        lwsync
        crset             20
        stdcx.            5, 0, 6
        bf-               2, 1f
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        lwsync
        b                 0b

asm_test::compare_exchange_weak::u64::seqcst_acquire:
        mr                6, 3
        ldarx             3, 0, 3
        cmpld             3, 4
        bf-               2, 1f
        sync
        stdcx.            5, 0, 6
        bf-               2, 1f
        lwsync
        crset             20
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        lwsync
        b                 0b

asm_test::compare_exchange_weak::u64::seqcst_relaxed:
        mr                6, 3
        ldarx             3, 0, 3
        crclr             20
        cmpld             3, 4
        bf-               2, 0f
        sync
        stdcx.            5, 0, 6
        bf-               2, 0f
        crset             20
        lwsync
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange_weak::u64::acquire_acquire:
        mr                6, 3
        ldarx             3, 0, 3
        cmpld             3, 4
        bf-               2, 1f
        stdcx.            5, 0, 6
        bf-               2, 1f
        lwsync
        crset             20
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        lwsync
        b                 0b

asm_test::compare_exchange_weak::u64::acquire_relaxed:
        mr                6, 3
        ldarx             3, 0, 3
        crclr             20
        cmpld             3, 4
        bf-               2, 0f
        stdcx.            5, 0, 6
        bf-               2, 0f
        crset             20
        lwsync
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr

asm_test::compare_exchange_weak::u64::relaxed_acquire:
        mr                6, 3
        ldarx             3, 0, 3
        cmpld             3, 4
        bf-               2, 1f
        stdcx.            5, 0, 6
        crset             20
        bf-               2, 1f
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        lwsync
        b                 0b

asm_test::compare_exchange_weak::u64::relaxed_relaxed:
        mr                6, 3
        ldarx             3, 0, 3
        cmpld             3, 4
        bf-               2, 1f
        stdcx.            5, 0, 6
        crset             20
        bf-               2, 1f
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        b                 0b

asm_test::compare_exchange_weak::u64::release_acquire:
        mr                6, 3
        ldarx             3, 0, 3
        cmpld             3, 4
        bf-               2, 1f
        lwsync
        crset             20
        stdcx.            5, 0, 6
        bf-               2, 1f
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        lwsync
        b                 0b

asm_test::compare_exchange_weak::u64::release_relaxed:
        mr                6, 3
        ldarx             3, 0, 3
        cmpld             3, 4
        bf-               2, 1f
        lwsync
        crset             20
        stdcx.            5, 0, 6
        bf-               2, 1f
0:
        li                4, 1
        bclr              12, 20
        li                4, 0
        blr
1:
        crclr             20
        b                 0b

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

asm_test::swap::u8::acqrel:
        rlwinm            5, 3, 3, 27, 28
        li                6, 255
        lwsync
        xori              5, 5, 24
        rldicr            3, 3, 0, 61
        slw               7, 4, 5
        slw               4, 6, 5
        and               6, 7, 4
0:
        lwarx             7, 0, 3
        andc              8, 7, 4
        or                8, 6, 8
        stwcx.            8, 0, 3
        bf-               2, 0b
        srw               3, 7, 5
        lwsync
        clrlwi            3, 3, 24
        blr

asm_test::swap::u8::seqcst:
        rlwinm            5, 3, 3, 27, 28
        li                6, 255
        sync
        xori              5, 5, 24
        rldicr            3, 3, 0, 61
        slw               7, 4, 5
        slw               4, 6, 5
        and               6, 7, 4
0:
        lwarx             7, 0, 3
        andc              8, 7, 4
        or                8, 6, 8
        stwcx.            8, 0, 3
        bf-               2, 0b
        srw               3, 7, 5
        lwsync
        clrlwi            3, 3, 24
        blr

asm_test::swap::u8::acquire:
        rlwinm            5, 3, 3, 27, 28
        li                6, 255
        xori              5, 5, 24
        rldicr            3, 3, 0, 61
        slw               7, 4, 5
        slw               4, 6, 5
        and               6, 7, 4
0:
        lwarx             7, 0, 3
        andc              8, 7, 4
        or                8, 6, 8
        stwcx.            8, 0, 3
        bf-               2, 0b
        srw               3, 7, 5
        lwsync
        clrlwi            3, 3, 24
        blr

asm_test::swap::u8::relaxed:
        rlwinm            5, 3, 3, 27, 28
        li                6, 255
        xori              5, 5, 24
        rldicr            3, 3, 0, 61
        slw               7, 4, 5
        slw               4, 6, 5
        and               6, 7, 4
0:
        lwarx             7, 0, 3
        andc              8, 7, 4
        or                8, 6, 8
        stwcx.            8, 0, 3
        bf-               2, 0b
        srw               3, 7, 5
        clrlwi            3, 3, 24
        blr

asm_test::swap::u8::release:
        rlwinm            5, 3, 3, 27, 28
        li                6, 255
        lwsync
        xori              5, 5, 24
        rldicr            3, 3, 0, 61
        slw               7, 4, 5
        slw               4, 6, 5
        and               6, 7, 4
0:
        lwarx             7, 0, 3
        andc              8, 7, 4
        or                8, 6, 8
        stwcx.            8, 0, 3
        bf-               2, 0b
        srw               3, 7, 5
        clrlwi            3, 3, 24
        blr

asm_test::swap::u16::acqrel:
        li                5, 0
        rlwinm            6, 3, 3, 27, 27
        lwsync
        ori               7, 5, 65535
        xori              5, 6, 16
        slw               6, 4, 5
        slw               4, 7, 5
        rldicr            3, 3, 0, 61
        and               6, 6, 4
0:
        lwarx             7, 0, 3
        andc              8, 7, 4
        or                8, 6, 8
        stwcx.            8, 0, 3
        bf-               2, 0b
        srw               3, 7, 5
        lwsync
        clrlwi            3, 3, 16
        blr

asm_test::swap::u16::seqcst:
        li                5, 0
        rlwinm            6, 3, 3, 27, 27
        sync
        ori               7, 5, 65535
        xori              5, 6, 16
        slw               6, 4, 5
        slw               4, 7, 5
        rldicr            3, 3, 0, 61
        and               6, 6, 4
0:
        lwarx             7, 0, 3
        andc              8, 7, 4
        or                8, 6, 8
        stwcx.            8, 0, 3
        bf-               2, 0b
        srw               3, 7, 5
        lwsync
        clrlwi            3, 3, 16
        blr

asm_test::swap::u16::acquire:
        li                5, 0
        rlwinm            6, 3, 3, 27, 27
        ori               7, 5, 65535
        xori              5, 6, 16
        slw               6, 4, 5
        slw               4, 7, 5
        rldicr            3, 3, 0, 61
        and               6, 6, 4
0:
        lwarx             7, 0, 3
        andc              8, 7, 4
        or                8, 6, 8
        stwcx.            8, 0, 3
        bf-               2, 0b
        srw               3, 7, 5
        lwsync
        clrlwi            3, 3, 16
        blr

asm_test::swap::u16::relaxed:
        li                5, 0
        rlwinm            6, 3, 3, 27, 27
        ori               7, 5, 65535
        xori              5, 6, 16
        slw               6, 4, 5
        slw               4, 7, 5
        rldicr            3, 3, 0, 61
        and               6, 6, 4
0:
        lwarx             7, 0, 3
        andc              8, 7, 4
        or                8, 6, 8
        stwcx.            8, 0, 3
        bf-               2, 0b
        srw               3, 7, 5
        clrlwi            3, 3, 16
        blr

asm_test::swap::u16::release:
        li                5, 0
        rlwinm            6, 3, 3, 27, 27
        lwsync
        ori               7, 5, 65535
        xori              5, 6, 16
        slw               6, 4, 5
        slw               4, 7, 5
        rldicr            3, 3, 0, 61
        and               6, 6, 4
0:
        lwarx             7, 0, 3
        andc              8, 7, 4
        or                8, 6, 8
        stwcx.            8, 0, 3
        bf-               2, 0b
        srw               3, 7, 5
        clrlwi            3, 3, 16
        blr

asm_test::swap::u32::acqrel:
        lwsync
0:
        lwarx             5, 0, 3
        stwcx.            4, 0, 3
        bf-               2, 0b
        mr                3, 5
        lwsync
        blr

asm_test::swap::u32::seqcst:
        sync
0:
        lwarx             5, 0, 3
        stwcx.            4, 0, 3
        bf-               2, 0b
        mr                3, 5
        lwsync
        blr

asm_test::swap::u32::acquire:
        mr                5, 3
0:
        lwarx             3, 0, 5
        stwcx.            4, 0, 5
        bf-               2, 0b
        lwsync
        blr

asm_test::swap::u32::relaxed:
0:
        lwarx             5, 0, 3
        stwcx.            4, 0, 3
        bf-               2, 0b
        mr                3, 5
        blr

asm_test::swap::u32::release:
        lwsync
0:
        lwarx             5, 0, 3
        stwcx.            4, 0, 3
        bf-               2, 0b
        mr                3, 5
        blr

asm_test::swap::u64::acqrel:
        lwsync
0:
        ldarx             5, 0, 3
        stdcx.            4, 0, 3
        bf-               2, 0b
        mr                3, 5
        lwsync
        blr

asm_test::swap::u64::seqcst:
        sync
0:
        ldarx             5, 0, 3
        stdcx.            4, 0, 3
        bf-               2, 0b
        mr                3, 5
        lwsync
        blr

asm_test::swap::u64::acquire:
        mr                5, 3
0:
        ldarx             3, 0, 5
        stdcx.            4, 0, 5
        bf-               2, 0b
        lwsync
        blr

asm_test::swap::u64::relaxed:
0:
        ldarx             5, 0, 3
        stdcx.            4, 0, 3
        bf-               2, 0b
        mr                3, 5
        blr

asm_test::swap::u64::release:
        lwsync
0:
        ldarx             5, 0, 3
        stdcx.            4, 0, 3
        bf-               2, 0b
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

