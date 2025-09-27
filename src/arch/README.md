<!-- omit in toc -->
# Atomic operation overview by architecture

This directory contains architecture-specific atomic implementations.

This document describes the operations that are considered atomic by architecture.

- [AArch64](#aarch64)
- [Arm](#arm)
- [AVR](#avr)
- [C-SKY](#c-sky)
- [Hexagon](#hexagon)
- [LoongArch](#loongarch)
- [M68k](#m68k)
- [MIPS](#mips)
- [MSP430](#msp430)
- [PowerPC](#powerpc)
- [RISC-V](#risc-v)
- [s390x](#s390x)
- [SPARC](#sparc)
- [x86](#x86)
- [Xtensa](#xtensa)

## AArch64

target_arch: aarch64, arm64ec<br>
Implementation: [aarch64.rs](aarch64.rs)<br>
Refs: [Arm® Architecture Reference Manual for A-profile architecture](https://developer.arm.com/documentation/ddi0487/latest)

TODO: overview

(Refs: Section B2.2 "Atomicity in the Arm architecture" of Arm® Architecture Reference Manual for A-profile architecture)

## Arm

target_arch: arm<br>
Implementation: [arm.rs](arm.rs), [armv8.rs](armv8.rs), [arm_linux.rs](arm_linux.rs)<br>
Refs: [Arm® Architecture Reference Manual for A-profile architecture](https://developer.arm.com/documentation/ddi0487/latest), [Arm® v8-M Architecture Reference Manual](https://developer.arm.com/documentation/ddi0553/latest), [ARM® Architecture Reference Manual ARMv7-A and ARMv7-R edition](https://developer.arm.com/documentation/ddi0406/latest), [Arm® v7-M Architecture Reference Manual](https://developer.arm.com/documentation/ddi0403/latest), [ARM® v6-M Architecture Reference Manual](https://developer.arm.com/documentation/ddi0419/latest)

TODO: overview

(Refs: Section E2.2 "Atomicity in the Arm architecture" of Arm® Architecture Reference Manual for A-profile architecture, Section B7.2 "Atomicity" of Arm® v8-M Architecture Reference Manual, Section A3.5.3 "Atomicity in the ARM architecture" of ARM® Architecture Reference Manual ARMv7-A and ARMv7-R edition, Section A3.5.3 "Atomicity in the Arm architecture" of Arm® v7-M Architecture Reference Manual, Section A3.5.1 "Atomicity in the ARM architecture" of ARM® v6-M Architecture Reference Manual)

## AVR

target_arch: avr<br>
Implementation: [avr.rs](avr.rs)<br>
Refs: [AVR® Instruction Set Manual, Rev. DS40002198B](https://ww1.microchip.com/downloads/en/DeviceDoc/AVR-InstructionSet-Manual-DS40002198.pdf)

This architecture is always single-core and the following operations are atomic:

- Operation that is complete within a single instruction.<br>
  This is because the currently executing instruction must be completed before entering the
  interrupt service routine.<br>
  (Refs: [AVR® Interrupts](https://developerhelp.microchip.com/xwiki/bin/view/products/mcu-mpu/8-bit-avr/structure/interrupts/))<br>
  The following two kinds of instructions are related to memory access:
  - 8-bit load/store
  - XCH, LAC, LAS, LAT: 8-bit swap,fetch-and-{clear,or,xor} (xmegau family)

- Operations performed in a situation where all interrupts are disabled.<br>
  However, pure operations that are not affected by compiler fences (Note: the correct interrupt
  disabling and restoring implementation must imply compiler fences, e.g., asm without nomem/readonly)
  may be moved out of the critical section by compiler optimizations.

## C-SKY

target_arch: csky<br>
Implementation: [csky.rs](csky.rs)<br>

TODO: reference and overview

## Hexagon

target_arch: hexagon<br>
Implementation: [hexagon.rs](hexagon.rs)<br>

TODO: reference and overview

## LoongArch

target_arch: loongarch32, loongarch64<br>
Implementation: [loongarch.rs](loongarch.rs)<br>

TODO: reference and overview

## M68k

target_arch: m68k<br>
Implementation: [m68k.rs](m68k.rs)<br>
Refs: [M68000 FAMILY Programmer's Reference Manual](https://www.nxp.com/docs/en/reference-manual/M68000PRM.pdf)

The following instructions are atomic if the address is properly aligned and the specified storage meets the requirements:

- Load/Store Instructions
  - {8,16,32}-bit

- Multiprocessor Instructions
  - TAS: 8-bit TAS (M68000 or later)
  - CAS: {8,16,32}-bit CAS (M68020 or later)
  - CAS2: {16,32}-bit double CAS (M68020 or later)

  (Refs: Section 3.1.11 "Multiprocessor Instructions" of M68000 FAMILY Programmer's Reference Manual)

Note that CAS2 is not yet supported in LLVM (as of 21) (our code use `.2byte` directive to work around it).

## MIPS

target_arch: mips, mips32r6, mips64, mips64r6<br>
Implementation: [mips.rs](mips.rs)<br>
Refs: [The MIPS32® Instruction Set Manual, Revision 6.06 (MD00086)](https://s3-eu-west-1.amazonaws.com/downloads-mips/documents/MD00086-2B-MIPS32BIS-AFP-6.06.pdf), [The MIPS64® Instruction Set Reference Manual, Revision 6.06 (MD00087)](https://s3-eu-west-1.amazonaws.com/downloads-mips/documents/MD00087-2B-MIPS64BIS-AFP-6.06.pdf), [MIPS® Coherence Protocol Specification, Revision 01.01 (MD00605)](https://s3-eu-west-1.amazonaws.com/downloads-mips/documents/MD00605-2B-CMPCOHERE-AFP-01.01.pdf)

The following instructions are atomic if the address is properly aligned and the specified storage meets the requirements:

- Load/Store Instructions
  - {8,16,32}-bit and 64-bit (MIPS64 only)

- LoadLinked and StoreConditional Instructions (LL/SC)
  - LL/SC: 32-bit LL/SC (MIPS32 or later)
  - LLD/SCD: 64-bit LL/SC (MIPS64 or later)
  - LLE/SCE: 32-bit LL/SC (MIPS32 or later, only present if Config5EVA=1)
  - LLWP/SCWP: 64-bit LL/SC (MIPS32R6 or later, only present if Config5XNP=0)
  - LLWPE/SCWPE: 64-bit LL/SC (MIPS32R6 or later, only present if Config5XNP=0 and Config5EVA=1)
  - LLDP/SCDP: 128-bit LL/SC (MIPS64R6 or later, only present if Config5XNP is 0)

Note that LL{W,D}P{,E}/SC{W,D}P{,E} is not yet supported in LLVM (as of 19).

None of the above instructions imply a memory barrier.
Several types of memory barriers are provided by SYNC instruction, but only SYNC (SYNC 0) is mandatory.
<br>
(Refs: Section 4.6.2 "Memory Barriers" and section 4.6.3 "Implicit Memory Barriers" of MIPS® Coherence Protocol Specification)

## MSP430

target_arch: msp430<br>
Implementation: [msp430.rs](msp430.rs)<br>
Refs: [MSP430x5xx and MSP430x6xx Family User's Guide, Rev. Q](https://www.ti.com/lit/ug/slau208q/slau208q.pdf)

This architecture is always single-core and the following operations are atomic:

- Operation that is complete within a single instruction.<br>
  This is because the currently executing instruction must be completed before entering the
  interrupt service routine.<br>
  (Refs: [Section 1.3.4.1 "Interrupt Acceptance" of MSP430x5xx and MSP430x6xx Family User's Guide, Rev. Q](https://www.ti.com/lit/ug/slau208q/slau208q.pdf#page=59))

- Operations performed in a situation where all interrupts are disabled.<br>
  However, pure operations that are not affected by compiler fences (Note: the correct interrupt
  disabling and restoring implementation must imply compiler fences, e.g., asm without nomem/readonly)
  may be moved out of the critical section by compiler optimizations.

## PowerPC

target_arch: powerpc, powerpc64<br>
Implementation: [powerpc.rs](powerpc.rs)<br>
Refs: Power ISA ([3.1C](https://files.openpower.foundation/s/9izgC5Rogi5Ywmm), [2.07B](https://ibm.ent.box.com/s/jd5w15gz301s5b5dt375mshpq9c3lh4u))

The following instructions are atomic if the address is properly aligned and the specified storage meets the requirements:

- Load/Store Instructions
  - All {8,16,32}-bit and 64-bit (powerpc64-only) single load/store instructions other than Move Assist instruction<br>
  - lq/stq: 128-bit load/store (powerpc64-only)<br>
    Compatibility: ISA 2.07 or later (available since ISA 2.03, but were privileged instructions and big-endian mode only and no documented atomicity guarantee, in pre-2.07 ISA)
    - ISA 2.07B: included in the requirements of server processors as Load/Store Quadword category
    - ISA 3.1C: included in the Linux Compliancy subset and AIX Compliancy subset
  - plq/pstq: 128-bit load/store (powerpc64-only)<br>
    (Note: Not mentioned in "Single-Copy Atomicity" section, but GCC [uses them for 128-bit load/store](https://github.com/gcc-mirror/gcc/commit/3bcdb5dec72b6d7b197821c2b814bc9fc07f4628))<br>
    Compatibility: ISA 3.1 or later
    - ISA 3.1C: included in the Linux Compliancy subset and AIX Compliancy subset

  (Refs: Section 1.4 "Single-Copy Atomicity" of Power ISA 3.1C Book II)

- Load And Reserve and Store Conditional Instructions (aka LL/SC)
  - l{b,h}arx/st{b,h}cx.: {8,16}-bit LL/SC<br>
    Compatibility: ISA 2.06 or later
    - ISA 2.07B: included in the requirements as Base category
    - ISA 3.1C: included in all compliancy subsets
  - lwarx/stwcx.: 32-bit LL/SC<br>
    Compatibility: PPC or later
    - ISA 2.07B: included in the requirements as Base category
    - ISA 3.1C: included in all compliancy subsets
  - ldarx/stdcx.: 64-bit LL/SC (powerpc64-only)<br>
    Compatibility: PPC or later
    - ISA 2.07B: included in the requirements of 64-bit processors as 64-bit category
    - ISA 3.1C: included in the Linux Compliancy subset and AIX Compliancy subset
  - lqarx/stqcx.: 128-bit LL/SC (powerpc64-only)<br>
    Compatibility: ISA 2.07 or later
    - ISA 2.07B: included in the requirements of server processors as Load/Store Quadword category
    - ISA 3.1C: included in the Linux Compliancy subset and AIX Compliancy subset

  (Refs: Section 4.6.2 "Load And Reserve and Store Conditional Instructions" of Power ISA 3.1C Book II)

- Atomic Memory Operation (AMO) Instructions
  - l{w,d}at: {32,64}-bit swap,fetch-and-{add,and,or,xor,max,min},etc. (powerpc64-only)<br>
    <!-- (Others: Compare and Swap Not Equal, Fetch and Increment Bounded, Fetch and Increment Equal, Fetch and Decrement Bounded) -->
  - st{w,d}at: {32,64}-bit add,and,or,xor,max,min,etc. (powerpc64-only)<br>
    <!-- (Others: Store Twin) -->

  Compatibility: ISA 3.0 or later
  - ISA 3.1C: included in the AIX Compliancy subset

  (Refs: Section 4.5 "Atomic Memory Operations" of Power ISA 3.1C Book II)

Load-store instructions are atomic only if properly aligned. LL/SC and AMO instructions require
proper alignment, otherwise the system alignment error handler is invoked or the results are boundedly undefined.<br>
(Refs: Section 1.4 "Single-Copy Atomicity", 4.6.2 "Load And Reserve and Store Conditional Instructions", and 4.5 "Atomic Memory Operations" of Power ISA 3.1C Book II)

Note that plq/pstq is not yet supported in LLVM (as of 19).

None of the above instructions imply a memory barrier.

- A sync (sync 0, sync 0,0, hwsync) instruction can be used as both an "import barrier" and an "export barrier".<br>
  Compatibility: POWER1 or later (some BookE processors don't have this and provide msync which has the same bit-pattern instead but no lwsync support)
  - ISA 2.07B: included in the requirements as Base category
  - ISA 3.1C: included in all compliancy subsets
- A lwsync (sync 1, sync 1,0) instruction can be used as both an "import barrier" and an "export barrier",
  if the specified storage location is in storage that is neither Write Through Required nor Caching Inhibited.<br>
- An "import barrier" can be constructed by a branch that depends on the loaded value (even a branch
  that depends on a comparison of the same register is okay), followed by an isync instruction.<br>
  Compatibility: POWER1 or later
  - ISA 2.07B: included in the requirements as Base category
  - ISA 3.1C: included in all compliancy subsets

(Refs: Section 1.7.1 "Storage Access Ordering" and Section B.2 "Lock Acquisition and Release, and Related Techniques" of Power ISA 3.1C Book II)

sync corresponds to SeqCst semantics, lwsync corresponds to Acquire/Release semantics, and isync
with appropriate sequence corresponds to Acquire semantics.

## RISC-V

target_arch: riscv32, riscv64<br>
Implementation: [riscv.rs](riscv.rs)<br>
Refs: [RISC-V Instruction Set Manual](https://github.com/riscv/riscv-isa-manual)

The following instructions are atomic if the address is properly aligned and the specified storage meets the requirements:

- Load/Store Instructions (relaxed load/store)
  - All {8,16,32}-bit (for RV32 & RV64) and 64-bit (for RV64) load/store instructions<br>
    (Refs: [Section "Memory Model Primitives" of RVWMO Memory Consistency Model, Version 2.0](https://github.com/riscv/riscv-isa-manual/blob/riscv-isa-release-56e76be-2025-08-26/src/rvwmo.adoc#memory-model-primitives))

- Load-Acquire and Store-Release Instructions
  - (experimental) Zalasr extension: {8,16,32}-bit (for RV32 & RV64) and 64-bit (for RV64) acquire/seqcst load, release/seqcst store<br>
    (Refs: [RISC-V Zalasr Specification](https://github.com/riscv/riscv-zalasr))

- Load-Reserved/Store-Conditional (LR/SC) Instructions (aka LL/SC)
  - Zalrsc extension: 32-bit (for RV32 & RV64) and 64-bit (for RV64)<br>
    (Refs: ["Zalrsc" Extension for Load-Reserved/Store-Conditional Instructions](https://github.com/riscv/riscv-isa-manual/blob/riscv-isa-release-56e76be-2025-08-26/src/a-st-ext.adoc#zalrsc-extension-for-load-reservedstore-conditional-instructions))

- Atomic Memory Operation (AMO) Instructions
  - Zaamo extension: 32-bit (for RV32 & RV64) and 64-bit (for RV64) swap,fetch_{add,and,or,xor,max,min}<br>
    (Refs: ["Zaamo" Extension for Atomic Memory Operations](https://github.com/riscv/riscv-isa-manual/blob/riscv-isa-release-56e76be-2025-08-26/src/a-st-ext.adoc#zaamo-extension-for-atomic-memory-operations))
  - Zabha extension: {8,16}-bit swap,fetch_{add,and,or,xor,max,min}<br>
    (Refs: ["Zabha" Extension for Byte and Halfword Atomic Memory Operations, Version 1.0](https://github.com/riscv/riscv-isa-manual/blob/riscv-isa-release-56e76be-2025-08-26/src/zabha.adoc))

- Atomic Compare-and-Swap (CAS) Instructions
  - Zacas extension: {32,64}-bit (for RV32 & RV64) and 128-bit (for RV64)<br>
    (Refs: ["Zacas" Extension for Atomic Compare-and-Swap (CAS) Instructions, Version 1.0.0](https://github.com/riscv/riscv-isa-manual/blob/riscv-isa-release-56e76be-2025-08-26/src/zacas.adoc))
  - Zacas and Zabha extensions: {8,16}-bit<br>
    (Refs: ["Zabha" Extension for Byte and Halfword Atomic Memory Operations, Version 1.0](https://github.com/riscv/riscv-isa-manual/blob/riscv-isa-release-56e76be-2025-08-26/src/zabha.adoc))

Of the above instructions, instructions other than relaxed load/store, can specify the memory ordering.<br>
The mappings from the C/C++ atomic operations are described in the [RISC-V Atomics ABI Specification](https://github.com/riscv-non-isa/riscv-elf-psabi-doc/blob/draft-20250812-301374e92976e298e676e7129a6212926b2299ce/riscv-atomic.adoc).

Note: "A" extension comprises instructions provided by Zalrsc and Zaamo extensions,
Zabha and Zacas extensions depends upon Zaamo extension.

(RV128 is not currently ratified, so it is [not mentioned in the ISA manual](https://github.com/riscv/riscv-isa-manual/pull/1942).)

## s390x

target_arch: s390x<br>
Implementation: [s390x.rs](s390x.rs)<br>
Refs: z/Architecture Principles of Operation ([Fifteenth Edition](https://www.ibm.com/docs/en/module_1678991624569/pdf/SA22-7832-14.pdf))

The following instructions are atomic if the address is properly aligned and the specified storage meets the requirements:

- Load/Store Instructions
  - All {8,16,32,64}-bit load/store instructions that having Single-Access References<br>
    (Refs: Section "Storage-Operand Fetch References", "Storage-Operand Store References", and "Storage-Operand Consistency" of z/Architecture Principles of Operation, Fourteenth Edition)
  - LPQ/STPQ: 128-bit load/store (arch1 or later)<br>
    (Refs: Section "LOAD PAIR FROM QUADWORD" and "STORE PAIR TO QUADWORD" of z/Architecture Principles of Operation, Fourteenth Edition)

- Instructions that having Interlocked-Update References
  - TS: 8-bit TAS (360 or later)<br>
    <!-- (TEST AND SET) -->
  - CS{,Y,G}, CDS{,Y,G}: {32,64,128}-bit CAS (CS,CDS: 370 or later, CSG,CDSG: arch1 or later, CSY,CDSY: long-displacement facility added in arch3)<br>
    <!-- (COMPARE AND SWAP, COMPARE DOUBLE AND SWAP) -->
  - LAA{,G}, LAAL{,G}, LAN{,G}, LAO{,G}, LAX{,G}: {32,64}-bit fetch-and-{add,and,or,xor} (interlocked-access facility 1 added in arch9)<br>
    <!-- (LOAD AND ADD, LOAD AND ADD LOGICAL, LOAD AND AND, LOAD AND OR, LOAD AND EXCLUSIVE OR) -->
  - A{,G}SI, AL{,G}SI: {32,64}-bit add with immediate (interlocked-access facility 1 added in arch9)<br>
    <!-- (Storage-and-immediate formats of ADD IMMEDIATE and ADD LOGICAL WITH SIGNED IMMEDIATE) -->
  - NI{,Y}, OI{,Y}, XI{,Y}: 8-bit {and,or,xor} with immediate (interlocked-access facility 2 added in arch10)<br>
    <!-- (Storage-and-immediate formats of AND, OR, and EXCLUSIVE OR) -->
  <!-- - (Others: COMPARE AND REPLACE DAT TABLE ENTRY, COMPARE AND SWAP AND PURGE, COMPARE AND SWAP AND STORE, STORE CHARACTERS UNDER MASK (conditional)) -->
  <!-- - (Others: COMPARE AND LOAD (concurrent-functions facility added in arch15)) -->

  (Refs: Section "Storage-Operand Update References" of z/Architecture Principles of Operation, Fourteenth Edition)

Of the above instructions, instructions that having Interlocked-Update References
other than STORE CHARACTERS UNDER MASK perform serialization.<br>
(Refs: Section "CPU Serialization" of z/Architecture Principles of Operation, Fourteenth Edition)

The following instructions are usually used as standalone serialization:

- BCR 15,0 (360 or later)
- BCR 14,0 (fast-BCR-serialization facility added in arch9)

(Refs: Section "BRANCH ON CONDITION" of z/Architecture Principles of Operation, Fourteenth Edition)

Serialization corresponds to SeqCst semantics, all memory access has Acquire/Release semantics.

## SPARC

target_arch: sparc, sparc64<br>
Implementation: [sparc.rs](sparc.rs)<br>
Refs: The SPARC Architecture Manual ([Version 9, Version 8](https://sparc.org/technical-documents))

The following instructions are atomic if the address is properly aligned and the specified storage meets the requirements:

- Load/Store Instructions
  - V7 or later: {8,16,32}-bit
  - V8+,V9: 64-bit

  (Refs: Section D.4.1 "Value Atomicity" of the SPARC Architecture Manual, Version 9)

- Compare-and-Swap Instructions
  - V8+,V9: {32,64}-bit CAS
  - V8 with LEONCASA: 32-bit CAS

  (Refs: Section 8.4.6 "Hardware Primitives for Mutual Exclusion" of the SPARC Architecture Manual, Version 9)

- SWAP Instructions (deprecated in V9)
  - V7 or later: 32-bit swap

  (Refs: Section 8.4.6 "Hardware Primitives for Mutual Exclusion" and A.57 "Swap Register with Memory" of the SPARC Architecture Manual, Version 9)

- Load Store Unsigned Byte Instructions
  - V7 or later: 8-bit TAS

  (Refs: Section 8.4.6 "Hardware Primitives for Mutual Exclusion" of the SPARC Architecture Manual, Version 9)

Memory access instructions require proper alignment, but some instructions are
implementation-dependent and may work with insufficient alignment.<br>
(Refs: Section 6.3.1.1 Memory Alignment Restrictions" of the SPARC Architecture Manual, Version 9)

Which memory barrier the above instructions imply depends on the memory model used.
V8+ and V9 have three memory models: Total Store Order (TSO), Partial Store Order (PSO), and Relaxed
Memory Order (RMO). V8 has only TSO and PSO. Implementation of TSO (or a more strongly ordered model
which implies TSO) is mandatory, and PSO and RMO are optional.<br>
(Refs: Section 8.4.4 "Memory Models" of the SPARC Architecture Manual, Version 9)

## x86

target_arch: x86, x86_64<br>
Implementation: [x86.rs](x86.rs)<br>

TODO: reference and overview

## Xtensa

target_arch: xtensa<br>
Implementation: [xtensa.rs](xtensa.rs)<br>

TODO: reference and overview
