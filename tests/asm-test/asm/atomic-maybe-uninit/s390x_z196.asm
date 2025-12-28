asm_test::compare_exchange::u8::acqrel_seqcst:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llcr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,8(%r5)
        risbg             %r4,%r2,32,55
        llcr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-8(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange::u8::seqcst_seqcst:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llcr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,8(%r5)
        risbg             %r4,%r2,32,55
        llcr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-8(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange::u8::acqrel_acquire:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llcr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,8(%r5)
        risbg             %r4,%r2,32,55
        llcr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-8(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange::u8::acqrel_relaxed:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llcr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,8(%r5)
        risbg             %r4,%r2,32,55
        llcr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-8(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange::u8::acquire_seqcst:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llcr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,8(%r5)
        risbg             %r4,%r2,32,55
        llcr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-8(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange::u8::relaxed_seqcst:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llcr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,8(%r5)
        risbg             %r4,%r2,32,55
        llcr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-8(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange::u8::release_seqcst:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llcr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,8(%r5)
        risbg             %r4,%r2,32,55
        llcr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-8(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange::u8::seqcst_acquire:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llcr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,8(%r5)
        risbg             %r4,%r2,32,55
        llcr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-8(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange::u8::seqcst_relaxed:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llcr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,8(%r5)
        risbg             %r4,%r2,32,55
        llcr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-8(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange::u8::acquire_acquire:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llcr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,8(%r5)
        risbg             %r4,%r2,32,55
        llcr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-8(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange::u8::acquire_relaxed:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llcr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,8(%r5)
        risbg             %r4,%r2,32,55
        llcr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-8(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange::u8::relaxed_acquire:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llcr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,8(%r5)
        risbg             %r4,%r2,32,55
        llcr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-8(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange::u8::relaxed_relaxed:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llcr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,8(%r5)
        risbg             %r4,%r2,32,55
        llcr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-8(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange::u8::release_acquire:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llcr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,8(%r5)
        risbg             %r4,%r2,32,55
        llcr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-8(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange::u8::release_relaxed:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llcr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,8(%r5)
        risbg             %r4,%r2,32,55
        llcr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-8(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange::u16::acqrel_seqcst:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llhr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,16(%r5)
        risbg             %r4,%r2,32,47
        llhr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-16(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange::u16::seqcst_seqcst:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llhr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,16(%r5)
        risbg             %r4,%r2,32,47
        llhr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-16(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange::u16::acqrel_acquire:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llhr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,16(%r5)
        risbg             %r4,%r2,32,47
        llhr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-16(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange::u16::acqrel_relaxed:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llhr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,16(%r5)
        risbg             %r4,%r2,32,47
        llhr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-16(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange::u16::acquire_seqcst:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llhr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,16(%r5)
        risbg             %r4,%r2,32,47
        llhr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-16(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange::u16::relaxed_seqcst:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llhr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,16(%r5)
        risbg             %r4,%r2,32,47
        llhr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-16(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange::u16::release_seqcst:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llhr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,16(%r5)
        risbg             %r4,%r2,32,47
        llhr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-16(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange::u16::seqcst_acquire:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llhr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,16(%r5)
        risbg             %r4,%r2,32,47
        llhr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-16(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange::u16::seqcst_relaxed:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llhr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,16(%r5)
        risbg             %r4,%r2,32,47
        llhr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-16(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange::u16::acquire_acquire:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llhr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,16(%r5)
        risbg             %r4,%r2,32,47
        llhr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-16(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange::u16::acquire_relaxed:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llhr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,16(%r5)
        risbg             %r4,%r2,32,47
        llhr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-16(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange::u16::relaxed_acquire:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llhr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,16(%r5)
        risbg             %r4,%r2,32,47
        llhr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-16(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange::u16::relaxed_relaxed:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llhr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,16(%r5)
        risbg             %r4,%r2,32,47
        llhr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-16(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange::u16::release_acquire:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llhr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,16(%r5)
        risbg             %r4,%r2,32,47
        llhr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-16(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange::u16::release_relaxed:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llhr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,16(%r5)
        risbg             %r4,%r2,32,47
        llhr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-16(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange::u32::acqrel_seqcst:
        lr                %r0,%r3
        cs                %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lr                %r2,%r0
        br                %r14

asm_test::compare_exchange::u32::seqcst_seqcst:
        lr                %r0,%r3
        cs                %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lr                %r2,%r0
        br                %r14

asm_test::compare_exchange::u32::acqrel_acquire:
        lr                %r0,%r3
        cs                %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lr                %r2,%r0
        br                %r14

asm_test::compare_exchange::u32::acqrel_relaxed:
        lr                %r0,%r3
        cs                %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lr                %r2,%r0
        br                %r14

asm_test::compare_exchange::u32::acquire_seqcst:
        lr                %r0,%r3
        cs                %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lr                %r2,%r0
        br                %r14

asm_test::compare_exchange::u32::relaxed_seqcst:
        lr                %r0,%r3
        cs                %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lr                %r2,%r0
        br                %r14

asm_test::compare_exchange::u32::release_seqcst:
        lr                %r0,%r3
        cs                %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lr                %r2,%r0
        br                %r14

asm_test::compare_exchange::u32::seqcst_acquire:
        lr                %r0,%r3
        cs                %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lr                %r2,%r0
        br                %r14

asm_test::compare_exchange::u32::seqcst_relaxed:
        lr                %r0,%r3
        cs                %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lr                %r2,%r0
        br                %r14

asm_test::compare_exchange::u32::acquire_acquire:
        lr                %r0,%r3
        cs                %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lr                %r2,%r0
        br                %r14

asm_test::compare_exchange::u32::acquire_relaxed:
        lr                %r0,%r3
        cs                %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lr                %r2,%r0
        br                %r14

asm_test::compare_exchange::u32::relaxed_acquire:
        lr                %r0,%r3
        cs                %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lr                %r2,%r0
        br                %r14

asm_test::compare_exchange::u32::relaxed_relaxed:
        lr                %r0,%r3
        cs                %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lr                %r2,%r0
        br                %r14

asm_test::compare_exchange::u32::release_acquire:
        lr                %r0,%r3
        cs                %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lr                %r2,%r0
        br                %r14

asm_test::compare_exchange::u32::release_relaxed:
        lr                %r0,%r3
        cs                %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lr                %r2,%r0
        br                %r14

asm_test::compare_exchange::u64::acqrel_seqcst:
        lgr               %r0,%r3
        csg               %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lgr               %r2,%r0
        br                %r14

asm_test::compare_exchange::u64::seqcst_seqcst:
        lgr               %r0,%r3
        csg               %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lgr               %r2,%r0
        br                %r14

asm_test::compare_exchange::u64::acqrel_acquire:
        lgr               %r0,%r3
        csg               %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lgr               %r2,%r0
        br                %r14

asm_test::compare_exchange::u64::acqrel_relaxed:
        lgr               %r0,%r3
        csg               %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lgr               %r2,%r0
        br                %r14

asm_test::compare_exchange::u64::acquire_seqcst:
        lgr               %r0,%r3
        csg               %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lgr               %r2,%r0
        br                %r14

asm_test::compare_exchange::u64::relaxed_seqcst:
        lgr               %r0,%r3
        csg               %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lgr               %r2,%r0
        br                %r14

asm_test::compare_exchange::u64::release_seqcst:
        lgr               %r0,%r3
        csg               %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lgr               %r2,%r0
        br                %r14

asm_test::compare_exchange::u64::seqcst_acquire:
        lgr               %r0,%r3
        csg               %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lgr               %r2,%r0
        br                %r14

asm_test::compare_exchange::u64::seqcst_relaxed:
        lgr               %r0,%r3
        csg               %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lgr               %r2,%r0
        br                %r14

asm_test::compare_exchange::u64::acquire_acquire:
        lgr               %r0,%r3
        csg               %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lgr               %r2,%r0
        br                %r14

asm_test::compare_exchange::u64::acquire_relaxed:
        lgr               %r0,%r3
        csg               %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lgr               %r2,%r0
        br                %r14

asm_test::compare_exchange::u64::relaxed_acquire:
        lgr               %r0,%r3
        csg               %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lgr               %r2,%r0
        br                %r14

asm_test::compare_exchange::u64::relaxed_relaxed:
        lgr               %r0,%r3
        csg               %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lgr               %r2,%r0
        br                %r14

asm_test::compare_exchange::u64::release_acquire:
        lgr               %r0,%r3
        csg               %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lgr               %r2,%r0
        br                %r14

asm_test::compare_exchange::u64::release_relaxed:
        lgr               %r0,%r3
        csg               %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lgr               %r2,%r0
        br                %r14

asm_test::compare_exchange::u128::acqrel_seqcst:
        stmg              %r12,%r15,96(%r15)
        lg                %r0,0(%r4)
        lg                %r1,8(%r4)
        lg                %r12,0(%r5)
        lg                %r13,8(%r5)
        cdsg              %r0,%r12,0(%r3)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        stg               %r1,8(%r2)
        stg               %r0,0(%r2)
        stc               %r3,16(%r2)
        lmg               %r12,%r15,96(%r15)
        br                %r14

asm_test::compare_exchange::u128::seqcst_seqcst:
        stmg              %r12,%r15,96(%r15)
        lg                %r0,0(%r4)
        lg                %r1,8(%r4)
        lg                %r12,0(%r5)
        lg                %r13,8(%r5)
        cdsg              %r0,%r12,0(%r3)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        stg               %r1,8(%r2)
        stg               %r0,0(%r2)
        stc               %r3,16(%r2)
        lmg               %r12,%r15,96(%r15)
        br                %r14

asm_test::compare_exchange::u128::acqrel_acquire:
        stmg              %r12,%r15,96(%r15)
        lg                %r0,0(%r4)
        lg                %r1,8(%r4)
        lg                %r12,0(%r5)
        lg                %r13,8(%r5)
        cdsg              %r0,%r12,0(%r3)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        stg               %r1,8(%r2)
        stg               %r0,0(%r2)
        stc               %r3,16(%r2)
        lmg               %r12,%r15,96(%r15)
        br                %r14

asm_test::compare_exchange::u128::acqrel_relaxed:
        stmg              %r12,%r15,96(%r15)
        lg                %r0,0(%r4)
        lg                %r1,8(%r4)
        lg                %r12,0(%r5)
        lg                %r13,8(%r5)
        cdsg              %r0,%r12,0(%r3)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        stg               %r1,8(%r2)
        stg               %r0,0(%r2)
        stc               %r3,16(%r2)
        lmg               %r12,%r15,96(%r15)
        br                %r14

asm_test::compare_exchange::u128::acquire_seqcst:
        stmg              %r12,%r15,96(%r15)
        lg                %r0,0(%r4)
        lg                %r1,8(%r4)
        lg                %r12,0(%r5)
        lg                %r13,8(%r5)
        cdsg              %r0,%r12,0(%r3)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        stg               %r1,8(%r2)
        stg               %r0,0(%r2)
        stc               %r3,16(%r2)
        lmg               %r12,%r15,96(%r15)
        br                %r14

asm_test::compare_exchange::u128::relaxed_seqcst:
        stmg              %r12,%r15,96(%r15)
        lg                %r0,0(%r4)
        lg                %r1,8(%r4)
        lg                %r12,0(%r5)
        lg                %r13,8(%r5)
        cdsg              %r0,%r12,0(%r3)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        stg               %r1,8(%r2)
        stg               %r0,0(%r2)
        stc               %r3,16(%r2)
        lmg               %r12,%r15,96(%r15)
        br                %r14

asm_test::compare_exchange::u128::release_seqcst:
        stmg              %r12,%r15,96(%r15)
        lg                %r0,0(%r4)
        lg                %r1,8(%r4)
        lg                %r12,0(%r5)
        lg                %r13,8(%r5)
        cdsg              %r0,%r12,0(%r3)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        stg               %r1,8(%r2)
        stg               %r0,0(%r2)
        stc               %r3,16(%r2)
        lmg               %r12,%r15,96(%r15)
        br                %r14

asm_test::compare_exchange::u128::seqcst_acquire:
        stmg              %r12,%r15,96(%r15)
        lg                %r0,0(%r4)
        lg                %r1,8(%r4)
        lg                %r12,0(%r5)
        lg                %r13,8(%r5)
        cdsg              %r0,%r12,0(%r3)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        stg               %r1,8(%r2)
        stg               %r0,0(%r2)
        stc               %r3,16(%r2)
        lmg               %r12,%r15,96(%r15)
        br                %r14

asm_test::compare_exchange::u128::seqcst_relaxed:
        stmg              %r12,%r15,96(%r15)
        lg                %r0,0(%r4)
        lg                %r1,8(%r4)
        lg                %r12,0(%r5)
        lg                %r13,8(%r5)
        cdsg              %r0,%r12,0(%r3)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        stg               %r1,8(%r2)
        stg               %r0,0(%r2)
        stc               %r3,16(%r2)
        lmg               %r12,%r15,96(%r15)
        br                %r14

asm_test::compare_exchange::u128::acquire_acquire:
        stmg              %r12,%r15,96(%r15)
        lg                %r0,0(%r4)
        lg                %r1,8(%r4)
        lg                %r12,0(%r5)
        lg                %r13,8(%r5)
        cdsg              %r0,%r12,0(%r3)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        stg               %r1,8(%r2)
        stg               %r0,0(%r2)
        stc               %r3,16(%r2)
        lmg               %r12,%r15,96(%r15)
        br                %r14

asm_test::compare_exchange::u128::acquire_relaxed:
        stmg              %r12,%r15,96(%r15)
        lg                %r0,0(%r4)
        lg                %r1,8(%r4)
        lg                %r12,0(%r5)
        lg                %r13,8(%r5)
        cdsg              %r0,%r12,0(%r3)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        stg               %r1,8(%r2)
        stg               %r0,0(%r2)
        stc               %r3,16(%r2)
        lmg               %r12,%r15,96(%r15)
        br                %r14

asm_test::compare_exchange::u128::relaxed_acquire:
        stmg              %r12,%r15,96(%r15)
        lg                %r0,0(%r4)
        lg                %r1,8(%r4)
        lg                %r12,0(%r5)
        lg                %r13,8(%r5)
        cdsg              %r0,%r12,0(%r3)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        stg               %r1,8(%r2)
        stg               %r0,0(%r2)
        stc               %r3,16(%r2)
        lmg               %r12,%r15,96(%r15)
        br                %r14

asm_test::compare_exchange::u128::relaxed_relaxed:
        stmg              %r12,%r15,96(%r15)
        lg                %r0,0(%r4)
        lg                %r1,8(%r4)
        lg                %r12,0(%r5)
        lg                %r13,8(%r5)
        cdsg              %r0,%r12,0(%r3)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        stg               %r1,8(%r2)
        stg               %r0,0(%r2)
        stc               %r3,16(%r2)
        lmg               %r12,%r15,96(%r15)
        br                %r14

asm_test::compare_exchange::u128::release_acquire:
        stmg              %r12,%r15,96(%r15)
        lg                %r0,0(%r4)
        lg                %r1,8(%r4)
        lg                %r12,0(%r5)
        lg                %r13,8(%r5)
        cdsg              %r0,%r12,0(%r3)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        stg               %r1,8(%r2)
        stg               %r0,0(%r2)
        stc               %r3,16(%r2)
        lmg               %r12,%r15,96(%r15)
        br                %r14

asm_test::compare_exchange::u128::release_relaxed:
        stmg              %r12,%r15,96(%r15)
        lg                %r0,0(%r4)
        lg                %r1,8(%r4)
        lg                %r12,0(%r5)
        lg                %r13,8(%r5)
        cdsg              %r0,%r12,0(%r3)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        stg               %r1,8(%r2)
        stg               %r0,0(%r2)
        stc               %r3,16(%r2)
        lmg               %r12,%r15,96(%r15)
        br                %r14

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llcr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,8(%r5)
        risbg             %r4,%r2,32,55
        llcr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-8(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llcr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,8(%r5)
        risbg             %r4,%r2,32,55
        llcr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-8(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llcr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,8(%r5)
        risbg             %r4,%r2,32,55
        llcr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-8(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llcr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,8(%r5)
        risbg             %r4,%r2,32,55
        llcr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-8(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llcr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,8(%r5)
        risbg             %r4,%r2,32,55
        llcr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-8(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llcr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,8(%r5)
        risbg             %r4,%r2,32,55
        llcr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-8(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange_weak::u8::release_seqcst:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llcr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,8(%r5)
        risbg             %r4,%r2,32,55
        llcr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-8(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llcr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,8(%r5)
        risbg             %r4,%r2,32,55
        llcr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-8(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llcr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,8(%r5)
        risbg             %r4,%r2,32,55
        llcr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-8(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange_weak::u8::acquire_acquire:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llcr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,8(%r5)
        risbg             %r4,%r2,32,55
        llcr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-8(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llcr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,8(%r5)
        risbg             %r4,%r2,32,55
        llcr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-8(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llcr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,8(%r5)
        risbg             %r4,%r2,32,55
        llcr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-8(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llcr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,8(%r5)
        risbg             %r4,%r2,32,55
        llcr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-8(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange_weak::u8::release_acquire:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llcr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,8(%r5)
        risbg             %r4,%r2,32,55
        llcr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-8(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange_weak::u8::release_relaxed:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llcr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,8(%r5)
        risbg             %r4,%r2,32,55
        llcr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-8(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llhr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,16(%r5)
        risbg             %r4,%r2,32,47
        llhr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-16(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llhr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,16(%r5)
        risbg             %r4,%r2,32,47
        llhr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-16(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llhr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,16(%r5)
        risbg             %r4,%r2,32,47
        llhr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-16(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llhr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,16(%r5)
        risbg             %r4,%r2,32,47
        llhr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-16(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llhr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,16(%r5)
        risbg             %r4,%r2,32,47
        llhr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-16(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llhr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,16(%r5)
        risbg             %r4,%r2,32,47
        llhr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-16(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange_weak::u16::release_seqcst:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llhr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,16(%r5)
        risbg             %r4,%r2,32,47
        llhr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-16(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llhr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,16(%r5)
        risbg             %r4,%r2,32,47
        llhr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-16(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llhr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,16(%r5)
        risbg             %r4,%r2,32,47
        llhr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-16(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange_weak::u16::acquire_acquire:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llhr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,16(%r5)
        risbg             %r4,%r2,32,47
        llhr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-16(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llhr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,16(%r5)
        risbg             %r4,%r2,32,47
        llhr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-16(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llhr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,16(%r5)
        risbg             %r4,%r2,32,47
        llhr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-16(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llhr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,16(%r5)
        risbg             %r4,%r2,32,47
        llhr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-16(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange_weak::u16::release_acquire:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llhr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,16(%r5)
        risbg             %r4,%r2,32,47
        llhr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-16(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange_weak::u16::release_relaxed:
        stmg              %r13,%r15,104(%r15)
        sllk              %r5,%r2,3
        risbgz            %r1,%r2,0,61
        llhr              %r0,%r3
        lcr               %r3,%r5
        l                 %r14,0(%r1)
0:
        rll               %r2,%r14,16(%r5)
        risbg             %r4,%r2,32,47
        llhr              %r2,%r2
        cr                %r2,%r0
        jlh               1f
        rll               %r13,%r4,-16(%r3)
        cs                %r14,%r13,0(%r1)
        jl                0b
1:
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lmg               %r13,%r15,104(%r15)
        br                %r14

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        lr                %r0,%r3
        cs                %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lr                %r2,%r0
        br                %r14

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        lr                %r0,%r3
        cs                %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lr                %r2,%r0
        br                %r14

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        lr                %r0,%r3
        cs                %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lr                %r2,%r0
        br                %r14

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        lr                %r0,%r3
        cs                %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lr                %r2,%r0
        br                %r14

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        lr                %r0,%r3
        cs                %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lr                %r2,%r0
        br                %r14

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        lr                %r0,%r3
        cs                %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lr                %r2,%r0
        br                %r14

asm_test::compare_exchange_weak::u32::release_seqcst:
        lr                %r0,%r3
        cs                %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lr                %r2,%r0
        br                %r14

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        lr                %r0,%r3
        cs                %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lr                %r2,%r0
        br                %r14

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        lr                %r0,%r3
        cs                %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lr                %r2,%r0
        br                %r14

asm_test::compare_exchange_weak::u32::acquire_acquire:
        lr                %r0,%r3
        cs                %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lr                %r2,%r0
        br                %r14

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        lr                %r0,%r3
        cs                %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lr                %r2,%r0
        br                %r14

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        lr                %r0,%r3
        cs                %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lr                %r2,%r0
        br                %r14

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        lr                %r0,%r3
        cs                %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lr                %r2,%r0
        br                %r14

asm_test::compare_exchange_weak::u32::release_acquire:
        lr                %r0,%r3
        cs                %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lr                %r2,%r0
        br                %r14

asm_test::compare_exchange_weak::u32::release_relaxed:
        lr                %r0,%r3
        cs                %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lr                %r2,%r0
        br                %r14

asm_test::compare_exchange_weak::u64::acqrel_seqcst:
        lgr               %r0,%r3
        csg               %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lgr               %r2,%r0
        br                %r14

asm_test::compare_exchange_weak::u64::seqcst_seqcst:
        lgr               %r0,%r3
        csg               %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lgr               %r2,%r0
        br                %r14

asm_test::compare_exchange_weak::u64::acqrel_acquire:
        lgr               %r0,%r3
        csg               %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lgr               %r2,%r0
        br                %r14

asm_test::compare_exchange_weak::u64::acqrel_relaxed:
        lgr               %r0,%r3
        csg               %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lgr               %r2,%r0
        br                %r14

asm_test::compare_exchange_weak::u64::acquire_seqcst:
        lgr               %r0,%r3
        csg               %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lgr               %r2,%r0
        br                %r14

asm_test::compare_exchange_weak::u64::relaxed_seqcst:
        lgr               %r0,%r3
        csg               %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lgr               %r2,%r0
        br                %r14

asm_test::compare_exchange_weak::u64::release_seqcst:
        lgr               %r0,%r3
        csg               %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lgr               %r2,%r0
        br                %r14

asm_test::compare_exchange_weak::u64::seqcst_acquire:
        lgr               %r0,%r3
        csg               %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lgr               %r2,%r0
        br                %r14

asm_test::compare_exchange_weak::u64::seqcst_relaxed:
        lgr               %r0,%r3
        csg               %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lgr               %r2,%r0
        br                %r14

asm_test::compare_exchange_weak::u64::acquire_acquire:
        lgr               %r0,%r3
        csg               %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lgr               %r2,%r0
        br                %r14

asm_test::compare_exchange_weak::u64::acquire_relaxed:
        lgr               %r0,%r3
        csg               %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lgr               %r2,%r0
        br                %r14

asm_test::compare_exchange_weak::u64::relaxed_acquire:
        lgr               %r0,%r3
        csg               %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lgr               %r2,%r0
        br                %r14

asm_test::compare_exchange_weak::u64::relaxed_relaxed:
        lgr               %r0,%r3
        csg               %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lgr               %r2,%r0
        br                %r14

asm_test::compare_exchange_weak::u64::release_acquire:
        lgr               %r0,%r3
        csg               %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lgr               %r2,%r0
        br                %r14

asm_test::compare_exchange_weak::u64::release_relaxed:
        lgr               %r0,%r3
        csg               %r0,%r4,0(%r2)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        lgr               %r2,%r0
        br                %r14

asm_test::compare_exchange_weak::u128::acqrel_seqcst:
        stmg              %r12,%r15,96(%r15)
        lg                %r0,0(%r4)
        lg                %r1,8(%r4)
        lg                %r12,0(%r5)
        lg                %r13,8(%r5)
        cdsg              %r0,%r12,0(%r3)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        stg               %r1,8(%r2)
        stg               %r0,0(%r2)
        stc               %r3,16(%r2)
        lmg               %r12,%r15,96(%r15)
        br                %r14

asm_test::compare_exchange_weak::u128::seqcst_seqcst:
        stmg              %r12,%r15,96(%r15)
        lg                %r0,0(%r4)
        lg                %r1,8(%r4)
        lg                %r12,0(%r5)
        lg                %r13,8(%r5)
        cdsg              %r0,%r12,0(%r3)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        stg               %r1,8(%r2)
        stg               %r0,0(%r2)
        stc               %r3,16(%r2)
        lmg               %r12,%r15,96(%r15)
        br                %r14

asm_test::compare_exchange_weak::u128::acqrel_acquire:
        stmg              %r12,%r15,96(%r15)
        lg                %r0,0(%r4)
        lg                %r1,8(%r4)
        lg                %r12,0(%r5)
        lg                %r13,8(%r5)
        cdsg              %r0,%r12,0(%r3)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        stg               %r1,8(%r2)
        stg               %r0,0(%r2)
        stc               %r3,16(%r2)
        lmg               %r12,%r15,96(%r15)
        br                %r14

asm_test::compare_exchange_weak::u128::acqrel_relaxed:
        stmg              %r12,%r15,96(%r15)
        lg                %r0,0(%r4)
        lg                %r1,8(%r4)
        lg                %r12,0(%r5)
        lg                %r13,8(%r5)
        cdsg              %r0,%r12,0(%r3)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        stg               %r1,8(%r2)
        stg               %r0,0(%r2)
        stc               %r3,16(%r2)
        lmg               %r12,%r15,96(%r15)
        br                %r14

asm_test::compare_exchange_weak::u128::acquire_seqcst:
        stmg              %r12,%r15,96(%r15)
        lg                %r0,0(%r4)
        lg                %r1,8(%r4)
        lg                %r12,0(%r5)
        lg                %r13,8(%r5)
        cdsg              %r0,%r12,0(%r3)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        stg               %r1,8(%r2)
        stg               %r0,0(%r2)
        stc               %r3,16(%r2)
        lmg               %r12,%r15,96(%r15)
        br                %r14

asm_test::compare_exchange_weak::u128::relaxed_seqcst:
        stmg              %r12,%r15,96(%r15)
        lg                %r0,0(%r4)
        lg                %r1,8(%r4)
        lg                %r12,0(%r5)
        lg                %r13,8(%r5)
        cdsg              %r0,%r12,0(%r3)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        stg               %r1,8(%r2)
        stg               %r0,0(%r2)
        stc               %r3,16(%r2)
        lmg               %r12,%r15,96(%r15)
        br                %r14

asm_test::compare_exchange_weak::u128::release_seqcst:
        stmg              %r12,%r15,96(%r15)
        lg                %r0,0(%r4)
        lg                %r1,8(%r4)
        lg                %r12,0(%r5)
        lg                %r13,8(%r5)
        cdsg              %r0,%r12,0(%r3)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        stg               %r1,8(%r2)
        stg               %r0,0(%r2)
        stc               %r3,16(%r2)
        lmg               %r12,%r15,96(%r15)
        br                %r14

asm_test::compare_exchange_weak::u128::seqcst_acquire:
        stmg              %r12,%r15,96(%r15)
        lg                %r0,0(%r4)
        lg                %r1,8(%r4)
        lg                %r12,0(%r5)
        lg                %r13,8(%r5)
        cdsg              %r0,%r12,0(%r3)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        stg               %r1,8(%r2)
        stg               %r0,0(%r2)
        stc               %r3,16(%r2)
        lmg               %r12,%r15,96(%r15)
        br                %r14

asm_test::compare_exchange_weak::u128::seqcst_relaxed:
        stmg              %r12,%r15,96(%r15)
        lg                %r0,0(%r4)
        lg                %r1,8(%r4)
        lg                %r12,0(%r5)
        lg                %r13,8(%r5)
        cdsg              %r0,%r12,0(%r3)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        stg               %r1,8(%r2)
        stg               %r0,0(%r2)
        stc               %r3,16(%r2)
        lmg               %r12,%r15,96(%r15)
        br                %r14

asm_test::compare_exchange_weak::u128::acquire_acquire:
        stmg              %r12,%r15,96(%r15)
        lg                %r0,0(%r4)
        lg                %r1,8(%r4)
        lg                %r12,0(%r5)
        lg                %r13,8(%r5)
        cdsg              %r0,%r12,0(%r3)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        stg               %r1,8(%r2)
        stg               %r0,0(%r2)
        stc               %r3,16(%r2)
        lmg               %r12,%r15,96(%r15)
        br                %r14

asm_test::compare_exchange_weak::u128::acquire_relaxed:
        stmg              %r12,%r15,96(%r15)
        lg                %r0,0(%r4)
        lg                %r1,8(%r4)
        lg                %r12,0(%r5)
        lg                %r13,8(%r5)
        cdsg              %r0,%r12,0(%r3)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        stg               %r1,8(%r2)
        stg               %r0,0(%r2)
        stc               %r3,16(%r2)
        lmg               %r12,%r15,96(%r15)
        br                %r14

asm_test::compare_exchange_weak::u128::relaxed_acquire:
        stmg              %r12,%r15,96(%r15)
        lg                %r0,0(%r4)
        lg                %r1,8(%r4)
        lg                %r12,0(%r5)
        lg                %r13,8(%r5)
        cdsg              %r0,%r12,0(%r3)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        stg               %r1,8(%r2)
        stg               %r0,0(%r2)
        stc               %r3,16(%r2)
        lmg               %r12,%r15,96(%r15)
        br                %r14

asm_test::compare_exchange_weak::u128::relaxed_relaxed:
        stmg              %r12,%r15,96(%r15)
        lg                %r0,0(%r4)
        lg                %r1,8(%r4)
        lg                %r12,0(%r5)
        lg                %r13,8(%r5)
        cdsg              %r0,%r12,0(%r3)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        stg               %r1,8(%r2)
        stg               %r0,0(%r2)
        stc               %r3,16(%r2)
        lmg               %r12,%r15,96(%r15)
        br                %r14

asm_test::compare_exchange_weak::u128::release_acquire:
        stmg              %r12,%r15,96(%r15)
        lg                %r0,0(%r4)
        lg                %r1,8(%r4)
        lg                %r12,0(%r5)
        lg                %r13,8(%r5)
        cdsg              %r0,%r12,0(%r3)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        stg               %r1,8(%r2)
        stg               %r0,0(%r2)
        stc               %r3,16(%r2)
        lmg               %r12,%r15,96(%r15)
        br                %r14

asm_test::compare_exchange_weak::u128::release_relaxed:
        stmg              %r12,%r15,96(%r15)
        lg                %r0,0(%r4)
        lg                %r1,8(%r4)
        lg                %r12,0(%r5)
        lg                %r13,8(%r5)
        cdsg              %r0,%r12,0(%r3)
        ipm               %r3
        afi               %r3,-268435456
        srl               %r3,31
        stg               %r1,8(%r2)
        stg               %r0,0(%r2)
        stc               %r3,16(%r2)
        lmg               %r12,%r15,96(%r15)
        br                %r14

asm_test::load::u8::seqcst:
        lb                %r2,0(%r2)
        br                %r14

asm_test::load::u8::acquire:
        lb                %r2,0(%r2)
        br                %r14

asm_test::load::u8::relaxed:
        lb                %r2,0(%r2)
        br                %r14

asm_test::load::u16::seqcst:
        lh                %r2,0(%r2)
        br                %r14

asm_test::load::u16::acquire:
        lh                %r2,0(%r2)
        br                %r14

asm_test::load::u16::relaxed:
        lh                %r2,0(%r2)
        br                %r14

asm_test::load::u32::seqcst:
        l                 %r2,0(%r2)
        br                %r14

asm_test::load::u32::acquire:
        l                 %r2,0(%r2)
        br                %r14

asm_test::load::u32::relaxed:
        l                 %r2,0(%r2)
        br                %r14

asm_test::load::u64::seqcst:
        lg                %r2,0(%r2)
        br                %r14

asm_test::load::u64::acquire:
        lg                %r2,0(%r2)
        br                %r14

asm_test::load::u64::relaxed:
        lg                %r2,0(%r2)
        br                %r14

asm_test::load::u128::seqcst:
        lpq               %r0,0(%r3)
        stg               %r1,8(%r2)
        stg               %r0,0(%r2)
        br                %r14

asm_test::load::u128::acquire:
        lpq               %r0,0(%r3)
        stg               %r1,8(%r2)
        stg               %r0,0(%r2)
        br                %r14

asm_test::load::u128::relaxed:
        lpq               %r0,0(%r3)
        stg               %r1,8(%r2)
        stg               %r0,0(%r2)
        br                %r14

asm_test::swap::u8::acqrel:
        sllk              %r4,%r2,3
        risbgz            %r1,%r2,0,61
        lcr               %r5,%r4
        l                 %r0,0(%r1)
0:
        rll               %r2,%r0,0(%r4)
        risbg             %r2,%r3,32,39,24
        rll               %r2,%r2,0(%r5)
        cs                %r0,%r2,0(%r1)
        jl                0b
        rll               %r2,%r0,8(%r4)
        br                %r14

asm_test::swap::u8::seqcst:
        sllk              %r4,%r2,3
        risbgz            %r1,%r2,0,61
        lcr               %r5,%r4
        l                 %r0,0(%r1)
0:
        rll               %r2,%r0,0(%r4)
        risbg             %r2,%r3,32,39,24
        rll               %r2,%r2,0(%r5)
        cs                %r0,%r2,0(%r1)
        jl                0b
        rll               %r2,%r0,8(%r4)
        br                %r14

asm_test::swap::u8::acquire:
        sllk              %r4,%r2,3
        risbgz            %r1,%r2,0,61
        lcr               %r5,%r4
        l                 %r0,0(%r1)
0:
        rll               %r2,%r0,0(%r4)
        risbg             %r2,%r3,32,39,24
        rll               %r2,%r2,0(%r5)
        cs                %r0,%r2,0(%r1)
        jl                0b
        rll               %r2,%r0,8(%r4)
        br                %r14

asm_test::swap::u8::relaxed:
        sllk              %r4,%r2,3
        risbgz            %r1,%r2,0,61
        lcr               %r5,%r4
        l                 %r0,0(%r1)
0:
        rll               %r2,%r0,0(%r4)
        risbg             %r2,%r3,32,39,24
        rll               %r2,%r2,0(%r5)
        cs                %r0,%r2,0(%r1)
        jl                0b
        rll               %r2,%r0,8(%r4)
        br                %r14

asm_test::swap::u8::release:
        sllk              %r4,%r2,3
        risbgz            %r1,%r2,0,61
        lcr               %r5,%r4
        l                 %r0,0(%r1)
0:
        rll               %r2,%r0,0(%r4)
        risbg             %r2,%r3,32,39,24
        rll               %r2,%r2,0(%r5)
        cs                %r0,%r2,0(%r1)
        jl                0b
        rll               %r2,%r0,8(%r4)
        br                %r14

asm_test::swap::u16::acqrel:
        sllk              %r4,%r2,3
        risbgz            %r1,%r2,0,61
        lcr               %r5,%r4
        l                 %r0,0(%r1)
0:
        rll               %r2,%r0,0(%r4)
        risbg             %r2,%r3,32,47,16
        rll               %r2,%r2,0(%r5)
        cs                %r0,%r2,0(%r1)
        jl                0b
        rll               %r2,%r0,16(%r4)
        br                %r14

asm_test::swap::u16::seqcst:
        sllk              %r4,%r2,3
        risbgz            %r1,%r2,0,61
        lcr               %r5,%r4
        l                 %r0,0(%r1)
0:
        rll               %r2,%r0,0(%r4)
        risbg             %r2,%r3,32,47,16
        rll               %r2,%r2,0(%r5)
        cs                %r0,%r2,0(%r1)
        jl                0b
        rll               %r2,%r0,16(%r4)
        br                %r14

asm_test::swap::u16::acquire:
        sllk              %r4,%r2,3
        risbgz            %r1,%r2,0,61
        lcr               %r5,%r4
        l                 %r0,0(%r1)
0:
        rll               %r2,%r0,0(%r4)
        risbg             %r2,%r3,32,47,16
        rll               %r2,%r2,0(%r5)
        cs                %r0,%r2,0(%r1)
        jl                0b
        rll               %r2,%r0,16(%r4)
        br                %r14

asm_test::swap::u16::relaxed:
        sllk              %r4,%r2,3
        risbgz            %r1,%r2,0,61
        lcr               %r5,%r4
        l                 %r0,0(%r1)
0:
        rll               %r2,%r0,0(%r4)
        risbg             %r2,%r3,32,47,16
        rll               %r2,%r2,0(%r5)
        cs                %r0,%r2,0(%r1)
        jl                0b
        rll               %r2,%r0,16(%r4)
        br                %r14

asm_test::swap::u16::release:
        sllk              %r4,%r2,3
        risbgz            %r1,%r2,0,61
        lcr               %r5,%r4
        l                 %r0,0(%r1)
0:
        rll               %r2,%r0,0(%r4)
        risbg             %r2,%r3,32,47,16
        rll               %r2,%r2,0(%r5)
        cs                %r0,%r2,0(%r1)
        jl                0b
        rll               %r2,%r0,16(%r4)
        br                %r14

asm_test::swap::u32::acqrel:
        l                 %r0,0(%r2)
0:
        cs                %r0,%r3,0(%r2)
        jl                0b
        lr                %r2,%r0
        br                %r14

asm_test::swap::u32::seqcst:
        l                 %r0,0(%r2)
0:
        cs                %r0,%r3,0(%r2)
        jl                0b
        lr                %r2,%r0
        br                %r14

asm_test::swap::u32::acquire:
        l                 %r0,0(%r2)
0:
        cs                %r0,%r3,0(%r2)
        jl                0b
        lr                %r2,%r0
        br                %r14

asm_test::swap::u32::relaxed:
        l                 %r0,0(%r2)
0:
        cs                %r0,%r3,0(%r2)
        jl                0b
        lr                %r2,%r0
        br                %r14

asm_test::swap::u32::release:
        l                 %r0,0(%r2)
0:
        cs                %r0,%r3,0(%r2)
        jl                0b
        lr                %r2,%r0
        br                %r14

asm_test::swap::u64::acqrel:
        lg                %r0,0(%r2)
0:
        csg               %r0,%r3,0(%r2)
        jl                0b
        lgr               %r2,%r0
        br                %r14

asm_test::swap::u64::seqcst:
        lg                %r0,0(%r2)
0:
        csg               %r0,%r3,0(%r2)
        jl                0b
        lgr               %r2,%r0
        br                %r14

asm_test::swap::u64::acquire:
        lg                %r0,0(%r2)
0:
        csg               %r0,%r3,0(%r2)
        jl                0b
        lgr               %r2,%r0
        br                %r14

asm_test::swap::u64::relaxed:
        lg                %r0,0(%r2)
0:
        csg               %r0,%r3,0(%r2)
        jl                0b
        lgr               %r2,%r0
        br                %r14

asm_test::swap::u64::release:
        lg                %r0,0(%r2)
0:
        csg               %r0,%r3,0(%r2)
        jl                0b
        lgr               %r2,%r0
        br                %r14

asm_test::swap::u128::acqrel:
        stmg              %r12,%r15,96(%r15)
        lg                %r12,0(%r4)
        lg                %r13,8(%r4)
        lg                %r0,8(%r3)
        lg                %r1,0(%r3)
0:
        cdsg              %r0,%r12,0(%r3)
        jl                0b
        stg               %r1,8(%r2)
        stg               %r0,0(%r2)
        lmg               %r12,%r15,96(%r15)
        br                %r14

asm_test::swap::u128::seqcst:
        stmg              %r12,%r15,96(%r15)
        lg                %r12,0(%r4)
        lg                %r13,8(%r4)
        lg                %r0,8(%r3)
        lg                %r1,0(%r3)
0:
        cdsg              %r0,%r12,0(%r3)
        jl                0b
        stg               %r1,8(%r2)
        stg               %r0,0(%r2)
        lmg               %r12,%r15,96(%r15)
        br                %r14

asm_test::swap::u128::acquire:
        stmg              %r12,%r15,96(%r15)
        lg                %r12,0(%r4)
        lg                %r13,8(%r4)
        lg                %r0,8(%r3)
        lg                %r1,0(%r3)
0:
        cdsg              %r0,%r12,0(%r3)
        jl                0b
        stg               %r1,8(%r2)
        stg               %r0,0(%r2)
        lmg               %r12,%r15,96(%r15)
        br                %r14

asm_test::swap::u128::relaxed:
        stmg              %r12,%r15,96(%r15)
        lg                %r12,0(%r4)
        lg                %r13,8(%r4)
        lg                %r0,8(%r3)
        lg                %r1,0(%r3)
0:
        cdsg              %r0,%r12,0(%r3)
        jl                0b
        stg               %r1,8(%r2)
        stg               %r0,0(%r2)
        lmg               %r12,%r15,96(%r15)
        br                %r14

asm_test::swap::u128::release:
        stmg              %r12,%r15,96(%r15)
        lg                %r12,0(%r4)
        lg                %r13,8(%r4)
        lg                %r0,8(%r3)
        lg                %r1,0(%r3)
0:
        cdsg              %r0,%r12,0(%r3)
        jl                0b
        stg               %r1,8(%r2)
        stg               %r0,0(%r2)
        lmg               %r12,%r15,96(%r15)
        br                %r14

asm_test::store::u8::seqcst:
        stc               %r3,0(%r2)
        bnor              %r0
        br                %r14

asm_test::store::u8::relaxed:
        stc               %r3,0(%r2)
        br                %r14

asm_test::store::u8::release:
        stc               %r3,0(%r2)
        br                %r14

asm_test::store::u16::seqcst:
        sth               %r3,0(%r2)
        bnor              %r0
        br                %r14

asm_test::store::u16::relaxed:
        sth               %r3,0(%r2)
        br                %r14

asm_test::store::u16::release:
        sth               %r3,0(%r2)
        br                %r14

asm_test::store::u32::seqcst:
        st                %r3,0(%r2)
        bnor              %r0
        br                %r14

asm_test::store::u32::relaxed:
        st                %r3,0(%r2)
        br                %r14

asm_test::store::u32::release:
        st                %r3,0(%r2)
        br                %r14

asm_test::store::u64::seqcst:
        stg               %r3,0(%r2)
        bnor              %r0
        br                %r14

asm_test::store::u64::relaxed:
        stg               %r3,0(%r2)
        br                %r14

asm_test::store::u64::release:
        stg               %r3,0(%r2)
        br                %r14

asm_test::store::u128::seqcst:
        lg                %r0,0(%r3)
        lg                %r1,8(%r3)
        stpq              %r0,0(%r2)
        bnor              %r0
        br                %r14

asm_test::store::u128::relaxed:
        lg                %r0,0(%r3)
        lg                %r1,8(%r3)
        stpq              %r0,0(%r2)
        br                %r14

asm_test::store::u128::release:
        lg                %r0,0(%r3)
        lg                %r1,8(%r3)
        stpq              %r0,0(%r2)
        br                %r14

