asm_test::compare_exchange::u8::acqrel_seqcst:
        mov               eax, esi
        lock cmpxchg      byte ptr [edi], dl
        sete              dl
        ret

asm_test::compare_exchange::u8::seqcst_seqcst:
        mov               eax, esi
        lock cmpxchg      byte ptr [edi], dl
        sete              dl
        ret

asm_test::compare_exchange::u8::acqrel_acquire:
        mov               eax, esi
        lock cmpxchg      byte ptr [edi], dl
        sete              dl
        ret

asm_test::compare_exchange::u8::acqrel_relaxed:
        mov               eax, esi
        lock cmpxchg      byte ptr [edi], dl
        sete              dl
        ret

asm_test::compare_exchange::u8::acquire_seqcst:
        mov               eax, esi
        lock cmpxchg      byte ptr [edi], dl
        sete              dl
        ret

asm_test::compare_exchange::u8::relaxed_seqcst:
        mov               eax, esi
        lock cmpxchg      byte ptr [edi], dl
        sete              dl
        ret

asm_test::compare_exchange::u8::release_seqcst:
        mov               eax, esi
        lock cmpxchg      byte ptr [edi], dl
        sete              dl
        ret

asm_test::compare_exchange::u8::seqcst_acquire:
        mov               eax, esi
        lock cmpxchg      byte ptr [edi], dl
        sete              dl
        ret

asm_test::compare_exchange::u8::seqcst_relaxed:
        mov               eax, esi
        lock cmpxchg      byte ptr [edi], dl
        sete              dl
        ret

asm_test::compare_exchange::u8::acquire_acquire:
        mov               eax, esi
        lock cmpxchg      byte ptr [edi], dl
        sete              dl
        ret

asm_test::compare_exchange::u8::acquire_relaxed:
        mov               eax, esi
        lock cmpxchg      byte ptr [edi], dl
        sete              dl
        ret

asm_test::compare_exchange::u8::relaxed_acquire:
        mov               eax, esi
        lock cmpxchg      byte ptr [edi], dl
        sete              dl
        ret

asm_test::compare_exchange::u8::relaxed_relaxed:
        mov               eax, esi
        lock cmpxchg      byte ptr [edi], dl
        sete              dl
        ret

asm_test::compare_exchange::u8::release_acquire:
        mov               eax, esi
        lock cmpxchg      byte ptr [edi], dl
        sete              dl
        ret

asm_test::compare_exchange::u8::release_relaxed:
        mov               eax, esi
        lock cmpxchg      byte ptr [edi], dl
        sete              dl
        ret

asm_test::compare_exchange::u16::acqrel_seqcst:
        mov               eax, esi
        lock cmpxchg      word ptr [edi], dx
        sete              dl
        ret

asm_test::compare_exchange::u16::seqcst_seqcst:
        mov               eax, esi
        lock cmpxchg      word ptr [edi], dx
        sete              dl
        ret

asm_test::compare_exchange::u16::acqrel_acquire:
        mov               eax, esi
        lock cmpxchg      word ptr [edi], dx
        sete              dl
        ret

asm_test::compare_exchange::u16::acqrel_relaxed:
        mov               eax, esi
        lock cmpxchg      word ptr [edi], dx
        sete              dl
        ret

asm_test::compare_exchange::u16::acquire_seqcst:
        mov               eax, esi
        lock cmpxchg      word ptr [edi], dx
        sete              dl
        ret

asm_test::compare_exchange::u16::relaxed_seqcst:
        mov               eax, esi
        lock cmpxchg      word ptr [edi], dx
        sete              dl
        ret

asm_test::compare_exchange::u16::release_seqcst:
        mov               eax, esi
        lock cmpxchg      word ptr [edi], dx
        sete              dl
        ret

asm_test::compare_exchange::u16::seqcst_acquire:
        mov               eax, esi
        lock cmpxchg      word ptr [edi], dx
        sete              dl
        ret

asm_test::compare_exchange::u16::seqcst_relaxed:
        mov               eax, esi
        lock cmpxchg      word ptr [edi], dx
        sete              dl
        ret

asm_test::compare_exchange::u16::acquire_acquire:
        mov               eax, esi
        lock cmpxchg      word ptr [edi], dx
        sete              dl
        ret

asm_test::compare_exchange::u16::acquire_relaxed:
        mov               eax, esi
        lock cmpxchg      word ptr [edi], dx
        sete              dl
        ret

asm_test::compare_exchange::u16::relaxed_acquire:
        mov               eax, esi
        lock cmpxchg      word ptr [edi], dx
        sete              dl
        ret

asm_test::compare_exchange::u16::relaxed_relaxed:
        mov               eax, esi
        lock cmpxchg      word ptr [edi], dx
        sete              dl
        ret

asm_test::compare_exchange::u16::release_acquire:
        mov               eax, esi
        lock cmpxchg      word ptr [edi], dx
        sete              dl
        ret

asm_test::compare_exchange::u16::release_relaxed:
        mov               eax, esi
        lock cmpxchg      word ptr [edi], dx
        sete              dl
        ret

asm_test::compare_exchange::u32::acqrel_seqcst:
        mov               eax, esi
        lock cmpxchg      dword ptr [edi], edx
        sete              dl
        ret

asm_test::compare_exchange::u32::seqcst_seqcst:
        mov               eax, esi
        lock cmpxchg      dword ptr [edi], edx
        sete              dl
        ret

asm_test::compare_exchange::u32::acqrel_acquire:
        mov               eax, esi
        lock cmpxchg      dword ptr [edi], edx
        sete              dl
        ret

asm_test::compare_exchange::u32::acqrel_relaxed:
        mov               eax, esi
        lock cmpxchg      dword ptr [edi], edx
        sete              dl
        ret

asm_test::compare_exchange::u32::acquire_seqcst:
        mov               eax, esi
        lock cmpxchg      dword ptr [edi], edx
        sete              dl
        ret

asm_test::compare_exchange::u32::relaxed_seqcst:
        mov               eax, esi
        lock cmpxchg      dword ptr [edi], edx
        sete              dl
        ret

asm_test::compare_exchange::u32::release_seqcst:
        mov               eax, esi
        lock cmpxchg      dword ptr [edi], edx
        sete              dl
        ret

asm_test::compare_exchange::u32::seqcst_acquire:
        mov               eax, esi
        lock cmpxchg      dword ptr [edi], edx
        sete              dl
        ret

asm_test::compare_exchange::u32::seqcst_relaxed:
        mov               eax, esi
        lock cmpxchg      dword ptr [edi], edx
        sete              dl
        ret

asm_test::compare_exchange::u32::acquire_acquire:
        mov               eax, esi
        lock cmpxchg      dword ptr [edi], edx
        sete              dl
        ret

asm_test::compare_exchange::u32::acquire_relaxed:
        mov               eax, esi
        lock cmpxchg      dword ptr [edi], edx
        sete              dl
        ret

asm_test::compare_exchange::u32::relaxed_acquire:
        mov               eax, esi
        lock cmpxchg      dword ptr [edi], edx
        sete              dl
        ret

asm_test::compare_exchange::u32::relaxed_relaxed:
        mov               eax, esi
        lock cmpxchg      dword ptr [edi], edx
        sete              dl
        ret

asm_test::compare_exchange::u32::release_acquire:
        mov               eax, esi
        lock cmpxchg      dword ptr [edi], edx
        sete              dl
        ret

asm_test::compare_exchange::u32::release_relaxed:
        mov               eax, esi
        lock cmpxchg      dword ptr [edi], edx
        sete              dl
        ret

asm_test::compare_exchange::u64::acqrel_seqcst:
        mov               rax, rdx
        lock cmpxchg      qword ptr [esi], rcx
        mov               qword ptr [edi], rax
        sete              byte ptr [edi + 0x8]
        mov               eax, edi
        ret

asm_test::compare_exchange::u64::seqcst_seqcst:
        mov               rax, rdx
        lock cmpxchg      qword ptr [esi], rcx
        mov               qword ptr [edi], rax
        sete              byte ptr [edi + 0x8]
        mov               eax, edi
        ret

asm_test::compare_exchange::u64::acqrel_acquire:
        mov               rax, rdx
        lock cmpxchg      qword ptr [esi], rcx
        mov               qword ptr [edi], rax
        sete              byte ptr [edi + 0x8]
        mov               eax, edi
        ret

asm_test::compare_exchange::u64::acqrel_relaxed:
        mov               rax, rdx
        lock cmpxchg      qword ptr [esi], rcx
        mov               qword ptr [edi], rax
        sete              byte ptr [edi + 0x8]
        mov               eax, edi
        ret

asm_test::compare_exchange::u64::acquire_seqcst:
        mov               rax, rdx
        lock cmpxchg      qword ptr [esi], rcx
        mov               qword ptr [edi], rax
        sete              byte ptr [edi + 0x8]
        mov               eax, edi
        ret

asm_test::compare_exchange::u64::relaxed_seqcst:
        mov               rax, rdx
        lock cmpxchg      qword ptr [esi], rcx
        mov               qword ptr [edi], rax
        sete              byte ptr [edi + 0x8]
        mov               eax, edi
        ret

asm_test::compare_exchange::u64::release_seqcst:
        mov               rax, rdx
        lock cmpxchg      qword ptr [esi], rcx
        mov               qword ptr [edi], rax
        sete              byte ptr [edi + 0x8]
        mov               eax, edi
        ret

asm_test::compare_exchange::u64::seqcst_acquire:
        mov               rax, rdx
        lock cmpxchg      qword ptr [esi], rcx
        mov               qword ptr [edi], rax
        sete              byte ptr [edi + 0x8]
        mov               eax, edi
        ret

asm_test::compare_exchange::u64::seqcst_relaxed:
        mov               rax, rdx
        lock cmpxchg      qword ptr [esi], rcx
        mov               qword ptr [edi], rax
        sete              byte ptr [edi + 0x8]
        mov               eax, edi
        ret

asm_test::compare_exchange::u64::acquire_acquire:
        mov               rax, rdx
        lock cmpxchg      qword ptr [esi], rcx
        mov               qword ptr [edi], rax
        sete              byte ptr [edi + 0x8]
        mov               eax, edi
        ret

asm_test::compare_exchange::u64::acquire_relaxed:
        mov               rax, rdx
        lock cmpxchg      qword ptr [esi], rcx
        mov               qword ptr [edi], rax
        sete              byte ptr [edi + 0x8]
        mov               eax, edi
        ret

asm_test::compare_exchange::u64::relaxed_acquire:
        mov               rax, rdx
        lock cmpxchg      qword ptr [esi], rcx
        mov               qword ptr [edi], rax
        sete              byte ptr [edi + 0x8]
        mov               eax, edi
        ret

asm_test::compare_exchange::u64::relaxed_relaxed:
        mov               rax, rdx
        lock cmpxchg      qword ptr [esi], rcx
        mov               qword ptr [edi], rax
        sete              byte ptr [edi + 0x8]
        mov               eax, edi
        ret

asm_test::compare_exchange::u64::release_acquire:
        mov               rax, rdx
        lock cmpxchg      qword ptr [esi], rcx
        mov               qword ptr [edi], rax
        sete              byte ptr [edi + 0x8]
        mov               eax, edi
        ret

asm_test::compare_exchange::u64::release_relaxed:
        mov               rax, rdx
        lock cmpxchg      qword ptr [esi], rcx
        mov               qword ptr [edi], rax
        sete              byte ptr [edi + 0x8]
        mov               eax, edi
        ret

asm_test::compare_exchange::u128::acqrel_seqcst:
        push              rbx
        mov               rax, rdx
        mov               rdx, rcx
        mov               rcx, r9
        mov               rbx, r8
        lock cmpxchg16b   xmmword ptr [esi]
        mov               qword ptr [edi], rax
        mov               qword ptr [edi + 0x8], rdx
        sete              byte ptr [edi + 0x10]
        mov               eax, edi
        pop               rbx
        ret

asm_test::compare_exchange::u128::seqcst_seqcst:
        push              rbx
        mov               rax, rdx
        mov               rdx, rcx
        mov               rcx, r9
        mov               rbx, r8
        lock cmpxchg16b   xmmword ptr [esi]
        mov               qword ptr [edi], rax
        mov               qword ptr [edi + 0x8], rdx
        sete              byte ptr [edi + 0x10]
        mov               eax, edi
        pop               rbx
        ret

asm_test::compare_exchange::u128::acqrel_acquire:
        push              rbx
        mov               rax, rdx
        mov               rdx, rcx
        mov               rcx, r9
        mov               rbx, r8
        lock cmpxchg16b   xmmword ptr [esi]
        mov               qword ptr [edi], rax
        mov               qword ptr [edi + 0x8], rdx
        sete              byte ptr [edi + 0x10]
        mov               eax, edi
        pop               rbx
        ret

asm_test::compare_exchange::u128::acqrel_relaxed:
        push              rbx
        mov               rax, rdx
        mov               rdx, rcx
        mov               rcx, r9
        mov               rbx, r8
        lock cmpxchg16b   xmmword ptr [esi]
        mov               qword ptr [edi], rax
        mov               qword ptr [edi + 0x8], rdx
        sete              byte ptr [edi + 0x10]
        mov               eax, edi
        pop               rbx
        ret

asm_test::compare_exchange::u128::acquire_seqcst:
        push              rbx
        mov               rax, rdx
        mov               rdx, rcx
        mov               rcx, r9
        mov               rbx, r8
        lock cmpxchg16b   xmmword ptr [esi]
        mov               qword ptr [edi], rax
        mov               qword ptr [edi + 0x8], rdx
        sete              byte ptr [edi + 0x10]
        mov               eax, edi
        pop               rbx
        ret

asm_test::compare_exchange::u128::relaxed_seqcst:
        push              rbx
        mov               rax, rdx
        mov               rdx, rcx
        mov               rcx, r9
        mov               rbx, r8
        lock cmpxchg16b   xmmword ptr [esi]
        mov               qword ptr [edi], rax
        mov               qword ptr [edi + 0x8], rdx
        sete              byte ptr [edi + 0x10]
        mov               eax, edi
        pop               rbx
        ret

asm_test::compare_exchange::u128::release_seqcst:
        push              rbx
        mov               rax, rdx
        mov               rdx, rcx
        mov               rcx, r9
        mov               rbx, r8
        lock cmpxchg16b   xmmword ptr [esi]
        mov               qword ptr [edi], rax
        mov               qword ptr [edi + 0x8], rdx
        sete              byte ptr [edi + 0x10]
        mov               eax, edi
        pop               rbx
        ret

asm_test::compare_exchange::u128::seqcst_acquire:
        push              rbx
        mov               rax, rdx
        mov               rdx, rcx
        mov               rcx, r9
        mov               rbx, r8
        lock cmpxchg16b   xmmword ptr [esi]
        mov               qword ptr [edi], rax
        mov               qword ptr [edi + 0x8], rdx
        sete              byte ptr [edi + 0x10]
        mov               eax, edi
        pop               rbx
        ret

asm_test::compare_exchange::u128::seqcst_relaxed:
        push              rbx
        mov               rax, rdx
        mov               rdx, rcx
        mov               rcx, r9
        mov               rbx, r8
        lock cmpxchg16b   xmmword ptr [esi]
        mov               qword ptr [edi], rax
        mov               qword ptr [edi + 0x8], rdx
        sete              byte ptr [edi + 0x10]
        mov               eax, edi
        pop               rbx
        ret

asm_test::compare_exchange::u128::acquire_acquire:
        push              rbx
        mov               rax, rdx
        mov               rdx, rcx
        mov               rcx, r9
        mov               rbx, r8
        lock cmpxchg16b   xmmword ptr [esi]
        mov               qword ptr [edi], rax
        mov               qword ptr [edi + 0x8], rdx
        sete              byte ptr [edi + 0x10]
        mov               eax, edi
        pop               rbx
        ret

asm_test::compare_exchange::u128::acquire_relaxed:
        push              rbx
        mov               rax, rdx
        mov               rdx, rcx
        mov               rcx, r9
        mov               rbx, r8
        lock cmpxchg16b   xmmword ptr [esi]
        mov               qword ptr [edi], rax
        mov               qword ptr [edi + 0x8], rdx
        sete              byte ptr [edi + 0x10]
        mov               eax, edi
        pop               rbx
        ret

asm_test::compare_exchange::u128::relaxed_acquire:
        push              rbx
        mov               rax, rdx
        mov               rdx, rcx
        mov               rcx, r9
        mov               rbx, r8
        lock cmpxchg16b   xmmword ptr [esi]
        mov               qword ptr [edi], rax
        mov               qword ptr [edi + 0x8], rdx
        sete              byte ptr [edi + 0x10]
        mov               eax, edi
        pop               rbx
        ret

asm_test::compare_exchange::u128::relaxed_relaxed:
        push              rbx
        mov               rax, rdx
        mov               rdx, rcx
        mov               rcx, r9
        mov               rbx, r8
        lock cmpxchg16b   xmmword ptr [esi]
        mov               qword ptr [edi], rax
        mov               qword ptr [edi + 0x8], rdx
        sete              byte ptr [edi + 0x10]
        mov               eax, edi
        pop               rbx
        ret

asm_test::compare_exchange::u128::release_acquire:
        push              rbx
        mov               rax, rdx
        mov               rdx, rcx
        mov               rcx, r9
        mov               rbx, r8
        lock cmpxchg16b   xmmword ptr [esi]
        mov               qword ptr [edi], rax
        mov               qword ptr [edi + 0x8], rdx
        sete              byte ptr [edi + 0x10]
        mov               eax, edi
        pop               rbx
        ret

asm_test::compare_exchange::u128::release_relaxed:
        push              rbx
        mov               rax, rdx
        mov               rdx, rcx
        mov               rcx, r9
        mov               rbx, r8
        lock cmpxchg16b   xmmword ptr [esi]
        mov               qword ptr [edi], rax
        mov               qword ptr [edi + 0x8], rdx
        sete              byte ptr [edi + 0x10]
        mov               eax, edi
        pop               rbx
        ret

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        mov               eax, esi
        lock cmpxchg      byte ptr [edi], dl
        sete              dl
        ret

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        mov               eax, esi
        lock cmpxchg      byte ptr [edi], dl
        sete              dl
        ret

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        mov               eax, esi
        lock cmpxchg      byte ptr [edi], dl
        sete              dl
        ret

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        mov               eax, esi
        lock cmpxchg      byte ptr [edi], dl
        sete              dl
        ret

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        mov               eax, esi
        lock cmpxchg      byte ptr [edi], dl
        sete              dl
        ret

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        mov               eax, esi
        lock cmpxchg      byte ptr [edi], dl
        sete              dl
        ret

asm_test::compare_exchange_weak::u8::release_seqcst:
        mov               eax, esi
        lock cmpxchg      byte ptr [edi], dl
        sete              dl
        ret

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        mov               eax, esi
        lock cmpxchg      byte ptr [edi], dl
        sete              dl
        ret

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        mov               eax, esi
        lock cmpxchg      byte ptr [edi], dl
        sete              dl
        ret

asm_test::compare_exchange_weak::u8::acquire_acquire:
        mov               eax, esi
        lock cmpxchg      byte ptr [edi], dl
        sete              dl
        ret

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        mov               eax, esi
        lock cmpxchg      byte ptr [edi], dl
        sete              dl
        ret

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        mov               eax, esi
        lock cmpxchg      byte ptr [edi], dl
        sete              dl
        ret

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        mov               eax, esi
        lock cmpxchg      byte ptr [edi], dl
        sete              dl
        ret

asm_test::compare_exchange_weak::u8::release_acquire:
        mov               eax, esi
        lock cmpxchg      byte ptr [edi], dl
        sete              dl
        ret

asm_test::compare_exchange_weak::u8::release_relaxed:
        mov               eax, esi
        lock cmpxchg      byte ptr [edi], dl
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        mov               eax, esi
        lock cmpxchg      word ptr [edi], dx
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        mov               eax, esi
        lock cmpxchg      word ptr [edi], dx
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        mov               eax, esi
        lock cmpxchg      word ptr [edi], dx
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        mov               eax, esi
        lock cmpxchg      word ptr [edi], dx
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        mov               eax, esi
        lock cmpxchg      word ptr [edi], dx
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        mov               eax, esi
        lock cmpxchg      word ptr [edi], dx
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::release_seqcst:
        mov               eax, esi
        lock cmpxchg      word ptr [edi], dx
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        mov               eax, esi
        lock cmpxchg      word ptr [edi], dx
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        mov               eax, esi
        lock cmpxchg      word ptr [edi], dx
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::acquire_acquire:
        mov               eax, esi
        lock cmpxchg      word ptr [edi], dx
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        mov               eax, esi
        lock cmpxchg      word ptr [edi], dx
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        mov               eax, esi
        lock cmpxchg      word ptr [edi], dx
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        mov               eax, esi
        lock cmpxchg      word ptr [edi], dx
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::release_acquire:
        mov               eax, esi
        lock cmpxchg      word ptr [edi], dx
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::release_relaxed:
        mov               eax, esi
        lock cmpxchg      word ptr [edi], dx
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        mov               eax, esi
        lock cmpxchg      dword ptr [edi], edx
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        mov               eax, esi
        lock cmpxchg      dword ptr [edi], edx
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        mov               eax, esi
        lock cmpxchg      dword ptr [edi], edx
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        mov               eax, esi
        lock cmpxchg      dword ptr [edi], edx
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        mov               eax, esi
        lock cmpxchg      dword ptr [edi], edx
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        mov               eax, esi
        lock cmpxchg      dword ptr [edi], edx
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::release_seqcst:
        mov               eax, esi
        lock cmpxchg      dword ptr [edi], edx
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        mov               eax, esi
        lock cmpxchg      dword ptr [edi], edx
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        mov               eax, esi
        lock cmpxchg      dword ptr [edi], edx
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::acquire_acquire:
        mov               eax, esi
        lock cmpxchg      dword ptr [edi], edx
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        mov               eax, esi
        lock cmpxchg      dword ptr [edi], edx
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        mov               eax, esi
        lock cmpxchg      dword ptr [edi], edx
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        mov               eax, esi
        lock cmpxchg      dword ptr [edi], edx
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::release_acquire:
        mov               eax, esi
        lock cmpxchg      dword ptr [edi], edx
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::release_relaxed:
        mov               eax, esi
        lock cmpxchg      dword ptr [edi], edx
        sete              dl
        ret

asm_test::compare_exchange_weak::u64::acqrel_seqcst:
        mov               rax, rdx
        lock cmpxchg      qword ptr [esi], rcx
        mov               qword ptr [edi], rax
        sete              byte ptr [edi + 0x8]
        mov               eax, edi
        ret

asm_test::compare_exchange_weak::u64::seqcst_seqcst:
        mov               rax, rdx
        lock cmpxchg      qword ptr [esi], rcx
        mov               qword ptr [edi], rax
        sete              byte ptr [edi + 0x8]
        mov               eax, edi
        ret

asm_test::compare_exchange_weak::u64::acqrel_acquire:
        mov               rax, rdx
        lock cmpxchg      qword ptr [esi], rcx
        mov               qword ptr [edi], rax
        sete              byte ptr [edi + 0x8]
        mov               eax, edi
        ret

asm_test::compare_exchange_weak::u64::acqrel_relaxed:
        mov               rax, rdx
        lock cmpxchg      qword ptr [esi], rcx
        mov               qword ptr [edi], rax
        sete              byte ptr [edi + 0x8]
        mov               eax, edi
        ret

asm_test::compare_exchange_weak::u64::acquire_seqcst:
        mov               rax, rdx
        lock cmpxchg      qword ptr [esi], rcx
        mov               qword ptr [edi], rax
        sete              byte ptr [edi + 0x8]
        mov               eax, edi
        ret

asm_test::compare_exchange_weak::u64::relaxed_seqcst:
        mov               rax, rdx
        lock cmpxchg      qword ptr [esi], rcx
        mov               qword ptr [edi], rax
        sete              byte ptr [edi + 0x8]
        mov               eax, edi
        ret

asm_test::compare_exchange_weak::u64::release_seqcst:
        mov               rax, rdx
        lock cmpxchg      qword ptr [esi], rcx
        mov               qword ptr [edi], rax
        sete              byte ptr [edi + 0x8]
        mov               eax, edi
        ret

asm_test::compare_exchange_weak::u64::seqcst_acquire:
        mov               rax, rdx
        lock cmpxchg      qword ptr [esi], rcx
        mov               qword ptr [edi], rax
        sete              byte ptr [edi + 0x8]
        mov               eax, edi
        ret

asm_test::compare_exchange_weak::u64::seqcst_relaxed:
        mov               rax, rdx
        lock cmpxchg      qword ptr [esi], rcx
        mov               qword ptr [edi], rax
        sete              byte ptr [edi + 0x8]
        mov               eax, edi
        ret

asm_test::compare_exchange_weak::u64::acquire_acquire:
        mov               rax, rdx
        lock cmpxchg      qword ptr [esi], rcx
        mov               qword ptr [edi], rax
        sete              byte ptr [edi + 0x8]
        mov               eax, edi
        ret

asm_test::compare_exchange_weak::u64::acquire_relaxed:
        mov               rax, rdx
        lock cmpxchg      qword ptr [esi], rcx
        mov               qword ptr [edi], rax
        sete              byte ptr [edi + 0x8]
        mov               eax, edi
        ret

asm_test::compare_exchange_weak::u64::relaxed_acquire:
        mov               rax, rdx
        lock cmpxchg      qword ptr [esi], rcx
        mov               qword ptr [edi], rax
        sete              byte ptr [edi + 0x8]
        mov               eax, edi
        ret

asm_test::compare_exchange_weak::u64::relaxed_relaxed:
        mov               rax, rdx
        lock cmpxchg      qword ptr [esi], rcx
        mov               qword ptr [edi], rax
        sete              byte ptr [edi + 0x8]
        mov               eax, edi
        ret

asm_test::compare_exchange_weak::u64::release_acquire:
        mov               rax, rdx
        lock cmpxchg      qword ptr [esi], rcx
        mov               qword ptr [edi], rax
        sete              byte ptr [edi + 0x8]
        mov               eax, edi
        ret

asm_test::compare_exchange_weak::u64::release_relaxed:
        mov               rax, rdx
        lock cmpxchg      qword ptr [esi], rcx
        mov               qword ptr [edi], rax
        sete              byte ptr [edi + 0x8]
        mov               eax, edi
        ret

asm_test::compare_exchange_weak::u128::acqrel_seqcst:
        push              rbx
        mov               rax, rdx
        mov               rdx, rcx
        mov               rcx, r9
        mov               rbx, r8
        lock cmpxchg16b   xmmword ptr [esi]
        mov               qword ptr [edi], rax
        mov               qword ptr [edi + 0x8], rdx
        sete              byte ptr [edi + 0x10]
        mov               eax, edi
        pop               rbx
        ret

asm_test::compare_exchange_weak::u128::seqcst_seqcst:
        push              rbx
        mov               rax, rdx
        mov               rdx, rcx
        mov               rcx, r9
        mov               rbx, r8
        lock cmpxchg16b   xmmword ptr [esi]
        mov               qword ptr [edi], rax
        mov               qword ptr [edi + 0x8], rdx
        sete              byte ptr [edi + 0x10]
        mov               eax, edi
        pop               rbx
        ret

asm_test::compare_exchange_weak::u128::acqrel_acquire:
        push              rbx
        mov               rax, rdx
        mov               rdx, rcx
        mov               rcx, r9
        mov               rbx, r8
        lock cmpxchg16b   xmmword ptr [esi]
        mov               qword ptr [edi], rax
        mov               qword ptr [edi + 0x8], rdx
        sete              byte ptr [edi + 0x10]
        mov               eax, edi
        pop               rbx
        ret

asm_test::compare_exchange_weak::u128::acqrel_relaxed:
        push              rbx
        mov               rax, rdx
        mov               rdx, rcx
        mov               rcx, r9
        mov               rbx, r8
        lock cmpxchg16b   xmmword ptr [esi]
        mov               qword ptr [edi], rax
        mov               qword ptr [edi + 0x8], rdx
        sete              byte ptr [edi + 0x10]
        mov               eax, edi
        pop               rbx
        ret

asm_test::compare_exchange_weak::u128::acquire_seqcst:
        push              rbx
        mov               rax, rdx
        mov               rdx, rcx
        mov               rcx, r9
        mov               rbx, r8
        lock cmpxchg16b   xmmword ptr [esi]
        mov               qword ptr [edi], rax
        mov               qword ptr [edi + 0x8], rdx
        sete              byte ptr [edi + 0x10]
        mov               eax, edi
        pop               rbx
        ret

asm_test::compare_exchange_weak::u128::relaxed_seqcst:
        push              rbx
        mov               rax, rdx
        mov               rdx, rcx
        mov               rcx, r9
        mov               rbx, r8
        lock cmpxchg16b   xmmword ptr [esi]
        mov               qword ptr [edi], rax
        mov               qword ptr [edi + 0x8], rdx
        sete              byte ptr [edi + 0x10]
        mov               eax, edi
        pop               rbx
        ret

asm_test::compare_exchange_weak::u128::release_seqcst:
        push              rbx
        mov               rax, rdx
        mov               rdx, rcx
        mov               rcx, r9
        mov               rbx, r8
        lock cmpxchg16b   xmmword ptr [esi]
        mov               qword ptr [edi], rax
        mov               qword ptr [edi + 0x8], rdx
        sete              byte ptr [edi + 0x10]
        mov               eax, edi
        pop               rbx
        ret

asm_test::compare_exchange_weak::u128::seqcst_acquire:
        push              rbx
        mov               rax, rdx
        mov               rdx, rcx
        mov               rcx, r9
        mov               rbx, r8
        lock cmpxchg16b   xmmword ptr [esi]
        mov               qword ptr [edi], rax
        mov               qword ptr [edi + 0x8], rdx
        sete              byte ptr [edi + 0x10]
        mov               eax, edi
        pop               rbx
        ret

asm_test::compare_exchange_weak::u128::seqcst_relaxed:
        push              rbx
        mov               rax, rdx
        mov               rdx, rcx
        mov               rcx, r9
        mov               rbx, r8
        lock cmpxchg16b   xmmword ptr [esi]
        mov               qword ptr [edi], rax
        mov               qword ptr [edi + 0x8], rdx
        sete              byte ptr [edi + 0x10]
        mov               eax, edi
        pop               rbx
        ret

asm_test::compare_exchange_weak::u128::acquire_acquire:
        push              rbx
        mov               rax, rdx
        mov               rdx, rcx
        mov               rcx, r9
        mov               rbx, r8
        lock cmpxchg16b   xmmword ptr [esi]
        mov               qword ptr [edi], rax
        mov               qword ptr [edi + 0x8], rdx
        sete              byte ptr [edi + 0x10]
        mov               eax, edi
        pop               rbx
        ret

asm_test::compare_exchange_weak::u128::acquire_relaxed:
        push              rbx
        mov               rax, rdx
        mov               rdx, rcx
        mov               rcx, r9
        mov               rbx, r8
        lock cmpxchg16b   xmmword ptr [esi]
        mov               qword ptr [edi], rax
        mov               qword ptr [edi + 0x8], rdx
        sete              byte ptr [edi + 0x10]
        mov               eax, edi
        pop               rbx
        ret

asm_test::compare_exchange_weak::u128::relaxed_acquire:
        push              rbx
        mov               rax, rdx
        mov               rdx, rcx
        mov               rcx, r9
        mov               rbx, r8
        lock cmpxchg16b   xmmword ptr [esi]
        mov               qword ptr [edi], rax
        mov               qword ptr [edi + 0x8], rdx
        sete              byte ptr [edi + 0x10]
        mov               eax, edi
        pop               rbx
        ret

asm_test::compare_exchange_weak::u128::relaxed_relaxed:
        push              rbx
        mov               rax, rdx
        mov               rdx, rcx
        mov               rcx, r9
        mov               rbx, r8
        lock cmpxchg16b   xmmword ptr [esi]
        mov               qword ptr [edi], rax
        mov               qword ptr [edi + 0x8], rdx
        sete              byte ptr [edi + 0x10]
        mov               eax, edi
        pop               rbx
        ret

asm_test::compare_exchange_weak::u128::release_acquire:
        push              rbx
        mov               rax, rdx
        mov               rdx, rcx
        mov               rcx, r9
        mov               rbx, r8
        lock cmpxchg16b   xmmword ptr [esi]
        mov               qword ptr [edi], rax
        mov               qword ptr [edi + 0x8], rdx
        sete              byte ptr [edi + 0x10]
        mov               eax, edi
        pop               rbx
        ret

asm_test::compare_exchange_weak::u128::release_relaxed:
        push              rbx
        mov               rax, rdx
        mov               rdx, rcx
        mov               rcx, r9
        mov               rbx, r8
        lock cmpxchg16b   xmmword ptr [esi]
        mov               qword ptr [edi], rax
        mov               qword ptr [edi + 0x8], rdx
        sete              byte ptr [edi + 0x10]
        mov               eax, edi
        pop               rbx
        ret

asm_test::load::u8::seqcst:
        movzx             eax, byte ptr [edi]
        ret

asm_test::load::u8::acquire:
        movzx             eax, byte ptr [edi]
        ret

asm_test::load::u8::relaxed:
        movzx             eax, byte ptr [edi]
        ret

asm_test::load::u16::seqcst:
        movzx             eax, word ptr [edi]
        ret

asm_test::load::u16::acquire:
        movzx             eax, word ptr [edi]
        ret

asm_test::load::u16::relaxed:
        movzx             eax, word ptr [edi]
        ret

asm_test::load::u32::seqcst:
        mov               eax, dword ptr [edi]
        ret

asm_test::load::u32::acquire:
        mov               eax, dword ptr [edi]
        ret

asm_test::load::u32::relaxed:
        mov               eax, dword ptr [edi]
        ret

asm_test::load::u64::seqcst:
        mov               rax, qword ptr [edi]
        ret

asm_test::load::u64::acquire:
        mov               rax, qword ptr [edi]
        ret

asm_test::load::u64::relaxed:
        mov               rax, qword ptr [edi]
        ret

asm_test::load::u128::seqcst:
        mov               rax, rdi
        vmovaps           xmm0, xmmword ptr [esi]
        vmovaps           xmmword ptr [eax], xmm0
        ret

asm_test::load::u128::acquire:
        mov               rax, rdi
        vmovaps           xmm0, xmmword ptr [esi]
        vmovaps           xmmword ptr [eax], xmm0
        ret

asm_test::load::u128::relaxed:
        mov               rax, rdi
        vmovaps           xmm0, xmmword ptr [esi]
        vmovaps           xmmword ptr [eax], xmm0
        ret

asm_test::swap::u8::acqrel:
        mov               eax, esi
        xchg              byte ptr [edi], al
        ret

asm_test::swap::u8::seqcst:
        mov               eax, esi
        xchg              byte ptr [edi], al
        ret

asm_test::swap::u8::acquire:
        mov               eax, esi
        xchg              byte ptr [edi], al
        ret

asm_test::swap::u8::relaxed:
        mov               eax, esi
        xchg              byte ptr [edi], al
        ret

asm_test::swap::u8::release:
        mov               eax, esi
        xchg              byte ptr [edi], al
        ret

asm_test::swap::u16::acqrel:
        mov               eax, esi
        xchg              word ptr [edi], ax
        ret

asm_test::swap::u16::seqcst:
        mov               eax, esi
        xchg              word ptr [edi], ax
        ret

asm_test::swap::u16::acquire:
        mov               eax, esi
        xchg              word ptr [edi], ax
        ret

asm_test::swap::u16::relaxed:
        mov               eax, esi
        xchg              word ptr [edi], ax
        ret

asm_test::swap::u16::release:
        mov               eax, esi
        xchg              word ptr [edi], ax
        ret

asm_test::swap::u32::acqrel:
        mov               eax, esi
        xchg              dword ptr [edi], eax
        ret

asm_test::swap::u32::seqcst:
        mov               eax, esi
        xchg              dword ptr [edi], eax
        ret

asm_test::swap::u32::acquire:
        mov               eax, esi
        xchg              dword ptr [edi], eax
        ret

asm_test::swap::u32::relaxed:
        mov               eax, esi
        xchg              dword ptr [edi], eax
        ret

asm_test::swap::u32::release:
        mov               eax, esi
        xchg              dword ptr [edi], eax
        ret

asm_test::swap::u64::acqrel:
        mov               rax, rsi
        xchg              qword ptr [edi], rax
        ret

asm_test::swap::u64::seqcst:
        mov               rax, rsi
        xchg              qword ptr [edi], rax
        ret

asm_test::swap::u64::acquire:
        mov               rax, rsi
        xchg              qword ptr [edi], rax
        ret

asm_test::swap::u64::relaxed:
        mov               rax, rsi
        xchg              qword ptr [edi], rax
        ret

asm_test::swap::u64::release:
        mov               rax, rsi
        xchg              qword ptr [edi], rax
        ret

asm_test::swap::u128::acqrel:
        push              rbx
        mov               rbx, rdx
        mov               rax, qword ptr [esi]
        mov               rdx, qword ptr [esi + 0x8]
        nop               dword ptr [rax]
0:
        lock cmpxchg16b   xmmword ptr [esi]
        jne               0b
        mov               qword ptr [edi], rax
        mov               qword ptr [edi + 0x8], rdx
        mov               eax, edi
        pop               rbx
        ret

asm_test::swap::u128::seqcst:
        push              rbx
        mov               rbx, rdx
        mov               rax, qword ptr [esi]
        mov               rdx, qword ptr [esi + 0x8]
        nop               dword ptr [rax]
0:
        lock cmpxchg16b   xmmword ptr [esi]
        jne               0b
        mov               qword ptr [edi], rax
        mov               qword ptr [edi + 0x8], rdx
        mov               eax, edi
        pop               rbx
        ret

asm_test::swap::u128::acquire:
        push              rbx
        mov               rbx, rdx
        mov               rax, qword ptr [esi]
        mov               rdx, qword ptr [esi + 0x8]
        nop               dword ptr [rax]
0:
        lock cmpxchg16b   xmmword ptr [esi]
        jne               0b
        mov               qword ptr [edi], rax
        mov               qword ptr [edi + 0x8], rdx
        mov               eax, edi
        pop               rbx
        ret

asm_test::swap::u128::relaxed:
        push              rbx
        mov               rbx, rdx
        mov               rax, qword ptr [esi]
        mov               rdx, qword ptr [esi + 0x8]
        nop               dword ptr [rax]
0:
        lock cmpxchg16b   xmmword ptr [esi]
        jne               0b
        mov               qword ptr [edi], rax
        mov               qword ptr [edi + 0x8], rdx
        mov               eax, edi
        pop               rbx
        ret

asm_test::swap::u128::release:
        push              rbx
        mov               rbx, rdx
        mov               rax, qword ptr [esi]
        mov               rdx, qword ptr [esi + 0x8]
        nop               dword ptr [rax]
0:
        lock cmpxchg16b   xmmword ptr [esi]
        jne               0b
        mov               qword ptr [edi], rax
        mov               qword ptr [edi + 0x8], rdx
        mov               eax, edi
        pop               rbx
        ret

asm_test::store::u8::seqcst:
        xchg              byte ptr [edi], sil
        ret

asm_test::store::u8::relaxed:
        mov               byte ptr [edi], sil
        ret

asm_test::store::u8::release:
        mov               byte ptr [edi], sil
        ret

asm_test::store::u16::seqcst:
        xchg              word ptr [edi], si
        ret

asm_test::store::u16::relaxed:
        mov               word ptr [edi], si
        ret

asm_test::store::u16::release:
        mov               word ptr [edi], si
        ret

asm_test::store::u32::seqcst:
        xchg              dword ptr [edi], esi
        ret

asm_test::store::u32::relaxed:
        mov               dword ptr [edi], esi
        ret

asm_test::store::u32::release:
        mov               dword ptr [edi], esi
        ret

asm_test::store::u64::seqcst:
        xchg              qword ptr [edi], rsi
        ret

asm_test::store::u64::relaxed:
        mov               qword ptr [edi], rsi
        ret

asm_test::store::u64::release:
        mov               qword ptr [edi], rsi
        ret

asm_test::store::u128::seqcst:
        vmovq             xmm0, rdx
        vmovq             xmm1, rsi
        vpunpcklqdq       xmm0, xmm1, xmm0 # xmm0 = xmm1[0],xmm0[0]
        vmovdqa           xmmword ptr [edi], xmm0
        lock or           dword ptr [rsp - 0x40], 0x0
        ret

asm_test::store::u128::relaxed:
        vmovq             xmm0, rdx
        vmovq             xmm1, rsi
        vpunpcklqdq       xmm0, xmm1, xmm0 # xmm0 = xmm1[0],xmm0[0]
        vmovdqa           xmmword ptr [edi], xmm0
        ret

asm_test::store::u128::release:
        vmovq             xmm0, rdx
        vmovq             xmm1, rsi
        vpunpcklqdq       xmm0, xmm1, xmm0 # xmm0 = xmm1[0],xmm0[0]
        vmovdqa           xmmword ptr [edi], xmm0
        ret

