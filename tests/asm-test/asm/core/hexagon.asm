asm_test::compare_exchange::u8::acqrel_seqcst:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r1 = and(r1,#0xff) }
        { r5 = asl(r4,r0)
          p0 = and(p0,!p0)
          r4 = and(r2,#0xff) }
        { p1 = or(p1,!p1)
          r5 = sub(#-0x1,r5) }
0:
        { r6 = #0xff
          r2 = memw_locked(r3) }
        { r6 &= lsr(r2,r0)
          if (!cmp.eq(r6.new,r1)) jump:t 1f }
        { r6 = and(r2,r5) }
        { r6 |= asl(r4,r0) }
        { memw_locked(r3,p2) = r6 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r0 = lsr(r2,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }

asm_test::compare_exchange::u8::seqcst_seqcst:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r1 = and(r1,#0xff) }
        { r5 = asl(r4,r0)
          p0 = and(p0,!p0)
          r4 = and(r2,#0xff) }
        { p1 = or(p1,!p1)
          r5 = sub(#-0x1,r5) }
0:
        { r6 = #0xff
          r2 = memw_locked(r3) }
        { r6 &= lsr(r2,r0)
          if (!cmp.eq(r6.new,r1)) jump:t 1f }
        { r6 = and(r2,r5) }
        { r6 |= asl(r4,r0) }
        { memw_locked(r3,p2) = r6 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r0 = lsr(r2,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }

asm_test::compare_exchange::u8::acqrel_acquire:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r1 = and(r1,#0xff) }
        { r5 = asl(r4,r0)
          p0 = and(p0,!p0)
          r4 = and(r2,#0xff) }
        { p1 = or(p1,!p1)
          r5 = sub(#-0x1,r5) }
0:
        { r6 = #0xff
          r2 = memw_locked(r3) }
        { r6 &= lsr(r2,r0)
          if (!cmp.eq(r6.new,r1)) jump:t 1f }
        { r6 = and(r2,r5) }
        { r6 |= asl(r4,r0) }
        { memw_locked(r3,p2) = r6 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r0 = lsr(r2,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }

asm_test::compare_exchange::u8::acqrel_relaxed:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r1 = and(r1,#0xff) }
        { r5 = asl(r4,r0)
          p0 = and(p0,!p0)
          r4 = and(r2,#0xff) }
        { p1 = or(p1,!p1)
          r5 = sub(#-0x1,r5) }
0:
        { r6 = #0xff
          r2 = memw_locked(r3) }
        { r6 &= lsr(r2,r0)
          if (!cmp.eq(r6.new,r1)) jump:t 1f }
        { r6 = and(r2,r5) }
        { r6 |= asl(r4,r0) }
        { memw_locked(r3,p2) = r6 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r0 = lsr(r2,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }

asm_test::compare_exchange::u8::acquire_seqcst:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r1 = and(r1,#0xff) }
        { r5 = asl(r4,r0)
          p0 = and(p0,!p0)
          r4 = and(r2,#0xff) }
        { p1 = or(p1,!p1)
          r5 = sub(#-0x1,r5) }
0:
        { r6 = #0xff
          r2 = memw_locked(r3) }
        { r6 &= lsr(r2,r0)
          if (!cmp.eq(r6.new,r1)) jump:t 1f }
        { r6 = and(r2,r5) }
        { r6 |= asl(r4,r0) }
        { memw_locked(r3,p2) = r6 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r0 = lsr(r2,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }

asm_test::compare_exchange::u8::relaxed_seqcst:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r1 = and(r1,#0xff) }
        { r5 = asl(r4,r0)
          p0 = and(p0,!p0)
          r4 = and(r2,#0xff) }
        { p1 = or(p1,!p1)
          r5 = sub(#-0x1,r5) }
0:
        { r6 = #0xff
          r2 = memw_locked(r3) }
        { r6 &= lsr(r2,r0)
          if (!cmp.eq(r6.new,r1)) jump:t 1f }
        { r6 = and(r2,r5) }
        { r6 |= asl(r4,r0) }
        { memw_locked(r3,p2) = r6 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r0 = lsr(r2,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }

asm_test::compare_exchange::u8::release_seqcst:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r1 = and(r1,#0xff) }
        { r5 = asl(r4,r0)
          p0 = and(p0,!p0)
          r4 = and(r2,#0xff) }
        { p1 = or(p1,!p1)
          r5 = sub(#-0x1,r5) }
0:
        { r6 = #0xff
          r2 = memw_locked(r3) }
        { r6 &= lsr(r2,r0)
          if (!cmp.eq(r6.new,r1)) jump:t 1f }
        { r6 = and(r2,r5) }
        { r6 |= asl(r4,r0) }
        { memw_locked(r3,p2) = r6 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r0 = lsr(r2,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }

asm_test::compare_exchange::u8::seqcst_acquire:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r1 = and(r1,#0xff) }
        { r5 = asl(r4,r0)
          p0 = and(p0,!p0)
          r4 = and(r2,#0xff) }
        { p1 = or(p1,!p1)
          r5 = sub(#-0x1,r5) }
0:
        { r6 = #0xff
          r2 = memw_locked(r3) }
        { r6 &= lsr(r2,r0)
          if (!cmp.eq(r6.new,r1)) jump:t 1f }
        { r6 = and(r2,r5) }
        { r6 |= asl(r4,r0) }
        { memw_locked(r3,p2) = r6 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r0 = lsr(r2,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }

asm_test::compare_exchange::u8::seqcst_relaxed:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r1 = and(r1,#0xff) }
        { r5 = asl(r4,r0)
          p0 = and(p0,!p0)
          r4 = and(r2,#0xff) }
        { p1 = or(p1,!p1)
          r5 = sub(#-0x1,r5) }
0:
        { r6 = #0xff
          r2 = memw_locked(r3) }
        { r6 &= lsr(r2,r0)
          if (!cmp.eq(r6.new,r1)) jump:t 1f }
        { r6 = and(r2,r5) }
        { r6 |= asl(r4,r0) }
        { memw_locked(r3,p2) = r6 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r0 = lsr(r2,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }

asm_test::compare_exchange::u8::acquire_acquire:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r1 = and(r1,#0xff) }
        { r5 = asl(r4,r0)
          p0 = and(p0,!p0)
          r4 = and(r2,#0xff) }
        { p1 = or(p1,!p1)
          r5 = sub(#-0x1,r5) }
0:
        { r6 = #0xff
          r2 = memw_locked(r3) }
        { r6 &= lsr(r2,r0)
          if (!cmp.eq(r6.new,r1)) jump:t 1f }
        { r6 = and(r2,r5) }
        { r6 |= asl(r4,r0) }
        { memw_locked(r3,p2) = r6 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r0 = lsr(r2,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }

asm_test::compare_exchange::u8::acquire_relaxed:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r1 = and(r1,#0xff) }
        { r5 = asl(r4,r0)
          p0 = and(p0,!p0)
          r4 = and(r2,#0xff) }
        { p1 = or(p1,!p1)
          r5 = sub(#-0x1,r5) }
0:
        { r6 = #0xff
          r2 = memw_locked(r3) }
        { r6 &= lsr(r2,r0)
          if (!cmp.eq(r6.new,r1)) jump:t 1f }
        { r6 = and(r2,r5) }
        { r6 |= asl(r4,r0) }
        { memw_locked(r3,p2) = r6 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r0 = lsr(r2,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }

asm_test::compare_exchange::u8::relaxed_acquire:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r1 = and(r1,#0xff) }
        { r5 = asl(r4,r0)
          p0 = and(p0,!p0)
          r4 = and(r2,#0xff) }
        { p1 = or(p1,!p1)
          r5 = sub(#-0x1,r5) }
0:
        { r6 = #0xff
          r2 = memw_locked(r3) }
        { r6 &= lsr(r2,r0)
          if (!cmp.eq(r6.new,r1)) jump:t 1f }
        { r6 = and(r2,r5) }
        { r6 |= asl(r4,r0) }
        { memw_locked(r3,p2) = r6 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r0 = lsr(r2,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }

asm_test::compare_exchange::u8::relaxed_relaxed:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r1 = and(r1,#0xff) }
        { r5 = asl(r4,r0)
          p0 = and(p0,!p0)
          r4 = and(r2,#0xff) }
        { p1 = or(p1,!p1)
          r5 = sub(#-0x1,r5) }
0:
        { r6 = #0xff
          r2 = memw_locked(r3) }
        { r6 &= lsr(r2,r0)
          if (!cmp.eq(r6.new,r1)) jump:t 1f }
        { r6 = and(r2,r5) }
        { r6 |= asl(r4,r0) }
        { memw_locked(r3,p2) = r6 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r0 = lsr(r2,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }

asm_test::compare_exchange::u8::release_acquire:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r1 = and(r1,#0xff) }
        { r5 = asl(r4,r0)
          p0 = and(p0,!p0)
          r4 = and(r2,#0xff) }
        { p1 = or(p1,!p1)
          r5 = sub(#-0x1,r5) }
0:
        { r6 = #0xff
          r2 = memw_locked(r3) }
        { r6 &= lsr(r2,r0)
          if (!cmp.eq(r6.new,r1)) jump:t 1f }
        { r6 = and(r2,r5) }
        { r6 |= asl(r4,r0) }
        { memw_locked(r3,p2) = r6 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r0 = lsr(r2,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }

asm_test::compare_exchange::u8::release_relaxed:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r1 = and(r1,#0xff) }
        { r5 = asl(r4,r0)
          p0 = and(p0,!p0)
          r4 = and(r2,#0xff) }
        { p1 = or(p1,!p1)
          r5 = sub(#-0x1,r5) }
0:
        { r6 = #0xff
          r2 = memw_locked(r3) }
        { r6 &= lsr(r2,r0)
          if (!cmp.eq(r6.new,r1)) jump:t 1f }
        { r6 = and(r2,r5) }
        { r6 |= asl(r4,r0) }
        { memw_locked(r3,p2) = r6 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r0 = lsr(r2,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }

asm_test::compare_exchange::u16::acqrel_seqcst:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r5 = asl(r4,r0)
          p0 = and(p0,!p0)
          r1 = zxth(r1); 	r4 = zxth(r2) }
        { p1 = or(p1,!p1)
          r5 = sub(#-0x1,r5) }
0:
        { immext(#0xffc0)
          r6 = ##0xffff
          r2 = memw_locked(r3) }
        { r6 &= lsr(r2,r0)
          if (!cmp.eq(r6.new,r1)) jump:t 1f }
        { r6 = and(r2,r5) }
        { r6 |= asl(r4,r0) }
        { memw_locked(r3,p2) = r6 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r0 = lsr(r2,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }

asm_test::compare_exchange::u16::seqcst_seqcst:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r5 = asl(r4,r0)
          p0 = and(p0,!p0)
          r1 = zxth(r1); 	r4 = zxth(r2) }
        { p1 = or(p1,!p1)
          r5 = sub(#-0x1,r5) }
0:
        { immext(#0xffc0)
          r6 = ##0xffff
          r2 = memw_locked(r3) }
        { r6 &= lsr(r2,r0)
          if (!cmp.eq(r6.new,r1)) jump:t 1f }
        { r6 = and(r2,r5) }
        { r6 |= asl(r4,r0) }
        { memw_locked(r3,p2) = r6 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r0 = lsr(r2,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }

asm_test::compare_exchange::u16::acqrel_acquire:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r5 = asl(r4,r0)
          p0 = and(p0,!p0)
          r1 = zxth(r1); 	r4 = zxth(r2) }
        { p1 = or(p1,!p1)
          r5 = sub(#-0x1,r5) }
0:
        { immext(#0xffc0)
          r6 = ##0xffff
          r2 = memw_locked(r3) }
        { r6 &= lsr(r2,r0)
          if (!cmp.eq(r6.new,r1)) jump:t 1f }
        { r6 = and(r2,r5) }
        { r6 |= asl(r4,r0) }
        { memw_locked(r3,p2) = r6 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r0 = lsr(r2,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }

asm_test::compare_exchange::u16::acqrel_relaxed:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r5 = asl(r4,r0)
          p0 = and(p0,!p0)
          r1 = zxth(r1); 	r4 = zxth(r2) }
        { p1 = or(p1,!p1)
          r5 = sub(#-0x1,r5) }
0:
        { immext(#0xffc0)
          r6 = ##0xffff
          r2 = memw_locked(r3) }
        { r6 &= lsr(r2,r0)
          if (!cmp.eq(r6.new,r1)) jump:t 1f }
        { r6 = and(r2,r5) }
        { r6 |= asl(r4,r0) }
        { memw_locked(r3,p2) = r6 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r0 = lsr(r2,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }

asm_test::compare_exchange::u16::acquire_seqcst:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r5 = asl(r4,r0)
          p0 = and(p0,!p0)
          r1 = zxth(r1); 	r4 = zxth(r2) }
        { p1 = or(p1,!p1)
          r5 = sub(#-0x1,r5) }
0:
        { immext(#0xffc0)
          r6 = ##0xffff
          r2 = memw_locked(r3) }
        { r6 &= lsr(r2,r0)
          if (!cmp.eq(r6.new,r1)) jump:t 1f }
        { r6 = and(r2,r5) }
        { r6 |= asl(r4,r0) }
        { memw_locked(r3,p2) = r6 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r0 = lsr(r2,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }

asm_test::compare_exchange::u16::relaxed_seqcst:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r5 = asl(r4,r0)
          p0 = and(p0,!p0)
          r1 = zxth(r1); 	r4 = zxth(r2) }
        { p1 = or(p1,!p1)
          r5 = sub(#-0x1,r5) }
0:
        { immext(#0xffc0)
          r6 = ##0xffff
          r2 = memw_locked(r3) }
        { r6 &= lsr(r2,r0)
          if (!cmp.eq(r6.new,r1)) jump:t 1f }
        { r6 = and(r2,r5) }
        { r6 |= asl(r4,r0) }
        { memw_locked(r3,p2) = r6 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r0 = lsr(r2,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }

asm_test::compare_exchange::u16::release_seqcst:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r5 = asl(r4,r0)
          p0 = and(p0,!p0)
          r1 = zxth(r1); 	r4 = zxth(r2) }
        { p1 = or(p1,!p1)
          r5 = sub(#-0x1,r5) }
0:
        { immext(#0xffc0)
          r6 = ##0xffff
          r2 = memw_locked(r3) }
        { r6 &= lsr(r2,r0)
          if (!cmp.eq(r6.new,r1)) jump:t 1f }
        { r6 = and(r2,r5) }
        { r6 |= asl(r4,r0) }
        { memw_locked(r3,p2) = r6 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r0 = lsr(r2,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }

asm_test::compare_exchange::u16::seqcst_acquire:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r5 = asl(r4,r0)
          p0 = and(p0,!p0)
          r1 = zxth(r1); 	r4 = zxth(r2) }
        { p1 = or(p1,!p1)
          r5 = sub(#-0x1,r5) }
0:
        { immext(#0xffc0)
          r6 = ##0xffff
          r2 = memw_locked(r3) }
        { r6 &= lsr(r2,r0)
          if (!cmp.eq(r6.new,r1)) jump:t 1f }
        { r6 = and(r2,r5) }
        { r6 |= asl(r4,r0) }
        { memw_locked(r3,p2) = r6 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r0 = lsr(r2,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }

asm_test::compare_exchange::u16::seqcst_relaxed:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r5 = asl(r4,r0)
          p0 = and(p0,!p0)
          r1 = zxth(r1); 	r4 = zxth(r2) }
        { p1 = or(p1,!p1)
          r5 = sub(#-0x1,r5) }
0:
        { immext(#0xffc0)
          r6 = ##0xffff
          r2 = memw_locked(r3) }
        { r6 &= lsr(r2,r0)
          if (!cmp.eq(r6.new,r1)) jump:t 1f }
        { r6 = and(r2,r5) }
        { r6 |= asl(r4,r0) }
        { memw_locked(r3,p2) = r6 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r0 = lsr(r2,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }

asm_test::compare_exchange::u16::acquire_acquire:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r5 = asl(r4,r0)
          p0 = and(p0,!p0)
          r1 = zxth(r1); 	r4 = zxth(r2) }
        { p1 = or(p1,!p1)
          r5 = sub(#-0x1,r5) }
0:
        { immext(#0xffc0)
          r6 = ##0xffff
          r2 = memw_locked(r3) }
        { r6 &= lsr(r2,r0)
          if (!cmp.eq(r6.new,r1)) jump:t 1f }
        { r6 = and(r2,r5) }
        { r6 |= asl(r4,r0) }
        { memw_locked(r3,p2) = r6 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r0 = lsr(r2,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }

asm_test::compare_exchange::u16::acquire_relaxed:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r5 = asl(r4,r0)
          p0 = and(p0,!p0)
          r1 = zxth(r1); 	r4 = zxth(r2) }
        { p1 = or(p1,!p1)
          r5 = sub(#-0x1,r5) }
0:
        { immext(#0xffc0)
          r6 = ##0xffff
          r2 = memw_locked(r3) }
        { r6 &= lsr(r2,r0)
          if (!cmp.eq(r6.new,r1)) jump:t 1f }
        { r6 = and(r2,r5) }
        { r6 |= asl(r4,r0) }
        { memw_locked(r3,p2) = r6 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r0 = lsr(r2,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }

asm_test::compare_exchange::u16::relaxed_acquire:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r5 = asl(r4,r0)
          p0 = and(p0,!p0)
          r1 = zxth(r1); 	r4 = zxth(r2) }
        { p1 = or(p1,!p1)
          r5 = sub(#-0x1,r5) }
0:
        { immext(#0xffc0)
          r6 = ##0xffff
          r2 = memw_locked(r3) }
        { r6 &= lsr(r2,r0)
          if (!cmp.eq(r6.new,r1)) jump:t 1f }
        { r6 = and(r2,r5) }
        { r6 |= asl(r4,r0) }
        { memw_locked(r3,p2) = r6 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r0 = lsr(r2,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }

asm_test::compare_exchange::u16::relaxed_relaxed:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r5 = asl(r4,r0)
          p0 = and(p0,!p0)
          r1 = zxth(r1); 	r4 = zxth(r2) }
        { p1 = or(p1,!p1)
          r5 = sub(#-0x1,r5) }
0:
        { immext(#0xffc0)
          r6 = ##0xffff
          r2 = memw_locked(r3) }
        { r6 &= lsr(r2,r0)
          if (!cmp.eq(r6.new,r1)) jump:t 1f }
        { r6 = and(r2,r5) }
        { r6 |= asl(r4,r0) }
        { memw_locked(r3,p2) = r6 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r0 = lsr(r2,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }

asm_test::compare_exchange::u16::release_acquire:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r5 = asl(r4,r0)
          p0 = and(p0,!p0)
          r1 = zxth(r1); 	r4 = zxth(r2) }
        { p1 = or(p1,!p1)
          r5 = sub(#-0x1,r5) }
0:
        { immext(#0xffc0)
          r6 = ##0xffff
          r2 = memw_locked(r3) }
        { r6 &= lsr(r2,r0)
          if (!cmp.eq(r6.new,r1)) jump:t 1f }
        { r6 = and(r2,r5) }
        { r6 |= asl(r4,r0) }
        { memw_locked(r3,p2) = r6 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r0 = lsr(r2,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }

asm_test::compare_exchange::u16::release_relaxed:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r5 = asl(r4,r0)
          p0 = and(p0,!p0)
          r1 = zxth(r1); 	r4 = zxth(r2) }
        { p1 = or(p1,!p1)
          r5 = sub(#-0x1,r5) }
0:
        { immext(#0xffc0)
          r6 = ##0xffff
          r2 = memw_locked(r3) }
        { r6 &= lsr(r2,r0)
          if (!cmp.eq(r6.new,r1)) jump:t 1f }
        { r6 = and(r2,r5) }
        { r6 |= asl(r4,r0) }
        { memw_locked(r3,p2) = r6 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r0 = lsr(r2,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }

asm_test::compare_exchange::u32::acqrel_seqcst:
        { p0 = and(p0,!p0)
          p1 = or(p1,!p1)
          r3 = r0 }
0:
        { r0 = memw_locked(r3) }
        { if (!p2.new) jump:t 1f
          p2 = cmp.eq(r0,r1) }
        { memw_locked(r3,p2) = r2 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange::u32::seqcst_seqcst:
        { p0 = and(p0,!p0)
          p1 = or(p1,!p1)
          r3 = r0 }
0:
        { r0 = memw_locked(r3) }
        { if (!p2.new) jump:t 1f
          p2 = cmp.eq(r0,r1) }
        { memw_locked(r3,p2) = r2 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange::u32::acqrel_acquire:
        { p0 = and(p0,!p0)
          p1 = or(p1,!p1)
          r3 = r0 }
0:
        { r0 = memw_locked(r3) }
        { if (!p2.new) jump:t 1f
          p2 = cmp.eq(r0,r1) }
        { memw_locked(r3,p2) = r2 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange::u32::acqrel_relaxed:
        { p0 = and(p0,!p0)
          p1 = or(p1,!p1)
          r3 = r0 }
0:
        { r0 = memw_locked(r3) }
        { if (!p2.new) jump:t 1f
          p2 = cmp.eq(r0,r1) }
        { memw_locked(r3,p2) = r2 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange::u32::acquire_seqcst:
        { p0 = and(p0,!p0)
          p1 = or(p1,!p1)
          r3 = r0 }
0:
        { r0 = memw_locked(r3) }
        { if (!p2.new) jump:t 1f
          p2 = cmp.eq(r0,r1) }
        { memw_locked(r3,p2) = r2 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange::u32::relaxed_seqcst:
        { p0 = and(p0,!p0)
          p1 = or(p1,!p1)
          r3 = r0 }
0:
        { r0 = memw_locked(r3) }
        { if (!p2.new) jump:t 1f
          p2 = cmp.eq(r0,r1) }
        { memw_locked(r3,p2) = r2 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange::u32::release_seqcst:
        { p0 = and(p0,!p0)
          p1 = or(p1,!p1)
          r3 = r0 }
0:
        { r0 = memw_locked(r3) }
        { if (!p2.new) jump:t 1f
          p2 = cmp.eq(r0,r1) }
        { memw_locked(r3,p2) = r2 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange::u32::seqcst_acquire:
        { p0 = and(p0,!p0)
          p1 = or(p1,!p1)
          r3 = r0 }
0:
        { r0 = memw_locked(r3) }
        { if (!p2.new) jump:t 1f
          p2 = cmp.eq(r0,r1) }
        { memw_locked(r3,p2) = r2 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange::u32::seqcst_relaxed:
        { p0 = and(p0,!p0)
          p1 = or(p1,!p1)
          r3 = r0 }
0:
        { r0 = memw_locked(r3) }
        { if (!p2.new) jump:t 1f
          p2 = cmp.eq(r0,r1) }
        { memw_locked(r3,p2) = r2 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange::u32::acquire_acquire:
        { p0 = and(p0,!p0)
          p1 = or(p1,!p1)
          r3 = r0 }
0:
        { r0 = memw_locked(r3) }
        { if (!p2.new) jump:t 1f
          p2 = cmp.eq(r0,r1) }
        { memw_locked(r3,p2) = r2 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange::u32::acquire_relaxed:
        { p0 = and(p0,!p0)
          p1 = or(p1,!p1)
          r3 = r0 }
0:
        { r0 = memw_locked(r3) }
        { if (!p2.new) jump:t 1f
          p2 = cmp.eq(r0,r1) }
        { memw_locked(r3,p2) = r2 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange::u32::relaxed_acquire:
        { p0 = and(p0,!p0)
          p1 = or(p1,!p1)
          r3 = r0 }
0:
        { r0 = memw_locked(r3) }
        { if (!p2.new) jump:t 1f
          p2 = cmp.eq(r0,r1) }
        { memw_locked(r3,p2) = r2 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange::u32::relaxed_relaxed:
        { p0 = and(p0,!p0)
          p1 = or(p1,!p1)
          r3 = r0 }
0:
        { r0 = memw_locked(r3) }
        { if (!p2.new) jump:t 1f
          p2 = cmp.eq(r0,r1) }
        { memw_locked(r3,p2) = r2 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange::u32::release_acquire:
        { p0 = and(p0,!p0)
          p1 = or(p1,!p1)
          r3 = r0 }
0:
        { r0 = memw_locked(r3) }
        { if (!p2.new) jump:t 1f
          p2 = cmp.eq(r0,r1) }
        { memw_locked(r3,p2) = r2 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange::u32::release_relaxed:
        { p0 = and(p0,!p0)
          p1 = or(p1,!p1)
          r3 = r0 }
0:
        { r0 = memw_locked(r3) }
        { if (!p2.new) jump:t 1f
          p2 = cmp.eq(r0,r1) }
        { memw_locked(r3,p2) = r2 }
        { if (!p2) jump:nt 0b }
        { p0 = or(p1,p1) }
1:
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        { r0 = and(#0x18,asl(r0,#0x3))
          r4 = and(r0,#-0x4)
          r5 = #0xff
          r1 = and(r1,#0xff) }
        { r3 = memw_locked(r4) }
        { r5 &= lsr(r3,r0) }
        { p0 = cmp.eq(r5,r1); if (!p0.new) jump:t 0f
          r1 = #0xff }
        { r1 = asl(r1,r0)
          r2 = and(r2,#0xff) }
        { r1 = sub(#-0x1,r1) }
        { r1 = and(r3,r1) }
        { r1 |= asl(r2,r0) }
        { memw_locked(r4,p0) = r1 }
        { r0 = lsr(r3,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }
0:
        { p0 = and(p0,!p0)
          r0 = lsr(r3,r0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        { r0 = and(#0x18,asl(r0,#0x3))
          r4 = and(r0,#-0x4)
          r5 = #0xff
          r1 = and(r1,#0xff) }
        { r3 = memw_locked(r4) }
        { r5 &= lsr(r3,r0) }
        { p0 = cmp.eq(r5,r1); if (!p0.new) jump:t 0f
          r1 = #0xff }
        { r1 = asl(r1,r0)
          r2 = and(r2,#0xff) }
        { r1 = sub(#-0x1,r1) }
        { r1 = and(r3,r1) }
        { r1 |= asl(r2,r0) }
        { memw_locked(r4,p0) = r1 }
        { r0 = lsr(r3,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }
0:
        { p0 = and(p0,!p0)
          r0 = lsr(r3,r0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        { r0 = and(#0x18,asl(r0,#0x3))
          r4 = and(r0,#-0x4)
          r5 = #0xff
          r1 = and(r1,#0xff) }
        { r3 = memw_locked(r4) }
        { r5 &= lsr(r3,r0) }
        { p0 = cmp.eq(r5,r1); if (!p0.new) jump:t 0f
          r1 = #0xff }
        { r1 = asl(r1,r0)
          r2 = and(r2,#0xff) }
        { r1 = sub(#-0x1,r1) }
        { r1 = and(r3,r1) }
        { r1 |= asl(r2,r0) }
        { memw_locked(r4,p0) = r1 }
        { r0 = lsr(r3,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }
0:
        { p0 = and(p0,!p0)
          r0 = lsr(r3,r0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        { r0 = and(#0x18,asl(r0,#0x3))
          r4 = and(r0,#-0x4)
          r5 = #0xff
          r1 = and(r1,#0xff) }
        { r3 = memw_locked(r4) }
        { r5 &= lsr(r3,r0) }
        { p0 = cmp.eq(r5,r1); if (!p0.new) jump:t 0f
          r1 = #0xff }
        { r1 = asl(r1,r0)
          r2 = and(r2,#0xff) }
        { r1 = sub(#-0x1,r1) }
        { r1 = and(r3,r1) }
        { r1 |= asl(r2,r0) }
        { memw_locked(r4,p0) = r1 }
        { r0 = lsr(r3,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }
0:
        { p0 = and(p0,!p0)
          r0 = lsr(r3,r0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        { r0 = and(#0x18,asl(r0,#0x3))
          r4 = and(r0,#-0x4)
          r5 = #0xff
          r1 = and(r1,#0xff) }
        { r3 = memw_locked(r4) }
        { r5 &= lsr(r3,r0) }
        { p0 = cmp.eq(r5,r1); if (!p0.new) jump:t 0f
          r1 = #0xff }
        { r1 = asl(r1,r0)
          r2 = and(r2,#0xff) }
        { r1 = sub(#-0x1,r1) }
        { r1 = and(r3,r1) }
        { r1 |= asl(r2,r0) }
        { memw_locked(r4,p0) = r1 }
        { r0 = lsr(r3,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }
0:
        { p0 = and(p0,!p0)
          r0 = lsr(r3,r0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        { r0 = and(#0x18,asl(r0,#0x3))
          r4 = and(r0,#-0x4)
          r5 = #0xff
          r1 = and(r1,#0xff) }
        { r3 = memw_locked(r4) }
        { r5 &= lsr(r3,r0) }
        { p0 = cmp.eq(r5,r1); if (!p0.new) jump:t 0f
          r1 = #0xff }
        { r1 = asl(r1,r0)
          r2 = and(r2,#0xff) }
        { r1 = sub(#-0x1,r1) }
        { r1 = and(r3,r1) }
        { r1 |= asl(r2,r0) }
        { memw_locked(r4,p0) = r1 }
        { r0 = lsr(r3,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }
0:
        { p0 = and(p0,!p0)
          r0 = lsr(r3,r0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u8::release_seqcst:
        { r0 = and(#0x18,asl(r0,#0x3))
          r4 = and(r0,#-0x4)
          r5 = #0xff
          r1 = and(r1,#0xff) }
        { r3 = memw_locked(r4) }
        { r5 &= lsr(r3,r0) }
        { p0 = cmp.eq(r5,r1); if (!p0.new) jump:t 0f
          r1 = #0xff }
        { r1 = asl(r1,r0)
          r2 = and(r2,#0xff) }
        { r1 = sub(#-0x1,r1) }
        { r1 = and(r3,r1) }
        { r1 |= asl(r2,r0) }
        { memw_locked(r4,p0) = r1 }
        { r0 = lsr(r3,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }
0:
        { p0 = and(p0,!p0)
          r0 = lsr(r3,r0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        { r0 = and(#0x18,asl(r0,#0x3))
          r4 = and(r0,#-0x4)
          r5 = #0xff
          r1 = and(r1,#0xff) }
        { r3 = memw_locked(r4) }
        { r5 &= lsr(r3,r0) }
        { p0 = cmp.eq(r5,r1); if (!p0.new) jump:t 0f
          r1 = #0xff }
        { r1 = asl(r1,r0)
          r2 = and(r2,#0xff) }
        { r1 = sub(#-0x1,r1) }
        { r1 = and(r3,r1) }
        { r1 |= asl(r2,r0) }
        { memw_locked(r4,p0) = r1 }
        { r0 = lsr(r3,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }
0:
        { p0 = and(p0,!p0)
          r0 = lsr(r3,r0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        { r0 = and(#0x18,asl(r0,#0x3))
          r4 = and(r0,#-0x4)
          r5 = #0xff
          r1 = and(r1,#0xff) }
        { r3 = memw_locked(r4) }
        { r5 &= lsr(r3,r0) }
        { p0 = cmp.eq(r5,r1); if (!p0.new) jump:t 0f
          r1 = #0xff }
        { r1 = asl(r1,r0)
          r2 = and(r2,#0xff) }
        { r1 = sub(#-0x1,r1) }
        { r1 = and(r3,r1) }
        { r1 |= asl(r2,r0) }
        { memw_locked(r4,p0) = r1 }
        { r0 = lsr(r3,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }
0:
        { p0 = and(p0,!p0)
          r0 = lsr(r3,r0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u8::acquire_acquire:
        { r0 = and(#0x18,asl(r0,#0x3))
          r4 = and(r0,#-0x4)
          r5 = #0xff
          r1 = and(r1,#0xff) }
        { r3 = memw_locked(r4) }
        { r5 &= lsr(r3,r0) }
        { p0 = cmp.eq(r5,r1); if (!p0.new) jump:t 0f
          r1 = #0xff }
        { r1 = asl(r1,r0)
          r2 = and(r2,#0xff) }
        { r1 = sub(#-0x1,r1) }
        { r1 = and(r3,r1) }
        { r1 |= asl(r2,r0) }
        { memw_locked(r4,p0) = r1 }
        { r0 = lsr(r3,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }
0:
        { p0 = and(p0,!p0)
          r0 = lsr(r3,r0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        { r0 = and(#0x18,asl(r0,#0x3))
          r4 = and(r0,#-0x4)
          r5 = #0xff
          r1 = and(r1,#0xff) }
        { r3 = memw_locked(r4) }
        { r5 &= lsr(r3,r0) }
        { p0 = cmp.eq(r5,r1); if (!p0.new) jump:t 0f
          r1 = #0xff }
        { r1 = asl(r1,r0)
          r2 = and(r2,#0xff) }
        { r1 = sub(#-0x1,r1) }
        { r1 = and(r3,r1) }
        { r1 |= asl(r2,r0) }
        { memw_locked(r4,p0) = r1 }
        { r0 = lsr(r3,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }
0:
        { p0 = and(p0,!p0)
          r0 = lsr(r3,r0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        { r0 = and(#0x18,asl(r0,#0x3))
          r4 = and(r0,#-0x4)
          r5 = #0xff
          r1 = and(r1,#0xff) }
        { r3 = memw_locked(r4) }
        { r5 &= lsr(r3,r0) }
        { p0 = cmp.eq(r5,r1); if (!p0.new) jump:t 0f
          r1 = #0xff }
        { r1 = asl(r1,r0)
          r2 = and(r2,#0xff) }
        { r1 = sub(#-0x1,r1) }
        { r1 = and(r3,r1) }
        { r1 |= asl(r2,r0) }
        { memw_locked(r4,p0) = r1 }
        { r0 = lsr(r3,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }
0:
        { p0 = and(p0,!p0)
          r0 = lsr(r3,r0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        { r0 = and(#0x18,asl(r0,#0x3))
          r4 = and(r0,#-0x4)
          r5 = #0xff
          r1 = and(r1,#0xff) }
        { r3 = memw_locked(r4) }
        { r5 &= lsr(r3,r0) }
        { p0 = cmp.eq(r5,r1); if (!p0.new) jump:t 0f
          r1 = #0xff }
        { r1 = asl(r1,r0)
          r2 = and(r2,#0xff) }
        { r1 = sub(#-0x1,r1) }
        { r1 = and(r3,r1) }
        { r1 |= asl(r2,r0) }
        { memw_locked(r4,p0) = r1 }
        { r0 = lsr(r3,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }
0:
        { p0 = and(p0,!p0)
          r0 = lsr(r3,r0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u8::release_acquire:
        { r0 = and(#0x18,asl(r0,#0x3))
          r4 = and(r0,#-0x4)
          r5 = #0xff
          r1 = and(r1,#0xff) }
        { r3 = memw_locked(r4) }
        { r5 &= lsr(r3,r0) }
        { p0 = cmp.eq(r5,r1); if (!p0.new) jump:t 0f
          r1 = #0xff }
        { r1 = asl(r1,r0)
          r2 = and(r2,#0xff) }
        { r1 = sub(#-0x1,r1) }
        { r1 = and(r3,r1) }
        { r1 |= asl(r2,r0) }
        { memw_locked(r4,p0) = r1 }
        { r0 = lsr(r3,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }
0:
        { p0 = and(p0,!p0)
          r0 = lsr(r3,r0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u8::release_relaxed:
        { r0 = and(#0x18,asl(r0,#0x3))
          r4 = and(r0,#-0x4)
          r5 = #0xff
          r1 = and(r1,#0xff) }
        { r3 = memw_locked(r4) }
        { r5 &= lsr(r3,r0) }
        { p0 = cmp.eq(r5,r1); if (!p0.new) jump:t 0f
          r1 = #0xff }
        { r1 = asl(r1,r0)
          r2 = and(r2,#0xff) }
        { r1 = sub(#-0x1,r1) }
        { r1 = and(r3,r1) }
        { r1 |= asl(r2,r0) }
        { memw_locked(r4,p0) = r1 }
        { r0 = lsr(r3,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }
0:
        { p0 = and(p0,!p0)
          r0 = lsr(r3,r0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        { r0 = and(#0x18,asl(r0,#0x3))
          r4 = and(r0,#-0x4)
          immext(#0xffc0)
          r5 = ##0xffff }
        { r1 = zxth(r1)
          r3 = memw_locked(r4) }
        { r5 &= lsr(r3,r0) }
        { p0 = cmp.eq(r5,r1); if (!p0.new) jump:t 0f
          immext(#0xffc0)
          r1 = ##0xffff }
        { r1 = asl(r1,r0)
          r2 = zxth(r2) }
        { r1 = sub(#-0x1,r1) }
        { r1 = and(r3,r1) }
        { r1 |= asl(r2,r0) }
        { memw_locked(r4,p0) = r1 }
        { r0 = lsr(r3,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }
0:
        { p0 = and(p0,!p0)
          r0 = lsr(r3,r0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        { r0 = and(#0x18,asl(r0,#0x3))
          r4 = and(r0,#-0x4)
          immext(#0xffc0)
          r5 = ##0xffff }
        { r1 = zxth(r1)
          r3 = memw_locked(r4) }
        { r5 &= lsr(r3,r0) }
        { p0 = cmp.eq(r5,r1); if (!p0.new) jump:t 0f
          immext(#0xffc0)
          r1 = ##0xffff }
        { r1 = asl(r1,r0)
          r2 = zxth(r2) }
        { r1 = sub(#-0x1,r1) }
        { r1 = and(r3,r1) }
        { r1 |= asl(r2,r0) }
        { memw_locked(r4,p0) = r1 }
        { r0 = lsr(r3,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }
0:
        { p0 = and(p0,!p0)
          r0 = lsr(r3,r0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        { r0 = and(#0x18,asl(r0,#0x3))
          r4 = and(r0,#-0x4)
          immext(#0xffc0)
          r5 = ##0xffff }
        { r1 = zxth(r1)
          r3 = memw_locked(r4) }
        { r5 &= lsr(r3,r0) }
        { p0 = cmp.eq(r5,r1); if (!p0.new) jump:t 0f
          immext(#0xffc0)
          r1 = ##0xffff }
        { r1 = asl(r1,r0)
          r2 = zxth(r2) }
        { r1 = sub(#-0x1,r1) }
        { r1 = and(r3,r1) }
        { r1 |= asl(r2,r0) }
        { memw_locked(r4,p0) = r1 }
        { r0 = lsr(r3,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }
0:
        { p0 = and(p0,!p0)
          r0 = lsr(r3,r0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        { r0 = and(#0x18,asl(r0,#0x3))
          r4 = and(r0,#-0x4)
          immext(#0xffc0)
          r5 = ##0xffff }
        { r1 = zxth(r1)
          r3 = memw_locked(r4) }
        { r5 &= lsr(r3,r0) }
        { p0 = cmp.eq(r5,r1); if (!p0.new) jump:t 0f
          immext(#0xffc0)
          r1 = ##0xffff }
        { r1 = asl(r1,r0)
          r2 = zxth(r2) }
        { r1 = sub(#-0x1,r1) }
        { r1 = and(r3,r1) }
        { r1 |= asl(r2,r0) }
        { memw_locked(r4,p0) = r1 }
        { r0 = lsr(r3,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }
0:
        { p0 = and(p0,!p0)
          r0 = lsr(r3,r0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        { r0 = and(#0x18,asl(r0,#0x3))
          r4 = and(r0,#-0x4)
          immext(#0xffc0)
          r5 = ##0xffff }
        { r1 = zxth(r1)
          r3 = memw_locked(r4) }
        { r5 &= lsr(r3,r0) }
        { p0 = cmp.eq(r5,r1); if (!p0.new) jump:t 0f
          immext(#0xffc0)
          r1 = ##0xffff }
        { r1 = asl(r1,r0)
          r2 = zxth(r2) }
        { r1 = sub(#-0x1,r1) }
        { r1 = and(r3,r1) }
        { r1 |= asl(r2,r0) }
        { memw_locked(r4,p0) = r1 }
        { r0 = lsr(r3,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }
0:
        { p0 = and(p0,!p0)
          r0 = lsr(r3,r0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        { r0 = and(#0x18,asl(r0,#0x3))
          r4 = and(r0,#-0x4)
          immext(#0xffc0)
          r5 = ##0xffff }
        { r1 = zxth(r1)
          r3 = memw_locked(r4) }
        { r5 &= lsr(r3,r0) }
        { p0 = cmp.eq(r5,r1); if (!p0.new) jump:t 0f
          immext(#0xffc0)
          r1 = ##0xffff }
        { r1 = asl(r1,r0)
          r2 = zxth(r2) }
        { r1 = sub(#-0x1,r1) }
        { r1 = and(r3,r1) }
        { r1 |= asl(r2,r0) }
        { memw_locked(r4,p0) = r1 }
        { r0 = lsr(r3,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }
0:
        { p0 = and(p0,!p0)
          r0 = lsr(r3,r0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u16::release_seqcst:
        { r0 = and(#0x18,asl(r0,#0x3))
          r4 = and(r0,#-0x4)
          immext(#0xffc0)
          r5 = ##0xffff }
        { r1 = zxth(r1)
          r3 = memw_locked(r4) }
        { r5 &= lsr(r3,r0) }
        { p0 = cmp.eq(r5,r1); if (!p0.new) jump:t 0f
          immext(#0xffc0)
          r1 = ##0xffff }
        { r1 = asl(r1,r0)
          r2 = zxth(r2) }
        { r1 = sub(#-0x1,r1) }
        { r1 = and(r3,r1) }
        { r1 |= asl(r2,r0) }
        { memw_locked(r4,p0) = r1 }
        { r0 = lsr(r3,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }
0:
        { p0 = and(p0,!p0)
          r0 = lsr(r3,r0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        { r0 = and(#0x18,asl(r0,#0x3))
          r4 = and(r0,#-0x4)
          immext(#0xffc0)
          r5 = ##0xffff }
        { r1 = zxth(r1)
          r3 = memw_locked(r4) }
        { r5 &= lsr(r3,r0) }
        { p0 = cmp.eq(r5,r1); if (!p0.new) jump:t 0f
          immext(#0xffc0)
          r1 = ##0xffff }
        { r1 = asl(r1,r0)
          r2 = zxth(r2) }
        { r1 = sub(#-0x1,r1) }
        { r1 = and(r3,r1) }
        { r1 |= asl(r2,r0) }
        { memw_locked(r4,p0) = r1 }
        { r0 = lsr(r3,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }
0:
        { p0 = and(p0,!p0)
          r0 = lsr(r3,r0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        { r0 = and(#0x18,asl(r0,#0x3))
          r4 = and(r0,#-0x4)
          immext(#0xffc0)
          r5 = ##0xffff }
        { r1 = zxth(r1)
          r3 = memw_locked(r4) }
        { r5 &= lsr(r3,r0) }
        { p0 = cmp.eq(r5,r1); if (!p0.new) jump:t 0f
          immext(#0xffc0)
          r1 = ##0xffff }
        { r1 = asl(r1,r0)
          r2 = zxth(r2) }
        { r1 = sub(#-0x1,r1) }
        { r1 = and(r3,r1) }
        { r1 |= asl(r2,r0) }
        { memw_locked(r4,p0) = r1 }
        { r0 = lsr(r3,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }
0:
        { p0 = and(p0,!p0)
          r0 = lsr(r3,r0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u16::acquire_acquire:
        { r0 = and(#0x18,asl(r0,#0x3))
          r4 = and(r0,#-0x4)
          immext(#0xffc0)
          r5 = ##0xffff }
        { r1 = zxth(r1)
          r3 = memw_locked(r4) }
        { r5 &= lsr(r3,r0) }
        { p0 = cmp.eq(r5,r1); if (!p0.new) jump:t 0f
          immext(#0xffc0)
          r1 = ##0xffff }
        { r1 = asl(r1,r0)
          r2 = zxth(r2) }
        { r1 = sub(#-0x1,r1) }
        { r1 = and(r3,r1) }
        { r1 |= asl(r2,r0) }
        { memw_locked(r4,p0) = r1 }
        { r0 = lsr(r3,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }
0:
        { p0 = and(p0,!p0)
          r0 = lsr(r3,r0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        { r0 = and(#0x18,asl(r0,#0x3))
          r4 = and(r0,#-0x4)
          immext(#0xffc0)
          r5 = ##0xffff }
        { r1 = zxth(r1)
          r3 = memw_locked(r4) }
        { r5 &= lsr(r3,r0) }
        { p0 = cmp.eq(r5,r1); if (!p0.new) jump:t 0f
          immext(#0xffc0)
          r1 = ##0xffff }
        { r1 = asl(r1,r0)
          r2 = zxth(r2) }
        { r1 = sub(#-0x1,r1) }
        { r1 = and(r3,r1) }
        { r1 |= asl(r2,r0) }
        { memw_locked(r4,p0) = r1 }
        { r0 = lsr(r3,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }
0:
        { p0 = and(p0,!p0)
          r0 = lsr(r3,r0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        { r0 = and(#0x18,asl(r0,#0x3))
          r4 = and(r0,#-0x4)
          immext(#0xffc0)
          r5 = ##0xffff }
        { r1 = zxth(r1)
          r3 = memw_locked(r4) }
        { r5 &= lsr(r3,r0) }
        { p0 = cmp.eq(r5,r1); if (!p0.new) jump:t 0f
          immext(#0xffc0)
          r1 = ##0xffff }
        { r1 = asl(r1,r0)
          r2 = zxth(r2) }
        { r1 = sub(#-0x1,r1) }
        { r1 = and(r3,r1) }
        { r1 |= asl(r2,r0) }
        { memw_locked(r4,p0) = r1 }
        { r0 = lsr(r3,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }
0:
        { p0 = and(p0,!p0)
          r0 = lsr(r3,r0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        { r0 = and(#0x18,asl(r0,#0x3))
          r4 = and(r0,#-0x4)
          immext(#0xffc0)
          r5 = ##0xffff }
        { r1 = zxth(r1)
          r3 = memw_locked(r4) }
        { r5 &= lsr(r3,r0) }
        { p0 = cmp.eq(r5,r1); if (!p0.new) jump:t 0f
          immext(#0xffc0)
          r1 = ##0xffff }
        { r1 = asl(r1,r0)
          r2 = zxth(r2) }
        { r1 = sub(#-0x1,r1) }
        { r1 = and(r3,r1) }
        { r1 |= asl(r2,r0) }
        { memw_locked(r4,p0) = r1 }
        { r0 = lsr(r3,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }
0:
        { p0 = and(p0,!p0)
          r0 = lsr(r3,r0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u16::release_acquire:
        { r0 = and(#0x18,asl(r0,#0x3))
          r4 = and(r0,#-0x4)
          immext(#0xffc0)
          r5 = ##0xffff }
        { r1 = zxth(r1)
          r3 = memw_locked(r4) }
        { r5 &= lsr(r3,r0) }
        { p0 = cmp.eq(r5,r1); if (!p0.new) jump:t 0f
          immext(#0xffc0)
          r1 = ##0xffff }
        { r1 = asl(r1,r0)
          r2 = zxth(r2) }
        { r1 = sub(#-0x1,r1) }
        { r1 = and(r3,r1) }
        { r1 |= asl(r2,r0) }
        { memw_locked(r4,p0) = r1 }
        { r0 = lsr(r3,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }
0:
        { p0 = and(p0,!p0)
          r0 = lsr(r3,r0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u16::release_relaxed:
        { r0 = and(#0x18,asl(r0,#0x3))
          r4 = and(r0,#-0x4)
          immext(#0xffc0)
          r5 = ##0xffff }
        { r1 = zxth(r1)
          r3 = memw_locked(r4) }
        { r5 &= lsr(r3,r0) }
        { p0 = cmp.eq(r5,r1); if (!p0.new) jump:t 0f
          immext(#0xffc0)
          r1 = ##0xffff }
        { r1 = asl(r1,r0)
          r2 = zxth(r2) }
        { r1 = sub(#-0x1,r1) }
        { r1 = and(r3,r1) }
        { r1 |= asl(r2,r0) }
        { memw_locked(r4,p0) = r1 }
        { r0 = lsr(r3,r0)
          jumpr r31
          r1 = mux(p0,#0x1,#0x0) }
0:
        { p0 = and(p0,!p0)
          r0 = lsr(r3,r0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        { r3 = r0
          r0 = memw_locked(r0) }
        { p0 = cmp.eq(r0,r1); if (!p0.new) jump:t 0f }
        { memw_locked(r3,p0) = r2 }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }
0:
        { p0 = and(p0,!p0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        { r3 = r0
          r0 = memw_locked(r0) }
        { p0 = cmp.eq(r0,r1); if (!p0.new) jump:t 0f }
        { memw_locked(r3,p0) = r2 }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }
0:
        { p0 = and(p0,!p0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        { r3 = r0
          r0 = memw_locked(r0) }
        { p0 = cmp.eq(r0,r1); if (!p0.new) jump:t 0f }
        { memw_locked(r3,p0) = r2 }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }
0:
        { p0 = and(p0,!p0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        { r3 = r0
          r0 = memw_locked(r0) }
        { p0 = cmp.eq(r0,r1); if (!p0.new) jump:t 0f }
        { memw_locked(r3,p0) = r2 }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }
0:
        { p0 = and(p0,!p0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        { r3 = r0
          r0 = memw_locked(r0) }
        { p0 = cmp.eq(r0,r1); if (!p0.new) jump:t 0f }
        { memw_locked(r3,p0) = r2 }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }
0:
        { p0 = and(p0,!p0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        { r3 = r0
          r0 = memw_locked(r0) }
        { p0 = cmp.eq(r0,r1); if (!p0.new) jump:t 0f }
        { memw_locked(r3,p0) = r2 }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }
0:
        { p0 = and(p0,!p0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u32::release_seqcst:
        { r3 = r0
          r0 = memw_locked(r0) }
        { p0 = cmp.eq(r0,r1); if (!p0.new) jump:t 0f }
        { memw_locked(r3,p0) = r2 }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }
0:
        { p0 = and(p0,!p0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        { r3 = r0
          r0 = memw_locked(r0) }
        { p0 = cmp.eq(r0,r1); if (!p0.new) jump:t 0f }
        { memw_locked(r3,p0) = r2 }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }
0:
        { p0 = and(p0,!p0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        { r3 = r0
          r0 = memw_locked(r0) }
        { p0 = cmp.eq(r0,r1); if (!p0.new) jump:t 0f }
        { memw_locked(r3,p0) = r2 }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }
0:
        { p0 = and(p0,!p0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u32::acquire_acquire:
        { r3 = r0
          r0 = memw_locked(r0) }
        { p0 = cmp.eq(r0,r1); if (!p0.new) jump:t 0f }
        { memw_locked(r3,p0) = r2 }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }
0:
        { p0 = and(p0,!p0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        { r3 = r0
          r0 = memw_locked(r0) }
        { p0 = cmp.eq(r0,r1); if (!p0.new) jump:t 0f }
        { memw_locked(r3,p0) = r2 }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }
0:
        { p0 = and(p0,!p0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        { r3 = r0
          r0 = memw_locked(r0) }
        { p0 = cmp.eq(r0,r1); if (!p0.new) jump:t 0f }
        { memw_locked(r3,p0) = r2 }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }
0:
        { p0 = and(p0,!p0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        { r3 = r0
          r0 = memw_locked(r0) }
        { p0 = cmp.eq(r0,r1); if (!p0.new) jump:t 0f }
        { memw_locked(r3,p0) = r2 }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }
0:
        { p0 = and(p0,!p0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u32::release_acquire:
        { r3 = r0
          r0 = memw_locked(r0) }
        { p0 = cmp.eq(r0,r1); if (!p0.new) jump:t 0f }
        { memw_locked(r3,p0) = r2 }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }
0:
        { p0 = and(p0,!p0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::compare_exchange_weak::u32::release_relaxed:
        { r3 = r0
          r0 = memw_locked(r0) }
        { p0 = cmp.eq(r0,r1); if (!p0.new) jump:t 0f }
        { memw_locked(r3,p0) = r2 }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }
0:
        { p0 = and(p0,!p0) }
        { r1 = mux(p0,#0x1,#0x0)
          jumpr r31 }

asm_test::load::u8::seqcst:
        { r0 = memub(r0+#0x0); 	jumpr r31 }

asm_test::load::u8::acquire:
        { r0 = memub(r0+#0x0); 	jumpr r31 }

asm_test::load::u8::relaxed:
        { r0 = memub(r0+#0x0); 	jumpr r31 }

asm_test::load::u16::seqcst:
        { r0 = memuh(r0+#0x0); 	jumpr r31 }

asm_test::load::u16::acquire:
        { r0 = memuh(r0+#0x0); 	jumpr r31 }

asm_test::load::u16::relaxed:
        { r0 = memuh(r0+#0x0); 	jumpr r31 }

asm_test::load::u32::seqcst:
        { r0 = memw(r0+#0x0); 	jumpr r31 }

asm_test::load::u32::acquire:
        { r0 = memw(r0+#0x0); 	jumpr r31 }

asm_test::load::u32::relaxed:
        { r0 = memw(r0+#0x0); 	jumpr r31 }

asm_test::swap::u8::acqrel:
        { r0 = and(#0x18,asl(r0,#0x3))
          r2 = and(r0,#-0x4)
          r3 = #0xff
          r1 = and(r1,#0xff) }
        { r3 = asl(r3,r0)
          r1 = asl(r1,r0) }
        { r3 = sub(#-0x1,r3) }
        { nop }
0:
        { r5 = r1
          r4 = memw_locked(r2) }
        { r5 |= and(r4,r3) }
        { memw_locked(r2,p0) = r5 }
        { if (!p0) jump:nt 0b }
        { r0 = lsr(r4,r0)
          jumpr r31 }

asm_test::swap::u8::seqcst:
        { r0 = and(#0x18,asl(r0,#0x3))
          r2 = and(r0,#-0x4)
          r3 = #0xff
          r1 = and(r1,#0xff) }
        { r3 = asl(r3,r0)
          r1 = asl(r1,r0) }
        { r3 = sub(#-0x1,r3) }
        { nop }
0:
        { r5 = r1
          r4 = memw_locked(r2) }
        { r5 |= and(r4,r3) }
        { memw_locked(r2,p0) = r5 }
        { if (!p0) jump:nt 0b }
        { r0 = lsr(r4,r0)
          jumpr r31 }

asm_test::swap::u8::acquire:
        { r0 = and(#0x18,asl(r0,#0x3))
          r2 = and(r0,#-0x4)
          r3 = #0xff
          r1 = and(r1,#0xff) }
        { r3 = asl(r3,r0)
          r1 = asl(r1,r0) }
        { r3 = sub(#-0x1,r3) }
        { nop }
0:
        { r5 = r1
          r4 = memw_locked(r2) }
        { r5 |= and(r4,r3) }
        { memw_locked(r2,p0) = r5 }
        { if (!p0) jump:nt 0b }
        { r0 = lsr(r4,r0)
          jumpr r31 }

asm_test::swap::u8::relaxed:
        { r0 = and(#0x18,asl(r0,#0x3))
          r2 = and(r0,#-0x4)
          r3 = #0xff
          r1 = and(r1,#0xff) }
        { r3 = asl(r3,r0)
          r1 = asl(r1,r0) }
        { r3 = sub(#-0x1,r3) }
        { nop }
0:
        { r5 = r1
          r4 = memw_locked(r2) }
        { r5 |= and(r4,r3) }
        { memw_locked(r2,p0) = r5 }
        { if (!p0) jump:nt 0b }
        { r0 = lsr(r4,r0)
          jumpr r31 }

asm_test::swap::u8::release:
        { r0 = and(#0x18,asl(r0,#0x3))
          r2 = and(r0,#-0x4)
          r3 = #0xff
          r1 = and(r1,#0xff) }
        { r3 = asl(r3,r0)
          r1 = asl(r1,r0) }
        { r3 = sub(#-0x1,r3) }
        { nop }
0:
        { r5 = r1
          r4 = memw_locked(r2) }
        { r5 |= and(r4,r3) }
        { memw_locked(r2,p0) = r5 }
        { if (!p0) jump:nt 0b }
        { r0 = lsr(r4,r0)
          jumpr r31 }

asm_test::swap::u16::acqrel:
        { r0 = and(#0x18,asl(r0,#0x3))
          r2 = and(r0,#-0x4)
          immext(#0xffc0)
          r3 = ##0xffff }
        { r3 = asl(r3,r0)
          r1 = zxth(r1) }
        { r1 = asl(r1,r0)
          r3 = sub(#-0x1,r3) }
0:
        { r5 = r1
          r4 = memw_locked(r2) }
        { r5 |= and(r4,r3) }
        { memw_locked(r2,p0) = r5 }
        { if (!p0) jump:nt 0b }
        { r0 = lsr(r4,r0)
          jumpr r31 }

asm_test::swap::u16::seqcst:
        { r0 = and(#0x18,asl(r0,#0x3))
          r2 = and(r0,#-0x4)
          immext(#0xffc0)
          r3 = ##0xffff }
        { r3 = asl(r3,r0)
          r1 = zxth(r1) }
        { r1 = asl(r1,r0)
          r3 = sub(#-0x1,r3) }
0:
        { r5 = r1
          r4 = memw_locked(r2) }
        { r5 |= and(r4,r3) }
        { memw_locked(r2,p0) = r5 }
        { if (!p0) jump:nt 0b }
        { r0 = lsr(r4,r0)
          jumpr r31 }

asm_test::swap::u16::acquire:
        { r0 = and(#0x18,asl(r0,#0x3))
          r2 = and(r0,#-0x4)
          immext(#0xffc0)
          r3 = ##0xffff }
        { r3 = asl(r3,r0)
          r1 = zxth(r1) }
        { r1 = asl(r1,r0)
          r3 = sub(#-0x1,r3) }
0:
        { r5 = r1
          r4 = memw_locked(r2) }
        { r5 |= and(r4,r3) }
        { memw_locked(r2,p0) = r5 }
        { if (!p0) jump:nt 0b }
        { r0 = lsr(r4,r0)
          jumpr r31 }

asm_test::swap::u16::relaxed:
        { r0 = and(#0x18,asl(r0,#0x3))
          r2 = and(r0,#-0x4)
          immext(#0xffc0)
          r3 = ##0xffff }
        { r3 = asl(r3,r0)
          r1 = zxth(r1) }
        { r1 = asl(r1,r0)
          r3 = sub(#-0x1,r3) }
0:
        { r5 = r1
          r4 = memw_locked(r2) }
        { r5 |= and(r4,r3) }
        { memw_locked(r2,p0) = r5 }
        { if (!p0) jump:nt 0b }
        { r0 = lsr(r4,r0)
          jumpr r31 }

asm_test::swap::u16::release:
        { r0 = and(#0x18,asl(r0,#0x3))
          r2 = and(r0,#-0x4)
          immext(#0xffc0)
          r3 = ##0xffff }
        { r3 = asl(r3,r0)
          r1 = zxth(r1) }
        { r1 = asl(r1,r0)
          r3 = sub(#-0x1,r3) }
0:
        { r5 = r1
          r4 = memw_locked(r2) }
        { r5 |= and(r4,r3) }
        { memw_locked(r2,p0) = r5 }
        { if (!p0) jump:nt 0b }
        { r0 = lsr(r4,r0)
          jumpr r31 }

asm_test::swap::u32::acqrel:
0:
        { r2 = memw_locked(r0) }
        { memw_locked(r0,p0) = r1 }
        { if (!p0) jump:nt 0b }
        { r0 = r2; 	jumpr r31 }

asm_test::swap::u32::seqcst:
0:
        { r2 = memw_locked(r0) }
        { memw_locked(r0,p0) = r1 }
        { if (!p0) jump:nt 0b }
        { r0 = r2; 	jumpr r31 }

asm_test::swap::u32::acquire:
0:
        { r2 = memw_locked(r0) }
        { memw_locked(r0,p0) = r1 }
        { if (!p0) jump:nt 0b }
        { r0 = r2; 	jumpr r31 }

asm_test::swap::u32::relaxed:
0:
        { r2 = memw_locked(r0) }
        { memw_locked(r0,p0) = r1 }
        { if (!p0) jump:nt 0b }
        { r0 = r2; 	jumpr r31 }

asm_test::swap::u32::release:
0:
        { r2 = memw_locked(r0) }
        { memw_locked(r0,p0) = r1 }
        { if (!p0) jump:nt 0b }
        { r0 = r2; 	jumpr r31 }

asm_test::store::u8::seqcst:
        { jumpr r31
          memb(r0+#0x0) = r1 }

asm_test::store::u8::relaxed:
        { jumpr r31
          memb(r0+#0x0) = r1 }

asm_test::store::u8::release:
        { jumpr r31
          memb(r0+#0x0) = r1 }

asm_test::store::u16::seqcst:
        { jumpr r31
          memh(r0+#0x0) = r1 }

asm_test::store::u16::relaxed:
        { jumpr r31
          memh(r0+#0x0) = r1 }

asm_test::store::u16::release:
        { jumpr r31
          memh(r0+#0x0) = r1 }

asm_test::store::u32::seqcst:
        { jumpr r31
          memw(r0+#0x0) = r1 }

asm_test::store::u32::relaxed:
        { jumpr r31
          memw(r0+#0x0) = r1 }

asm_test::store::u32::release:
        { jumpr r31
          memw(r0+#0x0) = r1 }

