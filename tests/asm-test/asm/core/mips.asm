asm_test::compare_exchange::u8::acqrel_seqcst:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x3
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xff
        sllv              $4,$2,$3
        andi              $2,$5,0xff
        sllv              $8,$2,$3
        andi              $2,$6,0xff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seb               $2,$2
        seb               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u8::seqcst_seqcst:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x3
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xff
        sllv              $4,$2,$3
        andi              $2,$5,0xff
        sllv              $8,$2,$3
        andi              $2,$6,0xff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seb               $2,$2
        seb               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u8::acqrel_acquire:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x3
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xff
        sllv              $4,$2,$3
        andi              $2,$5,0xff
        sllv              $8,$2,$3
        andi              $2,$6,0xff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seb               $2,$2
        seb               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u8::acqrel_relaxed:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x3
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xff
        sllv              $4,$2,$3
        andi              $2,$5,0xff
        sllv              $8,$2,$3
        andi              $2,$6,0xff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seb               $2,$2
        seb               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u8::acquire_seqcst:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x3
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xff
        sllv              $4,$2,$3
        andi              $2,$5,0xff
        sllv              $8,$2,$3
        andi              $2,$6,0xff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seb               $2,$2
        seb               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u8::relaxed_seqcst:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x3
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xff
        sllv              $4,$2,$3
        andi              $2,$5,0xff
        sllv              $8,$2,$3
        andi              $2,$6,0xff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seb               $2,$2
        seb               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u8::release_seqcst:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x3
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xff
        sllv              $4,$2,$3
        andi              $2,$5,0xff
        sllv              $8,$2,$3
        andi              $2,$6,0xff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seb               $2,$2
        seb               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u8::seqcst_acquire:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x3
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xff
        sllv              $4,$2,$3
        andi              $2,$5,0xff
        sllv              $8,$2,$3
        andi              $2,$6,0xff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seb               $2,$2
        seb               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u8::seqcst_relaxed:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x3
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xff
        sllv              $4,$2,$3
        andi              $2,$5,0xff
        sllv              $8,$2,$3
        andi              $2,$6,0xff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seb               $2,$2
        seb               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u8::acquire_acquire:
        andi              $2,$4,0x3
        li                $1,-4
        xori              $2,$2,0x3
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xff
        sllv              $4,$2,$3
        andi              $2,$5,0xff
        sllv              $8,$2,$3
        andi              $2,$6,0xff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seb               $2,$2
        seb               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u8::acquire_relaxed:
        andi              $2,$4,0x3
        li                $1,-4
        xori              $2,$2,0x3
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xff
        sllv              $4,$2,$3
        andi              $2,$5,0xff
        sllv              $8,$2,$3
        andi              $2,$6,0xff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seb               $2,$2
        seb               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u8::relaxed_acquire:
        andi              $2,$4,0x3
        li                $1,-4
        xori              $2,$2,0x3
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xff
        sllv              $4,$2,$3
        andi              $2,$5,0xff
        sllv              $8,$2,$3
        andi              $2,$6,0xff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seb               $2,$2
        seb               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u8::relaxed_relaxed:
        andi              $2,$4,0x3
        li                $1,-4
        xori              $2,$2,0x3
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xff
        sllv              $4,$2,$3
        andi              $2,$5,0xff
        sllv              $8,$2,$3
        andi              $2,$6,0xff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seb               $2,$2
        seb               $1,$5
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u8::release_acquire:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x3
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xff
        sllv              $4,$2,$3
        andi              $2,$5,0xff
        sllv              $8,$2,$3
        andi              $2,$6,0xff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seb               $2,$2
        seb               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u8::release_relaxed:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x3
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xff
        sllv              $4,$2,$3
        andi              $2,$5,0xff
        sllv              $8,$2,$3
        andi              $2,$6,0xff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seb               $2,$2
        seb               $1,$5
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u16::acqrel_seqcst:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x2
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xffff
        sllv              $4,$2,$3
        andi              $2,$5,0xffff
        sllv              $8,$2,$3
        andi              $2,$6,0xffff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seh               $2,$2
        seh               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u16::seqcst_seqcst:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x2
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xffff
        sllv              $4,$2,$3
        andi              $2,$5,0xffff
        sllv              $8,$2,$3
        andi              $2,$6,0xffff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seh               $2,$2
        seh               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u16::acqrel_acquire:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x2
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xffff
        sllv              $4,$2,$3
        andi              $2,$5,0xffff
        sllv              $8,$2,$3
        andi              $2,$6,0xffff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seh               $2,$2
        seh               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u16::acqrel_relaxed:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x2
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xffff
        sllv              $4,$2,$3
        andi              $2,$5,0xffff
        sllv              $8,$2,$3
        andi              $2,$6,0xffff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seh               $2,$2
        seh               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u16::acquire_seqcst:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x2
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xffff
        sllv              $4,$2,$3
        andi              $2,$5,0xffff
        sllv              $8,$2,$3
        andi              $2,$6,0xffff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seh               $2,$2
        seh               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u16::relaxed_seqcst:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x2
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xffff
        sllv              $4,$2,$3
        andi              $2,$5,0xffff
        sllv              $8,$2,$3
        andi              $2,$6,0xffff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seh               $2,$2
        seh               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u16::release_seqcst:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x2
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xffff
        sllv              $4,$2,$3
        andi              $2,$5,0xffff
        sllv              $8,$2,$3
        andi              $2,$6,0xffff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seh               $2,$2
        seh               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u16::seqcst_acquire:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x2
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xffff
        sllv              $4,$2,$3
        andi              $2,$5,0xffff
        sllv              $8,$2,$3
        andi              $2,$6,0xffff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seh               $2,$2
        seh               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u16::seqcst_relaxed:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x2
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xffff
        sllv              $4,$2,$3
        andi              $2,$5,0xffff
        sllv              $8,$2,$3
        andi              $2,$6,0xffff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seh               $2,$2
        seh               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u16::acquire_acquire:
        andi              $2,$4,0x3
        li                $1,-4
        xori              $2,$2,0x2
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xffff
        sllv              $4,$2,$3
        andi              $2,$5,0xffff
        sllv              $8,$2,$3
        andi              $2,$6,0xffff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seh               $2,$2
        seh               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u16::acquire_relaxed:
        andi              $2,$4,0x3
        li                $1,-4
        xori              $2,$2,0x2
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xffff
        sllv              $4,$2,$3
        andi              $2,$5,0xffff
        sllv              $8,$2,$3
        andi              $2,$6,0xffff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seh               $2,$2
        seh               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u16::relaxed_acquire:
        andi              $2,$4,0x3
        li                $1,-4
        xori              $2,$2,0x2
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xffff
        sllv              $4,$2,$3
        andi              $2,$5,0xffff
        sllv              $8,$2,$3
        andi              $2,$6,0xffff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seh               $2,$2
        seh               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u16::relaxed_relaxed:
        andi              $2,$4,0x3
        li                $1,-4
        xori              $2,$2,0x2
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xffff
        sllv              $4,$2,$3
        andi              $2,$5,0xffff
        sllv              $8,$2,$3
        andi              $2,$6,0xffff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seh               $2,$2
        seh               $1,$5
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u16::release_acquire:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x2
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xffff
        sllv              $4,$2,$3
        andi              $2,$5,0xffff
        sllv              $8,$2,$3
        andi              $2,$6,0xffff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seh               $2,$2
        seh               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u16::release_relaxed:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x2
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xffff
        sllv              $4,$2,$3
        andi              $2,$5,0xffff
        sllv              $8,$2,$3
        andi              $2,$6,0xffff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seh               $2,$2
        seh               $1,$5
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u32::acqrel_seqcst:
        sync
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u32::seqcst_seqcst:
        sync
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u32::acqrel_acquire:
        sync
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u32::acqrel_relaxed:
        sync
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u32::acquire_seqcst:
        sync
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u32::relaxed_seqcst:
        sync
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u32::release_seqcst:
        sync
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u32::seqcst_acquire:
        sync
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u32::seqcst_relaxed:
        sync
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u32::acquire_acquire:
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u32::acquire_relaxed:
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u32::relaxed_acquire:
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u32::relaxed_relaxed:
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u32::release_acquire:
        sync
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange::u32::release_relaxed:
        sync
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x3
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xff
        sllv              $4,$2,$3
        andi              $2,$5,0xff
        sllv              $8,$2,$3
        andi              $2,$6,0xff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seb               $2,$2
        seb               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x3
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xff
        sllv              $4,$2,$3
        andi              $2,$5,0xff
        sllv              $8,$2,$3
        andi              $2,$6,0xff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seb               $2,$2
        seb               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x3
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xff
        sllv              $4,$2,$3
        andi              $2,$5,0xff
        sllv              $8,$2,$3
        andi              $2,$6,0xff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seb               $2,$2
        seb               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x3
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xff
        sllv              $4,$2,$3
        andi              $2,$5,0xff
        sllv              $8,$2,$3
        andi              $2,$6,0xff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seb               $2,$2
        seb               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x3
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xff
        sllv              $4,$2,$3
        andi              $2,$5,0xff
        sllv              $8,$2,$3
        andi              $2,$6,0xff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seb               $2,$2
        seb               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x3
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xff
        sllv              $4,$2,$3
        andi              $2,$5,0xff
        sllv              $8,$2,$3
        andi              $2,$6,0xff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seb               $2,$2
        seb               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u8::release_seqcst:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x3
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xff
        sllv              $4,$2,$3
        andi              $2,$5,0xff
        sllv              $8,$2,$3
        andi              $2,$6,0xff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seb               $2,$2
        seb               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x3
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xff
        sllv              $4,$2,$3
        andi              $2,$5,0xff
        sllv              $8,$2,$3
        andi              $2,$6,0xff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seb               $2,$2
        seb               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x3
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xff
        sllv              $4,$2,$3
        andi              $2,$5,0xff
        sllv              $8,$2,$3
        andi              $2,$6,0xff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seb               $2,$2
        seb               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u8::acquire_acquire:
        andi              $2,$4,0x3
        li                $1,-4
        xori              $2,$2,0x3
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xff
        sllv              $4,$2,$3
        andi              $2,$5,0xff
        sllv              $8,$2,$3
        andi              $2,$6,0xff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seb               $2,$2
        seb               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        andi              $2,$4,0x3
        li                $1,-4
        xori              $2,$2,0x3
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xff
        sllv              $4,$2,$3
        andi              $2,$5,0xff
        sllv              $8,$2,$3
        andi              $2,$6,0xff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seb               $2,$2
        seb               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        andi              $2,$4,0x3
        li                $1,-4
        xori              $2,$2,0x3
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xff
        sllv              $4,$2,$3
        andi              $2,$5,0xff
        sllv              $8,$2,$3
        andi              $2,$6,0xff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seb               $2,$2
        seb               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        andi              $2,$4,0x3
        li                $1,-4
        xori              $2,$2,0x3
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xff
        sllv              $4,$2,$3
        andi              $2,$5,0xff
        sllv              $8,$2,$3
        andi              $2,$6,0xff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seb               $2,$2
        seb               $1,$5
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u8::release_acquire:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x3
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xff
        sllv              $4,$2,$3
        andi              $2,$5,0xff
        sllv              $8,$2,$3
        andi              $2,$6,0xff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seb               $2,$2
        seb               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u8::release_relaxed:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x3
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xff
        sllv              $4,$2,$3
        andi              $2,$5,0xff
        sllv              $8,$2,$3
        andi              $2,$6,0xff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seb               $2,$2
        seb               $1,$5
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x2
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xffff
        sllv              $4,$2,$3
        andi              $2,$5,0xffff
        sllv              $8,$2,$3
        andi              $2,$6,0xffff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seh               $2,$2
        seh               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x2
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xffff
        sllv              $4,$2,$3
        andi              $2,$5,0xffff
        sllv              $8,$2,$3
        andi              $2,$6,0xffff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seh               $2,$2
        seh               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x2
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xffff
        sllv              $4,$2,$3
        andi              $2,$5,0xffff
        sllv              $8,$2,$3
        andi              $2,$6,0xffff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seh               $2,$2
        seh               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x2
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xffff
        sllv              $4,$2,$3
        andi              $2,$5,0xffff
        sllv              $8,$2,$3
        andi              $2,$6,0xffff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seh               $2,$2
        seh               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x2
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xffff
        sllv              $4,$2,$3
        andi              $2,$5,0xffff
        sllv              $8,$2,$3
        andi              $2,$6,0xffff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seh               $2,$2
        seh               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x2
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xffff
        sllv              $4,$2,$3
        andi              $2,$5,0xffff
        sllv              $8,$2,$3
        andi              $2,$6,0xffff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seh               $2,$2
        seh               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u16::release_seqcst:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x2
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xffff
        sllv              $4,$2,$3
        andi              $2,$5,0xffff
        sllv              $8,$2,$3
        andi              $2,$6,0xffff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seh               $2,$2
        seh               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x2
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xffff
        sllv              $4,$2,$3
        andi              $2,$5,0xffff
        sllv              $8,$2,$3
        andi              $2,$6,0xffff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seh               $2,$2
        seh               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x2
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xffff
        sllv              $4,$2,$3
        andi              $2,$5,0xffff
        sllv              $8,$2,$3
        andi              $2,$6,0xffff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seh               $2,$2
        seh               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u16::acquire_acquire:
        andi              $2,$4,0x3
        li                $1,-4
        xori              $2,$2,0x2
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xffff
        sllv              $4,$2,$3
        andi              $2,$5,0xffff
        sllv              $8,$2,$3
        andi              $2,$6,0xffff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seh               $2,$2
        seh               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        andi              $2,$4,0x3
        li                $1,-4
        xori              $2,$2,0x2
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xffff
        sllv              $4,$2,$3
        andi              $2,$5,0xffff
        sllv              $8,$2,$3
        andi              $2,$6,0xffff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seh               $2,$2
        seh               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        andi              $2,$4,0x3
        li                $1,-4
        xori              $2,$2,0x2
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xffff
        sllv              $4,$2,$3
        andi              $2,$5,0xffff
        sllv              $8,$2,$3
        andi              $2,$6,0xffff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seh               $2,$2
        seh               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        andi              $2,$4,0x3
        li                $1,-4
        xori              $2,$2,0x2
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xffff
        sllv              $4,$2,$3
        andi              $2,$5,0xffff
        sllv              $8,$2,$3
        andi              $2,$6,0xffff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seh               $2,$2
        seh               $1,$5
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u16::release_acquire:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x2
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xffff
        sllv              $4,$2,$3
        andi              $2,$5,0xffff
        sllv              $8,$2,$3
        andi              $2,$6,0xffff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seh               $2,$2
        seh               $1,$5
        sync
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u16::release_relaxed:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x2
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xffff
        sllv              $4,$2,$3
        andi              $2,$5,0xffff
        sllv              $8,$2,$3
        andi              $2,$6,0xffff
        nor               $7,$0,$4
        sllv              $6,$2,$3
0:
        ll                $9,0($1)
        and               $10,$9,$4
        bne               $10,$8,1f
        nop
        and               $9,$9,$7
        or                $9,$9,$6
        sc                $9,0($1)
        beqz              $9,0b
        nop
1:
        srlv              $2,$10,$3
        seh               $2,$2
        seh               $1,$5
        xor               $1,$2,$1
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        sync
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        sync
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        sync
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        sync
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        sync
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        sync
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u32::release_seqcst:
        sync
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        sync
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        sync
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u32::acquire_acquire:
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u32::acquire_relaxed:
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u32::relaxed_acquire:
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u32::release_acquire:
        sync
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        sc                $1,0($4)
        beqz              $1,0b
        nop
1:
        sync
        xor               $1,$2,$5
        jr                $31
        sltiu             $3,$1,1

asm_test::compare_exchange_weak::u32::release_relaxed:
        sync
0:
        ll                $2,0($4)
        bne               $2,$5,1f
        nop
        move              $1,$6
        sc                $1,0($4)
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

asm_test::swap::u8::acqrel:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x3
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xff
        sllv              $4,$2,$3
        sllv              $5,$5,$3
        nor               $6,$0,$4
0:
        ll                $7,0($1)
        and               $8,$5,$4
        and               $9,$7,$6
        or                $9,$9,$8
        sc                $9,0($1)
        beqz              $9,0b
        nop
        and               $2,$7,$4
        srlv              $2,$2,$3
        seb               $2,$2
        sync
        jr                $31
        nop

asm_test::swap::u8::seqcst:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x3
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xff
        sllv              $4,$2,$3
        sllv              $5,$5,$3
        nor               $6,$0,$4
0:
        ll                $7,0($1)
        and               $8,$5,$4
        and               $9,$7,$6
        or                $9,$9,$8
        sc                $9,0($1)
        beqz              $9,0b
        nop
        and               $2,$7,$4
        srlv              $2,$2,$3
        seb               $2,$2
        sync
        jr                $31
        nop

asm_test::swap::u8::acquire:
        andi              $2,$4,0x3
        li                $1,-4
        xori              $2,$2,0x3
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xff
        sllv              $4,$2,$3
        sllv              $5,$5,$3
        nor               $6,$0,$4
0:
        ll                $7,0($1)
        and               $8,$5,$4
        and               $9,$7,$6
        or                $9,$9,$8
        sc                $9,0($1)
        beqz              $9,0b
        nop
        and               $2,$7,$4
        srlv              $2,$2,$3
        seb               $2,$2
        sync
        jr                $31
        nop

asm_test::swap::u8::relaxed:
        andi              $2,$4,0x3
        li                $1,-4
        xori              $2,$2,0x3
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xff
        sllv              $4,$2,$3
        sllv              $5,$5,$3
        nor               $6,$0,$4
0:
        ll                $7,0($1)
        and               $8,$5,$4
        and               $9,$7,$6
        or                $9,$9,$8
        sc                $9,0($1)
        beqz              $9,0b
        nop
        and               $2,$7,$4
        srlv              $2,$2,$3
        seb               $2,$2
        jr                $31
        nop

asm_test::swap::u8::release:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x3
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xff
        sllv              $4,$2,$3
        sllv              $5,$5,$3
        nor               $6,$0,$4
0:
        ll                $7,0($1)
        and               $8,$5,$4
        and               $9,$7,$6
        or                $9,$9,$8
        sc                $9,0($1)
        beqz              $9,0b
        nop
        and               $2,$7,$4
        srlv              $2,$2,$3
        seb               $2,$2
        jr                $31
        nop

asm_test::swap::u16::acqrel:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x2
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xffff
        sllv              $4,$2,$3
        sllv              $5,$5,$3
        nor               $6,$0,$4
0:
        ll                $7,0($1)
        and               $8,$5,$4
        and               $9,$7,$6
        or                $9,$9,$8
        sc                $9,0($1)
        beqz              $9,0b
        nop
        and               $2,$7,$4
        srlv              $2,$2,$3
        seh               $2,$2
        sync
        jr                $31
        nop

asm_test::swap::u16::seqcst:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x2
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xffff
        sllv              $4,$2,$3
        sllv              $5,$5,$3
        nor               $6,$0,$4
0:
        ll                $7,0($1)
        and               $8,$5,$4
        and               $9,$7,$6
        or                $9,$9,$8
        sc                $9,0($1)
        beqz              $9,0b
        nop
        and               $2,$7,$4
        srlv              $2,$2,$3
        seh               $2,$2
        sync
        jr                $31
        nop

asm_test::swap::u16::acquire:
        andi              $2,$4,0x3
        li                $1,-4
        xori              $2,$2,0x2
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xffff
        sllv              $4,$2,$3
        sllv              $5,$5,$3
        nor               $6,$0,$4
0:
        ll                $7,0($1)
        and               $8,$5,$4
        and               $9,$7,$6
        or                $9,$9,$8
        sc                $9,0($1)
        beqz              $9,0b
        nop
        and               $2,$7,$4
        srlv              $2,$2,$3
        seh               $2,$2
        sync
        jr                $31
        nop

asm_test::swap::u16::relaxed:
        andi              $2,$4,0x3
        li                $1,-4
        xori              $2,$2,0x2
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xffff
        sllv              $4,$2,$3
        sllv              $5,$5,$3
        nor               $6,$0,$4
0:
        ll                $7,0($1)
        and               $8,$5,$4
        and               $9,$7,$6
        or                $9,$9,$8
        sc                $9,0($1)
        beqz              $9,0b
        nop
        and               $2,$7,$4
        srlv              $2,$2,$3
        seh               $2,$2
        jr                $31
        nop

asm_test::swap::u16::release:
        andi              $2,$4,0x3
        li                $1,-4
        sync
        xori              $2,$2,0x2
        and               $1,$4,$1
        sll               $3,$2,0x3
        li                $2,0xffff
        sllv              $4,$2,$3
        sllv              $5,$5,$3
        nor               $6,$0,$4
0:
        ll                $7,0($1)
        and               $8,$5,$4
        and               $9,$7,$6
        or                $9,$9,$8
        sc                $9,0($1)
        beqz              $9,0b
        nop
        and               $2,$7,$4
        srlv              $2,$2,$3
        seh               $2,$2
        jr                $31
        nop

asm_test::swap::u32::acqrel:
        sync
0:
        ll                $2,0($4)
        move              $1,$5
        sc                $1,0($4)
        beqz              $1,0b
        nop
        sync
        jr                $31
        nop

asm_test::swap::u32::seqcst:
        sync
0:
        ll                $2,0($4)
        move              $1,$5
        sc                $1,0($4)
        beqz              $1,0b
        nop
        sync
        jr                $31
        nop

asm_test::swap::u32::acquire:
0:
        ll                $2,0($4)
        move              $1,$5
        sc                $1,0($4)
        beqz              $1,0b
        nop
        sync
        jr                $31
        nop

asm_test::swap::u32::relaxed:
0:
        ll                $2,0($4)
        move              $1,$5
        sc                $1,0($4)
        beqz              $1,0b
        nop
        jr                $31
        nop

asm_test::swap::u32::release:
        sync
0:
        ll                $2,0($4)
        move              $1,$5
        sc                $1,0($4)
        beqz              $1,0b
        nop
        jr                $31
        nop

asm_test::store::u8::seqcst:
        sync
        sb                $5,0($4)
        sync
        jr                $31
        nop

asm_test::store::u8::relaxed:
        jr                $31
        sb                $5,0($4)

asm_test::store::u8::release:
        sync
        jr                $31
        sb                $5,0($4)

asm_test::store::u16::seqcst:
        sync
        sh                $5,0($4)
        sync
        jr                $31
        nop

asm_test::store::u16::relaxed:
        jr                $31
        sh                $5,0($4)

asm_test::store::u16::release:
        sync
        jr                $31
        sh                $5,0($4)

asm_test::store::u32::seqcst:
        sync
        sw                $5,0($4)
        sync
        jr                $31
        nop

asm_test::store::u32::relaxed:
        jr                $31
        sw                $5,0($4)

asm_test::store::u32::release:
        sync
        jr                $31
        sw                $5,0($4)

