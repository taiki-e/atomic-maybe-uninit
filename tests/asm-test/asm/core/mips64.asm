asm_test::compare_exchange::u8::acqrel_seqcst:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xff
        sync
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xff
        andi              $2,$2,0xff
        seb               $1,$1
        xori              $4,$4,0x3
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seb               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u8::seqcst_seqcst:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xff
        sync
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xff
        andi              $2,$2,0xff
        seb               $1,$1
        xori              $4,$4,0x3
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seb               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u8::acqrel_acquire:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xff
        sync
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xff
        andi              $2,$2,0xff
        seb               $1,$1
        xori              $4,$4,0x3
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seb               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u8::acqrel_relaxed:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xff
        sync
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xff
        andi              $2,$2,0xff
        seb               $1,$1
        xori              $4,$4,0x3
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seb               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u8::acquire_seqcst:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xff
        sync
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xff
        andi              $2,$2,0xff
        seb               $1,$1
        xori              $4,$4,0x3
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seb               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u8::relaxed_seqcst:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xff
        sync
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xff
        andi              $2,$2,0xff
        seb               $1,$1
        xori              $4,$4,0x3
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seb               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u8::release_seqcst:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xff
        sync
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xff
        andi              $2,$2,0xff
        seb               $1,$1
        xori              $4,$4,0x3
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seb               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u8::seqcst_acquire:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xff
        sync
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xff
        andi              $2,$2,0xff
        seb               $1,$1
        xori              $4,$4,0x3
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seb               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u8::seqcst_relaxed:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xff
        sync
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xff
        andi              $2,$2,0xff
        seb               $1,$1
        xori              $4,$4,0x3
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seb               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u8::acquire_acquire:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xff
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xff
        andi              $2,$2,0xff
        seb               $1,$1
        xori              $4,$4,0x3
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seb               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u8::acquire_relaxed:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xff
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xff
        andi              $2,$2,0xff
        seb               $1,$1
        xori              $4,$4,0x3
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seb               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u8::relaxed_acquire:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xff
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xff
        andi              $2,$2,0xff
        seb               $1,$1
        xori              $4,$4,0x3
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seb               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u8::relaxed_relaxed:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xff
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xff
        andi              $2,$2,0xff
        seb               $1,$1
        xori              $4,$4,0x3
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seb               $2,$2
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u8::release_acquire:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xff
        sync
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xff
        andi              $2,$2,0xff
        seb               $1,$1
        xori              $4,$4,0x3
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seb               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u8::release_relaxed:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xff
        sync
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xff
        andi              $2,$2,0xff
        seb               $1,$1
        xori              $4,$4,0x3
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seb               $2,$2
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u16::acqrel_seqcst:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xffff
        sync
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xffff
        andi              $2,$2,0xffff
        seh               $1,$1
        xori              $4,$4,0x2
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seh               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u16::seqcst_seqcst:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xffff
        sync
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xffff
        andi              $2,$2,0xffff
        seh               $1,$1
        xori              $4,$4,0x2
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seh               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u16::acqrel_acquire:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xffff
        sync
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xffff
        andi              $2,$2,0xffff
        seh               $1,$1
        xori              $4,$4,0x2
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seh               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u16::acqrel_relaxed:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xffff
        sync
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xffff
        andi              $2,$2,0xffff
        seh               $1,$1
        xori              $4,$4,0x2
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seh               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u16::acquire_seqcst:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xffff
        sync
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xffff
        andi              $2,$2,0xffff
        seh               $1,$1
        xori              $4,$4,0x2
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seh               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u16::relaxed_seqcst:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xffff
        sync
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xffff
        andi              $2,$2,0xffff
        seh               $1,$1
        xori              $4,$4,0x2
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seh               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u16::release_seqcst:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xffff
        sync
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xffff
        andi              $2,$2,0xffff
        seh               $1,$1
        xori              $4,$4,0x2
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seh               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u16::seqcst_acquire:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xffff
        sync
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xffff
        andi              $2,$2,0xffff
        seh               $1,$1
        xori              $4,$4,0x2
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seh               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u16::seqcst_relaxed:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xffff
        sync
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xffff
        andi              $2,$2,0xffff
        seh               $1,$1
        xori              $4,$4,0x2
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seh               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u16::acquire_acquire:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xffff
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xffff
        andi              $2,$2,0xffff
        seh               $1,$1
        xori              $4,$4,0x2
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seh               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u16::acquire_relaxed:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xffff
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xffff
        andi              $2,$2,0xffff
        seh               $1,$1
        xori              $4,$4,0x2
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seh               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u16::relaxed_acquire:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xffff
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xffff
        andi              $2,$2,0xffff
        seh               $1,$1
        xori              $4,$4,0x2
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seh               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u16::relaxed_relaxed:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xffff
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xffff
        andi              $2,$2,0xffff
        seh               $1,$1
        xori              $4,$4,0x2
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seh               $2,$2
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u16::release_acquire:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xffff
        sync
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xffff
        andi              $2,$2,0xffff
        seh               $1,$1
        xori              $4,$4,0x2
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seh               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u16::release_relaxed:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xffff
        sync
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xffff
        andi              $2,$2,0xffff
        seh               $1,$1
        xori              $4,$4,0x2
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seh               $2,$2
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u32::acqrel_seqcst:
        sll               $1,$6,0x0
        sll               $3,$5,0x0
        sync
0:
        ll                $2,0($4)
        bne               $2,$3,1f
        nop
        move              $5,$1
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        xor               $1,$2,$3
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u32::seqcst_seqcst:
        sll               $1,$6,0x0
        sll               $3,$5,0x0
        sync
0:
        ll                $2,0($4)
        bne               $2,$3,1f
        nop
        move              $5,$1
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        xor               $1,$2,$3
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u32::acqrel_acquire:
        sll               $1,$6,0x0
        sll               $3,$5,0x0
        sync
0:
        ll                $2,0($4)
        bne               $2,$3,1f
        nop
        move              $5,$1
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        xor               $1,$2,$3
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u32::acqrel_relaxed:
        sll               $1,$6,0x0
        sll               $3,$5,0x0
        sync
0:
        ll                $2,0($4)
        bne               $2,$3,1f
        nop
        move              $5,$1
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        xor               $1,$2,$3
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u32::acquire_seqcst:
        sll               $1,$6,0x0
        sll               $3,$5,0x0
        sync
0:
        ll                $2,0($4)
        bne               $2,$3,1f
        nop
        move              $5,$1
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        xor               $1,$2,$3
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u32::relaxed_seqcst:
        sll               $1,$6,0x0
        sll               $3,$5,0x0
        sync
0:
        ll                $2,0($4)
        bne               $2,$3,1f
        nop
        move              $5,$1
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        xor               $1,$2,$3
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u32::release_seqcst:
        sll               $1,$6,0x0
        sll               $3,$5,0x0
        sync
0:
        ll                $2,0($4)
        bne               $2,$3,1f
        nop
        move              $5,$1
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        xor               $1,$2,$3
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u32::seqcst_acquire:
        sll               $1,$6,0x0
        sll               $3,$5,0x0
        sync
0:
        ll                $2,0($4)
        bne               $2,$3,1f
        nop
        move              $5,$1
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        xor               $1,$2,$3
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u32::seqcst_relaxed:
        sll               $1,$6,0x0
        sll               $3,$5,0x0
        sync
0:
        ll                $2,0($4)
        bne               $2,$3,1f
        nop
        move              $5,$1
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        xor               $1,$2,$3
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u32::acquire_acquire:
        sll               $1,$6,0x0
        sll               $3,$5,0x0
0:
        ll                $2,0($4)
        bne               $2,$3,1f
        nop
        move              $5,$1
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        xor               $1,$2,$3
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u32::acquire_relaxed:
        sll               $1,$6,0x0
        sll               $3,$5,0x0
0:
        ll                $2,0($4)
        bne               $2,$3,1f
        nop
        move              $5,$1
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        xor               $1,$2,$3
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u32::relaxed_acquire:
        sll               $1,$6,0x0
        sll               $3,$5,0x0
0:
        ll                $2,0($4)
        bne               $2,$3,1f
        nop
        move              $5,$1
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        xor               $1,$2,$3
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u32::relaxed_relaxed:
        sll               $1,$6,0x0
        sll               $3,$5,0x0
0:
        ll                $2,0($4)
        bne               $2,$3,1f
        nop
        move              $5,$1
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        xor               $1,$2,$3
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u32::release_acquire:
        sll               $1,$6,0x0
        sll               $3,$5,0x0
        sync
0:
        ll                $2,0($4)
        bne               $2,$3,1f
        nop
        move              $5,$1
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        xor               $1,$2,$3
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u32::release_relaxed:
        sll               $1,$6,0x0
        sll               $3,$5,0x0
        sync
0:
        ll                $2,0($4)
        bne               $2,$3,1f
        nop
        move              $5,$1
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        xor               $1,$2,$3
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u64::acqrel_seqcst:
        sync
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u64::seqcst_seqcst:
        sync
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u64::acqrel_acquire:
        sync
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u64::acqrel_relaxed:
        sync
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u64::acquire_seqcst:
        sync
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u64::relaxed_seqcst:
        sync
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u64::release_seqcst:
        sync
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u64::seqcst_acquire:
        sync
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u64::seqcst_relaxed:
        sync
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u64::acquire_acquire:
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u64::acquire_relaxed:
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u64::relaxed_acquire:
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u64::relaxed_relaxed:
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u64::release_acquire:
        sync
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u64::release_relaxed:
        sync
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xff
        sync
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xff
        andi              $2,$2,0xff
        seb               $1,$1
        xori              $4,$4,0x3
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seb               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xff
        sync
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xff
        andi              $2,$2,0xff
        seb               $1,$1
        xori              $4,$4,0x3
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seb               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xff
        sync
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xff
        andi              $2,$2,0xff
        seb               $1,$1
        xori              $4,$4,0x3
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seb               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xff
        sync
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xff
        andi              $2,$2,0xff
        seb               $1,$1
        xori              $4,$4,0x3
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seb               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xff
        sync
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xff
        andi              $2,$2,0xff
        seb               $1,$1
        xori              $4,$4,0x3
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seb               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xff
        sync
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xff
        andi              $2,$2,0xff
        seb               $1,$1
        xori              $4,$4,0x3
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seb               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u8::release_seqcst:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xff
        sync
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xff
        andi              $2,$2,0xff
        seb               $1,$1
        xori              $4,$4,0x3
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seb               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xff
        sync
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xff
        andi              $2,$2,0xff
        seb               $1,$1
        xori              $4,$4,0x3
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seb               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xff
        sync
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xff
        andi              $2,$2,0xff
        seb               $1,$1
        xori              $4,$4,0x3
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seb               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u8::acquire_acquire:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xff
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xff
        andi              $2,$2,0xff
        seb               $1,$1
        xori              $4,$4,0x3
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seb               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xff
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xff
        andi              $2,$2,0xff
        seb               $1,$1
        xori              $4,$4,0x3
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seb               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xff
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xff
        andi              $2,$2,0xff
        seb               $1,$1
        xori              $4,$4,0x3
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seb               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xff
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xff
        andi              $2,$2,0xff
        seb               $1,$1
        xori              $4,$4,0x3
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seb               $2,$2
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u8::release_acquire:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xff
        sync
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xff
        andi              $2,$2,0xff
        seb               $1,$1
        xori              $4,$4,0x3
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seb               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u8::release_relaxed:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xff
        sync
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xff
        andi              $2,$2,0xff
        seb               $1,$1
        xori              $4,$4,0x3
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seb               $2,$2
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xffff
        sync
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xffff
        andi              $2,$2,0xffff
        seh               $1,$1
        xori              $4,$4,0x2
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seh               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xffff
        sync
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xffff
        andi              $2,$2,0xffff
        seh               $1,$1
        xori              $4,$4,0x2
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seh               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xffff
        sync
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xffff
        andi              $2,$2,0xffff
        seh               $1,$1
        xori              $4,$4,0x2
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seh               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xffff
        sync
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xffff
        andi              $2,$2,0xffff
        seh               $1,$1
        xori              $4,$4,0x2
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seh               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xffff
        sync
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xffff
        andi              $2,$2,0xffff
        seh               $1,$1
        xori              $4,$4,0x2
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seh               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xffff
        sync
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xffff
        andi              $2,$2,0xffff
        seh               $1,$1
        xori              $4,$4,0x2
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seh               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u16::release_seqcst:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xffff
        sync
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xffff
        andi              $2,$2,0xffff
        seh               $1,$1
        xori              $4,$4,0x2
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seh               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xffff
        sync
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xffff
        andi              $2,$2,0xffff
        seh               $1,$1
        xori              $4,$4,0x2
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seh               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xffff
        sync
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xffff
        andi              $2,$2,0xffff
        seh               $1,$1
        xori              $4,$4,0x2
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seh               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u16::acquire_acquire:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xffff
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xffff
        andi              $2,$2,0xffff
        seh               $1,$1
        xori              $4,$4,0x2
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seh               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xffff
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xffff
        andi              $2,$2,0xffff
        seh               $1,$1
        xori              $4,$4,0x2
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seh               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xffff
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xffff
        andi              $2,$2,0xffff
        seh               $1,$1
        xori              $4,$4,0x2
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seh               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xffff
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xffff
        andi              $2,$2,0xffff
        seh               $1,$1
        xori              $4,$4,0x2
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seh               $2,$2
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u16::release_acquire:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xffff
        sync
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xffff
        andi              $2,$2,0xffff
        seh               $1,$1
        xori              $4,$4,0x2
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seh               $2,$2
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u16::release_relaxed:
        daddiu            $3,$0,-4
        sll               $2,$6,0x0
        sll               $1,$5,0x0
        li                $5,0xffff
        sync
        and               $3,$4,$3
        andi              $4,$4,0x3
        andi              $7,$1,0xffff
        andi              $2,$2,0xffff
        seh               $1,$1
        xori              $4,$4,0x2
        sll               $4,$4,0x3
        sllv              $5,$5,$4
        sllv              $7,$7,$4
        sllv              $8,$2,$4
        nor               $6,$0,$5
0:
        ll                $9,0($3)
        and               $10,$9,$5
        bne               $10,$7,1f
        nop
        and               $9,$9,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$4
        seh               $2,$2
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        sll               $1,$6,0x0
        sll               $3,$5,0x0
        sync
0:
        ll                $2,0($4)
        bne               $2,$3,1f
        nop
        move              $5,$1
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        xor               $1,$2,$3
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        sll               $1,$6,0x0
        sll               $3,$5,0x0
        sync
0:
        ll                $2,0($4)
        bne               $2,$3,1f
        nop
        move              $5,$1
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        xor               $1,$2,$3
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        sll               $1,$6,0x0
        sll               $3,$5,0x0
        sync
0:
        ll                $2,0($4)
        bne               $2,$3,1f
        nop
        move              $5,$1
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        xor               $1,$2,$3
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        sll               $1,$6,0x0
        sll               $3,$5,0x0
        sync
0:
        ll                $2,0($4)
        bne               $2,$3,1f
        nop
        move              $5,$1
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        xor               $1,$2,$3
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        sll               $1,$6,0x0
        sll               $3,$5,0x0
        sync
0:
        ll                $2,0($4)
        bne               $2,$3,1f
        nop
        move              $5,$1
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        xor               $1,$2,$3
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        sll               $1,$6,0x0
        sll               $3,$5,0x0
        sync
0:
        ll                $2,0($4)
        bne               $2,$3,1f
        nop
        move              $5,$1
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        xor               $1,$2,$3
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u32::release_seqcst:
        sll               $1,$6,0x0
        sll               $3,$5,0x0
        sync
0:
        ll                $2,0($4)
        bne               $2,$3,1f
        nop
        move              $5,$1
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        xor               $1,$2,$3
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        sll               $1,$6,0x0
        sll               $3,$5,0x0
        sync
0:
        ll                $2,0($4)
        bne               $2,$3,1f
        nop
        move              $5,$1
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        xor               $1,$2,$3
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        sll               $1,$6,0x0
        sll               $3,$5,0x0
        sync
0:
        ll                $2,0($4)
        bne               $2,$3,1f
        nop
        move              $5,$1
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        xor               $1,$2,$3
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u32::acquire_acquire:
        sll               $1,$6,0x0
        sll               $3,$5,0x0
0:
        ll                $2,0($4)
        bne               $2,$3,1f
        nop
        move              $5,$1
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        xor               $1,$2,$3
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        sll               $1,$6,0x0
        sll               $3,$5,0x0
0:
        ll                $2,0($4)
        bne               $2,$3,1f
        nop
        move              $5,$1
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        xor               $1,$2,$3
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        sll               $1,$6,0x0
        sll               $3,$5,0x0
0:
        ll                $2,0($4)
        bne               $2,$3,1f
        nop
        move              $5,$1
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        xor               $1,$2,$3
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        sll               $1,$6,0x0
        sll               $3,$5,0x0
0:
        ll                $2,0($4)
        bne               $2,$3,1f
        nop
        move              $5,$1
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        xor               $1,$2,$3
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u32::release_acquire:
        sll               $1,$6,0x0
        sll               $3,$5,0x0
        sync
0:
        ll                $2,0($4)
        bne               $2,$3,1f
        nop
        move              $5,$1
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        sync
        xor               $1,$2,$3
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u32::release_relaxed:
        sll               $1,$6,0x0
        sll               $3,$5,0x0
        sync
0:
        ll                $2,0($4)
        bne               $2,$3,1f
        nop
        move              $5,$1
        sc                $5,0($4)
        beqz              $5,0b
        nop
1:
        xor               $1,$2,$3
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u64::acqrel_seqcst:
        sync
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u64::seqcst_seqcst:
        sync
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u64::acqrel_acquire:
        sync
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u64::acqrel_relaxed:
        sync
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u64::acquire_seqcst:
        sync
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u64::relaxed_seqcst:
        sync
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u64::release_seqcst:
        sync
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u64::seqcst_acquire:
        sync
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u64::seqcst_relaxed:
        sync
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u64::acquire_acquire:
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u64::acquire_relaxed:
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u64::relaxed_acquire:
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u64::relaxed_relaxed:
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u64::release_acquire:
        sync
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u64::release_relaxed:
        sync
0:
        lld               $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        scd               $1,0($4)
        beqz              $1,0b
        nop
1:
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

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
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        sync
        and               $3,$4,$2
        andi              $2,$4,0x3
        xori              $2,$2,0x3
        sll               $4,$2,0x3
        li                $2,0xff
        sllv              $5,$2,$4
        sllv              $1,$1,$4
        nor               $6,$0,$5
0:
        ll                $7,0($3)
        and               $8,$1,$5
        and               $9,$7,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
        and               $2,$7,$5
        srlv              $2,$2,$4
        seb               $2,$2
        sync
        jr                $31
        nop

asm_test::swap::u8::seqcst:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        sync
        and               $3,$4,$2
        andi              $2,$4,0x3
        xori              $2,$2,0x3
        sll               $4,$2,0x3
        li                $2,0xff
        sllv              $5,$2,$4
        sllv              $1,$1,$4
        nor               $6,$0,$5
0:
        ll                $7,0($3)
        and               $8,$1,$5
        and               $9,$7,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
        and               $2,$7,$5
        srlv              $2,$2,$4
        seb               $2,$2
        sync
        jr                $31
        nop

asm_test::swap::u8::acquire:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        and               $3,$4,$2
        andi              $2,$4,0x3
        xori              $2,$2,0x3
        sll               $4,$2,0x3
        li                $2,0xff
        sllv              $5,$2,$4
        sllv              $1,$1,$4
        nor               $6,$0,$5
0:
        ll                $7,0($3)
        and               $8,$1,$5
        and               $9,$7,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
        and               $2,$7,$5
        srlv              $2,$2,$4
        seb               $2,$2
        sync
        jr                $31
        nop

asm_test::swap::u8::relaxed:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        and               $3,$4,$2
        andi              $2,$4,0x3
        xori              $2,$2,0x3
        sll               $4,$2,0x3
        li                $2,0xff
        sllv              $5,$2,$4
        sllv              $1,$1,$4
        nor               $6,$0,$5
0:
        ll                $7,0($3)
        and               $8,$1,$5
        and               $9,$7,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
        and               $2,$7,$5
        srlv              $2,$2,$4
        seb               $2,$2
        jr                $31
        nop

asm_test::swap::u8::release:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        sync
        and               $3,$4,$2
        andi              $2,$4,0x3
        xori              $2,$2,0x3
        sll               $4,$2,0x3
        li                $2,0xff
        sllv              $5,$2,$4
        sllv              $1,$1,$4
        nor               $6,$0,$5
0:
        ll                $7,0($3)
        and               $8,$1,$5
        and               $9,$7,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
        and               $2,$7,$5
        srlv              $2,$2,$4
        seb               $2,$2
        jr                $31
        nop

asm_test::swap::u16::acqrel:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        sync
        and               $3,$4,$2
        andi              $2,$4,0x3
        xori              $2,$2,0x2
        sll               $4,$2,0x3
        li                $2,0xffff
        sllv              $5,$2,$4
        sllv              $1,$1,$4
        nor               $6,$0,$5
0:
        ll                $7,0($3)
        and               $8,$1,$5
        and               $9,$7,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
        and               $2,$7,$5
        srlv              $2,$2,$4
        seh               $2,$2
        sync
        jr                $31
        nop

asm_test::swap::u16::seqcst:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        sync
        and               $3,$4,$2
        andi              $2,$4,0x3
        xori              $2,$2,0x2
        sll               $4,$2,0x3
        li                $2,0xffff
        sllv              $5,$2,$4
        sllv              $1,$1,$4
        nor               $6,$0,$5
0:
        ll                $7,0($3)
        and               $8,$1,$5
        and               $9,$7,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
        and               $2,$7,$5
        srlv              $2,$2,$4
        seh               $2,$2
        sync
        jr                $31
        nop

asm_test::swap::u16::acquire:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        and               $3,$4,$2
        andi              $2,$4,0x3
        xori              $2,$2,0x2
        sll               $4,$2,0x3
        li                $2,0xffff
        sllv              $5,$2,$4
        sllv              $1,$1,$4
        nor               $6,$0,$5
0:
        ll                $7,0($3)
        and               $8,$1,$5
        and               $9,$7,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
        and               $2,$7,$5
        srlv              $2,$2,$4
        seh               $2,$2
        sync
        jr                $31
        nop

asm_test::swap::u16::relaxed:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        and               $3,$4,$2
        andi              $2,$4,0x3
        xori              $2,$2,0x2
        sll               $4,$2,0x3
        li                $2,0xffff
        sllv              $5,$2,$4
        sllv              $1,$1,$4
        nor               $6,$0,$5
0:
        ll                $7,0($3)
        and               $8,$1,$5
        and               $9,$7,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
        and               $2,$7,$5
        srlv              $2,$2,$4
        seh               $2,$2
        jr                $31
        nop

asm_test::swap::u16::release:
        daddiu            $2,$0,-4
        sll               $1,$5,0x0
        sync
        and               $3,$4,$2
        andi              $2,$4,0x3
        xori              $2,$2,0x2
        sll               $4,$2,0x3
        li                $2,0xffff
        sllv              $5,$2,$4
        sllv              $1,$1,$4
        nor               $6,$0,$5
0:
        ll                $7,0($3)
        and               $8,$1,$5
        and               $9,$7,$6
        or                $9,$9,$8
        sc                $9,0($3)
        beqz              $9,0b
        nop
        and               $2,$7,$5
        srlv              $2,$2,$4
        seh               $2,$2
        jr                $31
        nop

asm_test::swap::u32::acqrel:
        sll               $1,$5,0x0
        sync
0:
        ll                $2,0($4)
        move              $3,$1
        sc                $3,0($4)
        beqz              $3,0b
        nop
        sync
        jr                $31
        nop

asm_test::swap::u32::seqcst:
        sll               $1,$5,0x0
        sync
0:
        ll                $2,0($4)
        move              $3,$1
        sc                $3,0($4)
        beqz              $3,0b
        nop
        sync
        jr                $31
        nop

asm_test::swap::u32::acquire:
        sll               $1,$5,0x0
0:
        ll                $2,0($4)
        move              $3,$1
        sc                $3,0($4)
        beqz              $3,0b
        nop
        sync
        jr                $31
        nop

asm_test::swap::u32::relaxed:
        sll               $1,$5,0x0
0:
        ll                $2,0($4)
        move              $3,$1
        sc                $3,0($4)
        beqz              $3,0b
        nop
        jr                $31
        nop

asm_test::swap::u32::release:
        sll               $1,$5,0x0
        sync
0:
        ll                $2,0($4)
        move              $3,$1
        sc                $3,0($4)
        beqz              $3,0b
        nop
        jr                $31
        nop

asm_test::swap::u64::acqrel:
        sync
0:
        lld               $2,0($4)
        move              $1,$5
        scd               $1,0($4)
        beqz              $1,0b
        nop
        sync
        jr                $31
        nop

asm_test::swap::u64::seqcst:
        sync
0:
        lld               $2,0($4)
        move              $1,$5
        scd               $1,0($4)
        beqz              $1,0b
        nop
        sync
        jr                $31
        nop

asm_test::swap::u64::acquire:
0:
        lld               $2,0($4)
        move              $1,$5
        scd               $1,0($4)
        beqz              $1,0b
        nop
        sync
        jr                $31
        nop

asm_test::swap::u64::relaxed:
0:
        lld               $2,0($4)
        move              $1,$5
        scd               $1,0($4)
        beqz              $1,0b
        nop
        jr                $31
        nop

asm_test::swap::u64::release:
        sync
0:
        lld               $2,0($4)
        move              $1,$5
        scd               $1,0($4)
        beqz              $1,0b
        nop
        jr                $31
        nop

asm_test::store::u8::seqcst:
        sll               $1,$5,0x0
        sync
        sb                $1,0($4)
        sync
        jr                $31
        nop

asm_test::store::u8::relaxed:
        sll               $1,$5,0x0
        jr                $31
        sb                $1,0($4)

asm_test::store::u8::release:
        sll               $1,$5,0x0
        sync
        jr                $31
        sb                $1,0($4)

asm_test::store::u16::seqcst:
        sll               $1,$5,0x0
        sync
        sh                $1,0($4)
        sync
        jr                $31
        nop

asm_test::store::u16::relaxed:
        sll               $1,$5,0x0
        jr                $31
        sh                $1,0($4)

asm_test::store::u16::release:
        sll               $1,$5,0x0
        sync
        jr                $31
        sh                $1,0($4)

asm_test::store::u32::seqcst:
        sll               $1,$5,0x0
        sync
        sw                $1,0($4)
        sync
        jr                $31
        nop

asm_test::store::u32::relaxed:
        sll               $1,$5,0x0
        jr                $31
        sw                $1,0($4)

asm_test::store::u32::release:
        sll               $1,$5,0x0
        sync
        jr                $31
        sw                $1,0($4)

asm_test::store::u64::seqcst:
        sync
        sd                $5,0($4)
        sync
        jr                $31
        nop

asm_test::store::u64::relaxed:
        jr                $31
        sd                $5,0($4)

asm_test::store::u64::release:
        sync
        jr                $31
        sd                $5,0($4)

