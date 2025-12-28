asm_test::compare_exchange::u8::acqrel_seqcst:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        li                a4, 0xff
        sll               a4, a4, a0
        sll               a1, a1, a0
        sll               a2, a2, a0
0:
        lr.w.aqrl         a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w.rl           a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange::u8::seqcst_seqcst:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        li                a4, 0xff
        sll               a4, a4, a0
        sll               a1, a1, a0
        sll               a2, a2, a0
0:
        lr.w.aqrl         a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w.rl           a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange::u8::acqrel_acquire:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        li                a4, 0xff
        sll               a4, a4, a0
        sll               a1, a1, a0
        sll               a2, a2, a0
0:
        lr.w.aq           a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w.rl           a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange::u8::acqrel_relaxed:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        li                a4, 0xff
        sll               a4, a4, a0
        sll               a1, a1, a0
        sll               a2, a2, a0
0:
        lr.w.aq           a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w.rl           a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange::u8::acquire_seqcst:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        li                a4, 0xff
        sll               a4, a4, a0
        sll               a1, a1, a0
        sll               a2, a2, a0
0:
        lr.w.aqrl         a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w.rl           a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange::u8::relaxed_seqcst:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        li                a4, 0xff
        sll               a4, a4, a0
        sll               a1, a1, a0
        sll               a2, a2, a0
0:
        lr.w.aqrl         a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w.rl           a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange::u8::release_seqcst:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        li                a4, 0xff
        sll               a4, a4, a0
        sll               a1, a1, a0
        sll               a2, a2, a0
0:
        lr.w.aqrl         a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w.rl           a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange::u8::seqcst_acquire:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        li                a4, 0xff
        sll               a4, a4, a0
        sll               a1, a1, a0
        sll               a2, a2, a0
0:
        lr.w.aqrl         a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w.rl           a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange::u8::seqcst_relaxed:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        li                a4, 0xff
        sll               a4, a4, a0
        sll               a1, a1, a0
        sll               a2, a2, a0
0:
        lr.w.aqrl         a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w.rl           a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange::u8::acquire_acquire:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        li                a4, 0xff
        sll               a4, a4, a0
        sll               a1, a1, a0
        sll               a2, a2, a0
0:
        lr.w.aq           a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w              a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange::u8::acquire_relaxed:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        li                a4, 0xff
        sll               a4, a4, a0
        sll               a1, a1, a0
        sll               a2, a2, a0
0:
        lr.w.aq           a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w              a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange::u8::relaxed_acquire:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        li                a4, 0xff
        sll               a4, a4, a0
        sll               a1, a1, a0
        sll               a2, a2, a0
0:
        lr.w.aq           a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w              a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange::u8::relaxed_relaxed:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        li                a4, 0xff
        sll               a4, a4, a0
        sll               a1, a1, a0
        sll               a2, a2, a0
0:
        lr.w              a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w              a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange::u8::release_acquire:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        li                a4, 0xff
        sll               a4, a4, a0
        sll               a1, a1, a0
        sll               a2, a2, a0
0:
        lr.w.aq           a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w.rl           a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange::u8::release_relaxed:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        li                a4, 0xff
        sll               a4, a4, a0
        sll               a1, a1, a0
        sll               a2, a2, a0
0:
        lr.w              a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w.rl           a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange::u16::acqrel_seqcst:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        lui               a4, 0x10
        addi              a4, a4, -0x1
        sll               a1, a1, a0
        sll               a2, a2, a0
        sll               a4, a4, a0
0:
        lr.w.aqrl         a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w.rl           a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange::u16::seqcst_seqcst:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        lui               a4, 0x10
        addi              a4, a4, -0x1
        sll               a1, a1, a0
        sll               a2, a2, a0
        sll               a4, a4, a0
0:
        lr.w.aqrl         a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w.rl           a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange::u16::acqrel_acquire:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        lui               a4, 0x10
        addi              a4, a4, -0x1
        sll               a1, a1, a0
        sll               a2, a2, a0
        sll               a4, a4, a0
0:
        lr.w.aq           a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w.rl           a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange::u16::acqrel_relaxed:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        lui               a4, 0x10
        addi              a4, a4, -0x1
        sll               a1, a1, a0
        sll               a2, a2, a0
        sll               a4, a4, a0
0:
        lr.w.aq           a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w.rl           a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange::u16::acquire_seqcst:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        lui               a4, 0x10
        addi              a4, a4, -0x1
        sll               a1, a1, a0
        sll               a2, a2, a0
        sll               a4, a4, a0
0:
        lr.w.aqrl         a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w.rl           a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange::u16::relaxed_seqcst:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        lui               a4, 0x10
        addi              a4, a4, -0x1
        sll               a1, a1, a0
        sll               a2, a2, a0
        sll               a4, a4, a0
0:
        lr.w.aqrl         a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w.rl           a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange::u16::release_seqcst:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        lui               a4, 0x10
        addi              a4, a4, -0x1
        sll               a1, a1, a0
        sll               a2, a2, a0
        sll               a4, a4, a0
0:
        lr.w.aqrl         a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w.rl           a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange::u16::seqcst_acquire:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        lui               a4, 0x10
        addi              a4, a4, -0x1
        sll               a1, a1, a0
        sll               a2, a2, a0
        sll               a4, a4, a0
0:
        lr.w.aqrl         a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w.rl           a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange::u16::seqcst_relaxed:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        lui               a4, 0x10
        addi              a4, a4, -0x1
        sll               a1, a1, a0
        sll               a2, a2, a0
        sll               a4, a4, a0
0:
        lr.w.aqrl         a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w.rl           a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange::u16::acquire_acquire:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        lui               a4, 0x10
        addi              a4, a4, -0x1
        sll               a1, a1, a0
        sll               a2, a2, a0
        sll               a4, a4, a0
0:
        lr.w.aq           a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w              a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange::u16::acquire_relaxed:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        lui               a4, 0x10
        addi              a4, a4, -0x1
        sll               a1, a1, a0
        sll               a2, a2, a0
        sll               a4, a4, a0
0:
        lr.w.aq           a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w              a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange::u16::relaxed_acquire:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        lui               a4, 0x10
        addi              a4, a4, -0x1
        sll               a1, a1, a0
        sll               a2, a2, a0
        sll               a4, a4, a0
0:
        lr.w.aq           a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w              a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange::u16::relaxed_relaxed:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        lui               a4, 0x10
        addi              a4, a4, -0x1
        sll               a1, a1, a0
        sll               a2, a2, a0
        sll               a4, a4, a0
0:
        lr.w              a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w              a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange::u16::release_acquire:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        lui               a4, 0x10
        addi              a4, a4, -0x1
        sll               a1, a1, a0
        sll               a2, a2, a0
        sll               a4, a4, a0
0:
        lr.w.aq           a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w.rl           a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange::u16::release_relaxed:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        lui               a4, 0x10
        addi              a4, a4, -0x1
        sll               a1, a1, a0
        sll               a2, a2, a0
        sll               a4, a4, a0
0:
        lr.w              a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w.rl           a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange::u32::acqrel_seqcst:
0:
        lr.w.aqrl         a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::seqcst_seqcst:
0:
        lr.w.aqrl         a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::acqrel_acquire:
0:
        lr.w.aq           a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::acqrel_relaxed:
0:
        lr.w.aq           a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::acquire_seqcst:
0:
        lr.w.aqrl         a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::relaxed_seqcst:
0:
        lr.w.aqrl         a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::release_seqcst:
0:
        lr.w.aqrl         a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::seqcst_acquire:
0:
        lr.w.aqrl         a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::seqcst_relaxed:
0:
        lr.w.aqrl         a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::acquire_acquire:
0:
        lr.w.aq           a3, (a0)
        bne               a3, a1, 1f
        sc.w              a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::acquire_relaxed:
0:
        lr.w.aq           a3, (a0)
        bne               a3, a1, 1f
        sc.w              a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::relaxed_acquire:
0:
        lr.w.aq           a3, (a0)
        bne               a3, a1, 1f
        sc.w              a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::relaxed_relaxed:
0:
        lr.w              a3, (a0)
        bne               a3, a1, 1f
        sc.w              a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::release_acquire:
0:
        lr.w.aq           a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange::u32::release_relaxed:
0:
        lr.w              a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        li                a4, 0xff
        sll               a4, a4, a0
        sll               a1, a1, a0
        sll               a2, a2, a0
0:
        lr.w.aqrl         a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w.rl           a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        li                a4, 0xff
        sll               a4, a4, a0
        sll               a1, a1, a0
        sll               a2, a2, a0
0:
        lr.w.aqrl         a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w.rl           a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        li                a4, 0xff
        sll               a4, a4, a0
        sll               a1, a1, a0
        sll               a2, a2, a0
0:
        lr.w.aq           a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w.rl           a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        li                a4, 0xff
        sll               a4, a4, a0
        sll               a1, a1, a0
        sll               a2, a2, a0
0:
        lr.w.aq           a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w.rl           a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        li                a4, 0xff
        sll               a4, a4, a0
        sll               a1, a1, a0
        sll               a2, a2, a0
0:
        lr.w.aqrl         a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w.rl           a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        li                a4, 0xff
        sll               a4, a4, a0
        sll               a1, a1, a0
        sll               a2, a2, a0
0:
        lr.w.aqrl         a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w.rl           a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange_weak::u8::release_seqcst:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        li                a4, 0xff
        sll               a4, a4, a0
        sll               a1, a1, a0
        sll               a2, a2, a0
0:
        lr.w.aqrl         a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w.rl           a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        li                a4, 0xff
        sll               a4, a4, a0
        sll               a1, a1, a0
        sll               a2, a2, a0
0:
        lr.w.aqrl         a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w.rl           a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        li                a4, 0xff
        sll               a4, a4, a0
        sll               a1, a1, a0
        sll               a2, a2, a0
0:
        lr.w.aqrl         a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w.rl           a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange_weak::u8::acquire_acquire:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        li                a4, 0xff
        sll               a4, a4, a0
        sll               a1, a1, a0
        sll               a2, a2, a0
0:
        lr.w.aq           a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w              a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        li                a4, 0xff
        sll               a4, a4, a0
        sll               a1, a1, a0
        sll               a2, a2, a0
0:
        lr.w.aq           a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w              a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        li                a4, 0xff
        sll               a4, a4, a0
        sll               a1, a1, a0
        sll               a2, a2, a0
0:
        lr.w.aq           a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w              a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        li                a4, 0xff
        sll               a4, a4, a0
        sll               a1, a1, a0
        sll               a2, a2, a0
0:
        lr.w              a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w              a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange_weak::u8::release_acquire:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        li                a4, 0xff
        sll               a4, a4, a0
        sll               a1, a1, a0
        sll               a2, a2, a0
0:
        lr.w.aq           a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w.rl           a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange_weak::u8::release_relaxed:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        li                a4, 0xff
        sll               a4, a4, a0
        sll               a1, a1, a0
        sll               a2, a2, a0
0:
        lr.w              a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w.rl           a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        lui               a4, 0x10
        addi              a4, a4, -0x1
        sll               a1, a1, a0
        sll               a2, a2, a0
        sll               a4, a4, a0
0:
        lr.w.aqrl         a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w.rl           a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        lui               a4, 0x10
        addi              a4, a4, -0x1
        sll               a1, a1, a0
        sll               a2, a2, a0
        sll               a4, a4, a0
0:
        lr.w.aqrl         a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w.rl           a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        lui               a4, 0x10
        addi              a4, a4, -0x1
        sll               a1, a1, a0
        sll               a2, a2, a0
        sll               a4, a4, a0
0:
        lr.w.aq           a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w.rl           a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        lui               a4, 0x10
        addi              a4, a4, -0x1
        sll               a1, a1, a0
        sll               a2, a2, a0
        sll               a4, a4, a0
0:
        lr.w.aq           a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w.rl           a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        lui               a4, 0x10
        addi              a4, a4, -0x1
        sll               a1, a1, a0
        sll               a2, a2, a0
        sll               a4, a4, a0
0:
        lr.w.aqrl         a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w.rl           a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        lui               a4, 0x10
        addi              a4, a4, -0x1
        sll               a1, a1, a0
        sll               a2, a2, a0
        sll               a4, a4, a0
0:
        lr.w.aqrl         a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w.rl           a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange_weak::u16::release_seqcst:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        lui               a4, 0x10
        addi              a4, a4, -0x1
        sll               a1, a1, a0
        sll               a2, a2, a0
        sll               a4, a4, a0
0:
        lr.w.aqrl         a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w.rl           a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        lui               a4, 0x10
        addi              a4, a4, -0x1
        sll               a1, a1, a0
        sll               a2, a2, a0
        sll               a4, a4, a0
0:
        lr.w.aqrl         a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w.rl           a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        lui               a4, 0x10
        addi              a4, a4, -0x1
        sll               a1, a1, a0
        sll               a2, a2, a0
        sll               a4, a4, a0
0:
        lr.w.aqrl         a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w.rl           a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange_weak::u16::acquire_acquire:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        lui               a4, 0x10
        addi              a4, a4, -0x1
        sll               a1, a1, a0
        sll               a2, a2, a0
        sll               a4, a4, a0
0:
        lr.w.aq           a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w              a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        lui               a4, 0x10
        addi              a4, a4, -0x1
        sll               a1, a1, a0
        sll               a2, a2, a0
        sll               a4, a4, a0
0:
        lr.w.aq           a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w              a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        lui               a4, 0x10
        addi              a4, a4, -0x1
        sll               a1, a1, a0
        sll               a2, a2, a0
        sll               a4, a4, a0
0:
        lr.w.aq           a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w              a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        lui               a4, 0x10
        addi              a4, a4, -0x1
        sll               a1, a1, a0
        sll               a2, a2, a0
        sll               a4, a4, a0
0:
        lr.w              a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w              a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange_weak::u16::release_acquire:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        lui               a4, 0x10
        addi              a4, a4, -0x1
        sll               a1, a1, a0
        sll               a2, a2, a0
        sll               a4, a4, a0
0:
        lr.w.aq           a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w.rl           a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange_weak::u16::release_relaxed:
        andi              a6, a0, -0x4
        slli              a0, a0, 0x3
        lui               a4, 0x10
        addi              a4, a4, -0x1
        sll               a1, a1, a0
        sll               a2, a2, a0
        sll               a4, a4, a0
0:
        lr.w              a5, (a6)
        and               a3, a5, a4
        bne               a3, a1, 1f
        xor               a3, a5, a2
        and               a3, a3, a4
        xor               a3, a3, a5
        sc.w.rl           a3, a3, (a6)
        bnez              a3, 0b
1:
        srl               a0, a5, a0
        and               a4, a4, a5
        xor               a1, a1, a4
        seqz              a1, a1
        ret

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
0:
        lr.w.aqrl         a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
0:
        lr.w.aqrl         a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::acqrel_acquire:
0:
        lr.w.aq           a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
0:
        lr.w.aq           a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::acquire_seqcst:
0:
        lr.w.aqrl         a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
0:
        lr.w.aqrl         a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::release_seqcst:
0:
        lr.w.aqrl         a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::seqcst_acquire:
0:
        lr.w.aqrl         a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
0:
        lr.w.aqrl         a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::acquire_acquire:
0:
        lr.w.aq           a3, (a0)
        bne               a3, a1, 1f
        sc.w              a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::acquire_relaxed:
0:
        lr.w.aq           a3, (a0)
        bne               a3, a1, 1f
        sc.w              a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::relaxed_acquire:
0:
        lr.w.aq           a3, (a0)
        bne               a3, a1, 1f
        sc.w              a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
0:
        lr.w              a3, (a0)
        bne               a3, a1, 1f
        sc.w              a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::release_acquire:
0:
        lr.w.aq           a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a1, a1, a3
        seqz              a1, a1
        mv                a0, a3
        ret

asm_test::compare_exchange_weak::u32::release_relaxed:
0:
        lr.w              a3, (a0)
        bne               a3, a1, 1f
        sc.w.rl           a4, a2, (a0)
        bnez              a4, 0b
1:
        xor               a1, a1, a3
        seqz              a1, a1
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
        slli              a0, a0, 0x3
        li                a3, 0xff
        sll               a3, a3, a0
        sll               a1, a1, a0
0:
        lr.w.aq           a4, (a2)
        mv                a5, a1
        xor               a5, a5, a4
        and               a5, a5, a3
        xor               a5, a5, a4
        sc.w.rl           a5, a5, (a2)
        bnez              a5, 0b
        srl               a0, a4, a0
        ret

asm_test::swap::u8::seqcst:
        andi              a2, a0, -0x4
        slli              a0, a0, 0x3
        li                a3, 0xff
        sll               a3, a3, a0
        sll               a1, a1, a0
0:
        lr.w.aqrl         a4, (a2)
        mv                a5, a1
        xor               a5, a5, a4
        and               a5, a5, a3
        xor               a5, a5, a4
        sc.w.rl           a5, a5, (a2)
        bnez              a5, 0b
        srl               a0, a4, a0
        ret

asm_test::swap::u8::acquire:
        andi              a2, a0, -0x4
        slli              a0, a0, 0x3
        li                a3, 0xff
        sll               a3, a3, a0
        sll               a1, a1, a0
0:
        lr.w.aq           a4, (a2)
        mv                a5, a1
        xor               a5, a5, a4
        and               a5, a5, a3
        xor               a5, a5, a4
        sc.w              a5, a5, (a2)
        bnez              a5, 0b
        srl               a0, a4, a0
        ret

asm_test::swap::u8::relaxed:
        andi              a2, a0, -0x4
        slli              a0, a0, 0x3
        li                a3, 0xff
        sll               a3, a3, a0
        sll               a1, a1, a0
0:
        lr.w              a4, (a2)
        mv                a5, a1
        xor               a5, a5, a4
        and               a5, a5, a3
        xor               a5, a5, a4
        sc.w              a5, a5, (a2)
        bnez              a5, 0b
        srl               a0, a4, a0
        ret

asm_test::swap::u8::release:
        andi              a2, a0, -0x4
        slli              a0, a0, 0x3
        li                a3, 0xff
        sll               a3, a3, a0
        sll               a1, a1, a0
0:
        lr.w              a4, (a2)
        mv                a5, a1
        xor               a5, a5, a4
        and               a5, a5, a3
        xor               a5, a5, a4
        sc.w.rl           a5, a5, (a2)
        bnez              a5, 0b
        srl               a0, a4, a0
        ret

asm_test::swap::u16::acqrel:
        andi              a2, a0, -0x4
        slli              a0, a0, 0x3
        lui               a3, 0x10
        addi              a3, a3, -0x1
        sll               a3, a3, a0
        sll               a1, a1, a0
0:
        lr.w.aq           a4, (a2)
        mv                a5, a1
        xor               a5, a5, a4
        and               a5, a5, a3
        xor               a5, a5, a4
        sc.w.rl           a5, a5, (a2)
        bnez              a5, 0b
        srl               a0, a4, a0
        ret

asm_test::swap::u16::seqcst:
        andi              a2, a0, -0x4
        slli              a0, a0, 0x3
        lui               a3, 0x10
        addi              a3, a3, -0x1
        sll               a3, a3, a0
        sll               a1, a1, a0
0:
        lr.w.aqrl         a4, (a2)
        mv                a5, a1
        xor               a5, a5, a4
        and               a5, a5, a3
        xor               a5, a5, a4
        sc.w.rl           a5, a5, (a2)
        bnez              a5, 0b
        srl               a0, a4, a0
        ret

asm_test::swap::u16::acquire:
        andi              a2, a0, -0x4
        slli              a0, a0, 0x3
        lui               a3, 0x10
        addi              a3, a3, -0x1
        sll               a3, a3, a0
        sll               a1, a1, a0
0:
        lr.w.aq           a4, (a2)
        mv                a5, a1
        xor               a5, a5, a4
        and               a5, a5, a3
        xor               a5, a5, a4
        sc.w              a5, a5, (a2)
        bnez              a5, 0b
        srl               a0, a4, a0
        ret

asm_test::swap::u16::relaxed:
        andi              a2, a0, -0x4
        slli              a0, a0, 0x3
        lui               a3, 0x10
        addi              a3, a3, -0x1
        sll               a3, a3, a0
        sll               a1, a1, a0
0:
        lr.w              a4, (a2)
        mv                a5, a1
        xor               a5, a5, a4
        and               a5, a5, a3
        xor               a5, a5, a4
        sc.w              a5, a5, (a2)
        bnez              a5, 0b
        srl               a0, a4, a0
        ret

asm_test::swap::u16::release:
        andi              a2, a0, -0x4
        slli              a0, a0, 0x3
        lui               a3, 0x10
        addi              a3, a3, -0x1
        sll               a3, a3, a0
        sll               a1, a1, a0
0:
        lr.w              a4, (a2)
        mv                a5, a1
        xor               a5, a5, a4
        and               a5, a5, a3
        xor               a5, a5, a4
        sc.w.rl           a5, a5, (a2)
        bnez              a5, 0b
        srl               a0, a4, a0
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

