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
