asm_test::compare_exchange::u8::acqrel_seqcst:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w.rl           a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange::u8::seqcst_seqcst:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w.rl           a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange::u8::acqrel_acquire:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w.rl           a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange::u8::acqrel_relaxed:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w.rl           a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange::u8::acquire_seqcst:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w.rl           a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange::u8::relaxed_seqcst:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w.rl           a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange::u8::release_seqcst:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w.rl           a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange::u8::seqcst_acquire:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w.rl           a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange::u8::seqcst_relaxed:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w.rl           a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange::u8::acquire_acquire:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w              a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange::u8::acquire_relaxed:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w              a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange::u8::relaxed_acquire:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w              a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange::u8::relaxed_relaxed:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w              a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w              a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange::u8::release_acquire:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w.rl           a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange::u8::release_relaxed:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w              a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w.rl           a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange::u16::acqrel_seqcst:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w.rl           a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange::u16::seqcst_seqcst:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w.rl           a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange::u16::acqrel_acquire:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w.rl           a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange::u16::acqrel_relaxed:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w.rl           a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange::u16::acquire_seqcst:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w.rl           a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange::u16::relaxed_seqcst:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w.rl           a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange::u16::release_seqcst:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w.rl           a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange::u16::seqcst_acquire:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w.rl           a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange::u16::seqcst_relaxed:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w.rl           a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange::u16::acquire_acquire:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w              a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange::u16::acquire_relaxed:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w              a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange::u16::relaxed_acquire:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w              a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange::u16::relaxed_relaxed:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w              a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w              a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange::u16::release_acquire:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w.rl           a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange::u16::release_relaxed:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w              a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w.rl           a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange::u32::acqrel_seqcst:
0:
        lr.w.aqrl         a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a4, a3, a1
        seqz              a4, a4
        snez              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::seqcst_seqcst:
0:
        lr.w.aqrl         a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a4, a3, a1
        seqz              a4, a4
        snez              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::acqrel_acquire:
0:
        lr.w.aq           a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a4, a3, a1
        seqz              a4, a4
        snez              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::acqrel_relaxed:
0:
        lr.w.aq           a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a4, a3, a1
        seqz              a4, a4
        snez              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::acquire_seqcst:
0:
        lr.w.aqrl         a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a4, a3, a1
        seqz              a4, a4
        snez              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::relaxed_seqcst:
0:
        lr.w.aqrl         a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a4, a3, a1
        seqz              a4, a4
        snez              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::release_seqcst:
0:
        lr.w.aqrl         a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a4, a3, a1
        seqz              a4, a4
        snez              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::seqcst_acquire:
0:
        lr.w.aqrl         a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a4, a3, a1
        seqz              a4, a4
        snez              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::seqcst_relaxed:
0:
        lr.w.aqrl         a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a4, a3, a1
        seqz              a4, a4
        snez              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::acquire_acquire:
0:
        lr.w.aq           a3, (a0)
        bne               a3, a1, 1f
        sc.w              a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a4, a3, a1
        seqz              a4, a4
        snez              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::acquire_relaxed:
0:
        lr.w.aq           a3, (a0)
        bne               a3, a1, 1f
        sc.w              a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a4, a3, a1
        seqz              a4, a4
        snez              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::relaxed_acquire:
0:
        lr.w.aq           a3, (a0)
        bne               a3, a1, 1f
        sc.w              a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a4, a3, a1
        seqz              a4, a4
        snez              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::relaxed_relaxed:
0:
        lr.w              a3, (a0)
        bne               a3, a1, 1f
        sc.w              a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a4, a3, a1
        seqz              a4, a4
        snez              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::release_acquire:
0:
        lr.w.aq           a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a4, a3, a1
        seqz              a4, a4
        snez              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::release_relaxed:
0:
        lr.w              a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a4, a3, a1
        seqz              a4, a4
        snez              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w.rl           a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w.rl           a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w.rl           a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w.rl           a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w.rl           a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w.rl           a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u8::release_seqcst:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w.rl           a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w.rl           a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w.rl           a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u8::acquire_acquire:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w              a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w              a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w              a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w              a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w              a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u8::release_acquire:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w.rl           a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u8::release_relaxed:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        li                a5, 0xff
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w              a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w.rl           a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w.rl           a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w.rl           a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w.rl           a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w.rl           a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w.rl           a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w.rl           a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u16::release_seqcst:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w.rl           a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w.rl           a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aqrl         a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w.rl           a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u16::acquire_acquire:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w              a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w              a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w              a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w              a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w              a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u16::release_acquire:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w.aq           a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w.rl           a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u16::release_relaxed:
        andi              a3, a0, -0x4
        slli              a4, a0, 0x3
        lui               a0, 0x10
        addi              a5, a0, -0x1
        sll               a5, a5, a4
        sll               a1, a1, a4
        sll               a2, a2, a4
0:
        lr.w              a6, (a3)
        and               a0, a6, a5
        bne               a0, a1, 1f
        xor               a0, a6, a2
        and               a0, a0, a5
        xor               a0, a0, a6
        sc.w.rl           a0, a0, (a3)
        bnez              a0, 0b
1:
        srl               a0, a6, a4
        and               a6, a6, a5
        xor               a6, a1, a6
        seqz              a6, a6
        snez              a1, a6
        ret

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
0:
        lr.w.aqrl         a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a4, a3, a1
        seqz              a4, a4
        snez              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
0:
        lr.w.aqrl         a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a4, a3, a1
        seqz              a4, a4
        snez              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::acqrel_acquire:
0:
        lr.w.aq           a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a4, a3, a1
        seqz              a4, a4
        snez              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
0:
        lr.w.aq           a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a4, a3, a1
        seqz              a4, a4
        snez              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::acquire_seqcst:
0:
        lr.w.aqrl         a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a4, a3, a1
        seqz              a4, a4
        snez              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
0:
        lr.w.aqrl         a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a4, a3, a1
        seqz              a4, a4
        snez              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::release_seqcst:
0:
        lr.w.aqrl         a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a4, a3, a1
        seqz              a4, a4
        snez              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::seqcst_acquire:
0:
        lr.w.aqrl         a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a4, a3, a1
        seqz              a4, a4
        snez              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
0:
        lr.w.aqrl         a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a4, a3, a1
        seqz              a4, a4
        snez              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::acquire_acquire:
0:
        lr.w.aq           a3, (a0)
        bne               a3, a1, 1f
        sc.w              a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a4, a3, a1
        seqz              a4, a4
        snez              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::acquire_relaxed:
0:
        lr.w.aq           a3, (a0)
        bne               a3, a1, 1f
        sc.w              a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a4, a3, a1
        seqz              a4, a4
        snez              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::relaxed_acquire:
0:
        lr.w.aq           a3, (a0)
        bne               a3, a1, 1f
        sc.w              a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a4, a3, a1
        seqz              a4, a4
        snez              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
0:
        lr.w              a3, (a0)
        bne               a3, a1, 1f
        sc.w              a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a4, a3, a1
        seqz              a4, a4
        snez              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::release_acquire:
0:
        lr.w.aq           a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a4, a3, a1
        seqz              a4, a4
        snez              a1, a4
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::release_relaxed:
0:
        lr.w              a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a4, a3, a1
        seqz              a4, a4
        snez              a1, a4
        mv                a0, a3
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
0:
        lr.w.aq           a2, (a0)
        sc.w.rl           a3, a1, (a0)
        bnez              a3, 0b
        mv                a0, a2
        ret

asm_test::swap::u32::seqcst:
0:
        lr.w.aqrl         a2, (a0)
        sc.w.rl           a3, a1, (a0)
        bnez              a3, 0b
        mv                a0, a2
        ret

asm_test::swap::u32::acquire:
0:
        lr.w.aq           a2, (a0)
        sc.w              a3, a1, (a0)
        bnez              a3, 0b
        mv                a0, a2
        ret

asm_test::swap::u32::relaxed:
0:
        lr.w              a2, (a0)
        sc.w              a3, a1, (a0)
        bnez              a3, 0b
        mv                a0, a2
        ret

asm_test::swap::u32::release:
0:
        lr.w              a2, (a0)
        sc.w.rl           a3, a1, (a0)
        bnez              a3, 0b
        mv                a0, a2
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

