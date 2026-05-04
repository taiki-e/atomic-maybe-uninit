asm_test::load::u8::seqcst:
        save              %sp, -96, %sp
        nop
        nop
        nop
        ldstub            [ %sp + -1 ], %g0
        ldub              [ %i0 ], %i0
        nop
        ret
        restore

asm_test::load::u8::acquire:
        save              %sp, -96, %sp
        ldub              [ %i0 ], %i0
        nop
        ret
        restore

asm_test::load::u8::relaxed:
        save              %sp, -96, %sp
        ldub              [ %i0 ], %i0
        nop
        ret
        restore

asm_test::load::u16::seqcst:
        save              %sp, -96, %sp
        nop
        nop
        nop
        ldstub            [ %sp + -1 ], %g0
        lduh              [ %i0 ], %i0
        nop
        ret
        restore

asm_test::load::u16::acquire:
        save              %sp, -96, %sp
        lduh              [ %i0 ], %i0
        nop
        ret
        restore

asm_test::load::u16::relaxed:
        save              %sp, -96, %sp
        lduh              [ %i0 ], %i0
        nop
        ret
        restore

asm_test::load::u32::seqcst:
        save              %sp, -96, %sp
        nop
        nop
        nop
        ldstub            [ %sp + -1 ], %g0
        ld                [ %i0 ], %i0
        nop
        ret
        restore

asm_test::load::u32::acquire:
        save              %sp, -96, %sp
        ld                [ %i0 ], %i0
        nop
        ret
        restore

asm_test::load::u32::relaxed:
        save              %sp, -96, %sp
        ld                [ %i0 ], %i0
        nop
        ret
        restore

asm_test::swap::u32::acqrel:
        save              %sp, -96, %sp
        stbar
        nop
        nop
        ldstub            [ %sp + -1 ], %g0
        swap              [ %i0 ], %i1
        ret
        restore           %g0, %i1, %o0

asm_test::swap::u32::seqcst:
        save              %sp, -96, %sp
        stbar
        nop
        nop
        ldstub            [ %sp + -1 ], %g0
        swap              [ %i0 ], %i1
        ret
        restore           %g0, %i1, %o0

asm_test::swap::u32::acquire:
        save              %sp, -96, %sp
        swap              [ %i0 ], %i1
        ret
        restore           %g0, %i1, %o0

asm_test::swap::u32::relaxed:
        save              %sp, -96, %sp
        swap              [ %i0 ], %i1
        ret
        restore           %g0, %i1, %o0

asm_test::swap::u32::release:
        save              %sp, -96, %sp
        stbar
        nop
        nop
        ldstub            [ %sp + -1 ], %g0
        swap              [ %i0 ], %i1
        ret
        restore           %g0, %i1, %o0

asm_test::store::u8::seqcst:
        save              %sp, -96, %sp
        stbar
        stb               %i1, [ %i0 ]
        stbar
        ldstub            [ %sp + -1 ], %g0
        ret
        restore

asm_test::store::u8::relaxed:
        save              %sp, -96, %sp
        stb               %i1, [ %i0 ]
        nop
        nop
        ret
        restore

asm_test::store::u8::release:
        save              %sp, -96, %sp
        stbar
        stb               %i1, [ %i0 ]
        nop
        nop
        ret
        restore

asm_test::store::u16::seqcst:
        save              %sp, -96, %sp
        stbar
        sth               %i1, [ %i0 ]
        stbar
        ldstub            [ %sp + -1 ], %g0
        ret
        restore

asm_test::store::u16::relaxed:
        save              %sp, -96, %sp
        sth               %i1, [ %i0 ]
        nop
        nop
        ret
        restore

asm_test::store::u16::release:
        save              %sp, -96, %sp
        stbar
        sth               %i1, [ %i0 ]
        nop
        nop
        ret
        restore

asm_test::store::u32::seqcst:
        save              %sp, -96, %sp
        stbar
        st                %i1, [ %i0 ]
        stbar
        ldstub            [ %sp + -1 ], %g0
        ret
        restore

asm_test::store::u32::relaxed:
        save              %sp, -96, %sp
        st                %i1, [ %i0 ]
        nop
        nop
        ret
        restore

asm_test::store::u32::release:
        save              %sp, -96, %sp
        stbar
        st                %i1, [ %i0 ]
        nop
        nop
        ret
        restore
