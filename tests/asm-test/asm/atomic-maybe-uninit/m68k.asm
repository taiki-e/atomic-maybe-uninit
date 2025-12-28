asm_test::compare_exchange::u8::acqrel_seqcst:
        moveal            %sp@(4),%a0
        moveb             %sp@(15),%d1
        moveb             %sp@(11),%d0
        casb              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u8::seqcst_seqcst:
        moveal            %sp@(4),%a0
        moveb             %sp@(15),%d1
        moveb             %sp@(11),%d0
        casb              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u8::acqrel_acquire:
        moveal            %sp@(4),%a0
        moveb             %sp@(15),%d1
        moveb             %sp@(11),%d0
        casb              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u8::acqrel_relaxed:
        moveal            %sp@(4),%a0
        moveb             %sp@(15),%d1
        moveb             %sp@(11),%d0
        casb              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u8::acquire_seqcst:
        moveal            %sp@(4),%a0
        moveb             %sp@(15),%d1
        moveb             %sp@(11),%d0
        casb              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u8::relaxed_seqcst:
        moveal            %sp@(4),%a0
        moveb             %sp@(15),%d1
        moveb             %sp@(11),%d0
        casb              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u8::release_seqcst:
        moveal            %sp@(4),%a0
        moveb             %sp@(15),%d1
        moveb             %sp@(11),%d0
        casb              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u8::seqcst_acquire:
        moveal            %sp@(4),%a0
        moveb             %sp@(15),%d1
        moveb             %sp@(11),%d0
        casb              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u8::seqcst_relaxed:
        moveal            %sp@(4),%a0
        moveb             %sp@(15),%d1
        moveb             %sp@(11),%d0
        casb              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u8::acquire_acquire:
        moveal            %sp@(4),%a0
        moveb             %sp@(15),%d1
        moveb             %sp@(11),%d0
        casb              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u8::acquire_relaxed:
        moveal            %sp@(4),%a0
        moveb             %sp@(15),%d1
        moveb             %sp@(11),%d0
        casb              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u8::relaxed_acquire:
        moveal            %sp@(4),%a0
        moveb             %sp@(15),%d1
        moveb             %sp@(11),%d0
        casb              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u8::relaxed_relaxed:
        moveal            %sp@(4),%a0
        moveb             %sp@(15),%d1
        moveb             %sp@(11),%d0
        casb              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u8::release_acquire:
        moveal            %sp@(4),%a0
        moveb             %sp@(15),%d1
        moveb             %sp@(11),%d0
        casb              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u8::release_relaxed:
        moveal            %sp@(4),%a0
        moveb             %sp@(15),%d1
        moveb             %sp@(11),%d0
        casb              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u16::acqrel_seqcst:
        moveal            %sp@(4),%a0
        movew             %sp@(14),%d1
        movew             %sp@(10),%d0
        casw              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u16::seqcst_seqcst:
        moveal            %sp@(4),%a0
        movew             %sp@(14),%d1
        movew             %sp@(10),%d0
        casw              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u16::acqrel_acquire:
        moveal            %sp@(4),%a0
        movew             %sp@(14),%d1
        movew             %sp@(10),%d0
        casw              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u16::acqrel_relaxed:
        moveal            %sp@(4),%a0
        movew             %sp@(14),%d1
        movew             %sp@(10),%d0
        casw              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u16::acquire_seqcst:
        moveal            %sp@(4),%a0
        movew             %sp@(14),%d1
        movew             %sp@(10),%d0
        casw              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u16::relaxed_seqcst:
        moveal            %sp@(4),%a0
        movew             %sp@(14),%d1
        movew             %sp@(10),%d0
        casw              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u16::release_seqcst:
        moveal            %sp@(4),%a0
        movew             %sp@(14),%d1
        movew             %sp@(10),%d0
        casw              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u16::seqcst_acquire:
        moveal            %sp@(4),%a0
        movew             %sp@(14),%d1
        movew             %sp@(10),%d0
        casw              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u16::seqcst_relaxed:
        moveal            %sp@(4),%a0
        movew             %sp@(14),%d1
        movew             %sp@(10),%d0
        casw              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u16::acquire_acquire:
        moveal            %sp@(4),%a0
        movew             %sp@(14),%d1
        movew             %sp@(10),%d0
        casw              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u16::acquire_relaxed:
        moveal            %sp@(4),%a0
        movew             %sp@(14),%d1
        movew             %sp@(10),%d0
        casw              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u16::relaxed_acquire:
        moveal            %sp@(4),%a0
        movew             %sp@(14),%d1
        movew             %sp@(10),%d0
        casw              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u16::relaxed_relaxed:
        moveal            %sp@(4),%a0
        movew             %sp@(14),%d1
        movew             %sp@(10),%d0
        casw              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u16::release_acquire:
        moveal            %sp@(4),%a0
        movew             %sp@(14),%d1
        movew             %sp@(10),%d0
        casw              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u16::release_relaxed:
        moveal            %sp@(4),%a0
        movew             %sp@(14),%d1
        movew             %sp@(10),%d0
        casw              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u32::acqrel_seqcst:
        moveal            %sp@(4),%a0
        movel             %sp@(12),%d1
        movel             %sp@(8),%d0
        casl              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u32::seqcst_seqcst:
        moveal            %sp@(4),%a0
        movel             %sp@(12),%d1
        movel             %sp@(8),%d0
        casl              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u32::acqrel_acquire:
        moveal            %sp@(4),%a0
        movel             %sp@(12),%d1
        movel             %sp@(8),%d0
        casl              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u32::acqrel_relaxed:
        moveal            %sp@(4),%a0
        movel             %sp@(12),%d1
        movel             %sp@(8),%d0
        casl              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u32::acquire_seqcst:
        moveal            %sp@(4),%a0
        movel             %sp@(12),%d1
        movel             %sp@(8),%d0
        casl              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u32::relaxed_seqcst:
        moveal            %sp@(4),%a0
        movel             %sp@(12),%d1
        movel             %sp@(8),%d0
        casl              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u32::release_seqcst:
        moveal            %sp@(4),%a0
        movel             %sp@(12),%d1
        movel             %sp@(8),%d0
        casl              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u32::seqcst_acquire:
        moveal            %sp@(4),%a0
        movel             %sp@(12),%d1
        movel             %sp@(8),%d0
        casl              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u32::seqcst_relaxed:
        moveal            %sp@(4),%a0
        movel             %sp@(12),%d1
        movel             %sp@(8),%d0
        casl              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u32::acquire_acquire:
        moveal            %sp@(4),%a0
        movel             %sp@(12),%d1
        movel             %sp@(8),%d0
        casl              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u32::acquire_relaxed:
        moveal            %sp@(4),%a0
        movel             %sp@(12),%d1
        movel             %sp@(8),%d0
        casl              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u32::relaxed_acquire:
        moveal            %sp@(4),%a0
        movel             %sp@(12),%d1
        movel             %sp@(8),%d0
        casl              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u32::relaxed_relaxed:
        moveal            %sp@(4),%a0
        movel             %sp@(12),%d1
        movel             %sp@(8),%d0
        casl              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u32::release_acquire:
        moveal            %sp@(4),%a0
        movel             %sp@(12),%d1
        movel             %sp@(8),%d0
        casl              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u32::release_relaxed:
        moveal            %sp@(4),%a0
        movel             %sp@(12),%d1
        movel             %sp@(8),%d0
        casl              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange::u64::acqrel_seqcst:
        subal             #20,%sp
        moveml            %d2-%d5/%a2,%sp@(0)
        moveal            %sp@(24),%a2
        movel             %sp@(28),%d4
        movel             %d4,%d5
        addl              #4,%d5
        movel             %sp@(40),%d2
        movel             %sp@(44),%d3
        movel             %sp@(32),%d1
        movel             %sp@(36),%d0
        moveal            %d4,%a0
        moveal            %d5,%a1
        cas2l             %d1,%d0,%d2,%d3,%a0@,%a1@
        seq               %d2
        movel             %d0,%a2@(4)
        movel             %d1,%a2@
        cmpib             #0,%d2
        sne               %a2@(8)
        movel             %a2,%d0
        moveml            %sp@(0),%d2-%d5/%a2
        addal             #20,%sp
        moveal            %sp@,%a1
        addal             #4,%sp
        movel             %a1,%sp@
        rts

asm_test::compare_exchange::u64::seqcst_seqcst:
        subal             #20,%sp
        moveml            %d2-%d5/%a2,%sp@(0)
        moveal            %sp@(24),%a2
        movel             %sp@(28),%d4
        movel             %d4,%d5
        addl              #4,%d5
        movel             %sp@(40),%d2
        movel             %sp@(44),%d3
        movel             %sp@(32),%d1
        movel             %sp@(36),%d0
        moveal            %d4,%a0
        moveal            %d5,%a1
        cas2l             %d1,%d0,%d2,%d3,%a0@,%a1@
        seq               %d2
        movel             %d0,%a2@(4)
        movel             %d1,%a2@
        cmpib             #0,%d2
        sne               %a2@(8)
        movel             %a2,%d0
        moveml            %sp@(0),%d2-%d5/%a2
        addal             #20,%sp
        moveal            %sp@,%a1
        addal             #4,%sp
        movel             %a1,%sp@
        rts

asm_test::compare_exchange::u64::acqrel_acquire:
        subal             #20,%sp
        moveml            %d2-%d5/%a2,%sp@(0)
        moveal            %sp@(24),%a2
        movel             %sp@(28),%d4
        movel             %d4,%d5
        addl              #4,%d5
        movel             %sp@(40),%d2
        movel             %sp@(44),%d3
        movel             %sp@(32),%d1
        movel             %sp@(36),%d0
        moveal            %d4,%a0
        moveal            %d5,%a1
        cas2l             %d1,%d0,%d2,%d3,%a0@,%a1@
        seq               %d2
        movel             %d0,%a2@(4)
        movel             %d1,%a2@
        cmpib             #0,%d2
        sne               %a2@(8)
        movel             %a2,%d0
        moveml            %sp@(0),%d2-%d5/%a2
        addal             #20,%sp
        moveal            %sp@,%a1
        addal             #4,%sp
        movel             %a1,%sp@
        rts

asm_test::compare_exchange::u64::acqrel_relaxed:
        subal             #20,%sp
        moveml            %d2-%d5/%a2,%sp@(0)
        moveal            %sp@(24),%a2
        movel             %sp@(28),%d4
        movel             %d4,%d5
        addl              #4,%d5
        movel             %sp@(40),%d2
        movel             %sp@(44),%d3
        movel             %sp@(32),%d1
        movel             %sp@(36),%d0
        moveal            %d4,%a0
        moveal            %d5,%a1
        cas2l             %d1,%d0,%d2,%d3,%a0@,%a1@
        seq               %d2
        movel             %d0,%a2@(4)
        movel             %d1,%a2@
        cmpib             #0,%d2
        sne               %a2@(8)
        movel             %a2,%d0
        moveml            %sp@(0),%d2-%d5/%a2
        addal             #20,%sp
        moveal            %sp@,%a1
        addal             #4,%sp
        movel             %a1,%sp@
        rts

asm_test::compare_exchange::u64::acquire_seqcst:
        subal             #20,%sp
        moveml            %d2-%d5/%a2,%sp@(0)
        moveal            %sp@(24),%a2
        movel             %sp@(28),%d4
        movel             %d4,%d5
        addl              #4,%d5
        movel             %sp@(40),%d2
        movel             %sp@(44),%d3
        movel             %sp@(32),%d1
        movel             %sp@(36),%d0
        moveal            %d4,%a0
        moveal            %d5,%a1
        cas2l             %d1,%d0,%d2,%d3,%a0@,%a1@
        seq               %d2
        movel             %d0,%a2@(4)
        movel             %d1,%a2@
        cmpib             #0,%d2
        sne               %a2@(8)
        movel             %a2,%d0
        moveml            %sp@(0),%d2-%d5/%a2
        addal             #20,%sp
        moveal            %sp@,%a1
        addal             #4,%sp
        movel             %a1,%sp@
        rts

asm_test::compare_exchange::u64::relaxed_seqcst:
        subal             #20,%sp
        moveml            %d2-%d5/%a2,%sp@(0)
        moveal            %sp@(24),%a2
        movel             %sp@(28),%d4
        movel             %d4,%d5
        addl              #4,%d5
        movel             %sp@(40),%d2
        movel             %sp@(44),%d3
        movel             %sp@(32),%d1
        movel             %sp@(36),%d0
        moveal            %d4,%a0
        moveal            %d5,%a1
        cas2l             %d1,%d0,%d2,%d3,%a0@,%a1@
        seq               %d2
        movel             %d0,%a2@(4)
        movel             %d1,%a2@
        cmpib             #0,%d2
        sne               %a2@(8)
        movel             %a2,%d0
        moveml            %sp@(0),%d2-%d5/%a2
        addal             #20,%sp
        moveal            %sp@,%a1
        addal             #4,%sp
        movel             %a1,%sp@
        rts

asm_test::compare_exchange::u64::release_seqcst:
        subal             #20,%sp
        moveml            %d2-%d5/%a2,%sp@(0)
        moveal            %sp@(24),%a2
        movel             %sp@(28),%d4
        movel             %d4,%d5
        addl              #4,%d5
        movel             %sp@(40),%d2
        movel             %sp@(44),%d3
        movel             %sp@(32),%d1
        movel             %sp@(36),%d0
        moveal            %d4,%a0
        moveal            %d5,%a1
        cas2l             %d1,%d0,%d2,%d3,%a0@,%a1@
        seq               %d2
        movel             %d0,%a2@(4)
        movel             %d1,%a2@
        cmpib             #0,%d2
        sne               %a2@(8)
        movel             %a2,%d0
        moveml            %sp@(0),%d2-%d5/%a2
        addal             #20,%sp
        moveal            %sp@,%a1
        addal             #4,%sp
        movel             %a1,%sp@
        rts

asm_test::compare_exchange::u64::seqcst_acquire:
        subal             #20,%sp
        moveml            %d2-%d5/%a2,%sp@(0)
        moveal            %sp@(24),%a2
        movel             %sp@(28),%d4
        movel             %d4,%d5
        addl              #4,%d5
        movel             %sp@(40),%d2
        movel             %sp@(44),%d3
        movel             %sp@(32),%d1
        movel             %sp@(36),%d0
        moveal            %d4,%a0
        moveal            %d5,%a1
        cas2l             %d1,%d0,%d2,%d3,%a0@,%a1@
        seq               %d2
        movel             %d0,%a2@(4)
        movel             %d1,%a2@
        cmpib             #0,%d2
        sne               %a2@(8)
        movel             %a2,%d0
        moveml            %sp@(0),%d2-%d5/%a2
        addal             #20,%sp
        moveal            %sp@,%a1
        addal             #4,%sp
        movel             %a1,%sp@
        rts

asm_test::compare_exchange::u64::seqcst_relaxed:
        subal             #20,%sp
        moveml            %d2-%d5/%a2,%sp@(0)
        moveal            %sp@(24),%a2
        movel             %sp@(28),%d4
        movel             %d4,%d5
        addl              #4,%d5
        movel             %sp@(40),%d2
        movel             %sp@(44),%d3
        movel             %sp@(32),%d1
        movel             %sp@(36),%d0
        moveal            %d4,%a0
        moveal            %d5,%a1
        cas2l             %d1,%d0,%d2,%d3,%a0@,%a1@
        seq               %d2
        movel             %d0,%a2@(4)
        movel             %d1,%a2@
        cmpib             #0,%d2
        sne               %a2@(8)
        movel             %a2,%d0
        moveml            %sp@(0),%d2-%d5/%a2
        addal             #20,%sp
        moveal            %sp@,%a1
        addal             #4,%sp
        movel             %a1,%sp@
        rts

asm_test::compare_exchange::u64::acquire_acquire:
        subal             #20,%sp
        moveml            %d2-%d5/%a2,%sp@(0)
        moveal            %sp@(24),%a2
        movel             %sp@(28),%d4
        movel             %d4,%d5
        addl              #4,%d5
        movel             %sp@(40),%d2
        movel             %sp@(44),%d3
        movel             %sp@(32),%d1
        movel             %sp@(36),%d0
        moveal            %d4,%a0
        moveal            %d5,%a1
        cas2l             %d1,%d0,%d2,%d3,%a0@,%a1@
        seq               %d2
        movel             %d0,%a2@(4)
        movel             %d1,%a2@
        cmpib             #0,%d2
        sne               %a2@(8)
        movel             %a2,%d0
        moveml            %sp@(0),%d2-%d5/%a2
        addal             #20,%sp
        moveal            %sp@,%a1
        addal             #4,%sp
        movel             %a1,%sp@
        rts

asm_test::compare_exchange::u64::acquire_relaxed:
        subal             #20,%sp
        moveml            %d2-%d5/%a2,%sp@(0)
        moveal            %sp@(24),%a2
        movel             %sp@(28),%d4
        movel             %d4,%d5
        addl              #4,%d5
        movel             %sp@(40),%d2
        movel             %sp@(44),%d3
        movel             %sp@(32),%d1
        movel             %sp@(36),%d0
        moveal            %d4,%a0
        moveal            %d5,%a1
        cas2l             %d1,%d0,%d2,%d3,%a0@,%a1@
        seq               %d2
        movel             %d0,%a2@(4)
        movel             %d1,%a2@
        cmpib             #0,%d2
        sne               %a2@(8)
        movel             %a2,%d0
        moveml            %sp@(0),%d2-%d5/%a2
        addal             #20,%sp
        moveal            %sp@,%a1
        addal             #4,%sp
        movel             %a1,%sp@
        rts

asm_test::compare_exchange::u64::relaxed_acquire:
        subal             #20,%sp
        moveml            %d2-%d5/%a2,%sp@(0)
        moveal            %sp@(24),%a2
        movel             %sp@(28),%d4
        movel             %d4,%d5
        addl              #4,%d5
        movel             %sp@(40),%d2
        movel             %sp@(44),%d3
        movel             %sp@(32),%d1
        movel             %sp@(36),%d0
        moveal            %d4,%a0
        moveal            %d5,%a1
        cas2l             %d1,%d0,%d2,%d3,%a0@,%a1@
        seq               %d2
        movel             %d0,%a2@(4)
        movel             %d1,%a2@
        cmpib             #0,%d2
        sne               %a2@(8)
        movel             %a2,%d0
        moveml            %sp@(0),%d2-%d5/%a2
        addal             #20,%sp
        moveal            %sp@,%a1
        addal             #4,%sp
        movel             %a1,%sp@
        rts

asm_test::compare_exchange::u64::relaxed_relaxed:
        subal             #20,%sp
        moveml            %d2-%d5/%a2,%sp@(0)
        moveal            %sp@(24),%a2
        movel             %sp@(28),%d4
        movel             %d4,%d5
        addl              #4,%d5
        movel             %sp@(40),%d2
        movel             %sp@(44),%d3
        movel             %sp@(32),%d1
        movel             %sp@(36),%d0
        moveal            %d4,%a0
        moveal            %d5,%a1
        cas2l             %d1,%d0,%d2,%d3,%a0@,%a1@
        seq               %d2
        movel             %d0,%a2@(4)
        movel             %d1,%a2@
        cmpib             #0,%d2
        sne               %a2@(8)
        movel             %a2,%d0
        moveml            %sp@(0),%d2-%d5/%a2
        addal             #20,%sp
        moveal            %sp@,%a1
        addal             #4,%sp
        movel             %a1,%sp@
        rts

asm_test::compare_exchange::u64::release_acquire:
        subal             #20,%sp
        moveml            %d2-%d5/%a2,%sp@(0)
        moveal            %sp@(24),%a2
        movel             %sp@(28),%d4
        movel             %d4,%d5
        addl              #4,%d5
        movel             %sp@(40),%d2
        movel             %sp@(44),%d3
        movel             %sp@(32),%d1
        movel             %sp@(36),%d0
        moveal            %d4,%a0
        moveal            %d5,%a1
        cas2l             %d1,%d0,%d2,%d3,%a0@,%a1@
        seq               %d2
        movel             %d0,%a2@(4)
        movel             %d1,%a2@
        cmpib             #0,%d2
        sne               %a2@(8)
        movel             %a2,%d0
        moveml            %sp@(0),%d2-%d5/%a2
        addal             #20,%sp
        moveal            %sp@,%a1
        addal             #4,%sp
        movel             %a1,%sp@
        rts

asm_test::compare_exchange::u64::release_relaxed:
        subal             #20,%sp
        moveml            %d2-%d5/%a2,%sp@(0)
        moveal            %sp@(24),%a2
        movel             %sp@(28),%d4
        movel             %d4,%d5
        addl              #4,%d5
        movel             %sp@(40),%d2
        movel             %sp@(44),%d3
        movel             %sp@(32),%d1
        movel             %sp@(36),%d0
        moveal            %d4,%a0
        moveal            %d5,%a1
        cas2l             %d1,%d0,%d2,%d3,%a0@,%a1@
        seq               %d2
        movel             %d0,%a2@(4)
        movel             %d1,%a2@
        cmpib             #0,%d2
        sne               %a2@(8)
        movel             %a2,%d0
        moveml            %sp@(0),%d2-%d5/%a2
        addal             #20,%sp
        moveal            %sp@,%a1
        addal             #4,%sp
        movel             %a1,%sp@
        rts

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        moveal            %sp@(4),%a0
        moveb             %sp@(15),%d1
        moveb             %sp@(11),%d0
        casb              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        moveal            %sp@(4),%a0
        moveb             %sp@(15),%d1
        moveb             %sp@(11),%d0
        casb              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        moveal            %sp@(4),%a0
        moveb             %sp@(15),%d1
        moveb             %sp@(11),%d0
        casb              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        moveal            %sp@(4),%a0
        moveb             %sp@(15),%d1
        moveb             %sp@(11),%d0
        casb              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        moveal            %sp@(4),%a0
        moveb             %sp@(15),%d1
        moveb             %sp@(11),%d0
        casb              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        moveal            %sp@(4),%a0
        moveb             %sp@(15),%d1
        moveb             %sp@(11),%d0
        casb              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u8::release_seqcst:
        moveal            %sp@(4),%a0
        moveb             %sp@(15),%d1
        moveb             %sp@(11),%d0
        casb              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        moveal            %sp@(4),%a0
        moveb             %sp@(15),%d1
        moveb             %sp@(11),%d0
        casb              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        moveal            %sp@(4),%a0
        moveb             %sp@(15),%d1
        moveb             %sp@(11),%d0
        casb              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u8::acquire_acquire:
        moveal            %sp@(4),%a0
        moveb             %sp@(15),%d1
        moveb             %sp@(11),%d0
        casb              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        moveal            %sp@(4),%a0
        moveb             %sp@(15),%d1
        moveb             %sp@(11),%d0
        casb              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        moveal            %sp@(4),%a0
        moveb             %sp@(15),%d1
        moveb             %sp@(11),%d0
        casb              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        moveal            %sp@(4),%a0
        moveb             %sp@(15),%d1
        moveb             %sp@(11),%d0
        casb              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u8::release_acquire:
        moveal            %sp@(4),%a0
        moveb             %sp@(15),%d1
        moveb             %sp@(11),%d0
        casb              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u8::release_relaxed:
        moveal            %sp@(4),%a0
        moveb             %sp@(15),%d1
        moveb             %sp@(11),%d0
        casb              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        moveal            %sp@(4),%a0
        movew             %sp@(14),%d1
        movew             %sp@(10),%d0
        casw              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        moveal            %sp@(4),%a0
        movew             %sp@(14),%d1
        movew             %sp@(10),%d0
        casw              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        moveal            %sp@(4),%a0
        movew             %sp@(14),%d1
        movew             %sp@(10),%d0
        casw              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        moveal            %sp@(4),%a0
        movew             %sp@(14),%d1
        movew             %sp@(10),%d0
        casw              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        moveal            %sp@(4),%a0
        movew             %sp@(14),%d1
        movew             %sp@(10),%d0
        casw              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        moveal            %sp@(4),%a0
        movew             %sp@(14),%d1
        movew             %sp@(10),%d0
        casw              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u16::release_seqcst:
        moveal            %sp@(4),%a0
        movew             %sp@(14),%d1
        movew             %sp@(10),%d0
        casw              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        moveal            %sp@(4),%a0
        movew             %sp@(14),%d1
        movew             %sp@(10),%d0
        casw              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        moveal            %sp@(4),%a0
        movew             %sp@(14),%d1
        movew             %sp@(10),%d0
        casw              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u16::acquire_acquire:
        moveal            %sp@(4),%a0
        movew             %sp@(14),%d1
        movew             %sp@(10),%d0
        casw              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        moveal            %sp@(4),%a0
        movew             %sp@(14),%d1
        movew             %sp@(10),%d0
        casw              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        moveal            %sp@(4),%a0
        movew             %sp@(14),%d1
        movew             %sp@(10),%d0
        casw              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        moveal            %sp@(4),%a0
        movew             %sp@(14),%d1
        movew             %sp@(10),%d0
        casw              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u16::release_acquire:
        moveal            %sp@(4),%a0
        movew             %sp@(14),%d1
        movew             %sp@(10),%d0
        casw              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u16::release_relaxed:
        moveal            %sp@(4),%a0
        movew             %sp@(14),%d1
        movew             %sp@(10),%d0
        casw              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        moveal            %sp@(4),%a0
        movel             %sp@(12),%d1
        movel             %sp@(8),%d0
        casl              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        moveal            %sp@(4),%a0
        movel             %sp@(12),%d1
        movel             %sp@(8),%d0
        casl              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        moveal            %sp@(4),%a0
        movel             %sp@(12),%d1
        movel             %sp@(8),%d0
        casl              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        moveal            %sp@(4),%a0
        movel             %sp@(12),%d1
        movel             %sp@(8),%d0
        casl              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        moveal            %sp@(4),%a0
        movel             %sp@(12),%d1
        movel             %sp@(8),%d0
        casl              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        moveal            %sp@(4),%a0
        movel             %sp@(12),%d1
        movel             %sp@(8),%d0
        casl              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u32::release_seqcst:
        moveal            %sp@(4),%a0
        movel             %sp@(12),%d1
        movel             %sp@(8),%d0
        casl              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        moveal            %sp@(4),%a0
        movel             %sp@(12),%d1
        movel             %sp@(8),%d0
        casl              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        moveal            %sp@(4),%a0
        movel             %sp@(12),%d1
        movel             %sp@(8),%d0
        casl              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u32::acquire_acquire:
        moveal            %sp@(4),%a0
        movel             %sp@(12),%d1
        movel             %sp@(8),%d0
        casl              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        moveal            %sp@(4),%a0
        movel             %sp@(12),%d1
        movel             %sp@(8),%d0
        casl              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        moveal            %sp@(4),%a0
        movel             %sp@(12),%d1
        movel             %sp@(8),%d0
        casl              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        moveal            %sp@(4),%a0
        movel             %sp@(12),%d1
        movel             %sp@(8),%d0
        casl              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u32::release_acquire:
        moveal            %sp@(4),%a0
        movel             %sp@(12),%d1
        movel             %sp@(8),%d0
        casl              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u32::release_relaxed:
        moveal            %sp@(4),%a0
        movel             %sp@(12),%d1
        movel             %sp@(8),%d0
        casl              %d0,%d1,%a0@
        seq               %d1
        cmpib             #0,%d1
        sne               %d1
        rts

asm_test::compare_exchange_weak::u64::acqrel_seqcst:
        subal             #20,%sp
        moveml            %d2-%d5/%a2,%sp@(0)
        moveal            %sp@(24),%a2
        movel             %sp@(28),%d4
        movel             %d4,%d5
        addl              #4,%d5
        movel             %sp@(40),%d2
        movel             %sp@(44),%d3
        movel             %sp@(32),%d1
        movel             %sp@(36),%d0
        moveal            %d4,%a0
        moveal            %d5,%a1
        cas2l             %d1,%d0,%d2,%d3,%a0@,%a1@
        seq               %d2
        movel             %d0,%a2@(4)
        movel             %d1,%a2@
        cmpib             #0,%d2
        sne               %a2@(8)
        movel             %a2,%d0
        moveml            %sp@(0),%d2-%d5/%a2
        addal             #20,%sp
        moveal            %sp@,%a1
        addal             #4,%sp
        movel             %a1,%sp@
        rts

asm_test::compare_exchange_weak::u64::seqcst_seqcst:
        subal             #20,%sp
        moveml            %d2-%d5/%a2,%sp@(0)
        moveal            %sp@(24),%a2
        movel             %sp@(28),%d4
        movel             %d4,%d5
        addl              #4,%d5
        movel             %sp@(40),%d2
        movel             %sp@(44),%d3
        movel             %sp@(32),%d1
        movel             %sp@(36),%d0
        moveal            %d4,%a0
        moveal            %d5,%a1
        cas2l             %d1,%d0,%d2,%d3,%a0@,%a1@
        seq               %d2
        movel             %d0,%a2@(4)
        movel             %d1,%a2@
        cmpib             #0,%d2
        sne               %a2@(8)
        movel             %a2,%d0
        moveml            %sp@(0),%d2-%d5/%a2
        addal             #20,%sp
        moveal            %sp@,%a1
        addal             #4,%sp
        movel             %a1,%sp@
        rts

asm_test::compare_exchange_weak::u64::acqrel_acquire:
        subal             #20,%sp
        moveml            %d2-%d5/%a2,%sp@(0)
        moveal            %sp@(24),%a2
        movel             %sp@(28),%d4
        movel             %d4,%d5
        addl              #4,%d5
        movel             %sp@(40),%d2
        movel             %sp@(44),%d3
        movel             %sp@(32),%d1
        movel             %sp@(36),%d0
        moveal            %d4,%a0
        moveal            %d5,%a1
        cas2l             %d1,%d0,%d2,%d3,%a0@,%a1@
        seq               %d2
        movel             %d0,%a2@(4)
        movel             %d1,%a2@
        cmpib             #0,%d2
        sne               %a2@(8)
        movel             %a2,%d0
        moveml            %sp@(0),%d2-%d5/%a2
        addal             #20,%sp
        moveal            %sp@,%a1
        addal             #4,%sp
        movel             %a1,%sp@
        rts

asm_test::compare_exchange_weak::u64::acqrel_relaxed:
        subal             #20,%sp
        moveml            %d2-%d5/%a2,%sp@(0)
        moveal            %sp@(24),%a2
        movel             %sp@(28),%d4
        movel             %d4,%d5
        addl              #4,%d5
        movel             %sp@(40),%d2
        movel             %sp@(44),%d3
        movel             %sp@(32),%d1
        movel             %sp@(36),%d0
        moveal            %d4,%a0
        moveal            %d5,%a1
        cas2l             %d1,%d0,%d2,%d3,%a0@,%a1@
        seq               %d2
        movel             %d0,%a2@(4)
        movel             %d1,%a2@
        cmpib             #0,%d2
        sne               %a2@(8)
        movel             %a2,%d0
        moveml            %sp@(0),%d2-%d5/%a2
        addal             #20,%sp
        moveal            %sp@,%a1
        addal             #4,%sp
        movel             %a1,%sp@
        rts

asm_test::compare_exchange_weak::u64::acquire_seqcst:
        subal             #20,%sp
        moveml            %d2-%d5/%a2,%sp@(0)
        moveal            %sp@(24),%a2
        movel             %sp@(28),%d4
        movel             %d4,%d5
        addl              #4,%d5
        movel             %sp@(40),%d2
        movel             %sp@(44),%d3
        movel             %sp@(32),%d1
        movel             %sp@(36),%d0
        moveal            %d4,%a0
        moveal            %d5,%a1
        cas2l             %d1,%d0,%d2,%d3,%a0@,%a1@
        seq               %d2
        movel             %d0,%a2@(4)
        movel             %d1,%a2@
        cmpib             #0,%d2
        sne               %a2@(8)
        movel             %a2,%d0
        moveml            %sp@(0),%d2-%d5/%a2
        addal             #20,%sp
        moveal            %sp@,%a1
        addal             #4,%sp
        movel             %a1,%sp@
        rts

asm_test::compare_exchange_weak::u64::relaxed_seqcst:
        subal             #20,%sp
        moveml            %d2-%d5/%a2,%sp@(0)
        moveal            %sp@(24),%a2
        movel             %sp@(28),%d4
        movel             %d4,%d5
        addl              #4,%d5
        movel             %sp@(40),%d2
        movel             %sp@(44),%d3
        movel             %sp@(32),%d1
        movel             %sp@(36),%d0
        moveal            %d4,%a0
        moveal            %d5,%a1
        cas2l             %d1,%d0,%d2,%d3,%a0@,%a1@
        seq               %d2
        movel             %d0,%a2@(4)
        movel             %d1,%a2@
        cmpib             #0,%d2
        sne               %a2@(8)
        movel             %a2,%d0
        moveml            %sp@(0),%d2-%d5/%a2
        addal             #20,%sp
        moveal            %sp@,%a1
        addal             #4,%sp
        movel             %a1,%sp@
        rts

asm_test::compare_exchange_weak::u64::release_seqcst:
        subal             #20,%sp
        moveml            %d2-%d5/%a2,%sp@(0)
        moveal            %sp@(24),%a2
        movel             %sp@(28),%d4
        movel             %d4,%d5
        addl              #4,%d5
        movel             %sp@(40),%d2
        movel             %sp@(44),%d3
        movel             %sp@(32),%d1
        movel             %sp@(36),%d0
        moveal            %d4,%a0
        moveal            %d5,%a1
        cas2l             %d1,%d0,%d2,%d3,%a0@,%a1@
        seq               %d2
        movel             %d0,%a2@(4)
        movel             %d1,%a2@
        cmpib             #0,%d2
        sne               %a2@(8)
        movel             %a2,%d0
        moveml            %sp@(0),%d2-%d5/%a2
        addal             #20,%sp
        moveal            %sp@,%a1
        addal             #4,%sp
        movel             %a1,%sp@
        rts

asm_test::compare_exchange_weak::u64::seqcst_acquire:
        subal             #20,%sp
        moveml            %d2-%d5/%a2,%sp@(0)
        moveal            %sp@(24),%a2
        movel             %sp@(28),%d4
        movel             %d4,%d5
        addl              #4,%d5
        movel             %sp@(40),%d2
        movel             %sp@(44),%d3
        movel             %sp@(32),%d1
        movel             %sp@(36),%d0
        moveal            %d4,%a0
        moveal            %d5,%a1
        cas2l             %d1,%d0,%d2,%d3,%a0@,%a1@
        seq               %d2
        movel             %d0,%a2@(4)
        movel             %d1,%a2@
        cmpib             #0,%d2
        sne               %a2@(8)
        movel             %a2,%d0
        moveml            %sp@(0),%d2-%d5/%a2
        addal             #20,%sp
        moveal            %sp@,%a1
        addal             #4,%sp
        movel             %a1,%sp@
        rts

asm_test::compare_exchange_weak::u64::seqcst_relaxed:
        subal             #20,%sp
        moveml            %d2-%d5/%a2,%sp@(0)
        moveal            %sp@(24),%a2
        movel             %sp@(28),%d4
        movel             %d4,%d5
        addl              #4,%d5
        movel             %sp@(40),%d2
        movel             %sp@(44),%d3
        movel             %sp@(32),%d1
        movel             %sp@(36),%d0
        moveal            %d4,%a0
        moveal            %d5,%a1
        cas2l             %d1,%d0,%d2,%d3,%a0@,%a1@
        seq               %d2
        movel             %d0,%a2@(4)
        movel             %d1,%a2@
        cmpib             #0,%d2
        sne               %a2@(8)
        movel             %a2,%d0
        moveml            %sp@(0),%d2-%d5/%a2
        addal             #20,%sp
        moveal            %sp@,%a1
        addal             #4,%sp
        movel             %a1,%sp@
        rts

asm_test::compare_exchange_weak::u64::acquire_acquire:
        subal             #20,%sp
        moveml            %d2-%d5/%a2,%sp@(0)
        moveal            %sp@(24),%a2
        movel             %sp@(28),%d4
        movel             %d4,%d5
        addl              #4,%d5
        movel             %sp@(40),%d2
        movel             %sp@(44),%d3
        movel             %sp@(32),%d1
        movel             %sp@(36),%d0
        moveal            %d4,%a0
        moveal            %d5,%a1
        cas2l             %d1,%d0,%d2,%d3,%a0@,%a1@
        seq               %d2
        movel             %d0,%a2@(4)
        movel             %d1,%a2@
        cmpib             #0,%d2
        sne               %a2@(8)
        movel             %a2,%d0
        moveml            %sp@(0),%d2-%d5/%a2
        addal             #20,%sp
        moveal            %sp@,%a1
        addal             #4,%sp
        movel             %a1,%sp@
        rts

asm_test::compare_exchange_weak::u64::acquire_relaxed:
        subal             #20,%sp
        moveml            %d2-%d5/%a2,%sp@(0)
        moveal            %sp@(24),%a2
        movel             %sp@(28),%d4
        movel             %d4,%d5
        addl              #4,%d5
        movel             %sp@(40),%d2
        movel             %sp@(44),%d3
        movel             %sp@(32),%d1
        movel             %sp@(36),%d0
        moveal            %d4,%a0
        moveal            %d5,%a1
        cas2l             %d1,%d0,%d2,%d3,%a0@,%a1@
        seq               %d2
        movel             %d0,%a2@(4)
        movel             %d1,%a2@
        cmpib             #0,%d2
        sne               %a2@(8)
        movel             %a2,%d0
        moveml            %sp@(0),%d2-%d5/%a2
        addal             #20,%sp
        moveal            %sp@,%a1
        addal             #4,%sp
        movel             %a1,%sp@
        rts

asm_test::compare_exchange_weak::u64::relaxed_acquire:
        subal             #20,%sp
        moveml            %d2-%d5/%a2,%sp@(0)
        moveal            %sp@(24),%a2
        movel             %sp@(28),%d4
        movel             %d4,%d5
        addl              #4,%d5
        movel             %sp@(40),%d2
        movel             %sp@(44),%d3
        movel             %sp@(32),%d1
        movel             %sp@(36),%d0
        moveal            %d4,%a0
        moveal            %d5,%a1
        cas2l             %d1,%d0,%d2,%d3,%a0@,%a1@
        seq               %d2
        movel             %d0,%a2@(4)
        movel             %d1,%a2@
        cmpib             #0,%d2
        sne               %a2@(8)
        movel             %a2,%d0
        moveml            %sp@(0),%d2-%d5/%a2
        addal             #20,%sp
        moveal            %sp@,%a1
        addal             #4,%sp
        movel             %a1,%sp@
        rts

asm_test::compare_exchange_weak::u64::relaxed_relaxed:
        subal             #20,%sp
        moveml            %d2-%d5/%a2,%sp@(0)
        moveal            %sp@(24),%a2
        movel             %sp@(28),%d4
        movel             %d4,%d5
        addl              #4,%d5
        movel             %sp@(40),%d2
        movel             %sp@(44),%d3
        movel             %sp@(32),%d1
        movel             %sp@(36),%d0
        moveal            %d4,%a0
        moveal            %d5,%a1
        cas2l             %d1,%d0,%d2,%d3,%a0@,%a1@
        seq               %d2
        movel             %d0,%a2@(4)
        movel             %d1,%a2@
        cmpib             #0,%d2
        sne               %a2@(8)
        movel             %a2,%d0
        moveml            %sp@(0),%d2-%d5/%a2
        addal             #20,%sp
        moveal            %sp@,%a1
        addal             #4,%sp
        movel             %a1,%sp@
        rts

asm_test::compare_exchange_weak::u64::release_acquire:
        subal             #20,%sp
        moveml            %d2-%d5/%a2,%sp@(0)
        moveal            %sp@(24),%a2
        movel             %sp@(28),%d4
        movel             %d4,%d5
        addl              #4,%d5
        movel             %sp@(40),%d2
        movel             %sp@(44),%d3
        movel             %sp@(32),%d1
        movel             %sp@(36),%d0
        moveal            %d4,%a0
        moveal            %d5,%a1
        cas2l             %d1,%d0,%d2,%d3,%a0@,%a1@
        seq               %d2
        movel             %d0,%a2@(4)
        movel             %d1,%a2@
        cmpib             #0,%d2
        sne               %a2@(8)
        movel             %a2,%d0
        moveml            %sp@(0),%d2-%d5/%a2
        addal             #20,%sp
        moveal            %sp@,%a1
        addal             #4,%sp
        movel             %a1,%sp@
        rts

asm_test::compare_exchange_weak::u64::release_relaxed:
        subal             #20,%sp
        moveml            %d2-%d5/%a2,%sp@(0)
        moveal            %sp@(24),%a2
        movel             %sp@(28),%d4
        movel             %d4,%d5
        addl              #4,%d5
        movel             %sp@(40),%d2
        movel             %sp@(44),%d3
        movel             %sp@(32),%d1
        movel             %sp@(36),%d0
        moveal            %d4,%a0
        moveal            %d5,%a1
        cas2l             %d1,%d0,%d2,%d3,%a0@,%a1@
        seq               %d2
        movel             %d0,%a2@(4)
        movel             %d1,%a2@
        cmpib             #0,%d2
        sne               %a2@(8)
        movel             %a2,%d0
        moveml            %sp@(0),%d2-%d5/%a2
        addal             #20,%sp
        moveal            %sp@,%a1
        addal             #4,%sp
        movel             %a1,%sp@
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

asm_test::load::u64::seqcst:
        subal             #8,%sp
        moveml            %d2-%d3,%sp@(0)
        movel             %sp@(12),%d1
        movel             %d1,%d2
        addl              #4,%d2
        moveq             #0,%d0
        moveal            %d1,%a0
        moveal            %d2,%a1
        movel             %d0,%d2
        movel             %d0,%d3
        movel             %d0,%d1
        cas2l             %d1,%d0,%d2,%d3,%a0@,%a1@
        moveal            %d0,%a0
        movel             %d1,%d0
        movel             %a0,%d1
        moveml            %sp@(0),%d2-%d3
        addal             #8,%sp
        rts

asm_test::load::u64::acquire:
        subal             #8,%sp
        moveml            %d2-%d3,%sp@(0)
        movel             %sp@(12),%d1
        movel             %d1,%d2
        addl              #4,%d2
        moveq             #0,%d0
        moveal            %d1,%a0
        moveal            %d2,%a1
        movel             %d0,%d2
        movel             %d0,%d3
        movel             %d0,%d1
        cas2l             %d1,%d0,%d2,%d3,%a0@,%a1@
        moveal            %d0,%a0
        movel             %d1,%d0
        movel             %a0,%d1
        moveml            %sp@(0),%d2-%d3
        addal             #8,%sp
        rts

asm_test::load::u64::relaxed:
        subal             #8,%sp
        moveml            %d2-%d3,%sp@(0)
        movel             %sp@(12),%d1
        movel             %d1,%d2
        addl              #4,%d2
        moveq             #0,%d0
        moveal            %d1,%a0
        moveal            %d2,%a1
        movel             %d0,%d2
        movel             %d0,%d3
        movel             %d0,%d1
        cas2l             %d1,%d0,%d2,%d3,%a0@,%a1@
        moveal            %d0,%a0
        movel             %d1,%d0
        movel             %a0,%d1
        moveml            %sp@(0),%d2-%d3
        addal             #8,%sp
        rts

asm_test::swap::u8::acqrel:
        moveal            %sp@(4),%a0
        moveb             %sp@(11),%d1
        moveb             %a0@,%d0
0:
        casb              %d0,%d1,%a0@
        bnes              0b
        rts

asm_test::swap::u8::seqcst:
        moveal            %sp@(4),%a0
        moveb             %sp@(11),%d1
        moveb             %a0@,%d0
0:
        casb              %d0,%d1,%a0@
        bnes              0b
        rts

asm_test::swap::u8::acquire:
        moveal            %sp@(4),%a0
        moveb             %sp@(11),%d1
        moveb             %a0@,%d0
0:
        casb              %d0,%d1,%a0@
        bnes              0b
        rts

asm_test::swap::u8::relaxed:
        moveal            %sp@(4),%a0
        moveb             %sp@(11),%d1
        moveb             %a0@,%d0
0:
        casb              %d0,%d1,%a0@
        bnes              0b
        rts

asm_test::swap::u8::release:
        moveal            %sp@(4),%a0
        moveb             %sp@(11),%d1
        moveb             %a0@,%d0
0:
        casb              %d0,%d1,%a0@
        bnes              0b
        rts

asm_test::swap::u16::acqrel:
        moveal            %sp@(4),%a0
        movew             %sp@(10),%d1
        movew             %a0@,%d0
0:
        casw              %d0,%d1,%a0@
        bnes              0b
        rts

asm_test::swap::u16::seqcst:
        moveal            %sp@(4),%a0
        movew             %sp@(10),%d1
        movew             %a0@,%d0
0:
        casw              %d0,%d1,%a0@
        bnes              0b
        rts

asm_test::swap::u16::acquire:
        moveal            %sp@(4),%a0
        movew             %sp@(10),%d1
        movew             %a0@,%d0
0:
        casw              %d0,%d1,%a0@
        bnes              0b
        rts

asm_test::swap::u16::relaxed:
        moveal            %sp@(4),%a0
        movew             %sp@(10),%d1
        movew             %a0@,%d0
0:
        casw              %d0,%d1,%a0@
        bnes              0b
        rts

asm_test::swap::u16::release:
        moveal            %sp@(4),%a0
        movew             %sp@(10),%d1
        movew             %a0@,%d0
0:
        casw              %d0,%d1,%a0@
        bnes              0b
        rts

asm_test::swap::u32::acqrel:
        moveal            %sp@(4),%a0
        movel             %sp@(8),%d1
        movel             %a0@,%d0
0:
        casl              %d0,%d1,%a0@
        bnes              0b
        rts

asm_test::swap::u32::seqcst:
        moveal            %sp@(4),%a0
        movel             %sp@(8),%d1
        movel             %a0@,%d0
0:
        casl              %d0,%d1,%a0@
        bnes              0b
        rts

asm_test::swap::u32::acquire:
        moveal            %sp@(4),%a0
        movel             %sp@(8),%d1
        movel             %a0@,%d0
0:
        casl              %d0,%d1,%a0@
        bnes              0b
        rts

asm_test::swap::u32::relaxed:
        moveal            %sp@(4),%a0
        movel             %sp@(8),%d1
        movel             %a0@,%d0
0:
        casl              %d0,%d1,%a0@
        bnes              0b
        rts

asm_test::swap::u32::release:
        moveal            %sp@(4),%a0
        movel             %sp@(8),%d1
        movel             %a0@,%d0
0:
        casl              %d0,%d1,%a0@
        bnes              0b
        rts

asm_test::swap::u64::acqrel:
        subal             #8,%sp
        moveml            %d2-%d3,%sp@(0)
        movel             %sp@(12),%d0
        movel             %d0,%d1
        addl              #4,%d1
        movel             %sp@(16),%d2
        movel             %sp@(20),%d3
        moveal            %d0,%a0
        moveal            %d1,%a1
        movel             %a0@,%d1
        movel             %a1@,%d0
0:
        cas2l             %d1,%d0,%d2,%d3,%a0@,%a1@
        bnes              0b
        moveal            %d0,%a0
        movel             %d1,%d0
        movel             %a0,%d1
        moveml            %sp@(0),%d2-%d3
        addal             #8,%sp
        rts

asm_test::swap::u64::seqcst:
        subal             #8,%sp
        moveml            %d2-%d3,%sp@(0)
        movel             %sp@(12),%d0
        movel             %d0,%d1
        addl              #4,%d1
        movel             %sp@(16),%d2
        movel             %sp@(20),%d3
        moveal            %d0,%a0
        moveal            %d1,%a1
        movel             %a0@,%d1
        movel             %a1@,%d0
0:
        cas2l             %d1,%d0,%d2,%d3,%a0@,%a1@
        bnes              0b
        moveal            %d0,%a0
        movel             %d1,%d0
        movel             %a0,%d1
        moveml            %sp@(0),%d2-%d3
        addal             #8,%sp
        rts

asm_test::swap::u64::acquire:
        subal             #8,%sp
        moveml            %d2-%d3,%sp@(0)
        movel             %sp@(12),%d0
        movel             %d0,%d1
        addl              #4,%d1
        movel             %sp@(16),%d2
        movel             %sp@(20),%d3
        moveal            %d0,%a0
        moveal            %d1,%a1
        movel             %a0@,%d1
        movel             %a1@,%d0
0:
        cas2l             %d1,%d0,%d2,%d3,%a0@,%a1@
        bnes              0b
        moveal            %d0,%a0
        movel             %d1,%d0
        movel             %a0,%d1
        moveml            %sp@(0),%d2-%d3
        addal             #8,%sp
        rts

asm_test::swap::u64::relaxed:
        subal             #8,%sp
        moveml            %d2-%d3,%sp@(0)
        movel             %sp@(12),%d0
        movel             %d0,%d1
        addl              #4,%d1
        movel             %sp@(16),%d2
        movel             %sp@(20),%d3
        moveal            %d0,%a0
        moveal            %d1,%a1
        movel             %a0@,%d1
        movel             %a1@,%d0
0:
        cas2l             %d1,%d0,%d2,%d3,%a0@,%a1@
        bnes              0b
        moveal            %d0,%a0
        movel             %d1,%d0
        movel             %a0,%d1
        moveml            %sp@(0),%d2-%d3
        addal             #8,%sp
        rts

asm_test::swap::u64::release:
        subal             #8,%sp
        moveml            %d2-%d3,%sp@(0)
        movel             %sp@(12),%d0
        movel             %d0,%d1
        addl              #4,%d1
        movel             %sp@(16),%d2
        movel             %sp@(20),%d3
        moveal            %d0,%a0
        moveal            %d1,%a1
        movel             %a0@,%d1
        movel             %a1@,%d0
0:
        cas2l             %d1,%d0,%d2,%d3,%a0@,%a1@
        bnes              0b
        moveal            %d0,%a0
        movel             %d1,%d0
        movel             %a0,%d1
        moveml            %sp@(0),%d2-%d3
        addal             #8,%sp
        rts

asm_test::store::u8::seqcst:
        moveal            %sp@(4),%a0
        moveb             %sp@(11),%d0
        moveb             %d0,%a0@
        rts

asm_test::store::u8::relaxed:
        moveal            %sp@(4),%a0
        moveb             %sp@(11),%d0
        moveb             %d0,%a0@
        rts

asm_test::store::u8::release:
        moveal            %sp@(4),%a0
        moveb             %sp@(11),%d0
        moveb             %d0,%a0@
        rts

asm_test::store::u16::seqcst:
        moveal            %sp@(4),%a0
        movew             %sp@(10),%d0
        movew             %d0,%a0@
        rts

asm_test::store::u16::relaxed:
        moveal            %sp@(4),%a0
        movew             %sp@(10),%d0
        movew             %d0,%a0@
        rts

asm_test::store::u16::release:
        moveal            %sp@(4),%a0
        movew             %sp@(10),%d0
        movew             %d0,%a0@
        rts

asm_test::store::u32::seqcst:
        moveal            %sp@(4),%a0
        movel             %sp@(8),%d0
        movel             %d0,%a0@
        rts

asm_test::store::u32::relaxed:
        moveal            %sp@(4),%a0
        movel             %sp@(8),%d0
        movel             %d0,%a0@
        rts

asm_test::store::u32::release:
        moveal            %sp@(4),%a0
        movel             %sp@(8),%d0
        movel             %d0,%a0@
        rts

asm_test::store::u64::seqcst:
        subal             #8,%sp
        moveml            %d2-%d3,%sp@(0)
        movel             %sp@(12),%d0
        movel             %d0,%d1
        addl              #4,%d1
        movel             %sp@(16),%d2
        movel             %sp@(20),%d3
        moveal            %d0,%a0
        moveal            %d1,%a1
        movel             %a0@,%d1
        movel             %a1@,%d0
0:
        cas2l             %d1,%d0,%d2,%d3,%a0@,%a1@
        bnes              0b
        moveml            %sp@(0),%d2-%d3
        addal             #8,%sp
        rts

asm_test::store::u64::relaxed:
        subal             #8,%sp
        moveml            %d2-%d3,%sp@(0)
        movel             %sp@(12),%d0
        movel             %d0,%d1
        addl              #4,%d1
        movel             %sp@(16),%d2
        movel             %sp@(20),%d3
        moveal            %d0,%a0
        moveal            %d1,%a1
        movel             %a0@,%d1
        movel             %a1@,%d0
0:
        cas2l             %d1,%d0,%d2,%d3,%a0@,%a1@
        bnes              0b
        moveml            %sp@(0),%d2-%d3
        addal             #8,%sp
        rts

asm_test::store::u64::release:
        subal             #8,%sp
        moveml            %d2-%d3,%sp@(0)
        movel             %sp@(12),%d0
        movel             %d0,%d1
        addl              #4,%d1
        movel             %sp@(16),%d2
        movel             %sp@(20),%d3
        moveal            %d0,%a0
        moveal            %d1,%a1
        movel             %a0@,%d1
        movel             %a1@,%d0
0:
        cas2l             %d1,%d0,%d2,%d3,%a0@,%a1@
        bnes              0b
        moveml            %sp@(0),%d2-%d3
        addal             #8,%sp
        rts

