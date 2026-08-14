asm_test::compare_exchange::u8::acqrel_seqcst:
        move              $a3, $a1
        ext.w.b           $a1, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u8::seqcst_seqcst:
        move              $a3, $a1
        ext.w.b           $a1, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u8::acqrel_acquire:
        move              $a3, $a1
        ext.w.b           $a1, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u8::acqrel_relaxed:
        move              $a3, $a1
        ext.w.b           $a1, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u8::acquire_seqcst:
        move              $a3, $a1
        ext.w.b           $a1, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u8::relaxed_seqcst:
        move              $a3, $a1
        ext.w.b           $a1, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u8::release_seqcst:
        move              $a3, $a1
        ext.w.b           $a1, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u8::seqcst_acquire:
        move              $a3, $a1
        ext.w.b           $a1, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u8::seqcst_relaxed:
        move              $a3, $a1
        ext.w.b           $a1, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u8::acquire_acquire:
        move              $a3, $a1
        ext.w.b           $a1, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u8::acquire_relaxed:
        move              $a3, $a1
        ext.w.b           $a1, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u8::relaxed_acquire:
        move              $a3, $a1
        ext.w.b           $a1, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u8::relaxed_relaxed:
        move              $a3, $a1
        ext.w.b           $a1, $a1
        amcas.b           $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u8::release_acquire:
        move              $a3, $a1
        ext.w.b           $a1, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u8::release_relaxed:
        move              $a3, $a1
        ext.w.b           $a1, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u16::acqrel_seqcst:
        move              $a3, $a1
        ext.w.h           $a1, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u16::seqcst_seqcst:
        move              $a3, $a1
        ext.w.h           $a1, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u16::acqrel_acquire:
        move              $a3, $a1
        ext.w.h           $a1, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u16::acqrel_relaxed:
        move              $a3, $a1
        ext.w.h           $a1, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u16::acquire_seqcst:
        move              $a3, $a1
        ext.w.h           $a1, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u16::relaxed_seqcst:
        move              $a3, $a1
        ext.w.h           $a1, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u16::release_seqcst:
        move              $a3, $a1
        ext.w.h           $a1, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u16::seqcst_acquire:
        move              $a3, $a1
        ext.w.h           $a1, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u16::seqcst_relaxed:
        move              $a3, $a1
        ext.w.h           $a1, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u16::acquire_acquire:
        move              $a3, $a1
        ext.w.h           $a1, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u16::acquire_relaxed:
        move              $a3, $a1
        ext.w.h           $a1, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u16::relaxed_acquire:
        move              $a3, $a1
        ext.w.h           $a1, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u16::relaxed_relaxed:
        move              $a3, $a1
        ext.w.h           $a1, $a1
        amcas.h           $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u16::release_acquire:
        move              $a3, $a1
        ext.w.h           $a1, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u16::release_relaxed:
        move              $a3, $a1
        ext.w.h           $a1, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::acqrel_seqcst:
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::seqcst_seqcst:
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::acqrel_acquire:
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::acqrel_relaxed:
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::acquire_seqcst:
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::relaxed_seqcst:
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::release_seqcst:
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::seqcst_acquire:
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::seqcst_relaxed:
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::acquire_acquire:
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::acquire_relaxed:
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::relaxed_acquire:
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::relaxed_relaxed:
        move              $a3, $a1
        amcas.w           $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::release_acquire:
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::release_relaxed:
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::acqrel_seqcst:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::seqcst_seqcst:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::acqrel_acquire:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::acqrel_relaxed:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::acquire_seqcst:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::relaxed_seqcst:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::release_seqcst:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::seqcst_acquire:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::seqcst_relaxed:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::acquire_acquire:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::acquire_relaxed:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::relaxed_acquire:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::relaxed_relaxed:
        move              $a3, $a1
        amcas.d           $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::release_acquire:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::release_relaxed:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange::u128::acqrel_seqcst:
0:
        ll.d              $a6, $a1, 0
        dbar              20
        ld.d              $a7, $a1, 8
        bne               $a6, $a2, 1f
        bne               $a7, $a3, 1f
        move              $t0, $a4
        sc.q              $t0, $a5, $a1
        beq               $t0, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a1, $a7, $a3
        xor               $a2, $a6, $a2
        or                $a1, $a2, $a1
        sltui             $a1, $a1, 1
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $a1, $a0, 16
        ret

asm_test::compare_exchange::u128::seqcst_seqcst:
0:
        ll.d              $a6, $a1, 0
        dbar              20
        ld.d              $a7, $a1, 8
        bne               $a6, $a2, 1f
        bne               $a7, $a3, 1f
        move              $t0, $a4
        sc.q              $t0, $a5, $a1
        beq               $t0, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a1, $a7, $a3
        xor               $a2, $a6, $a2
        or                $a1, $a2, $a1
        sltui             $a1, $a1, 1
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $a1, $a0, 16
        ret

asm_test::compare_exchange::u128::acqrel_acquire:
0:
        ll.d              $a6, $a1, 0
        dbar              20
        ld.d              $a7, $a1, 8
        bne               $a6, $a2, 1f
        bne               $a7, $a3, 1f
        move              $t0, $a4
        sc.q              $t0, $a5, $a1
        beq               $t0, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a1, $a7, $a3
        xor               $a2, $a6, $a2
        or                $a1, $a2, $a1
        sltui             $a1, $a1, 1
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $a1, $a0, 16
        ret

asm_test::compare_exchange::u128::acqrel_relaxed:
0:
        ll.d              $a6, $a1, 0
        dbar              20
        ld.d              $a7, $a1, 8
        bne               $a6, $a2, 1f
        bne               $a7, $a3, 1f
        move              $t0, $a4
        sc.q              $t0, $a5, $a1
        beq               $t0, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a1, $a7, $a3
        xor               $a2, $a6, $a2
        or                $a1, $a2, $a1
        sltui             $a1, $a1, 1
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $a1, $a0, 16
        ret

asm_test::compare_exchange::u128::acquire_seqcst:
0:
        ll.d              $a6, $a1, 0
        dbar              20
        ld.d              $a7, $a1, 8
        bne               $a6, $a2, 1f
        bne               $a7, $a3, 1f
        move              $t0, $a4
        sc.q              $t0, $a5, $a1
        beq               $t0, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a1, $a7, $a3
        xor               $a2, $a6, $a2
        or                $a1, $a2, $a1
        sltui             $a1, $a1, 1
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $a1, $a0, 16
        ret

asm_test::compare_exchange::u128::relaxed_seqcst:
0:
        ll.d              $a6, $a1, 0
        dbar              20
        ld.d              $a7, $a1, 8
        bne               $a6, $a2, 1f
        bne               $a7, $a3, 1f
        move              $t0, $a4
        sc.q              $t0, $a5, $a1
        beq               $t0, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a1, $a7, $a3
        xor               $a2, $a6, $a2
        or                $a1, $a2, $a1
        sltui             $a1, $a1, 1
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $a1, $a0, 16
        ret

asm_test::compare_exchange::u128::release_seqcst:
0:
        ll.d              $a6, $a1, 0
        dbar              20
        ld.d              $a7, $a1, 8
        bne               $a6, $a2, 1f
        bne               $a7, $a3, 1f
        move              $t0, $a4
        sc.q              $t0, $a5, $a1
        beq               $t0, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a1, $a7, $a3
        xor               $a2, $a6, $a2
        or                $a1, $a2, $a1
        sltui             $a1, $a1, 1
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $a1, $a0, 16
        ret

asm_test::compare_exchange::u128::seqcst_acquire:
0:
        ll.d              $a6, $a1, 0
        dbar              20
        ld.d              $a7, $a1, 8
        bne               $a6, $a2, 1f
        bne               $a7, $a3, 1f
        move              $t0, $a4
        sc.q              $t0, $a5, $a1
        beq               $t0, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a1, $a7, $a3
        xor               $a2, $a6, $a2
        or                $a1, $a2, $a1
        sltui             $a1, $a1, 1
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $a1, $a0, 16
        ret

asm_test::compare_exchange::u128::seqcst_relaxed:
0:
        ll.d              $a6, $a1, 0
        dbar              20
        ld.d              $a7, $a1, 8
        bne               $a6, $a2, 1f
        bne               $a7, $a3, 1f
        move              $t0, $a4
        sc.q              $t0, $a5, $a1
        beq               $t0, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a1, $a7, $a3
        xor               $a2, $a6, $a2
        or                $a1, $a2, $a1
        sltui             $a1, $a1, 1
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $a1, $a0, 16
        ret

asm_test::compare_exchange::u128::acquire_acquire:
0:
        ll.d              $a6, $a1, 0
        dbar              20
        ld.d              $a7, $a1, 8
        bne               $a6, $a2, 1f
        bne               $a7, $a3, 1f
        move              $t0, $a4
        sc.q              $t0, $a5, $a1
        beq               $t0, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a1, $a7, $a3
        xor               $a2, $a6, $a2
        or                $a1, $a2, $a1
        sltui             $a1, $a1, 1
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $a1, $a0, 16
        ret

asm_test::compare_exchange::u128::acquire_relaxed:
0:
        ll.d              $a6, $a1, 0
        dbar              20
        ld.d              $a7, $a1, 8
        bne               $a6, $a2, 1f
        bne               $a7, $a3, 1f
        move              $t0, $a4
        sc.q              $t0, $a5, $a1
        beq               $t0, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a1, $a7, $a3
        xor               $a2, $a6, $a2
        or                $a1, $a2, $a1
        sltui             $a1, $a1, 1
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $a1, $a0, 16
        ret

asm_test::compare_exchange::u128::relaxed_acquire:
0:
        ll.d              $a6, $a1, 0
        dbar              20
        ld.d              $a7, $a1, 8
        bne               $a6, $a2, 1f
        bne               $a7, $a3, 1f
        move              $t0, $a4
        sc.q              $t0, $a5, $a1
        beq               $t0, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a1, $a7, $a3
        xor               $a2, $a6, $a2
        or                $a1, $a2, $a1
        sltui             $a1, $a1, 1
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $a1, $a0, 16
        ret

asm_test::compare_exchange::u128::relaxed_relaxed:
0:
        ll.d              $a6, $a1, 0
        dbar              20
        ld.d              $a7, $a1, 8
        bne               $a6, $a2, 1f
        bne               $a7, $a3, 1f
        move              $t0, $a4
        sc.q              $t0, $a5, $a1
        beq               $t0, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        xor               $a1, $a7, $a3
        xor               $a2, $a6, $a2
        or                $a1, $a2, $a1
        sltui             $a1, $a1, 1
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $a1, $a0, 16
        ret

asm_test::compare_exchange::u128::release_acquire:
0:
        ll.d              $a6, $a1, 0
        dbar              20
        ld.d              $a7, $a1, 8
        bne               $a6, $a2, 1f
        bne               $a7, $a3, 1f
        move              $t0, $a4
        sc.q              $t0, $a5, $a1
        beq               $t0, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a1, $a7, $a3
        xor               $a2, $a6, $a2
        or                $a1, $a2, $a1
        sltui             $a1, $a1, 1
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $a1, $a0, 16
        ret

asm_test::compare_exchange::u128::release_relaxed:
0:
        ll.d              $a6, $a1, 0
        dbar              20
        ld.d              $a7, $a1, 8
        bne               $a6, $a2, 1f
        bne               $a7, $a3, 1f
        move              $t0, $a4
        sc.q              $t0, $a5, $a1
        beq               $t0, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        xor               $a1, $a7, $a3
        xor               $a2, $a6, $a2
        or                $a1, $a2, $a1
        sltui             $a1, $a1, 1
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $a1, $a0, 16
        ret

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        move              $a3, $a1
        ext.w.b           $a1, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        move              $a3, $a1
        ext.w.b           $a1, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        move              $a3, $a1
        ext.w.b           $a1, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        move              $a3, $a1
        ext.w.b           $a1, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        move              $a3, $a1
        ext.w.b           $a1, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        move              $a3, $a1
        ext.w.b           $a1, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u8::release_seqcst:
        move              $a3, $a1
        ext.w.b           $a1, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        move              $a3, $a1
        ext.w.b           $a1, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        move              $a3, $a1
        ext.w.b           $a1, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u8::acquire_acquire:
        move              $a3, $a1
        ext.w.b           $a1, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        move              $a3, $a1
        ext.w.b           $a1, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        move              $a3, $a1
        ext.w.b           $a1, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        move              $a3, $a1
        ext.w.b           $a1, $a1
        amcas.b           $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u8::release_acquire:
        move              $a3, $a1
        ext.w.b           $a1, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u8::release_relaxed:
        move              $a3, $a1
        ext.w.b           $a1, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        move              $a3, $a1
        ext.w.h           $a1, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        move              $a3, $a1
        ext.w.h           $a1, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        move              $a3, $a1
        ext.w.h           $a1, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        move              $a3, $a1
        ext.w.h           $a1, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        move              $a3, $a1
        ext.w.h           $a1, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        move              $a3, $a1
        ext.w.h           $a1, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u16::release_seqcst:
        move              $a3, $a1
        ext.w.h           $a1, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        move              $a3, $a1
        ext.w.h           $a1, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        move              $a3, $a1
        ext.w.h           $a1, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u16::acquire_acquire:
        move              $a3, $a1
        ext.w.h           $a1, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        move              $a3, $a1
        ext.w.h           $a1, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        move              $a3, $a1
        ext.w.h           $a1, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        move              $a3, $a1
        ext.w.h           $a1, $a1
        amcas.h           $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u16::release_acquire:
        move              $a3, $a1
        ext.w.h           $a1, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u16::release_relaxed:
        move              $a3, $a1
        ext.w.h           $a1, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::release_seqcst:
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::acquire_acquire:
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        move              $a3, $a1
        amcas.w           $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::release_acquire:
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::release_relaxed:
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::acqrel_seqcst:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::seqcst_seqcst:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::acqrel_acquire:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::acqrel_relaxed:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::acquire_seqcst:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::relaxed_seqcst:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::release_seqcst:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::seqcst_acquire:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::seqcst_relaxed:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::acquire_acquire:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::acquire_relaxed:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::relaxed_acquire:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::relaxed_relaxed:
        move              $a3, $a1
        amcas.d           $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::release_acquire:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::release_relaxed:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a1, $a0, 1
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u128::acqrel_seqcst:
0:
        ll.d              $a6, $a1, 0
        dbar              20
        ld.d              $a7, $a1, 8
        bne               $a6, $a2, 1f
        bne               $a7, $a3, 1f
        move              $t0, $a4
        sc.q              $t0, $a5, $a1
        beq               $t0, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a1, $a7, $a3
        xor               $a2, $a6, $a2
        or                $a1, $a2, $a1
        sltui             $a1, $a1, 1
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $a1, $a0, 16
        ret

asm_test::compare_exchange_weak::u128::seqcst_seqcst:
0:
        ll.d              $a6, $a1, 0
        dbar              20
        ld.d              $a7, $a1, 8
        bne               $a6, $a2, 1f
        bne               $a7, $a3, 1f
        move              $t0, $a4
        sc.q              $t0, $a5, $a1
        beq               $t0, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a1, $a7, $a3
        xor               $a2, $a6, $a2
        or                $a1, $a2, $a1
        sltui             $a1, $a1, 1
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $a1, $a0, 16
        ret

asm_test::compare_exchange_weak::u128::acqrel_acquire:
0:
        ll.d              $a6, $a1, 0
        dbar              20
        ld.d              $a7, $a1, 8
        bne               $a6, $a2, 1f
        bne               $a7, $a3, 1f
        move              $t0, $a4
        sc.q              $t0, $a5, $a1
        beq               $t0, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a1, $a7, $a3
        xor               $a2, $a6, $a2
        or                $a1, $a2, $a1
        sltui             $a1, $a1, 1
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $a1, $a0, 16
        ret

asm_test::compare_exchange_weak::u128::acqrel_relaxed:
0:
        ll.d              $a6, $a1, 0
        dbar              20
        ld.d              $a7, $a1, 8
        bne               $a6, $a2, 1f
        bne               $a7, $a3, 1f
        move              $t0, $a4
        sc.q              $t0, $a5, $a1
        beq               $t0, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a1, $a7, $a3
        xor               $a2, $a6, $a2
        or                $a1, $a2, $a1
        sltui             $a1, $a1, 1
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $a1, $a0, 16
        ret

asm_test::compare_exchange_weak::u128::acquire_seqcst:
0:
        ll.d              $a6, $a1, 0
        dbar              20
        ld.d              $a7, $a1, 8
        bne               $a6, $a2, 1f
        bne               $a7, $a3, 1f
        move              $t0, $a4
        sc.q              $t0, $a5, $a1
        beq               $t0, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a1, $a7, $a3
        xor               $a2, $a6, $a2
        or                $a1, $a2, $a1
        sltui             $a1, $a1, 1
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $a1, $a0, 16
        ret

asm_test::compare_exchange_weak::u128::relaxed_seqcst:
0:
        ll.d              $a6, $a1, 0
        dbar              20
        ld.d              $a7, $a1, 8
        bne               $a6, $a2, 1f
        bne               $a7, $a3, 1f
        move              $t0, $a4
        sc.q              $t0, $a5, $a1
        beq               $t0, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a1, $a7, $a3
        xor               $a2, $a6, $a2
        or                $a1, $a2, $a1
        sltui             $a1, $a1, 1
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $a1, $a0, 16
        ret

asm_test::compare_exchange_weak::u128::release_seqcst:
0:
        ll.d              $a6, $a1, 0
        dbar              20
        ld.d              $a7, $a1, 8
        bne               $a6, $a2, 1f
        bne               $a7, $a3, 1f
        move              $t0, $a4
        sc.q              $t0, $a5, $a1
        beq               $t0, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a1, $a7, $a3
        xor               $a2, $a6, $a2
        or                $a1, $a2, $a1
        sltui             $a1, $a1, 1
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $a1, $a0, 16
        ret

asm_test::compare_exchange_weak::u128::seqcst_acquire:
0:
        ll.d              $a6, $a1, 0
        dbar              20
        ld.d              $a7, $a1, 8
        bne               $a6, $a2, 1f
        bne               $a7, $a3, 1f
        move              $t0, $a4
        sc.q              $t0, $a5, $a1
        beq               $t0, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a1, $a7, $a3
        xor               $a2, $a6, $a2
        or                $a1, $a2, $a1
        sltui             $a1, $a1, 1
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $a1, $a0, 16
        ret

asm_test::compare_exchange_weak::u128::seqcst_relaxed:
0:
        ll.d              $a6, $a1, 0
        dbar              20
        ld.d              $a7, $a1, 8
        bne               $a6, $a2, 1f
        bne               $a7, $a3, 1f
        move              $t0, $a4
        sc.q              $t0, $a5, $a1
        beq               $t0, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a1, $a7, $a3
        xor               $a2, $a6, $a2
        or                $a1, $a2, $a1
        sltui             $a1, $a1, 1
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $a1, $a0, 16
        ret

asm_test::compare_exchange_weak::u128::acquire_acquire:
0:
        ll.d              $a6, $a1, 0
        dbar              20
        ld.d              $a7, $a1, 8
        bne               $a6, $a2, 1f
        bne               $a7, $a3, 1f
        move              $t0, $a4
        sc.q              $t0, $a5, $a1
        beq               $t0, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a1, $a7, $a3
        xor               $a2, $a6, $a2
        or                $a1, $a2, $a1
        sltui             $a1, $a1, 1
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $a1, $a0, 16
        ret

asm_test::compare_exchange_weak::u128::acquire_relaxed:
0:
        ll.d              $a6, $a1, 0
        dbar              20
        ld.d              $a7, $a1, 8
        bne               $a6, $a2, 1f
        bne               $a7, $a3, 1f
        move              $t0, $a4
        sc.q              $t0, $a5, $a1
        beq               $t0, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a1, $a7, $a3
        xor               $a2, $a6, $a2
        or                $a1, $a2, $a1
        sltui             $a1, $a1, 1
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $a1, $a0, 16
        ret

asm_test::compare_exchange_weak::u128::relaxed_acquire:
0:
        ll.d              $a6, $a1, 0
        dbar              20
        ld.d              $a7, $a1, 8
        bne               $a6, $a2, 1f
        bne               $a7, $a3, 1f
        move              $t0, $a4
        sc.q              $t0, $a5, $a1
        beq               $t0, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a1, $a7, $a3
        xor               $a2, $a6, $a2
        or                $a1, $a2, $a1
        sltui             $a1, $a1, 1
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $a1, $a0, 16
        ret

asm_test::compare_exchange_weak::u128::relaxed_relaxed:
0:
        ll.d              $a6, $a1, 0
        dbar              20
        ld.d              $a7, $a1, 8
        bne               $a6, $a2, 1f
        bne               $a7, $a3, 1f
        move              $t0, $a4
        sc.q              $t0, $a5, $a1
        beq               $t0, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        xor               $a1, $a7, $a3
        xor               $a2, $a6, $a2
        or                $a1, $a2, $a1
        sltui             $a1, $a1, 1
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $a1, $a0, 16
        ret

asm_test::compare_exchange_weak::u128::release_acquire:
0:
        ll.d              $a6, $a1, 0
        dbar              20
        ld.d              $a7, $a1, 8
        bne               $a6, $a2, 1f
        bne               $a7, $a3, 1f
        move              $t0, $a4
        sc.q              $t0, $a5, $a1
        beq               $t0, $zero, 0b
        b                 2f
1:
        dbar              20
2:
        xor               $a1, $a7, $a3
        xor               $a2, $a6, $a2
        or                $a1, $a2, $a1
        sltui             $a1, $a1, 1
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $a1, $a0, 16
        ret

asm_test::compare_exchange_weak::u128::release_relaxed:
0:
        ll.d              $a6, $a1, 0
        dbar              20
        ld.d              $a7, $a1, 8
        bne               $a6, $a2, 1f
        bne               $a7, $a3, 1f
        move              $t0, $a4
        sc.q              $t0, $a5, $a1
        beq               $t0, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        xor               $a1, $a7, $a3
        xor               $a2, $a6, $a2
        or                $a1, $a2, $a1
        sltui             $a1, $a1, 1
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $a1, $a0, 16
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

asm_test::load::u128::seqcst:
0:
        ll.d              $a2, $a0, 0
        dbar              20
        ld.d              $a1, $a0, 8
        bne               $a2, $zero, 1f
        bne               $a1, $zero, 1f
        move              $a3, $zero
        sc.q              $a3, $zero, $a0
        beq               $a3, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        dbar              16
        move              $a0, $a2
        ret

asm_test::load::u128::acquire:
0:
        ll.d              $a2, $a0, 0
        dbar              20
        ld.d              $a1, $a0, 8
        bne               $a2, $zero, 1f
        bne               $a1, $zero, 1f
        move              $a3, $zero
        sc.q              $a3, $zero, $a0
        beq               $a3, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        dbar              20
        move              $a0, $a2
        ret

asm_test::load::u128::relaxed:
0:
        ll.d              $a2, $a0, 0
        dbar              20
        ld.d              $a1, $a0, 8
        bne               $a2, $zero, 1f
        bne               $a1, $zero, 1f
        move              $a3, $zero
        sc.q              $a3, $zero, $a0
        beq               $a3, $zero, 0b
        b                 2f
1:
        dbar              1792
2:
        move              $a0, $a2
        ret

asm_test::swap::u8::acqrel:
        amswap_db.b       $a2, $a1, $a0
        move              $a0, $a2
        ret

asm_test::swap::u8::seqcst:
        amswap_db.b       $a2, $a1, $a0
        move              $a0, $a2
        ret

asm_test::swap::u8::acquire:
        amswap_db.b       $a2, $a1, $a0
        move              $a0, $a2
        ret

asm_test::swap::u8::relaxed:
        amswap.b          $a2, $a1, $a0
        move              $a0, $a2
        ret

asm_test::swap::u8::release:
        amswap_db.b       $a2, $a1, $a0
        move              $a0, $a2
        ret

asm_test::swap::u16::acqrel:
        amswap_db.h       $a2, $a1, $a0
        move              $a0, $a2
        ret

asm_test::swap::u16::seqcst:
        amswap_db.h       $a2, $a1, $a0
        move              $a0, $a2
        ret

asm_test::swap::u16::acquire:
        amswap_db.h       $a2, $a1, $a0
        move              $a0, $a2
        ret

asm_test::swap::u16::relaxed:
        amswap.h          $a2, $a1, $a0
        move              $a0, $a2
        ret

asm_test::swap::u16::release:
        amswap_db.h       $a2, $a1, $a0
        move              $a0, $a2
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

asm_test::swap::u128::acqrel:
        addi.d            $sp, $sp, -16
        st.d              $ra, $sp, 8
0:
        pcaddu18i         $ra, 0
        jirl              $ra, $ra, 0b
        ld.d              $ra, $sp, 8
        addi.d            $sp, $sp, 16
        ret

asm_test::swap::u128::seqcst:
        addi.d            $sp, $sp, -16
        st.d              $ra, $sp, 8
0:
        pcaddu18i         $ra, 0
        jirl              $ra, $ra, 0b
        ld.d              $ra, $sp, 8
        addi.d            $sp, $sp, 16
        ret

asm_test::swap::u128::acquire:
        addi.d            $sp, $sp, -16
        st.d              $ra, $sp, 8
0:
        pcaddu18i         $ra, 0
        jirl              $ra, $ra, 0b
        ld.d              $ra, $sp, 8
        addi.d            $sp, $sp, 16
        ret

asm_test::swap::u128::relaxed:
        addi.d            $sp, $sp, -16
        st.d              $ra, $sp, 8
0:
        pcaddu18i         $ra, 0
        jirl              $ra, $ra, 0b
        ld.d              $ra, $sp, 8
        addi.d            $sp, $sp, 16
        ret

asm_test::swap::u128::release:
        addi.d            $sp, $sp, -16
        st.d              $ra, $sp, 8
0:
        pcaddu18i         $ra, 0
        jirl              $ra, $ra, 0b
        ld.d              $ra, $sp, 8
        addi.d            $sp, $sp, 16
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

asm_test::store::u128::seqcst:
        addi.d            $sp, $sp, -16
        st.d              $ra, $sp, 8
0:
        pcaddu18i         $ra, 0
        jirl              $ra, $ra, 0b
        ld.d              $ra, $sp, 8
        addi.d            $sp, $sp, 16
        ret

asm_test::store::u128::relaxed:
        addi.d            $sp, $sp, -16
        st.d              $ra, $sp, 8
0:
        pcaddu18i         $ra, 0
        jirl              $ra, $ra, 0b
        ld.d              $ra, $sp, 8
        addi.d            $sp, $sp, 16
        ret

asm_test::store::u128::release:
        addi.d            $sp, $sp, -16
        st.d              $ra, $sp, 8
0:
        pcaddu18i         $ra, 0
        jirl              $ra, $ra, 0b
        ld.d              $ra, $sp, 8
        addi.d            $sp, $sp, 16
        ret
