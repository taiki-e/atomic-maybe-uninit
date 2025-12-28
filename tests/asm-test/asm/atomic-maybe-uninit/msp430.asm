asm_test::compare_exchange::u8::acqrel_seqcst:
        mov               r2,	r11	;
        dint
        nop
        mov.b             @r12,	r15	;
        xor.b             r15,	r13	;
        jnz               0f
        mov.b             r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp.b             #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov.b             r15,	r12	;
        ret

asm_test::compare_exchange::u8::seqcst_seqcst:
        mov               r2,	r11	;
        dint
        nop
        mov.b             @r12,	r15	;
        xor.b             r15,	r13	;
        jnz               0f
        mov.b             r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp.b             #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov.b             r15,	r12	;
        ret

asm_test::compare_exchange::u8::acqrel_acquire:
        mov               r2,	r11	;
        dint
        nop
        mov.b             @r12,	r15	;
        xor.b             r15,	r13	;
        jnz               0f
        mov.b             r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp.b             #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov.b             r15,	r12	;
        ret

asm_test::compare_exchange::u8::acqrel_relaxed:
        mov               r2,	r11	;
        dint
        nop
        mov.b             @r12,	r15	;
        xor.b             r15,	r13	;
        jnz               0f
        mov.b             r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp.b             #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov.b             r15,	r12	;
        ret

asm_test::compare_exchange::u8::acquire_seqcst:
        mov               r2,	r11	;
        dint
        nop
        mov.b             @r12,	r15	;
        xor.b             r15,	r13	;
        jnz               0f
        mov.b             r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp.b             #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov.b             r15,	r12	;
        ret

asm_test::compare_exchange::u8::relaxed_seqcst:
        mov               r2,	r11	;
        dint
        nop
        mov.b             @r12,	r15	;
        xor.b             r15,	r13	;
        jnz               0f
        mov.b             r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp.b             #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov.b             r15,	r12	;
        ret

asm_test::compare_exchange::u8::release_seqcst:
        mov               r2,	r11	;
        dint
        nop
        mov.b             @r12,	r15	;
        xor.b             r15,	r13	;
        jnz               0f
        mov.b             r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp.b             #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov.b             r15,	r12	;
        ret

asm_test::compare_exchange::u8::seqcst_acquire:
        mov               r2,	r11	;
        dint
        nop
        mov.b             @r12,	r15	;
        xor.b             r15,	r13	;
        jnz               0f
        mov.b             r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp.b             #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov.b             r15,	r12	;
        ret

asm_test::compare_exchange::u8::seqcst_relaxed:
        mov               r2,	r11	;
        dint
        nop
        mov.b             @r12,	r15	;
        xor.b             r15,	r13	;
        jnz               0f
        mov.b             r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp.b             #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov.b             r15,	r12	;
        ret

asm_test::compare_exchange::u8::acquire_acquire:
        mov               r2,	r11	;
        dint
        nop
        mov.b             @r12,	r15	;
        xor.b             r15,	r13	;
        jnz               0f
        mov.b             r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp.b             #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov.b             r15,	r12	;
        ret

asm_test::compare_exchange::u8::acquire_relaxed:
        mov               r2,	r11	;
        dint
        nop
        mov.b             @r12,	r15	;
        xor.b             r15,	r13	;
        jnz               0f
        mov.b             r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp.b             #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov.b             r15,	r12	;
        ret

asm_test::compare_exchange::u8::relaxed_acquire:
        mov               r2,	r11	;
        dint
        nop
        mov.b             @r12,	r15	;
        xor.b             r15,	r13	;
        jnz               0f
        mov.b             r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp.b             #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov.b             r15,	r12	;
        ret

asm_test::compare_exchange::u8::relaxed_relaxed:
        mov               r2,	r11	;
        dint
        nop
        mov.b             @r12,	r15	;
        xor.b             r15,	r13	;
        jnz               0f
        mov.b             r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp.b             #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov.b             r15,	r12	;
        ret

asm_test::compare_exchange::u8::release_acquire:
        mov               r2,	r11	;
        dint
        nop
        mov.b             @r12,	r15	;
        xor.b             r15,	r13	;
        jnz               0f
        mov.b             r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp.b             #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov.b             r15,	r12	;
        ret

asm_test::compare_exchange::u8::release_relaxed:
        mov               r2,	r11	;
        dint
        nop
        mov.b             @r12,	r15	;
        xor.b             r15,	r13	;
        jnz               0f
        mov.b             r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp.b             #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov.b             r15,	r12	;
        ret

asm_test::compare_exchange::u16::acqrel_seqcst:
        mov               r2,	r11	;
        dint
        nop
        mov               @r12,	r15	;
        xor               r15,	r13	;
        jnz               0f
        mov               r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp               #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov               r15,	r12	;
        ret

asm_test::compare_exchange::u16::seqcst_seqcst:
        mov               r2,	r11	;
        dint
        nop
        mov               @r12,	r15	;
        xor               r15,	r13	;
        jnz               0f
        mov               r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp               #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov               r15,	r12	;
        ret

asm_test::compare_exchange::u16::acqrel_acquire:
        mov               r2,	r11	;
        dint
        nop
        mov               @r12,	r15	;
        xor               r15,	r13	;
        jnz               0f
        mov               r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp               #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov               r15,	r12	;
        ret

asm_test::compare_exchange::u16::acqrel_relaxed:
        mov               r2,	r11	;
        dint
        nop
        mov               @r12,	r15	;
        xor               r15,	r13	;
        jnz               0f
        mov               r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp               #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov               r15,	r12	;
        ret

asm_test::compare_exchange::u16::acquire_seqcst:
        mov               r2,	r11	;
        dint
        nop
        mov               @r12,	r15	;
        xor               r15,	r13	;
        jnz               0f
        mov               r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp               #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov               r15,	r12	;
        ret

asm_test::compare_exchange::u16::relaxed_seqcst:
        mov               r2,	r11	;
        dint
        nop
        mov               @r12,	r15	;
        xor               r15,	r13	;
        jnz               0f
        mov               r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp               #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov               r15,	r12	;
        ret

asm_test::compare_exchange::u16::release_seqcst:
        mov               r2,	r11	;
        dint
        nop
        mov               @r12,	r15	;
        xor               r15,	r13	;
        jnz               0f
        mov               r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp               #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov               r15,	r12	;
        ret

asm_test::compare_exchange::u16::seqcst_acquire:
        mov               r2,	r11	;
        dint
        nop
        mov               @r12,	r15	;
        xor               r15,	r13	;
        jnz               0f
        mov               r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp               #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov               r15,	r12	;
        ret

asm_test::compare_exchange::u16::seqcst_relaxed:
        mov               r2,	r11	;
        dint
        nop
        mov               @r12,	r15	;
        xor               r15,	r13	;
        jnz               0f
        mov               r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp               #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov               r15,	r12	;
        ret

asm_test::compare_exchange::u16::acquire_acquire:
        mov               r2,	r11	;
        dint
        nop
        mov               @r12,	r15	;
        xor               r15,	r13	;
        jnz               0f
        mov               r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp               #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov               r15,	r12	;
        ret

asm_test::compare_exchange::u16::acquire_relaxed:
        mov               r2,	r11	;
        dint
        nop
        mov               @r12,	r15	;
        xor               r15,	r13	;
        jnz               0f
        mov               r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp               #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov               r15,	r12	;
        ret

asm_test::compare_exchange::u16::relaxed_acquire:
        mov               r2,	r11	;
        dint
        nop
        mov               @r12,	r15	;
        xor               r15,	r13	;
        jnz               0f
        mov               r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp               #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov               r15,	r12	;
        ret

asm_test::compare_exchange::u16::relaxed_relaxed:
        mov               r2,	r11	;
        dint
        nop
        mov               @r12,	r15	;
        xor               r15,	r13	;
        jnz               0f
        mov               r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp               #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov               r15,	r12	;
        ret

asm_test::compare_exchange::u16::release_acquire:
        mov               r2,	r11	;
        dint
        nop
        mov               @r12,	r15	;
        xor               r15,	r13	;
        jnz               0f
        mov               r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp               #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov               r15,	r12	;
        ret

asm_test::compare_exchange::u16::release_relaxed:
        mov               r2,	r11	;
        dint
        nop
        mov               @r12,	r15	;
        xor               r15,	r13	;
        jnz               0f
        mov               r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp               #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov               r15,	r12	;
        ret

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        mov               r2,	r11	;
        dint
        nop
        mov.b             @r12,	r15	;
        xor.b             r15,	r13	;
        jnz               0f
        mov.b             r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp.b             #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov.b             r15,	r12	;
        ret

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        mov               r2,	r11	;
        dint
        nop
        mov.b             @r12,	r15	;
        xor.b             r15,	r13	;
        jnz               0f
        mov.b             r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp.b             #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov.b             r15,	r12	;
        ret

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        mov               r2,	r11	;
        dint
        nop
        mov.b             @r12,	r15	;
        xor.b             r15,	r13	;
        jnz               0f
        mov.b             r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp.b             #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov.b             r15,	r12	;
        ret

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        mov               r2,	r11	;
        dint
        nop
        mov.b             @r12,	r15	;
        xor.b             r15,	r13	;
        jnz               0f
        mov.b             r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp.b             #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov.b             r15,	r12	;
        ret

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        mov               r2,	r11	;
        dint
        nop
        mov.b             @r12,	r15	;
        xor.b             r15,	r13	;
        jnz               0f
        mov.b             r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp.b             #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov.b             r15,	r12	;
        ret

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        mov               r2,	r11	;
        dint
        nop
        mov.b             @r12,	r15	;
        xor.b             r15,	r13	;
        jnz               0f
        mov.b             r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp.b             #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov.b             r15,	r12	;
        ret

asm_test::compare_exchange_weak::u8::release_seqcst:
        mov               r2,	r11	;
        dint
        nop
        mov.b             @r12,	r15	;
        xor.b             r15,	r13	;
        jnz               0f
        mov.b             r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp.b             #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov.b             r15,	r12	;
        ret

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        mov               r2,	r11	;
        dint
        nop
        mov.b             @r12,	r15	;
        xor.b             r15,	r13	;
        jnz               0f
        mov.b             r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp.b             #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov.b             r15,	r12	;
        ret

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        mov               r2,	r11	;
        dint
        nop
        mov.b             @r12,	r15	;
        xor.b             r15,	r13	;
        jnz               0f
        mov.b             r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp.b             #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov.b             r15,	r12	;
        ret

asm_test::compare_exchange_weak::u8::acquire_acquire:
        mov               r2,	r11	;
        dint
        nop
        mov.b             @r12,	r15	;
        xor.b             r15,	r13	;
        jnz               0f
        mov.b             r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp.b             #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov.b             r15,	r12	;
        ret

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        mov               r2,	r11	;
        dint
        nop
        mov.b             @r12,	r15	;
        xor.b             r15,	r13	;
        jnz               0f
        mov.b             r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp.b             #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov.b             r15,	r12	;
        ret

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        mov               r2,	r11	;
        dint
        nop
        mov.b             @r12,	r15	;
        xor.b             r15,	r13	;
        jnz               0f
        mov.b             r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp.b             #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov.b             r15,	r12	;
        ret

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        mov               r2,	r11	;
        dint
        nop
        mov.b             @r12,	r15	;
        xor.b             r15,	r13	;
        jnz               0f
        mov.b             r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp.b             #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov.b             r15,	r12	;
        ret

asm_test::compare_exchange_weak::u8::release_acquire:
        mov               r2,	r11	;
        dint
        nop
        mov.b             @r12,	r15	;
        xor.b             r15,	r13	;
        jnz               0f
        mov.b             r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp.b             #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov.b             r15,	r12	;
        ret

asm_test::compare_exchange_weak::u8::release_relaxed:
        mov               r2,	r11	;
        dint
        nop
        mov.b             @r12,	r15	;
        xor.b             r15,	r13	;
        jnz               0f
        mov.b             r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp.b             #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov.b             r15,	r12	;
        ret

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        mov               r2,	r11	;
        dint
        nop
        mov               @r12,	r15	;
        xor               r15,	r13	;
        jnz               0f
        mov               r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp               #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov               r15,	r12	;
        ret

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        mov               r2,	r11	;
        dint
        nop
        mov               @r12,	r15	;
        xor               r15,	r13	;
        jnz               0f
        mov               r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp               #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov               r15,	r12	;
        ret

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        mov               r2,	r11	;
        dint
        nop
        mov               @r12,	r15	;
        xor               r15,	r13	;
        jnz               0f
        mov               r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp               #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov               r15,	r12	;
        ret

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        mov               r2,	r11	;
        dint
        nop
        mov               @r12,	r15	;
        xor               r15,	r13	;
        jnz               0f
        mov               r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp               #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov               r15,	r12	;
        ret

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        mov               r2,	r11	;
        dint
        nop
        mov               @r12,	r15	;
        xor               r15,	r13	;
        jnz               0f
        mov               r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp               #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov               r15,	r12	;
        ret

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        mov               r2,	r11	;
        dint
        nop
        mov               @r12,	r15	;
        xor               r15,	r13	;
        jnz               0f
        mov               r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp               #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov               r15,	r12	;
        ret

asm_test::compare_exchange_weak::u16::release_seqcst:
        mov               r2,	r11	;
        dint
        nop
        mov               @r12,	r15	;
        xor               r15,	r13	;
        jnz               0f
        mov               r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp               #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov               r15,	r12	;
        ret

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        mov               r2,	r11	;
        dint
        nop
        mov               @r12,	r15	;
        xor               r15,	r13	;
        jnz               0f
        mov               r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp               #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov               r15,	r12	;
        ret

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        mov               r2,	r11	;
        dint
        nop
        mov               @r12,	r15	;
        xor               r15,	r13	;
        jnz               0f
        mov               r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp               #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov               r15,	r12	;
        ret

asm_test::compare_exchange_weak::u16::acquire_acquire:
        mov               r2,	r11	;
        dint
        nop
        mov               @r12,	r15	;
        xor               r15,	r13	;
        jnz               0f
        mov               r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp               #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov               r15,	r12	;
        ret

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        mov               r2,	r11	;
        dint
        nop
        mov               @r12,	r15	;
        xor               r15,	r13	;
        jnz               0f
        mov               r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp               #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov               r15,	r12	;
        ret

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        mov               r2,	r11	;
        dint
        nop
        mov               @r12,	r15	;
        xor               r15,	r13	;
        jnz               0f
        mov               r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp               #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov               r15,	r12	;
        ret

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        mov               r2,	r11	;
        dint
        nop
        mov               @r12,	r15	;
        xor               r15,	r13	;
        jnz               0f
        mov               r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp               #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov               r15,	r12	;
        ret

asm_test::compare_exchange_weak::u16::release_acquire:
        mov               r2,	r11	;
        dint
        nop
        mov               @r12,	r15	;
        xor               r15,	r13	;
        jnz               0f
        mov               r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp               #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov               r15,	r12	;
        ret

asm_test::compare_exchange_weak::u16::release_relaxed:
        mov               r2,	r11	;
        dint
        nop
        mov               @r12,	r15	;
        xor               r15,	r13	;
        jnz               0f
        mov               r14,	0(r12)	;
0:
        nop
        mov               r11,	r2	;
        nop
        cmp               #0,	r13	;r3 As==00
        mov               r2,	r13	;
        rra               r13		;
        and               #1,	r13	;r3 As==01
        mov               r15,	r12	;
        ret

asm_test::load::u8::seqcst:
        mov.b             @r12,	r12	;
        ret

asm_test::load::u8::acquire:
        mov.b             @r12,	r12	;
        ret

asm_test::load::u8::relaxed:
        mov.b             @r12,	r12	;
        ret

asm_test::load::u16::seqcst:
        mov               @r12,	r12	;
        ret

asm_test::load::u16::acquire:
        mov               @r12,	r12	;
        ret

asm_test::load::u16::relaxed:
        mov               @r12,	r12	;
        ret

asm_test::swap::u8::acqrel:
        mov               r2,	r15	;
        dint
        nop
        mov.b             @r12,	r14	;
        mov.b             r13,	0(r12)	;
        nop
        mov               r15,	r2	;
        nop
        mov.b             r14,	r12	;
        ret

asm_test::swap::u8::seqcst:
        mov               r2,	r15	;
        dint
        nop
        mov.b             @r12,	r14	;
        mov.b             r13,	0(r12)	;
        nop
        mov               r15,	r2	;
        nop
        mov.b             r14,	r12	;
        ret

asm_test::swap::u8::acquire:
        mov               r2,	r15	;
        dint
        nop
        mov.b             @r12,	r14	;
        mov.b             r13,	0(r12)	;
        nop
        mov               r15,	r2	;
        nop
        mov.b             r14,	r12	;
        ret

asm_test::swap::u8::relaxed:
        mov               r2,	r15	;
        dint
        nop
        mov.b             @r12,	r14	;
        mov.b             r13,	0(r12)	;
        nop
        mov               r15,	r2	;
        nop
        mov.b             r14,	r12	;
        ret

asm_test::swap::u8::release:
        mov               r2,	r15	;
        dint
        nop
        mov.b             @r12,	r14	;
        mov.b             r13,	0(r12)	;
        nop
        mov               r15,	r2	;
        nop
        mov.b             r14,	r12	;
        ret

asm_test::swap::u16::acqrel:
        mov               r2,	r15	;
        dint
        nop
        mov               @r12,	r14	;
        mov               r13,	0(r12)	;
        nop
        mov               r15,	r2	;
        nop
        mov               r14,	r12	;
        ret

asm_test::swap::u16::seqcst:
        mov               r2,	r15	;
        dint
        nop
        mov               @r12,	r14	;
        mov               r13,	0(r12)	;
        nop
        mov               r15,	r2	;
        nop
        mov               r14,	r12	;
        ret

asm_test::swap::u16::acquire:
        mov               r2,	r15	;
        dint
        nop
        mov               @r12,	r14	;
        mov               r13,	0(r12)	;
        nop
        mov               r15,	r2	;
        nop
        mov               r14,	r12	;
        ret

asm_test::swap::u16::relaxed:
        mov               r2,	r15	;
        dint
        nop
        mov               @r12,	r14	;
        mov               r13,	0(r12)	;
        nop
        mov               r15,	r2	;
        nop
        mov               r14,	r12	;
        ret

asm_test::swap::u16::release:
        mov               r2,	r15	;
        dint
        nop
        mov               @r12,	r14	;
        mov               r13,	0(r12)	;
        nop
        mov               r15,	r2	;
        nop
        mov               r14,	r12	;
        ret

asm_test::store::u8::seqcst:
        mov.b             r13,	0(r12)	;
        ret

asm_test::store::u8::relaxed:
        mov.b             r13,	0(r12)	;
        ret

asm_test::store::u8::release:
        mov.b             r13,	0(r12)	;
        ret

asm_test::store::u16::seqcst:
        mov               r13,	0(r12)	;
        ret

asm_test::store::u16::relaxed:
        mov               r13,	0(r12)	;
        ret

asm_test::store::u16::release:
        mov               r13,	0(r12)	;
        ret

