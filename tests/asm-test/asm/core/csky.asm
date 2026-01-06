asm_test::compare_exchange::u8::acqrel_seqcst:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange::u8::acqrel_seqcst+0x3c>
        st.b              r1, (r14, 0x7)
        movi              r1, 5
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange::u8::acqrel_seqcst+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 7
        movi              r3, 4
        jsr               r12
        mov               r1, r0
        ld.b              r0, (r14, 0x7)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange::u8::seqcst_seqcst:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange::u8::seqcst_seqcst+0x3c>
        st.b              r1, (r14, 0x7)
        movi              r1, 5
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange::u8::seqcst_seqcst+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 7
        movi              r3, 5
        jsr               r12
        mov               r1, r0
        ld.b              r0, (r14, 0x7)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange::u8::acqrel_acquire:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange::u8::acqrel_acquire+0x3c>
        st.b              r1, (r14, 0x7)
        movi              r1, 2
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange::u8::acqrel_acquire+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 7
        movi              r3, 4
        jsr               r12
        mov               r1, r0
        ld.b              r0, (r14, 0x7)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange::u8::acqrel_relaxed:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange::u8::acqrel_relaxed+0x3c>
        st.b              r1, (r14, 0x7)
        movi              r1, 0
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange::u8::acqrel_relaxed+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 7
        movi              r3, 4
        jsr               r12
        mov               r1, r0
        ld.b              r0, (r14, 0x7)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange::u8::acquire_seqcst:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange::u8::acquire_seqcst+0x3c>
        st.b              r1, (r14, 0x7)
        movi              r1, 5
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange::u8::acquire_seqcst+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 7
        movi              r3, 2
        jsr               r12
        mov               r1, r0
        ld.b              r0, (r14, 0x7)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange::u8::relaxed_seqcst:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange::u8::relaxed_seqcst+0x3c>
        st.b              r1, (r14, 0x7)
        movi              r1, 5
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange::u8::relaxed_seqcst+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 7
        movi              r3, 0
        jsr               r12
        mov               r1, r0
        ld.b              r0, (r14, 0x7)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange::u8::release_seqcst:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange::u8::release_seqcst+0x3c>
        st.b              r1, (r14, 0x7)
        movi              r1, 5
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange::u8::release_seqcst+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 7
        movi              r3, 3
        jsr               r12
        mov               r1, r0
        ld.b              r0, (r14, 0x7)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange::u8::seqcst_acquire:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange::u8::seqcst_acquire+0x3c>
        st.b              r1, (r14, 0x7)
        movi              r1, 2
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange::u8::seqcst_acquire+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 7
        movi              r3, 5
        jsr               r12
        mov               r1, r0
        ld.b              r0, (r14, 0x7)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange::u8::seqcst_relaxed:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange::u8::seqcst_relaxed+0x3c>
        st.b              r1, (r14, 0x7)
        movi              r1, 0
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange::u8::seqcst_relaxed+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 7
        movi              r3, 5
        jsr               r12
        mov               r1, r0
        ld.b              r0, (r14, 0x7)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange::u8::acquire_acquire:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange::u8::acquire_acquire+0x3c>
        st.b              r1, (r14, 0x7)
        movi              r1, 2
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange::u8::acquire_acquire+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 7
        movi              r3, 2
        jsr               r12
        mov               r1, r0
        ld.b              r0, (r14, 0x7)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange::u8::acquire_relaxed:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange::u8::acquire_relaxed+0x3c>
        st.b              r1, (r14, 0x7)
        movi              r1, 0
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange::u8::acquire_relaxed+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 7
        movi              r3, 2
        jsr               r12
        mov               r1, r0
        ld.b              r0, (r14, 0x7)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange::u8::relaxed_acquire:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange::u8::relaxed_acquire+0x3c>
        st.b              r1, (r14, 0x7)
        movi              r1, 2
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange::u8::relaxed_acquire+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 7
        movi              r3, 0
        jsr               r12
        mov               r1, r0
        ld.b              r0, (r14, 0x7)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange::u8::relaxed_relaxed:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange::u8::relaxed_relaxed+0x3c>
        st.b              r1, (r14, 0x7)
        movi              r1, 0
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange::u8::relaxed_relaxed+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 7
        movi              r3, 0
        jsr               r12
        mov               r1, r0
        ld.b              r0, (r14, 0x7)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange::u8::release_acquire:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange::u8::release_acquire+0x3c>
        st.b              r1, (r14, 0x7)
        movi              r1, 2
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange::u8::release_acquire+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 7
        movi              r3, 3
        jsr               r12
        mov               r1, r0
        ld.b              r0, (r14, 0x7)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange::u8::release_relaxed:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange::u8::release_relaxed+0x3c>
        st.b              r1, (r14, 0x7)
        movi              r1, 0
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange::u8::release_relaxed+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 7
        movi              r3, 3
        jsr               r12
        mov               r1, r0
        ld.b              r0, (r14, 0x7)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange::u16::acqrel_seqcst:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange::u16::acqrel_seqcst+0x3c>
        st.h              r1, (r14, 0x6)
        movi              r1, 5
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange::u16::acqrel_seqcst+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 6
        movi              r3, 4
        jsr               r12
        mov               r1, r0
        ld.h              r0, (r14, 0x6)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange::u16::seqcst_seqcst:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange::u16::seqcst_seqcst+0x3c>
        st.h              r1, (r14, 0x6)
        movi              r1, 5
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange::u16::seqcst_seqcst+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 6
        movi              r3, 5
        jsr               r12
        mov               r1, r0
        ld.h              r0, (r14, 0x6)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange::u16::acqrel_acquire:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange::u16::acqrel_acquire+0x3c>
        st.h              r1, (r14, 0x6)
        movi              r1, 2
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange::u16::acqrel_acquire+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 6
        movi              r3, 4
        jsr               r12
        mov               r1, r0
        ld.h              r0, (r14, 0x6)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange::u16::acqrel_relaxed:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange::u16::acqrel_relaxed+0x3c>
        st.h              r1, (r14, 0x6)
        movi              r1, 0
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange::u16::acqrel_relaxed+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 6
        movi              r3, 4
        jsr               r12
        mov               r1, r0
        ld.h              r0, (r14, 0x6)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange::u16::acquire_seqcst:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange::u16::acquire_seqcst+0x3c>
        st.h              r1, (r14, 0x6)
        movi              r1, 5
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange::u16::acquire_seqcst+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 6
        movi              r3, 2
        jsr               r12
        mov               r1, r0
        ld.h              r0, (r14, 0x6)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange::u16::relaxed_seqcst:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange::u16::relaxed_seqcst+0x3c>
        st.h              r1, (r14, 0x6)
        movi              r1, 5
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange::u16::relaxed_seqcst+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 6
        movi              r3, 0
        jsr               r12
        mov               r1, r0
        ld.h              r0, (r14, 0x6)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange::u16::release_seqcst:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange::u16::release_seqcst+0x3c>
        st.h              r1, (r14, 0x6)
        movi              r1, 5
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange::u16::release_seqcst+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 6
        movi              r3, 3
        jsr               r12
        mov               r1, r0
        ld.h              r0, (r14, 0x6)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange::u16::seqcst_acquire:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange::u16::seqcst_acquire+0x3c>
        st.h              r1, (r14, 0x6)
        movi              r1, 2
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange::u16::seqcst_acquire+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 6
        movi              r3, 5
        jsr               r12
        mov               r1, r0
        ld.h              r0, (r14, 0x6)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange::u16::seqcst_relaxed:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange::u16::seqcst_relaxed+0x3c>
        st.h              r1, (r14, 0x6)
        movi              r1, 0
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange::u16::seqcst_relaxed+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 6
        movi              r3, 5
        jsr               r12
        mov               r1, r0
        ld.h              r0, (r14, 0x6)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange::u16::acquire_acquire:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange::u16::acquire_acquire+0x3c>
        st.h              r1, (r14, 0x6)
        movi              r1, 2
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange::u16::acquire_acquire+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 6
        movi              r3, 2
        jsr               r12
        mov               r1, r0
        ld.h              r0, (r14, 0x6)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange::u16::acquire_relaxed:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange::u16::acquire_relaxed+0x3c>
        st.h              r1, (r14, 0x6)
        movi              r1, 0
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange::u16::acquire_relaxed+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 6
        movi              r3, 2
        jsr               r12
        mov               r1, r0
        ld.h              r0, (r14, 0x6)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange::u16::relaxed_acquire:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange::u16::relaxed_acquire+0x3c>
        st.h              r1, (r14, 0x6)
        movi              r1, 2
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange::u16::relaxed_acquire+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 6
        movi              r3, 0
        jsr               r12
        mov               r1, r0
        ld.h              r0, (r14, 0x6)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange::u16::relaxed_relaxed:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange::u16::relaxed_relaxed+0x3c>
        st.h              r1, (r14, 0x6)
        movi              r1, 0
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange::u16::relaxed_relaxed+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 6
        movi              r3, 0
        jsr               r12
        mov               r1, r0
        ld.h              r0, (r14, 0x6)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange::u16::release_acquire:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange::u16::release_acquire+0x3c>
        st.h              r1, (r14, 0x6)
        movi              r1, 2
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange::u16::release_acquire+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 6
        movi              r3, 3
        jsr               r12
        mov               r1, r0
        ld.h              r0, (r14, 0x6)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange::u16::release_relaxed:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange::u16::release_relaxed+0x3c>
        st.h              r1, (r14, 0x6)
        movi              r1, 0
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange::u16::release_relaxed+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 6
        movi              r3, 3
        jsr               r12
        mov               r1, r0
        ld.h              r0, (r14, 0x6)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange::u32::acqrel_seqcst:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 38 <asm_test::compare_exchange::u32::acqrel_seqcst+0x38>
        st.w              r1, (r14, 0x4)
        movi              r1, 5
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 3c <asm_test::compare_exchange::u32::acqrel_seqcst+0x3c>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 4
        movi              r3, 4
        jsr               r12
        mov               r1, r0
        ld.w              r0, (r14, 0x4)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange::u32::seqcst_seqcst:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 38 <asm_test::compare_exchange::u32::seqcst_seqcst+0x38>
        st.w              r1, (r14, 0x4)
        movi              r1, 5
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 3c <asm_test::compare_exchange::u32::seqcst_seqcst+0x3c>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 4
        movi              r3, 5
        jsr               r12
        mov               r1, r0
        ld.w              r0, (r14, 0x4)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange::u32::acqrel_acquire:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 38 <asm_test::compare_exchange::u32::acqrel_acquire+0x38>
        st.w              r1, (r14, 0x4)
        movi              r1, 2
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 3c <asm_test::compare_exchange::u32::acqrel_acquire+0x3c>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 4
        movi              r3, 4
        jsr               r12
        mov               r1, r0
        ld.w              r0, (r14, 0x4)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange::u32::acqrel_relaxed:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 38 <asm_test::compare_exchange::u32::acqrel_relaxed+0x38>
        st.w              r1, (r14, 0x4)
        movi              r1, 0
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 3c <asm_test::compare_exchange::u32::acqrel_relaxed+0x3c>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 4
        movi              r3, 4
        jsr               r12
        mov               r1, r0
        ld.w              r0, (r14, 0x4)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange::u32::acquire_seqcst:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 38 <asm_test::compare_exchange::u32::acquire_seqcst+0x38>
        st.w              r1, (r14, 0x4)
        movi              r1, 5
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 3c <asm_test::compare_exchange::u32::acquire_seqcst+0x3c>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 4
        movi              r3, 2
        jsr               r12
        mov               r1, r0
        ld.w              r0, (r14, 0x4)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange::u32::relaxed_seqcst:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 38 <asm_test::compare_exchange::u32::relaxed_seqcst+0x38>
        st.w              r1, (r14, 0x4)
        movi              r1, 5
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 3c <asm_test::compare_exchange::u32::relaxed_seqcst+0x3c>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 4
        movi              r3, 0
        jsr               r12
        mov               r1, r0
        ld.w              r0, (r14, 0x4)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange::u32::release_seqcst:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 38 <asm_test::compare_exchange::u32::release_seqcst+0x38>
        st.w              r1, (r14, 0x4)
        movi              r1, 5
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 3c <asm_test::compare_exchange::u32::release_seqcst+0x3c>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 4
        movi              r3, 3
        jsr               r12
        mov               r1, r0
        ld.w              r0, (r14, 0x4)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange::u32::seqcst_acquire:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 38 <asm_test::compare_exchange::u32::seqcst_acquire+0x38>
        st.w              r1, (r14, 0x4)
        movi              r1, 2
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 3c <asm_test::compare_exchange::u32::seqcst_acquire+0x3c>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 4
        movi              r3, 5
        jsr               r12
        mov               r1, r0
        ld.w              r0, (r14, 0x4)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange::u32::seqcst_relaxed:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 38 <asm_test::compare_exchange::u32::seqcst_relaxed+0x38>
        st.w              r1, (r14, 0x4)
        movi              r1, 0
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 3c <asm_test::compare_exchange::u32::seqcst_relaxed+0x3c>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 4
        movi              r3, 5
        jsr               r12
        mov               r1, r0
        ld.w              r0, (r14, 0x4)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange::u32::acquire_acquire:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 38 <asm_test::compare_exchange::u32::acquire_acquire+0x38>
        st.w              r1, (r14, 0x4)
        movi              r1, 2
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 3c <asm_test::compare_exchange::u32::acquire_acquire+0x3c>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 4
        movi              r3, 2
        jsr               r12
        mov               r1, r0
        ld.w              r0, (r14, 0x4)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange::u32::acquire_relaxed:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 38 <asm_test::compare_exchange::u32::acquire_relaxed+0x38>
        st.w              r1, (r14, 0x4)
        movi              r1, 0
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 3c <asm_test::compare_exchange::u32::acquire_relaxed+0x3c>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 4
        movi              r3, 2
        jsr               r12
        mov               r1, r0
        ld.w              r0, (r14, 0x4)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange::u32::relaxed_acquire:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 38 <asm_test::compare_exchange::u32::relaxed_acquire+0x38>
        st.w              r1, (r14, 0x4)
        movi              r1, 2
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 3c <asm_test::compare_exchange::u32::relaxed_acquire+0x3c>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 4
        movi              r3, 0
        jsr               r12
        mov               r1, r0
        ld.w              r0, (r14, 0x4)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange::u32::relaxed_relaxed:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 38 <asm_test::compare_exchange::u32::relaxed_relaxed+0x38>
        st.w              r1, (r14, 0x4)
        movi              r1, 0
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 3c <asm_test::compare_exchange::u32::relaxed_relaxed+0x3c>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 4
        movi              r3, 0
        jsr               r12
        mov               r1, r0
        ld.w              r0, (r14, 0x4)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange::u32::release_acquire:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 38 <asm_test::compare_exchange::u32::release_acquire+0x38>
        st.w              r1, (r14, 0x4)
        movi              r1, 2
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 3c <asm_test::compare_exchange::u32::release_acquire+0x3c>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 4
        movi              r3, 3
        jsr               r12
        mov               r1, r0
        ld.w              r0, (r14, 0x4)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange::u32::release_relaxed:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 38 <asm_test::compare_exchange::u32::release_relaxed+0x38>
        st.w              r1, (r14, 0x4)
        movi              r1, 0
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 3c <asm_test::compare_exchange::u32::release_relaxed+0x3c>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 4
        movi              r3, 3
        jsr               r12
        mov               r1, r0
        ld.w              r0, (r14, 0x4)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange_weak::u8::acqrel_seqcst+0x3c>
        st.b              r1, (r14, 0x7)
        movi              r1, 5
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange_weak::u8::acqrel_seqcst+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 7
        movi              r3, 4
        jsr               r12
        mov               r1, r0
        ld.b              r0, (r14, 0x7)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange_weak::u8::seqcst_seqcst+0x3c>
        st.b              r1, (r14, 0x7)
        movi              r1, 5
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange_weak::u8::seqcst_seqcst+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 7
        movi              r3, 5
        jsr               r12
        mov               r1, r0
        ld.b              r0, (r14, 0x7)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange_weak::u8::acqrel_acquire+0x3c>
        st.b              r1, (r14, 0x7)
        movi              r1, 2
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange_weak::u8::acqrel_acquire+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 7
        movi              r3, 4
        jsr               r12
        mov               r1, r0
        ld.b              r0, (r14, 0x7)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange_weak::u8::acqrel_relaxed+0x3c>
        st.b              r1, (r14, 0x7)
        movi              r1, 0
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange_weak::u8::acqrel_relaxed+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 7
        movi              r3, 4
        jsr               r12
        mov               r1, r0
        ld.b              r0, (r14, 0x7)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange_weak::u8::acquire_seqcst+0x3c>
        st.b              r1, (r14, 0x7)
        movi              r1, 5
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange_weak::u8::acquire_seqcst+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 7
        movi              r3, 2
        jsr               r12
        mov               r1, r0
        ld.b              r0, (r14, 0x7)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange_weak::u8::relaxed_seqcst+0x3c>
        st.b              r1, (r14, 0x7)
        movi              r1, 5
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange_weak::u8::relaxed_seqcst+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 7
        movi              r3, 0
        jsr               r12
        mov               r1, r0
        ld.b              r0, (r14, 0x7)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u8::release_seqcst:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange_weak::u8::release_seqcst+0x3c>
        st.b              r1, (r14, 0x7)
        movi              r1, 5
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange_weak::u8::release_seqcst+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 7
        movi              r3, 3
        jsr               r12
        mov               r1, r0
        ld.b              r0, (r14, 0x7)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange_weak::u8::seqcst_acquire+0x3c>
        st.b              r1, (r14, 0x7)
        movi              r1, 2
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange_weak::u8::seqcst_acquire+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 7
        movi              r3, 5
        jsr               r12
        mov               r1, r0
        ld.b              r0, (r14, 0x7)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange_weak::u8::seqcst_relaxed+0x3c>
        st.b              r1, (r14, 0x7)
        movi              r1, 0
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange_weak::u8::seqcst_relaxed+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 7
        movi              r3, 5
        jsr               r12
        mov               r1, r0
        ld.b              r0, (r14, 0x7)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u8::acquire_acquire:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange_weak::u8::acquire_acquire+0x3c>
        st.b              r1, (r14, 0x7)
        movi              r1, 2
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange_weak::u8::acquire_acquire+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 7
        movi              r3, 2
        jsr               r12
        mov               r1, r0
        ld.b              r0, (r14, 0x7)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange_weak::u8::acquire_relaxed+0x3c>
        st.b              r1, (r14, 0x7)
        movi              r1, 0
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange_weak::u8::acquire_relaxed+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 7
        movi              r3, 2
        jsr               r12
        mov               r1, r0
        ld.b              r0, (r14, 0x7)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange_weak::u8::relaxed_acquire+0x3c>
        st.b              r1, (r14, 0x7)
        movi              r1, 2
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange_weak::u8::relaxed_acquire+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 7
        movi              r3, 0
        jsr               r12
        mov               r1, r0
        ld.b              r0, (r14, 0x7)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange_weak::u8::relaxed_relaxed+0x3c>
        st.b              r1, (r14, 0x7)
        movi              r1, 0
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange_weak::u8::relaxed_relaxed+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 7
        movi              r3, 0
        jsr               r12
        mov               r1, r0
        ld.b              r0, (r14, 0x7)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u8::release_acquire:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange_weak::u8::release_acquire+0x3c>
        st.b              r1, (r14, 0x7)
        movi              r1, 2
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange_weak::u8::release_acquire+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 7
        movi              r3, 3
        jsr               r12
        mov               r1, r0
        ld.b              r0, (r14, 0x7)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u8::release_relaxed:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange_weak::u8::release_relaxed+0x3c>
        st.b              r1, (r14, 0x7)
        movi              r1, 0
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange_weak::u8::release_relaxed+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 7
        movi              r3, 3
        jsr               r12
        mov               r1, r0
        ld.b              r0, (r14, 0x7)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange_weak::u16::acqrel_seqcst+0x3c>
        st.h              r1, (r14, 0x6)
        movi              r1, 5
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange_weak::u16::acqrel_seqcst+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 6
        movi              r3, 4
        jsr               r12
        mov               r1, r0
        ld.h              r0, (r14, 0x6)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange_weak::u16::seqcst_seqcst+0x3c>
        st.h              r1, (r14, 0x6)
        movi              r1, 5
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange_weak::u16::seqcst_seqcst+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 6
        movi              r3, 5
        jsr               r12
        mov               r1, r0
        ld.h              r0, (r14, 0x6)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange_weak::u16::acqrel_acquire+0x3c>
        st.h              r1, (r14, 0x6)
        movi              r1, 2
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange_weak::u16::acqrel_acquire+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 6
        movi              r3, 4
        jsr               r12
        mov               r1, r0
        ld.h              r0, (r14, 0x6)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange_weak::u16::acqrel_relaxed+0x3c>
        st.h              r1, (r14, 0x6)
        movi              r1, 0
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange_weak::u16::acqrel_relaxed+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 6
        movi              r3, 4
        jsr               r12
        mov               r1, r0
        ld.h              r0, (r14, 0x6)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange_weak::u16::acquire_seqcst+0x3c>
        st.h              r1, (r14, 0x6)
        movi              r1, 5
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange_weak::u16::acquire_seqcst+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 6
        movi              r3, 2
        jsr               r12
        mov               r1, r0
        ld.h              r0, (r14, 0x6)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange_weak::u16::relaxed_seqcst+0x3c>
        st.h              r1, (r14, 0x6)
        movi              r1, 5
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange_weak::u16::relaxed_seqcst+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 6
        movi              r3, 0
        jsr               r12
        mov               r1, r0
        ld.h              r0, (r14, 0x6)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u16::release_seqcst:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange_weak::u16::release_seqcst+0x3c>
        st.h              r1, (r14, 0x6)
        movi              r1, 5
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange_weak::u16::release_seqcst+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 6
        movi              r3, 3
        jsr               r12
        mov               r1, r0
        ld.h              r0, (r14, 0x6)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange_weak::u16::seqcst_acquire+0x3c>
        st.h              r1, (r14, 0x6)
        movi              r1, 2
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange_weak::u16::seqcst_acquire+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 6
        movi              r3, 5
        jsr               r12
        mov               r1, r0
        ld.h              r0, (r14, 0x6)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange_weak::u16::seqcst_relaxed+0x3c>
        st.h              r1, (r14, 0x6)
        movi              r1, 0
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange_weak::u16::seqcst_relaxed+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 6
        movi              r3, 5
        jsr               r12
        mov               r1, r0
        ld.h              r0, (r14, 0x6)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u16::acquire_acquire:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange_weak::u16::acquire_acquire+0x3c>
        st.h              r1, (r14, 0x6)
        movi              r1, 2
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange_weak::u16::acquire_acquire+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 6
        movi              r3, 2
        jsr               r12
        mov               r1, r0
        ld.h              r0, (r14, 0x6)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange_weak::u16::acquire_relaxed+0x3c>
        st.h              r1, (r14, 0x6)
        movi              r1, 0
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange_weak::u16::acquire_relaxed+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 6
        movi              r3, 2
        jsr               r12
        mov               r1, r0
        ld.h              r0, (r14, 0x6)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange_weak::u16::relaxed_acquire+0x3c>
        st.h              r1, (r14, 0x6)
        movi              r1, 2
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange_weak::u16::relaxed_acquire+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 6
        movi              r3, 0
        jsr               r12
        mov               r1, r0
        ld.h              r0, (r14, 0x6)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange_weak::u16::relaxed_relaxed+0x3c>
        st.h              r1, (r14, 0x6)
        movi              r1, 0
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange_weak::u16::relaxed_relaxed+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 6
        movi              r3, 0
        jsr               r12
        mov               r1, r0
        ld.h              r0, (r14, 0x6)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u16::release_acquire:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange_weak::u16::release_acquire+0x3c>
        st.h              r1, (r14, 0x6)
        movi              r1, 2
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange_weak::u16::release_acquire+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 6
        movi              r3, 3
        jsr               r12
        mov               r1, r0
        ld.h              r0, (r14, 0x6)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u16::release_relaxed:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 3c <asm_test::compare_exchange_weak::u16::release_relaxed+0x3c>
        st.h              r1, (r14, 0x6)
        movi              r1, 0
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 40 <asm_test::compare_exchange_weak::u16::release_relaxed+0x40>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 6
        movi              r3, 3
        jsr               r12
        mov               r1, r0
        ld.h              r0, (r14, 0x6)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 38 <asm_test::compare_exchange_weak::u32::acqrel_seqcst+0x38>
        st.w              r1, (r14, 0x4)
        movi              r1, 5
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 3c <asm_test::compare_exchange_weak::u32::acqrel_seqcst+0x3c>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 4
        movi              r3, 4
        jsr               r12
        mov               r1, r0
        ld.w              r0, (r14, 0x4)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 38 <asm_test::compare_exchange_weak::u32::seqcst_seqcst+0x38>
        st.w              r1, (r14, 0x4)
        movi              r1, 5
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 3c <asm_test::compare_exchange_weak::u32::seqcst_seqcst+0x3c>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 4
        movi              r3, 5
        jsr               r12
        mov               r1, r0
        ld.w              r0, (r14, 0x4)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 38 <asm_test::compare_exchange_weak::u32::acqrel_acquire+0x38>
        st.w              r1, (r14, 0x4)
        movi              r1, 2
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 3c <asm_test::compare_exchange_weak::u32::acqrel_acquire+0x3c>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 4
        movi              r3, 4
        jsr               r12
        mov               r1, r0
        ld.w              r0, (r14, 0x4)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 38 <asm_test::compare_exchange_weak::u32::acqrel_relaxed+0x38>
        st.w              r1, (r14, 0x4)
        movi              r1, 0
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 3c <asm_test::compare_exchange_weak::u32::acqrel_relaxed+0x3c>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 4
        movi              r3, 4
        jsr               r12
        mov               r1, r0
        ld.w              r0, (r14, 0x4)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 38 <asm_test::compare_exchange_weak::u32::acquire_seqcst+0x38>
        st.w              r1, (r14, 0x4)
        movi              r1, 5
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 3c <asm_test::compare_exchange_weak::u32::acquire_seqcst+0x3c>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 4
        movi              r3, 2
        jsr               r12
        mov               r1, r0
        ld.w              r0, (r14, 0x4)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 38 <asm_test::compare_exchange_weak::u32::relaxed_seqcst+0x38>
        st.w              r1, (r14, 0x4)
        movi              r1, 5
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 3c <asm_test::compare_exchange_weak::u32::relaxed_seqcst+0x3c>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 4
        movi              r3, 0
        jsr               r12
        mov               r1, r0
        ld.w              r0, (r14, 0x4)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u32::release_seqcst:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 38 <asm_test::compare_exchange_weak::u32::release_seqcst+0x38>
        st.w              r1, (r14, 0x4)
        movi              r1, 5
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 3c <asm_test::compare_exchange_weak::u32::release_seqcst+0x3c>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 4
        movi              r3, 3
        jsr               r12
        mov               r1, r0
        ld.w              r0, (r14, 0x4)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 38 <asm_test::compare_exchange_weak::u32::seqcst_acquire+0x38>
        st.w              r1, (r14, 0x4)
        movi              r1, 2
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 3c <asm_test::compare_exchange_weak::u32::seqcst_acquire+0x3c>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 4
        movi              r3, 5
        jsr               r12
        mov               r1, r0
        ld.w              r0, (r14, 0x4)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 38 <asm_test::compare_exchange_weak::u32::seqcst_relaxed+0x38>
        st.w              r1, (r14, 0x4)
        movi              r1, 0
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 3c <asm_test::compare_exchange_weak::u32::seqcst_relaxed+0x3c>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 4
        movi              r3, 5
        jsr               r12
        mov               r1, r0
        ld.w              r0, (r14, 0x4)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u32::acquire_acquire:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 38 <asm_test::compare_exchange_weak::u32::acquire_acquire+0x38>
        st.w              r1, (r14, 0x4)
        movi              r1, 2
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 3c <asm_test::compare_exchange_weak::u32::acquire_acquire+0x3c>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 4
        movi              r3, 2
        jsr               r12
        mov               r1, r0
        ld.w              r0, (r14, 0x4)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 38 <asm_test::compare_exchange_weak::u32::acquire_relaxed+0x38>
        st.w              r1, (r14, 0x4)
        movi              r1, 0
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 3c <asm_test::compare_exchange_weak::u32::acquire_relaxed+0x3c>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 4
        movi              r3, 2
        jsr               r12
        mov               r1, r0
        ld.w              r0, (r14, 0x4)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 38 <asm_test::compare_exchange_weak::u32::relaxed_acquire+0x38>
        st.w              r1, (r14, 0x4)
        movi              r1, 2
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 3c <asm_test::compare_exchange_weak::u32::relaxed_acquire+0x3c>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 4
        movi              r3, 0
        jsr               r12
        mov               r1, r0
        ld.w              r0, (r14, 0x4)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 38 <asm_test::compare_exchange_weak::u32::relaxed_relaxed+0x38>
        st.w              r1, (r14, 0x4)
        movi              r1, 0
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 3c <asm_test::compare_exchange_weak::u32::relaxed_relaxed+0x3c>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 4
        movi              r3, 0
        jsr               r12
        mov               r1, r0
        ld.w              r0, (r14, 0x4)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u32::release_acquire:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 38 <asm_test::compare_exchange_weak::u32::release_acquire+0x38>
        st.w              r1, (r14, 0x4)
        movi              r1, 2
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 3c <asm_test::compare_exchange_weak::u32::release_acquire+0x3c>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 4
        movi              r3, 3
        jsr               r12
        mov               r1, r0
        ld.w              r0, (r14, 0x4)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::compare_exchange_weak::u32::release_relaxed:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        subi              r14, r14, 8
        lrw               r28, 0x0	// 38 <asm_test::compare_exchange_weak::u32::release_relaxed+0x38>
        st.w              r1, (r14, 0x4)
        movi              r1, 0
        st.w              r1, (r14, 0x0)
        lrw               r1, 0x0	// 3c <asm_test::compare_exchange_weak::u32::release_relaxed+0x3c>
        ldr.w             r12, (r28, r1 << 0)
        addi              r1, r14, 4
        movi              r3, 3
        jsr               r12
        mov               r1, r0
        ld.w              r0, (r14, 0x4)
        addi              r14, r14, 8
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::load::u8::seqcst:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        lrw               r28, 0x0	// 28 <asm_test::load::u8::seqcst+0x28>
        lrw               r1, 0x0	// 2c <asm_test::load::u8::seqcst+0x2c>
        ldr.w             r2, (r28, r1 << 0)
        movi              r1, 5
        jsr               r2
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::load::u8::acquire:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        lrw               r28, 0x0	// 28 <asm_test::load::u8::acquire+0x28>
        lrw               r1, 0x0	// 2c <asm_test::load::u8::acquire+0x2c>
        ldr.w             r2, (r28, r1 << 0)
        movi              r1, 2
        jsr               r2
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::load::u8::relaxed:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        lrw               r28, 0x0	// 28 <asm_test::load::u8::relaxed+0x28>
        lrw               r1, 0x0	// 2c <asm_test::load::u8::relaxed+0x2c>
        ldr.w             r2, (r28, r1 << 0)
        movi              r1, 0
        jsr               r2
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::load::u16::seqcst:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        lrw               r28, 0x0	// 28 <asm_test::load::u16::seqcst+0x28>
        lrw               r1, 0x0	// 2c <asm_test::load::u16::seqcst+0x2c>
        ldr.w             r2, (r28, r1 << 0)
        movi              r1, 5
        jsr               r2
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::load::u16::acquire:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        lrw               r28, 0x0	// 28 <asm_test::load::u16::acquire+0x28>
        lrw               r1, 0x0	// 2c <asm_test::load::u16::acquire+0x2c>
        ldr.w             r2, (r28, r1 << 0)
        movi              r1, 2
        jsr               r2
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::load::u16::relaxed:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        lrw               r28, 0x0	// 28 <asm_test::load::u16::relaxed+0x28>
        lrw               r1, 0x0	// 2c <asm_test::load::u16::relaxed+0x2c>
        ldr.w             r2, (r28, r1 << 0)
        movi              r1, 0
        jsr               r2
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::load::u32::seqcst:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        lrw               r28, 0x0	// 28 <asm_test::load::u32::seqcst+0x28>
        lrw               r1, 0x0	// 2c <asm_test::load::u32::seqcst+0x2c>
        ldr.w             r2, (r28, r1 << 0)
        movi              r1, 5
        jsr               r2
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::load::u32::acquire:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        lrw               r28, 0x0	// 28 <asm_test::load::u32::acquire+0x28>
        lrw               r1, 0x0	// 2c <asm_test::load::u32::acquire+0x2c>
        ldr.w             r2, (r28, r1 << 0)
        movi              r1, 2
        jsr               r2
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::load::u32::relaxed:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        lrw               r28, 0x0	// 28 <asm_test::load::u32::relaxed+0x28>
        lrw               r1, 0x0	// 2c <asm_test::load::u32::relaxed+0x2c>
        ldr.w             r2, (r28, r1 << 0)
        movi              r1, 0
        jsr               r2
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::swap::u8::acqrel:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        lrw               r28, 0x0	// 28 <asm_test::swap::u8::acqrel+0x28>
        lrw               r2, 0x0	// 2c <asm_test::swap::u8::acqrel+0x2c>
        ldr.w             r3, (r28, r2 << 0)
        movi              r2, 4
        jsr               r3
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::swap::u8::seqcst:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        lrw               r28, 0x0	// 28 <asm_test::swap::u8::seqcst+0x28>
        lrw               r2, 0x0	// 2c <asm_test::swap::u8::seqcst+0x2c>
        ldr.w             r3, (r28, r2 << 0)
        movi              r2, 5
        jsr               r3
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::swap::u8::acquire:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        lrw               r28, 0x0	// 28 <asm_test::swap::u8::acquire+0x28>
        lrw               r2, 0x0	// 2c <asm_test::swap::u8::acquire+0x2c>
        ldr.w             r3, (r28, r2 << 0)
        movi              r2, 2
        jsr               r3
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::swap::u8::relaxed:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        lrw               r28, 0x0	// 28 <asm_test::swap::u8::relaxed+0x28>
        lrw               r2, 0x0	// 2c <asm_test::swap::u8::relaxed+0x2c>
        ldr.w             r3, (r28, r2 << 0)
        movi              r2, 0
        jsr               r3
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::swap::u8::release:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        lrw               r28, 0x0	// 28 <asm_test::swap::u8::release+0x28>
        lrw               r2, 0x0	// 2c <asm_test::swap::u8::release+0x2c>
        ldr.w             r3, (r28, r2 << 0)
        movi              r2, 3
        jsr               r3
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::swap::u16::acqrel:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        lrw               r28, 0x0	// 28 <asm_test::swap::u16::acqrel+0x28>
        lrw               r2, 0x0	// 2c <asm_test::swap::u16::acqrel+0x2c>
        ldr.w             r3, (r28, r2 << 0)
        movi              r2, 4
        jsr               r3
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::swap::u16::seqcst:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        lrw               r28, 0x0	// 28 <asm_test::swap::u16::seqcst+0x28>
        lrw               r2, 0x0	// 2c <asm_test::swap::u16::seqcst+0x2c>
        ldr.w             r3, (r28, r2 << 0)
        movi              r2, 5
        jsr               r3
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::swap::u16::acquire:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        lrw               r28, 0x0	// 28 <asm_test::swap::u16::acquire+0x28>
        lrw               r2, 0x0	// 2c <asm_test::swap::u16::acquire+0x2c>
        ldr.w             r3, (r28, r2 << 0)
        movi              r2, 2
        jsr               r3
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::swap::u16::relaxed:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        lrw               r28, 0x0	// 28 <asm_test::swap::u16::relaxed+0x28>
        lrw               r2, 0x0	// 2c <asm_test::swap::u16::relaxed+0x2c>
        ldr.w             r3, (r28, r2 << 0)
        movi              r2, 0
        jsr               r3
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::swap::u16::release:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        lrw               r28, 0x0	// 28 <asm_test::swap::u16::release+0x28>
        lrw               r2, 0x0	// 2c <asm_test::swap::u16::release+0x2c>
        ldr.w             r3, (r28, r2 << 0)
        movi              r2, 3
        jsr               r3
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::swap::u32::acqrel:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        lrw               r28, 0x0	// 28 <asm_test::swap::u32::acqrel+0x28>
        lrw               r2, 0x0	// 2c <asm_test::swap::u32::acqrel+0x2c>
        ldr.w             r3, (r28, r2 << 0)
        movi              r2, 4
        jsr               r3
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::swap::u32::seqcst:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        lrw               r28, 0x0	// 28 <asm_test::swap::u32::seqcst+0x28>
        lrw               r2, 0x0	// 2c <asm_test::swap::u32::seqcst+0x2c>
        ldr.w             r3, (r28, r2 << 0)
        movi              r2, 5
        jsr               r3
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::swap::u32::acquire:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        lrw               r28, 0x0	// 28 <asm_test::swap::u32::acquire+0x28>
        lrw               r2, 0x0	// 2c <asm_test::swap::u32::acquire+0x2c>
        ldr.w             r3, (r28, r2 << 0)
        movi              r2, 2
        jsr               r3
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::swap::u32::relaxed:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        lrw               r28, 0x0	// 28 <asm_test::swap::u32::relaxed+0x28>
        lrw               r2, 0x0	// 2c <asm_test::swap::u32::relaxed+0x2c>
        ldr.w             r3, (r28, r2 << 0)
        movi              r2, 0
        jsr               r3
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::swap::u32::release:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        lrw               r28, 0x0	// 28 <asm_test::swap::u32::release+0x28>
        lrw               r2, 0x0	// 2c <asm_test::swap::u32::release+0x2c>
        ldr.w             r3, (r28, r2 << 0)
        movi              r2, 3
        jsr               r3
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::store::u8::seqcst:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        lrw               r28, 0x0	// 28 <asm_test::store::u8::seqcst+0x28>
        lrw               r2, 0x0	// 2c <asm_test::store::u8::seqcst+0x2c>
        ldr.w             r3, (r28, r2 << 0)
        movi              r2, 5
        jsr               r3
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::store::u8::relaxed:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        lrw               r28, 0x0	// 28 <asm_test::store::u8::relaxed+0x28>
        lrw               r2, 0x0	// 2c <asm_test::store::u8::relaxed+0x2c>
        ldr.w             r3, (r28, r2 << 0)
        movi              r2, 0
        jsr               r3
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::store::u8::release:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        lrw               r28, 0x0	// 28 <asm_test::store::u8::release+0x28>
        lrw               r2, 0x0	// 2c <asm_test::store::u8::release+0x2c>
        ldr.w             r3, (r28, r2 << 0)
        movi              r2, 3
        jsr               r3
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::store::u16::seqcst:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        lrw               r28, 0x0	// 28 <asm_test::store::u16::seqcst+0x28>
        lrw               r2, 0x0	// 2c <asm_test::store::u16::seqcst+0x2c>
        ldr.w             r3, (r28, r2 << 0)
        movi              r2, 5
        jsr               r3
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::store::u16::relaxed:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        lrw               r28, 0x0	// 28 <asm_test::store::u16::relaxed+0x28>
        lrw               r2, 0x0	// 2c <asm_test::store::u16::relaxed+0x2c>
        ldr.w             r3, (r28, r2 << 0)
        movi              r2, 0
        jsr               r3
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::store::u16::release:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        lrw               r28, 0x0	// 28 <asm_test::store::u16::release+0x28>
        lrw               r2, 0x0	// 2c <asm_test::store::u16::release+0x2c>
        ldr.w             r3, (r28, r2 << 0)
        movi              r2, 3
        jsr               r3
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::store::u32::seqcst:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        lrw               r28, 0x0	// 28 <asm_test::store::u32::seqcst+0x28>
        lrw               r2, 0x0	// 2c <asm_test::store::u32::seqcst+0x2c>
        ldr.w             r3, (r28, r2 << 0)
        movi              r2, 5
        jsr               r3
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::store::u32::relaxed:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        lrw               r28, 0x0	// 28 <asm_test::store::u32::relaxed+0x28>
        lrw               r2, 0x0	// 2c <asm_test::store::u32::relaxed+0x2c>
        ldr.w             r3, (r28, r2 << 0)
        movi              r2, 0
        jsr               r3
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

asm_test::store::u32::release:
        subi              r14, r14, 8
        st.w              r28, (r14, 0x4)
        st.w              r15, (r14, 0x0)
        lrw               r28, 0x0	// 28 <asm_test::store::u32::release+0x28>
        lrw               r2, 0x0	// 2c <asm_test::store::u32::release+0x2c>
        ldr.w             r3, (r28, r2 << 0)
        movi              r2, 3
        jsr               r3
        ld.w              r15, (r14, 0x0)
        ld.w              r28, (r14, 0x4)
        addi              r14, r14, 8
        rts

