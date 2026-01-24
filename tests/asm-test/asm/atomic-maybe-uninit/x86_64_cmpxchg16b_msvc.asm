asm_test::compare_exchange::u8::acqrel_seqcst:
        mov               eax, edx
        movzx             edx, r8b
        lock cmpxchg      byte ptr [rcx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u8::seqcst_seqcst:
        mov               eax, edx
        movzx             edx, r8b
        lock cmpxchg      byte ptr [rcx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u8::acqrel_acquire:
        mov               eax, edx
        movzx             edx, r8b
        lock cmpxchg      byte ptr [rcx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u8::acqrel_relaxed:
        mov               eax, edx
        movzx             edx, r8b
        lock cmpxchg      byte ptr [rcx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u8::acquire_seqcst:
        mov               eax, edx
        movzx             edx, r8b
        lock cmpxchg      byte ptr [rcx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u8::relaxed_seqcst:
        mov               eax, edx
        movzx             edx, r8b
        lock cmpxchg      byte ptr [rcx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u8::release_seqcst:
        mov               eax, edx
        movzx             edx, r8b
        lock cmpxchg      byte ptr [rcx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u8::seqcst_acquire:
        mov               eax, edx
        movzx             edx, r8b
        lock cmpxchg      byte ptr [rcx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u8::seqcst_relaxed:
        mov               eax, edx
        movzx             edx, r8b
        lock cmpxchg      byte ptr [rcx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u8::acquire_acquire:
        mov               eax, edx
        movzx             edx, r8b
        lock cmpxchg      byte ptr [rcx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u8::acquire_relaxed:
        mov               eax, edx
        movzx             edx, r8b
        lock cmpxchg      byte ptr [rcx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u8::relaxed_acquire:
        mov               eax, edx
        movzx             edx, r8b
        lock cmpxchg      byte ptr [rcx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u8::relaxed_relaxed:
        mov               eax, edx
        movzx             edx, r8b
        lock cmpxchg      byte ptr [rcx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u8::release_acquire:
        mov               eax, edx
        movzx             edx, r8b
        lock cmpxchg      byte ptr [rcx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u8::release_relaxed:
        mov               eax, edx
        movzx             edx, r8b
        lock cmpxchg      byte ptr [rcx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::acqrel_seqcst:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::seqcst_seqcst:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::acqrel_acquire:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::acqrel_relaxed:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::acquire_seqcst:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::relaxed_seqcst:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::release_seqcst:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::seqcst_acquire:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::seqcst_relaxed:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::acquire_acquire:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::acquire_relaxed:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::relaxed_acquire:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::relaxed_relaxed:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::release_acquire:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::release_relaxed:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::acqrel_seqcst:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::seqcst_seqcst:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::acqrel_acquire:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::acqrel_relaxed:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::acquire_seqcst:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::relaxed_seqcst:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::release_seqcst:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::seqcst_acquire:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::seqcst_relaxed:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::acquire_acquire:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::acquire_relaxed:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::relaxed_acquire:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::relaxed_relaxed:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::release_acquire:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::release_relaxed:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u64::acqrel_seqcst:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u64::seqcst_seqcst:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u64::acqrel_acquire:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u64::acqrel_relaxed:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u64::acquire_seqcst:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u64::relaxed_seqcst:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u64::release_seqcst:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u64::seqcst_acquire:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u64::seqcst_relaxed:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u64::acquire_acquire:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u64::acquire_relaxed:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u64::relaxed_acquire:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u64::relaxed_relaxed:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u64::release_acquire:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u64::release_relaxed:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u128::acqrel_seqcst:
        push              rsi
        mov               rax, r8
        mov               r10, rcx
        mov               r8, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rsi, rdx
        mov               rdx, r9
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [r10 + 0x8], rdx
        mov               qword ptr [r10], rax
        mov               byte ptr [r10 + 0x10], cl
        mov               rax, r10
        pop               rsi
        ret

asm_test::compare_exchange::u128::seqcst_seqcst:
        push              rsi
        mov               rax, r8
        mov               r10, rcx
        mov               r8, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rsi, rdx
        mov               rdx, r9
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [r10 + 0x8], rdx
        mov               qword ptr [r10], rax
        mov               byte ptr [r10 + 0x10], cl
        mov               rax, r10
        pop               rsi
        ret

asm_test::compare_exchange::u128::acqrel_acquire:
        push              rsi
        mov               rax, r8
        mov               r10, rcx
        mov               r8, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rsi, rdx
        mov               rdx, r9
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [r10 + 0x8], rdx
        mov               qword ptr [r10], rax
        mov               byte ptr [r10 + 0x10], cl
        mov               rax, r10
        pop               rsi
        ret

asm_test::compare_exchange::u128::acqrel_relaxed:
        push              rsi
        mov               rax, r8
        mov               r10, rcx
        mov               r8, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rsi, rdx
        mov               rdx, r9
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [r10 + 0x8], rdx
        mov               qword ptr [r10], rax
        mov               byte ptr [r10 + 0x10], cl
        mov               rax, r10
        pop               rsi
        ret

asm_test::compare_exchange::u128::acquire_seqcst:
        push              rsi
        mov               rax, r8
        mov               r10, rcx
        mov               r8, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rsi, rdx
        mov               rdx, r9
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [r10 + 0x8], rdx
        mov               qword ptr [r10], rax
        mov               byte ptr [r10 + 0x10], cl
        mov               rax, r10
        pop               rsi
        ret

asm_test::compare_exchange::u128::relaxed_seqcst:
        push              rsi
        mov               rax, r8
        mov               r10, rcx
        mov               r8, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rsi, rdx
        mov               rdx, r9
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [r10 + 0x8], rdx
        mov               qword ptr [r10], rax
        mov               byte ptr [r10 + 0x10], cl
        mov               rax, r10
        pop               rsi
        ret

asm_test::compare_exchange::u128::release_seqcst:
        push              rsi
        mov               rax, r8
        mov               r10, rcx
        mov               r8, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rsi, rdx
        mov               rdx, r9
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [r10 + 0x8], rdx
        mov               qword ptr [r10], rax
        mov               byte ptr [r10 + 0x10], cl
        mov               rax, r10
        pop               rsi
        ret

asm_test::compare_exchange::u128::seqcst_acquire:
        push              rsi
        mov               rax, r8
        mov               r10, rcx
        mov               r8, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rsi, rdx
        mov               rdx, r9
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [r10 + 0x8], rdx
        mov               qword ptr [r10], rax
        mov               byte ptr [r10 + 0x10], cl
        mov               rax, r10
        pop               rsi
        ret

asm_test::compare_exchange::u128::seqcst_relaxed:
        push              rsi
        mov               rax, r8
        mov               r10, rcx
        mov               r8, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rsi, rdx
        mov               rdx, r9
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [r10 + 0x8], rdx
        mov               qword ptr [r10], rax
        mov               byte ptr [r10 + 0x10], cl
        mov               rax, r10
        pop               rsi
        ret

asm_test::compare_exchange::u128::acquire_acquire:
        push              rsi
        mov               rax, r8
        mov               r10, rcx
        mov               r8, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rsi, rdx
        mov               rdx, r9
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [r10 + 0x8], rdx
        mov               qword ptr [r10], rax
        mov               byte ptr [r10 + 0x10], cl
        mov               rax, r10
        pop               rsi
        ret

asm_test::compare_exchange::u128::acquire_relaxed:
        push              rsi
        mov               rax, r8
        mov               r10, rcx
        mov               r8, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rsi, rdx
        mov               rdx, r9
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [r10 + 0x8], rdx
        mov               qword ptr [r10], rax
        mov               byte ptr [r10 + 0x10], cl
        mov               rax, r10
        pop               rsi
        ret

asm_test::compare_exchange::u128::relaxed_acquire:
        push              rsi
        mov               rax, r8
        mov               r10, rcx
        mov               r8, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rsi, rdx
        mov               rdx, r9
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [r10 + 0x8], rdx
        mov               qword ptr [r10], rax
        mov               byte ptr [r10 + 0x10], cl
        mov               rax, r10
        pop               rsi
        ret

asm_test::compare_exchange::u128::relaxed_relaxed:
        push              rsi
        mov               rax, r8
        mov               r10, rcx
        mov               r8, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rsi, rdx
        mov               rdx, r9
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [r10 + 0x8], rdx
        mov               qword ptr [r10], rax
        mov               byte ptr [r10 + 0x10], cl
        mov               rax, r10
        pop               rsi
        ret

asm_test::compare_exchange::u128::release_acquire:
        push              rsi
        mov               rax, r8
        mov               r10, rcx
        mov               r8, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rsi, rdx
        mov               rdx, r9
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [r10 + 0x8], rdx
        mov               qword ptr [r10], rax
        mov               byte ptr [r10 + 0x10], cl
        mov               rax, r10
        pop               rsi
        ret

asm_test::compare_exchange::u128::release_relaxed:
        push              rsi
        mov               rax, r8
        mov               r10, rcx
        mov               r8, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rsi, rdx
        mov               rdx, r9
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [r10 + 0x8], rdx
        mov               qword ptr [r10], rax
        mov               byte ptr [r10 + 0x10], cl
        mov               rax, r10
        pop               rsi
        ret

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        mov               eax, edx
        movzx             edx, r8b
        lock cmpxchg      byte ptr [rcx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        mov               eax, edx
        movzx             edx, r8b
        lock cmpxchg      byte ptr [rcx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        mov               eax, edx
        movzx             edx, r8b
        lock cmpxchg      byte ptr [rcx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        mov               eax, edx
        movzx             edx, r8b
        lock cmpxchg      byte ptr [rcx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        mov               eax, edx
        movzx             edx, r8b
        lock cmpxchg      byte ptr [rcx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        mov               eax, edx
        movzx             edx, r8b
        lock cmpxchg      byte ptr [rcx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u8::release_seqcst:
        mov               eax, edx
        movzx             edx, r8b
        lock cmpxchg      byte ptr [rcx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        mov               eax, edx
        movzx             edx, r8b
        lock cmpxchg      byte ptr [rcx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        mov               eax, edx
        movzx             edx, r8b
        lock cmpxchg      byte ptr [rcx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u8::acquire_acquire:
        mov               eax, edx
        movzx             edx, r8b
        lock cmpxchg      byte ptr [rcx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        mov               eax, edx
        movzx             edx, r8b
        lock cmpxchg      byte ptr [rcx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        mov               eax, edx
        movzx             edx, r8b
        lock cmpxchg      byte ptr [rcx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        mov               eax, edx
        movzx             edx, r8b
        lock cmpxchg      byte ptr [rcx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u8::release_acquire:
        mov               eax, edx
        movzx             edx, r8b
        lock cmpxchg      byte ptr [rcx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u8::release_relaxed:
        mov               eax, edx
        movzx             edx, r8b
        lock cmpxchg      byte ptr [rcx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::release_seqcst:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::acquire_acquire:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::release_acquire:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::release_relaxed:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::release_seqcst:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::acquire_acquire:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::release_acquire:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::release_relaxed:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u64::acqrel_seqcst:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u64::seqcst_seqcst:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u64::acqrel_acquire:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u64::acqrel_relaxed:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u64::acquire_seqcst:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u64::relaxed_seqcst:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u64::release_seqcst:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u64::seqcst_acquire:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u64::seqcst_relaxed:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u64::acquire_acquire:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u64::acquire_relaxed:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u64::relaxed_acquire:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u64::relaxed_relaxed:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u64::release_acquire:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u64::release_relaxed:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u128::acqrel_seqcst:
        push              rsi
        mov               rax, r8
        mov               r10, rcx
        mov               r8, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rsi, rdx
        mov               rdx, r9
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [r10 + 0x8], rdx
        mov               qword ptr [r10], rax
        mov               byte ptr [r10 + 0x10], cl
        mov               rax, r10
        pop               rsi
        ret

asm_test::compare_exchange_weak::u128::seqcst_seqcst:
        push              rsi
        mov               rax, r8
        mov               r10, rcx
        mov               r8, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rsi, rdx
        mov               rdx, r9
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [r10 + 0x8], rdx
        mov               qword ptr [r10], rax
        mov               byte ptr [r10 + 0x10], cl
        mov               rax, r10
        pop               rsi
        ret

asm_test::compare_exchange_weak::u128::acqrel_acquire:
        push              rsi
        mov               rax, r8
        mov               r10, rcx
        mov               r8, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rsi, rdx
        mov               rdx, r9
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [r10 + 0x8], rdx
        mov               qword ptr [r10], rax
        mov               byte ptr [r10 + 0x10], cl
        mov               rax, r10
        pop               rsi
        ret

asm_test::compare_exchange_weak::u128::acqrel_relaxed:
        push              rsi
        mov               rax, r8
        mov               r10, rcx
        mov               r8, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rsi, rdx
        mov               rdx, r9
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [r10 + 0x8], rdx
        mov               qword ptr [r10], rax
        mov               byte ptr [r10 + 0x10], cl
        mov               rax, r10
        pop               rsi
        ret

asm_test::compare_exchange_weak::u128::acquire_seqcst:
        push              rsi
        mov               rax, r8
        mov               r10, rcx
        mov               r8, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rsi, rdx
        mov               rdx, r9
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [r10 + 0x8], rdx
        mov               qword ptr [r10], rax
        mov               byte ptr [r10 + 0x10], cl
        mov               rax, r10
        pop               rsi
        ret

asm_test::compare_exchange_weak::u128::relaxed_seqcst:
        push              rsi
        mov               rax, r8
        mov               r10, rcx
        mov               r8, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rsi, rdx
        mov               rdx, r9
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [r10 + 0x8], rdx
        mov               qword ptr [r10], rax
        mov               byte ptr [r10 + 0x10], cl
        mov               rax, r10
        pop               rsi
        ret

asm_test::compare_exchange_weak::u128::release_seqcst:
        push              rsi
        mov               rax, r8
        mov               r10, rcx
        mov               r8, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rsi, rdx
        mov               rdx, r9
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [r10 + 0x8], rdx
        mov               qword ptr [r10], rax
        mov               byte ptr [r10 + 0x10], cl
        mov               rax, r10
        pop               rsi
        ret

asm_test::compare_exchange_weak::u128::seqcst_acquire:
        push              rsi
        mov               rax, r8
        mov               r10, rcx
        mov               r8, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rsi, rdx
        mov               rdx, r9
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [r10 + 0x8], rdx
        mov               qword ptr [r10], rax
        mov               byte ptr [r10 + 0x10], cl
        mov               rax, r10
        pop               rsi
        ret

asm_test::compare_exchange_weak::u128::seqcst_relaxed:
        push              rsi
        mov               rax, r8
        mov               r10, rcx
        mov               r8, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rsi, rdx
        mov               rdx, r9
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [r10 + 0x8], rdx
        mov               qword ptr [r10], rax
        mov               byte ptr [r10 + 0x10], cl
        mov               rax, r10
        pop               rsi
        ret

asm_test::compare_exchange_weak::u128::acquire_acquire:
        push              rsi
        mov               rax, r8
        mov               r10, rcx
        mov               r8, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rsi, rdx
        mov               rdx, r9
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [r10 + 0x8], rdx
        mov               qword ptr [r10], rax
        mov               byte ptr [r10 + 0x10], cl
        mov               rax, r10
        pop               rsi
        ret

asm_test::compare_exchange_weak::u128::acquire_relaxed:
        push              rsi
        mov               rax, r8
        mov               r10, rcx
        mov               r8, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rsi, rdx
        mov               rdx, r9
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [r10 + 0x8], rdx
        mov               qword ptr [r10], rax
        mov               byte ptr [r10 + 0x10], cl
        mov               rax, r10
        pop               rsi
        ret

asm_test::compare_exchange_weak::u128::relaxed_acquire:
        push              rsi
        mov               rax, r8
        mov               r10, rcx
        mov               r8, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rsi, rdx
        mov               rdx, r9
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [r10 + 0x8], rdx
        mov               qword ptr [r10], rax
        mov               byte ptr [r10 + 0x10], cl
        mov               rax, r10
        pop               rsi
        ret

asm_test::compare_exchange_weak::u128::relaxed_relaxed:
        push              rsi
        mov               rax, r8
        mov               r10, rcx
        mov               r8, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rsi, rdx
        mov               rdx, r9
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [r10 + 0x8], rdx
        mov               qword ptr [r10], rax
        mov               byte ptr [r10 + 0x10], cl
        mov               rax, r10
        pop               rsi
        ret

asm_test::compare_exchange_weak::u128::release_acquire:
        push              rsi
        mov               rax, r8
        mov               r10, rcx
        mov               r8, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rsi, rdx
        mov               rdx, r9
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [r10 + 0x8], rdx
        mov               qword ptr [r10], rax
        mov               byte ptr [r10 + 0x10], cl
        mov               rax, r10
        pop               rsi
        ret

asm_test::compare_exchange_weak::u128::release_relaxed:
        push              rsi
        mov               rax, r8
        mov               r10, rcx
        mov               r8, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rsi, rdx
        mov               rdx, r9
        xchg              r8, rbx
        lock cmpxchg16b   xmmword ptr [rsi]
        sete              cl
        mov               rbx, r8
        mov               qword ptr [r10 + 0x8], rdx
        mov               qword ptr [r10], rax
        mov               byte ptr [r10 + 0x10], cl
        mov               rax, r10
        pop               rsi
        ret

asm_test::load::u8::seqcst:
        movzx             eax, byte ptr [rcx]
        ret

asm_test::load::u8::acquire:
        movzx             eax, byte ptr [rcx]
        ret

asm_test::load::u8::relaxed:
        movzx             eax, byte ptr [rcx]
        ret

asm_test::load::u16::seqcst:
        movzx             eax, word ptr [rcx]
        ret

asm_test::load::u16::acquire:
        movzx             eax, word ptr [rcx]
        ret

asm_test::load::u16::relaxed:
        movzx             eax, word ptr [rcx]
        ret

asm_test::load::u32::seqcst:
        mov               eax, dword ptr [rcx]
        ret

asm_test::load::u32::acquire:
        mov               eax, dword ptr [rcx]
        ret

asm_test::load::u32::relaxed:
        mov               eax, dword ptr [rcx]
        ret

asm_test::load::u64::seqcst:
        mov               rax, qword ptr [rcx]
        ret

asm_test::load::u64::acquire:
        mov               rax, qword ptr [rcx]
        ret

asm_test::load::u64::relaxed:
        mov               rax, qword ptr [rcx]
        ret

asm_test::load::u128::seqcst:
        push              rsi
        push              rdi
        mov               rdi, rcx
        xor               ecx, ecx
        xor               eax, eax
        xor               edx, edx
        mov               rsi, rbx
        xor               rbx, rbx
        lock cmpxchg16b   xmmword ptr [rdi]
        mov               rbx, rsi
        pop               rdi
        pop               rsi
        ret

asm_test::load::u128::acquire:
        push              rsi
        push              rdi
        mov               rdi, rcx
        xor               ecx, ecx
        xor               eax, eax
        xor               edx, edx
        mov               rsi, rbx
        xor               rbx, rbx
        lock cmpxchg16b   xmmword ptr [rdi]
        mov               rbx, rsi
        pop               rdi
        pop               rsi
        ret

asm_test::load::u128::relaxed:
        push              rsi
        push              rdi
        mov               rdi, rcx
        xor               ecx, ecx
        xor               eax, eax
        xor               edx, edx
        mov               rsi, rbx
        xor               rbx, rbx
        lock cmpxchg16b   xmmword ptr [rdi]
        mov               rbx, rsi
        pop               rdi
        pop               rsi
        ret

asm_test::swap::u8::acqrel:
        mov               eax, edx
        xchg              byte ptr [rcx], al
        ret

asm_test::swap::u8::seqcst:
        mov               eax, edx
        xchg              byte ptr [rcx], al
        ret

asm_test::swap::u8::acquire:
        mov               eax, edx
        xchg              byte ptr [rcx], al
        ret

asm_test::swap::u8::relaxed:
        mov               eax, edx
        xchg              byte ptr [rcx], al
        ret

asm_test::swap::u8::release:
        mov               eax, edx
        xchg              byte ptr [rcx], al
        ret

asm_test::swap::u16::acqrel:
        mov               eax, edx
        xchg              word ptr [rcx], ax
        ret

asm_test::swap::u16::seqcst:
        mov               eax, edx
        xchg              word ptr [rcx], ax
        ret

asm_test::swap::u16::acquire:
        mov               eax, edx
        xchg              word ptr [rcx], ax
        ret

asm_test::swap::u16::relaxed:
        mov               eax, edx
        xchg              word ptr [rcx], ax
        ret

asm_test::swap::u16::release:
        mov               eax, edx
        xchg              word ptr [rcx], ax
        ret

asm_test::swap::u32::acqrel:
        mov               eax, edx
        xchg              dword ptr [rcx], eax
        ret

asm_test::swap::u32::seqcst:
        mov               eax, edx
        xchg              dword ptr [rcx], eax
        ret

asm_test::swap::u32::acquire:
        mov               eax, edx
        xchg              dword ptr [rcx], eax
        ret

asm_test::swap::u32::relaxed:
        mov               eax, edx
        xchg              dword ptr [rcx], eax
        ret

asm_test::swap::u32::release:
        mov               eax, edx
        xchg              dword ptr [rcx], eax
        ret

asm_test::swap::u64::acqrel:
        mov               rax, rdx
        xchg              qword ptr [rcx], rax
        ret

asm_test::swap::u64::seqcst:
        mov               rax, rdx
        xchg              qword ptr [rcx], rax
        ret

asm_test::swap::u64::acquire:
        mov               rax, rdx
        xchg              qword ptr [rcx], rax
        ret

asm_test::swap::u64::relaxed:
        mov               rax, rdx
        xchg              qword ptr [rcx], rax
        ret

asm_test::swap::u64::release:
        mov               rax, rdx
        xchg              qword ptr [rcx], rax
        ret

asm_test::swap::u128::acqrel:
        push              rsi
        push              rdi
        mov               rdi, rcx
        mov               rcx, r8
        mov               rsi, rdx
        xchg              rsi, rbx
        mov               rax, qword ptr [rdi]
        mov               rdx, qword ptr [rdi + 0x8]
0:
        lock cmpxchg16b   xmmword ptr [rdi]
        jne               0b
        mov               rbx, rsi
        pop               rdi
        pop               rsi
        ret

asm_test::swap::u128::seqcst:
        push              rsi
        push              rdi
        mov               rdi, rcx
        mov               rcx, r8
        mov               rsi, rdx
        xchg              rsi, rbx
        mov               rax, qword ptr [rdi]
        mov               rdx, qword ptr [rdi + 0x8]
0:
        lock cmpxchg16b   xmmword ptr [rdi]
        jne               0b
        mov               rbx, rsi
        pop               rdi
        pop               rsi
        ret

asm_test::swap::u128::acquire:
        push              rsi
        push              rdi
        mov               rdi, rcx
        mov               rcx, r8
        mov               rsi, rdx
        xchg              rsi, rbx
        mov               rax, qword ptr [rdi]
        mov               rdx, qword ptr [rdi + 0x8]
0:
        lock cmpxchg16b   xmmword ptr [rdi]
        jne               0b
        mov               rbx, rsi
        pop               rdi
        pop               rsi
        ret

asm_test::swap::u128::relaxed:
        push              rsi
        push              rdi
        mov               rdi, rcx
        mov               rcx, r8
        mov               rsi, rdx
        xchg              rsi, rbx
        mov               rax, qword ptr [rdi]
        mov               rdx, qword ptr [rdi + 0x8]
0:
        lock cmpxchg16b   xmmword ptr [rdi]
        jne               0b
        mov               rbx, rsi
        pop               rdi
        pop               rsi
        ret

asm_test::swap::u128::release:
        push              rsi
        push              rdi
        mov               rdi, rcx
        mov               rcx, r8
        mov               rsi, rdx
        xchg              rsi, rbx
        mov               rax, qword ptr [rdi]
        mov               rdx, qword ptr [rdi + 0x8]
0:
        lock cmpxchg16b   xmmword ptr [rdi]
        jne               0b
        mov               rbx, rsi
        pop               rdi
        pop               rsi
        ret

asm_test::store::u8::seqcst:
        xchg              byte ptr [rcx], dl
        ret

asm_test::store::u8::relaxed:
        mov               byte ptr [rcx], dl
        ret

asm_test::store::u8::release:
        mov               byte ptr [rcx], dl
        ret

asm_test::store::u16::seqcst:
        xchg              word ptr [rcx], dx
        ret

asm_test::store::u16::relaxed:
        mov               word ptr [rcx], dx
        ret

asm_test::store::u16::release:
        mov               word ptr [rcx], dx
        ret

asm_test::store::u32::seqcst:
        xchg              dword ptr [rcx], edx
        ret

asm_test::store::u32::relaxed:
        mov               dword ptr [rcx], edx
        ret

asm_test::store::u32::release:
        mov               dword ptr [rcx], edx
        ret

asm_test::store::u64::seqcst:
        xchg              qword ptr [rcx], rdx
        ret

asm_test::store::u64::relaxed:
        mov               qword ptr [rcx], rdx
        ret

asm_test::store::u64::release:
        mov               qword ptr [rcx], rdx
        ret

asm_test::store::u128::seqcst:
        push              rsi
        push              rdi
        mov               rdi, rcx
        mov               rcx, r8
        mov               rsi, rdx
        xchg              rsi, rbx
        mov               rax, qword ptr [rdi]
        mov               rdx, qword ptr [rdi + 0x8]
0:
        lock cmpxchg16b   xmmword ptr [rdi]
        jne               0b
        mov               rbx, rsi
        pop               rdi
        pop               rsi
        ret

asm_test::store::u128::relaxed:
        push              rsi
        push              rdi
        mov               rdi, rcx
        mov               rcx, r8
        mov               rsi, rdx
        xchg              rsi, rbx
        mov               rax, qword ptr [rdi]
        mov               rdx, qword ptr [rdi + 0x8]
0:
        lock cmpxchg16b   xmmword ptr [rdi]
        jne               0b
        mov               rbx, rsi
        pop               rdi
        pop               rsi
        ret

asm_test::store::u128::release:
        push              rsi
        push              rdi
        mov               rdi, rcx
        mov               rcx, r8
        mov               rsi, rdx
        xchg              rsi, rbx
        mov               rax, qword ptr [rdi]
        mov               rdx, qword ptr [rdi + 0x8]
0:
        lock cmpxchg16b   xmmword ptr [rdi]
        jne               0b
        mov               rbx, rsi
        pop               rdi
        pop               rsi
        ret

