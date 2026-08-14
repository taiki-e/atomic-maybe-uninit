asm_test::compare_exchange::u8::acqrel_seqcst:
        ext.w.b           $a1, $a1
        move              $a3, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u8::seqcst_seqcst:
        ext.w.b           $a1, $a1
        move              $a3, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u8::acqrel_acquire:
        ext.w.b           $a1, $a1
        move              $a3, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u8::acqrel_relaxed:
        ext.w.b           $a1, $a1
        move              $a3, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u8::acquire_seqcst:
        ext.w.b           $a1, $a1
        move              $a3, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u8::relaxed_seqcst:
        ext.w.b           $a1, $a1
        move              $a3, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u8::release_seqcst:
        ext.w.b           $a1, $a1
        move              $a3, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u8::seqcst_acquire:
        ext.w.b           $a1, $a1
        move              $a3, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u8::seqcst_relaxed:
        ext.w.b           $a1, $a1
        move              $a3, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u8::acquire_acquire:
        ext.w.b           $a1, $a1
        move              $a3, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u8::acquire_relaxed:
        ext.w.b           $a1, $a1
        move              $a3, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u8::relaxed_acquire:
        ext.w.b           $a1, $a1
        move              $a3, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u8::relaxed_relaxed:
        ext.w.b           $a1, $a1
        move              $a3, $a1
        amcas.b           $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u8::release_acquire:
        ext.w.b           $a1, $a1
        move              $a3, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u8::release_relaxed:
        ext.w.b           $a1, $a1
        move              $a3, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u16::acqrel_seqcst:
        ext.w.h           $a1, $a1
        move              $a3, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u16::seqcst_seqcst:
        ext.w.h           $a1, $a1
        move              $a3, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u16::acqrel_acquire:
        ext.w.h           $a1, $a1
        move              $a3, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u16::acqrel_relaxed:
        ext.w.h           $a1, $a1
        move              $a3, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u16::acquire_seqcst:
        ext.w.h           $a1, $a1
        move              $a3, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u16::relaxed_seqcst:
        ext.w.h           $a1, $a1
        move              $a3, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u16::release_seqcst:
        ext.w.h           $a1, $a1
        move              $a3, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u16::seqcst_acquire:
        ext.w.h           $a1, $a1
        move              $a3, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u16::seqcst_relaxed:
        ext.w.h           $a1, $a1
        move              $a3, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u16::acquire_acquire:
        ext.w.h           $a1, $a1
        move              $a3, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u16::acquire_relaxed:
        ext.w.h           $a1, $a1
        move              $a3, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u16::relaxed_acquire:
        ext.w.h           $a1, $a1
        move              $a3, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u16::relaxed_relaxed:
        ext.w.h           $a1, $a1
        move              $a3, $a1
        amcas.h           $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u16::release_acquire:
        ext.w.h           $a1, $a1
        move              $a3, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u16::release_relaxed:
        ext.w.h           $a1, $a1
        move              $a3, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::acqrel_seqcst:
        slli.w            $a1, $a1, 0
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::seqcst_seqcst:
        slli.w            $a1, $a1, 0
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::acqrel_acquire:
        slli.w            $a1, $a1, 0
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::acqrel_relaxed:
        slli.w            $a1, $a1, 0
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::acquire_seqcst:
        slli.w            $a1, $a1, 0
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::relaxed_seqcst:
        slli.w            $a1, $a1, 0
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::release_seqcst:
        slli.w            $a1, $a1, 0
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::seqcst_acquire:
        slli.w            $a1, $a1, 0
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::seqcst_relaxed:
        slli.w            $a1, $a1, 0
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::acquire_acquire:
        slli.w            $a1, $a1, 0
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::acquire_relaxed:
        slli.w            $a1, $a1, 0
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::relaxed_acquire:
        slli.w            $a1, $a1, 0
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::relaxed_relaxed:
        slli.w            $a1, $a1, 0
        move              $a3, $a1
        amcas.w           $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::release_acquire:
        slli.w            $a1, $a1, 0
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u32::release_relaxed:
        slli.w            $a1, $a1, 0
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::acqrel_seqcst:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::seqcst_seqcst:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::acqrel_acquire:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::acqrel_relaxed:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::acquire_seqcst:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::relaxed_seqcst:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::release_seqcst:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::seqcst_acquire:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::seqcst_relaxed:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::acquire_acquire:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::acquire_relaxed:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::relaxed_acquire:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::relaxed_relaxed:
        move              $a3, $a1
        amcas.d           $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::release_acquire:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange::u64::release_relaxed:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
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
        beqz              $t0, 0b
        b                 2f
1:
        move              $t0, $a6
        sc.q              $t0, $a7, $a1
        beqz              $t0, 0b
        move              $t0, $zero
2:
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $t0, $a0, 16
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
        beqz              $t0, 0b
        b                 2f
1:
        move              $t0, $a6
        sc.q              $t0, $a7, $a1
        beqz              $t0, 0b
        move              $t0, $zero
2:
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $t0, $a0, 16
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
        beqz              $t0, 0b
        b                 2f
1:
        move              $t0, $a6
        sc.q              $t0, $a7, $a1
        beqz              $t0, 0b
        move              $t0, $zero
2:
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $t0, $a0, 16
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
        beqz              $t0, 0b
        b                 2f
1:
        move              $t0, $a6
        sc.q              $t0, $a7, $a1
        beqz              $t0, 0b
        move              $t0, $zero
2:
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $t0, $a0, 16
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
        beqz              $t0, 0b
        b                 2f
1:
        move              $t0, $a6
        sc.q              $t0, $a7, $a1
        beqz              $t0, 0b
        move              $t0, $zero
2:
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $t0, $a0, 16
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
        beqz              $t0, 0b
        b                 2f
1:
        move              $t0, $a6
        sc.q              $t0, $a7, $a1
        beqz              $t0, 0b
        move              $t0, $zero
2:
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $t0, $a0, 16
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
        beqz              $t0, 0b
        b                 2f
1:
        move              $t0, $a6
        sc.q              $t0, $a7, $a1
        beqz              $t0, 0b
        move              $t0, $zero
2:
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $t0, $a0, 16
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
        beqz              $t0, 0b
        b                 2f
1:
        move              $t0, $a6
        sc.q              $t0, $a7, $a1
        beqz              $t0, 0b
        move              $t0, $zero
2:
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $t0, $a0, 16
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
        beqz              $t0, 0b
        b                 2f
1:
        move              $t0, $a6
        sc.q              $t0, $a7, $a1
        beqz              $t0, 0b
        move              $t0, $zero
2:
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $t0, $a0, 16
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
        beqz              $t0, 0b
        b                 2f
1:
        move              $t0, $a6
        sc.q              $t0, $a7, $a1
        beqz              $t0, 0b
        move              $t0, $zero
2:
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $t0, $a0, 16
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
        beqz              $t0, 0b
        b                 2f
1:
        move              $t0, $a6
        sc.q              $t0, $a7, $a1
        beqz              $t0, 0b
        move              $t0, $zero
2:
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $t0, $a0, 16
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
        beqz              $t0, 0b
        b                 2f
1:
        move              $t0, $a6
        sc.q              $t0, $a7, $a1
        beqz              $t0, 0b
        move              $t0, $zero
2:
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $t0, $a0, 16
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
        beqz              $t0, 0b
        b                 2f
1:
        move              $t0, $a6
        sc.q              $t0, $a7, $a1
        beqz              $t0, 0b
        move              $t0, $zero
2:
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $t0, $a0, 16
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
        beqz              $t0, 0b
        b                 2f
1:
        move              $t0, $a6
        sc.q              $t0, $a7, $a1
        beqz              $t0, 0b
        move              $t0, $zero
2:
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $t0, $a0, 16
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
        beqz              $t0, 0b
        b                 2f
1:
        move              $t0, $a6
        sc.q              $t0, $a7, $a1
        beqz              $t0, 0b
        move              $t0, $zero
2:
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $t0, $a0, 16
        ret

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        ext.w.b           $a1, $a1
        move              $a3, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        ext.w.b           $a1, $a1
        move              $a3, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        ext.w.b           $a1, $a1
        move              $a3, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        ext.w.b           $a1, $a1
        move              $a3, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        ext.w.b           $a1, $a1
        move              $a3, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        ext.w.b           $a1, $a1
        move              $a3, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u8::release_seqcst:
        ext.w.b           $a1, $a1
        move              $a3, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        ext.w.b           $a1, $a1
        move              $a3, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        ext.w.b           $a1, $a1
        move              $a3, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u8::acquire_acquire:
        ext.w.b           $a1, $a1
        move              $a3, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        ext.w.b           $a1, $a1
        move              $a3, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        ext.w.b           $a1, $a1
        move              $a3, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        ext.w.b           $a1, $a1
        move              $a3, $a1
        amcas.b           $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u8::release_acquire:
        ext.w.b           $a1, $a1
        move              $a3, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u8::release_relaxed:
        ext.w.b           $a1, $a1
        move              $a3, $a1
        amcas_db.b        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        ext.w.h           $a1, $a1
        move              $a3, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        ext.w.h           $a1, $a1
        move              $a3, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        ext.w.h           $a1, $a1
        move              $a3, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        ext.w.h           $a1, $a1
        move              $a3, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        ext.w.h           $a1, $a1
        move              $a3, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        ext.w.h           $a1, $a1
        move              $a3, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u16::release_seqcst:
        ext.w.h           $a1, $a1
        move              $a3, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        ext.w.h           $a1, $a1
        move              $a3, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        ext.w.h           $a1, $a1
        move              $a3, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u16::acquire_acquire:
        ext.w.h           $a1, $a1
        move              $a3, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        ext.w.h           $a1, $a1
        move              $a3, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        ext.w.h           $a1, $a1
        move              $a3, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        ext.w.h           $a1, $a1
        move              $a3, $a1
        amcas.h           $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u16::release_acquire:
        ext.w.h           $a1, $a1
        move              $a3, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u16::release_relaxed:
        ext.w.h           $a1, $a1
        move              $a3, $a1
        amcas_db.h        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        slli.w            $a1, $a1, 0
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        slli.w            $a1, $a1, 0
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        slli.w            $a1, $a1, 0
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        slli.w            $a1, $a1, 0
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        slli.w            $a1, $a1, 0
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        slli.w            $a1, $a1, 0
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::release_seqcst:
        slli.w            $a1, $a1, 0
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        slli.w            $a1, $a1, 0
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        slli.w            $a1, $a1, 0
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::acquire_acquire:
        slli.w            $a1, $a1, 0
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        slli.w            $a1, $a1, 0
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        slli.w            $a1, $a1, 0
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        slli.w            $a1, $a1, 0
        move              $a3, $a1
        amcas.w           $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::release_acquire:
        slli.w            $a1, $a1, 0
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u32::release_relaxed:
        slli.w            $a1, $a1, 0
        move              $a3, $a1
        amcas_db.w        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::acqrel_seqcst:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::seqcst_seqcst:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::acqrel_acquire:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::acqrel_relaxed:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::acquire_seqcst:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::relaxed_seqcst:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::release_seqcst:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::seqcst_acquire:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::seqcst_relaxed:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::acquire_acquire:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::acquire_relaxed:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::relaxed_acquire:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::relaxed_relaxed:
        move              $a3, $a1
        amcas.d           $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::release_acquire:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
        move              $a0, $a3
        ret

asm_test::compare_exchange_weak::u64::release_relaxed:
        move              $a3, $a1
        amcas_db.d        $a3, $a2, $a0
        xor               $a0, $a3, $a1
        sltui             $a0, $a0, 1
        sltu              $a1, $zero, $a0
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
        beqz              $t0, 0b
        b                 2f
1:
        move              $t0, $a6
        sc.q              $t0, $a7, $a1
        beqz              $t0, 0b
        move              $t0, $zero
2:
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $t0, $a0, 16
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
        beqz              $t0, 0b
        b                 2f
1:
        move              $t0, $a6
        sc.q              $t0, $a7, $a1
        beqz              $t0, 0b
        move              $t0, $zero
2:
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $t0, $a0, 16
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
        beqz              $t0, 0b
        b                 2f
1:
        move              $t0, $a6
        sc.q              $t0, $a7, $a1
        beqz              $t0, 0b
        move              $t0, $zero
2:
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $t0, $a0, 16
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
        beqz              $t0, 0b
        b                 2f
1:
        move              $t0, $a6
        sc.q              $t0, $a7, $a1
        beqz              $t0, 0b
        move              $t0, $zero
2:
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $t0, $a0, 16
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
        beqz              $t0, 0b
        b                 2f
1:
        move              $t0, $a6
        sc.q              $t0, $a7, $a1
        beqz              $t0, 0b
        move              $t0, $zero
2:
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $t0, $a0, 16
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
        beqz              $t0, 0b
        b                 2f
1:
        move              $t0, $a6
        sc.q              $t0, $a7, $a1
        beqz              $t0, 0b
        move              $t0, $zero
2:
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $t0, $a0, 16
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
        beqz              $t0, 0b
        b                 2f
1:
        move              $t0, $a6
        sc.q              $t0, $a7, $a1
        beqz              $t0, 0b
        move              $t0, $zero
2:
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $t0, $a0, 16
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
        beqz              $t0, 0b
        b                 2f
1:
        move              $t0, $a6
        sc.q              $t0, $a7, $a1
        beqz              $t0, 0b
        move              $t0, $zero
2:
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $t0, $a0, 16
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
        beqz              $t0, 0b
        b                 2f
1:
        move              $t0, $a6
        sc.q              $t0, $a7, $a1
        beqz              $t0, 0b
        move              $t0, $zero
2:
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $t0, $a0, 16
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
        beqz              $t0, 0b
        b                 2f
1:
        move              $t0, $a6
        sc.q              $t0, $a7, $a1
        beqz              $t0, 0b
        move              $t0, $zero
2:
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $t0, $a0, 16
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
        beqz              $t0, 0b
        b                 2f
1:
        move              $t0, $a6
        sc.q              $t0, $a7, $a1
        beqz              $t0, 0b
        move              $t0, $zero
2:
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $t0, $a0, 16
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
        beqz              $t0, 0b
        b                 2f
1:
        move              $t0, $a6
        sc.q              $t0, $a7, $a1
        beqz              $t0, 0b
        move              $t0, $zero
2:
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $t0, $a0, 16
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
        beqz              $t0, 0b
        b                 2f
1:
        move              $t0, $a6
        sc.q              $t0, $a7, $a1
        beqz              $t0, 0b
        move              $t0, $zero
2:
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $t0, $a0, 16
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
        beqz              $t0, 0b
        b                 2f
1:
        move              $t0, $a6
        sc.q              $t0, $a7, $a1
        beqz              $t0, 0b
        move              $t0, $zero
2:
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $t0, $a0, 16
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
        beqz              $t0, 0b
        b                 2f
1:
        move              $t0, $a6
        sc.q              $t0, $a7, $a1
        beqz              $t0, 0b
        move              $t0, $zero
2:
        st.d              $a7, $a0, 8
        st.d              $a6, $a0, 0
        st.b              $t0, $a0, 16
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
        move              $a3, $a2
        sc.q              $a3, $a1, $a0
        beqz              $a3, 0b
        move              $a0, $a2
        ret

asm_test::load::u128::acquire:
0:
        ll.d              $a2, $a0, 0
        dbar              20
        ld.d              $a1, $a0, 8
        move              $a3, $a2
        sc.q              $a3, $a1, $a0
        beqz              $a3, 0b
        move              $a0, $a2
        ret

asm_test::load::u128::relaxed:
0:
        ll.d              $a2, $a0, 0
        dbar              20
        ld.d              $a1, $a0, 8
        move              $a3, $a2
        sc.q              $a3, $a1, $a0
        beqz              $a3, 0b
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
0:
        ll.d              $a3, $a0, 0
        dbar              20
        ld.d              $a4, $a0, 8
        move              $a5, $a1
        sc.q              $a5, $a2, $a0
        beqz              $a5, 0b
        move              $a0, $a3
        move              $a1, $a4
        ret

asm_test::swap::u128::seqcst:
0:
        ll.d              $a3, $a0, 0
        dbar              20
        ld.d              $a4, $a0, 8
        move              $a5, $a1
        sc.q              $a5, $a2, $a0
        beqz              $a5, 0b
        move              $a0, $a3
        move              $a1, $a4
        ret

asm_test::swap::u128::acquire:
0:
        ll.d              $a3, $a0, 0
        dbar              20
        ld.d              $a4, $a0, 8
        move              $a5, $a1
        sc.q              $a5, $a2, $a0
        beqz              $a5, 0b
        move              $a0, $a3
        move              $a1, $a4
        ret

asm_test::swap::u128::relaxed:
0:
        ll.d              $a3, $a0, 0
        dbar              20
        ld.d              $a4, $a0, 8
        move              $a5, $a1
        sc.q              $a5, $a2, $a0
        beqz              $a5, 0b
        move              $a0, $a3
        move              $a1, $a4
        ret

asm_test::swap::u128::release:
0:
        ll.d              $a3, $a0, 0
        dbar              20
        ld.d              $a4, $a0, 8
        move              $a5, $a1
        sc.q              $a5, $a2, $a0
        beqz              $a5, 0b
        move              $a0, $a3
        move              $a1, $a4
        ret

asm_test::store::u8::seqcst:
        amswap_db.b       $zero, $a1, $a0
        ret

asm_test::store::u8::relaxed:
        st.b              $a1, $a0, 0
        ret

asm_test::store::u8::release:
        amswap_db.b       $zero, $a1, $a0
        ret

asm_test::store::u16::seqcst:
        amswap_db.h       $zero, $a1, $a0
        ret

asm_test::store::u16::relaxed:
        st.h              $a1, $a0, 0
        ret

asm_test::store::u16::release:
        amswap_db.h       $zero, $a1, $a0
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
0:
        ll.d              $a3, $a0, 0
        dbar              20
        ld.d              $a4, $a0, 8
        move              $a5, $a1
        sc.q              $a5, $a2, $a0
        beqz              $a5, 0b
        ret

asm_test::store::u128::relaxed:
0:
        ll.d              $a3, $a0, 0
        dbar              20
        ld.d              $a4, $a0, 8
        move              $a5, $a1
        sc.q              $a5, $a2, $a0
        beqz              $a5, 0b
        ret

asm_test::store::u128::release:
0:
        ll.d              $a3, $a0, 0
        dbar              20
        ld.d              $a4, $a0, 8
        move              $a5, $a1
        sc.q              $a5, $a2, $a0
        beqz              $a5, 0b
        ret
