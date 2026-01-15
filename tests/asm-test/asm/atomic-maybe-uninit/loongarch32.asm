asm_test::compare_exchange::u8::acqrel_seqcst:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        ori               $a5, $zero, 255
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              16
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange::u8::seqcst_seqcst:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        ori               $a5, $zero, 255
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              16
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange::u8::acqrel_acquire:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        ori               $a5, $zero, 255
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              20
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange::u8::acqrel_relaxed:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        ori               $a5, $zero, 255
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              1792
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange::u8::acquire_seqcst:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        ori               $a5, $zero, 255
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              16
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange::u8::relaxed_seqcst:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        ori               $a5, $zero, 255
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              16
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange::u8::release_seqcst:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        ori               $a5, $zero, 255
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              16
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange::u8::seqcst_acquire:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        ori               $a5, $zero, 255
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              20
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange::u8::seqcst_relaxed:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        ori               $a5, $zero, 255
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              1792
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange::u8::acquire_acquire:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        ori               $a5, $zero, 255
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              20
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange::u8::acquire_relaxed:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        ori               $a5, $zero, 255
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              1792
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange::u8::relaxed_acquire:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        ori               $a5, $zero, 255
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              20
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange::u8::relaxed_relaxed:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        ori               $a5, $zero, 255
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              1792
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange::u8::release_acquire:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        ori               $a5, $zero, 255
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              20
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange::u8::release_relaxed:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        ori               $a5, $zero, 255
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              1792
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange::u16::acqrel_seqcst:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        lu12i.w           $a0, 15
        ori               $a5, $a0, 4095
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              16
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange::u16::seqcst_seqcst:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        lu12i.w           $a0, 15
        ori               $a5, $a0, 4095
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              16
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange::u16::acqrel_acquire:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        lu12i.w           $a0, 15
        ori               $a5, $a0, 4095
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              20
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange::u16::acqrel_relaxed:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        lu12i.w           $a0, 15
        ori               $a5, $a0, 4095
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              1792
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange::u16::acquire_seqcst:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        lu12i.w           $a0, 15
        ori               $a5, $a0, 4095
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              16
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange::u16::relaxed_seqcst:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        lu12i.w           $a0, 15
        ori               $a5, $a0, 4095
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              16
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange::u16::release_seqcst:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        lu12i.w           $a0, 15
        ori               $a5, $a0, 4095
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              16
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange::u16::seqcst_acquire:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        lu12i.w           $a0, 15
        ori               $a5, $a0, 4095
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              20
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange::u16::seqcst_relaxed:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        lu12i.w           $a0, 15
        ori               $a5, $a0, 4095
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              1792
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange::u16::acquire_acquire:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        lu12i.w           $a0, 15
        ori               $a5, $a0, 4095
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              20
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange::u16::acquire_relaxed:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        lu12i.w           $a0, 15
        ori               $a5, $a0, 4095
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              1792
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange::u16::relaxed_acquire:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        lu12i.w           $a0, 15
        ori               $a5, $a0, 4095
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              20
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange::u16::relaxed_relaxed:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        lu12i.w           $a0, 15
        ori               $a5, $a0, 4095
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              1792
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange::u16::release_acquire:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        lu12i.w           $a0, 15
        ori               $a5, $a0, 4095
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              20
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange::u16::release_relaxed:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        lu12i.w           $a0, 15
        ori               $a5, $a0, 4095
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              1792
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange::u32::acqrel_seqcst:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beqz              $a4, 0b
        b                 2f
1:
        dbar              16
        move              $a4, $zero
2:
        sltu              $a1, $zero, $a4
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::seqcst_seqcst:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beqz              $a4, 0b
        b                 2f
1:
        dbar              16
        move              $a4, $zero
2:
        sltu              $a1, $zero, $a4
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::acqrel_acquire:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beqz              $a4, 0b
        b                 2f
1:
        dbar              20
        move              $a4, $zero
2:
        sltu              $a1, $zero, $a4
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::acqrel_relaxed:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beqz              $a4, 0b
        b                 2f
1:
        dbar              1792
        move              $a4, $zero
2:
        sltu              $a1, $zero, $a4
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::acquire_seqcst:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beqz              $a4, 0b
        b                 2f
1:
        dbar              16
        move              $a4, $zero
2:
        sltu              $a1, $zero, $a4
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::relaxed_seqcst:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beqz              $a4, 0b
        b                 2f
1:
        dbar              16
        move              $a4, $zero
2:
        sltu              $a1, $zero, $a4
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::release_seqcst:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beqz              $a4, 0b
        b                 2f
1:
        dbar              16
        move              $a4, $zero
2:
        sltu              $a1, $zero, $a4
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::seqcst_acquire:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beqz              $a4, 0b
        b                 2f
1:
        dbar              20
        move              $a4, $zero
2:
        sltu              $a1, $zero, $a4
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::seqcst_relaxed:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beqz              $a4, 0b
        b                 2f
1:
        dbar              1792
        move              $a4, $zero
2:
        sltu              $a1, $zero, $a4
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::acquire_acquire:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beqz              $a4, 0b
        b                 2f
1:
        dbar              20
        move              $a4, $zero
2:
        sltu              $a1, $zero, $a4
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::acquire_relaxed:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beqz              $a4, 0b
        b                 2f
1:
        dbar              1792
        move              $a4, $zero
2:
        sltu              $a1, $zero, $a4
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::relaxed_acquire:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beqz              $a4, 0b
        b                 2f
1:
        dbar              20
        move              $a4, $zero
2:
        sltu              $a1, $zero, $a4
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::relaxed_relaxed:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beqz              $a4, 0b
        b                 2f
1:
        dbar              1792
        move              $a4, $zero
2:
        sltu              $a1, $zero, $a4
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::release_acquire:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beqz              $a4, 0b
        b                 2f
1:
        dbar              20
        move              $a4, $zero
2:
        sltu              $a1, $zero, $a4
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::release_relaxed:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beqz              $a4, 0b
        b                 2f
1:
        dbar              1792
        move              $a4, $zero
2:
        sltu              $a1, $zero, $a4
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        ori               $a5, $zero, 255
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              16
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        ori               $a5, $zero, 255
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              16
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        ori               $a5, $zero, 255
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              20
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        ori               $a5, $zero, 255
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              1792
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        ori               $a5, $zero, 255
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              16
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        ori               $a5, $zero, 255
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              16
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange_weak::u8::release_seqcst:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        ori               $a5, $zero, 255
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              16
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        ori               $a5, $zero, 255
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              20
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        ori               $a5, $zero, 255
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              1792
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange_weak::u8::acquire_acquire:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        ori               $a5, $zero, 255
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              20
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        ori               $a5, $zero, 255
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              1792
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        ori               $a5, $zero, 255
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              20
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        ori               $a5, $zero, 255
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              1792
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange_weak::u8::release_acquire:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        ori               $a5, $zero, 255
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              20
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange_weak::u8::release_relaxed:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        ori               $a5, $zero, 255
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              1792
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        lu12i.w           $a0, 15
        ori               $a5, $a0, 4095
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              16
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        lu12i.w           $a0, 15
        ori               $a5, $a0, 4095
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              16
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        lu12i.w           $a0, 15
        ori               $a5, $a0, 4095
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              20
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        lu12i.w           $a0, 15
        ori               $a5, $a0, 4095
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              1792
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        lu12i.w           $a0, 15
        ori               $a5, $a0, 4095
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              16
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        lu12i.w           $a0, 15
        ori               $a5, $a0, 4095
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              16
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange_weak::u16::release_seqcst:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        lu12i.w           $a0, 15
        ori               $a5, $a0, 4095
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              16
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        lu12i.w           $a0, 15
        ori               $a5, $a0, 4095
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              20
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        lu12i.w           $a0, 15
        ori               $a5, $a0, 4095
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              1792
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange_weak::u16::acquire_acquire:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        lu12i.w           $a0, 15
        ori               $a5, $a0, 4095
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              20
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        lu12i.w           $a0, 15
        ori               $a5, $a0, 4095
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              1792
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        lu12i.w           $a0, 15
        ori               $a5, $a0, 4095
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              20
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        lu12i.w           $a0, 15
        ori               $a5, $a0, 4095
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              1792
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange_weak::u16::release_acquire:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        lu12i.w           $a0, 15
        ori               $a5, $a0, 4095
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              20
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange_weak::u16::release_relaxed:
        addi.w            $a3, $zero, -4
        and               $a3, $a0, $a3
        slli.w            $a4, $a0, 3
        lu12i.w           $a0, 15
        ori               $a5, $a0, 4095
        sll.w             $a5, $a5, $a4
        sll.w             $a1, $a1, $a4
        sll.w             $a2, $a2, $a4
0:
        ll.w              $a0, $a3, 0
        and               $a6, $a0, $a5
        bne               $a6, $a1, 1f
        andn              $a6, $a0, $a5
        or                $a6, $a6, $a2
        sc.w              $a6, $a3, 0
        beqz              $a6, 0b
        b                 2f
1:
        dbar              1792
        move              $a6, $zero
2:
        srl.w             $a0, $a0, $a4
        sltu              $a1, $zero, $a6
        ret

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beqz              $a4, 0b
        b                 2f
1:
        dbar              16
        move              $a4, $zero
2:
        sltu              $a1, $zero, $a4
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beqz              $a4, 0b
        b                 2f
1:
        dbar              16
        move              $a4, $zero
2:
        sltu              $a1, $zero, $a4
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::acqrel_acquire:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beqz              $a4, 0b
        b                 2f
1:
        dbar              20
        move              $a4, $zero
2:
        sltu              $a1, $zero, $a4
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beqz              $a4, 0b
        b                 2f
1:
        dbar              1792
        move              $a4, $zero
2:
        sltu              $a1, $zero, $a4
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::acquire_seqcst:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beqz              $a4, 0b
        b                 2f
1:
        dbar              16
        move              $a4, $zero
2:
        sltu              $a1, $zero, $a4
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beqz              $a4, 0b
        b                 2f
1:
        dbar              16
        move              $a4, $zero
2:
        sltu              $a1, $zero, $a4
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::release_seqcst:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beqz              $a4, 0b
        b                 2f
1:
        dbar              16
        move              $a4, $zero
2:
        sltu              $a1, $zero, $a4
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::seqcst_acquire:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beqz              $a4, 0b
        b                 2f
1:
        dbar              20
        move              $a4, $zero
2:
        sltu              $a1, $zero, $a4
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beqz              $a4, 0b
        b                 2f
1:
        dbar              1792
        move              $a4, $zero
2:
        sltu              $a1, $zero, $a4
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::acquire_acquire:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beqz              $a4, 0b
        b                 2f
1:
        dbar              20
        move              $a4, $zero
2:
        sltu              $a1, $zero, $a4
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::acquire_relaxed:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beqz              $a4, 0b
        b                 2f
1:
        dbar              1792
        move              $a4, $zero
2:
        sltu              $a1, $zero, $a4
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::relaxed_acquire:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beqz              $a4, 0b
        b                 2f
1:
        dbar              20
        move              $a4, $zero
2:
        sltu              $a1, $zero, $a4
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beqz              $a4, 0b
        b                 2f
1:
        dbar              1792
        move              $a4, $zero
2:
        sltu              $a1, $zero, $a4
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::release_acquire:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beqz              $a4, 0b
        b                 2f
1:
        dbar              20
        move              $a4, $zero
2:
        sltu              $a1, $zero, $a4
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::release_relaxed:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beqz              $a4, 0b
        b                 2f
1:
        dbar              1792
        move              $a4, $zero
2:
        sltu              $a1, $zero, $a4
        move              $a0, $a3
        ret

asm_test::load::u8::seqcst:
        ld.b              $a0, $a0, 0
        dbar              16
        ret

asm_test::load::u8::acquire:
        ld.b              $a0, $a0, 0
        dbar              20
        ret

asm_test::load::u8::relaxed:
        ld.b              $a0, $a0, 0
        ret

asm_test::load::u16::seqcst:
        ld.h              $a0, $a0, 0
        dbar              16
        ret

asm_test::load::u16::acquire:
        ld.h              $a0, $a0, 0
        dbar              20
        ret

asm_test::load::u16::relaxed:
        ld.h              $a0, $a0, 0
        ret

asm_test::load::u32::seqcst:
        ld.w              $a0, $a0, 0
        dbar              16
        ret

asm_test::load::u32::acquire:
        ld.w              $a0, $a0, 0
        dbar              20
        ret

asm_test::load::u32::relaxed:
        ld.w              $a0, $a0, 0
        ret

asm_test::swap::u8::acqrel:
        addi.w            $a2, $zero, -4
        and               $a2, $a0, $a2
        slli.w            $a3, $a0, 3
        ori               $a4, $zero, 255
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
0:
        ll.w              $a0, $a2, 0
        andn              $a5, $a0, $a4
        or                $a5, $a5, $a1
        sc.w              $a5, $a2, 0
        beqz              $a5, 0b
        srl.w             $a0, $a0, $a3
        ret

asm_test::swap::u8::seqcst:
        addi.w            $a2, $zero, -4
        and               $a2, $a0, $a2
        slli.w            $a3, $a0, 3
        ori               $a4, $zero, 255
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
0:
        ll.w              $a0, $a2, 0
        andn              $a5, $a0, $a4
        or                $a5, $a5, $a1
        sc.w              $a5, $a2, 0
        beqz              $a5, 0b
        srl.w             $a0, $a0, $a3
        ret

asm_test::swap::u8::acquire:
        addi.w            $a2, $zero, -4
        and               $a2, $a0, $a2
        slli.w            $a3, $a0, 3
        ori               $a4, $zero, 255
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
0:
        ll.w              $a0, $a2, 0
        andn              $a5, $a0, $a4
        or                $a5, $a5, $a1
        sc.w              $a5, $a2, 0
        beqz              $a5, 0b
        srl.w             $a0, $a0, $a3
        ret

asm_test::swap::u8::relaxed:
        addi.w            $a2, $zero, -4
        and               $a2, $a0, $a2
        slli.w            $a3, $a0, 3
        ori               $a4, $zero, 255
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
0:
        ll.w              $a0, $a2, 0
        andn              $a5, $a0, $a4
        or                $a5, $a5, $a1
        sc.w              $a5, $a2, 0
        beqz              $a5, 0b
        srl.w             $a0, $a0, $a3
        ret

asm_test::swap::u8::release:
        addi.w            $a2, $zero, -4
        and               $a2, $a0, $a2
        slli.w            $a3, $a0, 3
        ori               $a4, $zero, 255
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
0:
        ll.w              $a0, $a2, 0
        andn              $a5, $a0, $a4
        or                $a5, $a5, $a1
        sc.w              $a5, $a2, 0
        beqz              $a5, 0b
        srl.w             $a0, $a0, $a3
        ret

asm_test::swap::u16::acqrel:
        addi.w            $a2, $zero, -4
        and               $a2, $a0, $a2
        slli.w            $a3, $a0, 3
        lu12i.w           $a0, 15
        ori               $a4, $a0, 4095
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
0:
        ll.w              $a0, $a2, 0
        andn              $a5, $a0, $a4
        or                $a5, $a5, $a1
        sc.w              $a5, $a2, 0
        beqz              $a5, 0b
        srl.w             $a0, $a0, $a3
        ret

asm_test::swap::u16::seqcst:
        addi.w            $a2, $zero, -4
        and               $a2, $a0, $a2
        slli.w            $a3, $a0, 3
        lu12i.w           $a0, 15
        ori               $a4, $a0, 4095
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
0:
        ll.w              $a0, $a2, 0
        andn              $a5, $a0, $a4
        or                $a5, $a5, $a1
        sc.w              $a5, $a2, 0
        beqz              $a5, 0b
        srl.w             $a0, $a0, $a3
        ret

asm_test::swap::u16::acquire:
        addi.w            $a2, $zero, -4
        and               $a2, $a0, $a2
        slli.w            $a3, $a0, 3
        lu12i.w           $a0, 15
        ori               $a4, $a0, 4095
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
0:
        ll.w              $a0, $a2, 0
        andn              $a5, $a0, $a4
        or                $a5, $a5, $a1
        sc.w              $a5, $a2, 0
        beqz              $a5, 0b
        srl.w             $a0, $a0, $a3
        ret

asm_test::swap::u16::relaxed:
        addi.w            $a2, $zero, -4
        and               $a2, $a0, $a2
        slli.w            $a3, $a0, 3
        lu12i.w           $a0, 15
        ori               $a4, $a0, 4095
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
0:
        ll.w              $a0, $a2, 0
        andn              $a5, $a0, $a4
        or                $a5, $a5, $a1
        sc.w              $a5, $a2, 0
        beqz              $a5, 0b
        srl.w             $a0, $a0, $a3
        ret

asm_test::swap::u16::release:
        addi.w            $a2, $zero, -4
        and               $a2, $a0, $a2
        slli.w            $a3, $a0, 3
        lu12i.w           $a0, 15
        ori               $a4, $a0, 4095
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
0:
        ll.w              $a0, $a2, 0
        andn              $a5, $a0, $a4
        or                $a5, $a5, $a1
        sc.w              $a5, $a2, 0
        beqz              $a5, 0b
        srl.w             $a0, $a0, $a3
        ret

asm_test::swap::u32::acqrel:
0:
        ll.w              $a2, $a0, 0
        move              $a3, $a1
        sc.w              $a3, $a0, 0
        beqz              $a3, 0b
        move              $a0, $a2
        ret

asm_test::swap::u32::seqcst:
0:
        ll.w              $a2, $a0, 0
        move              $a3, $a1
        sc.w              $a3, $a0, 0
        beqz              $a3, 0b
        move              $a0, $a2
        ret

asm_test::swap::u32::acquire:
0:
        ll.w              $a2, $a0, 0
        move              $a3, $a1
        sc.w              $a3, $a0, 0
        beqz              $a3, 0b
        move              $a0, $a2
        ret

asm_test::swap::u32::relaxed:
0:
        ll.w              $a2, $a0, 0
        move              $a3, $a1
        sc.w              $a3, $a0, 0
        beqz              $a3, 0b
        move              $a0, $a2
        ret

asm_test::swap::u32::release:
0:
        ll.w              $a2, $a0, 0
        move              $a3, $a1
        sc.w              $a3, $a0, 0
        beqz              $a3, 0b
        move              $a0, $a2
        ret

asm_test::store::u8::seqcst:
        dbar              16
        st.b              $a1, $a0, 0
        dbar              16
        ret

asm_test::store::u8::relaxed:
        st.b              $a1, $a0, 0
        ret

asm_test::store::u8::release:
        dbar              18
        st.b              $a1, $a0, 0
        ret

asm_test::store::u16::seqcst:
        dbar              16
        st.h              $a1, $a0, 0
        dbar              16
        ret

asm_test::store::u16::relaxed:
        st.h              $a1, $a0, 0
        ret

asm_test::store::u16::release:
        dbar              18
        st.h              $a1, $a0, 0
        ret

asm_test::store::u32::seqcst:
        dbar              16
        st.w              $a1, $a0, 0
        dbar              16
        ret

asm_test::store::u32::relaxed:
        st.w              $a1, $a0, 0
        ret

asm_test::store::u32::release:
        dbar              18
        st.w              $a1, $a0, 0
        ret

