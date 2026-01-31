asm_test::compare_exchange::u8::acqrel_seqcst:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        moveb             %sp@(19),%d1
        moveb             %sp@(15),%d2
        moveb             %d2,%d0
        casb              %d0,%d1,%a0@
        moveb             %d0,%d1
        subb              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange::u8::seqcst_seqcst:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        moveb             %sp@(19),%d1
        moveb             %sp@(15),%d2
        moveb             %d2,%d0
        casb              %d0,%d1,%a0@
        moveb             %d0,%d1
        subb              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange::u8::acqrel_acquire:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        moveb             %sp@(19),%d1
        moveb             %sp@(15),%d2
        moveb             %d2,%d0
        casb              %d0,%d1,%a0@
        moveb             %d0,%d1
        subb              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange::u8::acqrel_relaxed:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        moveb             %sp@(19),%d1
        moveb             %sp@(15),%d2
        moveb             %d2,%d0
        casb              %d0,%d1,%a0@
        moveb             %d0,%d1
        subb              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange::u8::acquire_seqcst:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        moveb             %sp@(19),%d1
        moveb             %sp@(15),%d2
        moveb             %d2,%d0
        casb              %d0,%d1,%a0@
        moveb             %d0,%d1
        subb              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange::u8::relaxed_seqcst:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        moveb             %sp@(19),%d1
        moveb             %sp@(15),%d2
        moveb             %d2,%d0
        casb              %d0,%d1,%a0@
        moveb             %d0,%d1
        subb              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange::u8::release_seqcst:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        moveb             %sp@(19),%d1
        moveb             %sp@(15),%d2
        moveb             %d2,%d0
        casb              %d0,%d1,%a0@
        moveb             %d0,%d1
        subb              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange::u8::seqcst_acquire:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        moveb             %sp@(19),%d1
        moveb             %sp@(15),%d2
        moveb             %d2,%d0
        casb              %d0,%d1,%a0@
        moveb             %d0,%d1
        subb              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange::u8::seqcst_relaxed:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        moveb             %sp@(19),%d1
        moveb             %sp@(15),%d2
        moveb             %d2,%d0
        casb              %d0,%d1,%a0@
        moveb             %d0,%d1
        subb              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange::u8::acquire_acquire:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        moveb             %sp@(19),%d1
        moveb             %sp@(15),%d2
        moveb             %d2,%d0
        casb              %d0,%d1,%a0@
        moveb             %d0,%d1
        subb              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange::u8::acquire_relaxed:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        moveb             %sp@(19),%d1
        moveb             %sp@(15),%d2
        moveb             %d2,%d0
        casb              %d0,%d1,%a0@
        moveb             %d0,%d1
        subb              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange::u8::relaxed_acquire:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        moveb             %sp@(19),%d1
        moveb             %sp@(15),%d2
        moveb             %d2,%d0
        casb              %d0,%d1,%a0@
        moveb             %d0,%d1
        subb              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange::u8::relaxed_relaxed:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        moveb             %sp@(19),%d1
        moveb             %sp@(15),%d2
        moveb             %d2,%d0
        casb              %d0,%d1,%a0@
        moveb             %d0,%d1
        subb              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange::u8::release_acquire:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        moveb             %sp@(19),%d1
        moveb             %sp@(15),%d2
        moveb             %d2,%d0
        casb              %d0,%d1,%a0@
        moveb             %d0,%d1
        subb              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange::u8::release_relaxed:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        moveb             %sp@(19),%d1
        moveb             %sp@(15),%d2
        moveb             %d2,%d0
        casb              %d0,%d1,%a0@
        moveb             %d0,%d1
        subb              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange::u16::acqrel_seqcst:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movew             %sp@(18),%d1
        movew             %sp@(14),%d2
        movew             %d2,%d0
        casw              %d0,%d1,%a0@
        movew             %d0,%d1
        subw              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange::u16::seqcst_seqcst:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movew             %sp@(18),%d1
        movew             %sp@(14),%d2
        movew             %d2,%d0
        casw              %d0,%d1,%a0@
        movew             %d0,%d1
        subw              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange::u16::acqrel_acquire:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movew             %sp@(18),%d1
        movew             %sp@(14),%d2
        movew             %d2,%d0
        casw              %d0,%d1,%a0@
        movew             %d0,%d1
        subw              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange::u16::acqrel_relaxed:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movew             %sp@(18),%d1
        movew             %sp@(14),%d2
        movew             %d2,%d0
        casw              %d0,%d1,%a0@
        movew             %d0,%d1
        subw              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange::u16::acquire_seqcst:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movew             %sp@(18),%d1
        movew             %sp@(14),%d2
        movew             %d2,%d0
        casw              %d0,%d1,%a0@
        movew             %d0,%d1
        subw              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange::u16::relaxed_seqcst:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movew             %sp@(18),%d1
        movew             %sp@(14),%d2
        movew             %d2,%d0
        casw              %d0,%d1,%a0@
        movew             %d0,%d1
        subw              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange::u16::release_seqcst:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movew             %sp@(18),%d1
        movew             %sp@(14),%d2
        movew             %d2,%d0
        casw              %d0,%d1,%a0@
        movew             %d0,%d1
        subw              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange::u16::seqcst_acquire:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movew             %sp@(18),%d1
        movew             %sp@(14),%d2
        movew             %d2,%d0
        casw              %d0,%d1,%a0@
        movew             %d0,%d1
        subw              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange::u16::seqcst_relaxed:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movew             %sp@(18),%d1
        movew             %sp@(14),%d2
        movew             %d2,%d0
        casw              %d0,%d1,%a0@
        movew             %d0,%d1
        subw              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange::u16::acquire_acquire:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movew             %sp@(18),%d1
        movew             %sp@(14),%d2
        movew             %d2,%d0
        casw              %d0,%d1,%a0@
        movew             %d0,%d1
        subw              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange::u16::acquire_relaxed:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movew             %sp@(18),%d1
        movew             %sp@(14),%d2
        movew             %d2,%d0
        casw              %d0,%d1,%a0@
        movew             %d0,%d1
        subw              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange::u16::relaxed_acquire:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movew             %sp@(18),%d1
        movew             %sp@(14),%d2
        movew             %d2,%d0
        casw              %d0,%d1,%a0@
        movew             %d0,%d1
        subw              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange::u16::relaxed_relaxed:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movew             %sp@(18),%d1
        movew             %sp@(14),%d2
        movew             %d2,%d0
        casw              %d0,%d1,%a0@
        movew             %d0,%d1
        subw              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange::u16::release_acquire:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movew             %sp@(18),%d1
        movew             %sp@(14),%d2
        movew             %d2,%d0
        casw              %d0,%d1,%a0@
        movew             %d0,%d1
        subw              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange::u16::release_relaxed:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movew             %sp@(18),%d1
        movew             %sp@(14),%d2
        movew             %d2,%d0
        casw              %d0,%d1,%a0@
        movew             %d0,%d1
        subw              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange::u32::acqrel_seqcst:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movel             %sp@(16),%d1
        movel             %sp@(12),%d2
        movel             %d2,%d0
        casl              %d0,%d1,%a0@
        movel             %d0,%d1
        subl              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange::u32::seqcst_seqcst:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movel             %sp@(16),%d1
        movel             %sp@(12),%d2
        movel             %d2,%d0
        casl              %d0,%d1,%a0@
        movel             %d0,%d1
        subl              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange::u32::acqrel_acquire:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movel             %sp@(16),%d1
        movel             %sp@(12),%d2
        movel             %d2,%d0
        casl              %d0,%d1,%a0@
        movel             %d0,%d1
        subl              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange::u32::acqrel_relaxed:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movel             %sp@(16),%d1
        movel             %sp@(12),%d2
        movel             %d2,%d0
        casl              %d0,%d1,%a0@
        movel             %d0,%d1
        subl              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange::u32::acquire_seqcst:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movel             %sp@(16),%d1
        movel             %sp@(12),%d2
        movel             %d2,%d0
        casl              %d0,%d1,%a0@
        movel             %d0,%d1
        subl              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange::u32::relaxed_seqcst:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movel             %sp@(16),%d1
        movel             %sp@(12),%d2
        movel             %d2,%d0
        casl              %d0,%d1,%a0@
        movel             %d0,%d1
        subl              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange::u32::release_seqcst:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movel             %sp@(16),%d1
        movel             %sp@(12),%d2
        movel             %d2,%d0
        casl              %d0,%d1,%a0@
        movel             %d0,%d1
        subl              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange::u32::seqcst_acquire:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movel             %sp@(16),%d1
        movel             %sp@(12),%d2
        movel             %d2,%d0
        casl              %d0,%d1,%a0@
        movel             %d0,%d1
        subl              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange::u32::seqcst_relaxed:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movel             %sp@(16),%d1
        movel             %sp@(12),%d2
        movel             %d2,%d0
        casl              %d0,%d1,%a0@
        movel             %d0,%d1
        subl              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange::u32::acquire_acquire:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movel             %sp@(16),%d1
        movel             %sp@(12),%d2
        movel             %d2,%d0
        casl              %d0,%d1,%a0@
        movel             %d0,%d1
        subl              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange::u32::acquire_relaxed:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movel             %sp@(16),%d1
        movel             %sp@(12),%d2
        movel             %d2,%d0
        casl              %d0,%d1,%a0@
        movel             %d0,%d1
        subl              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange::u32::relaxed_acquire:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movel             %sp@(16),%d1
        movel             %sp@(12),%d2
        movel             %d2,%d0
        casl              %d0,%d1,%a0@
        movel             %d0,%d1
        subl              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange::u32::relaxed_relaxed:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movel             %sp@(16),%d1
        movel             %sp@(12),%d2
        movel             %d2,%d0
        casl              %d0,%d1,%a0@
        movel             %d0,%d1
        subl              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange::u32::release_acquire:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movel             %sp@(16),%d1
        movel             %sp@(12),%d2
        movel             %d2,%d0
        casl              %d0,%d1,%a0@
        movel             %d0,%d1
        subl              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange::u32::release_relaxed:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movel             %sp@(16),%d1
        movel             %sp@(12),%d2
        movel             %d2,%d0
        casl              %d0,%d1,%a0@
        movel             %d0,%d1
        subl              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        moveb             %sp@(19),%d1
        moveb             %sp@(15),%d2
        moveb             %d2,%d0
        casb              %d0,%d1,%a0@
        moveb             %d0,%d1
        subb              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        moveb             %sp@(19),%d1
        moveb             %sp@(15),%d2
        moveb             %d2,%d0
        casb              %d0,%d1,%a0@
        moveb             %d0,%d1
        subb              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        moveb             %sp@(19),%d1
        moveb             %sp@(15),%d2
        moveb             %d2,%d0
        casb              %d0,%d1,%a0@
        moveb             %d0,%d1
        subb              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        moveb             %sp@(19),%d1
        moveb             %sp@(15),%d2
        moveb             %d2,%d0
        casb              %d0,%d1,%a0@
        moveb             %d0,%d1
        subb              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        moveb             %sp@(19),%d1
        moveb             %sp@(15),%d2
        moveb             %d2,%d0
        casb              %d0,%d1,%a0@
        moveb             %d0,%d1
        subb              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        moveb             %sp@(19),%d1
        moveb             %sp@(15),%d2
        moveb             %d2,%d0
        casb              %d0,%d1,%a0@
        moveb             %d0,%d1
        subb              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u8::release_seqcst:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        moveb             %sp@(19),%d1
        moveb             %sp@(15),%d2
        moveb             %d2,%d0
        casb              %d0,%d1,%a0@
        moveb             %d0,%d1
        subb              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        moveb             %sp@(19),%d1
        moveb             %sp@(15),%d2
        moveb             %d2,%d0
        casb              %d0,%d1,%a0@
        moveb             %d0,%d1
        subb              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        moveb             %sp@(19),%d1
        moveb             %sp@(15),%d2
        moveb             %d2,%d0
        casb              %d0,%d1,%a0@
        moveb             %d0,%d1
        subb              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u8::acquire_acquire:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        moveb             %sp@(19),%d1
        moveb             %sp@(15),%d2
        moveb             %d2,%d0
        casb              %d0,%d1,%a0@
        moveb             %d0,%d1
        subb              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        moveb             %sp@(19),%d1
        moveb             %sp@(15),%d2
        moveb             %d2,%d0
        casb              %d0,%d1,%a0@
        moveb             %d0,%d1
        subb              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        moveb             %sp@(19),%d1
        moveb             %sp@(15),%d2
        moveb             %d2,%d0
        casb              %d0,%d1,%a0@
        moveb             %d0,%d1
        subb              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        moveb             %sp@(19),%d1
        moveb             %sp@(15),%d2
        moveb             %d2,%d0
        casb              %d0,%d1,%a0@
        moveb             %d0,%d1
        subb              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u8::release_acquire:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        moveb             %sp@(19),%d1
        moveb             %sp@(15),%d2
        moveb             %d2,%d0
        casb              %d0,%d1,%a0@
        moveb             %d0,%d1
        subb              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u8::release_relaxed:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        moveb             %sp@(19),%d1
        moveb             %sp@(15),%d2
        moveb             %d2,%d0
        casb              %d0,%d1,%a0@
        moveb             %d0,%d1
        subb              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movew             %sp@(18),%d1
        movew             %sp@(14),%d2
        movew             %d2,%d0
        casw              %d0,%d1,%a0@
        movew             %d0,%d1
        subw              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movew             %sp@(18),%d1
        movew             %sp@(14),%d2
        movew             %d2,%d0
        casw              %d0,%d1,%a0@
        movew             %d0,%d1
        subw              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movew             %sp@(18),%d1
        movew             %sp@(14),%d2
        movew             %d2,%d0
        casw              %d0,%d1,%a0@
        movew             %d0,%d1
        subw              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movew             %sp@(18),%d1
        movew             %sp@(14),%d2
        movew             %d2,%d0
        casw              %d0,%d1,%a0@
        movew             %d0,%d1
        subw              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movew             %sp@(18),%d1
        movew             %sp@(14),%d2
        movew             %d2,%d0
        casw              %d0,%d1,%a0@
        movew             %d0,%d1
        subw              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movew             %sp@(18),%d1
        movew             %sp@(14),%d2
        movew             %d2,%d0
        casw              %d0,%d1,%a0@
        movew             %d0,%d1
        subw              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u16::release_seqcst:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movew             %sp@(18),%d1
        movew             %sp@(14),%d2
        movew             %d2,%d0
        casw              %d0,%d1,%a0@
        movew             %d0,%d1
        subw              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movew             %sp@(18),%d1
        movew             %sp@(14),%d2
        movew             %d2,%d0
        casw              %d0,%d1,%a0@
        movew             %d0,%d1
        subw              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movew             %sp@(18),%d1
        movew             %sp@(14),%d2
        movew             %d2,%d0
        casw              %d0,%d1,%a0@
        movew             %d0,%d1
        subw              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u16::acquire_acquire:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movew             %sp@(18),%d1
        movew             %sp@(14),%d2
        movew             %d2,%d0
        casw              %d0,%d1,%a0@
        movew             %d0,%d1
        subw              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movew             %sp@(18),%d1
        movew             %sp@(14),%d2
        movew             %d2,%d0
        casw              %d0,%d1,%a0@
        movew             %d0,%d1
        subw              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movew             %sp@(18),%d1
        movew             %sp@(14),%d2
        movew             %d2,%d0
        casw              %d0,%d1,%a0@
        movew             %d0,%d1
        subw              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movew             %sp@(18),%d1
        movew             %sp@(14),%d2
        movew             %d2,%d0
        casw              %d0,%d1,%a0@
        movew             %d0,%d1
        subw              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u16::release_acquire:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movew             %sp@(18),%d1
        movew             %sp@(14),%d2
        movew             %d2,%d0
        casw              %d0,%d1,%a0@
        movew             %d0,%d1
        subw              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u16::release_relaxed:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movew             %sp@(18),%d1
        movew             %sp@(14),%d2
        movew             %d2,%d0
        casw              %d0,%d1,%a0@
        movew             %d0,%d1
        subw              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movel             %sp@(16),%d1
        movel             %sp@(12),%d2
        movel             %d2,%d0
        casl              %d0,%d1,%a0@
        movel             %d0,%d1
        subl              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movel             %sp@(16),%d1
        movel             %sp@(12),%d2
        movel             %d2,%d0
        casl              %d0,%d1,%a0@
        movel             %d0,%d1
        subl              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movel             %sp@(16),%d1
        movel             %sp@(12),%d2
        movel             %d2,%d0
        casl              %d0,%d1,%a0@
        movel             %d0,%d1
        subl              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movel             %sp@(16),%d1
        movel             %sp@(12),%d2
        movel             %d2,%d0
        casl              %d0,%d1,%a0@
        movel             %d0,%d1
        subl              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movel             %sp@(16),%d1
        movel             %sp@(12),%d2
        movel             %d2,%d0
        casl              %d0,%d1,%a0@
        movel             %d0,%d1
        subl              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movel             %sp@(16),%d1
        movel             %sp@(12),%d2
        movel             %d2,%d0
        casl              %d0,%d1,%a0@
        movel             %d0,%d1
        subl              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u32::release_seqcst:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movel             %sp@(16),%d1
        movel             %sp@(12),%d2
        movel             %d2,%d0
        casl              %d0,%d1,%a0@
        movel             %d0,%d1
        subl              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movel             %sp@(16),%d1
        movel             %sp@(12),%d2
        movel             %d2,%d0
        casl              %d0,%d1,%a0@
        movel             %d0,%d1
        subl              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movel             %sp@(16),%d1
        movel             %sp@(12),%d2
        movel             %d2,%d0
        casl              %d0,%d1,%a0@
        movel             %d0,%d1
        subl              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u32::acquire_acquire:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movel             %sp@(16),%d1
        movel             %sp@(12),%d2
        movel             %d2,%d0
        casl              %d0,%d1,%a0@
        movel             %d0,%d1
        subl              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movel             %sp@(16),%d1
        movel             %sp@(12),%d2
        movel             %d2,%d0
        casl              %d0,%d1,%a0@
        movel             %d0,%d1
        subl              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movel             %sp@(16),%d1
        movel             %sp@(12),%d2
        movel             %d2,%d0
        casl              %d0,%d1,%a0@
        movel             %d0,%d1
        subl              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movel             %sp@(16),%d1
        movel             %sp@(12),%d2
        movel             %d2,%d0
        casl              %d0,%d1,%a0@
        movel             %d0,%d1
        subl              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u32::release_acquire:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movel             %sp@(16),%d1
        movel             %sp@(12),%d2
        movel             %d2,%d0
        casl              %d0,%d1,%a0@
        movel             %d0,%d1
        subl              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::compare_exchange_weak::u32::release_relaxed:
        subal             #4,%sp
        moveml            %d2,%sp@(0)
        moveal            %sp@(8),%a0
        movel             %sp@(16),%d1
        movel             %sp@(12),%d2
        movel             %d2,%d0
        casl              %d0,%d1,%a0@
        movel             %d0,%d1
        subl              %d2,%d1
        seq               %d1
        moveml            %sp@(0),%d2
        addal             #4,%sp
        rts

asm_test::load::u8::seqcst:
        moveal            %sp@(4),%a0
        moveb             %a0@,%d0
        rts

asm_test::load::u8::acquire:
        moveal            %sp@(4),%a0
        moveb             %a0@,%d0
        rts

asm_test::load::u8::relaxed:
        moveal            %sp@(4),%a0
        moveb             %a0@,%d0
        rts

asm_test::load::u16::seqcst:
        moveal            %sp@(4),%a0
        movew             %a0@,%d0
        rts

asm_test::load::u16::acquire:
        moveal            %sp@(4),%a0
        movew             %a0@,%d0
        rts

asm_test::load::u16::relaxed:
        moveal            %sp@(4),%a0
        movew             %a0@,%d0
        rts

asm_test::load::u32::seqcst:
        moveal            %sp@(4),%a0
        movel             %a0@,%d0
        rts

asm_test::load::u32::acquire:
        moveal            %sp@(4),%a0
        movel             %a0@,%d0
        rts

asm_test::load::u32::relaxed:
        moveal            %sp@(4),%a0
        movel             %a0@,%d0
        rts

asm_test::swap::u8::acqrel:
        subal             #8,%sp
        moveml            %d2-%d3,%sp@(0)
        moveb             %sp@(19),%d1
        moveal            %sp@(12),%a0
        moveb             %a0@,%d2
        moveb             %d2,%d0
0:
        casb              %d0,%d1,%a0@
        moveb             %d0,%d3
        subb              %d2,%d3
        seq               %d2
        andb              #1,%d2
        cmpib             #0,%d2
        moveb             %d0,%d2
        beqs              0b
        moveml            %sp@(0),%d2-%d3
        addal             #8,%sp
        rts

asm_test::swap::u8::seqcst:
        subal             #8,%sp
        moveml            %d2-%d3,%sp@(0)
        moveb             %sp@(19),%d1
        moveal            %sp@(12),%a0
        moveb             %a0@,%d2
        moveb             %d2,%d0
0:
        casb              %d0,%d1,%a0@
        moveb             %d0,%d3
        subb              %d2,%d3
        seq               %d2
        andb              #1,%d2
        cmpib             #0,%d2
        moveb             %d0,%d2
        beqs              0b
        moveml            %sp@(0),%d2-%d3
        addal             #8,%sp
        rts

asm_test::swap::u8::acquire:
        subal             #8,%sp
        moveml            %d2-%d3,%sp@(0)
        moveb             %sp@(19),%d1
        moveal            %sp@(12),%a0
        moveb             %a0@,%d2
        moveb             %d2,%d0
0:
        casb              %d0,%d1,%a0@
        moveb             %d0,%d3
        subb              %d2,%d3
        seq               %d2
        andb              #1,%d2
        cmpib             #0,%d2
        moveb             %d0,%d2
        beqs              0b
        moveml            %sp@(0),%d2-%d3
        addal             #8,%sp
        rts

asm_test::swap::u8::relaxed:
        subal             #8,%sp
        moveml            %d2-%d3,%sp@(0)
        moveb             %sp@(19),%d1
        moveal            %sp@(12),%a0
        moveb             %a0@,%d2
        moveb             %d2,%d0
0:
        casb              %d0,%d1,%a0@
        moveb             %d0,%d3
        subb              %d2,%d3
        seq               %d2
        andb              #1,%d2
        cmpib             #0,%d2
        moveb             %d0,%d2
        beqs              0b
        moveml            %sp@(0),%d2-%d3
        addal             #8,%sp
        rts

asm_test::swap::u8::release:
        subal             #8,%sp
        moveml            %d2-%d3,%sp@(0)
        moveb             %sp@(19),%d1
        moveal            %sp@(12),%a0
        moveb             %a0@,%d2
        moveb             %d2,%d0
0:
        casb              %d0,%d1,%a0@
        moveb             %d0,%d3
        subb              %d2,%d3
        seq               %d2
        andb              #1,%d2
        cmpib             #0,%d2
        moveb             %d0,%d2
        beqs              0b
        moveml            %sp@(0),%d2-%d3
        addal             #8,%sp
        rts

asm_test::swap::u16::acqrel:
        subal             #8,%sp
        moveml            %d2-%d3,%sp@(0)
        movew             %sp@(18),%d1
        moveal            %sp@(12),%a0
        movew             %a0@,%d2
        movew             %d2,%d0
0:
        casw              %d0,%d1,%a0@
        movew             %d0,%d3
        subw              %d2,%d3
        seq               %d2
        andb              #1,%d2
        cmpib             #0,%d2
        movew             %d0,%d2
        beqs              0b
        moveml            %sp@(0),%d2-%d3
        addal             #8,%sp
        rts

asm_test::swap::u16::seqcst:
        subal             #8,%sp
        moveml            %d2-%d3,%sp@(0)
        movew             %sp@(18),%d1
        moveal            %sp@(12),%a0
        movew             %a0@,%d2
        movew             %d2,%d0
0:
        casw              %d0,%d1,%a0@
        movew             %d0,%d3
        subw              %d2,%d3
        seq               %d2
        andb              #1,%d2
        cmpib             #0,%d2
        movew             %d0,%d2
        beqs              0b
        moveml            %sp@(0),%d2-%d3
        addal             #8,%sp
        rts

asm_test::swap::u16::acquire:
        subal             #8,%sp
        moveml            %d2-%d3,%sp@(0)
        movew             %sp@(18),%d1
        moveal            %sp@(12),%a0
        movew             %a0@,%d2
        movew             %d2,%d0
0:
        casw              %d0,%d1,%a0@
        movew             %d0,%d3
        subw              %d2,%d3
        seq               %d2
        andb              #1,%d2
        cmpib             #0,%d2
        movew             %d0,%d2
        beqs              0b
        moveml            %sp@(0),%d2-%d3
        addal             #8,%sp
        rts

asm_test::swap::u16::relaxed:
        subal             #8,%sp
        moveml            %d2-%d3,%sp@(0)
        movew             %sp@(18),%d1
        moveal            %sp@(12),%a0
        movew             %a0@,%d2
        movew             %d2,%d0
0:
        casw              %d0,%d1,%a0@
        movew             %d0,%d3
        subw              %d2,%d3
        seq               %d2
        andb              #1,%d2
        cmpib             #0,%d2
        movew             %d0,%d2
        beqs              0b
        moveml            %sp@(0),%d2-%d3
        addal             #8,%sp
        rts

asm_test::swap::u16::release:
        subal             #8,%sp
        moveml            %d2-%d3,%sp@(0)
        movew             %sp@(18),%d1
        moveal            %sp@(12),%a0
        movew             %a0@,%d2
        movew             %d2,%d0
0:
        casw              %d0,%d1,%a0@
        movew             %d0,%d3
        subw              %d2,%d3
        seq               %d2
        andb              #1,%d2
        cmpib             #0,%d2
        movew             %d0,%d2
        beqs              0b
        moveml            %sp@(0),%d2-%d3
        addal             #8,%sp
        rts

asm_test::swap::u32::acqrel:
        subal             #8,%sp
        moveml            %d2-%d3,%sp@(0)
        movel             %sp@(16),%d1
        moveal            %sp@(12),%a0
        movel             %a0@,%d2
        movel             %d2,%d0
0:
        casl              %d0,%d1,%a0@
        movel             %d0,%d3
        subl              %d2,%d3
        seq               %d2
        andb              #1,%d2
        cmpib             #0,%d2
        movel             %d0,%d2
        beqs              0b
        moveml            %sp@(0),%d2-%d3
        addal             #8,%sp
        rts

asm_test::swap::u32::seqcst:
        subal             #8,%sp
        moveml            %d2-%d3,%sp@(0)
        movel             %sp@(16),%d1
        moveal            %sp@(12),%a0
        movel             %a0@,%d2
        movel             %d2,%d0
0:
        casl              %d0,%d1,%a0@
        movel             %d0,%d3
        subl              %d2,%d3
        seq               %d2
        andb              #1,%d2
        cmpib             #0,%d2
        movel             %d0,%d2
        beqs              0b
        moveml            %sp@(0),%d2-%d3
        addal             #8,%sp
        rts

asm_test::swap::u32::acquire:
        subal             #8,%sp
        moveml            %d2-%d3,%sp@(0)
        movel             %sp@(16),%d1
        moveal            %sp@(12),%a0
        movel             %a0@,%d2
        movel             %d2,%d0
0:
        casl              %d0,%d1,%a0@
        movel             %d0,%d3
        subl              %d2,%d3
        seq               %d2
        andb              #1,%d2
        cmpib             #0,%d2
        movel             %d0,%d2
        beqs              0b
        moveml            %sp@(0),%d2-%d3
        addal             #8,%sp
        rts

asm_test::swap::u32::relaxed:
        subal             #8,%sp
        moveml            %d2-%d3,%sp@(0)
        movel             %sp@(16),%d1
        moveal            %sp@(12),%a0
        movel             %a0@,%d2
        movel             %d2,%d0
0:
        casl              %d0,%d1,%a0@
        movel             %d0,%d3
        subl              %d2,%d3
        seq               %d2
        andb              #1,%d2
        cmpib             #0,%d2
        movel             %d0,%d2
        beqs              0b
        moveml            %sp@(0),%d2-%d3
        addal             #8,%sp
        rts

asm_test::swap::u32::release:
        subal             #8,%sp
        moveml            %d2-%d3,%sp@(0)
        movel             %sp@(16),%d1
        moveal            %sp@(12),%a0
        movel             %a0@,%d2
        movel             %d2,%d0
0:
        casl              %d0,%d1,%a0@
        movel             %d0,%d3
        subl              %d2,%d3
        seq               %d2
        andb              #1,%d2
        cmpib             #0,%d2
        movel             %d0,%d2
        beqs              0b
        moveml            %sp@(0),%d2-%d3
        addal             #8,%sp
        rts

asm_test::store::u8::seqcst:
        moveb             %sp@(11),%d0
        moveal            %sp@(4),%a0
        moveb             %d0,%a0@
        rts

asm_test::store::u8::relaxed:
        moveb             %sp@(11),%d0
        moveal            %sp@(4),%a0
        moveb             %d0,%a0@
        rts

asm_test::store::u8::release:
        moveb             %sp@(11),%d0
        moveal            %sp@(4),%a0
        moveb             %d0,%a0@
        rts

asm_test::store::u16::seqcst:
        movew             %sp@(10),%d0
        moveal            %sp@(4),%a0
        movew             %d0,%a0@
        rts

asm_test::store::u16::relaxed:
        movew             %sp@(10),%d0
        moveal            %sp@(4),%a0
        movew             %d0,%a0@
        rts

asm_test::store::u16::release:
        movew             %sp@(10),%d0
        moveal            %sp@(4),%a0
        movew             %d0,%a0@
        rts

asm_test::store::u32::seqcst:
        movel             %sp@(8),%d0
        moveal            %sp@(4),%a0
        movel             %d0,%a0@
        rts

asm_test::store::u32::relaxed:
        movel             %sp@(8),%d0
        moveal            %sp@(4),%a0
        movel             %d0,%a0@
        rts

asm_test::store::u32::release:
        movel             %sp@(8),%d0
        moveal            %sp@(4),%a0
        movel             %d0,%a0@
        rts

