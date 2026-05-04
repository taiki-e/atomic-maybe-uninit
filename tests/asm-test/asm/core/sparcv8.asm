asm_test::compare_exchange::u8::acqrel_seqcst:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        stb               %i1, [ %fp + -1 ]
        add               %fp, -1, %o1
        mov               4, %o3
0:
        call              0f
        mov               5, %o4
        ldub              [ %fp + -1 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange::u8::seqcst_seqcst:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        stb               %i1, [ %fp + -1 ]
        add               %fp, -1, %o1
        mov               5, %o3
0:
        call              0f
        mov               %o3, %o4
        ldub              [ %fp + -1 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange::u8::acqrel_acquire:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        stb               %i1, [ %fp + -1 ]
        add               %fp, -1, %o1
        mov               4, %o3
0:
        call              0f
        mov               2, %o4
        ldub              [ %fp + -1 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange::u8::acqrel_relaxed:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        stb               %i1, [ %fp + -1 ]
        add               %fp, -1, %o1
        mov               4, %o3
0:
        call              0f
        mov               %g0, %o4
        ldub              [ %fp + -1 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange::u8::acquire_seqcst:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        stb               %i1, [ %fp + -1 ]
        add               %fp, -1, %o1
        mov               2, %o3
0:
        call              0f
        mov               5, %o4
        ldub              [ %fp + -1 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange::u8::relaxed_seqcst:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        stb               %i1, [ %fp + -1 ]
        add               %fp, -1, %o1
        mov               5, %o4
0:
        call              0f
        mov               %g0, %o3
        ldub              [ %fp + -1 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange::u8::release_seqcst:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        stb               %i1, [ %fp + -1 ]
        add               %fp, -1, %o1
        mov               3, %o3
0:
        call              0f
        mov               5, %o4
        ldub              [ %fp + -1 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange::u8::seqcst_acquire:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        stb               %i1, [ %fp + -1 ]
        add               %fp, -1, %o1
        mov               5, %o3
0:
        call              0f
        mov               2, %o4
        ldub              [ %fp + -1 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange::u8::seqcst_relaxed:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        stb               %i1, [ %fp + -1 ]
        add               %fp, -1, %o1
        mov               5, %o3
0:
        call              0f
        mov               %g0, %o4
        ldub              [ %fp + -1 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange::u8::acquire_acquire:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        stb               %i1, [ %fp + -1 ]
        add               %fp, -1, %o1
        mov               2, %o3
0:
        call              0f
        mov               %o3, %o4
        ldub              [ %fp + -1 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange::u8::acquire_relaxed:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        stb               %i1, [ %fp + -1 ]
        add               %fp, -1, %o1
        mov               2, %o3
0:
        call              0f
        mov               %g0, %o4
        ldub              [ %fp + -1 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange::u8::relaxed_acquire:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        stb               %i1, [ %fp + -1 ]
        add               %fp, -1, %o1
        mov               2, %o4
0:
        call              0f
        mov               %g0, %o3
        ldub              [ %fp + -1 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange::u8::relaxed_relaxed:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        stb               %i1, [ %fp + -1 ]
        add               %fp, -1, %o1
        mov               %g0, %o3
0:
        call              0f
        mov               %g0, %o4
        ldub              [ %fp + -1 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange::u8::release_acquire:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        stb               %i1, [ %fp + -1 ]
        add               %fp, -1, %o1
        mov               3, %o3
0:
        call              0f
        mov               2, %o4
        ldub              [ %fp + -1 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange::u8::release_relaxed:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        stb               %i1, [ %fp + -1 ]
        add               %fp, -1, %o1
        mov               3, %o3
0:
        call              0f
        mov               %g0, %o4
        ldub              [ %fp + -1 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange::u16::acqrel_seqcst:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        sth               %i1, [ %fp + -2 ]
        add               %fp, -2, %o1
        mov               4, %o3
0:
        call              0f
        mov               5, %o4
        lduh              [ %fp + -2 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange::u16::seqcst_seqcst:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        sth               %i1, [ %fp + -2 ]
        add               %fp, -2, %o1
        mov               5, %o3
0:
        call              0f
        mov               %o3, %o4
        lduh              [ %fp + -2 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange::u16::acqrel_acquire:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        sth               %i1, [ %fp + -2 ]
        add               %fp, -2, %o1
        mov               4, %o3
0:
        call              0f
        mov               2, %o4
        lduh              [ %fp + -2 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange::u16::acqrel_relaxed:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        sth               %i1, [ %fp + -2 ]
        add               %fp, -2, %o1
        mov               4, %o3
0:
        call              0f
        mov               %g0, %o4
        lduh              [ %fp + -2 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange::u16::acquire_seqcst:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        sth               %i1, [ %fp + -2 ]
        add               %fp, -2, %o1
        mov               2, %o3
0:
        call              0f
        mov               5, %o4
        lduh              [ %fp + -2 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange::u16::relaxed_seqcst:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        sth               %i1, [ %fp + -2 ]
        add               %fp, -2, %o1
        mov               5, %o4
0:
        call              0f
        mov               %g0, %o3
        lduh              [ %fp + -2 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange::u16::release_seqcst:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        sth               %i1, [ %fp + -2 ]
        add               %fp, -2, %o1
        mov               3, %o3
0:
        call              0f
        mov               5, %o4
        lduh              [ %fp + -2 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange::u16::seqcst_acquire:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        sth               %i1, [ %fp + -2 ]
        add               %fp, -2, %o1
        mov               5, %o3
0:
        call              0f
        mov               2, %o4
        lduh              [ %fp + -2 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange::u16::seqcst_relaxed:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        sth               %i1, [ %fp + -2 ]
        add               %fp, -2, %o1
        mov               5, %o3
0:
        call              0f
        mov               %g0, %o4
        lduh              [ %fp + -2 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange::u16::acquire_acquire:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        sth               %i1, [ %fp + -2 ]
        add               %fp, -2, %o1
        mov               2, %o3
0:
        call              0f
        mov               %o3, %o4
        lduh              [ %fp + -2 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange::u16::acquire_relaxed:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        sth               %i1, [ %fp + -2 ]
        add               %fp, -2, %o1
        mov               2, %o3
0:
        call              0f
        mov               %g0, %o4
        lduh              [ %fp + -2 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange::u16::relaxed_acquire:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        sth               %i1, [ %fp + -2 ]
        add               %fp, -2, %o1
        mov               2, %o4
0:
        call              0f
        mov               %g0, %o3
        lduh              [ %fp + -2 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange::u16::relaxed_relaxed:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        sth               %i1, [ %fp + -2 ]
        add               %fp, -2, %o1
        mov               %g0, %o3
0:
        call              0f
        mov               %g0, %o4
        lduh              [ %fp + -2 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange::u16::release_acquire:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        sth               %i1, [ %fp + -2 ]
        add               %fp, -2, %o1
        mov               3, %o3
0:
        call              0f
        mov               2, %o4
        lduh              [ %fp + -2 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange::u16::release_relaxed:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        sth               %i1, [ %fp + -2 ]
        add               %fp, -2, %o1
        mov               3, %o3
0:
        call              0f
        mov               %g0, %o4
        lduh              [ %fp + -2 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange::u32::acqrel_seqcst:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        st                %i1, [ %fp + -4 ]
        add               %fp, -4, %o1
        mov               4, %o3
0:
        call              0f
        mov               5, %o4
        ld                [ %fp + -4 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange::u32::seqcst_seqcst:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        st                %i1, [ %fp + -4 ]
        add               %fp, -4, %o1
        mov               5, %o3
0:
        call              0f
        mov               %o3, %o4
        ld                [ %fp + -4 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange::u32::acqrel_acquire:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        st                %i1, [ %fp + -4 ]
        add               %fp, -4, %o1
        mov               4, %o3
0:
        call              0f
        mov               2, %o4
        ld                [ %fp + -4 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange::u32::acqrel_relaxed:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        st                %i1, [ %fp + -4 ]
        add               %fp, -4, %o1
        mov               4, %o3
0:
        call              0f
        mov               %g0, %o4
        ld                [ %fp + -4 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange::u32::acquire_seqcst:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        st                %i1, [ %fp + -4 ]
        add               %fp, -4, %o1
        mov               2, %o3
0:
        call              0f
        mov               5, %o4
        ld                [ %fp + -4 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange::u32::relaxed_seqcst:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        st                %i1, [ %fp + -4 ]
        add               %fp, -4, %o1
        mov               5, %o4
0:
        call              0f
        mov               %g0, %o3
        ld                [ %fp + -4 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange::u32::release_seqcst:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        st                %i1, [ %fp + -4 ]
        add               %fp, -4, %o1
        mov               3, %o3
0:
        call              0f
        mov               5, %o4
        ld                [ %fp + -4 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange::u32::seqcst_acquire:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        st                %i1, [ %fp + -4 ]
        add               %fp, -4, %o1
        mov               5, %o3
0:
        call              0f
        mov               2, %o4
        ld                [ %fp + -4 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange::u32::seqcst_relaxed:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        st                %i1, [ %fp + -4 ]
        add               %fp, -4, %o1
        mov               5, %o3
0:
        call              0f
        mov               %g0, %o4
        ld                [ %fp + -4 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange::u32::acquire_acquire:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        st                %i1, [ %fp + -4 ]
        add               %fp, -4, %o1
        mov               2, %o3
0:
        call              0f
        mov               %o3, %o4
        ld                [ %fp + -4 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange::u32::acquire_relaxed:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        st                %i1, [ %fp + -4 ]
        add               %fp, -4, %o1
        mov               2, %o3
0:
        call              0f
        mov               %g0, %o4
        ld                [ %fp + -4 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange::u32::relaxed_acquire:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        st                %i1, [ %fp + -4 ]
        add               %fp, -4, %o1
        mov               2, %o4
0:
        call              0f
        mov               %g0, %o3
        ld                [ %fp + -4 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange::u32::relaxed_relaxed:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        st                %i1, [ %fp + -4 ]
        add               %fp, -4, %o1
        mov               %g0, %o3
0:
        call              0f
        mov               %g0, %o4
        ld                [ %fp + -4 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange::u32::release_acquire:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        st                %i1, [ %fp + -4 ]
        add               %fp, -4, %o1
        mov               3, %o3
0:
        call              0f
        mov               2, %o4
        ld                [ %fp + -4 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange::u32::release_relaxed:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        st                %i1, [ %fp + -4 ]
        add               %fp, -4, %o1
        mov               3, %o3
0:
        call              0f
        mov               %g0, %o4
        ld                [ %fp + -4 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        stb               %i1, [ %fp + -1 ]
        add               %fp, -1, %o1
        mov               4, %o3
0:
        call              0f
        mov               5, %o4
        ldub              [ %fp + -1 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        stb               %i1, [ %fp + -1 ]
        add               %fp, -1, %o1
        mov               5, %o3
0:
        call              0f
        mov               %o3, %o4
        ldub              [ %fp + -1 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        stb               %i1, [ %fp + -1 ]
        add               %fp, -1, %o1
        mov               4, %o3
0:
        call              0f
        mov               2, %o4
        ldub              [ %fp + -1 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        stb               %i1, [ %fp + -1 ]
        add               %fp, -1, %o1
        mov               4, %o3
0:
        call              0f
        mov               %g0, %o4
        ldub              [ %fp + -1 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        stb               %i1, [ %fp + -1 ]
        add               %fp, -1, %o1
        mov               2, %o3
0:
        call              0f
        mov               5, %o4
        ldub              [ %fp + -1 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        stb               %i1, [ %fp + -1 ]
        add               %fp, -1, %o1
        mov               5, %o4
0:
        call              0f
        mov               %g0, %o3
        ldub              [ %fp + -1 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u8::release_seqcst:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        stb               %i1, [ %fp + -1 ]
        add               %fp, -1, %o1
        mov               3, %o3
0:
        call              0f
        mov               5, %o4
        ldub              [ %fp + -1 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        stb               %i1, [ %fp + -1 ]
        add               %fp, -1, %o1
        mov               5, %o3
0:
        call              0f
        mov               2, %o4
        ldub              [ %fp + -1 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        stb               %i1, [ %fp + -1 ]
        add               %fp, -1, %o1
        mov               5, %o3
0:
        call              0f
        mov               %g0, %o4
        ldub              [ %fp + -1 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u8::acquire_acquire:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        stb               %i1, [ %fp + -1 ]
        add               %fp, -1, %o1
        mov               2, %o3
0:
        call              0f
        mov               %o3, %o4
        ldub              [ %fp + -1 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        stb               %i1, [ %fp + -1 ]
        add               %fp, -1, %o1
        mov               2, %o3
0:
        call              0f
        mov               %g0, %o4
        ldub              [ %fp + -1 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        stb               %i1, [ %fp + -1 ]
        add               %fp, -1, %o1
        mov               2, %o4
0:
        call              0f
        mov               %g0, %o3
        ldub              [ %fp + -1 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        stb               %i1, [ %fp + -1 ]
        add               %fp, -1, %o1
        mov               %g0, %o3
0:
        call              0f
        mov               %g0, %o4
        ldub              [ %fp + -1 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u8::release_acquire:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        stb               %i1, [ %fp + -1 ]
        add               %fp, -1, %o1
        mov               3, %o3
0:
        call              0f
        mov               2, %o4
        ldub              [ %fp + -1 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u8::release_relaxed:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        stb               %i1, [ %fp + -1 ]
        add               %fp, -1, %o1
        mov               3, %o3
0:
        call              0f
        mov               %g0, %o4
        ldub              [ %fp + -1 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        sth               %i1, [ %fp + -2 ]
        add               %fp, -2, %o1
        mov               4, %o3
0:
        call              0f
        mov               5, %o4
        lduh              [ %fp + -2 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        sth               %i1, [ %fp + -2 ]
        add               %fp, -2, %o1
        mov               5, %o3
0:
        call              0f
        mov               %o3, %o4
        lduh              [ %fp + -2 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        sth               %i1, [ %fp + -2 ]
        add               %fp, -2, %o1
        mov               4, %o3
0:
        call              0f
        mov               2, %o4
        lduh              [ %fp + -2 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        sth               %i1, [ %fp + -2 ]
        add               %fp, -2, %o1
        mov               4, %o3
0:
        call              0f
        mov               %g0, %o4
        lduh              [ %fp + -2 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        sth               %i1, [ %fp + -2 ]
        add               %fp, -2, %o1
        mov               2, %o3
0:
        call              0f
        mov               5, %o4
        lduh              [ %fp + -2 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        sth               %i1, [ %fp + -2 ]
        add               %fp, -2, %o1
        mov               5, %o4
0:
        call              0f
        mov               %g0, %o3
        lduh              [ %fp + -2 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u16::release_seqcst:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        sth               %i1, [ %fp + -2 ]
        add               %fp, -2, %o1
        mov               3, %o3
0:
        call              0f
        mov               5, %o4
        lduh              [ %fp + -2 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        sth               %i1, [ %fp + -2 ]
        add               %fp, -2, %o1
        mov               5, %o3
0:
        call              0f
        mov               2, %o4
        lduh              [ %fp + -2 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        sth               %i1, [ %fp + -2 ]
        add               %fp, -2, %o1
        mov               5, %o3
0:
        call              0f
        mov               %g0, %o4
        lduh              [ %fp + -2 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u16::acquire_acquire:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        sth               %i1, [ %fp + -2 ]
        add               %fp, -2, %o1
        mov               2, %o3
0:
        call              0f
        mov               %o3, %o4
        lduh              [ %fp + -2 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        sth               %i1, [ %fp + -2 ]
        add               %fp, -2, %o1
        mov               2, %o3
0:
        call              0f
        mov               %g0, %o4
        lduh              [ %fp + -2 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        sth               %i1, [ %fp + -2 ]
        add               %fp, -2, %o1
        mov               2, %o4
0:
        call              0f
        mov               %g0, %o3
        lduh              [ %fp + -2 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        sth               %i1, [ %fp + -2 ]
        add               %fp, -2, %o1
        mov               %g0, %o3
0:
        call              0f
        mov               %g0, %o4
        lduh              [ %fp + -2 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u16::release_acquire:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        sth               %i1, [ %fp + -2 ]
        add               %fp, -2, %o1
        mov               3, %o3
0:
        call              0f
        mov               2, %o4
        lduh              [ %fp + -2 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u16::release_relaxed:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        sth               %i1, [ %fp + -2 ]
        add               %fp, -2, %o1
        mov               3, %o3
0:
        call              0f
        mov               %g0, %o4
        lduh              [ %fp + -2 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        st                %i1, [ %fp + -4 ]
        add               %fp, -4, %o1
        mov               4, %o3
0:
        call              0f
        mov               5, %o4
        ld                [ %fp + -4 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        st                %i1, [ %fp + -4 ]
        add               %fp, -4, %o1
        mov               5, %o3
0:
        call              0f
        mov               %o3, %o4
        ld                [ %fp + -4 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        st                %i1, [ %fp + -4 ]
        add               %fp, -4, %o1
        mov               4, %o3
0:
        call              0f
        mov               2, %o4
        ld                [ %fp + -4 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        st                %i1, [ %fp + -4 ]
        add               %fp, -4, %o1
        mov               4, %o3
0:
        call              0f
        mov               %g0, %o4
        ld                [ %fp + -4 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        st                %i1, [ %fp + -4 ]
        add               %fp, -4, %o1
        mov               2, %o3
0:
        call              0f
        mov               5, %o4
        ld                [ %fp + -4 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        st                %i1, [ %fp + -4 ]
        add               %fp, -4, %o1
        mov               5, %o4
0:
        call              0f
        mov               %g0, %o3
        ld                [ %fp + -4 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u32::release_seqcst:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        st                %i1, [ %fp + -4 ]
        add               %fp, -4, %o1
        mov               3, %o3
0:
        call              0f
        mov               5, %o4
        ld                [ %fp + -4 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        st                %i1, [ %fp + -4 ]
        add               %fp, -4, %o1
        mov               5, %o3
0:
        call              0f
        mov               2, %o4
        ld                [ %fp + -4 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        st                %i1, [ %fp + -4 ]
        add               %fp, -4, %o1
        mov               5, %o3
0:
        call              0f
        mov               %g0, %o4
        ld                [ %fp + -4 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u32::acquire_acquire:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        st                %i1, [ %fp + -4 ]
        add               %fp, -4, %o1
        mov               2, %o3
0:
        call              0f
        mov               %o3, %o4
        ld                [ %fp + -4 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        st                %i1, [ %fp + -4 ]
        add               %fp, -4, %o1
        mov               2, %o3
0:
        call              0f
        mov               %g0, %o4
        ld                [ %fp + -4 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        st                %i1, [ %fp + -4 ]
        add               %fp, -4, %o1
        mov               2, %o4
0:
        call              0f
        mov               %g0, %o3
        ld                [ %fp + -4 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        st                %i1, [ %fp + -4 ]
        add               %fp, -4, %o1
        mov               %g0, %o3
0:
        call              0f
        mov               %g0, %o4
        ld                [ %fp + -4 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u32::release_acquire:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        st                %i1, [ %fp + -4 ]
        add               %fp, -4, %o1
        mov               3, %o3
0:
        call              0f
        mov               2, %o4
        ld                [ %fp + -4 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::compare_exchange_weak::u32::release_relaxed:
        save              %sp, -96, %sp
        mov               %i2, %o2
        mov               %i0, %o0
        st                %i1, [ %fp + -4 ]
        add               %fp, -4, %o1
        mov               3, %o3
0:
        call              0f
        mov               %g0, %o4
        ld                [ %fp + -4 ], %i0
        ret
        restore           %g0, %o0, %o1

asm_test::load::u8::seqcst:
        save              %sp, -96, %sp
        mov               %i0, %o0
0:
        call              0f
        mov               5, %o1
        ret
        restore           %g0, %o0, %o0

asm_test::load::u8::acquire:
        save              %sp, -96, %sp
        mov               %i0, %o0
0:
        call              0f
        mov               2, %o1
        ret
        restore           %g0, %o0, %o0

asm_test::load::u8::relaxed:
        save              %sp, -96, %sp
        mov               %i0, %o0
0:
        call              0f
        mov               %g0, %o1
        ret
        restore           %g0, %o0, %o0

asm_test::load::u16::seqcst:
        save              %sp, -96, %sp
        mov               %i0, %o0
0:
        call              0f
        mov               5, %o1
        ret
        restore           %g0, %o0, %o0

asm_test::load::u16::acquire:
        save              %sp, -96, %sp
        mov               %i0, %o0
0:
        call              0f
        mov               2, %o1
        ret
        restore           %g0, %o0, %o0

asm_test::load::u16::relaxed:
        save              %sp, -96, %sp
        mov               %i0, %o0
0:
        call              0f
        mov               %g0, %o1
        ret
        restore           %g0, %o0, %o0

asm_test::load::u32::seqcst:
        save              %sp, -96, %sp
        mov               %i0, %o0
0:
        call              0f
        mov               5, %o1
        ret
        restore           %g0, %o0, %o0

asm_test::load::u32::acquire:
        save              %sp, -96, %sp
        mov               %i0, %o0
0:
        call              0f
        mov               2, %o1
        ret
        restore           %g0, %o0, %o0

asm_test::load::u32::relaxed:
        save              %sp, -96, %sp
        mov               %i0, %o0
0:
        call              0f
        mov               %g0, %o1
        ret
        restore           %g0, %o0, %o0

asm_test::swap::u8::acqrel:
        save              %sp, -96, %sp
        mov               %i1, %o1
        mov               %i0, %o0
0:
        call              0f
        mov               4, %o2
        ret
        restore           %g0, %o0, %o0

asm_test::swap::u8::seqcst:
        save              %sp, -96, %sp
        mov               %i1, %o1
        mov               %i0, %o0
0:
        call              0f
        mov               5, %o2
        ret
        restore           %g0, %o0, %o0

asm_test::swap::u8::acquire:
        save              %sp, -96, %sp
        mov               %i1, %o1
        mov               %i0, %o0
0:
        call              0f
        mov               2, %o2
        ret
        restore           %g0, %o0, %o0

asm_test::swap::u8::relaxed:
        save              %sp, -96, %sp
        mov               %i1, %o1
        mov               %i0, %o0
0:
        call              0f
        mov               %g0, %o2
        ret
        restore           %g0, %o0, %o0

asm_test::swap::u8::release:
        save              %sp, -96, %sp
        mov               %i1, %o1
        mov               %i0, %o0
0:
        call              0f
        mov               3, %o2
        ret
        restore           %g0, %o0, %o0

asm_test::swap::u16::acqrel:
        save              %sp, -96, %sp
        mov               %i1, %o1
        mov               %i0, %o0
0:
        call              0f
        mov               4, %o2
        ret
        restore           %g0, %o0, %o0

asm_test::swap::u16::seqcst:
        save              %sp, -96, %sp
        mov               %i1, %o1
        mov               %i0, %o0
0:
        call              0f
        mov               5, %o2
        ret
        restore           %g0, %o0, %o0

asm_test::swap::u16::acquire:
        save              %sp, -96, %sp
        mov               %i1, %o1
        mov               %i0, %o0
0:
        call              0f
        mov               2, %o2
        ret
        restore           %g0, %o0, %o0

asm_test::swap::u16::relaxed:
        save              %sp, -96, %sp
        mov               %i1, %o1
        mov               %i0, %o0
0:
        call              0f
        mov               %g0, %o2
        ret
        restore           %g0, %o0, %o0

asm_test::swap::u16::release:
        save              %sp, -96, %sp
        mov               %i1, %o1
        mov               %i0, %o0
0:
        call              0f
        mov               3, %o2
        ret
        restore           %g0, %o0, %o0

asm_test::swap::u32::acqrel:
        save              %sp, -96, %sp
        mov               %i1, %o1
        mov               %i0, %o0
0:
        call              0f
        mov               4, %o2
        ret
        restore           %g0, %o0, %o0

asm_test::swap::u32::seqcst:
        save              %sp, -96, %sp
        mov               %i1, %o1
        mov               %i0, %o0
0:
        call              0f
        mov               5, %o2
        ret
        restore           %g0, %o0, %o0

asm_test::swap::u32::acquire:
        save              %sp, -96, %sp
        mov               %i1, %o1
        mov               %i0, %o0
0:
        call              0f
        mov               2, %o2
        ret
        restore           %g0, %o0, %o0

asm_test::swap::u32::relaxed:
        save              %sp, -96, %sp
        mov               %i1, %o1
        mov               %i0, %o0
0:
        call              0f
        mov               %g0, %o2
        ret
        restore           %g0, %o0, %o0

asm_test::swap::u32::release:
        save              %sp, -96, %sp
        mov               %i1, %o1
        mov               %i0, %o0
0:
        call              0f
        mov               3, %o2
        ret
        restore           %g0, %o0, %o0

asm_test::store::u8::seqcst:
        save              %sp, -96, %sp
        mov               %i1, %o1
        mov               %i0, %o0
0:
        call              0f
        mov               5, %o2
        ret
        restore

asm_test::store::u8::relaxed:
        save              %sp, -96, %sp
        mov               %i1, %o1
        mov               %i0, %o0
0:
        call              0f
        mov               %g0, %o2
        ret
        restore

asm_test::store::u8::release:
        save              %sp, -96, %sp
        mov               %i1, %o1
        mov               %i0, %o0
0:
        call              0f
        mov               3, %o2
        ret
        restore

asm_test::store::u16::seqcst:
        save              %sp, -96, %sp
        mov               %i1, %o1
        mov               %i0, %o0
0:
        call              0f
        mov               5, %o2
        ret
        restore

asm_test::store::u16::relaxed:
        save              %sp, -96, %sp
        mov               %i1, %o1
        mov               %i0, %o0
0:
        call              0f
        mov               %g0, %o2
        ret
        restore

asm_test::store::u16::release:
        save              %sp, -96, %sp
        mov               %i1, %o1
        mov               %i0, %o0
0:
        call              0f
        mov               3, %o2
        ret
        restore

asm_test::store::u32::seqcst:
        save              %sp, -96, %sp
        mov               %i1, %o1
        mov               %i0, %o0
0:
        call              0f
        mov               5, %o2
        ret
        restore

asm_test::store::u32::relaxed:
        save              %sp, -96, %sp
        mov               %i1, %o1
        mov               %i0, %o0
0:
        call              0f
        mov               %g0, %o2
        ret
        restore

asm_test::store::u32::release:
        save              %sp, -96, %sp
        mov               %i1, %o1
        mov               %i0, %o0
0:
        call              0f
        mov               3, %o2
        ret
        restore
