asm_test::compare_exchange::u8::acqrel_seqcst:
        clrlwi            6, 4, 24
        not               4, 3
        rlwinm            7, 3, 0, 0, 29
        rlwinm            3, 4, 3, 27, 28
        lwarx             4, 0, 7
        srw               8, 4, 3
        clrlwi            8, 8, 24
        cmplw             8, 6
        bf                2, 1f
        li                8, 255
        clrlwi            5, 5, 24
        lwsync
        slw               8, 8, 3
        slw               5, 5, 3
        not               8, 8
        nop
0:
        and               9, 4, 8
        or                9, 9, 5
        stwcx.            9, 0, 7
        bt                2, 2f
        lwarx             4, 0, 7
        srw               9, 4, 3
        clrlwi            9, 9, 24
        cmplw             9, 6
        bt                2, 0b
1:
        crclr             20
        lwsync
        b                 3f
2:
        lwsync
        crset             20
3:
        srw               3, 4, 3
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u8::seqcst_seqcst:
        clrlwi            6, 4, 24
        not               4, 3
        rlwinm            7, 3, 0, 0, 29
        rlwinm            3, 4, 3, 27, 28
        lwarx             4, 0, 7
        srw               8, 4, 3
        clrlwi            8, 8, 24
        cmplw             8, 6
        bf                2, 1f
        li                8, 255
        clrlwi            5, 5, 24
        sync
        slw               8, 8, 3
        slw               5, 5, 3
        not               8, 8
        nop
0:
        and               9, 4, 8
        or                9, 9, 5
        stwcx.            9, 0, 7
        bt                2, 2f
        lwarx             4, 0, 7
        srw               9, 4, 3
        clrlwi            9, 9, 24
        cmplw             9, 6
        bt                2, 0b
1:
        crclr             20
        lwsync
        b                 3f
2:
        lwsync
        crset             20
3:
        srw               3, 4, 3
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u8::acqrel_acquire:
        clrlwi            6, 4, 24
        not               4, 3
        rlwinm            7, 3, 0, 0, 29
        rlwinm            3, 4, 3, 27, 28
        lwarx             4, 0, 7
        srw               8, 4, 3
        clrlwi            8, 8, 24
        cmplw             8, 6
        bf                2, 1f
        li                8, 255
        clrlwi            5, 5, 24
        lwsync
        slw               8, 8, 3
        slw               5, 5, 3
        not               8, 8
        nop
0:
        and               9, 4, 8
        or                9, 9, 5
        stwcx.            9, 0, 7
        bt                2, 2f
        lwarx             4, 0, 7
        srw               9, 4, 3
        clrlwi            9, 9, 24
        cmplw             9, 6
        bt                2, 0b
1:
        crclr             20
        lwsync
        b                 3f
2:
        lwsync
        crset             20
3:
        srw               3, 4, 3
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u8::acqrel_relaxed:
        clrlwi            6, 4, 24
        not               4, 3
        rlwinm            7, 3, 0, 0, 29
        rlwinm            3, 4, 3, 27, 28
        lwarx             4, 0, 7
        srw               8, 4, 3
        clrlwi            8, 8, 24
        cmplw             8, 6
        bf                2, 1f
        li                8, 255
        clrlwi            5, 5, 24
        lwsync
        slw               8, 8, 3
        slw               5, 5, 3
        not               8, 8
        nop
0:
        and               9, 4, 8
        or                9, 9, 5
        stwcx.            9, 0, 7
        bt                2, 2f
        lwarx             4, 0, 7
        srw               9, 4, 3
        clrlwi            9, 9, 24
        cmplw             9, 6
        bt                2, 0b
1:
        crclr             20
        b                 3f
2:
        lwsync
        crset             20
3:
        srw               3, 4, 3
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u8::acquire_seqcst:
        not               7, 3
        rlwinm            6, 3, 0, 0, 29
        li                3, 255
        clrlwi            4, 4, 24
        rlwinm            7, 7, 3, 27, 28
        slw               3, 3, 7
        not               8, 3
        clrlwi            3, 5, 24
        slw               5, 3, 7
        nop
        nop
        nop
0:
        lwarx             9, 0, 6
        srw               3, 9, 7
        clrlwi            10, 3, 24
        cmplw             10, 4
        bf                2, 1f
        and               9, 9, 8
        or                9, 9, 5
        stwcx.            9, 0, 6
        bf                2, 0b
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crclr             20
        lwsync
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u8::relaxed_seqcst:
        not               7, 3
        rlwinm            6, 3, 0, 0, 29
        li                3, 255
        clrlwi            4, 4, 24
        rlwinm            7, 7, 3, 27, 28
        slw               3, 3, 7
        not               8, 3
        clrlwi            3, 5, 24
        slw               5, 3, 7
        nop
        nop
        nop
0:
        lwarx             9, 0, 6
        srw               3, 9, 7
        clrlwi            10, 3, 24
        cmplw             10, 4
        bf                2, 1f
        and               9, 9, 8
        or                9, 9, 5
        stwcx.            9, 0, 6
        bf                2, 0b
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crclr             20
        lwsync
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u8::release_seqcst:
        clrlwi            6, 4, 24
        not               4, 3
        rlwinm            7, 3, 0, 0, 29
        rlwinm            3, 4, 3, 27, 28
        lwarx             4, 0, 7
        srw               8, 4, 3
        clrlwi            8, 8, 24
        cmplw             8, 6
        bf                2, 1f
        li                8, 255
        clrlwi            5, 5, 24
        lwsync
        slw               8, 8, 3
        slw               5, 5, 3
        not               8, 8
        nop
0:
        and               9, 4, 8
        or                9, 9, 5
        stwcx.            9, 0, 7
        bt                2, 2f
        lwarx             4, 0, 7
        srw               9, 4, 3
        clrlwi            9, 9, 24
        cmplw             9, 6
        bt                2, 0b
1:
        crclr             20
        lwsync
        b                 3f
2:
        crset             20
3:
        srw               3, 4, 3
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u8::seqcst_acquire:
        clrlwi            6, 4, 24
        not               4, 3
        rlwinm            7, 3, 0, 0, 29
        rlwinm            3, 4, 3, 27, 28
        lwarx             4, 0, 7
        srw               8, 4, 3
        clrlwi            8, 8, 24
        cmplw             8, 6
        bf                2, 1f
        li                8, 255
        clrlwi            5, 5, 24
        sync
        slw               8, 8, 3
        slw               5, 5, 3
        not               8, 8
        nop
0:
        and               9, 4, 8
        or                9, 9, 5
        stwcx.            9, 0, 7
        bt                2, 2f
        lwarx             4, 0, 7
        srw               9, 4, 3
        clrlwi            9, 9, 24
        cmplw             9, 6
        bt                2, 0b
1:
        crclr             20
        lwsync
        b                 3f
2:
        lwsync
        crset             20
3:
        srw               3, 4, 3
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u8::seqcst_relaxed:
        clrlwi            6, 4, 24
        not               4, 3
        rlwinm            7, 3, 0, 0, 29
        rlwinm            3, 4, 3, 27, 28
        lwarx             4, 0, 7
        srw               8, 4, 3
        clrlwi            8, 8, 24
        cmplw             8, 6
        bf                2, 1f
        li                8, 255
        clrlwi            5, 5, 24
        sync
        slw               8, 8, 3
        slw               5, 5, 3
        not               8, 8
        nop
0:
        and               9, 4, 8
        or                9, 9, 5
        stwcx.            9, 0, 7
        bt                2, 2f
        lwarx             4, 0, 7
        srw               9, 4, 3
        clrlwi            9, 9, 24
        cmplw             9, 6
        bt                2, 0b
1:
        crclr             20
        b                 3f
2:
        lwsync
        crset             20
3:
        srw               3, 4, 3
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u8::acquire_acquire:
        not               7, 3
        rlwinm            6, 3, 0, 0, 29
        li                3, 255
        clrlwi            4, 4, 24
        rlwinm            7, 7, 3, 27, 28
        slw               3, 3, 7
        not               8, 3
        clrlwi            3, 5, 24
        slw               5, 3, 7
        nop
        nop
        nop
0:
        lwarx             9, 0, 6
        srw               3, 9, 7
        clrlwi            10, 3, 24
        cmplw             10, 4
        bf                2, 1f
        and               9, 9, 8
        or                9, 9, 5
        stwcx.            9, 0, 6
        bf                2, 0b
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crclr             20
        lwsync
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u8::acquire_relaxed:
        not               7, 3
        rlwinm            6, 3, 0, 0, 29
        li                3, 255
        clrlwi            4, 4, 24
        rlwinm            7, 7, 3, 27, 28
        slw               3, 3, 7
        not               8, 3
        clrlwi            3, 5, 24
        slw               5, 3, 7
        nop
        nop
        nop
0:
        lwarx             9, 0, 6
        srw               3, 9, 7
        clrlwi            10, 3, 24
        cmplw             10, 4
        bf                2, 1f
        and               9, 9, 8
        or                9, 9, 5
        stwcx.            9, 0, 6
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
        not               7, 3
        rlwinm            6, 3, 0, 0, 29
        li                3, 255
        clrlwi            4, 4, 24
        rlwinm            7, 7, 3, 27, 28
        slw               3, 3, 7
        not               8, 3
        clrlwi            3, 5, 24
        slw               5, 3, 7
        nop
        nop
        nop
0:
        lwarx             9, 0, 6
        srw               3, 9, 7
        clrlwi            10, 3, 24
        cmplw             10, 4
        bf                2, 1f
        and               9, 9, 8
        or                9, 9, 5
        stwcx.            9, 0, 6
        bf                2, 0b
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crclr             20
        lwsync
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u8::relaxed_relaxed:
        not               7, 3
        rlwinm            6, 3, 0, 0, 29
        li                3, 255
        clrlwi            4, 4, 24
        rlwinm            7, 7, 3, 27, 28
        slw               3, 3, 7
        not               8, 3
        clrlwi            3, 5, 24
        slw               5, 3, 7
        nop
        nop
        nop
0:
        lwarx             9, 0, 6
        srw               3, 9, 7
        clrlwi            10, 3, 24
        cmplw             10, 4
        bf                2, 1f
        and               9, 9, 8
        or                9, 9, 5
        stwcx.            9, 0, 6
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
        clrlwi            6, 4, 24
        not               4, 3
        rlwinm            7, 3, 0, 0, 29
        rlwinm            3, 4, 3, 27, 28
        lwarx             4, 0, 7
        srw               8, 4, 3
        clrlwi            8, 8, 24
        cmplw             8, 6
        bf                2, 1f
        li                8, 255
        clrlwi            5, 5, 24
        lwsync
        slw               8, 8, 3
        slw               5, 5, 3
        not               8, 8
        nop
0:
        and               9, 4, 8
        or                9, 9, 5
        stwcx.            9, 0, 7
        bt                2, 2f
        lwarx             4, 0, 7
        srw               9, 4, 3
        clrlwi            9, 9, 24
        cmplw             9, 6
        bt                2, 0b
1:
        crclr             20
        lwsync
        b                 3f
2:
        crset             20
3:
        srw               3, 4, 3
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u8::release_relaxed:
        clrlwi            6, 4, 24
        not               4, 3
        rlwinm            7, 3, 0, 0, 29
        rlwinm            3, 4, 3, 27, 28
        lwarx             4, 0, 7
        srw               8, 4, 3
        clrlwi            8, 8, 24
        cmplw             8, 6
        bf                2, 1f
        li                8, 255
        clrlwi            5, 5, 24
        lwsync
        slw               8, 8, 3
        slw               5, 5, 3
        not               8, 8
        nop
0:
        and               9, 4, 8
        or                9, 9, 5
        stwcx.            9, 0, 7
        bt                2, 2f
        lwarx             4, 0, 7
        srw               9, 4, 3
        clrlwi            9, 9, 24
        cmplw             9, 6
        bt                2, 0b
1:
        crclr             20
        b                 3f
2:
        crset             20
3:
        srw               3, 4, 3
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u16::acqrel_seqcst:
        rlwinm            7, 3, 0, 0, 29
        clrlwi            3, 3, 30
        xori              3, 3, 2
        clrlwi            6, 4, 16
        lwarx             4, 0, 7
        slwi              3, 3, 3
        srw               8, 4, 3
        clrlwi            8, 8, 16
        cmplw             8, 6
        bf                2, 1f
        lis               8, 0
        clrlwi            5, 5, 16
        lwsync
        ori               8, 8, 65535
        slw               5, 5, 3
        slw               8, 8, 3
        not               8, 8
        nop
        nop
        nop
0:
        and               9, 4, 8
        or                9, 9, 5
        stwcx.            9, 0, 7
        bt                2, 2f
        lwarx             4, 0, 7
        srw               9, 4, 3
        clrlwi            9, 9, 16
        cmplw             9, 6
        bt                2, 0b
1:
        crclr             20
        lwsync
        b                 3f
2:
        lwsync
        crset             20
3:
        srw               3, 4, 3
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u16::seqcst_seqcst:
        rlwinm            7, 3, 0, 0, 29
        clrlwi            3, 3, 30
        xori              3, 3, 2
        clrlwi            6, 4, 16
        lwarx             4, 0, 7
        slwi              3, 3, 3
        srw               8, 4, 3
        clrlwi            8, 8, 16
        cmplw             8, 6
        bf                2, 1f
        lis               8, 0
        clrlwi            5, 5, 16
        sync
        ori               8, 8, 65535
        slw               5, 5, 3
        slw               8, 8, 3
        not               8, 8
        nop
        nop
        nop
0:
        and               9, 4, 8
        or                9, 9, 5
        stwcx.            9, 0, 7
        bt                2, 2f
        lwarx             4, 0, 7
        srw               9, 4, 3
        clrlwi            9, 9, 16
        cmplw             9, 6
        bt                2, 0b
1:
        crclr             20
        lwsync
        b                 3f
2:
        lwsync
        crset             20
3:
        srw               3, 4, 3
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u16::acqrel_acquire:
        rlwinm            7, 3, 0, 0, 29
        clrlwi            3, 3, 30
        xori              3, 3, 2
        clrlwi            6, 4, 16
        lwarx             4, 0, 7
        slwi              3, 3, 3
        srw               8, 4, 3
        clrlwi            8, 8, 16
        cmplw             8, 6
        bf                2, 1f
        lis               8, 0
        clrlwi            5, 5, 16
        lwsync
        ori               8, 8, 65535
        slw               5, 5, 3
        slw               8, 8, 3
        not               8, 8
        nop
        nop
        nop
0:
        and               9, 4, 8
        or                9, 9, 5
        stwcx.            9, 0, 7
        bt                2, 2f
        lwarx             4, 0, 7
        srw               9, 4, 3
        clrlwi            9, 9, 16
        cmplw             9, 6
        bt                2, 0b
1:
        crclr             20
        lwsync
        b                 3f
2:
        lwsync
        crset             20
3:
        srw               3, 4, 3
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u16::acqrel_relaxed:
        rlwinm            7, 3, 0, 0, 29
        clrlwi            3, 3, 30
        xori              3, 3, 2
        clrlwi            6, 4, 16
        lwarx             4, 0, 7
        slwi              3, 3, 3
        srw               8, 4, 3
        clrlwi            8, 8, 16
        cmplw             8, 6
        bf                2, 1f
        lis               8, 0
        clrlwi            5, 5, 16
        lwsync
        ori               8, 8, 65535
        slw               5, 5, 3
        slw               8, 8, 3
        not               8, 8
        nop
        nop
        nop
0:
        and               9, 4, 8
        or                9, 9, 5
        stwcx.            9, 0, 7
        bt                2, 2f
        lwarx             4, 0, 7
        srw               9, 4, 3
        clrlwi            9, 9, 16
        cmplw             9, 6
        bt                2, 0b
1:
        crclr             20
        b                 3f
2:
        lwsync
        crset             20
3:
        srw               3, 4, 3
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u16::acquire_seqcst:
        rlwinm            6, 3, 0, 0, 29
        clrlwi            3, 3, 30
        xori              3, 3, 2
        clrlwi            4, 4, 16
        slwi              7, 3, 3
        lis               3, 0
        ori               3, 3, 65535
        slw               3, 3, 7
        not               8, 3
        clrlwi            3, 5, 16
        slw               5, 3, 7
        nop
0:
        lwarx             9, 0, 6
        srw               3, 9, 7
        clrlwi            10, 3, 16
        cmplw             10, 4
        bf                2, 1f
        and               9, 9, 8
        or                9, 9, 5
        stwcx.            9, 0, 6
        bf                2, 0b
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crclr             20
        lwsync
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u16::relaxed_seqcst:
        rlwinm            6, 3, 0, 0, 29
        clrlwi            3, 3, 30
        xori              3, 3, 2
        clrlwi            4, 4, 16
        slwi              7, 3, 3
        lis               3, 0
        ori               3, 3, 65535
        slw               3, 3, 7
        not               8, 3
        clrlwi            3, 5, 16
        slw               5, 3, 7
        nop
0:
        lwarx             9, 0, 6
        srw               3, 9, 7
        clrlwi            10, 3, 16
        cmplw             10, 4
        bf                2, 1f
        and               9, 9, 8
        or                9, 9, 5
        stwcx.            9, 0, 6
        bf                2, 0b
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crclr             20
        lwsync
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u16::release_seqcst:
        rlwinm            7, 3, 0, 0, 29
        clrlwi            3, 3, 30
        xori              3, 3, 2
        clrlwi            6, 4, 16
        lwarx             4, 0, 7
        slwi              3, 3, 3
        srw               8, 4, 3
        clrlwi            8, 8, 16
        cmplw             8, 6
        bf                2, 1f
        lis               8, 0
        clrlwi            5, 5, 16
        lwsync
        ori               8, 8, 65535
        slw               5, 5, 3
        slw               8, 8, 3
        not               8, 8
        nop
        nop
        nop
0:
        and               9, 4, 8
        or                9, 9, 5
        stwcx.            9, 0, 7
        bt                2, 2f
        lwarx             4, 0, 7
        srw               9, 4, 3
        clrlwi            9, 9, 16
        cmplw             9, 6
        bt                2, 0b
1:
        crclr             20
        lwsync
        b                 3f
2:
        crset             20
3:
        srw               3, 4, 3
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u16::seqcst_acquire:
        rlwinm            7, 3, 0, 0, 29
        clrlwi            3, 3, 30
        xori              3, 3, 2
        clrlwi            6, 4, 16
        lwarx             4, 0, 7
        slwi              3, 3, 3
        srw               8, 4, 3
        clrlwi            8, 8, 16
        cmplw             8, 6
        bf                2, 1f
        lis               8, 0
        clrlwi            5, 5, 16
        sync
        ori               8, 8, 65535
        slw               5, 5, 3
        slw               8, 8, 3
        not               8, 8
        nop
        nop
        nop
0:
        and               9, 4, 8
        or                9, 9, 5
        stwcx.            9, 0, 7
        bt                2, 2f
        lwarx             4, 0, 7
        srw               9, 4, 3
        clrlwi            9, 9, 16
        cmplw             9, 6
        bt                2, 0b
1:
        crclr             20
        lwsync
        b                 3f
2:
        lwsync
        crset             20
3:
        srw               3, 4, 3
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u16::seqcst_relaxed:
        rlwinm            7, 3, 0, 0, 29
        clrlwi            3, 3, 30
        xori              3, 3, 2
        clrlwi            6, 4, 16
        lwarx             4, 0, 7
        slwi              3, 3, 3
        srw               8, 4, 3
        clrlwi            8, 8, 16
        cmplw             8, 6
        bf                2, 1f
        lis               8, 0
        clrlwi            5, 5, 16
        sync
        ori               8, 8, 65535
        slw               5, 5, 3
        slw               8, 8, 3
        not               8, 8
        nop
        nop
        nop
0:
        and               9, 4, 8
        or                9, 9, 5
        stwcx.            9, 0, 7
        bt                2, 2f
        lwarx             4, 0, 7
        srw               9, 4, 3
        clrlwi            9, 9, 16
        cmplw             9, 6
        bt                2, 0b
1:
        crclr             20
        b                 3f
2:
        lwsync
        crset             20
3:
        srw               3, 4, 3
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u16::acquire_acquire:
        rlwinm            6, 3, 0, 0, 29
        clrlwi            3, 3, 30
        xori              3, 3, 2
        clrlwi            4, 4, 16
        slwi              7, 3, 3
        lis               3, 0
        ori               3, 3, 65535
        slw               3, 3, 7
        not               8, 3
        clrlwi            3, 5, 16
        slw               5, 3, 7
        nop
0:
        lwarx             9, 0, 6
        srw               3, 9, 7
        clrlwi            10, 3, 16
        cmplw             10, 4
        bf                2, 1f
        and               9, 9, 8
        or                9, 9, 5
        stwcx.            9, 0, 6
        bf                2, 0b
        lwsync
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crclr             20
        lwsync
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u16::acquire_relaxed:
        rlwinm            6, 3, 0, 0, 29
        clrlwi            3, 3, 30
        xori              3, 3, 2
        clrlwi            4, 4, 16
        slwi              7, 3, 3
        lis               3, 0
        ori               3, 3, 65535
        slw               3, 3, 7
        not               8, 3
        clrlwi            3, 5, 16
        slw               5, 3, 7
        nop
0:
        lwarx             9, 0, 6
        srw               3, 9, 7
        clrlwi            10, 3, 16
        cmplw             10, 4
        bf                2, 1f
        and               9, 9, 8
        or                9, 9, 5
        stwcx.            9, 0, 6
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
        rlwinm            6, 3, 0, 0, 29
        clrlwi            3, 3, 30
        xori              3, 3, 2
        clrlwi            4, 4, 16
        slwi              7, 3, 3
        lis               3, 0
        ori               3, 3, 65535
        slw               3, 3, 7
        not               8, 3
        clrlwi            3, 5, 16
        slw               5, 3, 7
        nop
0:
        lwarx             9, 0, 6
        srw               3, 9, 7
        clrlwi            10, 3, 16
        cmplw             10, 4
        bf                2, 1f
        and               9, 9, 8
        or                9, 9, 5
        stwcx.            9, 0, 6
        bf                2, 0b
        crset             20
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crclr             20
        lwsync
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u16::relaxed_relaxed:
        rlwinm            6, 3, 0, 0, 29
        clrlwi            3, 3, 30
        xori              3, 3, 2
        clrlwi            4, 4, 16
        slwi              7, 3, 3
        lis               3, 0
        ori               3, 3, 65535
        slw               3, 3, 7
        not               8, 3
        clrlwi            3, 5, 16
        slw               5, 3, 7
        nop
0:
        lwarx             9, 0, 6
        srw               3, 9, 7
        clrlwi            10, 3, 16
        cmplw             10, 4
        bf                2, 1f
        and               9, 9, 8
        or                9, 9, 5
        stwcx.            9, 0, 6
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
        rlwinm            7, 3, 0, 0, 29
        clrlwi            3, 3, 30
        xori              3, 3, 2
        clrlwi            6, 4, 16
        lwarx             4, 0, 7
        slwi              3, 3, 3
        srw               8, 4, 3
        clrlwi            8, 8, 16
        cmplw             8, 6
        bf                2, 1f
        lis               8, 0
        clrlwi            5, 5, 16
        lwsync
        ori               8, 8, 65535
        slw               5, 5, 3
        slw               8, 8, 3
        not               8, 8
        nop
        nop
        nop
0:
        and               9, 4, 8
        or                9, 9, 5
        stwcx.            9, 0, 7
        bt                2, 2f
        lwarx             4, 0, 7
        srw               9, 4, 3
        clrlwi            9, 9, 16
        cmplw             9, 6
        bt                2, 0b
1:
        crclr             20
        lwsync
        b                 3f
2:
        crset             20
3:
        srw               3, 4, 3
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange::u16::release_relaxed:
        rlwinm            7, 3, 0, 0, 29
        clrlwi            3, 3, 30
        xori              3, 3, 2
        clrlwi            6, 4, 16
        lwarx             4, 0, 7
        slwi              3, 3, 3
        srw               8, 4, 3
        clrlwi            8, 8, 16
        cmplw             8, 6
        bf                2, 1f
        lis               8, 0
        clrlwi            5, 5, 16
        lwsync
        ori               8, 8, 65535
        slw               5, 5, 3
        slw               8, 8, 3
        not               8, 8
        nop
        nop
        nop
0:
        and               9, 4, 8
        or                9, 9, 5
        stwcx.            9, 0, 7
        bt                2, 2f
        lwarx             4, 0, 7
        srw               9, 4, 3
        clrlwi            9, 9, 16
        cmplw             9, 6
        bt                2, 0b
1:
        crclr             20
        b                 3f
2:
        crset             20
3:
        srw               3, 4, 3
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
        crclr             20
        lwsync
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
        crclr             20
        lwsync
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
        crclr             20
        lwsync
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
        crclr             20
        lwsync
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
        crclr             20
        lwsync
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
        crclr             20
        lwsync
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
        crclr             20
        lwsync
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
        crclr             20
        lwsync
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
        crclr             20
        lwsync
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
        crclr             20
        lwsync
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

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        not               6, 3
        clrlwi            8, 4, 24
        rlwinm            4, 3, 0, 0, 29
        rlwinm            6, 6, 3, 27, 28
        lwarx             7, 0, 4
        srw               3, 7, 6
        clrlwi            9, 3, 24
        cmplw             9, 8
        bf                2, 0f
        li                8, 255
        clrlwi            5, 5, 24
        lwsync
        slw               8, 8, 6
        slw               5, 5, 6
        not               8, 8
        and               6, 7, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
        bt                2, 1f
0:
        crclr             20
        lwsync
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
        not               6, 3
        clrlwi            8, 4, 24
        rlwinm            4, 3, 0, 0, 29
        rlwinm            6, 6, 3, 27, 28
        lwarx             7, 0, 4
        srw               3, 7, 6
        clrlwi            9, 3, 24
        cmplw             9, 8
        bf                2, 0f
        li                8, 255
        clrlwi            5, 5, 24
        sync
        slw               8, 8, 6
        slw               5, 5, 6
        not               8, 8
        and               6, 7, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
        bt                2, 1f
0:
        crclr             20
        lwsync
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
        not               6, 3
        clrlwi            8, 4, 24
        rlwinm            4, 3, 0, 0, 29
        rlwinm            6, 6, 3, 27, 28
        lwarx             7, 0, 4
        srw               3, 7, 6
        clrlwi            9, 3, 24
        cmplw             9, 8
        bf                2, 0f
        li                8, 255
        clrlwi            5, 5, 24
        lwsync
        slw               8, 8, 6
        slw               5, 5, 6
        not               8, 8
        and               6, 7, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
        bt                2, 1f
0:
        crclr             20
        lwsync
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
        not               6, 3
        clrlwi            8, 4, 24
        crclr             20
        rlwinm            4, 3, 0, 0, 29
        rlwinm            6, 6, 3, 27, 28
        lwarx             7, 0, 4
        srw               3, 7, 6
        clrlwi            9, 3, 24
        cmplw             9, 8
        bf                2, 0f
        li                8, 255
        clrlwi            5, 5, 24
        lwsync
        slw               8, 8, 6
        slw               5, 5, 6
        not               8, 8
        and               6, 7, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
        bt                2, 1f
0:
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crset             20
        lwsync
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        not               6, 3
        clrlwi            8, 4, 24
        rlwinm            4, 3, 0, 0, 29
        rlwinm            6, 6, 3, 27, 28
        lwarx             7, 0, 4
        srw               3, 7, 6
        clrlwi            9, 3, 24
        cmplw             9, 8
        bf                2, 0f
        li                8, 255
        clrlwi            5, 5, 24
        slw               8, 8, 6
        slw               5, 5, 6
        not               8, 8
        and               6, 7, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
        bt                2, 1f
0:
        crclr             20
        lwsync
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
        not               6, 3
        clrlwi            8, 4, 24
        rlwinm            4, 3, 0, 0, 29
        rlwinm            6, 6, 3, 27, 28
        lwarx             7, 0, 4
        srw               3, 7, 6
        clrlwi            9, 3, 24
        cmplw             9, 8
        bf                2, 0f
        li                8, 255
        clrlwi            5, 5, 24
        slw               8, 8, 6
        slw               5, 5, 6
        not               8, 8
        and               6, 7, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
        bt                2, 1f
0:
        crclr             20
        lwsync
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
        not               6, 3
        clrlwi            8, 4, 24
        rlwinm            4, 3, 0, 0, 29
        rlwinm            6, 6, 3, 27, 28
        lwarx             7, 0, 4
        srw               3, 7, 6
        clrlwi            9, 3, 24
        cmplw             9, 8
        bf                2, 0f
        li                8, 255
        clrlwi            5, 5, 24
        lwsync
        slw               8, 8, 6
        slw               5, 5, 6
        not               8, 8
        and               6, 7, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
        bt                2, 1f
0:
        crclr             20
        lwsync
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
        not               6, 3
        clrlwi            8, 4, 24
        rlwinm            4, 3, 0, 0, 29
        rlwinm            6, 6, 3, 27, 28
        lwarx             7, 0, 4
        srw               3, 7, 6
        clrlwi            9, 3, 24
        cmplw             9, 8
        bf                2, 0f
        li                8, 255
        clrlwi            5, 5, 24
        sync
        slw               8, 8, 6
        slw               5, 5, 6
        not               8, 8
        and               6, 7, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
        bt                2, 1f
0:
        crclr             20
        lwsync
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
        not               6, 3
        clrlwi            8, 4, 24
        crclr             20
        rlwinm            4, 3, 0, 0, 29
        rlwinm            6, 6, 3, 27, 28
        lwarx             7, 0, 4
        srw               3, 7, 6
        clrlwi            9, 3, 24
        cmplw             9, 8
        bf                2, 0f
        li                8, 255
        clrlwi            5, 5, 24
        sync
        slw               8, 8, 6
        slw               5, 5, 6
        not               8, 8
        and               6, 7, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
        bt                2, 1f
0:
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crset             20
        lwsync
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u8::acquire_acquire:
        not               6, 3
        clrlwi            8, 4, 24
        rlwinm            4, 3, 0, 0, 29
        rlwinm            6, 6, 3, 27, 28
        lwarx             7, 0, 4
        srw               3, 7, 6
        clrlwi            9, 3, 24
        cmplw             9, 8
        bf                2, 0f
        li                8, 255
        clrlwi            5, 5, 24
        slw               8, 8, 6
        slw               5, 5, 6
        not               8, 8
        and               6, 7, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
        bt                2, 1f
0:
        crclr             20
        lwsync
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
        not               6, 3
        clrlwi            8, 4, 24
        crclr             20
        rlwinm            4, 3, 0, 0, 29
        rlwinm            6, 6, 3, 27, 28
        lwarx             7, 0, 4
        srw               3, 7, 6
        clrlwi            9, 3, 24
        cmplw             9, 8
        bf                2, 0f
        li                8, 255
        clrlwi            5, 5, 24
        slw               8, 8, 6
        slw               5, 5, 6
        not               8, 8
        and               6, 7, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
        bt                2, 1f
0:
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crset             20
        lwsync
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        not               6, 3
        clrlwi            8, 4, 24
        rlwinm            4, 3, 0, 0, 29
        rlwinm            6, 6, 3, 27, 28
        lwarx             7, 0, 4
        srw               3, 7, 6
        clrlwi            9, 3, 24
        cmplw             9, 8
        bf                2, 0f
        li                8, 255
        clrlwi            5, 5, 24
        slw               8, 8, 6
        slw               5, 5, 6
        not               8, 8
        and               6, 7, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
        bt                2, 1f
0:
        crclr             20
        lwsync
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
        not               6, 3
        clrlwi            8, 4, 24
        rlwinm            4, 3, 0, 0, 29
        rlwinm            6, 6, 3, 27, 28
        lwarx             7, 0, 4
        srw               3, 7, 6
        clrlwi            9, 3, 24
        cmplw             9, 8
        bf                2, 0f
        li                8, 255
        clrlwi            5, 5, 24
        slw               8, 8, 6
        slw               5, 5, 6
        not               8, 8
        and               6, 7, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
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
        not               6, 3
        clrlwi            8, 4, 24
        rlwinm            4, 3, 0, 0, 29
        rlwinm            6, 6, 3, 27, 28
        lwarx             7, 0, 4
        srw               3, 7, 6
        clrlwi            9, 3, 24
        cmplw             9, 8
        bf                2, 0f
        li                8, 255
        clrlwi            5, 5, 24
        lwsync
        slw               8, 8, 6
        slw               5, 5, 6
        not               8, 8
        and               6, 7, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
        bt                2, 1f
0:
        crclr             20
        lwsync
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
        not               6, 3
        clrlwi            8, 4, 24
        rlwinm            4, 3, 0, 0, 29
        rlwinm            6, 6, 3, 27, 28
        lwarx             7, 0, 4
        srw               3, 7, 6
        clrlwi            9, 3, 24
        cmplw             9, 8
        bf                2, 0f
        li                8, 255
        clrlwi            5, 5, 24
        lwsync
        slw               8, 8, 6
        slw               5, 5, 6
        not               8, 8
        and               6, 7, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
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
        clrlwi            8, 4, 16
        rlwinm            4, 3, 0, 0, 29
        lwarx             7, 0, 4
        clrlwi            3, 3, 30
        xori              3, 3, 2
        slwi              6, 3, 3
        srw               3, 7, 6
        clrlwi            9, 3, 16
        cmplw             9, 8
        bf                2, 0f
        lis               8, 0
        clrlwi            5, 5, 16
        lwsync
        ori               8, 8, 65535
        slw               5, 5, 6
        slw               8, 8, 6
        not               8, 8
        and               6, 7, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
        bt                2, 1f
0:
        crclr             20
        lwsync
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
        clrlwi            8, 4, 16
        rlwinm            4, 3, 0, 0, 29
        lwarx             7, 0, 4
        clrlwi            3, 3, 30
        xori              3, 3, 2
        slwi              6, 3, 3
        srw               3, 7, 6
        clrlwi            9, 3, 16
        cmplw             9, 8
        bf                2, 0f
        lis               8, 0
        clrlwi            5, 5, 16
        sync
        ori               8, 8, 65535
        slw               5, 5, 6
        slw               8, 8, 6
        not               8, 8
        and               6, 7, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
        bt                2, 1f
0:
        crclr             20
        lwsync
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
        clrlwi            8, 4, 16
        rlwinm            4, 3, 0, 0, 29
        lwarx             7, 0, 4
        clrlwi            3, 3, 30
        xori              3, 3, 2
        slwi              6, 3, 3
        srw               3, 7, 6
        clrlwi            9, 3, 16
        cmplw             9, 8
        bf                2, 0f
        lis               8, 0
        clrlwi            5, 5, 16
        lwsync
        ori               8, 8, 65535
        slw               5, 5, 6
        slw               8, 8, 6
        not               8, 8
        and               6, 7, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
        bt                2, 1f
0:
        crclr             20
        lwsync
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
        clrlwi            8, 4, 16
        rlwinm            4, 3, 0, 0, 29
        crclr             20
        clrlwi            3, 3, 30
        xori              3, 3, 2
        lwarx             7, 0, 4
        slwi              6, 3, 3
        srw               3, 7, 6
        clrlwi            9, 3, 16
        cmplw             9, 8
        bf                2, 0f
        lis               8, 0
        clrlwi            5, 5, 16
        lwsync
        ori               8, 8, 65535
        slw               5, 5, 6
        slw               8, 8, 6
        not               8, 8
        and               6, 7, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
        bt                2, 1f
0:
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crset             20
        lwsync
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        clrlwi            8, 4, 16
        rlwinm            4, 3, 0, 0, 29
        lwarx             7, 0, 4
        clrlwi            3, 3, 30
        xori              3, 3, 2
        slwi              6, 3, 3
        srw               3, 7, 6
        clrlwi            9, 3, 16
        cmplw             9, 8
        bf                2, 0f
        lis               8, 0
        clrlwi            5, 5, 16
        ori               8, 8, 65535
        slw               5, 5, 6
        slw               8, 8, 6
        not               8, 8
        and               6, 7, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
        bt                2, 1f
0:
        crclr             20
        lwsync
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
        clrlwi            8, 4, 16
        rlwinm            4, 3, 0, 0, 29
        lwarx             7, 0, 4
        clrlwi            3, 3, 30
        xori              3, 3, 2
        slwi              6, 3, 3
        srw               3, 7, 6
        clrlwi            9, 3, 16
        cmplw             9, 8
        bf                2, 0f
        lis               8, 0
        clrlwi            5, 5, 16
        ori               8, 8, 65535
        slw               5, 5, 6
        slw               8, 8, 6
        not               8, 8
        and               6, 7, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
        bt                2, 1f
0:
        crclr             20
        lwsync
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
        clrlwi            8, 4, 16
        rlwinm            4, 3, 0, 0, 29
        lwarx             7, 0, 4
        clrlwi            3, 3, 30
        xori              3, 3, 2
        slwi              6, 3, 3
        srw               3, 7, 6
        clrlwi            9, 3, 16
        cmplw             9, 8
        bf                2, 0f
        lis               8, 0
        clrlwi            5, 5, 16
        lwsync
        ori               8, 8, 65535
        slw               5, 5, 6
        slw               8, 8, 6
        not               8, 8
        and               6, 7, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
        bt                2, 1f
0:
        crclr             20
        lwsync
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
        clrlwi            8, 4, 16
        rlwinm            4, 3, 0, 0, 29
        lwarx             7, 0, 4
        clrlwi            3, 3, 30
        xori              3, 3, 2
        slwi              6, 3, 3
        srw               3, 7, 6
        clrlwi            9, 3, 16
        cmplw             9, 8
        bf                2, 0f
        lis               8, 0
        clrlwi            5, 5, 16
        sync
        ori               8, 8, 65535
        slw               5, 5, 6
        slw               8, 8, 6
        not               8, 8
        and               6, 7, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
        bt                2, 1f
0:
        crclr             20
        lwsync
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
        clrlwi            8, 4, 16
        rlwinm            4, 3, 0, 0, 29
        crclr             20
        clrlwi            3, 3, 30
        xori              3, 3, 2
        lwarx             7, 0, 4
        slwi              6, 3, 3
        srw               3, 7, 6
        clrlwi            9, 3, 16
        cmplw             9, 8
        bf                2, 0f
        lis               8, 0
        clrlwi            5, 5, 16
        sync
        ori               8, 8, 65535
        slw               5, 5, 6
        slw               8, 8, 6
        not               8, 8
        and               6, 7, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
        bt                2, 1f
0:
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crset             20
        lwsync
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u16::acquire_acquire:
        clrlwi            8, 4, 16
        rlwinm            4, 3, 0, 0, 29
        lwarx             7, 0, 4
        clrlwi            3, 3, 30
        xori              3, 3, 2
        slwi              6, 3, 3
        srw               3, 7, 6
        clrlwi            9, 3, 16
        cmplw             9, 8
        bf                2, 0f
        lis               8, 0
        clrlwi            5, 5, 16
        ori               8, 8, 65535
        slw               5, 5, 6
        slw               8, 8, 6
        not               8, 8
        and               6, 7, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
        bt                2, 1f
0:
        crclr             20
        lwsync
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
        clrlwi            8, 4, 16
        rlwinm            4, 3, 0, 0, 29
        crclr             20
        clrlwi            3, 3, 30
        xori              3, 3, 2
        lwarx             7, 0, 4
        slwi              6, 3, 3
        srw               3, 7, 6
        clrlwi            9, 3, 16
        cmplw             9, 8
        bf                2, 0f
        lis               8, 0
        clrlwi            5, 5, 16
        ori               8, 8, 65535
        slw               5, 5, 6
        slw               8, 8, 6
        not               8, 8
        and               6, 7, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
        bt                2, 1f
0:
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr
1:
        crset             20
        lwsync
        li                4, 0
        li                5, 1
        isel              4, 5, 4, 20
        blr

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        clrlwi            8, 4, 16
        rlwinm            4, 3, 0, 0, 29
        lwarx             7, 0, 4
        clrlwi            3, 3, 30
        xori              3, 3, 2
        slwi              6, 3, 3
        srw               3, 7, 6
        clrlwi            9, 3, 16
        cmplw             9, 8
        bf                2, 0f
        lis               8, 0
        clrlwi            5, 5, 16
        ori               8, 8, 65535
        slw               5, 5, 6
        slw               8, 8, 6
        not               8, 8
        and               6, 7, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
        bt                2, 1f
0:
        crclr             20
        lwsync
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
        clrlwi            8, 4, 16
        rlwinm            4, 3, 0, 0, 29
        lwarx             7, 0, 4
        clrlwi            3, 3, 30
        xori              3, 3, 2
        slwi              6, 3, 3
        srw               3, 7, 6
        clrlwi            9, 3, 16
        cmplw             9, 8
        bf                2, 0f
        lis               8, 0
        clrlwi            5, 5, 16
        ori               8, 8, 65535
        slw               5, 5, 6
        slw               8, 8, 6
        not               8, 8
        and               6, 7, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
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
        clrlwi            8, 4, 16
        rlwinm            4, 3, 0, 0, 29
        lwarx             7, 0, 4
        clrlwi            3, 3, 30
        xori              3, 3, 2
        slwi              6, 3, 3
        srw               3, 7, 6
        clrlwi            9, 3, 16
        cmplw             9, 8
        bf                2, 0f
        lis               8, 0
        clrlwi            5, 5, 16
        lwsync
        ori               8, 8, 65535
        slw               5, 5, 6
        slw               8, 8, 6
        not               8, 8
        and               6, 7, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
        bt                2, 1f
0:
        crclr             20
        lwsync
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
        clrlwi            8, 4, 16
        rlwinm            4, 3, 0, 0, 29
        lwarx             7, 0, 4
        clrlwi            3, 3, 30
        xori              3, 3, 2
        slwi              6, 3, 3
        srw               3, 7, 6
        clrlwi            9, 3, 16
        cmplw             9, 8
        bf                2, 0f
        lis               8, 0
        clrlwi            5, 5, 16
        lwsync
        ori               8, 8, 65535
        slw               5, 5, 6
        slw               8, 8, 6
        not               8, 8
        and               6, 7, 8
        or                5, 6, 5
        stwcx.            5, 0, 4
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
        crclr             20
        lwsync
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
        crclr             20
        lwsync
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
        crclr             20
        lwsync
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
        crclr             20
        mr                6, 3
        lwarx             3, 0, 3
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
        crset             20
        lwsync
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
        crclr             20
        lwsync
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
        crclr             20
        lwsync
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
        crclr             20
        lwsync
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
        crclr             20
        lwsync
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
        crclr             20
        mr                6, 3
        lwarx             3, 0, 3
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
        crset             20
        lwsync
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
        crclr             20
        lwsync
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
        crclr             20
        mr                6, 3
        lwarx             3, 0, 3
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
        crset             20
        lwsync
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
        crclr             20
        lwsync
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
        crclr             20
        lwsync
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

asm_test::load::u8::seqcst:
        sync
        lbz               3, 0(3)
        cmpw              7, 3, 3
        bf-               30, 0f
0:
        isync
        blr

asm_test::load::u8::acquire:
        lbz               3, 0(3)
        cmpw              7, 3, 3
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
        cmpw              7, 3, 3
        bf-               30, 0f
0:
        isync
        blr

asm_test::load::u16::acquire:
        lhz               3, 0(3)
        cmpw              7, 3, 3
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
        cmpw              7, 3, 3
        bf-               30, 0f
0:
        isync
        blr

asm_test::load::u32::acquire:
        lwz               3, 0(3)
        cmpw              7, 3, 3
        bf-               30, 0f
0:
        isync
        blr

asm_test::load::u32::relaxed:
        lwz               3, 0(3)
        blr

asm_test::swap::u8::acqrel:
        rlwinm            5, 3, 3, 27, 28
        lwsync
        rlwinm            3, 3, 0, 0, 29
        xori              5, 5, 24
        slw               6, 4, 5
        li                4, 255
        slw               4, 4, 5
        and               6, 6, 4
0:
        lwarx             7, 0, 3
        andc              8, 7, 4
        or                8, 6, 8
        stwcx.            8, 0, 3
        bf                2, 0b
        srw               3, 7, 5
        lwsync
        clrlwi            3, 3, 24
        blr

asm_test::swap::u8::seqcst:
        rlwinm            5, 3, 3, 27, 28
        sync
        rlwinm            3, 3, 0, 0, 29
        xori              5, 5, 24
        slw               6, 4, 5
        li                4, 255
        slw               4, 4, 5
        and               6, 6, 4
0:
        lwarx             7, 0, 3
        andc              8, 7, 4
        or                8, 6, 8
        stwcx.            8, 0, 3
        bf                2, 0b
        srw               3, 7, 5
        lwsync
        clrlwi            3, 3, 24
        blr

asm_test::swap::u8::acquire:
        rlwinm            5, 3, 3, 27, 28
        rlwinm            3, 3, 0, 0, 29
        xori              5, 5, 24
        slw               6, 4, 5
        li                4, 255
        slw               4, 4, 5
        and               6, 6, 4
0:
        lwarx             7, 0, 3
        andc              8, 7, 4
        or                8, 6, 8
        stwcx.            8, 0, 3
        bf                2, 0b
        srw               3, 7, 5
        lwsync
        clrlwi            3, 3, 24
        blr

asm_test::swap::u8::relaxed:
        rlwinm            5, 3, 3, 27, 28
        rlwinm            3, 3, 0, 0, 29
        xori              5, 5, 24
        slw               6, 4, 5
        li                4, 255
        slw               4, 4, 5
        and               6, 6, 4
0:
        lwarx             7, 0, 3
        andc              8, 7, 4
        or                8, 6, 8
        stwcx.            8, 0, 3
        bf                2, 0b
        srw               3, 7, 5
        clrlwi            3, 3, 24
        blr

asm_test::swap::u8::release:
        rlwinm            5, 3, 3, 27, 28
        lwsync
        rlwinm            3, 3, 0, 0, 29
        xori              5, 5, 24
        slw               6, 4, 5
        li                4, 255
        slw               4, 4, 5
        and               6, 6, 4
0:
        lwarx             7, 0, 3
        andc              8, 7, 4
        or                8, 6, 8
        stwcx.            8, 0, 3
        bf                2, 0b
        srw               3, 7, 5
        clrlwi            3, 3, 24
        blr

asm_test::swap::u16::acqrel:
        rlwinm            5, 3, 3, 27, 27
        lwsync
        rlwinm            3, 3, 0, 0, 29
        xori              5, 5, 16
        slw               6, 4, 5
        li                4, 0
        ori               4, 4, 65535
        slw               4, 4, 5
        and               6, 6, 4
0:
        lwarx             7, 0, 3
        andc              8, 7, 4
        or                8, 6, 8
        stwcx.            8, 0, 3
        bf                2, 0b
        srw               3, 7, 5
        lwsync
        clrlwi            3, 3, 16
        blr

asm_test::swap::u16::seqcst:
        rlwinm            5, 3, 3, 27, 27
        sync
        rlwinm            3, 3, 0, 0, 29
        xori              5, 5, 16
        slw               6, 4, 5
        li                4, 0
        ori               4, 4, 65535
        slw               4, 4, 5
        and               6, 6, 4
0:
        lwarx             7, 0, 3
        andc              8, 7, 4
        or                8, 6, 8
        stwcx.            8, 0, 3
        bf                2, 0b
        srw               3, 7, 5
        lwsync
        clrlwi            3, 3, 16
        blr

asm_test::swap::u16::acquire:
        rlwinm            5, 3, 3, 27, 27
        rlwinm            3, 3, 0, 0, 29
        xori              5, 5, 16
        slw               6, 4, 5
        li                4, 0
        ori               4, 4, 65535
        slw               4, 4, 5
        and               6, 6, 4
0:
        lwarx             7, 0, 3
        andc              8, 7, 4
        or                8, 6, 8
        stwcx.            8, 0, 3
        bf                2, 0b
        srw               3, 7, 5
        lwsync
        clrlwi            3, 3, 16
        blr

asm_test::swap::u16::relaxed:
        rlwinm            5, 3, 3, 27, 27
        rlwinm            3, 3, 0, 0, 29
        xori              5, 5, 16
        slw               6, 4, 5
        li                4, 0
        ori               4, 4, 65535
        slw               4, 4, 5
        and               6, 6, 4
0:
        lwarx             7, 0, 3
        andc              8, 7, 4
        or                8, 6, 8
        stwcx.            8, 0, 3
        bf                2, 0b
        srw               3, 7, 5
        clrlwi            3, 3, 16
        blr

asm_test::swap::u16::release:
        rlwinm            5, 3, 3, 27, 27
        lwsync
        rlwinm            3, 3, 0, 0, 29
        xori              5, 5, 16
        slw               6, 4, 5
        li                4, 0
        ori               4, 4, 65535
        slw               4, 4, 5
        and               6, 6, 4
0:
        lwarx             7, 0, 3
        andc              8, 7, 4
        or                8, 6, 8
        stwcx.            8, 0, 3
        bf                2, 0b
        srw               3, 7, 5
        clrlwi            3, 3, 16
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

