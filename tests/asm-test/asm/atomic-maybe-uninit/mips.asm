asm_test::compare_exchange::u8::acqrel_seqcst:
        li                $1,-4
        andi              $3,$5,0xff
        sll               $2,$4,0x3
        andi              $5,$6,0xff
        li                $6,255
        and               $1,$4,$1
        xori              $4,$2,0x18
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
        sync
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange::u8::seqcst_seqcst:
        li                $1,-4
        andi              $3,$5,0xff
        sll               $2,$4,0x3
        andi              $5,$6,0xff
        li                $6,255
        and               $1,$4,$1
        xori              $4,$2,0x18
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
        sync
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange::u8::acqrel_acquire:
        li                $1,-4
        andi              $3,$5,0xff
        sll               $2,$4,0x3
        andi              $5,$6,0xff
        li                $6,255
        and               $1,$4,$1
        xori              $4,$2,0x18
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
        sync
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange::u8::acqrel_relaxed:
        li                $1,-4
        andi              $3,$5,0xff
        sll               $2,$4,0x3
        andi              $5,$6,0xff
        li                $6,255
        and               $1,$4,$1
        xori              $4,$2,0x18
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
        sync
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange::u8::acquire_seqcst:
        li                $1,-4
        andi              $3,$5,0xff
        sll               $2,$4,0x3
        andi              $5,$6,0xff
        li                $6,255
        and               $1,$4,$1
        xori              $4,$2,0x18
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
        sync
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange::u8::relaxed_seqcst:
        li                $1,-4
        andi              $3,$5,0xff
        sll               $2,$4,0x3
        andi              $5,$6,0xff
        li                $6,255
        and               $1,$4,$1
        xori              $4,$2,0x18
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
        sync
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange::u8::release_seqcst:
        li                $1,-4
        andi              $3,$5,0xff
        sll               $2,$4,0x3
        andi              $5,$6,0xff
        li                $6,255
        and               $1,$4,$1
        xori              $4,$2,0x18
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
        sync
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange::u8::seqcst_acquire:
        li                $1,-4
        andi              $3,$5,0xff
        sll               $2,$4,0x3
        andi              $5,$6,0xff
        li                $6,255
        and               $1,$4,$1
        xori              $4,$2,0x18
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
        sync
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange::u8::seqcst_relaxed:
        li                $1,-4
        andi              $3,$5,0xff
        sll               $2,$4,0x3
        andi              $5,$6,0xff
        li                $6,255
        and               $1,$4,$1
        xori              $4,$2,0x18
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
        sync
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange::u8::acquire_acquire:
        li                $1,-4
        andi              $3,$5,0xff
        sll               $2,$4,0x3
        andi              $5,$6,0xff
        li                $6,255
        and               $1,$4,$1
        xori              $4,$2,0x18
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange::u8::acquire_relaxed:
        li                $1,-4
        andi              $3,$5,0xff
        sll               $2,$4,0x3
        andi              $5,$6,0xff
        li                $6,255
        and               $1,$4,$1
        xori              $4,$2,0x18
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange::u8::relaxed_acquire:
        li                $1,-4
        andi              $3,$5,0xff
        sll               $2,$4,0x3
        andi              $5,$6,0xff
        li                $6,255
        and               $1,$4,$1
        xori              $4,$2,0x18
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange::u8::relaxed_relaxed:
        li                $1,-4
        andi              $3,$5,0xff
        sll               $2,$4,0x3
        andi              $5,$6,0xff
        li                $6,255
        and               $1,$4,$1
        xori              $4,$2,0x18
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange::u8::release_acquire:
        li                $1,-4
        andi              $3,$5,0xff
        sll               $2,$4,0x3
        andi              $5,$6,0xff
        li                $6,255
        and               $1,$4,$1
        xori              $4,$2,0x18
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
        sync
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange::u8::release_relaxed:
        li                $1,-4
        andi              $3,$5,0xff
        sll               $2,$4,0x3
        andi              $5,$6,0xff
        li                $6,255
        and               $1,$4,$1
        xori              $4,$2,0x18
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
        sync
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange::u16::acqrel_seqcst:
        li                $1,-4
        andi              $3,$5,0xffff
        sll               $2,$4,0x3
        andi              $5,$6,0xffff
        li                $6,0xffff
        and               $1,$4,$1
        xori              $4,$2,0x10
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
        sync
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange::u16::seqcst_seqcst:
        li                $1,-4
        andi              $3,$5,0xffff
        sll               $2,$4,0x3
        andi              $5,$6,0xffff
        li                $6,0xffff
        and               $1,$4,$1
        xori              $4,$2,0x10
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
        sync
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange::u16::acqrel_acquire:
        li                $1,-4
        andi              $3,$5,0xffff
        sll               $2,$4,0x3
        andi              $5,$6,0xffff
        li                $6,0xffff
        and               $1,$4,$1
        xori              $4,$2,0x10
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
        sync
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange::u16::acqrel_relaxed:
        li                $1,-4
        andi              $3,$5,0xffff
        sll               $2,$4,0x3
        andi              $5,$6,0xffff
        li                $6,0xffff
        and               $1,$4,$1
        xori              $4,$2,0x10
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
        sync
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange::u16::acquire_seqcst:
        li                $1,-4
        andi              $3,$5,0xffff
        sll               $2,$4,0x3
        andi              $5,$6,0xffff
        li                $6,0xffff
        and               $1,$4,$1
        xori              $4,$2,0x10
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
        sync
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange::u16::relaxed_seqcst:
        li                $1,-4
        andi              $3,$5,0xffff
        sll               $2,$4,0x3
        andi              $5,$6,0xffff
        li                $6,0xffff
        and               $1,$4,$1
        xori              $4,$2,0x10
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
        sync
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange::u16::release_seqcst:
        li                $1,-4
        andi              $3,$5,0xffff
        sll               $2,$4,0x3
        andi              $5,$6,0xffff
        li                $6,0xffff
        and               $1,$4,$1
        xori              $4,$2,0x10
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
        sync
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange::u16::seqcst_acquire:
        li                $1,-4
        andi              $3,$5,0xffff
        sll               $2,$4,0x3
        andi              $5,$6,0xffff
        li                $6,0xffff
        and               $1,$4,$1
        xori              $4,$2,0x10
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
        sync
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange::u16::seqcst_relaxed:
        li                $1,-4
        andi              $3,$5,0xffff
        sll               $2,$4,0x3
        andi              $5,$6,0xffff
        li                $6,0xffff
        and               $1,$4,$1
        xori              $4,$2,0x10
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
        sync
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange::u16::acquire_acquire:
        li                $1,-4
        andi              $3,$5,0xffff
        sll               $2,$4,0x3
        andi              $5,$6,0xffff
        li                $6,0xffff
        and               $1,$4,$1
        xori              $4,$2,0x10
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange::u16::acquire_relaxed:
        li                $1,-4
        andi              $3,$5,0xffff
        sll               $2,$4,0x3
        andi              $5,$6,0xffff
        li                $6,0xffff
        and               $1,$4,$1
        xori              $4,$2,0x10
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange::u16::relaxed_acquire:
        li                $1,-4
        andi              $3,$5,0xffff
        sll               $2,$4,0x3
        andi              $5,$6,0xffff
        li                $6,0xffff
        and               $1,$4,$1
        xori              $4,$2,0x10
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange::u16::relaxed_relaxed:
        li                $1,-4
        andi              $3,$5,0xffff
        sll               $2,$4,0x3
        andi              $5,$6,0xffff
        li                $6,0xffff
        and               $1,$4,$1
        xori              $4,$2,0x10
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange::u16::release_acquire:
        li                $1,-4
        andi              $3,$5,0xffff
        sll               $2,$4,0x3
        andi              $5,$6,0xffff
        li                $6,0xffff
        and               $1,$4,$1
        xori              $4,$2,0x10
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
        sync
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange::u16::release_relaxed:
        li                $1,-4
        andi              $3,$5,0xffff
        sll               $2,$4,0x3
        andi              $5,$6,0xffff
        li                $6,0xffff
        and               $1,$4,$1
        xori              $4,$2,0x10
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
        sync
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange::u32::acqrel_seqcst:
        sync
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange::u32::seqcst_seqcst:
        sync
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange::u32::acqrel_acquire:
        sync
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange::u32::acqrel_relaxed:
        sync
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange::u32::acquire_seqcst:
        sync
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange::u32::relaxed_seqcst:
        sync
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange::u32::release_seqcst:
        sync
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange::u32::seqcst_acquire:
        sync
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange::u32::seqcst_relaxed:
        sync
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange::u32::acquire_acquire:
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange::u32::acquire_relaxed:
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange::u32::relaxed_acquire:
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange::u32::relaxed_relaxed:
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange::u32::release_acquire:
        sync
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange::u32::release_relaxed:
        sync
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        li                $1,-4
        andi              $3,$5,0xff
        sll               $2,$4,0x3
        andi              $5,$6,0xff
        li                $6,255
        and               $1,$4,$1
        xori              $4,$2,0x18
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
        sync
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        li                $1,-4
        andi              $3,$5,0xff
        sll               $2,$4,0x3
        andi              $5,$6,0xff
        li                $6,255
        and               $1,$4,$1
        xori              $4,$2,0x18
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
        sync
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        li                $1,-4
        andi              $3,$5,0xff
        sll               $2,$4,0x3
        andi              $5,$6,0xff
        li                $6,255
        and               $1,$4,$1
        xori              $4,$2,0x18
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
        sync
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        li                $1,-4
        andi              $3,$5,0xff
        sll               $2,$4,0x3
        andi              $5,$6,0xff
        li                $6,255
        and               $1,$4,$1
        xori              $4,$2,0x18
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
        sync
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        li                $1,-4
        andi              $3,$5,0xff
        sll               $2,$4,0x3
        andi              $5,$6,0xff
        li                $6,255
        and               $1,$4,$1
        xori              $4,$2,0x18
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
        sync
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        li                $1,-4
        andi              $3,$5,0xff
        sll               $2,$4,0x3
        andi              $5,$6,0xff
        li                $6,255
        and               $1,$4,$1
        xori              $4,$2,0x18
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
        sync
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange_weak::u8::release_seqcst:
        li                $1,-4
        andi              $3,$5,0xff
        sll               $2,$4,0x3
        andi              $5,$6,0xff
        li                $6,255
        and               $1,$4,$1
        xori              $4,$2,0x18
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
        sync
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        li                $1,-4
        andi              $3,$5,0xff
        sll               $2,$4,0x3
        andi              $5,$6,0xff
        li                $6,255
        and               $1,$4,$1
        xori              $4,$2,0x18
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
        sync
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        li                $1,-4
        andi              $3,$5,0xff
        sll               $2,$4,0x3
        andi              $5,$6,0xff
        li                $6,255
        and               $1,$4,$1
        xori              $4,$2,0x18
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
        sync
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange_weak::u8::acquire_acquire:
        li                $1,-4
        andi              $3,$5,0xff
        sll               $2,$4,0x3
        andi              $5,$6,0xff
        li                $6,255
        and               $1,$4,$1
        xori              $4,$2,0x18
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        li                $1,-4
        andi              $3,$5,0xff
        sll               $2,$4,0x3
        andi              $5,$6,0xff
        li                $6,255
        and               $1,$4,$1
        xori              $4,$2,0x18
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        li                $1,-4
        andi              $3,$5,0xff
        sll               $2,$4,0x3
        andi              $5,$6,0xff
        li                $6,255
        and               $1,$4,$1
        xori              $4,$2,0x18
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        li                $1,-4
        andi              $3,$5,0xff
        sll               $2,$4,0x3
        andi              $5,$6,0xff
        li                $6,255
        and               $1,$4,$1
        xori              $4,$2,0x18
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange_weak::u8::release_acquire:
        li                $1,-4
        andi              $3,$5,0xff
        sll               $2,$4,0x3
        andi              $5,$6,0xff
        li                $6,255
        and               $1,$4,$1
        xori              $4,$2,0x18
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
        sync
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange_weak::u8::release_relaxed:
        li                $1,-4
        andi              $3,$5,0xff
        sll               $2,$4,0x3
        andi              $5,$6,0xff
        li                $6,255
        and               $1,$4,$1
        xori              $4,$2,0x18
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
        sync
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        li                $1,-4
        andi              $3,$5,0xffff
        sll               $2,$4,0x3
        andi              $5,$6,0xffff
        li                $6,0xffff
        and               $1,$4,$1
        xori              $4,$2,0x10
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
        sync
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        li                $1,-4
        andi              $3,$5,0xffff
        sll               $2,$4,0x3
        andi              $5,$6,0xffff
        li                $6,0xffff
        and               $1,$4,$1
        xori              $4,$2,0x10
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
        sync
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        li                $1,-4
        andi              $3,$5,0xffff
        sll               $2,$4,0x3
        andi              $5,$6,0xffff
        li                $6,0xffff
        and               $1,$4,$1
        xori              $4,$2,0x10
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
        sync
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        li                $1,-4
        andi              $3,$5,0xffff
        sll               $2,$4,0x3
        andi              $5,$6,0xffff
        li                $6,0xffff
        and               $1,$4,$1
        xori              $4,$2,0x10
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
        sync
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        li                $1,-4
        andi              $3,$5,0xffff
        sll               $2,$4,0x3
        andi              $5,$6,0xffff
        li                $6,0xffff
        and               $1,$4,$1
        xori              $4,$2,0x10
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
        sync
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        li                $1,-4
        andi              $3,$5,0xffff
        sll               $2,$4,0x3
        andi              $5,$6,0xffff
        li                $6,0xffff
        and               $1,$4,$1
        xori              $4,$2,0x10
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
        sync
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange_weak::u16::release_seqcst:
        li                $1,-4
        andi              $3,$5,0xffff
        sll               $2,$4,0x3
        andi              $5,$6,0xffff
        li                $6,0xffff
        and               $1,$4,$1
        xori              $4,$2,0x10
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
        sync
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        li                $1,-4
        andi              $3,$5,0xffff
        sll               $2,$4,0x3
        andi              $5,$6,0xffff
        li                $6,0xffff
        and               $1,$4,$1
        xori              $4,$2,0x10
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
        sync
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        li                $1,-4
        andi              $3,$5,0xffff
        sll               $2,$4,0x3
        andi              $5,$6,0xffff
        li                $6,0xffff
        and               $1,$4,$1
        xori              $4,$2,0x10
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
        sync
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange_weak::u16::acquire_acquire:
        li                $1,-4
        andi              $3,$5,0xffff
        sll               $2,$4,0x3
        andi              $5,$6,0xffff
        li                $6,0xffff
        and               $1,$4,$1
        xori              $4,$2,0x10
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        li                $1,-4
        andi              $3,$5,0xffff
        sll               $2,$4,0x3
        andi              $5,$6,0xffff
        li                $6,0xffff
        and               $1,$4,$1
        xori              $4,$2,0x10
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        li                $1,-4
        andi              $3,$5,0xffff
        sll               $2,$4,0x3
        andi              $5,$6,0xffff
        li                $6,0xffff
        and               $1,$4,$1
        xori              $4,$2,0x10
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        li                $1,-4
        andi              $3,$5,0xffff
        sll               $2,$4,0x3
        andi              $5,$6,0xffff
        li                $6,0xffff
        and               $1,$4,$1
        xori              $4,$2,0x10
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange_weak::u16::release_acquire:
        li                $1,-4
        andi              $3,$5,0xffff
        sll               $2,$4,0x3
        andi              $5,$6,0xffff
        li                $6,0xffff
        and               $1,$4,$1
        xori              $4,$2,0x10
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
        sync
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sync
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange_weak::u16::release_relaxed:
        li                $1,-4
        andi              $3,$5,0xffff
        sll               $2,$4,0x3
        andi              $5,$6,0xffff
        li                $6,0xffff
        and               $1,$4,$1
        xori              $4,$2,0x10
        sllv              $3,$3,$4
        sllv              $5,$5,$4
        sllv              $6,$6,$4
        sync
0:
        ll                $2,0($1)
        and               $7,$2,$6
        bne               $7,$3,1f
        li                $7,0
        xor               $7,$2,$5
        and               $7,$7,$6
        xor               $7,$7,$2
        sc                $7,0($1)
        beqz              $7,0b
        nop
1:
        sltu              $3,$0,$7
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        sync
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        sync
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        sync
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        sync
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        sync
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        sync
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange_weak::u32::release_seqcst:
        sync
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        sync
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        sync
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange_weak::u32::acquire_acquire:
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange_weak::u32::acquire_relaxed:
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange_weak::u32::relaxed_acquire:
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange_weak::u32::release_acquire:
        sync
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        jr                $31
        sltu              $3,$0,$1

asm_test::compare_exchange_weak::u32::release_relaxed:
        sync
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        li                $1,0
        move              $1,$6
        sc                $1,0($4)
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

asm_test::swap::u8::acqrel:
        li                $1,-4
        sll               $2,$4,0x3
        andi              $3,$5,0xff
        and               $1,$4,$1
        xori              $4,$2,0x18
        li                $2,255
        sllv              $3,$3,$4
        sllv              $2,$2,$4
        nor               $5,$2,$0
        sync
0:
        ll                $2,0($1)
        and               $6,$2,$5
        or                $6,$6,$3
        sc                $6,0($1)
        beqz              $6,0b
        nop
        sync
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::swap::u8::seqcst:
        li                $1,-4
        sll               $2,$4,0x3
        andi              $3,$5,0xff
        and               $1,$4,$1
        xori              $4,$2,0x18
        li                $2,255
        sllv              $3,$3,$4
        sllv              $2,$2,$4
        nor               $5,$2,$0
        sync
0:
        ll                $2,0($1)
        and               $6,$2,$5
        or                $6,$6,$3
        sc                $6,0($1)
        beqz              $6,0b
        nop
        sync
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::swap::u8::acquire:
        li                $1,-4
        sll               $2,$4,0x3
        andi              $3,$5,0xff
        and               $1,$4,$1
        xori              $4,$2,0x18
        li                $2,255
        sllv              $3,$3,$4
        sllv              $2,$2,$4
        nor               $5,$2,$0
0:
        ll                $2,0($1)
        and               $6,$2,$5
        or                $6,$6,$3
        sc                $6,0($1)
        beqz              $6,0b
        nop
        sync
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::swap::u8::relaxed:
        li                $1,-4
        sll               $2,$4,0x3
        andi              $3,$5,0xff
        and               $1,$4,$1
        xori              $4,$2,0x18
        li                $2,255
        sllv              $3,$3,$4
        sllv              $2,$2,$4
        nor               $5,$2,$0
0:
        ll                $2,0($1)
        and               $6,$2,$5
        or                $6,$6,$3
        sc                $6,0($1)
        beqz              $6,0b
        nop
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::swap::u8::release:
        li                $1,-4
        sll               $2,$4,0x3
        andi              $3,$5,0xff
        and               $1,$4,$1
        xori              $4,$2,0x18
        li                $2,255
        sllv              $3,$3,$4
        sllv              $2,$2,$4
        nor               $5,$2,$0
        sync
0:
        ll                $2,0($1)
        and               $6,$2,$5
        or                $6,$6,$3
        sc                $6,0($1)
        beqz              $6,0b
        nop
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::swap::u16::acqrel:
        li                $1,-4
        sll               $2,$4,0x3
        andi              $3,$5,0xffff
        and               $1,$4,$1
        xori              $4,$2,0x10
        li                $2,0xffff
        sllv              $3,$3,$4
        sllv              $2,$2,$4
        nor               $5,$2,$0
        sync
0:
        ll                $2,0($1)
        and               $6,$2,$5
        or                $6,$6,$3
        sc                $6,0($1)
        beqz              $6,0b
        nop
        sync
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::swap::u16::seqcst:
        li                $1,-4
        sll               $2,$4,0x3
        andi              $3,$5,0xffff
        and               $1,$4,$1
        xori              $4,$2,0x10
        li                $2,0xffff
        sllv              $3,$3,$4
        sllv              $2,$2,$4
        nor               $5,$2,$0
        sync
0:
        ll                $2,0($1)
        and               $6,$2,$5
        or                $6,$6,$3
        sc                $6,0($1)
        beqz              $6,0b
        nop
        sync
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::swap::u16::acquire:
        li                $1,-4
        sll               $2,$4,0x3
        andi              $3,$5,0xffff
        and               $1,$4,$1
        xori              $4,$2,0x10
        li                $2,0xffff
        sllv              $3,$3,$4
        sllv              $2,$2,$4
        nor               $5,$2,$0
0:
        ll                $2,0($1)
        and               $6,$2,$5
        or                $6,$6,$3
        sc                $6,0($1)
        beqz              $6,0b
        nop
        sync
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::swap::u16::relaxed:
        li                $1,-4
        sll               $2,$4,0x3
        andi              $3,$5,0xffff
        and               $1,$4,$1
        xori              $4,$2,0x10
        li                $2,0xffff
        sllv              $3,$3,$4
        sllv              $2,$2,$4
        nor               $5,$2,$0
0:
        ll                $2,0($1)
        and               $6,$2,$5
        or                $6,$6,$3
        sc                $6,0($1)
        beqz              $6,0b
        nop
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::swap::u16::release:
        li                $1,-4
        sll               $2,$4,0x3
        andi              $3,$5,0xffff
        and               $1,$4,$1
        xori              $4,$2,0x10
        li                $2,0xffff
        sllv              $3,$3,$4
        sllv              $2,$2,$4
        nor               $5,$2,$0
        sync
0:
        ll                $2,0($1)
        and               $6,$2,$5
        or                $6,$6,$3
        sc                $6,0($1)
        beqz              $6,0b
        nop
        srlv              $2,$2,$4
        jr                $31
        nop

asm_test::swap::u32::acqrel:
        sync
        move              $1,$5
0:
        ll                $2,0($4)
        sc                $1,0($4)
        beqz              $1,0b
        move              $1,$5
        sync
        jr                $31
        nop

asm_test::swap::u32::seqcst:
        sync
        move              $1,$5
0:
        ll                $2,0($4)
        sc                $1,0($4)
        beqz              $1,0b
        move              $1,$5
        sync
        jr                $31
        nop

asm_test::swap::u32::acquire:
        move              $1,$5
0:
        ll                $2,0($4)
        sc                $1,0($4)
        beqz              $1,0b
        move              $1,$5
        sync
        jr                $31
        nop

asm_test::swap::u32::relaxed:
        move              $1,$5
0:
        ll                $2,0($4)
        sc                $1,0($4)
        beqz              $1,0b
        move              $1,$5
        jr                $31
        nop

asm_test::swap::u32::release:
        sync
        move              $1,$5
0:
        ll                $2,0($4)
        sc                $1,0($4)
        beqz              $1,0b
        move              $1,$5
        jr                $31
        nop

asm_test::store::u8::seqcst:
        andi              $1,$5,0xff
        sync
        sb                $1,0($4)
        sync
        jr                $31
        nop

asm_test::store::u8::relaxed:
        andi              $1,$5,0xff
        sb                $1,0($4)
        jr                $31
        nop

asm_test::store::u8::release:
        andi              $1,$5,0xff
        sync
        sb                $1,0($4)
        jr                $31
        nop

asm_test::store::u16::seqcst:
        andi              $1,$5,0xffff
        sync
        sh                $1,0($4)
        sync
        jr                $31
        nop

asm_test::store::u16::relaxed:
        andi              $1,$5,0xffff
        sh                $1,0($4)
        jr                $31
        nop

asm_test::store::u16::release:
        andi              $1,$5,0xffff
        sync
        sh                $1,0($4)
        jr                $31
        nop

asm_test::store::u32::seqcst:
        sync
        sw                $5,0($4)
        sync
        jr                $31
        nop

asm_test::store::u32::relaxed:
        sw                $5,0($4)
        jr                $31
        nop

asm_test::store::u32::release:
        sync
        sw                $5,0($4)
        jr                $31
        nop
