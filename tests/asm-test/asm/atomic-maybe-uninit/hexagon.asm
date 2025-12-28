asm_test::compare_exchange::u8::acqrel_seqcst:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r5 = and(r1,#0xff) }
        { r4 = asl(r4,r0)
          r6 = #0x0; 	r2 = and(r2,#255) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u8::seqcst_seqcst:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r5 = and(r1,#0xff) }
        { r4 = asl(r4,r0)
          r6 = #0x0; 	r2 = and(r2,#255) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u8::acqrel_acquire:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r5 = and(r1,#0xff) }
        { r4 = asl(r4,r0)
          r6 = #0x0; 	r2 = and(r2,#255) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u8::acqrel_relaxed:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r5 = and(r1,#0xff) }
        { r4 = asl(r4,r0)
          r6 = #0x0; 	r2 = and(r2,#255) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u8::acquire_seqcst:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r5 = and(r1,#0xff) }
        { r4 = asl(r4,r0)
          r6 = #0x0; 	r2 = and(r2,#255) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u8::relaxed_seqcst:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r5 = and(r1,#0xff) }
        { r4 = asl(r4,r0)
          r6 = #0x0; 	r2 = and(r2,#255) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u8::release_seqcst:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r5 = and(r1,#0xff) }
        { r4 = asl(r4,r0)
          r6 = #0x0; 	r2 = and(r2,#255) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u8::seqcst_acquire:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r5 = and(r1,#0xff) }
        { r4 = asl(r4,r0)
          r6 = #0x0; 	r2 = and(r2,#255) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u8::seqcst_relaxed:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r5 = and(r1,#0xff) }
        { r4 = asl(r4,r0)
          r6 = #0x0; 	r2 = and(r2,#255) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u8::acquire_acquire:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r5 = and(r1,#0xff) }
        { r4 = asl(r4,r0)
          r6 = #0x0; 	r2 = and(r2,#255) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u8::acquire_relaxed:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r5 = and(r1,#0xff) }
        { r4 = asl(r4,r0)
          r6 = #0x0; 	r2 = and(r2,#255) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u8::relaxed_acquire:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r5 = and(r1,#0xff) }
        { r4 = asl(r4,r0)
          r6 = #0x0; 	r2 = and(r2,#255) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u8::relaxed_relaxed:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r5 = and(r1,#0xff) }
        { r4 = asl(r4,r0)
          r6 = #0x0; 	r2 = and(r2,#255) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u8::release_acquire:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r5 = and(r1,#0xff) }
        { r4 = asl(r4,r0)
          r6 = #0x0; 	r2 = and(r2,#255) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u8::release_relaxed:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r5 = and(r1,#0xff) }
        { r4 = asl(r4,r0)
          r6 = #0x0; 	r2 = and(r2,#255) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u16::acqrel_seqcst:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r4 = asl(r4,r0)
          r2 = zxth(r2)
          r6 = #0x0; 	r5 = zxth(r1) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u16::seqcst_seqcst:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r4 = asl(r4,r0)
          r2 = zxth(r2)
          r6 = #0x0; 	r5 = zxth(r1) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u16::acqrel_acquire:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r4 = asl(r4,r0)
          r2 = zxth(r2)
          r6 = #0x0; 	r5 = zxth(r1) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u16::acqrel_relaxed:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r4 = asl(r4,r0)
          r2 = zxth(r2)
          r6 = #0x0; 	r5 = zxth(r1) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u16::acquire_seqcst:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r4 = asl(r4,r0)
          r2 = zxth(r2)
          r6 = #0x0; 	r5 = zxth(r1) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u16::relaxed_seqcst:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r4 = asl(r4,r0)
          r2 = zxth(r2)
          r6 = #0x0; 	r5 = zxth(r1) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u16::release_seqcst:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r4 = asl(r4,r0)
          r2 = zxth(r2)
          r6 = #0x0; 	r5 = zxth(r1) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u16::seqcst_acquire:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r4 = asl(r4,r0)
          r2 = zxth(r2)
          r6 = #0x0; 	r5 = zxth(r1) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u16::seqcst_relaxed:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r4 = asl(r4,r0)
          r2 = zxth(r2)
          r6 = #0x0; 	r5 = zxth(r1) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u16::acquire_acquire:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r4 = asl(r4,r0)
          r2 = zxth(r2)
          r6 = #0x0; 	r5 = zxth(r1) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u16::acquire_relaxed:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r4 = asl(r4,r0)
          r2 = zxth(r2)
          r6 = #0x0; 	r5 = zxth(r1) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u16::relaxed_acquire:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r4 = asl(r4,r0)
          r2 = zxth(r2)
          r6 = #0x0; 	r5 = zxth(r1) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u16::relaxed_relaxed:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r4 = asl(r4,r0)
          r2 = zxth(r2)
          r6 = #0x0; 	r5 = zxth(r1) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u16::release_acquire:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r4 = asl(r4,r0)
          r2 = zxth(r2)
          r6 = #0x0; 	r5 = zxth(r1) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u16::release_relaxed:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r4 = asl(r4,r0)
          r2 = zxth(r2)
          r6 = #0x0; 	r5 = zxth(r1) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u32::acqrel_seqcst:
        { r4 = #0x0 }
0:
        { r3 = memw_locked(r0) }
        { p0 = cmp.eq(r3,r1); if (!p0.new) jump:nt 1f }
        { memw_locked(r0,p0) = r2 }
        { if (!p0) jump:nt 0b }
        { r4 = #0x1 }
1:
        { r0 = r3; 	p0 = cmp.eq(r4,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u32::seqcst_seqcst:
        { r4 = #0x0 }
0:
        { r3 = memw_locked(r0) }
        { p0 = cmp.eq(r3,r1); if (!p0.new) jump:nt 1f }
        { memw_locked(r0,p0) = r2 }
        { if (!p0) jump:nt 0b }
        { r4 = #0x1 }
1:
        { r0 = r3; 	p0 = cmp.eq(r4,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u32::acqrel_acquire:
        { r4 = #0x0 }
0:
        { r3 = memw_locked(r0) }
        { p0 = cmp.eq(r3,r1); if (!p0.new) jump:nt 1f }
        { memw_locked(r0,p0) = r2 }
        { if (!p0) jump:nt 0b }
        { r4 = #0x1 }
1:
        { r0 = r3; 	p0 = cmp.eq(r4,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u32::acqrel_relaxed:
        { r4 = #0x0 }
0:
        { r3 = memw_locked(r0) }
        { p0 = cmp.eq(r3,r1); if (!p0.new) jump:nt 1f }
        { memw_locked(r0,p0) = r2 }
        { if (!p0) jump:nt 0b }
        { r4 = #0x1 }
1:
        { r0 = r3; 	p0 = cmp.eq(r4,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u32::acquire_seqcst:
        { r4 = #0x0 }
0:
        { r3 = memw_locked(r0) }
        { p0 = cmp.eq(r3,r1); if (!p0.new) jump:nt 1f }
        { memw_locked(r0,p0) = r2 }
        { if (!p0) jump:nt 0b }
        { r4 = #0x1 }
1:
        { r0 = r3; 	p0 = cmp.eq(r4,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u32::relaxed_seqcst:
        { r4 = #0x0 }
0:
        { r3 = memw_locked(r0) }
        { p0 = cmp.eq(r3,r1); if (!p0.new) jump:nt 1f }
        { memw_locked(r0,p0) = r2 }
        { if (!p0) jump:nt 0b }
        { r4 = #0x1 }
1:
        { r0 = r3; 	p0 = cmp.eq(r4,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u32::release_seqcst:
        { r4 = #0x0 }
0:
        { r3 = memw_locked(r0) }
        { p0 = cmp.eq(r3,r1); if (!p0.new) jump:nt 1f }
        { memw_locked(r0,p0) = r2 }
        { if (!p0) jump:nt 0b }
        { r4 = #0x1 }
1:
        { r0 = r3; 	p0 = cmp.eq(r4,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u32::seqcst_acquire:
        { r4 = #0x0 }
0:
        { r3 = memw_locked(r0) }
        { p0 = cmp.eq(r3,r1); if (!p0.new) jump:nt 1f }
        { memw_locked(r0,p0) = r2 }
        { if (!p0) jump:nt 0b }
        { r4 = #0x1 }
1:
        { r0 = r3; 	p0 = cmp.eq(r4,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u32::seqcst_relaxed:
        { r4 = #0x0 }
0:
        { r3 = memw_locked(r0) }
        { p0 = cmp.eq(r3,r1); if (!p0.new) jump:nt 1f }
        { memw_locked(r0,p0) = r2 }
        { if (!p0) jump:nt 0b }
        { r4 = #0x1 }
1:
        { r0 = r3; 	p0 = cmp.eq(r4,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u32::acquire_acquire:
        { r4 = #0x0 }
0:
        { r3 = memw_locked(r0) }
        { p0 = cmp.eq(r3,r1); if (!p0.new) jump:nt 1f }
        { memw_locked(r0,p0) = r2 }
        { if (!p0) jump:nt 0b }
        { r4 = #0x1 }
1:
        { r0 = r3; 	p0 = cmp.eq(r4,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u32::acquire_relaxed:
        { r4 = #0x0 }
0:
        { r3 = memw_locked(r0) }
        { p0 = cmp.eq(r3,r1); if (!p0.new) jump:nt 1f }
        { memw_locked(r0,p0) = r2 }
        { if (!p0) jump:nt 0b }
        { r4 = #0x1 }
1:
        { r0 = r3; 	p0 = cmp.eq(r4,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u32::relaxed_acquire:
        { r4 = #0x0 }
0:
        { r3 = memw_locked(r0) }
        { p0 = cmp.eq(r3,r1); if (!p0.new) jump:nt 1f }
        { memw_locked(r0,p0) = r2 }
        { if (!p0) jump:nt 0b }
        { r4 = #0x1 }
1:
        { r0 = r3; 	p0 = cmp.eq(r4,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u32::relaxed_relaxed:
        { r4 = #0x0 }
0:
        { r3 = memw_locked(r0) }
        { p0 = cmp.eq(r3,r1); if (!p0.new) jump:nt 1f }
        { memw_locked(r0,p0) = r2 }
        { if (!p0) jump:nt 0b }
        { r4 = #0x1 }
1:
        { r0 = r3; 	p0 = cmp.eq(r4,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u32::release_acquire:
        { r4 = #0x0 }
0:
        { r3 = memw_locked(r0) }
        { p0 = cmp.eq(r3,r1); if (!p0.new) jump:nt 1f }
        { memw_locked(r0,p0) = r2 }
        { if (!p0) jump:nt 0b }
        { r4 = #0x1 }
1:
        { r0 = r3; 	p0 = cmp.eq(r4,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u32::release_relaxed:
        { r4 = #0x0 }
0:
        { r3 = memw_locked(r0) }
        { p0 = cmp.eq(r3,r1); if (!p0.new) jump:nt 1f }
        { memw_locked(r0,p0) = r2 }
        { if (!p0) jump:nt 0b }
        { r4 = #0x1 }
1:
        { r0 = r3; 	p0 = cmp.eq(r4,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange::u64::acqrel_seqcst:
        { r8 = #0x0 }
0:
        { r7:6 = memd_locked(r1) }
        { p0 = cmp.eq(r6,r2); if (!p0.new) jump:nt 1f }
        { p0 = cmp.eq(r7,r3); if (!p0.new) jump:nt 1f }
        { memd_locked(r1,p0) = r5:4 }
        { if (!p0) jump:nt 0b }
        { r8 = #0x1 }
1:
        { jumpr r31
          memb(r0+#0x8) = r8
          memd(r0+#0x0) = r7:6 }

asm_test::compare_exchange::u64::seqcst_seqcst:
        { r8 = #0x0 }
0:
        { r7:6 = memd_locked(r1) }
        { p0 = cmp.eq(r6,r2); if (!p0.new) jump:nt 1f }
        { p0 = cmp.eq(r7,r3); if (!p0.new) jump:nt 1f }
        { memd_locked(r1,p0) = r5:4 }
        { if (!p0) jump:nt 0b }
        { r8 = #0x1 }
1:
        { jumpr r31
          memb(r0+#0x8) = r8
          memd(r0+#0x0) = r7:6 }

asm_test::compare_exchange::u64::acqrel_acquire:
        { r8 = #0x0 }
0:
        { r7:6 = memd_locked(r1) }
        { p0 = cmp.eq(r6,r2); if (!p0.new) jump:nt 1f }
        { p0 = cmp.eq(r7,r3); if (!p0.new) jump:nt 1f }
        { memd_locked(r1,p0) = r5:4 }
        { if (!p0) jump:nt 0b }
        { r8 = #0x1 }
1:
        { jumpr r31
          memb(r0+#0x8) = r8
          memd(r0+#0x0) = r7:6 }

asm_test::compare_exchange::u64::acqrel_relaxed:
        { r8 = #0x0 }
0:
        { r7:6 = memd_locked(r1) }
        { p0 = cmp.eq(r6,r2); if (!p0.new) jump:nt 1f }
        { p0 = cmp.eq(r7,r3); if (!p0.new) jump:nt 1f }
        { memd_locked(r1,p0) = r5:4 }
        { if (!p0) jump:nt 0b }
        { r8 = #0x1 }
1:
        { jumpr r31
          memb(r0+#0x8) = r8
          memd(r0+#0x0) = r7:6 }

asm_test::compare_exchange::u64::acquire_seqcst:
        { r8 = #0x0 }
0:
        { r7:6 = memd_locked(r1) }
        { p0 = cmp.eq(r6,r2); if (!p0.new) jump:nt 1f }
        { p0 = cmp.eq(r7,r3); if (!p0.new) jump:nt 1f }
        { memd_locked(r1,p0) = r5:4 }
        { if (!p0) jump:nt 0b }
        { r8 = #0x1 }
1:
        { jumpr r31
          memb(r0+#0x8) = r8
          memd(r0+#0x0) = r7:6 }

asm_test::compare_exchange::u64::relaxed_seqcst:
        { r8 = #0x0 }
0:
        { r7:6 = memd_locked(r1) }
        { p0 = cmp.eq(r6,r2); if (!p0.new) jump:nt 1f }
        { p0 = cmp.eq(r7,r3); if (!p0.new) jump:nt 1f }
        { memd_locked(r1,p0) = r5:4 }
        { if (!p0) jump:nt 0b }
        { r8 = #0x1 }
1:
        { jumpr r31
          memb(r0+#0x8) = r8
          memd(r0+#0x0) = r7:6 }

asm_test::compare_exchange::u64::release_seqcst:
        { r8 = #0x0 }
0:
        { r7:6 = memd_locked(r1) }
        { p0 = cmp.eq(r6,r2); if (!p0.new) jump:nt 1f }
        { p0 = cmp.eq(r7,r3); if (!p0.new) jump:nt 1f }
        { memd_locked(r1,p0) = r5:4 }
        { if (!p0) jump:nt 0b }
        { r8 = #0x1 }
1:
        { jumpr r31
          memb(r0+#0x8) = r8
          memd(r0+#0x0) = r7:6 }

asm_test::compare_exchange::u64::seqcst_acquire:
        { r8 = #0x0 }
0:
        { r7:6 = memd_locked(r1) }
        { p0 = cmp.eq(r6,r2); if (!p0.new) jump:nt 1f }
        { p0 = cmp.eq(r7,r3); if (!p0.new) jump:nt 1f }
        { memd_locked(r1,p0) = r5:4 }
        { if (!p0) jump:nt 0b }
        { r8 = #0x1 }
1:
        { jumpr r31
          memb(r0+#0x8) = r8
          memd(r0+#0x0) = r7:6 }

asm_test::compare_exchange::u64::seqcst_relaxed:
        { r8 = #0x0 }
0:
        { r7:6 = memd_locked(r1) }
        { p0 = cmp.eq(r6,r2); if (!p0.new) jump:nt 1f }
        { p0 = cmp.eq(r7,r3); if (!p0.new) jump:nt 1f }
        { memd_locked(r1,p0) = r5:4 }
        { if (!p0) jump:nt 0b }
        { r8 = #0x1 }
1:
        { jumpr r31
          memb(r0+#0x8) = r8
          memd(r0+#0x0) = r7:6 }

asm_test::compare_exchange::u64::acquire_acquire:
        { r8 = #0x0 }
0:
        { r7:6 = memd_locked(r1) }
        { p0 = cmp.eq(r6,r2); if (!p0.new) jump:nt 1f }
        { p0 = cmp.eq(r7,r3); if (!p0.new) jump:nt 1f }
        { memd_locked(r1,p0) = r5:4 }
        { if (!p0) jump:nt 0b }
        { r8 = #0x1 }
1:
        { jumpr r31
          memb(r0+#0x8) = r8
          memd(r0+#0x0) = r7:6 }

asm_test::compare_exchange::u64::acquire_relaxed:
        { r8 = #0x0 }
0:
        { r7:6 = memd_locked(r1) }
        { p0 = cmp.eq(r6,r2); if (!p0.new) jump:nt 1f }
        { p0 = cmp.eq(r7,r3); if (!p0.new) jump:nt 1f }
        { memd_locked(r1,p0) = r5:4 }
        { if (!p0) jump:nt 0b }
        { r8 = #0x1 }
1:
        { jumpr r31
          memb(r0+#0x8) = r8
          memd(r0+#0x0) = r7:6 }

asm_test::compare_exchange::u64::relaxed_acquire:
        { r8 = #0x0 }
0:
        { r7:6 = memd_locked(r1) }
        { p0 = cmp.eq(r6,r2); if (!p0.new) jump:nt 1f }
        { p0 = cmp.eq(r7,r3); if (!p0.new) jump:nt 1f }
        { memd_locked(r1,p0) = r5:4 }
        { if (!p0) jump:nt 0b }
        { r8 = #0x1 }
1:
        { jumpr r31
          memb(r0+#0x8) = r8
          memd(r0+#0x0) = r7:6 }

asm_test::compare_exchange::u64::relaxed_relaxed:
        { r8 = #0x0 }
0:
        { r7:6 = memd_locked(r1) }
        { p0 = cmp.eq(r6,r2); if (!p0.new) jump:nt 1f }
        { p0 = cmp.eq(r7,r3); if (!p0.new) jump:nt 1f }
        { memd_locked(r1,p0) = r5:4 }
        { if (!p0) jump:nt 0b }
        { r8 = #0x1 }
1:
        { jumpr r31
          memb(r0+#0x8) = r8
          memd(r0+#0x0) = r7:6 }

asm_test::compare_exchange::u64::release_acquire:
        { r8 = #0x0 }
0:
        { r7:6 = memd_locked(r1) }
        { p0 = cmp.eq(r6,r2); if (!p0.new) jump:nt 1f }
        { p0 = cmp.eq(r7,r3); if (!p0.new) jump:nt 1f }
        { memd_locked(r1,p0) = r5:4 }
        { if (!p0) jump:nt 0b }
        { r8 = #0x1 }
1:
        { jumpr r31
          memb(r0+#0x8) = r8
          memd(r0+#0x0) = r7:6 }

asm_test::compare_exchange::u64::release_relaxed:
        { r8 = #0x0 }
0:
        { r7:6 = memd_locked(r1) }
        { p0 = cmp.eq(r6,r2); if (!p0.new) jump:nt 1f }
        { p0 = cmp.eq(r7,r3); if (!p0.new) jump:nt 1f }
        { memd_locked(r1,p0) = r5:4 }
        { if (!p0) jump:nt 0b }
        { r8 = #0x1 }
1:
        { jumpr r31
          memb(r0+#0x8) = r8
          memd(r0+#0x0) = r7:6 }

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r5 = and(r1,#0xff) }
        { r4 = asl(r4,r0)
          r6 = #0x0; 	r2 = and(r2,#255) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r5 = and(r1,#0xff) }
        { r4 = asl(r4,r0)
          r6 = #0x0; 	r2 = and(r2,#255) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r5 = and(r1,#0xff) }
        { r4 = asl(r4,r0)
          r6 = #0x0; 	r2 = and(r2,#255) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r5 = and(r1,#0xff) }
        { r4 = asl(r4,r0)
          r6 = #0x0; 	r2 = and(r2,#255) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r5 = and(r1,#0xff) }
        { r4 = asl(r4,r0)
          r6 = #0x0; 	r2 = and(r2,#255) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r5 = and(r1,#0xff) }
        { r4 = asl(r4,r0)
          r6 = #0x0; 	r2 = and(r2,#255) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u8::release_seqcst:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r5 = and(r1,#0xff) }
        { r4 = asl(r4,r0)
          r6 = #0x0; 	r2 = and(r2,#255) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r5 = and(r1,#0xff) }
        { r4 = asl(r4,r0)
          r6 = #0x0; 	r2 = and(r2,#255) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r5 = and(r1,#0xff) }
        { r4 = asl(r4,r0)
          r6 = #0x0; 	r2 = and(r2,#255) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u8::acquire_acquire:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r5 = and(r1,#0xff) }
        { r4 = asl(r4,r0)
          r6 = #0x0; 	r2 = and(r2,#255) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r5 = and(r1,#0xff) }
        { r4 = asl(r4,r0)
          r6 = #0x0; 	r2 = and(r2,#255) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r5 = and(r1,#0xff) }
        { r4 = asl(r4,r0)
          r6 = #0x0; 	r2 = and(r2,#255) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r5 = and(r1,#0xff) }
        { r4 = asl(r4,r0)
          r6 = #0x0; 	r2 = and(r2,#255) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u8::release_acquire:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r5 = and(r1,#0xff) }
        { r4 = asl(r4,r0)
          r6 = #0x0; 	r2 = and(r2,#255) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u8::release_relaxed:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          r4 = #0xff
          r5 = and(r1,#0xff) }
        { r4 = asl(r4,r0)
          r6 = #0x0; 	r2 = and(r2,#255) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r4 = asl(r4,r0)
          r2 = zxth(r2)
          r6 = #0x0; 	r5 = zxth(r1) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r4 = asl(r4,r0)
          r2 = zxth(r2)
          r6 = #0x0; 	r5 = zxth(r1) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r4 = asl(r4,r0)
          r2 = zxth(r2)
          r6 = #0x0; 	r5 = zxth(r1) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r4 = asl(r4,r0)
          r2 = zxth(r2)
          r6 = #0x0; 	r5 = zxth(r1) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r4 = asl(r4,r0)
          r2 = zxth(r2)
          r6 = #0x0; 	r5 = zxth(r1) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r4 = asl(r4,r0)
          r2 = zxth(r2)
          r6 = #0x0; 	r5 = zxth(r1) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u16::release_seqcst:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r4 = asl(r4,r0)
          r2 = zxth(r2)
          r6 = #0x0; 	r5 = zxth(r1) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r4 = asl(r4,r0)
          r2 = zxth(r2)
          r6 = #0x0; 	r5 = zxth(r1) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r4 = asl(r4,r0)
          r2 = zxth(r2)
          r6 = #0x0; 	r5 = zxth(r1) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u16::acquire_acquire:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r4 = asl(r4,r0)
          r2 = zxth(r2)
          r6 = #0x0; 	r5 = zxth(r1) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r4 = asl(r4,r0)
          r2 = zxth(r2)
          r6 = #0x0; 	r5 = zxth(r1) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r4 = asl(r4,r0)
          r2 = zxth(r2)
          r6 = #0x0; 	r5 = zxth(r1) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r4 = asl(r4,r0)
          r2 = zxth(r2)
          r6 = #0x0; 	r5 = zxth(r1) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u16::release_acquire:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r4 = asl(r4,r0)
          r2 = zxth(r2)
          r6 = #0x0; 	r5 = zxth(r1) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u16::release_relaxed:
        { r0 = and(#0x18,asl(r0,#0x3))
          r3 = and(r0,#-0x4)
          immext(#0xffc0)
          r4 = ##0xffff }
        { r4 = asl(r4,r0)
          r2 = zxth(r2)
          r6 = #0x0; 	r5 = zxth(r1) }
        { r5 = asl(r5,r0) }
        { r2 = asl(r2,r0) }
0:
        { r1 = memw_locked(r3) }
        { r7 = and(r1,r4) }
        { p0 = cmp.eq(r7,r5); if (!p0.new) jump:nt 1f }
        { r7 = and(r1,~r4) }
        { r7 = or(r7,r2) }
        { memw_locked(r3,p0) = r7 }
        { if (!p0) jump:nt 0b }
        { r6 = #0x1 }
1:
        { r1 = asr(r1,r0) }
        { r0 = r1; 	p0 = cmp.eq(r6,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        { r4 = #0x0 }
0:
        { r3 = memw_locked(r0) }
        { p0 = cmp.eq(r3,r1); if (!p0.new) jump:nt 1f }
        { memw_locked(r0,p0) = r2 }
        { if (!p0) jump:nt 0b }
        { r4 = #0x1 }
1:
        { r0 = r3; 	p0 = cmp.eq(r4,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        { r4 = #0x0 }
0:
        { r3 = memw_locked(r0) }
        { p0 = cmp.eq(r3,r1); if (!p0.new) jump:nt 1f }
        { memw_locked(r0,p0) = r2 }
        { if (!p0) jump:nt 0b }
        { r4 = #0x1 }
1:
        { r0 = r3; 	p0 = cmp.eq(r4,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        { r4 = #0x0 }
0:
        { r3 = memw_locked(r0) }
        { p0 = cmp.eq(r3,r1); if (!p0.new) jump:nt 1f }
        { memw_locked(r0,p0) = r2 }
        { if (!p0) jump:nt 0b }
        { r4 = #0x1 }
1:
        { r0 = r3; 	p0 = cmp.eq(r4,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        { r4 = #0x0 }
0:
        { r3 = memw_locked(r0) }
        { p0 = cmp.eq(r3,r1); if (!p0.new) jump:nt 1f }
        { memw_locked(r0,p0) = r2 }
        { if (!p0) jump:nt 0b }
        { r4 = #0x1 }
1:
        { r0 = r3; 	p0 = cmp.eq(r4,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        { r4 = #0x0 }
0:
        { r3 = memw_locked(r0) }
        { p0 = cmp.eq(r3,r1); if (!p0.new) jump:nt 1f }
        { memw_locked(r0,p0) = r2 }
        { if (!p0) jump:nt 0b }
        { r4 = #0x1 }
1:
        { r0 = r3; 	p0 = cmp.eq(r4,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        { r4 = #0x0 }
0:
        { r3 = memw_locked(r0) }
        { p0 = cmp.eq(r3,r1); if (!p0.new) jump:nt 1f }
        { memw_locked(r0,p0) = r2 }
        { if (!p0) jump:nt 0b }
        { r4 = #0x1 }
1:
        { r0 = r3; 	p0 = cmp.eq(r4,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u32::release_seqcst:
        { r4 = #0x0 }
0:
        { r3 = memw_locked(r0) }
        { p0 = cmp.eq(r3,r1); if (!p0.new) jump:nt 1f }
        { memw_locked(r0,p0) = r2 }
        { if (!p0) jump:nt 0b }
        { r4 = #0x1 }
1:
        { r0 = r3; 	p0 = cmp.eq(r4,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        { r4 = #0x0 }
0:
        { r3 = memw_locked(r0) }
        { p0 = cmp.eq(r3,r1); if (!p0.new) jump:nt 1f }
        { memw_locked(r0,p0) = r2 }
        { if (!p0) jump:nt 0b }
        { r4 = #0x1 }
1:
        { r0 = r3; 	p0 = cmp.eq(r4,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        { r4 = #0x0 }
0:
        { r3 = memw_locked(r0) }
        { p0 = cmp.eq(r3,r1); if (!p0.new) jump:nt 1f }
        { memw_locked(r0,p0) = r2 }
        { if (!p0) jump:nt 0b }
        { r4 = #0x1 }
1:
        { r0 = r3; 	p0 = cmp.eq(r4,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u32::acquire_acquire:
        { r4 = #0x0 }
0:
        { r3 = memw_locked(r0) }
        { p0 = cmp.eq(r3,r1); if (!p0.new) jump:nt 1f }
        { memw_locked(r0,p0) = r2 }
        { if (!p0) jump:nt 0b }
        { r4 = #0x1 }
1:
        { r0 = r3; 	p0 = cmp.eq(r4,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        { r4 = #0x0 }
0:
        { r3 = memw_locked(r0) }
        { p0 = cmp.eq(r3,r1); if (!p0.new) jump:nt 1f }
        { memw_locked(r0,p0) = r2 }
        { if (!p0) jump:nt 0b }
        { r4 = #0x1 }
1:
        { r0 = r3; 	p0 = cmp.eq(r4,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        { r4 = #0x0 }
0:
        { r3 = memw_locked(r0) }
        { p0 = cmp.eq(r3,r1); if (!p0.new) jump:nt 1f }
        { memw_locked(r0,p0) = r2 }
        { if (!p0) jump:nt 0b }
        { r4 = #0x1 }
1:
        { r0 = r3; 	p0 = cmp.eq(r4,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        { r4 = #0x0 }
0:
        { r3 = memw_locked(r0) }
        { p0 = cmp.eq(r3,r1); if (!p0.new) jump:nt 1f }
        { memw_locked(r0,p0) = r2 }
        { if (!p0) jump:nt 0b }
        { r4 = #0x1 }
1:
        { r0 = r3; 	p0 = cmp.eq(r4,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u32::release_acquire:
        { r4 = #0x0 }
0:
        { r3 = memw_locked(r0) }
        { p0 = cmp.eq(r3,r1); if (!p0.new) jump:nt 1f }
        { memw_locked(r0,p0) = r2 }
        { if (!p0) jump:nt 0b }
        { r4 = #0x1 }
1:
        { r0 = r3; 	p0 = cmp.eq(r4,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u32::release_relaxed:
        { r4 = #0x0 }
0:
        { r3 = memw_locked(r0) }
        { p0 = cmp.eq(r3,r1); if (!p0.new) jump:nt 1f }
        { memw_locked(r0,p0) = r2 }
        { if (!p0) jump:nt 0b }
        { r4 = #0x1 }
1:
        { r0 = r3; 	p0 = cmp.eq(r4,#0x0) }
        { r1 = mux(p0,#0x0,#0x1)
          jumpr r31 }

asm_test::compare_exchange_weak::u64::acqrel_seqcst:
        { r8 = #0x0 }
0:
        { r7:6 = memd_locked(r1) }
        { p0 = cmp.eq(r6,r2); if (!p0.new) jump:nt 1f }
        { p0 = cmp.eq(r7,r3); if (!p0.new) jump:nt 1f }
        { memd_locked(r1,p0) = r5:4 }
        { if (!p0) jump:nt 0b }
        { r8 = #0x1 }
1:
        { jumpr r31
          memb(r0+#0x8) = r8
          memd(r0+#0x0) = r7:6 }

asm_test::compare_exchange_weak::u64::seqcst_seqcst:
        { r8 = #0x0 }
0:
        { r7:6 = memd_locked(r1) }
        { p0 = cmp.eq(r6,r2); if (!p0.new) jump:nt 1f }
        { p0 = cmp.eq(r7,r3); if (!p0.new) jump:nt 1f }
        { memd_locked(r1,p0) = r5:4 }
        { if (!p0) jump:nt 0b }
        { r8 = #0x1 }
1:
        { jumpr r31
          memb(r0+#0x8) = r8
          memd(r0+#0x0) = r7:6 }

asm_test::compare_exchange_weak::u64::acqrel_acquire:
        { r8 = #0x0 }
0:
        { r7:6 = memd_locked(r1) }
        { p0 = cmp.eq(r6,r2); if (!p0.new) jump:nt 1f }
        { p0 = cmp.eq(r7,r3); if (!p0.new) jump:nt 1f }
        { memd_locked(r1,p0) = r5:4 }
        { if (!p0) jump:nt 0b }
        { r8 = #0x1 }
1:
        { jumpr r31
          memb(r0+#0x8) = r8
          memd(r0+#0x0) = r7:6 }

asm_test::compare_exchange_weak::u64::acqrel_relaxed:
        { r8 = #0x0 }
0:
        { r7:6 = memd_locked(r1) }
        { p0 = cmp.eq(r6,r2); if (!p0.new) jump:nt 1f }
        { p0 = cmp.eq(r7,r3); if (!p0.new) jump:nt 1f }
        { memd_locked(r1,p0) = r5:4 }
        { if (!p0) jump:nt 0b }
        { r8 = #0x1 }
1:
        { jumpr r31
          memb(r0+#0x8) = r8
          memd(r0+#0x0) = r7:6 }

asm_test::compare_exchange_weak::u64::acquire_seqcst:
        { r8 = #0x0 }
0:
        { r7:6 = memd_locked(r1) }
        { p0 = cmp.eq(r6,r2); if (!p0.new) jump:nt 1f }
        { p0 = cmp.eq(r7,r3); if (!p0.new) jump:nt 1f }
        { memd_locked(r1,p0) = r5:4 }
        { if (!p0) jump:nt 0b }
        { r8 = #0x1 }
1:
        { jumpr r31
          memb(r0+#0x8) = r8
          memd(r0+#0x0) = r7:6 }

asm_test::compare_exchange_weak::u64::relaxed_seqcst:
        { r8 = #0x0 }
0:
        { r7:6 = memd_locked(r1) }
        { p0 = cmp.eq(r6,r2); if (!p0.new) jump:nt 1f }
        { p0 = cmp.eq(r7,r3); if (!p0.new) jump:nt 1f }
        { memd_locked(r1,p0) = r5:4 }
        { if (!p0) jump:nt 0b }
        { r8 = #0x1 }
1:
        { jumpr r31
          memb(r0+#0x8) = r8
          memd(r0+#0x0) = r7:6 }

asm_test::compare_exchange_weak::u64::release_seqcst:
        { r8 = #0x0 }
0:
        { r7:6 = memd_locked(r1) }
        { p0 = cmp.eq(r6,r2); if (!p0.new) jump:nt 1f }
        { p0 = cmp.eq(r7,r3); if (!p0.new) jump:nt 1f }
        { memd_locked(r1,p0) = r5:4 }
        { if (!p0) jump:nt 0b }
        { r8 = #0x1 }
1:
        { jumpr r31
          memb(r0+#0x8) = r8
          memd(r0+#0x0) = r7:6 }

asm_test::compare_exchange_weak::u64::seqcst_acquire:
        { r8 = #0x0 }
0:
        { r7:6 = memd_locked(r1) }
        { p0 = cmp.eq(r6,r2); if (!p0.new) jump:nt 1f }
        { p0 = cmp.eq(r7,r3); if (!p0.new) jump:nt 1f }
        { memd_locked(r1,p0) = r5:4 }
        { if (!p0) jump:nt 0b }
        { r8 = #0x1 }
1:
        { jumpr r31
          memb(r0+#0x8) = r8
          memd(r0+#0x0) = r7:6 }

asm_test::compare_exchange_weak::u64::seqcst_relaxed:
        { r8 = #0x0 }
0:
        { r7:6 = memd_locked(r1) }
        { p0 = cmp.eq(r6,r2); if (!p0.new) jump:nt 1f }
        { p0 = cmp.eq(r7,r3); if (!p0.new) jump:nt 1f }
        { memd_locked(r1,p0) = r5:4 }
        { if (!p0) jump:nt 0b }
        { r8 = #0x1 }
1:
        { jumpr r31
          memb(r0+#0x8) = r8
          memd(r0+#0x0) = r7:6 }

asm_test::compare_exchange_weak::u64::acquire_acquire:
        { r8 = #0x0 }
0:
        { r7:6 = memd_locked(r1) }
        { p0 = cmp.eq(r6,r2); if (!p0.new) jump:nt 1f }
        { p0 = cmp.eq(r7,r3); if (!p0.new) jump:nt 1f }
        { memd_locked(r1,p0) = r5:4 }
        { if (!p0) jump:nt 0b }
        { r8 = #0x1 }
1:
        { jumpr r31
          memb(r0+#0x8) = r8
          memd(r0+#0x0) = r7:6 }

asm_test::compare_exchange_weak::u64::acquire_relaxed:
        { r8 = #0x0 }
0:
        { r7:6 = memd_locked(r1) }
        { p0 = cmp.eq(r6,r2); if (!p0.new) jump:nt 1f }
        { p0 = cmp.eq(r7,r3); if (!p0.new) jump:nt 1f }
        { memd_locked(r1,p0) = r5:4 }
        { if (!p0) jump:nt 0b }
        { r8 = #0x1 }
1:
        { jumpr r31
          memb(r0+#0x8) = r8
          memd(r0+#0x0) = r7:6 }

asm_test::compare_exchange_weak::u64::relaxed_acquire:
        { r8 = #0x0 }
0:
        { r7:6 = memd_locked(r1) }
        { p0 = cmp.eq(r6,r2); if (!p0.new) jump:nt 1f }
        { p0 = cmp.eq(r7,r3); if (!p0.new) jump:nt 1f }
        { memd_locked(r1,p0) = r5:4 }
        { if (!p0) jump:nt 0b }
        { r8 = #0x1 }
1:
        { jumpr r31
          memb(r0+#0x8) = r8
          memd(r0+#0x0) = r7:6 }

asm_test::compare_exchange_weak::u64::relaxed_relaxed:
        { r8 = #0x0 }
0:
        { r7:6 = memd_locked(r1) }
        { p0 = cmp.eq(r6,r2); if (!p0.new) jump:nt 1f }
        { p0 = cmp.eq(r7,r3); if (!p0.new) jump:nt 1f }
        { memd_locked(r1,p0) = r5:4 }
        { if (!p0) jump:nt 0b }
        { r8 = #0x1 }
1:
        { jumpr r31
          memb(r0+#0x8) = r8
          memd(r0+#0x0) = r7:6 }

asm_test::compare_exchange_weak::u64::release_acquire:
        { r8 = #0x0 }
0:
        { r7:6 = memd_locked(r1) }
        { p0 = cmp.eq(r6,r2); if (!p0.new) jump:nt 1f }
        { p0 = cmp.eq(r7,r3); if (!p0.new) jump:nt 1f }
        { memd_locked(r1,p0) = r5:4 }
        { if (!p0) jump:nt 0b }
        { r8 = #0x1 }
1:
        { jumpr r31
          memb(r0+#0x8) = r8
          memd(r0+#0x0) = r7:6 }

asm_test::compare_exchange_weak::u64::release_relaxed:
        { r8 = #0x0 }
0:
        { r7:6 = memd_locked(r1) }
        { p0 = cmp.eq(r6,r2); if (!p0.new) jump:nt 1f }
        { p0 = cmp.eq(r7,r3); if (!p0.new) jump:nt 1f }
        { memd_locked(r1,p0) = r5:4 }
        { if (!p0) jump:nt 0b }
        { r8 = #0x1 }
1:
        { jumpr r31
          memb(r0+#0x8) = r8
          memd(r0+#0x0) = r7:6 }

asm_test::load::u8::seqcst:
        { r0 = memub(r0+#0x0) }
        { jumpr r31 }

asm_test::load::u8::acquire:
        { r0 = memub(r0+#0x0) }
        { jumpr r31 }

asm_test::load::u8::relaxed:
        { r0 = memub(r0+#0x0) }
        { jumpr r31 }

asm_test::load::u16::seqcst:
        { r0 = memuh(r0+#0x0) }
        { jumpr r31 }

asm_test::load::u16::acquire:
        { r0 = memuh(r0+#0x0) }
        { jumpr r31 }

asm_test::load::u16::relaxed:
        { r0 = memuh(r0+#0x0) }
        { jumpr r31 }

asm_test::load::u32::seqcst:
        { r0 = memw(r0+#0x0) }
        { jumpr r31 }

asm_test::load::u32::acquire:
        { r0 = memw(r0+#0x0) }
        { jumpr r31 }

asm_test::load::u32::relaxed:
        { r0 = memw(r0+#0x0) }
        { jumpr r31 }

asm_test::load::u64::seqcst:
        { r3:2 = memd(r0+#0x0) }
        { r1:0 = combine(r3,r2)
          jumpr r31 }

asm_test::load::u64::acquire:
        { r3:2 = memd(r0+#0x0) }
        { r1:0 = combine(r3,r2)
          jumpr r31 }

asm_test::load::u64::relaxed:
        { r3:2 = memd(r0+#0x0) }
        { r1:0 = combine(r3,r2)
          jumpr r31 }

asm_test::swap::u8::acqrel:
        { r0 = and(#0x18,asl(r0,#0x3))
          r2 = and(r0,#-0x4)
          r3 = #0xff
          r4 = and(r1,#0xff) }
        { r3 = asl(r3,r0) }
        { r4 = asl(r4,r0) }
0:
        { r1 = memw_locked(r2) }
        { r5 = and(r1,~r3) }
        { r5 = or(r5,r4) }
        { memw_locked(r2,p0) = r5 }
        { if (!p0) jump:nt 0b }
        { r1 = asr(r1,r0) }
        { r0 = r1; 	jumpr r31 }

asm_test::swap::u8::seqcst:
        { r0 = and(#0x18,asl(r0,#0x3))
          r2 = and(r0,#-0x4)
          r3 = #0xff
          r4 = and(r1,#0xff) }
        { r3 = asl(r3,r0) }
        { r4 = asl(r4,r0) }
0:
        { r1 = memw_locked(r2) }
        { r5 = and(r1,~r3) }
        { r5 = or(r5,r4) }
        { memw_locked(r2,p0) = r5 }
        { if (!p0) jump:nt 0b }
        { r1 = asr(r1,r0) }
        { r0 = r1; 	jumpr r31 }

asm_test::swap::u8::acquire:
        { r0 = and(#0x18,asl(r0,#0x3))
          r2 = and(r0,#-0x4)
          r3 = #0xff
          r4 = and(r1,#0xff) }
        { r3 = asl(r3,r0) }
        { r4 = asl(r4,r0) }
0:
        { r1 = memw_locked(r2) }
        { r5 = and(r1,~r3) }
        { r5 = or(r5,r4) }
        { memw_locked(r2,p0) = r5 }
        { if (!p0) jump:nt 0b }
        { r1 = asr(r1,r0) }
        { r0 = r1; 	jumpr r31 }

asm_test::swap::u8::relaxed:
        { r0 = and(#0x18,asl(r0,#0x3))
          r2 = and(r0,#-0x4)
          r3 = #0xff
          r4 = and(r1,#0xff) }
        { r3 = asl(r3,r0) }
        { r4 = asl(r4,r0) }
0:
        { r1 = memw_locked(r2) }
        { r5 = and(r1,~r3) }
        { r5 = or(r5,r4) }
        { memw_locked(r2,p0) = r5 }
        { if (!p0) jump:nt 0b }
        { r1 = asr(r1,r0) }
        { r0 = r1; 	jumpr r31 }

asm_test::swap::u8::release:
        { r0 = and(#0x18,asl(r0,#0x3))
          r2 = and(r0,#-0x4)
          r3 = #0xff
          r4 = and(r1,#0xff) }
        { r3 = asl(r3,r0) }
        { r4 = asl(r4,r0) }
0:
        { r1 = memw_locked(r2) }
        { r5 = and(r1,~r3) }
        { r5 = or(r5,r4) }
        { memw_locked(r2,p0) = r5 }
        { if (!p0) jump:nt 0b }
        { r1 = asr(r1,r0) }
        { r0 = r1; 	jumpr r31 }

asm_test::swap::u16::acqrel:
        { r0 = and(#0x18,asl(r0,#0x3))
          r2 = and(r0,#-0x4)
          immext(#0xffc0)
          r3 = ##0xffff }
        { r3 = asl(r3,r0)
          r4 = zxth(r1) }
        { r4 = asl(r4,r0) }
0:
        { r1 = memw_locked(r2) }
        { r5 = and(r1,~r3) }
        { r5 = or(r5,r4) }
        { memw_locked(r2,p0) = r5 }
        { if (!p0) jump:nt 0b }
        { r1 = asr(r1,r0) }
        { r0 = r1; 	jumpr r31 }

asm_test::swap::u16::seqcst:
        { r0 = and(#0x18,asl(r0,#0x3))
          r2 = and(r0,#-0x4)
          immext(#0xffc0)
          r3 = ##0xffff }
        { r3 = asl(r3,r0)
          r4 = zxth(r1) }
        { r4 = asl(r4,r0) }
0:
        { r1 = memw_locked(r2) }
        { r5 = and(r1,~r3) }
        { r5 = or(r5,r4) }
        { memw_locked(r2,p0) = r5 }
        { if (!p0) jump:nt 0b }
        { r1 = asr(r1,r0) }
        { r0 = r1; 	jumpr r31 }

asm_test::swap::u16::acquire:
        { r0 = and(#0x18,asl(r0,#0x3))
          r2 = and(r0,#-0x4)
          immext(#0xffc0)
          r3 = ##0xffff }
        { r3 = asl(r3,r0)
          r4 = zxth(r1) }
        { r4 = asl(r4,r0) }
0:
        { r1 = memw_locked(r2) }
        { r5 = and(r1,~r3) }
        { r5 = or(r5,r4) }
        { memw_locked(r2,p0) = r5 }
        { if (!p0) jump:nt 0b }
        { r1 = asr(r1,r0) }
        { r0 = r1; 	jumpr r31 }

asm_test::swap::u16::relaxed:
        { r0 = and(#0x18,asl(r0,#0x3))
          r2 = and(r0,#-0x4)
          immext(#0xffc0)
          r3 = ##0xffff }
        { r3 = asl(r3,r0)
          r4 = zxth(r1) }
        { r4 = asl(r4,r0) }
0:
        { r1 = memw_locked(r2) }
        { r5 = and(r1,~r3) }
        { r5 = or(r5,r4) }
        { memw_locked(r2,p0) = r5 }
        { if (!p0) jump:nt 0b }
        { r1 = asr(r1,r0) }
        { r0 = r1; 	jumpr r31 }

asm_test::swap::u16::release:
        { r0 = and(#0x18,asl(r0,#0x3))
          r2 = and(r0,#-0x4)
          immext(#0xffc0)
          r3 = ##0xffff }
        { r3 = asl(r3,r0)
          r4 = zxth(r1) }
        { r4 = asl(r4,r0) }
0:
        { r1 = memw_locked(r2) }
        { r5 = and(r1,~r3) }
        { r5 = or(r5,r4) }
        { memw_locked(r2,p0) = r5 }
        { if (!p0) jump:nt 0b }
        { r1 = asr(r1,r0) }
        { r0 = r1; 	jumpr r31 }

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

asm_test::swap::u64::acqrel:
0:
        { r5:4 = memd_locked(r0) }
        { memd_locked(r0,p0) = r3:2 }
        { if (!p0) jump:nt 0b }
        { r1:0 = combine(r5,r4)
          jumpr r31 }

asm_test::swap::u64::seqcst:
0:
        { r5:4 = memd_locked(r0) }
        { memd_locked(r0,p0) = r3:2 }
        { if (!p0) jump:nt 0b }
        { r1:0 = combine(r5,r4)
          jumpr r31 }

asm_test::swap::u64::acquire:
0:
        { r5:4 = memd_locked(r0) }
        { memd_locked(r0,p0) = r3:2 }
        { if (!p0) jump:nt 0b }
        { r1:0 = combine(r5,r4)
          jumpr r31 }

asm_test::swap::u64::relaxed:
0:
        { r5:4 = memd_locked(r0) }
        { memd_locked(r0,p0) = r3:2 }
        { if (!p0) jump:nt 0b }
        { r1:0 = combine(r5,r4)
          jumpr r31 }

asm_test::swap::u64::release:
0:
        { r5:4 = memd_locked(r0) }
        { memd_locked(r0,p0) = r3:2 }
        { if (!p0) jump:nt 0b }
        { r1:0 = combine(r5,r4)
          jumpr r31 }

asm_test::store::u8::seqcst:
        { memb(r0+#0x0) = r1 }
        { jumpr r31 }

asm_test::store::u8::relaxed:
        { memb(r0+#0x0) = r1 }
        { jumpr r31 }

asm_test::store::u8::release:
        { memb(r0+#0x0) = r1 }
        { jumpr r31 }

asm_test::store::u16::seqcst:
        { memh(r0+#0x0) = r1 }
        { jumpr r31 }

asm_test::store::u16::relaxed:
        { memh(r0+#0x0) = r1 }
        { jumpr r31 }

asm_test::store::u16::release:
        { memh(r0+#0x0) = r1 }
        { jumpr r31 }

asm_test::store::u32::seqcst:
        { memw(r0+#0x0) = r1 }
        { jumpr r31 }

asm_test::store::u32::relaxed:
        { memw(r0+#0x0) = r1 }
        { jumpr r31 }

asm_test::store::u32::release:
        { memw(r0+#0x0) = r1 }
        { jumpr r31 }

asm_test::store::u64::seqcst:
        { memd(r0+#0x0) = r3:2 }
        { jumpr r31 }

asm_test::store::u64::relaxed:
        { memd(r0+#0x0) = r3:2 }
        { jumpr r31 }

asm_test::store::u64::release:
        { memd(r0+#0x0) = r3:2 }
        { jumpr r31 }

