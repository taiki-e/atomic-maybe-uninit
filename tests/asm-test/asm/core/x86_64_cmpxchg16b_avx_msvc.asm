asm_test::compare_exchange::u8::acqrel_seqcst:
        mov               eax, edx
        lock cmpxchg      byte ptr [rcx], r8b
        sete              dl
        ret

asm_test::compare_exchange::u8::seqcst_seqcst:
        mov               eax, edx
        lock cmpxchg      byte ptr [rcx], r8b
        sete              dl
        ret

asm_test::compare_exchange::u8::acqrel_acquire:
        mov               eax, edx
        lock cmpxchg      byte ptr [rcx], r8b
        sete              dl
        ret

asm_test::compare_exchange::u8::acqrel_relaxed:
        mov               eax, edx
        lock cmpxchg      byte ptr [rcx], r8b
        sete              dl
        ret

asm_test::compare_exchange::u8::acquire_seqcst:
        mov               eax, edx
        lock cmpxchg      byte ptr [rcx], r8b
        sete              dl
        ret

asm_test::compare_exchange::u8::relaxed_seqcst:
        mov               eax, edx
        lock cmpxchg      byte ptr [rcx], r8b
        sete              dl
        ret

asm_test::compare_exchange::u8::release_seqcst:
        mov               eax, edx
        lock cmpxchg      byte ptr [rcx], r8b
        sete              dl
        ret

asm_test::compare_exchange::u8::seqcst_acquire:
        mov               eax, edx
        lock cmpxchg      byte ptr [rcx], r8b
        sete              dl
        ret

asm_test::compare_exchange::u8::seqcst_relaxed:
        mov               eax, edx
        lock cmpxchg      byte ptr [rcx], r8b
        sete              dl
        ret

asm_test::compare_exchange::u8::acquire_acquire:
        mov               eax, edx
        lock cmpxchg      byte ptr [rcx], r8b
        sete              dl
        ret

asm_test::compare_exchange::u8::acquire_relaxed:
        mov               eax, edx
        lock cmpxchg      byte ptr [rcx], r8b
        sete              dl
        ret

asm_test::compare_exchange::u8::relaxed_acquire:
        mov               eax, edx
        lock cmpxchg      byte ptr [rcx], r8b
        sete              dl
        ret

asm_test::compare_exchange::u8::relaxed_relaxed:
        mov               eax, edx
        lock cmpxchg      byte ptr [rcx], r8b
        sete              dl
        ret

asm_test::compare_exchange::u8::release_acquire:
        mov               eax, edx
        lock cmpxchg      byte ptr [rcx], r8b
        sete              dl
        ret

asm_test::compare_exchange::u8::release_relaxed:
        mov               eax, edx
        lock cmpxchg      byte ptr [rcx], r8b
        sete              dl
        ret

asm_test::compare_exchange::u16::acqrel_seqcst:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              dl
        ret

asm_test::compare_exchange::u16::seqcst_seqcst:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              dl
        ret

asm_test::compare_exchange::u16::acqrel_acquire:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              dl
        ret

asm_test::compare_exchange::u16::acqrel_relaxed:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              dl
        ret

asm_test::compare_exchange::u16::acquire_seqcst:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              dl
        ret

asm_test::compare_exchange::u16::relaxed_seqcst:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              dl
        ret

asm_test::compare_exchange::u16::release_seqcst:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              dl
        ret

asm_test::compare_exchange::u16::seqcst_acquire:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              dl
        ret

asm_test::compare_exchange::u16::seqcst_relaxed:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              dl
        ret

asm_test::compare_exchange::u16::acquire_acquire:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              dl
        ret

asm_test::compare_exchange::u16::acquire_relaxed:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              dl
        ret

asm_test::compare_exchange::u16::relaxed_acquire:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              dl
        ret

asm_test::compare_exchange::u16::relaxed_relaxed:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              dl
        ret

asm_test::compare_exchange::u16::release_acquire:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              dl
        ret

asm_test::compare_exchange::u16::release_relaxed:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              dl
        ret

asm_test::compare_exchange::u32::acqrel_seqcst:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              dl
        ret

asm_test::compare_exchange::u32::seqcst_seqcst:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              dl
        ret

asm_test::compare_exchange::u32::acqrel_acquire:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              dl
        ret

asm_test::compare_exchange::u32::acqrel_relaxed:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              dl
        ret

asm_test::compare_exchange::u32::acquire_seqcst:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              dl
        ret

asm_test::compare_exchange::u32::relaxed_seqcst:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              dl
        ret

asm_test::compare_exchange::u32::release_seqcst:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              dl
        ret

asm_test::compare_exchange::u32::seqcst_acquire:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              dl
        ret

asm_test::compare_exchange::u32::seqcst_relaxed:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              dl
        ret

asm_test::compare_exchange::u32::acquire_acquire:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              dl
        ret

asm_test::compare_exchange::u32::acquire_relaxed:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              dl
        ret

asm_test::compare_exchange::u32::relaxed_acquire:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              dl
        ret

asm_test::compare_exchange::u32::relaxed_relaxed:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              dl
        ret

asm_test::compare_exchange::u32::release_acquire:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              dl
        ret

asm_test::compare_exchange::u32::release_relaxed:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              dl
        ret

asm_test::compare_exchange::u64::acqrel_seqcst:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              dl
        ret

asm_test::compare_exchange::u64::seqcst_seqcst:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              dl
        ret

asm_test::compare_exchange::u64::acqrel_acquire:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              dl
        ret

asm_test::compare_exchange::u64::acqrel_relaxed:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              dl
        ret

asm_test::compare_exchange::u64::acquire_seqcst:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              dl
        ret

asm_test::compare_exchange::u64::relaxed_seqcst:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              dl
        ret

asm_test::compare_exchange::u64::release_seqcst:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              dl
        ret

asm_test::compare_exchange::u64::seqcst_acquire:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              dl
        ret

asm_test::compare_exchange::u64::seqcst_relaxed:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              dl
        ret

asm_test::compare_exchange::u64::acquire_acquire:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              dl
        ret

asm_test::compare_exchange::u64::acquire_relaxed:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              dl
        ret

asm_test::compare_exchange::u64::relaxed_acquire:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              dl
        ret

asm_test::compare_exchange::u64::relaxed_relaxed:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              dl
        ret

asm_test::compare_exchange::u64::release_acquire:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              dl
        ret

asm_test::compare_exchange::u64::release_relaxed:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              dl
        ret

asm_test::compare_exchange::u128::acqrel_seqcst:
        push              rbx
        mov               rax, r8
        mov               r8, rdx
        mov               r10, rcx
        mov               rbx, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rdx, r9
        lock cmpxchg16b   xmmword ptr [r8]
        mov               qword ptr [r10], rax
        mov               qword ptr [r10 + 0x8], rdx
        sete              byte ptr [r10 + 0x10]
        mov               rax, r10
        pop               rbx
        ret

asm_test::compare_exchange::u128::seqcst_seqcst:
        push              rbx
        mov               rax, r8
        mov               r8, rdx
        mov               r10, rcx
        mov               rbx, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rdx, r9
        lock cmpxchg16b   xmmword ptr [r8]
        mov               qword ptr [r10], rax
        mov               qword ptr [r10 + 0x8], rdx
        sete              byte ptr [r10 + 0x10]
        mov               rax, r10
        pop               rbx
        ret

asm_test::compare_exchange::u128::acqrel_acquire:
        push              rbx
        mov               rax, r8
        mov               r8, rdx
        mov               r10, rcx
        mov               rbx, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rdx, r9
        lock cmpxchg16b   xmmword ptr [r8]
        mov               qword ptr [r10], rax
        mov               qword ptr [r10 + 0x8], rdx
        sete              byte ptr [r10 + 0x10]
        mov               rax, r10
        pop               rbx
        ret

asm_test::compare_exchange::u128::acqrel_relaxed:
        push              rbx
        mov               rax, r8
        mov               r8, rdx
        mov               r10, rcx
        mov               rbx, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rdx, r9
        lock cmpxchg16b   xmmword ptr [r8]
        mov               qword ptr [r10], rax
        mov               qword ptr [r10 + 0x8], rdx
        sete              byte ptr [r10 + 0x10]
        mov               rax, r10
        pop               rbx
        ret

asm_test::compare_exchange::u128::acquire_seqcst:
        push              rbx
        mov               rax, r8
        mov               r8, rdx
        mov               r10, rcx
        mov               rbx, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rdx, r9
        lock cmpxchg16b   xmmword ptr [r8]
        mov               qword ptr [r10], rax
        mov               qword ptr [r10 + 0x8], rdx
        sete              byte ptr [r10 + 0x10]
        mov               rax, r10
        pop               rbx
        ret

asm_test::compare_exchange::u128::relaxed_seqcst:
        push              rbx
        mov               rax, r8
        mov               r8, rdx
        mov               r10, rcx
        mov               rbx, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rdx, r9
        lock cmpxchg16b   xmmword ptr [r8]
        mov               qword ptr [r10], rax
        mov               qword ptr [r10 + 0x8], rdx
        sete              byte ptr [r10 + 0x10]
        mov               rax, r10
        pop               rbx
        ret

asm_test::compare_exchange::u128::release_seqcst:
        push              rbx
        mov               rax, r8
        mov               r8, rdx
        mov               r10, rcx
        mov               rbx, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rdx, r9
        lock cmpxchg16b   xmmword ptr [r8]
        mov               qword ptr [r10], rax
        mov               qword ptr [r10 + 0x8], rdx
        sete              byte ptr [r10 + 0x10]
        mov               rax, r10
        pop               rbx
        ret

asm_test::compare_exchange::u128::seqcst_acquire:
        push              rbx
        mov               rax, r8
        mov               r8, rdx
        mov               r10, rcx
        mov               rbx, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rdx, r9
        lock cmpxchg16b   xmmword ptr [r8]
        mov               qword ptr [r10], rax
        mov               qword ptr [r10 + 0x8], rdx
        sete              byte ptr [r10 + 0x10]
        mov               rax, r10
        pop               rbx
        ret

asm_test::compare_exchange::u128::seqcst_relaxed:
        push              rbx
        mov               rax, r8
        mov               r8, rdx
        mov               r10, rcx
        mov               rbx, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rdx, r9
        lock cmpxchg16b   xmmword ptr [r8]
        mov               qword ptr [r10], rax
        mov               qword ptr [r10 + 0x8], rdx
        sete              byte ptr [r10 + 0x10]
        mov               rax, r10
        pop               rbx
        ret

asm_test::compare_exchange::u128::acquire_acquire:
        push              rbx
        mov               rax, r8
        mov               r8, rdx
        mov               r10, rcx
        mov               rbx, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rdx, r9
        lock cmpxchg16b   xmmword ptr [r8]
        mov               qword ptr [r10], rax
        mov               qword ptr [r10 + 0x8], rdx
        sete              byte ptr [r10 + 0x10]
        mov               rax, r10
        pop               rbx
        ret

asm_test::compare_exchange::u128::acquire_relaxed:
        push              rbx
        mov               rax, r8
        mov               r8, rdx
        mov               r10, rcx
        mov               rbx, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rdx, r9
        lock cmpxchg16b   xmmword ptr [r8]
        mov               qword ptr [r10], rax
        mov               qword ptr [r10 + 0x8], rdx
        sete              byte ptr [r10 + 0x10]
        mov               rax, r10
        pop               rbx
        ret

asm_test::compare_exchange::u128::relaxed_acquire:
        push              rbx
        mov               rax, r8
        mov               r8, rdx
        mov               r10, rcx
        mov               rbx, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rdx, r9
        lock cmpxchg16b   xmmword ptr [r8]
        mov               qword ptr [r10], rax
        mov               qword ptr [r10 + 0x8], rdx
        sete              byte ptr [r10 + 0x10]
        mov               rax, r10
        pop               rbx
        ret

asm_test::compare_exchange::u128::relaxed_relaxed:
        push              rbx
        mov               rax, r8
        mov               r8, rdx
        mov               r10, rcx
        mov               rbx, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rdx, r9
        lock cmpxchg16b   xmmword ptr [r8]
        mov               qword ptr [r10], rax
        mov               qword ptr [r10 + 0x8], rdx
        sete              byte ptr [r10 + 0x10]
        mov               rax, r10
        pop               rbx
        ret

asm_test::compare_exchange::u128::release_acquire:
        push              rbx
        mov               rax, r8
        mov               r8, rdx
        mov               r10, rcx
        mov               rbx, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rdx, r9
        lock cmpxchg16b   xmmword ptr [r8]
        mov               qword ptr [r10], rax
        mov               qword ptr [r10 + 0x8], rdx
        sete              byte ptr [r10 + 0x10]
        mov               rax, r10
        pop               rbx
        ret

asm_test::compare_exchange::u128::release_relaxed:
        push              rbx
        mov               rax, r8
        mov               r8, rdx
        mov               r10, rcx
        mov               rbx, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rdx, r9
        lock cmpxchg16b   xmmword ptr [r8]
        mov               qword ptr [r10], rax
        mov               qword ptr [r10 + 0x8], rdx
        sete              byte ptr [r10 + 0x10]
        mov               rax, r10
        pop               rbx
        ret

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        mov               eax, edx
        lock cmpxchg      byte ptr [rcx], r8b
        sete              dl
        ret

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        mov               eax, edx
        lock cmpxchg      byte ptr [rcx], r8b
        sete              dl
        ret

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        mov               eax, edx
        lock cmpxchg      byte ptr [rcx], r8b
        sete              dl
        ret

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        mov               eax, edx
        lock cmpxchg      byte ptr [rcx], r8b
        sete              dl
        ret

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        mov               eax, edx
        lock cmpxchg      byte ptr [rcx], r8b
        sete              dl
        ret

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        mov               eax, edx
        lock cmpxchg      byte ptr [rcx], r8b
        sete              dl
        ret

asm_test::compare_exchange_weak::u8::release_seqcst:
        mov               eax, edx
        lock cmpxchg      byte ptr [rcx], r8b
        sete              dl
        ret

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        mov               eax, edx
        lock cmpxchg      byte ptr [rcx], r8b
        sete              dl
        ret

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        mov               eax, edx
        lock cmpxchg      byte ptr [rcx], r8b
        sete              dl
        ret

asm_test::compare_exchange_weak::u8::acquire_acquire:
        mov               eax, edx
        lock cmpxchg      byte ptr [rcx], r8b
        sete              dl
        ret

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        mov               eax, edx
        lock cmpxchg      byte ptr [rcx], r8b
        sete              dl
        ret

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        mov               eax, edx
        lock cmpxchg      byte ptr [rcx], r8b
        sete              dl
        ret

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        mov               eax, edx
        lock cmpxchg      byte ptr [rcx], r8b
        sete              dl
        ret

asm_test::compare_exchange_weak::u8::release_acquire:
        mov               eax, edx
        lock cmpxchg      byte ptr [rcx], r8b
        sete              dl
        ret

asm_test::compare_exchange_weak::u8::release_relaxed:
        mov               eax, edx
        lock cmpxchg      byte ptr [rcx], r8b
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::release_seqcst:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::acquire_acquire:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::release_acquire:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::release_relaxed:
        mov               eax, edx
        lock cmpxchg      word ptr [rcx], r8w
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::release_seqcst:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::acquire_acquire:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::release_acquire:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::release_relaxed:
        mov               eax, edx
        lock cmpxchg      dword ptr [rcx], r8d
        sete              dl
        ret

asm_test::compare_exchange_weak::u64::acqrel_seqcst:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              dl
        ret

asm_test::compare_exchange_weak::u64::seqcst_seqcst:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              dl
        ret

asm_test::compare_exchange_weak::u64::acqrel_acquire:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              dl
        ret

asm_test::compare_exchange_weak::u64::acqrel_relaxed:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              dl
        ret

asm_test::compare_exchange_weak::u64::acquire_seqcst:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              dl
        ret

asm_test::compare_exchange_weak::u64::relaxed_seqcst:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              dl
        ret

asm_test::compare_exchange_weak::u64::release_seqcst:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              dl
        ret

asm_test::compare_exchange_weak::u64::seqcst_acquire:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              dl
        ret

asm_test::compare_exchange_weak::u64::seqcst_relaxed:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              dl
        ret

asm_test::compare_exchange_weak::u64::acquire_acquire:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              dl
        ret

asm_test::compare_exchange_weak::u64::acquire_relaxed:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              dl
        ret

asm_test::compare_exchange_weak::u64::relaxed_acquire:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              dl
        ret

asm_test::compare_exchange_weak::u64::relaxed_relaxed:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              dl
        ret

asm_test::compare_exchange_weak::u64::release_acquire:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              dl
        ret

asm_test::compare_exchange_weak::u64::release_relaxed:
        mov               rax, rdx
        lock cmpxchg      qword ptr [rcx], r8
        sete              dl
        ret

asm_test::compare_exchange_weak::u128::acqrel_seqcst:
        push              rbx
        mov               rax, r8
        mov               r8, rdx
        mov               r10, rcx
        mov               rbx, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rdx, r9
        lock cmpxchg16b   xmmword ptr [r8]
        mov               qword ptr [r10], rax
        mov               qword ptr [r10 + 0x8], rdx
        sete              byte ptr [r10 + 0x10]
        mov               rax, r10
        pop               rbx
        ret

asm_test::compare_exchange_weak::u128::seqcst_seqcst:
        push              rbx
        mov               rax, r8
        mov               r8, rdx
        mov               r10, rcx
        mov               rbx, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rdx, r9
        lock cmpxchg16b   xmmword ptr [r8]
        mov               qword ptr [r10], rax
        mov               qword ptr [r10 + 0x8], rdx
        sete              byte ptr [r10 + 0x10]
        mov               rax, r10
        pop               rbx
        ret

asm_test::compare_exchange_weak::u128::acqrel_acquire:
        push              rbx
        mov               rax, r8
        mov               r8, rdx
        mov               r10, rcx
        mov               rbx, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rdx, r9
        lock cmpxchg16b   xmmword ptr [r8]
        mov               qword ptr [r10], rax
        mov               qword ptr [r10 + 0x8], rdx
        sete              byte ptr [r10 + 0x10]
        mov               rax, r10
        pop               rbx
        ret

asm_test::compare_exchange_weak::u128::acqrel_relaxed:
        push              rbx
        mov               rax, r8
        mov               r8, rdx
        mov               r10, rcx
        mov               rbx, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rdx, r9
        lock cmpxchg16b   xmmword ptr [r8]
        mov               qword ptr [r10], rax
        mov               qword ptr [r10 + 0x8], rdx
        sete              byte ptr [r10 + 0x10]
        mov               rax, r10
        pop               rbx
        ret

asm_test::compare_exchange_weak::u128::acquire_seqcst:
        push              rbx
        mov               rax, r8
        mov               r8, rdx
        mov               r10, rcx
        mov               rbx, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rdx, r9
        lock cmpxchg16b   xmmword ptr [r8]
        mov               qword ptr [r10], rax
        mov               qword ptr [r10 + 0x8], rdx
        sete              byte ptr [r10 + 0x10]
        mov               rax, r10
        pop               rbx
        ret

asm_test::compare_exchange_weak::u128::relaxed_seqcst:
        push              rbx
        mov               rax, r8
        mov               r8, rdx
        mov               r10, rcx
        mov               rbx, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rdx, r9
        lock cmpxchg16b   xmmword ptr [r8]
        mov               qword ptr [r10], rax
        mov               qword ptr [r10 + 0x8], rdx
        sete              byte ptr [r10 + 0x10]
        mov               rax, r10
        pop               rbx
        ret

asm_test::compare_exchange_weak::u128::release_seqcst:
        push              rbx
        mov               rax, r8
        mov               r8, rdx
        mov               r10, rcx
        mov               rbx, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rdx, r9
        lock cmpxchg16b   xmmword ptr [r8]
        mov               qword ptr [r10], rax
        mov               qword ptr [r10 + 0x8], rdx
        sete              byte ptr [r10 + 0x10]
        mov               rax, r10
        pop               rbx
        ret

asm_test::compare_exchange_weak::u128::seqcst_acquire:
        push              rbx
        mov               rax, r8
        mov               r8, rdx
        mov               r10, rcx
        mov               rbx, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rdx, r9
        lock cmpxchg16b   xmmword ptr [r8]
        mov               qword ptr [r10], rax
        mov               qword ptr [r10 + 0x8], rdx
        sete              byte ptr [r10 + 0x10]
        mov               rax, r10
        pop               rbx
        ret

asm_test::compare_exchange_weak::u128::seqcst_relaxed:
        push              rbx
        mov               rax, r8
        mov               r8, rdx
        mov               r10, rcx
        mov               rbx, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rdx, r9
        lock cmpxchg16b   xmmword ptr [r8]
        mov               qword ptr [r10], rax
        mov               qword ptr [r10 + 0x8], rdx
        sete              byte ptr [r10 + 0x10]
        mov               rax, r10
        pop               rbx
        ret

asm_test::compare_exchange_weak::u128::acquire_acquire:
        push              rbx
        mov               rax, r8
        mov               r8, rdx
        mov               r10, rcx
        mov               rbx, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rdx, r9
        lock cmpxchg16b   xmmword ptr [r8]
        mov               qword ptr [r10], rax
        mov               qword ptr [r10 + 0x8], rdx
        sete              byte ptr [r10 + 0x10]
        mov               rax, r10
        pop               rbx
        ret

asm_test::compare_exchange_weak::u128::acquire_relaxed:
        push              rbx
        mov               rax, r8
        mov               r8, rdx
        mov               r10, rcx
        mov               rbx, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rdx, r9
        lock cmpxchg16b   xmmword ptr [r8]
        mov               qword ptr [r10], rax
        mov               qword ptr [r10 + 0x8], rdx
        sete              byte ptr [r10 + 0x10]
        mov               rax, r10
        pop               rbx
        ret

asm_test::compare_exchange_weak::u128::relaxed_acquire:
        push              rbx
        mov               rax, r8
        mov               r8, rdx
        mov               r10, rcx
        mov               rbx, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rdx, r9
        lock cmpxchg16b   xmmword ptr [r8]
        mov               qword ptr [r10], rax
        mov               qword ptr [r10 + 0x8], rdx
        sete              byte ptr [r10 + 0x10]
        mov               rax, r10
        pop               rbx
        ret

asm_test::compare_exchange_weak::u128::relaxed_relaxed:
        push              rbx
        mov               rax, r8
        mov               r8, rdx
        mov               r10, rcx
        mov               rbx, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rdx, r9
        lock cmpxchg16b   xmmword ptr [r8]
        mov               qword ptr [r10], rax
        mov               qword ptr [r10 + 0x8], rdx
        sete              byte ptr [r10 + 0x10]
        mov               rax, r10
        pop               rbx
        ret

asm_test::compare_exchange_weak::u128::release_acquire:
        push              rbx
        mov               rax, r8
        mov               r8, rdx
        mov               r10, rcx
        mov               rbx, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rdx, r9
        lock cmpxchg16b   xmmword ptr [r8]
        mov               qword ptr [r10], rax
        mov               qword ptr [r10 + 0x8], rdx
        sete              byte ptr [r10 + 0x10]
        mov               rax, r10
        pop               rbx
        ret

asm_test::compare_exchange_weak::u128::release_relaxed:
        push              rbx
        mov               rax, r8
        mov               r8, rdx
        mov               r10, rcx
        mov               rbx, qword ptr [rsp + 0x30]
        mov               rcx, qword ptr [rsp + 0x38]
        mov               rdx, r9
        lock cmpxchg16b   xmmword ptr [r8]
        mov               qword ptr [r10], rax
        mov               qword ptr [r10 + 0x8], rdx
        sete              byte ptr [r10 + 0x10]
        mov               rax, r10
        pop               rbx
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
        vmovdqa           xmm0, xmmword ptr [rcx]
        vmovq             rax, xmm0
        vpextrq           rdx, xmm0, 0x1
        ret

asm_test::load::u128::acquire:
        vmovdqa           xmm0, xmmword ptr [rcx]
        vmovq             rax, xmm0
        vpextrq           rdx, xmm0, 0x1
        ret

asm_test::load::u128::relaxed:
        vmovdqa           xmm0, xmmword ptr [rcx]
        vmovq             rax, xmm0
        vpextrq           rdx, xmm0, 0x1
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
        push              rbx
        mov               rbx, rdx
        mov               r9, rcx
        mov               rax, qword ptr [rcx]
        mov               rdx, qword ptr [rcx + 0x8]
        nop
0:
        mov               rcx, r8
        lock cmpxchg16b   xmmword ptr [r9]
        jne               0b
        pop               rbx
        ret

asm_test::swap::u128::seqcst:
        push              rbx
        mov               rbx, rdx
        mov               r9, rcx
        mov               rax, qword ptr [rcx]
        mov               rdx, qword ptr [rcx + 0x8]
        nop
0:
        mov               rcx, r8
        lock cmpxchg16b   xmmword ptr [r9]
        jne               0b
        pop               rbx
        ret

asm_test::swap::u128::acquire:
        push              rbx
        mov               rbx, rdx
        mov               r9, rcx
        mov               rax, qword ptr [rcx]
        mov               rdx, qword ptr [rcx + 0x8]
        nop
0:
        mov               rcx, r8
        lock cmpxchg16b   xmmword ptr [r9]
        jne               0b
        pop               rbx
        ret

asm_test::swap::u128::relaxed:
        push              rbx
        mov               rbx, rdx
        mov               r9, rcx
        mov               rax, qword ptr [rcx]
        mov               rdx, qword ptr [rcx + 0x8]
        nop
0:
        mov               rcx, r8
        lock cmpxchg16b   xmmword ptr [r9]
        jne               0b
        pop               rbx
        ret

asm_test::swap::u128::release:
        push              rbx
        mov               rbx, rdx
        mov               r9, rcx
        mov               rax, qword ptr [rcx]
        mov               rdx, qword ptr [rcx + 0x8]
        nop
0:
        mov               rcx, r8
        lock cmpxchg16b   xmmword ptr [r9]
        jne               0b
        pop               rbx
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
        vmovq             xmm0, r8
        vmovq             xmm1, rdx
        vpunpcklqdq       xmm0, xmm1, xmm0 # xmm0 = xmm1[0],xmm0[0]
        vmovdqa           xmmword ptr [rcx], xmm0
        lock or           dword ptr [rsp], 0x0
        ret

asm_test::store::u128::relaxed:
        vmovq             xmm0, r8
        vmovq             xmm1, rdx
        vpunpcklqdq       xmm0, xmm1, xmm0 # xmm0 = xmm1[0],xmm0[0]
        vmovdqa           xmmword ptr [rcx], xmm0
        ret

asm_test::store::u128::release:
        vmovq             xmm0, r8
        vmovq             xmm1, rdx
        vpunpcklqdq       xmm0, xmm1, xmm0 # xmm0 = xmm1[0],xmm0[0]
        vmovdqa           xmmword ptr [rcx], xmm0
        ret

