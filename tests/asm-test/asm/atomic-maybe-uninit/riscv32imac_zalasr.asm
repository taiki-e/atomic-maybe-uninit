asm_test::compare_exchange::u8::acqrel_seqcst:
        li                a3, 0xff
        slli              a4, a0, 0x3
        andi              a5, a0, -0x4
        sll               a1, a1, a4
        sll               a2, a2, a4
        sll               a3, a3, a4
0:
        lr.w.aqrl         a0, (a5)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w.rl           a6, a6, (a5)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a4
        snez              a1, a6
        ret

asm_test::compare_exchange::u8::seqcst_seqcst:
        li                a3, 0xff
        slli              a4, a0, 0x3
        andi              a5, a0, -0x4
        sll               a1, a1, a4
        sll               a2, a2, a4
        sll               a3, a3, a4
0:
        lr.w.aqrl         a0, (a5)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w.rl           a6, a6, (a5)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a4
        snez              a1, a6
        ret

asm_test::compare_exchange::u8::acqrel_acquire:
        li                a3, 0xff
        slli              a4, a0, 0x3
        andi              a5, a0, -0x4
        sll               a1, a1, a4
        sll               a2, a2, a4
        sll               a3, a3, a4
0:
        lr.w.aq           a0, (a5)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w.rl           a6, a6, (a5)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a4
        snez              a1, a6
        ret

asm_test::compare_exchange::u8::acqrel_relaxed:
        li                a3, 0xff
        slli              a4, a0, 0x3
        andi              a5, a0, -0x4
        sll               a1, a1, a4
        sll               a2, a2, a4
        sll               a3, a3, a4
0:
        lr.w.aq           a0, (a5)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w.rl           a6, a6, (a5)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a4
        snez              a1, a6
        ret

asm_test::compare_exchange::u8::acquire_seqcst:
        li                a3, 0xff
        slli              a4, a0, 0x3
        andi              a5, a0, -0x4
        sll               a1, a1, a4
        sll               a2, a2, a4
        sll               a3, a3, a4
0:
        lr.w.aqrl         a0, (a5)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w.rl           a6, a6, (a5)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a4
        snez              a1, a6
        ret

asm_test::compare_exchange::u8::relaxed_seqcst:
        li                a3, 0xff
        slli              a4, a0, 0x3
        andi              a5, a0, -0x4
        sll               a1, a1, a4
        sll               a2, a2, a4
        sll               a3, a3, a4
0:
        lr.w.aqrl         a0, (a5)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w.rl           a6, a6, (a5)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a4
        snez              a1, a6
        ret

asm_test::compare_exchange::u8::release_seqcst:
        li                a3, 0xff
        slli              a4, a0, 0x3
        andi              a5, a0, -0x4
        sll               a1, a1, a4
        sll               a2, a2, a4
        sll               a3, a3, a4
0:
        lr.w.aqrl         a0, (a5)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w.rl           a6, a6, (a5)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a4
        snez              a1, a6
        ret

asm_test::compare_exchange::u8::seqcst_acquire:
        li                a3, 0xff
        slli              a4, a0, 0x3
        andi              a5, a0, -0x4
        sll               a1, a1, a4
        sll               a2, a2, a4
        sll               a3, a3, a4
0:
        lr.w.aqrl         a0, (a5)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w.rl           a6, a6, (a5)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a4
        snez              a1, a6
        ret

asm_test::compare_exchange::u8::seqcst_relaxed:
        li                a3, 0xff
        slli              a4, a0, 0x3
        andi              a5, a0, -0x4
        sll               a1, a1, a4
        sll               a2, a2, a4
        sll               a3, a3, a4
0:
        lr.w.aqrl         a0, (a5)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w.rl           a6, a6, (a5)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a4
        snez              a1, a6
        ret

asm_test::compare_exchange::u8::acquire_acquire:
        li                a3, 0xff
        slli              a4, a0, 0x3
        andi              a5, a0, -0x4
        sll               a1, a1, a4
        sll               a2, a2, a4
        sll               a3, a3, a4
0:
        lr.w.aq           a0, (a5)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w              a6, a6, (a5)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a4
        snez              a1, a6
        ret

asm_test::compare_exchange::u8::acquire_relaxed:
        li                a3, 0xff
        slli              a4, a0, 0x3
        andi              a5, a0, -0x4
        sll               a1, a1, a4
        sll               a2, a2, a4
        sll               a3, a3, a4
0:
        lr.w.aq           a0, (a5)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w              a6, a6, (a5)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a4
        snez              a1, a6
        ret

asm_test::compare_exchange::u8::relaxed_acquire:
        li                a3, 0xff
        slli              a4, a0, 0x3
        andi              a5, a0, -0x4
        sll               a1, a1, a4
        sll               a2, a2, a4
        sll               a3, a3, a4
0:
        lr.w.aq           a0, (a5)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w              a6, a6, (a5)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a4
        snez              a1, a6
        ret

asm_test::compare_exchange::u8::relaxed_relaxed:
        li                a3, 0xff
        slli              a4, a0, 0x3
        andi              a5, a0, -0x4
        sll               a1, a1, a4
        sll               a2, a2, a4
        sll               a3, a3, a4
0:
        lr.w              a0, (a5)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w              a6, a6, (a5)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a4
        snez              a1, a6
        ret

asm_test::compare_exchange::u8::release_acquire:
        li                a3, 0xff
        slli              a4, a0, 0x3
        andi              a5, a0, -0x4
        sll               a1, a1, a4
        sll               a2, a2, a4
        sll               a3, a3, a4
0:
        lr.w.aq           a0, (a5)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w.rl           a6, a6, (a5)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a4
        snez              a1, a6
        ret

asm_test::compare_exchange::u8::release_relaxed:
        li                a3, 0xff
        slli              a4, a0, 0x3
        andi              a5, a0, -0x4
        sll               a1, a1, a4
        sll               a2, a2, a4
        sll               a3, a3, a4
0:
        lr.w              a0, (a5)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w.rl           a6, a6, (a5)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a4
        snez              a1, a6
        ret

asm_test::compare_exchange::u16::acqrel_seqcst:
        lui               a3, 0x10
        andi              a4, a0, -0x4
        slli              a5, a0, 0x3
        sll               a1, a1, a5
        addi              a3, a3, -0x1
        sll               a2, a2, a5
        sll               a3, a3, a5
0:
        lr.w.aqrl         a0, (a4)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w.rl           a6, a6, (a4)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a5
        snez              a1, a6
        ret

asm_test::compare_exchange::u16::seqcst_seqcst:
        lui               a3, 0x10
        andi              a4, a0, -0x4
        slli              a5, a0, 0x3
        sll               a1, a1, a5
        addi              a3, a3, -0x1
        sll               a2, a2, a5
        sll               a3, a3, a5
0:
        lr.w.aqrl         a0, (a4)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w.rl           a6, a6, (a4)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a5
        snez              a1, a6
        ret

asm_test::compare_exchange::u16::acqrel_acquire:
        lui               a3, 0x10
        andi              a4, a0, -0x4
        slli              a5, a0, 0x3
        sll               a1, a1, a5
        addi              a3, a3, -0x1
        sll               a2, a2, a5
        sll               a3, a3, a5
0:
        lr.w.aq           a0, (a4)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w.rl           a6, a6, (a4)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a5
        snez              a1, a6
        ret

asm_test::compare_exchange::u16::acqrel_relaxed:
        lui               a3, 0x10
        andi              a4, a0, -0x4
        slli              a5, a0, 0x3
        sll               a1, a1, a5
        addi              a3, a3, -0x1
        sll               a2, a2, a5
        sll               a3, a3, a5
0:
        lr.w.aq           a0, (a4)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w.rl           a6, a6, (a4)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a5
        snez              a1, a6
        ret

asm_test::compare_exchange::u16::acquire_seqcst:
        lui               a3, 0x10
        andi              a4, a0, -0x4
        slli              a5, a0, 0x3
        sll               a1, a1, a5
        addi              a3, a3, -0x1
        sll               a2, a2, a5
        sll               a3, a3, a5
0:
        lr.w.aqrl         a0, (a4)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w.rl           a6, a6, (a4)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a5
        snez              a1, a6
        ret

asm_test::compare_exchange::u16::relaxed_seqcst:
        lui               a3, 0x10
        andi              a4, a0, -0x4
        slli              a5, a0, 0x3
        sll               a1, a1, a5
        addi              a3, a3, -0x1
        sll               a2, a2, a5
        sll               a3, a3, a5
0:
        lr.w.aqrl         a0, (a4)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w.rl           a6, a6, (a4)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a5
        snez              a1, a6
        ret

asm_test::compare_exchange::u16::release_seqcst:
        lui               a3, 0x10
        andi              a4, a0, -0x4
        slli              a5, a0, 0x3
        sll               a1, a1, a5
        addi              a3, a3, -0x1
        sll               a2, a2, a5
        sll               a3, a3, a5
0:
        lr.w.aqrl         a0, (a4)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w.rl           a6, a6, (a4)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a5
        snez              a1, a6
        ret

asm_test::compare_exchange::u16::seqcst_acquire:
        lui               a3, 0x10
        andi              a4, a0, -0x4
        slli              a5, a0, 0x3
        sll               a1, a1, a5
        addi              a3, a3, -0x1
        sll               a2, a2, a5
        sll               a3, a3, a5
0:
        lr.w.aqrl         a0, (a4)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w.rl           a6, a6, (a4)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a5
        snez              a1, a6
        ret

asm_test::compare_exchange::u16::seqcst_relaxed:
        lui               a3, 0x10
        andi              a4, a0, -0x4
        slli              a5, a0, 0x3
        sll               a1, a1, a5
        addi              a3, a3, -0x1
        sll               a2, a2, a5
        sll               a3, a3, a5
0:
        lr.w.aqrl         a0, (a4)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w.rl           a6, a6, (a4)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a5
        snez              a1, a6
        ret

asm_test::compare_exchange::u16::acquire_acquire:
        lui               a3, 0x10
        andi              a4, a0, -0x4
        slli              a5, a0, 0x3
        sll               a1, a1, a5
        addi              a3, a3, -0x1
        sll               a2, a2, a5
        sll               a3, a3, a5
0:
        lr.w.aq           a0, (a4)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w              a6, a6, (a4)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a5
        snez              a1, a6
        ret

asm_test::compare_exchange::u16::acquire_relaxed:
        lui               a3, 0x10
        andi              a4, a0, -0x4
        slli              a5, a0, 0x3
        sll               a1, a1, a5
        addi              a3, a3, -0x1
        sll               a2, a2, a5
        sll               a3, a3, a5
0:
        lr.w.aq           a0, (a4)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w              a6, a6, (a4)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a5
        snez              a1, a6
        ret

asm_test::compare_exchange::u16::relaxed_acquire:
        lui               a3, 0x10
        andi              a4, a0, -0x4
        slli              a5, a0, 0x3
        sll               a1, a1, a5
        addi              a3, a3, -0x1
        sll               a2, a2, a5
        sll               a3, a3, a5
0:
        lr.w.aq           a0, (a4)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w              a6, a6, (a4)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a5
        snez              a1, a6
        ret

asm_test::compare_exchange::u16::relaxed_relaxed:
        lui               a3, 0x10
        andi              a4, a0, -0x4
        slli              a5, a0, 0x3
        sll               a1, a1, a5
        addi              a3, a3, -0x1
        sll               a2, a2, a5
        sll               a3, a3, a5
0:
        lr.w              a0, (a4)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w              a6, a6, (a4)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a5
        snez              a1, a6
        ret

asm_test::compare_exchange::u16::release_acquire:
        lui               a3, 0x10
        andi              a4, a0, -0x4
        slli              a5, a0, 0x3
        sll               a1, a1, a5
        addi              a3, a3, -0x1
        sll               a2, a2, a5
        sll               a3, a3, a5
0:
        lr.w.aq           a0, (a4)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w.rl           a6, a6, (a4)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a5
        snez              a1, a6
        ret

asm_test::compare_exchange::u16::release_relaxed:
        lui               a3, 0x10
        andi              a4, a0, -0x4
        slli              a5, a0, 0x3
        sll               a1, a1, a5
        addi              a3, a3, -0x1
        sll               a2, a2, a5
        sll               a3, a3, a5
0:
        lr.w              a0, (a4)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w.rl           a6, a6, (a4)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a5
        snez              a1, a6
        ret

asm_test::compare_exchange::u32::acqrel_seqcst:
        li                a4, 0x1
0:
        lr.w.aqrl         a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        seqz              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::seqcst_seqcst:
        li                a4, 0x1
0:
        lr.w.aqrl         a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        seqz              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::acqrel_acquire:
        li                a4, 0x1
0:
        lr.w.aq           a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        seqz              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::acqrel_relaxed:
        li                a4, 0x1
0:
        lr.w.aq           a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        seqz              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::acquire_seqcst:
        li                a4, 0x1
0:
        lr.w.aqrl         a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        seqz              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::relaxed_seqcst:
        li                a4, 0x1
0:
        lr.w.aqrl         a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        seqz              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::release_seqcst:
        li                a4, 0x1
0:
        lr.w.aqrl         a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        seqz              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::seqcst_acquire:
        li                a4, 0x1
0:
        lr.w.aqrl         a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        seqz              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::seqcst_relaxed:
        li                a4, 0x1
0:
        lr.w.aqrl         a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        seqz              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::acquire_acquire:
        li                a4, 0x1
0:
        lr.w.aq           a3, (a0)
        bne               a3, a1, 1f
        sc.w              a4, a2, (a0)
        bnez              a4, 0b
1:
        seqz              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::acquire_relaxed:
        li                a4, 0x1
0:
        lr.w.aq           a3, (a0)
        bne               a3, a1, 1f
        sc.w              a4, a2, (a0)
        bnez              a4, 0b
1:
        seqz              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::relaxed_acquire:
        li                a4, 0x1
0:
        lr.w.aq           a3, (a0)
        bne               a3, a1, 1f
        sc.w              a4, a2, (a0)
        bnez              a4, 0b
1:
        seqz              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::relaxed_relaxed:
        li                a4, 0x1
0:
        lr.w              a3, (a0)
        bne               a3, a1, 1f
        sc.w              a4, a2, (a0)
        bnez              a4, 0b
1:
        seqz              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::release_acquire:
        li                a4, 0x1
0:
        lr.w.aq           a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        seqz              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::release_relaxed:
        li                a4, 0x1
0:
        lr.w              a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        seqz              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        li                a3, 0xff
        slli              a4, a0, 0x3
        andi              a5, a0, -0x4
        sll               a1, a1, a4
        sll               a2, a2, a4
        sll               a3, a3, a4
0:
        lr.w.aqrl         a0, (a5)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w.rl           a6, a6, (a5)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a4
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        li                a3, 0xff
        slli              a4, a0, 0x3
        andi              a5, a0, -0x4
        sll               a1, a1, a4
        sll               a2, a2, a4
        sll               a3, a3, a4
0:
        lr.w.aqrl         a0, (a5)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w.rl           a6, a6, (a5)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a4
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        li                a3, 0xff
        slli              a4, a0, 0x3
        andi              a5, a0, -0x4
        sll               a1, a1, a4
        sll               a2, a2, a4
        sll               a3, a3, a4
0:
        lr.w.aq           a0, (a5)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w.rl           a6, a6, (a5)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a4
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        li                a3, 0xff
        slli              a4, a0, 0x3
        andi              a5, a0, -0x4
        sll               a1, a1, a4
        sll               a2, a2, a4
        sll               a3, a3, a4
0:
        lr.w.aq           a0, (a5)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w.rl           a6, a6, (a5)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a4
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        li                a3, 0xff
        slli              a4, a0, 0x3
        andi              a5, a0, -0x4
        sll               a1, a1, a4
        sll               a2, a2, a4
        sll               a3, a3, a4
0:
        lr.w.aqrl         a0, (a5)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w.rl           a6, a6, (a5)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a4
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        li                a3, 0xff
        slli              a4, a0, 0x3
        andi              a5, a0, -0x4
        sll               a1, a1, a4
        sll               a2, a2, a4
        sll               a3, a3, a4
0:
        lr.w.aqrl         a0, (a5)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w.rl           a6, a6, (a5)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a4
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u8::release_seqcst:
        li                a3, 0xff
        slli              a4, a0, 0x3
        andi              a5, a0, -0x4
        sll               a1, a1, a4
        sll               a2, a2, a4
        sll               a3, a3, a4
0:
        lr.w.aqrl         a0, (a5)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w.rl           a6, a6, (a5)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a4
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        li                a3, 0xff
        slli              a4, a0, 0x3
        andi              a5, a0, -0x4
        sll               a1, a1, a4
        sll               a2, a2, a4
        sll               a3, a3, a4
0:
        lr.w.aqrl         a0, (a5)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w.rl           a6, a6, (a5)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a4
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        li                a3, 0xff
        slli              a4, a0, 0x3
        andi              a5, a0, -0x4
        sll               a1, a1, a4
        sll               a2, a2, a4
        sll               a3, a3, a4
0:
        lr.w.aqrl         a0, (a5)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w.rl           a6, a6, (a5)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a4
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u8::acquire_acquire:
        li                a3, 0xff
        slli              a4, a0, 0x3
        andi              a5, a0, -0x4
        sll               a1, a1, a4
        sll               a2, a2, a4
        sll               a3, a3, a4
0:
        lr.w.aq           a0, (a5)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w              a6, a6, (a5)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a4
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        li                a3, 0xff
        slli              a4, a0, 0x3
        andi              a5, a0, -0x4
        sll               a1, a1, a4
        sll               a2, a2, a4
        sll               a3, a3, a4
0:
        lr.w.aq           a0, (a5)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w              a6, a6, (a5)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a4
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        li                a3, 0xff
        slli              a4, a0, 0x3
        andi              a5, a0, -0x4
        sll               a1, a1, a4
        sll               a2, a2, a4
        sll               a3, a3, a4
0:
        lr.w.aq           a0, (a5)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w              a6, a6, (a5)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a4
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        li                a3, 0xff
        slli              a4, a0, 0x3
        andi              a5, a0, -0x4
        sll               a1, a1, a4
        sll               a2, a2, a4
        sll               a3, a3, a4
0:
        lr.w              a0, (a5)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w              a6, a6, (a5)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a4
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u8::release_acquire:
        li                a3, 0xff
        slli              a4, a0, 0x3
        andi              a5, a0, -0x4
        sll               a1, a1, a4
        sll               a2, a2, a4
        sll               a3, a3, a4
0:
        lr.w.aq           a0, (a5)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w.rl           a6, a6, (a5)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a4
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u8::release_relaxed:
        li                a3, 0xff
        slli              a4, a0, 0x3
        andi              a5, a0, -0x4
        sll               a1, a1, a4
        sll               a2, a2, a4
        sll               a3, a3, a4
0:
        lr.w              a0, (a5)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w.rl           a6, a6, (a5)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a4
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        lui               a3, 0x10
        andi              a4, a0, -0x4
        slli              a5, a0, 0x3
        sll               a1, a1, a5
        addi              a3, a3, -0x1
        sll               a2, a2, a5
        sll               a3, a3, a5
0:
        lr.w.aqrl         a0, (a4)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w.rl           a6, a6, (a4)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a5
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        lui               a3, 0x10
        andi              a4, a0, -0x4
        slli              a5, a0, 0x3
        sll               a1, a1, a5
        addi              a3, a3, -0x1
        sll               a2, a2, a5
        sll               a3, a3, a5
0:
        lr.w.aqrl         a0, (a4)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w.rl           a6, a6, (a4)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a5
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        lui               a3, 0x10
        andi              a4, a0, -0x4
        slli              a5, a0, 0x3
        sll               a1, a1, a5
        addi              a3, a3, -0x1
        sll               a2, a2, a5
        sll               a3, a3, a5
0:
        lr.w.aq           a0, (a4)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w.rl           a6, a6, (a4)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a5
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        lui               a3, 0x10
        andi              a4, a0, -0x4
        slli              a5, a0, 0x3
        sll               a1, a1, a5
        addi              a3, a3, -0x1
        sll               a2, a2, a5
        sll               a3, a3, a5
0:
        lr.w.aq           a0, (a4)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w.rl           a6, a6, (a4)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a5
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        lui               a3, 0x10
        andi              a4, a0, -0x4
        slli              a5, a0, 0x3
        sll               a1, a1, a5
        addi              a3, a3, -0x1
        sll               a2, a2, a5
        sll               a3, a3, a5
0:
        lr.w.aqrl         a0, (a4)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w.rl           a6, a6, (a4)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a5
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        lui               a3, 0x10
        andi              a4, a0, -0x4
        slli              a5, a0, 0x3
        sll               a1, a1, a5
        addi              a3, a3, -0x1
        sll               a2, a2, a5
        sll               a3, a3, a5
0:
        lr.w.aqrl         a0, (a4)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w.rl           a6, a6, (a4)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a5
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u16::release_seqcst:
        lui               a3, 0x10
        andi              a4, a0, -0x4
        slli              a5, a0, 0x3
        sll               a1, a1, a5
        addi              a3, a3, -0x1
        sll               a2, a2, a5
        sll               a3, a3, a5
0:
        lr.w.aqrl         a0, (a4)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w.rl           a6, a6, (a4)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a5
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        lui               a3, 0x10
        andi              a4, a0, -0x4
        slli              a5, a0, 0x3
        sll               a1, a1, a5
        addi              a3, a3, -0x1
        sll               a2, a2, a5
        sll               a3, a3, a5
0:
        lr.w.aqrl         a0, (a4)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w.rl           a6, a6, (a4)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a5
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        lui               a3, 0x10
        andi              a4, a0, -0x4
        slli              a5, a0, 0x3
        sll               a1, a1, a5
        addi              a3, a3, -0x1
        sll               a2, a2, a5
        sll               a3, a3, a5
0:
        lr.w.aqrl         a0, (a4)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w.rl           a6, a6, (a4)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a5
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u16::acquire_acquire:
        lui               a3, 0x10
        andi              a4, a0, -0x4
        slli              a5, a0, 0x3
        sll               a1, a1, a5
        addi              a3, a3, -0x1
        sll               a2, a2, a5
        sll               a3, a3, a5
0:
        lr.w.aq           a0, (a4)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w              a6, a6, (a4)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a5
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        lui               a3, 0x10
        andi              a4, a0, -0x4
        slli              a5, a0, 0x3
        sll               a1, a1, a5
        addi              a3, a3, -0x1
        sll               a2, a2, a5
        sll               a3, a3, a5
0:
        lr.w.aq           a0, (a4)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w              a6, a6, (a4)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a5
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        lui               a3, 0x10
        andi              a4, a0, -0x4
        slli              a5, a0, 0x3
        sll               a1, a1, a5
        addi              a3, a3, -0x1
        sll               a2, a2, a5
        sll               a3, a3, a5
0:
        lr.w.aq           a0, (a4)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w              a6, a6, (a4)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a5
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        lui               a3, 0x10
        andi              a4, a0, -0x4
        slli              a5, a0, 0x3
        sll               a1, a1, a5
        addi              a3, a3, -0x1
        sll               a2, a2, a5
        sll               a3, a3, a5
0:
        lr.w              a0, (a4)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w              a6, a6, (a4)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a5
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u16::release_acquire:
        lui               a3, 0x10
        andi              a4, a0, -0x4
        slli              a5, a0, 0x3
        sll               a1, a1, a5
        addi              a3, a3, -0x1
        sll               a2, a2, a5
        sll               a3, a3, a5
0:
        lr.w.aq           a0, (a4)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w.rl           a6, a6, (a4)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a5
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u16::release_relaxed:
        lui               a3, 0x10
        andi              a4, a0, -0x4
        slli              a5, a0, 0x3
        sll               a1, a1, a5
        addi              a3, a3, -0x1
        sll               a2, a2, a5
        sll               a3, a3, a5
0:
        lr.w              a0, (a4)
        and               a6, a0, a3
        bne               a6, a1, 1f
        xor               a6, a0, a2
        and               a6, a6, a3
        xor               a6, a6, a0
        sc.w.rl           a6, a6, (a4)
        bnez              a6, 0b
        and               a6, a0, a3
1:
        xor               a6, a6, a1
        seqz              a6, a6
        srl               a0, a0, a5
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        li                a4, 0x1
0:
        lr.w.aqrl         a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        seqz              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        li                a4, 0x1
0:
        lr.w.aqrl         a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        seqz              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        li                a4, 0x1
0:
        lr.w.aq           a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        seqz              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        li                a4, 0x1
0:
        lr.w.aq           a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        seqz              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        li                a4, 0x1
0:
        lr.w.aqrl         a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        seqz              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        li                a4, 0x1
0:
        lr.w.aqrl         a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        seqz              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::release_seqcst:
        li                a4, 0x1
0:
        lr.w.aqrl         a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        seqz              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        li                a4, 0x1
0:
        lr.w.aqrl         a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        seqz              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        li                a4, 0x1
0:
        lr.w.aqrl         a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        seqz              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::acquire_acquire:
        li                a4, 0x1
0:
        lr.w.aq           a3, (a0)
        bne               a3, a1, 1f
        sc.w              a4, a2, (a0)
        bnez              a4, 0b
1:
        seqz              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        li                a4, 0x1
0:
        lr.w.aq           a3, (a0)
        bne               a3, a1, 1f
        sc.w              a4, a2, (a0)
        bnez              a4, 0b
1:
        seqz              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        li                a4, 0x1
0:
        lr.w.aq           a3, (a0)
        bne               a3, a1, 1f
        sc.w              a4, a2, (a0)
        bnez              a4, 0b
1:
        seqz              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        li                a4, 0x1
0:
        lr.w              a3, (a0)
        bne               a3, a1, 1f
        sc.w              a4, a2, (a0)
        bnez              a4, 0b
1:
        seqz              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::release_acquire:
        li                a4, 0x1
0:
        lr.w.aq           a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        seqz              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::release_relaxed:
        li                a4, 0x1
0:
        lr.w              a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        seqz              a1, a4
        mv                a0, a3
        ret

asm_test::load::u8::seqcst:
        fence             rw, rw
        lb                a0, 0x0(a0)
        fence             r, rw
        ret

asm_test::load::u8::acquire:
        lb.aq             a0, (a0)
        ret

asm_test::load::u8::relaxed:
        lb                a0, 0x0(a0)
        ret

asm_test::load::u16::seqcst:
        fence             rw, rw
        lh                a0, 0x0(a0)
        fence             r, rw
        ret

asm_test::load::u16::acquire:
        lh.aq             a0, (a0)
        ret

asm_test::load::u16::relaxed:
        lh                a0, 0x0(a0)
        ret

asm_test::load::u32::seqcst:
        fence             rw, rw
        lw                a0, 0x0(a0)
        fence             r, rw
        ret

asm_test::load::u32::acquire:
        lw.aq             a0, (a0)
        ret

asm_test::load::u32::relaxed:
        lw                a0, 0x0(a0)
        ret

asm_test::swap::u8::acqrel:
        slli              a2, a0, 0x3
        li                a3, 0xff
        andi              a4, a0, -0x4
        sll               a3, a3, a2
        sll               a1, a1, a2
        not               a3, a3
0:
        lr.w.aq           a0, (a4)
        and               a5, a0, a3
        or                a5, a5, a1
        sc.w.rl           a5, a5, (a4)
        bnez              a5, 0b
        srl               a0, a0, a2
        ret

asm_test::swap::u8::seqcst:
        slli              a2, a0, 0x3
        li                a3, 0xff
        andi              a4, a0, -0x4
        sll               a3, a3, a2
        sll               a1, a1, a2
        not               a3, a3
0:
        lr.w.aqrl         a0, (a4)
        and               a5, a0, a3
        or                a5, a5, a1
        sc.w.rl           a5, a5, (a4)
        bnez              a5, 0b
        srl               a0, a0, a2
        ret

asm_test::swap::u8::acquire:
        slli              a2, a0, 0x3
        li                a3, 0xff
        andi              a4, a0, -0x4
        sll               a3, a3, a2
        sll               a1, a1, a2
        not               a3, a3
0:
        lr.w.aq           a0, (a4)
        and               a5, a0, a3
        or                a5, a5, a1
        sc.w              a5, a5, (a4)
        bnez              a5, 0b
        srl               a0, a0, a2
        ret

asm_test::swap::u8::relaxed:
        slli              a2, a0, 0x3
        li                a3, 0xff
        andi              a4, a0, -0x4
        sll               a3, a3, a2
        sll               a1, a1, a2
        not               a3, a3
0:
        lr.w              a0, (a4)
        and               a5, a0, a3
        or                a5, a5, a1
        sc.w              a5, a5, (a4)
        bnez              a5, 0b
        srl               a0, a0, a2
        ret

asm_test::swap::u8::release:
        slli              a2, a0, 0x3
        li                a3, 0xff
        andi              a4, a0, -0x4
        sll               a3, a3, a2
        sll               a1, a1, a2
        not               a3, a3
0:
        lr.w              a0, (a4)
        and               a5, a0, a3
        or                a5, a5, a1
        sc.w.rl           a5, a5, (a4)
        bnez              a5, 0b
        srl               a0, a0, a2
        ret

asm_test::swap::u16::acqrel:
        lui               a2, 0x10
        slli              a3, a0, 0x3
        addi              a2, a2, -0x1
        andi              a4, a0, -0x4
        sll               a2, a2, a3
        sll               a1, a1, a3
        not               a2, a2
0:
        lr.w.aq           a0, (a4)
        and               a5, a0, a2
        or                a5, a5, a1
        sc.w.rl           a5, a5, (a4)
        bnez              a5, 0b
        srl               a0, a0, a3
        ret

asm_test::swap::u16::seqcst:
        lui               a2, 0x10
        slli              a3, a0, 0x3
        addi              a2, a2, -0x1
        andi              a4, a0, -0x4
        sll               a2, a2, a3
        sll               a1, a1, a3
        not               a2, a2
0:
        lr.w.aqrl         a0, (a4)
        and               a5, a0, a2
        or                a5, a5, a1
        sc.w.rl           a5, a5, (a4)
        bnez              a5, 0b
        srl               a0, a0, a3
        ret

asm_test::swap::u16::acquire:
        lui               a2, 0x10
        slli              a3, a0, 0x3
        addi              a2, a2, -0x1
        andi              a4, a0, -0x4
        sll               a2, a2, a3
        sll               a1, a1, a3
        not               a2, a2
0:
        lr.w.aq           a0, (a4)
        and               a5, a0, a2
        or                a5, a5, a1
        sc.w              a5, a5, (a4)
        bnez              a5, 0b
        srl               a0, a0, a3
        ret

asm_test::swap::u16::relaxed:
        lui               a2, 0x10
        slli              a3, a0, 0x3
        addi              a2, a2, -0x1
        andi              a4, a0, -0x4
        sll               a2, a2, a3
        sll               a1, a1, a3
        not               a2, a2
0:
        lr.w              a0, (a4)
        and               a5, a0, a2
        or                a5, a5, a1
        sc.w              a5, a5, (a4)
        bnez              a5, 0b
        srl               a0, a0, a3
        ret

asm_test::swap::u16::release:
        lui               a2, 0x10
        slli              a3, a0, 0x3
        addi              a2, a2, -0x1
        andi              a4, a0, -0x4
        sll               a2, a2, a3
        sll               a1, a1, a3
        not               a2, a2
0:
        lr.w              a0, (a4)
        and               a5, a0, a2
        or                a5, a5, a1
        sc.w.rl           a5, a5, (a4)
        bnez              a5, 0b
        srl               a0, a0, a3
        ret

asm_test::swap::u32::acqrel:
        amoswap.w.aqrl    a0, a1, (a0)
        ret

asm_test::swap::u32::seqcst:
        amoswap.w.aqrl    a0, a1, (a0)
        ret

asm_test::swap::u32::acquire:
        amoswap.w.aq      a0, a1, (a0)
        ret

asm_test::swap::u32::relaxed:
        amoswap.w         a0, a1, (a0)
        ret

asm_test::swap::u32::release:
        amoswap.w.rl      a0, a1, (a0)
        ret

asm_test::store::u8::seqcst:
        fence             rw, w
        sb                a1, 0x0(a0)
        fence             rw, rw
        ret

asm_test::store::u8::relaxed:
        sb                a1, 0x0(a0)
        ret

asm_test::store::u8::release:
        sb.rl             a1, (a0)
        ret

asm_test::store::u16::seqcst:
        fence             rw, w
        sh                a1, 0x0(a0)
        fence             rw, rw
        ret

asm_test::store::u16::relaxed:
        sh                a1, 0x0(a0)
        ret

asm_test::store::u16::release:
        sh.rl             a1, (a0)
        ret

asm_test::store::u32::seqcst:
        fence             rw, w
        sw                a1, 0x0(a0)
        fence             rw, rw
        ret

asm_test::store::u32::relaxed:
        sw                a1, 0x0(a0)
        ret

asm_test::store::u32::release:
        sw.rl             a1, (a0)
        ret
