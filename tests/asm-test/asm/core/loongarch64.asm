asm_test::compare_exchange::u8::acqrel_seqcst:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        ori               $a4, $zero, 255
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange::u8::seqcst_seqcst:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        ori               $a4, $zero, 255
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange::u8::acqrel_acquire:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        ori               $a4, $zero, 255
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange::u8::acqrel_relaxed:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        ori               $a4, $zero, 255
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange::u8::acquire_seqcst:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        ori               $a4, $zero, 255
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange::u8::relaxed_seqcst:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        ori               $a4, $zero, 255
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange::u8::release_seqcst:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        ori               $a4, $zero, 255
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange::u8::seqcst_acquire:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        ori               $a4, $zero, 255
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange::u8::seqcst_relaxed:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        ori               $a4, $zero, 255
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange::u8::acquire_acquire:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        ori               $a4, $zero, 255
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange::u8::acquire_relaxed:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        ori               $a4, $zero, 255
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange::u8::relaxed_acquire:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        ori               $a4, $zero, 255
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange::u8::relaxed_relaxed:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        ori               $a4, $zero, 255
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange::u8::release_acquire:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        ori               $a4, $zero, 255
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange::u8::release_relaxed:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        ori               $a4, $zero, 255
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange::u16::acqrel_seqcst:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        lu12i.w           $a4, 15
        ori               $a4, $a4, 4095
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange::u16::seqcst_seqcst:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        lu12i.w           $a4, 15
        ori               $a4, $a4, 4095
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange::u16::acqrel_acquire:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        lu12i.w           $a4, 15
        ori               $a4, $a4, 4095
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange::u16::acqrel_relaxed:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        lu12i.w           $a4, 15
        ori               $a4, $a4, 4095
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange::u16::acquire_seqcst:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        lu12i.w           $a4, 15
        ori               $a4, $a4, 4095
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange::u16::relaxed_seqcst:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        lu12i.w           $a4, 15
        ori               $a4, $a4, 4095
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange::u16::release_seqcst:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        lu12i.w           $a4, 15
        ori               $a4, $a4, 4095
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange::u16::seqcst_acquire:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        lu12i.w           $a4, 15
        ori               $a4, $a4, 4095
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange::u16::seqcst_relaxed:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        lu12i.w           $a4, 15
        ori               $a4, $a4, 4095
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange::u16::acquire_acquire:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        lu12i.w           $a4, 15
        ori               $a4, $a4, 4095
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange::u16::acquire_relaxed:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        lu12i.w           $a4, 15
        ori               $a4, $a4, 4095
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange::u16::relaxed_acquire:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        lu12i.w           $a4, 15
        ori               $a4, $a4, 4095
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange::u16::relaxed_relaxed:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        lu12i.w           $a4, 15
        ori               $a4, $a4, 4095
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange::u16::release_acquire:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        lu12i.w           $a4, 15
        ori               $a4, $a4, 4095
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange::u16::release_relaxed:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        lu12i.w           $a4, 15
        ori               $a4, $a4, 4095
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange::u32::acqrel_seqcst:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::seqcst_seqcst:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::acqrel_acquire:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::acqrel_relaxed:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::acquire_seqcst:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::relaxed_seqcst:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::release_seqcst:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::seqcst_acquire:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::seqcst_relaxed:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::acquire_acquire:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::acquire_relaxed:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::relaxed_acquire:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::relaxed_relaxed:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::release_acquire:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::release_relaxed:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::acqrel_seqcst:
0:
        ll.d              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.d              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::seqcst_seqcst:
0:
        ll.d              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.d              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::acqrel_acquire:
0:
        ll.d              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.d              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::acqrel_relaxed:
0:
        ll.d              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.d              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::acquire_seqcst:
0:
        ll.d              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.d              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::relaxed_seqcst:
0:
        ll.d              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.d              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::release_seqcst:
0:
        ll.d              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.d              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::seqcst_acquire:
0:
        ll.d              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.d              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::seqcst_relaxed:
0:
        ll.d              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.d              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::acquire_acquire:
0:
        ll.d              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.d              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::acquire_relaxed:
0:
        ll.d              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.d              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::relaxed_acquire:
0:
        ll.d              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.d              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::relaxed_relaxed:
0:
        ll.d              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.d              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::release_acquire:
0:
        ll.d              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.d              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::release_relaxed:
0:
        ll.d              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.d              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        ori               $a4, $zero, 255
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        ori               $a4, $zero, 255
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        ori               $a4, $zero, 255
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        ori               $a4, $zero, 255
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        ori               $a4, $zero, 255
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        ori               $a4, $zero, 255
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange_weak::u8::release_seqcst:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        ori               $a4, $zero, 255
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        ori               $a4, $zero, 255
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        ori               $a4, $zero, 255
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange_weak::u8::acquire_acquire:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        ori               $a4, $zero, 255
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        ori               $a4, $zero, 255
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        ori               $a4, $zero, 255
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        ori               $a4, $zero, 255
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange_weak::u8::release_acquire:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        ori               $a4, $zero, 255
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange_weak::u8::release_relaxed:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        ori               $a4, $zero, 255
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        lu12i.w           $a4, 15
        ori               $a4, $a4, 4095
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        lu12i.w           $a4, 15
        ori               $a4, $a4, 4095
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        lu12i.w           $a4, 15
        ori               $a4, $a4, 4095
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        lu12i.w           $a4, 15
        ori               $a4, $a4, 4095
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        lu12i.w           $a4, 15
        ori               $a4, $a4, 4095
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        lu12i.w           $a4, 15
        ori               $a4, $a4, 4095
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange_weak::u16::release_seqcst:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        lu12i.w           $a4, 15
        ori               $a4, $a4, 4095
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        lu12i.w           $a4, 15
        ori               $a4, $a4, 4095
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        lu12i.w           $a4, 15
        ori               $a4, $a4, 4095
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange_weak::u16::acquire_acquire:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        lu12i.w           $a4, 15
        ori               $a4, $a4, 4095
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        lu12i.w           $a4, 15
        ori               $a4, $a4, 4095
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        lu12i.w           $a4, 15
        ori               $a4, $a4, 4095
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        lu12i.w           $a4, 15
        ori               $a4, $a4, 4095
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange_weak::u16::release_acquire:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        lu12i.w           $a4, 15
        ori               $a4, $a4, 4095
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange_weak::u16::release_relaxed:
        slli.d            $a3, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        lu12i.w           $a4, 15
        ori               $a4, $a4, 4095
        sll.w             $a4, $a4, $a3
        sll.w             $a1, $a1, $a3
        sll.w             $a2, $a2, $a3
0:
        ll.w              $a5, $a0, 0
        and               $a6, $a5, $a4
        bne               $a6, $a1, 1f
        andn              $a6, $a5, $a4
        or                $a6, $a6, $a2
        sc.w              $a6, $a0, 0
        beq               $a6, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        srl.w             $a0, $a5, $a3
        and               $a2, $a5, $a4
        xor               $a1, $a1, $a2
        sltui             $a1, $a1, 1
        ret

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::acqrel_acquire:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::acquire_seqcst:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::release_seqcst:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::seqcst_acquire:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::acquire_acquire:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::acquire_relaxed:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::relaxed_acquire:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::release_acquire:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::release_relaxed:
0:
        ll.w              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.w              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::acqrel_seqcst:
0:
        ll.d              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.d              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::seqcst_seqcst:
0:
        ll.d              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.d              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::acqrel_acquire:
0:
        ll.d              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.d              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::acqrel_relaxed:
0:
        ll.d              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.d              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::acquire_seqcst:
0:
        ll.d              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.d              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::relaxed_seqcst:
0:
        ll.d              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.d              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::release_seqcst:
0:
        ll.d              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.d              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::seqcst_acquire:
0:
        ll.d              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.d              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::seqcst_relaxed:
0:
        ll.d              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.d              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::acquire_acquire:
0:
        ll.d              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.d              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::acquire_relaxed:
0:
        ll.d              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.d              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::relaxed_acquire:
0:
        ll.d              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.d              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::relaxed_relaxed:
0:
        ll.d              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.d              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::release_acquire:
0:
        ll.d              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.d              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::release_relaxed:
0:
        ll.d              $a3, $a0, 0
        bne               $a3, $a1, 1f
        move              $a4, $a2
        sc.d              $a4, $a0, 0
        beq               $a4, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
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

asm_test::load::u64::seqcst:
        ld.d              $a0, $a0, 0
        dbar              16
        ret

asm_test::load::u64::acquire:
        ld.d              $a0, $a0, 0
        dbar              20
        ret

asm_test::load::u64::relaxed:
        ld.d              $a0, $a0, 0
        ret

asm_test::swap::u8::acqrel:
        slli.d            $a2, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        ori               $a3, $zero, 255
        sll.w             $a3, $a3, $a2
        sll.w             $a1, $a1, $a2
0:
        ll.w              $a4, $a0, 0
        addi.w            $a5, $a1, 0
        xor               $a5, $a4, $a5
        and               $a5, $a5, $a3
        xor               $a5, $a4, $a5
        sc.w              $a5, $a0, 0
        beq               $a5, $zero, 0b
        srl.w             $a0, $a4, $a2
        ret

asm_test::swap::u8::seqcst:
        slli.d            $a2, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        ori               $a3, $zero, 255
        sll.w             $a3, $a3, $a2
        sll.w             $a1, $a1, $a2
0:
        ll.w              $a4, $a0, 0
        addi.w            $a5, $a1, 0
        xor               $a5, $a4, $a5
        and               $a5, $a5, $a3
        xor               $a5, $a4, $a5
        sc.w              $a5, $a0, 0
        beq               $a5, $zero, 0b
        srl.w             $a0, $a4, $a2
        ret

asm_test::swap::u8::acquire:
        slli.d            $a2, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        ori               $a3, $zero, 255
        sll.w             $a3, $a3, $a2
        sll.w             $a1, $a1, $a2
0:
        ll.w              $a4, $a0, 0
        addi.w            $a5, $a1, 0
        xor               $a5, $a4, $a5
        and               $a5, $a5, $a3
        xor               $a5, $a4, $a5
        sc.w              $a5, $a0, 0
        beq               $a5, $zero, 0b
        srl.w             $a0, $a4, $a2
        ret

asm_test::swap::u8::relaxed:
        slli.d            $a2, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        ori               $a3, $zero, 255
        sll.w             $a3, $a3, $a2
        sll.w             $a1, $a1, $a2
0:
        ll.w              $a4, $a0, 0
        addi.w            $a5, $a1, 0
        xor               $a5, $a4, $a5
        and               $a5, $a5, $a3
        xor               $a5, $a4, $a5
        sc.w              $a5, $a0, 0
        beq               $a5, $zero, 0b
        srl.w             $a0, $a4, $a2
        ret

asm_test::swap::u8::release:
        slli.d            $a2, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        ori               $a3, $zero, 255
        sll.w             $a3, $a3, $a2
        sll.w             $a1, $a1, $a2
0:
        ll.w              $a4, $a0, 0
        addi.w            $a5, $a1, 0
        xor               $a5, $a4, $a5
        and               $a5, $a5, $a3
        xor               $a5, $a4, $a5
        sc.w              $a5, $a0, 0
        beq               $a5, $zero, 0b
        srl.w             $a0, $a4, $a2
        ret

asm_test::swap::u16::acqrel:
        slli.d            $a2, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        lu12i.w           $a3, 15
        ori               $a3, $a3, 4095
        sll.w             $a3, $a3, $a2
        sll.w             $a1, $a1, $a2
0:
        ll.w              $a4, $a0, 0
        addi.w            $a5, $a1, 0
        xor               $a5, $a4, $a5
        and               $a5, $a5, $a3
        xor               $a5, $a4, $a5
        sc.w              $a5, $a0, 0
        beq               $a5, $zero, 0b
        srl.w             $a0, $a4, $a2
        ret

asm_test::swap::u16::seqcst:
        slli.d            $a2, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        lu12i.w           $a3, 15
        ori               $a3, $a3, 4095
        sll.w             $a3, $a3, $a2
        sll.w             $a1, $a1, $a2
0:
        ll.w              $a4, $a0, 0
        addi.w            $a5, $a1, 0
        xor               $a5, $a4, $a5
        and               $a5, $a5, $a3
        xor               $a5, $a4, $a5
        sc.w              $a5, $a0, 0
        beq               $a5, $zero, 0b
        srl.w             $a0, $a4, $a2
        ret

asm_test::swap::u16::acquire:
        slli.d            $a2, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        lu12i.w           $a3, 15
        ori               $a3, $a3, 4095
        sll.w             $a3, $a3, $a2
        sll.w             $a1, $a1, $a2
0:
        ll.w              $a4, $a0, 0
        addi.w            $a5, $a1, 0
        xor               $a5, $a4, $a5
        and               $a5, $a5, $a3
        xor               $a5, $a4, $a5
        sc.w              $a5, $a0, 0
        beq               $a5, $zero, 0b
        srl.w             $a0, $a4, $a2
        ret

asm_test::swap::u16::relaxed:
        slli.d            $a2, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        lu12i.w           $a3, 15
        ori               $a3, $a3, 4095
        sll.w             $a3, $a3, $a2
        sll.w             $a1, $a1, $a2
0:
        ll.w              $a4, $a0, 0
        addi.w            $a5, $a1, 0
        xor               $a5, $a4, $a5
        and               $a5, $a5, $a3
        xor               $a5, $a4, $a5
        sc.w              $a5, $a0, 0
        beq               $a5, $zero, 0b
        srl.w             $a0, $a4, $a2
        ret

asm_test::swap::u16::release:
        slli.d            $a2, $a0, 3
        bstrins.d         $a0, $zero, 1, 0
        lu12i.w           $a3, 15
        ori               $a3, $a3, 4095
        sll.w             $a3, $a3, $a2
        sll.w             $a1, $a1, $a2
0:
        ll.w              $a4, $a0, 0
        addi.w            $a5, $a1, 0
        xor               $a5, $a4, $a5
        and               $a5, $a5, $a3
        xor               $a5, $a4, $a5
        sc.w              $a5, $a0, 0
        beq               $a5, $zero, 0b
        srl.w             $a0, $a4, $a2
        ret

asm_test::swap::u32::acqrel:
        amswap_db.w       $a2, $a1, $a0
        move              $a0, $a2
        ret

asm_test::swap::u32::seqcst:
        amswap_db.w       $a2, $a1, $a0
        move              $a0, $a2
        ret

asm_test::swap::u32::acquire:
        amswap_db.w       $a2, $a1, $a0
        move              $a0, $a2
        ret

asm_test::swap::u32::relaxed:
        amswap.w          $a2, $a1, $a0
        move              $a0, $a2
        ret

asm_test::swap::u32::release:
        amswap_db.w       $a2, $a1, $a0
        move              $a0, $a2
        ret

asm_test::swap::u64::acqrel:
        amswap_db.d       $a2, $a1, $a0
        move              $a0, $a2
        ret

asm_test::swap::u64::seqcst:
        amswap_db.d       $a2, $a1, $a0
        move              $a0, $a2
        ret

asm_test::swap::u64::acquire:
        amswap_db.d       $a2, $a1, $a0
        move              $a0, $a2
        ret

asm_test::swap::u64::relaxed:
        amswap.d          $a2, $a1, $a0
        move              $a0, $a2
        ret

asm_test::swap::u64::release:
        amswap_db.d       $a2, $a1, $a0
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
        amswap_db.w       $zero, $a1, $a0
        ret

asm_test::store::u32::relaxed:
        st.w              $a1, $a0, 0
        ret

asm_test::store::u32::release:
        amswap_db.w       $zero, $a1, $a0
        ret

asm_test::store::u64::seqcst:
        amswap_db.d       $zero, $a1, $a0
        ret

asm_test::store::u64::relaxed:
        st.d              $a1, $a0, 0
        ret

asm_test::store::u64::release:
        amswap_db.d       $zero, $a1, $a0
        ret

