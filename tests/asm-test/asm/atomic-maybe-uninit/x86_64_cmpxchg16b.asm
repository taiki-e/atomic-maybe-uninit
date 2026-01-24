asm_test::compare_exchange::u8::acqrel_seqcst:
        mov               eax, esi
        movzx             ecx, dl
        lock cmpxchg      byte ptr [rdi], cl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u8::seqcst_seqcst:
        mov               eax, esi
        movzx             ecx, dl
        lock cmpxchg      byte ptr [rdi], cl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u8::acqrel_acquire:
        mov               eax, esi
        movzx             ecx, dl
        lock cmpxchg      byte ptr [rdi], cl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u8::acqrel_relaxed:
        mov               eax, esi
        movzx             ecx, dl
        lock cmpxchg      byte ptr [rdi], cl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u8::acquire_seqcst:
        mov               eax, esi
        movzx             ecx, dl
        lock cmpxchg      byte ptr [rdi], cl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u8::relaxed_seqcst:
        mov               eax, esi
        movzx             ecx, dl
        lock cmpxchg      byte ptr [rdi], cl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u8::release_seqcst:
        mov               eax, esi
        movzx             ecx, dl
        lock cmpxchg      byte ptr [rdi], cl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u8::seqcst_acquire:
        mov               eax, esi
        movzx             ecx, dl
        lock cmpxchg      byte ptr [rdi], cl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u8::seqcst_relaxed:
        mov               eax, esi
        movzx             ecx, dl
        lock cmpxchg      byte ptr [rdi], cl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u8::acquire_acquire:
        mov               eax, esi
        movzx             ecx, dl
        lock cmpxchg      byte ptr [rdi], cl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u8::acquire_relaxed:
        mov               eax, esi
        movzx             ecx, dl
        lock cmpxchg      byte ptr [rdi], cl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u8::relaxed_acquire:
        mov               eax, esi
        movzx             ecx, dl
        lock cmpxchg      byte ptr [rdi], cl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u8::relaxed_relaxed:
        mov               eax, esi
        movzx             ecx, dl
        lock cmpxchg      byte ptr [rdi], cl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u8::release_acquire:
        mov               eax, esi
        movzx             ecx, dl
        lock cmpxchg      byte ptr [rdi], cl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u8::release_relaxed:
        mov               eax, esi
        movzx             ecx, dl
        lock cmpxchg      byte ptr [rdi], cl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::acqrel_seqcst:
        mov               eax, esi
        lock cmpxchg      word ptr [rdi], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::seqcst_seqcst:
        mov               eax, esi
        lock cmpxchg      word ptr [rdi], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::acqrel_acquire:
        mov               eax, esi
        lock cmpxchg      word ptr [rdi], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::acqrel_relaxed:
        mov               eax, esi
        lock cmpxchg      word ptr [rdi], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::acquire_seqcst:
        mov               eax, esi
        lock cmpxchg      word ptr [rdi], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::relaxed_seqcst:
        mov               eax, esi
        lock cmpxchg      word ptr [rdi], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::release_seqcst:
        mov               eax, esi
        lock cmpxchg      word ptr [rdi], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::seqcst_acquire:
        mov               eax, esi
        lock cmpxchg      word ptr [rdi], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::seqcst_relaxed:
        mov               eax, esi
        lock cmpxchg      word ptr [rdi], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::acquire_acquire:
        mov               eax, esi
        lock cmpxchg      word ptr [rdi], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::acquire_relaxed:
        mov               eax, esi
        lock cmpxchg      word ptr [rdi], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::relaxed_acquire:
        mov               eax, esi
        lock cmpxchg      word ptr [rdi], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::relaxed_relaxed:
        mov               eax, esi
        lock cmpxchg      word ptr [rdi], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::release_acquire:
        mov               eax, esi
        lock cmpxchg      word ptr [rdi], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::release_relaxed:
        mov               eax, esi
        lock cmpxchg      word ptr [rdi], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::acqrel_seqcst:
        mov               eax, esi
        lock cmpxchg      dword ptr [rdi], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::seqcst_seqcst:
        mov               eax, esi
        lock cmpxchg      dword ptr [rdi], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::acqrel_acquire:
        mov               eax, esi
        lock cmpxchg      dword ptr [rdi], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::acqrel_relaxed:
        mov               eax, esi
        lock cmpxchg      dword ptr [rdi], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::acquire_seqcst:
        mov               eax, esi
        lock cmpxchg      dword ptr [rdi], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::relaxed_seqcst:
        mov               eax, esi
        lock cmpxchg      dword ptr [rdi], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::release_seqcst:
        mov               eax, esi
        lock cmpxchg      dword ptr [rdi], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::seqcst_acquire:
        mov               eax, esi
        lock cmpxchg      dword ptr [rdi], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::seqcst_relaxed:
        mov               eax, esi
        lock cmpxchg      dword ptr [rdi], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::acquire_acquire:
        mov               eax, esi
        lock cmpxchg      dword ptr [rdi], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::acquire_relaxed:
        mov               eax, esi
        lock cmpxchg      dword ptr [rdi], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::relaxed_acquire:
        mov               eax, esi
        lock cmpxchg      dword ptr [rdi], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::relaxed_relaxed:
        mov               eax, esi
        lock cmpxchg      dword ptr [rdi], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::release_acquire:
        mov               eax, esi
        lock cmpxchg      dword ptr [rdi], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::release_relaxed:
        mov               eax, esi
        lock cmpxchg      dword ptr [rdi], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u64::acqrel_seqcst:
        mov               rax, rsi
        lock cmpxchg      qword ptr [rdi], rdx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u64::seqcst_seqcst:
        mov               rax, rsi
        lock cmpxchg      qword ptr [rdi], rdx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u64::acqrel_acquire:
        mov               rax, rsi
        lock cmpxchg      qword ptr [rdi], rdx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u64::acqrel_relaxed:
        mov               rax, rsi
        lock cmpxchg      qword ptr [rdi], rdx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u64::acquire_seqcst:
        mov               rax, rsi
        lock cmpxchg      qword ptr [rdi], rdx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u64::relaxed_seqcst:
        mov               rax, rsi
        lock cmpxchg      qword ptr [rdi], rdx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u64::release_seqcst:
        mov               rax, rsi
        lock cmpxchg      qword ptr [rdi], rdx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u64::seqcst_acquire:
        mov               rax, rsi
        lock cmpxchg      qword ptr [rdi], rdx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u64::seqcst_relaxed:
        mov               rax, rsi
        lock cmpxchg      qword ptr [rdi], rdx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u64::acquire_acquire:
        mov               rax, rsi
        lock cmpxchg      qword ptr [rdi], rdx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u64::acquire_relaxed:
        mov               rax, rsi
        lock cmpxchg      qword ptr [rdi], rdx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u64::relaxed_acquire:
        mov               rax, rsi
        lock cmpxchg      qword ptr [rdi], rdx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u64::relaxed_relaxed:
        mov               rax, rsi
        lock cmpxchg      qword ptr [rdi], rdx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u64::release_acquire:
        mov               rax, rsi
        lock cmpxchg      qword ptr [rdi], rdx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u64::release_relaxed:
        mov               rax, rsi
        lock cmpxchg      qword ptr [rdi], rdx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u128::acqrel_seqcst:
        mov               r10, rcx
        mov               rax, rdx
        mov               rcx, r9
        mov               rdx, r10
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [rdi + 0x8], rdx
        mov               qword ptr [rdi], rax
        mov               byte ptr [rdi + 0x10], cl
        mov               rax, rdi
        ret

asm_test::compare_exchange::u128::seqcst_seqcst:
        mov               r10, rcx
        mov               rax, rdx
        mov               rcx, r9
        mov               rdx, r10
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [rdi + 0x8], rdx
        mov               qword ptr [rdi], rax
        mov               byte ptr [rdi + 0x10], cl
        mov               rax, rdi
        ret

asm_test::compare_exchange::u128::acqrel_acquire:
        mov               r10, rcx
        mov               rax, rdx
        mov               rcx, r9
        mov               rdx, r10
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [rdi + 0x8], rdx
        mov               qword ptr [rdi], rax
        mov               byte ptr [rdi + 0x10], cl
        mov               rax, rdi
        ret

asm_test::compare_exchange::u128::acqrel_relaxed:
        mov               r10, rcx
        mov               rax, rdx
        mov               rcx, r9
        mov               rdx, r10
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [rdi + 0x8], rdx
        mov               qword ptr [rdi], rax
        mov               byte ptr [rdi + 0x10], cl
        mov               rax, rdi
        ret

asm_test::compare_exchange::u128::acquire_seqcst:
        mov               r10, rcx
        mov               rax, rdx
        mov               rcx, r9
        mov               rdx, r10
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [rdi + 0x8], rdx
        mov               qword ptr [rdi], rax
        mov               byte ptr [rdi + 0x10], cl
        mov               rax, rdi
        ret

asm_test::compare_exchange::u128::relaxed_seqcst:
        mov               r10, rcx
        mov               rax, rdx
        mov               rcx, r9
        mov               rdx, r10
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [rdi + 0x8], rdx
        mov               qword ptr [rdi], rax
        mov               byte ptr [rdi + 0x10], cl
        mov               rax, rdi
        ret

asm_test::compare_exchange::u128::release_seqcst:
        mov               r10, rcx
        mov               rax, rdx
        mov               rcx, r9
        mov               rdx, r10
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [rdi + 0x8], rdx
        mov               qword ptr [rdi], rax
        mov               byte ptr [rdi + 0x10], cl
        mov               rax, rdi
        ret

asm_test::compare_exchange::u128::seqcst_acquire:
        mov               r10, rcx
        mov               rax, rdx
        mov               rcx, r9
        mov               rdx, r10
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [rdi + 0x8], rdx
        mov               qword ptr [rdi], rax
        mov               byte ptr [rdi + 0x10], cl
        mov               rax, rdi
        ret

asm_test::compare_exchange::u128::seqcst_relaxed:
        mov               r10, rcx
        mov               rax, rdx
        mov               rcx, r9
        mov               rdx, r10
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [rdi + 0x8], rdx
        mov               qword ptr [rdi], rax
        mov               byte ptr [rdi + 0x10], cl
        mov               rax, rdi
        ret

asm_test::compare_exchange::u128::acquire_acquire:
        mov               r10, rcx
        mov               rax, rdx
        mov               rcx, r9
        mov               rdx, r10
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [rdi + 0x8], rdx
        mov               qword ptr [rdi], rax
        mov               byte ptr [rdi + 0x10], cl
        mov               rax, rdi
        ret

asm_test::compare_exchange::u128::acquire_relaxed:
        mov               r10, rcx
        mov               rax, rdx
        mov               rcx, r9
        mov               rdx, r10
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [rdi + 0x8], rdx
        mov               qword ptr [rdi], rax
        mov               byte ptr [rdi + 0x10], cl
        mov               rax, rdi
        ret

asm_test::compare_exchange::u128::relaxed_acquire:
        mov               r10, rcx
        mov               rax, rdx
        mov               rcx, r9
        mov               rdx, r10
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [rdi + 0x8], rdx
        mov               qword ptr [rdi], rax
        mov               byte ptr [rdi + 0x10], cl
        mov               rax, rdi
        ret

asm_test::compare_exchange::u128::relaxed_relaxed:
        mov               r10, rcx
        mov               rax, rdx
        mov               rcx, r9
        mov               rdx, r10
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [rdi + 0x8], rdx
        mov               qword ptr [rdi], rax
        mov               byte ptr [rdi + 0x10], cl
        mov               rax, rdi
        ret

asm_test::compare_exchange::u128::release_acquire:
        mov               r10, rcx
        mov               rax, rdx
        mov               rcx, r9
        mov               rdx, r10
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [rdi + 0x8], rdx
        mov               qword ptr [rdi], rax
        mov               byte ptr [rdi + 0x10], cl
        mov               rax, rdi
        ret

asm_test::compare_exchange::u128::release_relaxed:
        mov               r10, rcx
        mov               rax, rdx
        mov               rcx, r9
        mov               rdx, r10
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [rdi + 0x8], rdx
        mov               qword ptr [rdi], rax
        mov               byte ptr [rdi + 0x10], cl
        mov               rax, rdi
        ret

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        mov               eax, esi
        movzx             ecx, dl
        lock cmpxchg      byte ptr [rdi], cl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        mov               eax, esi
        movzx             ecx, dl
        lock cmpxchg      byte ptr [rdi], cl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        mov               eax, esi
        movzx             ecx, dl
        lock cmpxchg      byte ptr [rdi], cl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        mov               eax, esi
        movzx             ecx, dl
        lock cmpxchg      byte ptr [rdi], cl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        mov               eax, esi
        movzx             ecx, dl
        lock cmpxchg      byte ptr [rdi], cl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        mov               eax, esi
        movzx             ecx, dl
        lock cmpxchg      byte ptr [rdi], cl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u8::release_seqcst:
        mov               eax, esi
        movzx             ecx, dl
        lock cmpxchg      byte ptr [rdi], cl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        mov               eax, esi
        movzx             ecx, dl
        lock cmpxchg      byte ptr [rdi], cl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        mov               eax, esi
        movzx             ecx, dl
        lock cmpxchg      byte ptr [rdi], cl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u8::acquire_acquire:
        mov               eax, esi
        movzx             ecx, dl
        lock cmpxchg      byte ptr [rdi], cl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        mov               eax, esi
        movzx             ecx, dl
        lock cmpxchg      byte ptr [rdi], cl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        mov               eax, esi
        movzx             ecx, dl
        lock cmpxchg      byte ptr [rdi], cl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        mov               eax, esi
        movzx             ecx, dl
        lock cmpxchg      byte ptr [rdi], cl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u8::release_acquire:
        mov               eax, esi
        movzx             ecx, dl
        lock cmpxchg      byte ptr [rdi], cl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u8::release_relaxed:
        mov               eax, esi
        movzx             ecx, dl
        lock cmpxchg      byte ptr [rdi], cl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        mov               eax, esi
        lock cmpxchg      word ptr [rdi], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        mov               eax, esi
        lock cmpxchg      word ptr [rdi], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        mov               eax, esi
        lock cmpxchg      word ptr [rdi], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        mov               eax, esi
        lock cmpxchg      word ptr [rdi], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        mov               eax, esi
        lock cmpxchg      word ptr [rdi], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        mov               eax, esi
        lock cmpxchg      word ptr [rdi], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::release_seqcst:
        mov               eax, esi
        lock cmpxchg      word ptr [rdi], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        mov               eax, esi
        lock cmpxchg      word ptr [rdi], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        mov               eax, esi
        lock cmpxchg      word ptr [rdi], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::acquire_acquire:
        mov               eax, esi
        lock cmpxchg      word ptr [rdi], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        mov               eax, esi
        lock cmpxchg      word ptr [rdi], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        mov               eax, esi
        lock cmpxchg      word ptr [rdi], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        mov               eax, esi
        lock cmpxchg      word ptr [rdi], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::release_acquire:
        mov               eax, esi
        lock cmpxchg      word ptr [rdi], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::release_relaxed:
        mov               eax, esi
        lock cmpxchg      word ptr [rdi], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        mov               eax, esi
        lock cmpxchg      dword ptr [rdi], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        mov               eax, esi
        lock cmpxchg      dword ptr [rdi], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        mov               eax, esi
        lock cmpxchg      dword ptr [rdi], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        mov               eax, esi
        lock cmpxchg      dword ptr [rdi], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        mov               eax, esi
        lock cmpxchg      dword ptr [rdi], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        mov               eax, esi
        lock cmpxchg      dword ptr [rdi], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::release_seqcst:
        mov               eax, esi
        lock cmpxchg      dword ptr [rdi], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        mov               eax, esi
        lock cmpxchg      dword ptr [rdi], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        mov               eax, esi
        lock cmpxchg      dword ptr [rdi], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::acquire_acquire:
        mov               eax, esi
        lock cmpxchg      dword ptr [rdi], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        mov               eax, esi
        lock cmpxchg      dword ptr [rdi], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        mov               eax, esi
        lock cmpxchg      dword ptr [rdi], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        mov               eax, esi
        lock cmpxchg      dword ptr [rdi], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::release_acquire:
        mov               eax, esi
        lock cmpxchg      dword ptr [rdi], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::release_relaxed:
        mov               eax, esi
        lock cmpxchg      dword ptr [rdi], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u64::acqrel_seqcst:
        mov               rax, rsi
        lock cmpxchg      qword ptr [rdi], rdx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u64::seqcst_seqcst:
        mov               rax, rsi
        lock cmpxchg      qword ptr [rdi], rdx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u64::acqrel_acquire:
        mov               rax, rsi
        lock cmpxchg      qword ptr [rdi], rdx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u64::acqrel_relaxed:
        mov               rax, rsi
        lock cmpxchg      qword ptr [rdi], rdx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u64::acquire_seqcst:
        mov               rax, rsi
        lock cmpxchg      qword ptr [rdi], rdx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u64::relaxed_seqcst:
        mov               rax, rsi
        lock cmpxchg      qword ptr [rdi], rdx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u64::release_seqcst:
        mov               rax, rsi
        lock cmpxchg      qword ptr [rdi], rdx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u64::seqcst_acquire:
        mov               rax, rsi
        lock cmpxchg      qword ptr [rdi], rdx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u64::seqcst_relaxed:
        mov               rax, rsi
        lock cmpxchg      qword ptr [rdi], rdx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u64::acquire_acquire:
        mov               rax, rsi
        lock cmpxchg      qword ptr [rdi], rdx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u64::acquire_relaxed:
        mov               rax, rsi
        lock cmpxchg      qword ptr [rdi], rdx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u64::relaxed_acquire:
        mov               rax, rsi
        lock cmpxchg      qword ptr [rdi], rdx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u64::relaxed_relaxed:
        mov               rax, rsi
        lock cmpxchg      qword ptr [rdi], rdx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u64::release_acquire:
        mov               rax, rsi
        lock cmpxchg      qword ptr [rdi], rdx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u64::release_relaxed:
        mov               rax, rsi
        lock cmpxchg      qword ptr [rdi], rdx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u128::acqrel_seqcst:
        mov               r10, rcx
        mov               rax, rdx
        mov               rcx, r9
        mov               rdx, r10
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [rdi + 0x8], rdx
        mov               qword ptr [rdi], rax
        mov               byte ptr [rdi + 0x10], cl
        mov               rax, rdi
        ret

asm_test::compare_exchange_weak::u128::seqcst_seqcst:
        mov               r10, rcx
        mov               rax, rdx
        mov               rcx, r9
        mov               rdx, r10
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [rdi + 0x8], rdx
        mov               qword ptr [rdi], rax
        mov               byte ptr [rdi + 0x10], cl
        mov               rax, rdi
        ret

asm_test::compare_exchange_weak::u128::acqrel_acquire:
        mov               r10, rcx
        mov               rax, rdx
        mov               rcx, r9
        mov               rdx, r10
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [rdi + 0x8], rdx
        mov               qword ptr [rdi], rax
        mov               byte ptr [rdi + 0x10], cl
        mov               rax, rdi
        ret

asm_test::compare_exchange_weak::u128::acqrel_relaxed:
        mov               r10, rcx
        mov               rax, rdx
        mov               rcx, r9
        mov               rdx, r10
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [rdi + 0x8], rdx
        mov               qword ptr [rdi], rax
        mov               byte ptr [rdi + 0x10], cl
        mov               rax, rdi
        ret

asm_test::compare_exchange_weak::u128::acquire_seqcst:
        mov               r10, rcx
        mov               rax, rdx
        mov               rcx, r9
        mov               rdx, r10
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [rdi + 0x8], rdx
        mov               qword ptr [rdi], rax
        mov               byte ptr [rdi + 0x10], cl
        mov               rax, rdi
        ret

asm_test::compare_exchange_weak::u128::relaxed_seqcst:
        mov               r10, rcx
        mov               rax, rdx
        mov               rcx, r9
        mov               rdx, r10
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [rdi + 0x8], rdx
        mov               qword ptr [rdi], rax
        mov               byte ptr [rdi + 0x10], cl
        mov               rax, rdi
        ret

asm_test::compare_exchange_weak::u128::release_seqcst:
        mov               r10, rcx
        mov               rax, rdx
        mov               rcx, r9
        mov               rdx, r10
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [rdi + 0x8], rdx
        mov               qword ptr [rdi], rax
        mov               byte ptr [rdi + 0x10], cl
        mov               rax, rdi
        ret

asm_test::compare_exchange_weak::u128::seqcst_acquire:
        mov               r10, rcx
        mov               rax, rdx
        mov               rcx, r9
        mov               rdx, r10
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [rdi + 0x8], rdx
        mov               qword ptr [rdi], rax
        mov               byte ptr [rdi + 0x10], cl
        mov               rax, rdi
        ret

asm_test::compare_exchange_weak::u128::seqcst_relaxed:
        mov               r10, rcx
        mov               rax, rdx
        mov               rcx, r9
        mov               rdx, r10
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [rdi + 0x8], rdx
        mov               qword ptr [rdi], rax
        mov               byte ptr [rdi + 0x10], cl
        mov               rax, rdi
        ret

asm_test::compare_exchange_weak::u128::acquire_acquire:
        mov               r10, rcx
        mov               rax, rdx
        mov               rcx, r9
        mov               rdx, r10
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [rdi + 0x8], rdx
        mov               qword ptr [rdi], rax
        mov               byte ptr [rdi + 0x10], cl
        mov               rax, rdi
        ret

asm_test::compare_exchange_weak::u128::acquire_relaxed:
        mov               r10, rcx
        mov               rax, rdx
        mov               rcx, r9
        mov               rdx, r10
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [rdi + 0x8], rdx
        mov               qword ptr [rdi], rax
        mov               byte ptr [rdi + 0x10], cl
        mov               rax, rdi
        ret

asm_test::compare_exchange_weak::u128::relaxed_acquire:
        mov               r10, rcx
        mov               rax, rdx
        mov               rcx, r9
        mov               rdx, r10
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [rdi + 0x8], rdx
        mov               qword ptr [rdi], rax
        mov               byte ptr [rdi + 0x10], cl
        mov               rax, rdi
        ret

asm_test::compare_exchange_weak::u128::relaxed_relaxed:
        mov               r10, rcx
        mov               rax, rdx
        mov               rcx, r9
        mov               rdx, r10
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [rdi + 0x8], rdx
        mov               qword ptr [rdi], rax
        mov               byte ptr [rdi + 0x10], cl
        mov               rax, rdi
        ret

asm_test::compare_exchange_weak::u128::release_acquire:
        mov               r10, rcx
        mov               rax, rdx
        mov               rcx, r9
        mov               rdx, r10
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [rdi + 0x8], rdx
        mov               qword ptr [rdi], rax
        mov               byte ptr [rdi + 0x10], cl
        mov               rax, rdi
        ret

asm_test::compare_exchange_weak::u128::release_relaxed:
        mov               r10, rcx
        mov               rax, rdx
        mov               rcx, r9
        mov               rdx, r10
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [rdi + 0x8], rdx
        mov               qword ptr [rdi], rax
        mov               byte ptr [rdi + 0x10], cl
        mov               rax, rdi
        ret

asm_test::load::u8::seqcst:
        movzx             eax, byte ptr [rdi]
        ret

asm_test::load::u8::acquire:
        movzx             eax, byte ptr [rdi]
        ret

asm_test::load::u8::relaxed:
        movzx             eax, byte ptr [rdi]
        ret

asm_test::load::u16::seqcst:
        movzx             eax, word ptr [rdi]
        ret

asm_test::load::u16::acquire:
        movzx             eax, word ptr [rdi]
        ret

asm_test::load::u16::relaxed:
        movzx             eax, word ptr [rdi]
        ret

asm_test::load::u32::seqcst:
        mov               eax, dword ptr [rdi]
        ret

asm_test::load::u32::acquire:
        mov               eax, dword ptr [rdi]
        ret

asm_test::load::u32::relaxed:
        mov               eax, dword ptr [rdi]
        ret

asm_test::load::u64::seqcst:
        mov               rax, qword ptr [rdi]
        ret

asm_test::load::u64::acquire:
        mov               rax, qword ptr [rdi]
        ret

asm_test::load::u64::relaxed:
        mov               rax, qword ptr [rdi]
        ret

asm_test::load::u128::seqcst:
        xor               ecx, ecx
        xor               eax, eax
        xor               edx, edx
        mov               rsi, rbx
        xor               rbx, rbx
        lock cmpxchg16b   xmmword ptr [rdi]
        mov               rbx, rsi
        ret

asm_test::load::u128::acquire:
        xor               ecx, ecx
        xor               eax, eax
        xor               edx, edx
        mov               rsi, rbx
        xor               rbx, rbx
        lock cmpxchg16b   xmmword ptr [rdi]
        mov               rbx, rsi
        ret

asm_test::load::u128::relaxed:
        xor               ecx, ecx
        xor               eax, eax
        xor               edx, edx
        mov               rsi, rbx
        xor               rbx, rbx
        lock cmpxchg16b   xmmword ptr [rdi]
        mov               rbx, rsi
        ret

asm_test::swap::u8::acqrel:
        mov               eax, esi
        xchg              byte ptr [rdi], al
        ret

asm_test::swap::u8::seqcst:
        mov               eax, esi
        xchg              byte ptr [rdi], al
        ret

asm_test::swap::u8::acquire:
        mov               eax, esi
        xchg              byte ptr [rdi], al
        ret

asm_test::swap::u8::relaxed:
        mov               eax, esi
        xchg              byte ptr [rdi], al
        ret

asm_test::swap::u8::release:
        mov               eax, esi
        xchg              byte ptr [rdi], al
        ret

asm_test::swap::u16::acqrel:
        mov               eax, esi
        xchg              word ptr [rdi], ax
        ret

asm_test::swap::u16::seqcst:
        mov               eax, esi
        xchg              word ptr [rdi], ax
        ret

asm_test::swap::u16::acquire:
        mov               eax, esi
        xchg              word ptr [rdi], ax
        ret

asm_test::swap::u16::relaxed:
        mov               eax, esi
        xchg              word ptr [rdi], ax
        ret

asm_test::swap::u16::release:
        mov               eax, esi
        xchg              word ptr [rdi], ax
        ret

asm_test::swap::u32::acqrel:
        mov               eax, esi
        xchg              dword ptr [rdi], eax
        ret

asm_test::swap::u32::seqcst:
        mov               eax, esi
        xchg              dword ptr [rdi], eax
        ret

asm_test::swap::u32::acquire:
        mov               eax, esi
        xchg              dword ptr [rdi], eax
        ret

asm_test::swap::u32::relaxed:
        mov               eax, esi
        xchg              dword ptr [rdi], eax
        ret

asm_test::swap::u32::release:
        mov               eax, esi
        xchg              dword ptr [rdi], eax
        ret

asm_test::swap::u64::acqrel:
        mov               rax, rsi
        xchg              qword ptr [rdi], rax
        ret

asm_test::swap::u64::seqcst:
        mov               rax, rsi
        xchg              qword ptr [rdi], rax
        ret

asm_test::swap::u64::acquire:
        mov               rax, rsi
        xchg              qword ptr [rdi], rax
        ret

asm_test::swap::u64::relaxed:
        mov               rax, rsi
        xchg              qword ptr [rdi], rax
        ret

asm_test::swap::u64::release:
        mov               rax, rsi
        xchg              qword ptr [rdi], rax
        ret

asm_test::swap::u128::acqrel:
        mov               rcx, rdx
        xchg              rsi, rbx
        mov               rax, qword ptr [rdi]
        mov               rdx, qword ptr [rdi + 0x8]
0:
        lock cmpxchg16b   xmmword ptr [rdi]
        jne               0b
        mov               rbx, rsi
        ret

asm_test::swap::u128::seqcst:
        mov               rcx, rdx
        xchg              rsi, rbx
        mov               rax, qword ptr [rdi]
        mov               rdx, qword ptr [rdi + 0x8]
0:
        lock cmpxchg16b   xmmword ptr [rdi]
        jne               0b
        mov               rbx, rsi
        ret

asm_test::swap::u128::acquire:
        mov               rcx, rdx
        xchg              rsi, rbx
        mov               rax, qword ptr [rdi]
        mov               rdx, qword ptr [rdi + 0x8]
0:
        lock cmpxchg16b   xmmword ptr [rdi]
        jne               0b
        mov               rbx, rsi
        ret

asm_test::swap::u128::relaxed:
        mov               rcx, rdx
        xchg              rsi, rbx
        mov               rax, qword ptr [rdi]
        mov               rdx, qword ptr [rdi + 0x8]
0:
        lock cmpxchg16b   xmmword ptr [rdi]
        jne               0b
        mov               rbx, rsi
        ret

asm_test::swap::u128::release:
        mov               rcx, rdx
        xchg              rsi, rbx
        mov               rax, qword ptr [rdi]
        mov               rdx, qword ptr [rdi + 0x8]
0:
        lock cmpxchg16b   xmmword ptr [rdi]
        jne               0b
        mov               rbx, rsi
        ret

asm_test::store::u8::seqcst:
        xchg              byte ptr [rdi], sil
        ret

asm_test::store::u8::relaxed:
        mov               byte ptr [rdi], sil
        ret

asm_test::store::u8::release:
        mov               byte ptr [rdi], sil
        ret

asm_test::store::u16::seqcst:
        xchg              word ptr [rdi], si
        ret

asm_test::store::u16::relaxed:
        mov               word ptr [rdi], si
        ret

asm_test::store::u16::release:
        mov               word ptr [rdi], si
        ret

asm_test::store::u32::seqcst:
        xchg              dword ptr [rdi], esi
        ret

asm_test::store::u32::relaxed:
        mov               dword ptr [rdi], esi
        ret

asm_test::store::u32::release:
        mov               dword ptr [rdi], esi
        ret

asm_test::store::u64::seqcst:
        xchg              qword ptr [rdi], rsi
        ret

asm_test::store::u64::relaxed:
        mov               qword ptr [rdi], rsi
        ret

asm_test::store::u64::release:
        mov               qword ptr [rdi], rsi
        ret

asm_test::store::u128::seqcst:
        mov               rcx, rdx
        xchg              rsi, rbx
        mov               rax, qword ptr [rdi]
        mov               rdx, qword ptr [rdi + 0x8]
0:
        lock cmpxchg16b   xmmword ptr [rdi]
        jne               0b
        mov               rbx, rsi
        ret

asm_test::store::u128::relaxed:
        mov               rcx, rdx
        xchg              rsi, rbx
        mov               rax, qword ptr [rdi]
        mov               rdx, qword ptr [rdi + 0x8]
0:
        lock cmpxchg16b   xmmword ptr [rdi]
        jne               0b
        mov               rbx, rsi
        ret

asm_test::store::u128::release:
        mov               rcx, rdx
        xchg              rsi, rbx
        mov               rax, qword ptr [rdi]
        mov               rdx, qword ptr [rdi + 0x8]
0:
        lock cmpxchg16b   xmmword ptr [rdi]
        jne               0b
        mov               rbx, rsi
        ret

