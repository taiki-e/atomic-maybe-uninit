asm_test::compare_exchange::u8::acqrel_seqcst:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w.rl           a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange::u8::seqcst_seqcst:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w.rl           a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange::u8::acqrel_acquire:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w.rl           a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange::u8::acqrel_relaxed:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w.rl           a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange::u8::acquire_seqcst:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w.rl           a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange::u8::relaxed_seqcst:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w.rl           a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange::u8::release_seqcst:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w.rl           a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange::u8::seqcst_acquire:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w.rl           a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange::u8::seqcst_relaxed:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w.rl           a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange::u8::acquire_acquire:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w              a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange::u8::acquire_relaxed:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w              a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange::u8::relaxed_acquire:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w              a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange::u8::relaxed_relaxed:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w              a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w              a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange::u8::release_acquire:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w.rl           a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange::u8::release_relaxed:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w              a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w.rl           a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange::u16::acqrel_seqcst:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w.rl           a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange::u16::seqcst_seqcst:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w.rl           a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange::u16::acqrel_acquire:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w.rl           a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange::u16::acqrel_relaxed:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w.rl           a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange::u16::acquire_seqcst:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w.rl           a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange::u16::relaxed_seqcst:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w.rl           a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange::u16::release_seqcst:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w.rl           a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange::u16::seqcst_acquire:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w.rl           a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange::u16::seqcst_relaxed:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w.rl           a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange::u16::acquire_acquire:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w              a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange::u16::acquire_relaxed:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w              a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange::u16::relaxed_acquire:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w              a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange::u16::relaxed_relaxed:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w              a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w              a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange::u16::release_acquire:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w.rl           a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange::u16::release_relaxed:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w              a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w.rl           a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange::u32::acqrel_seqcst:
        fence             rw, rw
        mv                a3, a1
        amocas.w.aqrl     a3, a2, (a0)
        xor               a0, a3, a1
        seqz              a0, a0
        snez              a1, a0
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::seqcst_seqcst:
        fence             rw, rw
        mv                a3, a1
        amocas.w.aqrl     a3, a2, (a0)
        xor               a0, a3, a1
        seqz              a0, a0
        snez              a1, a0
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::acqrel_acquire:
        mv                a3, a1
        amocas.w.aqrl     a3, a2, (a0)
        xor               a0, a3, a1
        seqz              a0, a0
        snez              a1, a0
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::acqrel_relaxed:
        mv                a3, a1
        amocas.w.aqrl     a3, a2, (a0)
        xor               a0, a3, a1
        seqz              a0, a0
        snez              a1, a0
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::acquire_seqcst:
        fence             rw, rw
        mv                a3, a1
        amocas.w.aqrl     a3, a2, (a0)
        xor               a0, a3, a1
        seqz              a0, a0
        snez              a1, a0
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::relaxed_seqcst:
        fence             rw, rw
        mv                a3, a1
        amocas.w.aqrl     a3, a2, (a0)
        xor               a0, a3, a1
        seqz              a0, a0
        snez              a1, a0
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::release_seqcst:
        fence             rw, rw
        mv                a3, a1
        amocas.w.aqrl     a3, a2, (a0)
        xor               a0, a3, a1
        seqz              a0, a0
        snez              a1, a0
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::seqcst_acquire:
        mv                a3, a1
        amocas.w.aqrl     a3, a2, (a0)
        xor               a0, a3, a1
        seqz              a0, a0
        snez              a1, a0
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::seqcst_relaxed:
        mv                a3, a1
        amocas.w.aqrl     a3, a2, (a0)
        xor               a0, a3, a1
        seqz              a0, a0
        snez              a1, a0
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::acquire_acquire:
        mv                a3, a1
        amocas.w.aq       a3, a2, (a0)
        xor               a0, a3, a1
        seqz              a0, a0
        snez              a1, a0
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::acquire_relaxed:
        mv                a3, a1
        amocas.w.aq       a3, a2, (a0)
        xor               a0, a3, a1
        seqz              a0, a0
        snez              a1, a0
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::relaxed_acquire:
        mv                a3, a1
        amocas.w.aq       a3, a2, (a0)
        xor               a0, a3, a1
        seqz              a0, a0
        snez              a1, a0
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::relaxed_relaxed:
        mv                a3, a1
        amocas.w          a3, a2, (a0)
        xor               a0, a3, a1
        seqz              a0, a0
        snez              a1, a0
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::release_acquire:
        mv                a3, a1
        amocas.w.aqrl     a3, a2, (a0)
        xor               a0, a3, a1
        seqz              a0, a0
        snez              a1, a0
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::release_relaxed:
        mv                a3, a1
        amocas.w.rl       a3, a2, (a0)
        xor               a0, a3, a1
        seqz              a0, a0
        snez              a1, a0
        mv                a0, a3
        ret

asm_test::compare_exchange::u64::acqrel_seqcst:
        mv                a6, a5
        mv                a7, a4
        mv                a4, a2
        mv                a5, a3
        mv                a3, a6
        mv                a2, a7
        fence             rw, rw
        mv                a6, a4
        mv                a7, a5
        amocas.d.aqrl     a4, a2, (a1)
        xor               a6, a6, a4
        xor               a7, a7, a5
        or                a6, a6, a7
        seqz              a6, a6
        sw                a4, 0x0(a0)
        sw                a5, 0x4(a0)
        sb                a6, 0x8(a0)
        ret

asm_test::compare_exchange::u64::seqcst_seqcst:
        mv                a6, a5
        mv                a7, a4
        mv                a4, a2
        mv                a5, a3
        mv                a3, a6
        mv                a2, a7
        fence             rw, rw
        mv                a6, a4
        mv                a7, a5
        amocas.d.aqrl     a4, a2, (a1)
        xor               a6, a6, a4
        xor               a7, a7, a5
        or                a6, a6, a7
        seqz              a6, a6
        sw                a4, 0x0(a0)
        sw                a5, 0x4(a0)
        sb                a6, 0x8(a0)
        ret

asm_test::compare_exchange::u64::acqrel_acquire:
        mv                a6, a5
        mv                a7, a4
        mv                a4, a2
        mv                a5, a3
        mv                a3, a6
        mv                a2, a7
        mv                a6, a4
        mv                a7, a5
        amocas.d.aqrl     a4, a2, (a1)
        xor               a6, a6, a4
        xor               a7, a7, a5
        or                a6, a6, a7
        seqz              a6, a6
        sw                a4, 0x0(a0)
        sw                a5, 0x4(a0)
        sb                a6, 0x8(a0)
        ret

asm_test::compare_exchange::u64::acqrel_relaxed:
        mv                a6, a5
        mv                a7, a4
        mv                a4, a2
        mv                a5, a3
        mv                a3, a6
        mv                a2, a7
        mv                a6, a4
        mv                a7, a5
        amocas.d.aqrl     a4, a2, (a1)
        xor               a6, a6, a4
        xor               a7, a7, a5
        or                a6, a6, a7
        seqz              a6, a6
        sw                a4, 0x0(a0)
        sw                a5, 0x4(a0)
        sb                a6, 0x8(a0)
        ret

asm_test::compare_exchange::u64::acquire_seqcst:
        mv                a6, a5
        mv                a7, a4
        mv                a4, a2
        mv                a5, a3
        mv                a3, a6
        mv                a2, a7
        fence             rw, rw
        mv                a6, a4
        mv                a7, a5
        amocas.d.aqrl     a4, a2, (a1)
        xor               a6, a6, a4
        xor               a7, a7, a5
        or                a6, a6, a7
        seqz              a6, a6
        sw                a4, 0x0(a0)
        sw                a5, 0x4(a0)
        sb                a6, 0x8(a0)
        ret

asm_test::compare_exchange::u64::relaxed_seqcst:
        mv                a6, a5
        mv                a7, a4
        mv                a4, a2
        mv                a5, a3
        mv                a3, a6
        mv                a2, a7
        fence             rw, rw
        mv                a6, a4
        mv                a7, a5
        amocas.d.aqrl     a4, a2, (a1)
        xor               a6, a6, a4
        xor               a7, a7, a5
        or                a6, a6, a7
        seqz              a6, a6
        sw                a4, 0x0(a0)
        sw                a5, 0x4(a0)
        sb                a6, 0x8(a0)
        ret

asm_test::compare_exchange::u64::release_seqcst:
        mv                a6, a5
        mv                a7, a4
        mv                a4, a2
        mv                a5, a3
        mv                a3, a6
        mv                a2, a7
        fence             rw, rw
        mv                a6, a4
        mv                a7, a5
        amocas.d.aqrl     a4, a2, (a1)
        xor               a6, a6, a4
        xor               a7, a7, a5
        or                a6, a6, a7
        seqz              a6, a6
        sw                a4, 0x0(a0)
        sw                a5, 0x4(a0)
        sb                a6, 0x8(a0)
        ret

asm_test::compare_exchange::u64::seqcst_acquire:
        mv                a6, a5
        mv                a7, a4
        mv                a4, a2
        mv                a5, a3
        mv                a3, a6
        mv                a2, a7
        mv                a6, a4
        mv                a7, a5
        amocas.d.aqrl     a4, a2, (a1)
        xor               a6, a6, a4
        xor               a7, a7, a5
        or                a6, a6, a7
        seqz              a6, a6
        sw                a4, 0x0(a0)
        sw                a5, 0x4(a0)
        sb                a6, 0x8(a0)
        ret

asm_test::compare_exchange::u64::seqcst_relaxed:
        mv                a6, a5
        mv                a7, a4
        mv                a4, a2
        mv                a5, a3
        mv                a3, a6
        mv                a2, a7
        mv                a6, a4
        mv                a7, a5
        amocas.d.aqrl     a4, a2, (a1)
        xor               a6, a6, a4
        xor               a7, a7, a5
        or                a6, a6, a7
        seqz              a6, a6
        sw                a4, 0x0(a0)
        sw                a5, 0x4(a0)
        sb                a6, 0x8(a0)
        ret

asm_test::compare_exchange::u64::acquire_acquire:
        mv                a6, a5
        mv                a7, a4
        mv                a4, a2
        mv                a5, a3
        mv                a3, a6
        mv                a2, a7
        mv                a6, a4
        mv                a7, a5
        amocas.d.aq       a4, a2, (a1)
        xor               a6, a6, a4
        xor               a7, a7, a5
        or                a6, a6, a7
        seqz              a6, a6
        sw                a4, 0x0(a0)
        sw                a5, 0x4(a0)
        sb                a6, 0x8(a0)
        ret

asm_test::compare_exchange::u64::acquire_relaxed:
        mv                a6, a5
        mv                a7, a4
        mv                a4, a2
        mv                a5, a3
        mv                a3, a6
        mv                a2, a7
        mv                a6, a4
        mv                a7, a5
        amocas.d.aq       a4, a2, (a1)
        xor               a6, a6, a4
        xor               a7, a7, a5
        or                a6, a6, a7
        seqz              a6, a6
        sw                a4, 0x0(a0)
        sw                a5, 0x4(a0)
        sb                a6, 0x8(a0)
        ret

asm_test::compare_exchange::u64::relaxed_acquire:
        mv                a6, a5
        mv                a7, a4
        mv                a4, a2
        mv                a5, a3
        mv                a3, a6
        mv                a2, a7
        mv                a6, a4
        mv                a7, a5
        amocas.d.aq       a4, a2, (a1)
        xor               a6, a6, a4
        xor               a7, a7, a5
        or                a6, a6, a7
        seqz              a6, a6
        sw                a4, 0x0(a0)
        sw                a5, 0x4(a0)
        sb                a6, 0x8(a0)
        ret

asm_test::compare_exchange::u64::relaxed_relaxed:
        mv                a6, a5
        mv                a7, a4
        mv                a4, a2
        mv                a5, a3
        mv                a3, a6
        mv                a2, a7
        mv                a6, a4
        mv                a7, a5
        amocas.d          a4, a2, (a1)
        xor               a6, a6, a4
        xor               a7, a7, a5
        or                a6, a6, a7
        seqz              a6, a6
        sw                a4, 0x0(a0)
        sw                a5, 0x4(a0)
        sb                a6, 0x8(a0)
        ret

asm_test::compare_exchange::u64::release_acquire:
        mv                a6, a5
        mv                a7, a4
        mv                a4, a2
        mv                a5, a3
        mv                a3, a6
        mv                a2, a7
        mv                a6, a4
        mv                a7, a5
        amocas.d.aqrl     a4, a2, (a1)
        xor               a6, a6, a4
        xor               a7, a7, a5
        or                a6, a6, a7
        seqz              a6, a6
        sw                a4, 0x0(a0)
        sw                a5, 0x4(a0)
        sb                a6, 0x8(a0)
        ret

asm_test::compare_exchange::u64::release_relaxed:
        mv                a6, a5
        mv                a7, a4
        mv                a4, a2
        mv                a5, a3
        mv                a3, a6
        mv                a2, a7
        mv                a6, a4
        mv                a7, a5
        amocas.d.rl       a4, a2, (a1)
        xor               a6, a6, a4
        xor               a7, a7, a5
        or                a6, a6, a7
        seqz              a6, a6
        sw                a4, 0x0(a0)
        sw                a5, 0x4(a0)
        sb                a6, 0x8(a0)
        ret

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w.rl           a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w.rl           a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w.rl           a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w.rl           a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w.rl           a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w.rl           a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange_weak::u8::release_seqcst:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w.rl           a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w.rl           a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w.rl           a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange_weak::u8::acquire_acquire:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w              a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w              a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w              a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w              a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w              a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange_weak::u8::release_acquire:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w.rl           a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange_weak::u8::release_relaxed:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w              a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w.rl           a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w.rl           a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w.rl           a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w.rl           a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w.rl           a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w.rl           a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w.rl           a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange_weak::u16::release_seqcst:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w.rl           a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w.rl           a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w.rl           a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange_weak::u16::acquire_acquire:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w              a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w              a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w              a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w              a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w              a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange_weak::u16::release_acquire:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w.rl           a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange_weak::u16::release_relaxed:
        andi              a6, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w              a3, (a6)
        and               a0, a3, a5
        bne               a0, a1, 1f
        xor               a0, a3, a2
        and               a0, a0, a5
        xor               a0, a0, a3
        sc.w.rl           a0, a0, (a6)
        bnez              a0, 0b
1:
        srl               a0, a3, a4
        and               a3, a3, a5
        xor               a3, a3, a1
        seqz              a3, a3
        snez              a1, a3
        ret

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        fence             rw, rw
        mv                a3, a1
        amocas.w.aqrl     a3, a2, (a0)
        xor               a0, a3, a1
        seqz              a0, a0
        snez              a1, a0
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        fence             rw, rw
        mv                a3, a1
        amocas.w.aqrl     a3, a2, (a0)
        xor               a0, a3, a1
        seqz              a0, a0
        snez              a1, a0
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        mv                a3, a1
        amocas.w.aqrl     a3, a2, (a0)
        xor               a0, a3, a1
        seqz              a0, a0
        snez              a1, a0
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        mv                a3, a1
        amocas.w.aqrl     a3, a2, (a0)
        xor               a0, a3, a1
        seqz              a0, a0
        snez              a1, a0
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        fence             rw, rw
        mv                a3, a1
        amocas.w.aqrl     a3, a2, (a0)
        xor               a0, a3, a1
        seqz              a0, a0
        snez              a1, a0
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        fence             rw, rw
        mv                a3, a1
        amocas.w.aqrl     a3, a2, (a0)
        xor               a0, a3, a1
        seqz              a0, a0
        snez              a1, a0
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::release_seqcst:
        fence             rw, rw
        mv                a3, a1
        amocas.w.aqrl     a3, a2, (a0)
        xor               a0, a3, a1
        seqz              a0, a0
        snez              a1, a0
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        mv                a3, a1
        amocas.w.aqrl     a3, a2, (a0)
        xor               a0, a3, a1
        seqz              a0, a0
        snez              a1, a0
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        mv                a3, a1
        amocas.w.aqrl     a3, a2, (a0)
        xor               a0, a3, a1
        seqz              a0, a0
        snez              a1, a0
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::acquire_acquire:
        mv                a3, a1
        amocas.w.aq       a3, a2, (a0)
        xor               a0, a3, a1
        seqz              a0, a0
        snez              a1, a0
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        mv                a3, a1
        amocas.w.aq       a3, a2, (a0)
        xor               a0, a3, a1
        seqz              a0, a0
        snez              a1, a0
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        mv                a3, a1
        amocas.w.aq       a3, a2, (a0)
        xor               a0, a3, a1
        seqz              a0, a0
        snez              a1, a0
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        mv                a3, a1
        amocas.w          a3, a2, (a0)
        xor               a0, a3, a1
        seqz              a0, a0
        snez              a1, a0
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::release_acquire:
        mv                a3, a1
        amocas.w.aqrl     a3, a2, (a0)
        xor               a0, a3, a1
        seqz              a0, a0
        snez              a1, a0
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::release_relaxed:
        mv                a3, a1
        amocas.w.rl       a3, a2, (a0)
        xor               a0, a3, a1
        seqz              a0, a0
        snez              a1, a0
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u64::acqrel_seqcst:
        mv                a6, a5
        mv                a7, a4
        mv                a4, a2
        mv                a5, a3
        mv                a3, a6
        mv                a2, a7
        fence             rw, rw
        mv                a6, a4
        mv                a7, a5
        amocas.d.aqrl     a4, a2, (a1)
        xor               a6, a6, a4
        xor               a7, a7, a5
        or                a6, a6, a7
        seqz              a6, a6
        sw                a4, 0x0(a0)
        sw                a5, 0x4(a0)
        sb                a6, 0x8(a0)
        ret

asm_test::compare_exchange_weak::u64::seqcst_seqcst:
        mv                a6, a5
        mv                a7, a4
        mv                a4, a2
        mv                a5, a3
        mv                a3, a6
        mv                a2, a7
        fence             rw, rw
        mv                a6, a4
        mv                a7, a5
        amocas.d.aqrl     a4, a2, (a1)
        xor               a6, a6, a4
        xor               a7, a7, a5
        or                a6, a6, a7
        seqz              a6, a6
        sw                a4, 0x0(a0)
        sw                a5, 0x4(a0)
        sb                a6, 0x8(a0)
        ret

asm_test::compare_exchange_weak::u64::acqrel_acquire:
        mv                a6, a5
        mv                a7, a4
        mv                a4, a2
        mv                a5, a3
        mv                a3, a6
        mv                a2, a7
        mv                a6, a4
        mv                a7, a5
        amocas.d.aqrl     a4, a2, (a1)
        xor               a6, a6, a4
        xor               a7, a7, a5
        or                a6, a6, a7
        seqz              a6, a6
        sw                a4, 0x0(a0)
        sw                a5, 0x4(a0)
        sb                a6, 0x8(a0)
        ret

asm_test::compare_exchange_weak::u64::acqrel_relaxed:
        mv                a6, a5
        mv                a7, a4
        mv                a4, a2
        mv                a5, a3
        mv                a3, a6
        mv                a2, a7
        mv                a6, a4
        mv                a7, a5
        amocas.d.aqrl     a4, a2, (a1)
        xor               a6, a6, a4
        xor               a7, a7, a5
        or                a6, a6, a7
        seqz              a6, a6
        sw                a4, 0x0(a0)
        sw                a5, 0x4(a0)
        sb                a6, 0x8(a0)
        ret

asm_test::compare_exchange_weak::u64::acquire_seqcst:
        mv                a6, a5
        mv                a7, a4
        mv                a4, a2
        mv                a5, a3
        mv                a3, a6
        mv                a2, a7
        fence             rw, rw
        mv                a6, a4
        mv                a7, a5
        amocas.d.aqrl     a4, a2, (a1)
        xor               a6, a6, a4
        xor               a7, a7, a5
        or                a6, a6, a7
        seqz              a6, a6
        sw                a4, 0x0(a0)
        sw                a5, 0x4(a0)
        sb                a6, 0x8(a0)
        ret

asm_test::compare_exchange_weak::u64::relaxed_seqcst:
        mv                a6, a5
        mv                a7, a4
        mv                a4, a2
        mv                a5, a3
        mv                a3, a6
        mv                a2, a7
        fence             rw, rw
        mv                a6, a4
        mv                a7, a5
        amocas.d.aqrl     a4, a2, (a1)
        xor               a6, a6, a4
        xor               a7, a7, a5
        or                a6, a6, a7
        seqz              a6, a6
        sw                a4, 0x0(a0)
        sw                a5, 0x4(a0)
        sb                a6, 0x8(a0)
        ret

asm_test::compare_exchange_weak::u64::release_seqcst:
        mv                a6, a5
        mv                a7, a4
        mv                a4, a2
        mv                a5, a3
        mv                a3, a6
        mv                a2, a7
        fence             rw, rw
        mv                a6, a4
        mv                a7, a5
        amocas.d.aqrl     a4, a2, (a1)
        xor               a6, a6, a4
        xor               a7, a7, a5
        or                a6, a6, a7
        seqz              a6, a6
        sw                a4, 0x0(a0)
        sw                a5, 0x4(a0)
        sb                a6, 0x8(a0)
        ret

asm_test::compare_exchange_weak::u64::seqcst_acquire:
        mv                a6, a5
        mv                a7, a4
        mv                a4, a2
        mv                a5, a3
        mv                a3, a6
        mv                a2, a7
        mv                a6, a4
        mv                a7, a5
        amocas.d.aqrl     a4, a2, (a1)
        xor               a6, a6, a4
        xor               a7, a7, a5
        or                a6, a6, a7
        seqz              a6, a6
        sw                a4, 0x0(a0)
        sw                a5, 0x4(a0)
        sb                a6, 0x8(a0)
        ret

asm_test::compare_exchange_weak::u64::seqcst_relaxed:
        mv                a6, a5
        mv                a7, a4
        mv                a4, a2
        mv                a5, a3
        mv                a3, a6
        mv                a2, a7
        mv                a6, a4
        mv                a7, a5
        amocas.d.aqrl     a4, a2, (a1)
        xor               a6, a6, a4
        xor               a7, a7, a5
        or                a6, a6, a7
        seqz              a6, a6
        sw                a4, 0x0(a0)
        sw                a5, 0x4(a0)
        sb                a6, 0x8(a0)
        ret

asm_test::compare_exchange_weak::u64::acquire_acquire:
        mv                a6, a5
        mv                a7, a4
        mv                a4, a2
        mv                a5, a3
        mv                a3, a6
        mv                a2, a7
        mv                a6, a4
        mv                a7, a5
        amocas.d.aq       a4, a2, (a1)
        xor               a6, a6, a4
        xor               a7, a7, a5
        or                a6, a6, a7
        seqz              a6, a6
        sw                a4, 0x0(a0)
        sw                a5, 0x4(a0)
        sb                a6, 0x8(a0)
        ret

asm_test::compare_exchange_weak::u64::acquire_relaxed:
        mv                a6, a5
        mv                a7, a4
        mv                a4, a2
        mv                a5, a3
        mv                a3, a6
        mv                a2, a7
        mv                a6, a4
        mv                a7, a5
        amocas.d.aq       a4, a2, (a1)
        xor               a6, a6, a4
        xor               a7, a7, a5
        or                a6, a6, a7
        seqz              a6, a6
        sw                a4, 0x0(a0)
        sw                a5, 0x4(a0)
        sb                a6, 0x8(a0)
        ret

asm_test::compare_exchange_weak::u64::relaxed_acquire:
        mv                a6, a5
        mv                a7, a4
        mv                a4, a2
        mv                a5, a3
        mv                a3, a6
        mv                a2, a7
        mv                a6, a4
        mv                a7, a5
        amocas.d.aq       a4, a2, (a1)
        xor               a6, a6, a4
        xor               a7, a7, a5
        or                a6, a6, a7
        seqz              a6, a6
        sw                a4, 0x0(a0)
        sw                a5, 0x4(a0)
        sb                a6, 0x8(a0)
        ret

asm_test::compare_exchange_weak::u64::relaxed_relaxed:
        mv                a6, a5
        mv                a7, a4
        mv                a4, a2
        mv                a5, a3
        mv                a3, a6
        mv                a2, a7
        mv                a6, a4
        mv                a7, a5
        amocas.d          a4, a2, (a1)
        xor               a6, a6, a4
        xor               a7, a7, a5
        or                a6, a6, a7
        seqz              a6, a6
        sw                a4, 0x0(a0)
        sw                a5, 0x4(a0)
        sb                a6, 0x8(a0)
        ret

asm_test::compare_exchange_weak::u64::release_acquire:
        mv                a6, a5
        mv                a7, a4
        mv                a4, a2
        mv                a5, a3
        mv                a3, a6
        mv                a2, a7
        mv                a6, a4
        mv                a7, a5
        amocas.d.aqrl     a4, a2, (a1)
        xor               a6, a6, a4
        xor               a7, a7, a5
        or                a6, a6, a7
        seqz              a6, a6
        sw                a4, 0x0(a0)
        sw                a5, 0x4(a0)
        sb                a6, 0x8(a0)
        ret

asm_test::compare_exchange_weak::u64::release_relaxed:
        mv                a6, a5
        mv                a7, a4
        mv                a4, a2
        mv                a5, a3
        mv                a3, a6
        mv                a2, a7
        mv                a6, a4
        mv                a7, a5
        amocas.d.rl       a4, a2, (a1)
        xor               a6, a6, a4
        xor               a7, a7, a5
        or                a6, a6, a7
        seqz              a6, a6
        sw                a4, 0x0(a0)
        sw                a5, 0x4(a0)
        sb                a6, 0x8(a0)
        ret

asm_test::load::u8::seqcst:
        fence             rw, rw
        lb                a0, 0x0(a0)
        fence             r, rw
        ret

asm_test::load::u8::acquire:
        lb                a0, 0x0(a0)
        fence             r, rw
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
        lh                a0, 0x0(a0)
        fence             r, rw
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
        lw                a0, 0x0(a0)
        fence             r, rw
        ret

asm_test::load::u32::relaxed:
        lw                a0, 0x0(a0)
        ret

asm_test::load::u64::seqcst:
        li                a2, 0x0
        li                a3, 0x0
        fence             rw, rw
        amocas.d.aqrl     a2, a2, (a0)
        mv                a1, a3
        mv                a0, a2
        ret

asm_test::load::u64::acquire:
        li                a2, 0x0
        li                a3, 0x0
        amocas.d.aq       a2, a2, (a0)
        mv                a1, a3
        mv                a0, a2
        ret

asm_test::load::u64::relaxed:
        li                a2, 0x0
        li                a3, 0x0
        amocas.d          a2, a2, (a0)
        mv                a1, a3
        mv                a0, a2
        ret

asm_test::swap::u8::acqrel:
        andi              a2, a0, -0x4
        slli              a3, a0, 0x3
        li                a4, 0xff
        sll               a4, a4, a3
        sll               a1, a1, a3
        not               a4, a4
0:
        lr.w.aq           a0, (a2)
        and               a5, a0, a4
        or                a5, a5, a1
        sc.w.rl           a5, a5, (a2)
        bnez              a5, 0b
        srl               a0, a0, a3
        ret

asm_test::swap::u8::seqcst:
        andi              a2, a0, -0x4
        slli              a3, a0, 0x3
        li                a4, 0xff
        sll               a4, a4, a3
        sll               a1, a1, a3
        not               a4, a4
0:
        lr.w.aqrl         a0, (a2)
        and               a5, a0, a4
        or                a5, a5, a1
        sc.w.rl           a5, a5, (a2)
        bnez              a5, 0b
        srl               a0, a0, a3
        ret

asm_test::swap::u8::acquire:
        andi              a2, a0, -0x4
        slli              a3, a0, 0x3
        li                a4, 0xff
        sll               a4, a4, a3
        sll               a1, a1, a3
        not               a4, a4
0:
        lr.w.aq           a0, (a2)
        and               a5, a0, a4
        or                a5, a5, a1
        sc.w              a5, a5, (a2)
        bnez              a5, 0b
        srl               a0, a0, a3
        ret

asm_test::swap::u8::relaxed:
        andi              a2, a0, -0x4
        slli              a3, a0, 0x3
        li                a4, 0xff
        sll               a4, a4, a3
        sll               a1, a1, a3
        not               a4, a4
0:
        lr.w              a0, (a2)
        and               a5, a0, a4
        or                a5, a5, a1
        sc.w              a5, a5, (a2)
        bnez              a5, 0b
        srl               a0, a0, a3
        ret

asm_test::swap::u8::release:
        andi              a2, a0, -0x4
        slli              a3, a0, 0x3
        li                a4, 0xff
        sll               a4, a4, a3
        sll               a1, a1, a3
        not               a4, a4
0:
        lr.w              a0, (a2)
        and               a5, a0, a4
        or                a5, a5, a1
        sc.w.rl           a5, a5, (a2)
        bnez              a5, 0b
        srl               a0, a0, a3
        ret

asm_test::swap::u16::acqrel:
        andi              a2, a0, -0x4
        slli              a3, a0, 0x3
        lui               a0, 0x10
        addi              a4, a0, -0x1
        sll               a4, a4, a3
        sll               a1, a1, a3
        not               a4, a4
0:
        lr.w.aq           a0, (a2)
        and               a5, a0, a4
        or                a5, a5, a1
        sc.w.rl           a5, a5, (a2)
        bnez              a5, 0b
        srl               a0, a0, a3
        ret

asm_test::swap::u16::seqcst:
        andi              a2, a0, -0x4
        slli              a3, a0, 0x3
        lui               a0, 0x10
        addi              a4, a0, -0x1
        sll               a4, a4, a3
        sll               a1, a1, a3
        not               a4, a4
0:
        lr.w.aqrl         a0, (a2)
        and               a5, a0, a4
        or                a5, a5, a1
        sc.w.rl           a5, a5, (a2)
        bnez              a5, 0b
        srl               a0, a0, a3
        ret

asm_test::swap::u16::acquire:
        andi              a2, a0, -0x4
        slli              a3, a0, 0x3
        lui               a0, 0x10
        addi              a4, a0, -0x1
        sll               a4, a4, a3
        sll               a1, a1, a3
        not               a4, a4
0:
        lr.w.aq           a0, (a2)
        and               a5, a0, a4
        or                a5, a5, a1
        sc.w              a5, a5, (a2)
        bnez              a5, 0b
        srl               a0, a0, a3
        ret

asm_test::swap::u16::relaxed:
        andi              a2, a0, -0x4
        slli              a3, a0, 0x3
        lui               a0, 0x10
        addi              a4, a0, -0x1
        sll               a4, a4, a3
        sll               a1, a1, a3
        not               a4, a4
0:
        lr.w              a0, (a2)
        and               a5, a0, a4
        or                a5, a5, a1
        sc.w              a5, a5, (a2)
        bnez              a5, 0b
        srl               a0, a0, a3
        ret

asm_test::swap::u16::release:
        andi              a2, a0, -0x4
        slli              a3, a0, 0x3
        lui               a0, 0x10
        addi              a4, a0, -0x1
        sll               a4, a4, a3
        sll               a1, a1, a3
        not               a4, a4
0:
        lr.w              a0, (a2)
        and               a5, a0, a4
        or                a5, a5, a1
        sc.w.rl           a5, a5, (a2)
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

asm_test::swap::u64::acqrel:
        mv                a3, a2
        mv                a2, a1
        lw                a4, 0x0(a0)
        lw                a5, 0x4(a0)
0:
        mv                a1, a4
        mv                a6, a5
        amocas.d.aqrl     a4, a2, (a0)
        xor               a1, a1, a4
        xor               a6, a6, a5
        or                a1, a1, a6
        bnez              a1, 0b
        mv                a1, a5
        mv                a0, a4
        ret

asm_test::swap::u64::seqcst:
        mv                a3, a2
        mv                a2, a1
        lw                a4, 0x0(a0)
        lw                a5, 0x4(a0)
0:
        mv                a1, a4
        mv                a6, a5
        amocas.d.aqrl     a4, a2, (a0)
        xor               a1, a1, a4
        xor               a6, a6, a5
        or                a1, a1, a6
        bnez              a1, 0b
        mv                a1, a5
        mv                a0, a4
        ret

asm_test::swap::u64::acquire:
        mv                a3, a2
        mv                a2, a1
        lw                a4, 0x0(a0)
        lw                a5, 0x4(a0)
0:
        mv                a1, a4
        mv                a6, a5
        amocas.d.aq       a4, a2, (a0)
        xor               a1, a1, a4
        xor               a6, a6, a5
        or                a1, a1, a6
        bnez              a1, 0b
        mv                a1, a5
        mv                a0, a4
        ret

asm_test::swap::u64::relaxed:
        mv                a3, a2
        mv                a2, a1
        lw                a4, 0x0(a0)
        lw                a5, 0x4(a0)
0:
        mv                a1, a4
        mv                a6, a5
        amocas.d          a4, a2, (a0)
        xor               a1, a1, a4
        xor               a6, a6, a5
        or                a1, a1, a6
        bnez              a1, 0b
        mv                a1, a5
        mv                a0, a4
        ret

asm_test::swap::u64::release:
        mv                a3, a2
        mv                a2, a1
        lw                a4, 0x0(a0)
        lw                a5, 0x4(a0)
0:
        mv                a1, a4
        mv                a6, a5
        amocas.d.rl       a4, a2, (a0)
        xor               a1, a1, a4
        xor               a6, a6, a5
        or                a1, a1, a6
        bnez              a1, 0b
        mv                a1, a5
        mv                a0, a4
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
        fence             rw, w
        sb                a1, 0x0(a0)
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
        fence             rw, w
        sh                a1, 0x0(a0)
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
        fence             rw, w
        sw                a1, 0x0(a0)
        ret

asm_test::store::u64::seqcst:
        mv                a3, a2
        mv                a2, a1
        lw                a4, 0x0(a0)
        lw                a5, 0x4(a0)
0:
        mv                a1, a4
        mv                a6, a5
        amocas.d.aqrl     a4, a2, (a0)
        xor               a1, a1, a4
        xor               a6, a6, a5
        or                a1, a1, a6
        bnez              a1, 0b
        ret

asm_test::store::u64::relaxed:
        mv                a3, a2
        mv                a2, a1
        lw                a4, 0x0(a0)
        lw                a5, 0x4(a0)
0:
        mv                a1, a4
        mv                a6, a5
        amocas.d          a4, a2, (a0)
        xor               a1, a1, a4
        xor               a6, a6, a5
        or                a1, a1, a6
        bnez              a1, 0b
        ret

asm_test::store::u64::release:
        mv                a3, a2
        mv                a2, a1
        lw                a4, 0x0(a0)
        lw                a5, 0x4(a0)
0:
        mv                a1, a4
        mv                a6, a5
        amocas.d.rl       a4, a2, (a0)
        xor               a1, a1, a4
        xor               a6, a6, a5
        or                a1, a1, a6
        bnez              a1, 0b
        ret

