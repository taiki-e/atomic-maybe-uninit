asm_test::compare_exchange::u8::acqrel_seqcst:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        daddiu            $5,$0,255
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xff
        sllv              $5,$5,$3
        andi              $6,$2,0xff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
        sync
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange::u8::seqcst_seqcst:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        daddiu            $5,$0,255
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xff
        sllv              $5,$5,$3
        andi              $6,$2,0xff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
        sync
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange::u8::acqrel_acquire:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        daddiu            $5,$0,255
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xff
        sllv              $5,$5,$3
        andi              $6,$2,0xff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
        sync
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange::u8::acqrel_relaxed:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        daddiu            $5,$0,255
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xff
        sllv              $5,$5,$3
        andi              $6,$2,0xff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
        sync
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange::u8::acquire_seqcst:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        daddiu            $5,$0,255
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xff
        sllv              $5,$5,$3
        andi              $6,$2,0xff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
        sync
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange::u8::relaxed_seqcst:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        daddiu            $5,$0,255
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xff
        sllv              $5,$5,$3
        andi              $6,$2,0xff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
        sync
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange::u8::release_seqcst:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        daddiu            $5,$0,255
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xff
        sllv              $5,$5,$3
        andi              $6,$2,0xff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
        sync
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange::u8::seqcst_acquire:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        daddiu            $5,$0,255
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xff
        sllv              $5,$5,$3
        andi              $6,$2,0xff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
        sync
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange::u8::seqcst_relaxed:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        daddiu            $5,$0,255
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xff
        sllv              $5,$5,$3
        andi              $6,$2,0xff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
        sync
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange::u8::acquire_acquire:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        daddiu            $5,$0,255
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xff
        sllv              $5,$5,$3
        andi              $6,$2,0xff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange::u8::acquire_relaxed:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        daddiu            $5,$0,255
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xff
        sllv              $5,$5,$3
        andi              $6,$2,0xff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange::u8::relaxed_acquire:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        daddiu            $5,$0,255
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xff
        sllv              $5,$5,$3
        andi              $6,$2,0xff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange::u8::relaxed_relaxed:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        daddiu            $5,$0,255
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xff
        sllv              $5,$5,$3
        andi              $6,$2,0xff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange::u8::release_acquire:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        daddiu            $5,$0,255
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xff
        sllv              $5,$5,$3
        andi              $6,$2,0xff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
        sync
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange::u8::release_relaxed:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        daddiu            $5,$0,255
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xff
        sllv              $5,$5,$3
        andi              $6,$2,0xff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
        sync
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange::u16::acqrel_seqcst:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        li                $5,0xffff
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xffff
        sllv              $5,$5,$3
        andi              $6,$2,0xffff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
        sync
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange::u16::seqcst_seqcst:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        li                $5,0xffff
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xffff
        sllv              $5,$5,$3
        andi              $6,$2,0xffff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
        sync
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange::u16::acqrel_acquire:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        li                $5,0xffff
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xffff
        sllv              $5,$5,$3
        andi              $6,$2,0xffff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
        sync
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange::u16::acqrel_relaxed:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        li                $5,0xffff
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xffff
        sllv              $5,$5,$3
        andi              $6,$2,0xffff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
        sync
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange::u16::acquire_seqcst:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        li                $5,0xffff
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xffff
        sllv              $5,$5,$3
        andi              $6,$2,0xffff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
        sync
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange::u16::relaxed_seqcst:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        li                $5,0xffff
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xffff
        sllv              $5,$5,$3
        andi              $6,$2,0xffff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
        sync
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange::u16::release_seqcst:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        li                $5,0xffff
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xffff
        sllv              $5,$5,$3
        andi              $6,$2,0xffff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
        sync
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange::u16::seqcst_acquire:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        li                $5,0xffff
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xffff
        sllv              $5,$5,$3
        andi              $6,$2,0xffff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
        sync
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange::u16::seqcst_relaxed:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        li                $5,0xffff
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xffff
        sllv              $5,$5,$3
        andi              $6,$2,0xffff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
        sync
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange::u16::acquire_acquire:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        li                $5,0xffff
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xffff
        sllv              $5,$5,$3
        andi              $6,$2,0xffff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange::u16::acquire_relaxed:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        li                $5,0xffff
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xffff
        sllv              $5,$5,$3
        andi              $6,$2,0xffff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange::u16::relaxed_acquire:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        li                $5,0xffff
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xffff
        sllv              $5,$5,$3
        andi              $6,$2,0xffff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange::u16::relaxed_relaxed:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        li                $5,0xffff
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xffff
        sllv              $5,$5,$3
        andi              $6,$2,0xffff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange::u16::release_acquire:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        li                $5,0xffff
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xffff
        sllv              $5,$5,$3
        andi              $6,$2,0xffff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
        sync
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange::u16::release_relaxed:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        li                $5,0xffff
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xffff
        sllv              $5,$5,$3
        andi              $6,$2,0xffff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
        sync
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange::u32::acqrel_seqcst:
        sll               $3,$6,0x0
        sll               $1,$5,0x0
        sync
0:
        ll                $2,0($4)
        bne               $2,$1,1f
        li                $5,0
        move              $5,$3
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$5

asm_test::compare_exchange::u32::seqcst_seqcst:
        sll               $3,$6,0x0
        sll               $1,$5,0x0
        sync
0:
        ll                $2,0($4)
        bne               $2,$1,1f
        li                $5,0
        move              $5,$3
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$5

asm_test::compare_exchange::u32::acqrel_acquire:
        sll               $3,$6,0x0
        sll               $1,$5,0x0
        sync
0:
        ll                $2,0($4)
        bne               $2,$1,1f
        li                $5,0
        move              $5,$3
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$5

asm_test::compare_exchange::u32::acqrel_relaxed:
        sll               $3,$6,0x0
        sll               $1,$5,0x0
        sync
0:
        ll                $2,0($4)
        bne               $2,$1,1f
        li                $5,0
        move              $5,$3
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$5

asm_test::compare_exchange::u32::acquire_seqcst:
        sll               $3,$6,0x0
        sll               $1,$5,0x0
        sync
0:
        ll                $2,0($4)
        bne               $2,$1,1f
        li                $5,0
        move              $5,$3
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$5

asm_test::compare_exchange::u32::relaxed_seqcst:
        sll               $3,$6,0x0
        sll               $1,$5,0x0
        sync
0:
        ll                $2,0($4)
        bne               $2,$1,1f
        li                $5,0
        move              $5,$3
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$5

asm_test::compare_exchange::u32::release_seqcst:
        sll               $3,$6,0x0
        sll               $1,$5,0x0
        sync
0:
        ll                $2,0($4)
        bne               $2,$1,1f
        li                $5,0
        move              $5,$3
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$5

asm_test::compare_exchange::u32::seqcst_acquire:
        sll               $3,$6,0x0
        sll               $1,$5,0x0
        sync
0:
        ll                $2,0($4)
        bne               $2,$1,1f
        li                $5,0
        move              $5,$3
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$5

asm_test::compare_exchange::u32::seqcst_relaxed:
        sll               $3,$6,0x0
        sll               $1,$5,0x0
        sync
0:
        ll                $2,0($4)
        bne               $2,$1,1f
        li                $5,0
        move              $5,$3
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$5

asm_test::compare_exchange::u32::acquire_acquire:
        sll               $3,$6,0x0
        sll               $1,$5,0x0
0:
        ll                $2,0($4)
        bne               $2,$1,1f
        li                $5,0
        move              $5,$3
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$5

asm_test::compare_exchange::u32::acquire_relaxed:
        sll               $3,$6,0x0
        sll               $1,$5,0x0
0:
        ll                $2,0($4)
        bne               $2,$1,1f
        li                $5,0
        move              $5,$3
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$5

asm_test::compare_exchange::u32::relaxed_acquire:
        sll               $3,$6,0x0
        sll               $1,$5,0x0
0:
        ll                $2,0($4)
        bne               $2,$1,1f
        li                $5,0
        move              $5,$3
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$5

asm_test::compare_exchange::u32::relaxed_relaxed:
        sll               $3,$6,0x0
        sll               $1,$5,0x0
0:
        ll                $2,0($4)
        bne               $2,$1,1f
        li                $5,0
        move              $5,$3
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        jr                $31
        sltu              $3,$0,$5

asm_test::compare_exchange::u32::release_acquire:
        sll               $3,$6,0x0
        sll               $1,$5,0x0
        sync
0:
        ll                $2,0($4)
        bne               $2,$1,1f
        li                $5,0
        move              $5,$3
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$5

asm_test::compare_exchange::u32::release_relaxed:
        sll               $3,$6,0x0
        sll               $1,$5,0x0
        sync
0:
        ll                $2,0($4)
        bne               $2,$1,1f
        li                $5,0
        move              $5,$3
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        jr                $31
        sltu              $3,$0,$5

asm_test::compare_exchange::u64::acqrel_seqcst:
        sync
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange::u64::seqcst_seqcst:
        sync
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange::u64::acqrel_acquire:
        sync
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange::u64::acqrel_relaxed:
        sync
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange::u64::acquire_seqcst:
        sync
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange::u64::relaxed_seqcst:
        sync
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange::u64::release_seqcst:
        sync
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange::u64::seqcst_acquire:
        sync
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange::u64::seqcst_relaxed:
        sync
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange::u64::acquire_acquire:
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange::u64::acquire_relaxed:
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange::u64::relaxed_acquire:
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange::u64::relaxed_relaxed:
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange::u64::release_acquire:
        sync
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange::u64::release_relaxed:
        sync
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        daddiu            $5,$0,255
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xff
        sllv              $5,$5,$3
        andi              $6,$2,0xff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
        sync
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        daddiu            $5,$0,255
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xff
        sllv              $5,$5,$3
        andi              $6,$2,0xff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
        sync
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        daddiu            $5,$0,255
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xff
        sllv              $5,$5,$3
        andi              $6,$2,0xff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
        sync
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        daddiu            $5,$0,255
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xff
        sllv              $5,$5,$3
        andi              $6,$2,0xff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
        sync
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        daddiu            $5,$0,255
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xff
        sllv              $5,$5,$3
        andi              $6,$2,0xff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
        sync
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        daddiu            $5,$0,255
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xff
        sllv              $5,$5,$3
        andi              $6,$2,0xff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
        sync
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange_weak::u8::release_seqcst:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        daddiu            $5,$0,255
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xff
        sllv              $5,$5,$3
        andi              $6,$2,0xff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
        sync
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        daddiu            $5,$0,255
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xff
        sllv              $5,$5,$3
        andi              $6,$2,0xff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
        sync
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        daddiu            $5,$0,255
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xff
        sllv              $5,$5,$3
        andi              $6,$2,0xff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
        sync
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange_weak::u8::acquire_acquire:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        daddiu            $5,$0,255
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xff
        sllv              $5,$5,$3
        andi              $6,$2,0xff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        daddiu            $5,$0,255
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xff
        sllv              $5,$5,$3
        andi              $6,$2,0xff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        daddiu            $5,$0,255
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xff
        sllv              $5,$5,$3
        andi              $6,$2,0xff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        daddiu            $5,$0,255
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xff
        sllv              $5,$5,$3
        andi              $6,$2,0xff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange_weak::u8::release_acquire:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        daddiu            $5,$0,255
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xff
        sllv              $5,$5,$3
        andi              $6,$2,0xff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
        sync
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange_weak::u8::release_relaxed:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        daddiu            $5,$0,255
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xff
        sllv              $5,$5,$3
        andi              $6,$2,0xff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
        sync
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        li                $5,0xffff
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xffff
        sllv              $5,$5,$3
        andi              $6,$2,0xffff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
        sync
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        li                $5,0xffff
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xffff
        sllv              $5,$5,$3
        andi              $6,$2,0xffff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
        sync
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        li                $5,0xffff
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xffff
        sllv              $5,$5,$3
        andi              $6,$2,0xffff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
        sync
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        li                $5,0xffff
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xffff
        sllv              $5,$5,$3
        andi              $6,$2,0xffff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
        sync
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        li                $5,0xffff
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xffff
        sllv              $5,$5,$3
        andi              $6,$2,0xffff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
        sync
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        li                $5,0xffff
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xffff
        sllv              $5,$5,$3
        andi              $6,$2,0xffff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
        sync
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange_weak::u16::release_seqcst:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        li                $5,0xffff
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xffff
        sllv              $5,$5,$3
        andi              $6,$2,0xffff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
        sync
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        li                $5,0xffff
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xffff
        sllv              $5,$5,$3
        andi              $6,$2,0xffff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
        sync
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        li                $5,0xffff
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xffff
        sllv              $5,$5,$3
        andi              $6,$2,0xffff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
        sync
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange_weak::u16::acquire_acquire:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        li                $5,0xffff
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xffff
        sllv              $5,$5,$3
        andi              $6,$2,0xffff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        li                $5,0xffff
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xffff
        sllv              $5,$5,$3
        andi              $6,$2,0xffff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        li                $5,0xffff
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xffff
        sllv              $5,$5,$3
        andi              $6,$2,0xffff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        li                $5,0xffff
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xffff
        sllv              $5,$5,$3
        andi              $6,$2,0xffff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange_weak::u16::release_acquire:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        li                $5,0xffff
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xffff
        sllv              $5,$5,$3
        andi              $6,$2,0xffff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
        sync
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        sync
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange_weak::u16::release_relaxed:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        dsll              $3,$4,0x3
        li                $5,0xffff
        and               $4,$4,$2
        sll               $2,$6,0x0
        andi              $1,$1,0xffff
        sllv              $5,$5,$3
        andi              $6,$2,0xffff
        sllv              $1,$1,$3
        sllv              $6,$6,$3
        sync
0:
        ll                $2,0($4)
        and               $7,$2,$5
        bne               $7,$1,1f
        li                $7,0
        xor               $7,$2,$6
        and               $7,$7,$5
        xor               $7,$7,$2
        sc                $7,0($4)
        beqz              $7,0b
        nop
1:
        srlv              $2,$2,$3
        jr                $31
        sltu              $3,$0,$7

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        sll               $3,$6,0x0
        sll               $1,$5,0x0
        sync
0:
        ll                $2,0($4)
        bne               $2,$1,1f
        li                $5,0
        move              $5,$3
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$5

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        sll               $3,$6,0x0
        sll               $1,$5,0x0
        sync
0:
        ll                $2,0($4)
        bne               $2,$1,1f
        li                $5,0
        move              $5,$3
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$5

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        sll               $3,$6,0x0
        sll               $1,$5,0x0
        sync
0:
        ll                $2,0($4)
        bne               $2,$1,1f
        li                $5,0
        move              $5,$3
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$5

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        sll               $3,$6,0x0
        sll               $1,$5,0x0
        sync
0:
        ll                $2,0($4)
        bne               $2,$1,1f
        li                $5,0
        move              $5,$3
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$5

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        sll               $3,$6,0x0
        sll               $1,$5,0x0
        sync
0:
        ll                $2,0($4)
        bne               $2,$1,1f
        li                $5,0
        move              $5,$3
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$5

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        sll               $3,$6,0x0
        sll               $1,$5,0x0
        sync
0:
        ll                $2,0($4)
        bne               $2,$1,1f
        li                $5,0
        move              $5,$3
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$5

asm_test::compare_exchange_weak::u32::release_seqcst:
        sll               $3,$6,0x0
        sll               $1,$5,0x0
        sync
0:
        ll                $2,0($4)
        bne               $2,$1,1f
        li                $5,0
        move              $5,$3
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$5

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        sll               $3,$6,0x0
        sll               $1,$5,0x0
        sync
0:
        ll                $2,0($4)
        bne               $2,$1,1f
        li                $5,0
        move              $5,$3
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$5

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        sll               $3,$6,0x0
        sll               $1,$5,0x0
        sync
0:
        ll                $2,0($4)
        bne               $2,$1,1f
        li                $5,0
        move              $5,$3
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$5

asm_test::compare_exchange_weak::u32::acquire_acquire:
        sll               $3,$6,0x0
        sll               $1,$5,0x0
0:
        ll                $2,0($4)
        bne               $2,$1,1f
        li                $5,0
        move              $5,$3
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$5

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        sll               $3,$6,0x0
        sll               $1,$5,0x0
0:
        ll                $2,0($4)
        bne               $2,$1,1f
        li                $5,0
        move              $5,$3
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$5

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        sll               $3,$6,0x0
        sll               $1,$5,0x0
0:
        ll                $2,0($4)
        bne               $2,$1,1f
        li                $5,0
        move              $5,$3
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$5

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        sll               $3,$6,0x0
        sll               $1,$5,0x0
0:
        ll                $2,0($4)
        bne               $2,$1,1f
        li                $5,0
        move              $5,$3
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        jr                $31
        sltu              $3,$0,$5

asm_test::compare_exchange_weak::u32::release_acquire:
        sll               $3,$6,0x0
        sll               $1,$5,0x0
        sync
0:
        ll                $2,0($4)
        bne               $2,$1,1f
        li                $5,0
        move              $5,$3
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$5

asm_test::compare_exchange_weak::u32::release_relaxed:
        sll               $3,$6,0x0
        sll               $1,$5,0x0
        sync
0:
        ll                $2,0($4)
        bne               $2,$1,1f
        li                $5,0
        move              $5,$3
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        jr                $31
        sltu              $3,$0,$5

asm_test::compare_exchange_weak::u64::acqrel_seqcst:
        sync
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange_weak::u64::seqcst_seqcst:
        sync
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange_weak::u64::acqrel_acquire:
        sync
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange_weak::u64::acqrel_relaxed:
        sync
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange_weak::u64::acquire_seqcst:
        sync
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange_weak::u64::relaxed_seqcst:
        sync
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange_weak::u64::release_seqcst:
        sync
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange_weak::u64::seqcst_acquire:
        sync
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange_weak::u64::seqcst_relaxed:
        sync
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange_weak::u64::acquire_acquire:
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange_weak::u64::acquire_relaxed:
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange_weak::u64::relaxed_acquire:
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange_weak::u64::relaxed_relaxed:
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange_weak::u64::release_acquire:
        sync
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange_weak::u64::release_relaxed:
        sync
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        jr                $31
        sltu              $3,$0,$1

asm_test::load::u8::seqcst:
        lb                $2,0($4)
        sync
        jr                $31
        nop

asm_test::load::u8::acquire:
        lb                $2,0($4)
        sync
        jr                $31
        nop

asm_test::load::u8::relaxed:
        lb                $2,0($4)
        jr                $31
        nop

asm_test::load::u16::seqcst:
        lh                $2,0($4)
        sync
        jr                $31
        nop

asm_test::load::u16::acquire:
        lh                $2,0($4)
        sync
        jr                $31
        nop

asm_test::load::u16::relaxed:
        lh                $2,0($4)
        jr                $31
        nop

asm_test::load::u32::seqcst:
        lw                $2,0($4)
        sync
        jr                $31
        nop

asm_test::load::u32::acquire:
        lw                $2,0($4)
        sync
        jr                $31
        nop

asm_test::load::u32::relaxed:
        lw                $2,0($4)
        jr                $31
        nop

asm_test::load::u64::seqcst:
        ld                $2,0($4)
        sync
        jr                $31
        nop

asm_test::load::u64::acquire:
        ld                $2,0($4)
        sync
        jr                $31
        nop

asm_test::load::u64::relaxed:
        ld                $2,0($4)
        jr                $31
        nop

asm_test::swap::u8::acqrel:
        daddiu            $1,$0,-4
        sll               $2,$5,0x0
        dsll              $3,$4,0x3
        and               $1,$4,$1
        andi              $4,$2,0xff
        li                $2,255
        sllv              $2,$2,$3
        sllv              $4,$4,$3
        nor               $5,$2,$0
        sync
0:
        ll                $2,0($1)
        and               $6,$2,$5
        or                $6,$6,$4
        sc                $6,0($1)
        beqz              $6,0b
        nop
        sync
        srlv              $2,$2,$3
        jr                $31
        nop

asm_test::swap::u8::seqcst:
        daddiu            $1,$0,-4
        sll               $2,$5,0x0
        dsll              $3,$4,0x3
        and               $1,$4,$1
        andi              $4,$2,0xff
        li                $2,255
        sllv              $2,$2,$3
        sllv              $4,$4,$3
        nor               $5,$2,$0
        sync
0:
        ll                $2,0($1)
        and               $6,$2,$5
        or                $6,$6,$4
        sc                $6,0($1)
        beqz              $6,0b
        nop
        sync
        srlv              $2,$2,$3
        jr                $31
        nop

asm_test::swap::u8::acquire:
        daddiu            $1,$0,-4
        sll               $2,$5,0x0
        dsll              $3,$4,0x3
        and               $1,$4,$1
        andi              $4,$2,0xff
        li                $2,255
        sllv              $2,$2,$3
        sllv              $4,$4,$3
        nor               $5,$2,$0
0:
        ll                $2,0($1)
        and               $6,$2,$5
        or                $6,$6,$4
        sc                $6,0($1)
        beqz              $6,0b
        nop
        sync
        srlv              $2,$2,$3
        jr                $31
        nop

asm_test::swap::u8::relaxed:
        daddiu            $1,$0,-4
        sll               $2,$5,0x0
        dsll              $3,$4,0x3
        and               $1,$4,$1
        andi              $4,$2,0xff
        li                $2,255
        sllv              $2,$2,$3
        sllv              $4,$4,$3
        nor               $5,$2,$0
0:
        ll                $2,0($1)
        and               $6,$2,$5
        or                $6,$6,$4
        sc                $6,0($1)
        beqz              $6,0b
        nop
        srlv              $2,$2,$3
        jr                $31
        nop

asm_test::swap::u8::release:
        daddiu            $1,$0,-4
        sll               $2,$5,0x0
        dsll              $3,$4,0x3
        and               $1,$4,$1
        andi              $4,$2,0xff
        li                $2,255
        sllv              $2,$2,$3
        sllv              $4,$4,$3
        nor               $5,$2,$0
        sync
0:
        ll                $2,0($1)
        and               $6,$2,$5
        or                $6,$6,$4
        sc                $6,0($1)
        beqz              $6,0b
        nop
        srlv              $2,$2,$3
        jr                $31
        nop

asm_test::swap::u16::acqrel:
        daddiu            $1,$0,-4
        sll               $2,$5,0x0
        dsll              $3,$4,0x3
        and               $1,$4,$1
        andi              $4,$2,0xffff
        li                $2,0xffff
        sllv              $2,$2,$3
        sllv              $4,$4,$3
        nor               $5,$2,$0
        sync
0:
        ll                $2,0($1)
        and               $6,$2,$5
        or                $6,$6,$4
        sc                $6,0($1)
        beqz              $6,0b
        nop
        sync
        srlv              $2,$2,$3
        jr                $31
        nop

asm_test::swap::u16::seqcst:
        daddiu            $1,$0,-4
        sll               $2,$5,0x0
        dsll              $3,$4,0x3
        and               $1,$4,$1
        andi              $4,$2,0xffff
        li                $2,0xffff
        sllv              $2,$2,$3
        sllv              $4,$4,$3
        nor               $5,$2,$0
        sync
0:
        ll                $2,0($1)
        and               $6,$2,$5
        or                $6,$6,$4
        sc                $6,0($1)
        beqz              $6,0b
        nop
        sync
        srlv              $2,$2,$3
        jr                $31
        nop

asm_test::swap::u16::acquire:
        daddiu            $1,$0,-4
        sll               $2,$5,0x0
        dsll              $3,$4,0x3
        and               $1,$4,$1
        andi              $4,$2,0xffff
        li                $2,0xffff
        sllv              $2,$2,$3
        sllv              $4,$4,$3
        nor               $5,$2,$0
0:
        ll                $2,0($1)
        and               $6,$2,$5
        or                $6,$6,$4
        sc                $6,0($1)
        beqz              $6,0b
        nop
        sync
        srlv              $2,$2,$3
        jr                $31
        nop

asm_test::swap::u16::relaxed:
        daddiu            $1,$0,-4
        sll               $2,$5,0x0
        dsll              $3,$4,0x3
        and               $1,$4,$1
        andi              $4,$2,0xffff
        li                $2,0xffff
        sllv              $2,$2,$3
        sllv              $4,$4,$3
        nor               $5,$2,$0
0:
        ll                $2,0($1)
        and               $6,$2,$5
        or                $6,$6,$4
        sc                $6,0($1)
        beqz              $6,0b
        nop
        srlv              $2,$2,$3
        jr                $31
        nop

asm_test::swap::u16::release:
        daddiu            $1,$0,-4
        sll               $2,$5,0x0
        dsll              $3,$4,0x3
        and               $1,$4,$1
        andi              $4,$2,0xffff
        li                $2,0xffff
        sllv              $2,$2,$3
        sllv              $4,$4,$3
        nor               $5,$2,$0
        sync
0:
        ll                $2,0($1)
        and               $6,$2,$5
        or                $6,$6,$4
        sc                $6,0($1)
        beqz              $6,0b
        nop
        srlv              $2,$2,$3
        jr                $31
        nop

asm_test::swap::u32::acqrel:
        sll               $1,$5,0x0
        sync
        move              $3,$1
0:
        ll                $2,0($4)
        sc                $3,0($4)
        beqz              $3,0b
        move              $3,$1
        sync
        jr                $31
        nop

asm_test::swap::u32::seqcst:
        sll               $1,$5,0x0
        sync
        move              $3,$1
0:
        ll                $2,0($4)
        sc                $3,0($4)
        beqz              $3,0b
        move              $3,$1
        sync
        jr                $31
        nop

asm_test::swap::u32::acquire:
        sll               $1,$5,0x0
        move              $3,$1
0:
        ll                $2,0($4)
        sc                $3,0($4)
        beqz              $3,0b
        move              $3,$1
        sync
        jr                $31
        nop

asm_test::swap::u32::relaxed:
        sll               $1,$5,0x0
        move              $3,$1
0:
        ll                $2,0($4)
        sc                $3,0($4)
        beqz              $3,0b
        move              $3,$1
        jr                $31
        nop

asm_test::swap::u32::release:
        sll               $1,$5,0x0
        sync
        move              $3,$1
0:
        ll                $2,0($4)
        sc                $3,0($4)
        beqz              $3,0b
        move              $3,$1
        jr                $31
        nop

asm_test::swap::u64::acqrel:
        sync
        move              $1,$5
0:
        lld               $2,0($4)
        scd               $1,0($4)
        beqz              $1,0b
        move              $1,$5
        sync
        jr                $31
        nop

asm_test::swap::u64::seqcst:
        sync
        move              $1,$5
0:
        lld               $2,0($4)
        scd               $1,0($4)
        beqz              $1,0b
        move              $1,$5
        sync
        jr                $31
        nop

asm_test::swap::u64::acquire:
        move              $1,$5
0:
        lld               $2,0($4)
        scd               $1,0($4)
        beqz              $1,0b
        move              $1,$5
        sync
        jr                $31
        nop

asm_test::swap::u64::relaxed:
        move              $1,$5
0:
        lld               $2,0($4)
        scd               $1,0($4)
        beqz              $1,0b
        move              $1,$5
        jr                $31
        nop

asm_test::swap::u64::release:
        sync
        move              $1,$5
0:
        lld               $2,0($4)
        scd               $1,0($4)
        beqz              $1,0b
        move              $1,$5
        jr                $31
        nop

asm_test::store::u8::seqcst:
        sll               $1,$5,0x0
        andi              $1,$1,0xff
        sync
        sb                $1,0($4)
        sync
        jr                $31
        nop

asm_test::store::u8::relaxed:
        sll               $1,$5,0x0
        andi              $1,$1,0xff
        sb                $1,0($4)
        jr                $31
        nop

asm_test::store::u8::release:
        sll               $1,$5,0x0
        andi              $1,$1,0xff
        sync
        sb                $1,0($4)
        jr                $31
        nop

asm_test::store::u16::seqcst:
        sll               $1,$5,0x0
        andi              $1,$1,0xffff
        sync
        sh                $1,0($4)
        sync
        jr                $31
        nop

asm_test::store::u16::relaxed:
        sll               $1,$5,0x0
        andi              $1,$1,0xffff
        sh                $1,0($4)
        jr                $31
        nop

asm_test::store::u16::release:
        sll               $1,$5,0x0
        andi              $1,$1,0xffff
        sync
        sh                $1,0($4)
        jr                $31
        nop

asm_test::store::u32::seqcst:
        sll               $1,$5,0x0
        sync
        sw                $1,0($4)
        sync
        jr                $31
        nop

asm_test::store::u32::relaxed:
        sll               $1,$5,0x0
        sw                $1,0($4)
        jr                $31
        nop

asm_test::store::u32::release:
        sll               $1,$5,0x0
        sync
        sw                $1,0($4)
        jr                $31
        nop

asm_test::store::u64::seqcst:
        sync
        sd                $5,0($4)
        sync
        jr                $31
        nop

asm_test::store::u64::relaxed:
        sd                $5,0($4)
        jr                $31
        nop

asm_test::store::u64::release:
        sync
        sd                $5,0($4)
        jr                $31
        nop
