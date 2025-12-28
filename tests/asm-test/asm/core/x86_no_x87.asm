asm_test::compare_exchange::u8::acqrel_seqcst:
        movzx             eax, byte ptr [esp + 0x8]
        movzx             ecx, byte ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      byte ptr [edx], cl
        sete              dl
        ret

asm_test::compare_exchange::u8::seqcst_seqcst:
        movzx             eax, byte ptr [esp + 0x8]
        movzx             ecx, byte ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      byte ptr [edx], cl
        sete              dl
        ret

asm_test::compare_exchange::u8::acqrel_acquire:
        movzx             eax, byte ptr [esp + 0x8]
        movzx             ecx, byte ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      byte ptr [edx], cl
        sete              dl
        ret

asm_test::compare_exchange::u8::acqrel_relaxed:
        movzx             eax, byte ptr [esp + 0x8]
        movzx             ecx, byte ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      byte ptr [edx], cl
        sete              dl
        ret

asm_test::compare_exchange::u8::acquire_seqcst:
        movzx             eax, byte ptr [esp + 0x8]
        movzx             ecx, byte ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      byte ptr [edx], cl
        sete              dl
        ret

asm_test::compare_exchange::u8::relaxed_seqcst:
        movzx             eax, byte ptr [esp + 0x8]
        movzx             ecx, byte ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      byte ptr [edx], cl
        sete              dl
        ret

asm_test::compare_exchange::u8::release_seqcst:
        movzx             eax, byte ptr [esp + 0x8]
        movzx             ecx, byte ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      byte ptr [edx], cl
        sete              dl
        ret

asm_test::compare_exchange::u8::seqcst_acquire:
        movzx             eax, byte ptr [esp + 0x8]
        movzx             ecx, byte ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      byte ptr [edx], cl
        sete              dl
        ret

asm_test::compare_exchange::u8::seqcst_relaxed:
        movzx             eax, byte ptr [esp + 0x8]
        movzx             ecx, byte ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      byte ptr [edx], cl
        sete              dl
        ret

asm_test::compare_exchange::u8::acquire_acquire:
        movzx             eax, byte ptr [esp + 0x8]
        movzx             ecx, byte ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      byte ptr [edx], cl
        sete              dl
        ret

asm_test::compare_exchange::u8::acquire_relaxed:
        movzx             eax, byte ptr [esp + 0x8]
        movzx             ecx, byte ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      byte ptr [edx], cl
        sete              dl
        ret

asm_test::compare_exchange::u8::relaxed_acquire:
        movzx             eax, byte ptr [esp + 0x8]
        movzx             ecx, byte ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      byte ptr [edx], cl
        sete              dl
        ret

asm_test::compare_exchange::u8::relaxed_relaxed:
        movzx             eax, byte ptr [esp + 0x8]
        movzx             ecx, byte ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      byte ptr [edx], cl
        sete              dl
        ret

asm_test::compare_exchange::u8::release_acquire:
        movzx             eax, byte ptr [esp + 0x8]
        movzx             ecx, byte ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      byte ptr [edx], cl
        sete              dl
        ret

asm_test::compare_exchange::u8::release_relaxed:
        movzx             eax, byte ptr [esp + 0x8]
        movzx             ecx, byte ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      byte ptr [edx], cl
        sete              dl
        ret

asm_test::compare_exchange::u16::acqrel_seqcst:
        movzx             eax, word ptr [esp + 0x8]
        movzx             ecx, word ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      word ptr [edx], cx
        sete              dl
        ret

asm_test::compare_exchange::u16::seqcst_seqcst:
        movzx             eax, word ptr [esp + 0x8]
        movzx             ecx, word ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      word ptr [edx], cx
        sete              dl
        ret

asm_test::compare_exchange::u16::acqrel_acquire:
        movzx             eax, word ptr [esp + 0x8]
        movzx             ecx, word ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      word ptr [edx], cx
        sete              dl
        ret

asm_test::compare_exchange::u16::acqrel_relaxed:
        movzx             eax, word ptr [esp + 0x8]
        movzx             ecx, word ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      word ptr [edx], cx
        sete              dl
        ret

asm_test::compare_exchange::u16::acquire_seqcst:
        movzx             eax, word ptr [esp + 0x8]
        movzx             ecx, word ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      word ptr [edx], cx
        sete              dl
        ret

asm_test::compare_exchange::u16::relaxed_seqcst:
        movzx             eax, word ptr [esp + 0x8]
        movzx             ecx, word ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      word ptr [edx], cx
        sete              dl
        ret

asm_test::compare_exchange::u16::release_seqcst:
        movzx             eax, word ptr [esp + 0x8]
        movzx             ecx, word ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      word ptr [edx], cx
        sete              dl
        ret

asm_test::compare_exchange::u16::seqcst_acquire:
        movzx             eax, word ptr [esp + 0x8]
        movzx             ecx, word ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      word ptr [edx], cx
        sete              dl
        ret

asm_test::compare_exchange::u16::seqcst_relaxed:
        movzx             eax, word ptr [esp + 0x8]
        movzx             ecx, word ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      word ptr [edx], cx
        sete              dl
        ret

asm_test::compare_exchange::u16::acquire_acquire:
        movzx             eax, word ptr [esp + 0x8]
        movzx             ecx, word ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      word ptr [edx], cx
        sete              dl
        ret

asm_test::compare_exchange::u16::acquire_relaxed:
        movzx             eax, word ptr [esp + 0x8]
        movzx             ecx, word ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      word ptr [edx], cx
        sete              dl
        ret

asm_test::compare_exchange::u16::relaxed_acquire:
        movzx             eax, word ptr [esp + 0x8]
        movzx             ecx, word ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      word ptr [edx], cx
        sete              dl
        ret

asm_test::compare_exchange::u16::relaxed_relaxed:
        movzx             eax, word ptr [esp + 0x8]
        movzx             ecx, word ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      word ptr [edx], cx
        sete              dl
        ret

asm_test::compare_exchange::u16::release_acquire:
        movzx             eax, word ptr [esp + 0x8]
        movzx             ecx, word ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      word ptr [edx], cx
        sete              dl
        ret

asm_test::compare_exchange::u16::release_relaxed:
        movzx             eax, word ptr [esp + 0x8]
        movzx             ecx, word ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      word ptr [edx], cx
        sete              dl
        ret

asm_test::compare_exchange::u32::acqrel_seqcst:
        mov               eax, dword ptr [esp + 0x8]
        mov               ecx, dword ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      dword ptr [edx], ecx
        sete              dl
        ret

asm_test::compare_exchange::u32::seqcst_seqcst:
        mov               eax, dword ptr [esp + 0x8]
        mov               ecx, dword ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      dword ptr [edx], ecx
        sete              dl
        ret

asm_test::compare_exchange::u32::acqrel_acquire:
        mov               eax, dword ptr [esp + 0x8]
        mov               ecx, dword ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      dword ptr [edx], ecx
        sete              dl
        ret

asm_test::compare_exchange::u32::acqrel_relaxed:
        mov               eax, dword ptr [esp + 0x8]
        mov               ecx, dword ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      dword ptr [edx], ecx
        sete              dl
        ret

asm_test::compare_exchange::u32::acquire_seqcst:
        mov               eax, dword ptr [esp + 0x8]
        mov               ecx, dword ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      dword ptr [edx], ecx
        sete              dl
        ret

asm_test::compare_exchange::u32::relaxed_seqcst:
        mov               eax, dword ptr [esp + 0x8]
        mov               ecx, dword ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      dword ptr [edx], ecx
        sete              dl
        ret

asm_test::compare_exchange::u32::release_seqcst:
        mov               eax, dword ptr [esp + 0x8]
        mov               ecx, dword ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      dword ptr [edx], ecx
        sete              dl
        ret

asm_test::compare_exchange::u32::seqcst_acquire:
        mov               eax, dword ptr [esp + 0x8]
        mov               ecx, dword ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      dword ptr [edx], ecx
        sete              dl
        ret

asm_test::compare_exchange::u32::seqcst_relaxed:
        mov               eax, dword ptr [esp + 0x8]
        mov               ecx, dword ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      dword ptr [edx], ecx
        sete              dl
        ret

asm_test::compare_exchange::u32::acquire_acquire:
        mov               eax, dword ptr [esp + 0x8]
        mov               ecx, dword ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      dword ptr [edx], ecx
        sete              dl
        ret

asm_test::compare_exchange::u32::acquire_relaxed:
        mov               eax, dword ptr [esp + 0x8]
        mov               ecx, dword ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      dword ptr [edx], ecx
        sete              dl
        ret

asm_test::compare_exchange::u32::relaxed_acquire:
        mov               eax, dword ptr [esp + 0x8]
        mov               ecx, dword ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      dword ptr [edx], ecx
        sete              dl
        ret

asm_test::compare_exchange::u32::relaxed_relaxed:
        mov               eax, dword ptr [esp + 0x8]
        mov               ecx, dword ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      dword ptr [edx], ecx
        sete              dl
        ret

asm_test::compare_exchange::u32::release_acquire:
        mov               eax, dword ptr [esp + 0x8]
        mov               ecx, dword ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      dword ptr [edx], ecx
        sete              dl
        ret

asm_test::compare_exchange::u32::release_relaxed:
        mov               eax, dword ptr [esp + 0x8]
        mov               ecx, dword ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      dword ptr [edx], ecx
        sete              dl
        ret

asm_test::compare_exchange::u64::acqrel_seqcst:
        push              ebx
        push              edi
        push              esi
        mov               esi, dword ptr [esp + 0x10]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        sete              byte ptr [esi + 0x8]
        mov               eax, esi
        pop               esi
        pop               edi
        pop               ebx
        ret               0x4

asm_test::compare_exchange::u64::seqcst_seqcst:
        push              ebx
        push              edi
        push              esi
        mov               esi, dword ptr [esp + 0x10]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        sete              byte ptr [esi + 0x8]
        mov               eax, esi
        pop               esi
        pop               edi
        pop               ebx
        ret               0x4

asm_test::compare_exchange::u64::acqrel_acquire:
        push              ebx
        push              edi
        push              esi
        mov               esi, dword ptr [esp + 0x10]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        sete              byte ptr [esi + 0x8]
        mov               eax, esi
        pop               esi
        pop               edi
        pop               ebx
        ret               0x4

asm_test::compare_exchange::u64::acqrel_relaxed:
        push              ebx
        push              edi
        push              esi
        mov               esi, dword ptr [esp + 0x10]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        sete              byte ptr [esi + 0x8]
        mov               eax, esi
        pop               esi
        pop               edi
        pop               ebx
        ret               0x4

asm_test::compare_exchange::u64::acquire_seqcst:
        push              ebx
        push              edi
        push              esi
        mov               esi, dword ptr [esp + 0x10]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        sete              byte ptr [esi + 0x8]
        mov               eax, esi
        pop               esi
        pop               edi
        pop               ebx
        ret               0x4

asm_test::compare_exchange::u64::relaxed_seqcst:
        push              ebx
        push              edi
        push              esi
        mov               esi, dword ptr [esp + 0x10]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        sete              byte ptr [esi + 0x8]
        mov               eax, esi
        pop               esi
        pop               edi
        pop               ebx
        ret               0x4

asm_test::compare_exchange::u64::release_seqcst:
        push              ebx
        push              edi
        push              esi
        mov               esi, dword ptr [esp + 0x10]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        sete              byte ptr [esi + 0x8]
        mov               eax, esi
        pop               esi
        pop               edi
        pop               ebx
        ret               0x4

asm_test::compare_exchange::u64::seqcst_acquire:
        push              ebx
        push              edi
        push              esi
        mov               esi, dword ptr [esp + 0x10]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        sete              byte ptr [esi + 0x8]
        mov               eax, esi
        pop               esi
        pop               edi
        pop               ebx
        ret               0x4

asm_test::compare_exchange::u64::seqcst_relaxed:
        push              ebx
        push              edi
        push              esi
        mov               esi, dword ptr [esp + 0x10]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        sete              byte ptr [esi + 0x8]
        mov               eax, esi
        pop               esi
        pop               edi
        pop               ebx
        ret               0x4

asm_test::compare_exchange::u64::acquire_acquire:
        push              ebx
        push              edi
        push              esi
        mov               esi, dword ptr [esp + 0x10]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        sete              byte ptr [esi + 0x8]
        mov               eax, esi
        pop               esi
        pop               edi
        pop               ebx
        ret               0x4

asm_test::compare_exchange::u64::acquire_relaxed:
        push              ebx
        push              edi
        push              esi
        mov               esi, dword ptr [esp + 0x10]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        sete              byte ptr [esi + 0x8]
        mov               eax, esi
        pop               esi
        pop               edi
        pop               ebx
        ret               0x4

asm_test::compare_exchange::u64::relaxed_acquire:
        push              ebx
        push              edi
        push              esi
        mov               esi, dword ptr [esp + 0x10]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        sete              byte ptr [esi + 0x8]
        mov               eax, esi
        pop               esi
        pop               edi
        pop               ebx
        ret               0x4

asm_test::compare_exchange::u64::relaxed_relaxed:
        push              ebx
        push              edi
        push              esi
        mov               esi, dword ptr [esp + 0x10]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        sete              byte ptr [esi + 0x8]
        mov               eax, esi
        pop               esi
        pop               edi
        pop               ebx
        ret               0x4

asm_test::compare_exchange::u64::release_acquire:
        push              ebx
        push              edi
        push              esi
        mov               esi, dword ptr [esp + 0x10]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        sete              byte ptr [esi + 0x8]
        mov               eax, esi
        pop               esi
        pop               edi
        pop               ebx
        ret               0x4

asm_test::compare_exchange::u64::release_relaxed:
        push              ebx
        push              edi
        push              esi
        mov               esi, dword ptr [esp + 0x10]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        sete              byte ptr [esi + 0x8]
        mov               eax, esi
        pop               esi
        pop               edi
        pop               ebx
        ret               0x4

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        movzx             eax, byte ptr [esp + 0x8]
        movzx             ecx, byte ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      byte ptr [edx], cl
        sete              dl
        ret

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        movzx             eax, byte ptr [esp + 0x8]
        movzx             ecx, byte ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      byte ptr [edx], cl
        sete              dl
        ret

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        movzx             eax, byte ptr [esp + 0x8]
        movzx             ecx, byte ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      byte ptr [edx], cl
        sete              dl
        ret

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        movzx             eax, byte ptr [esp + 0x8]
        movzx             ecx, byte ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      byte ptr [edx], cl
        sete              dl
        ret

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        movzx             eax, byte ptr [esp + 0x8]
        movzx             ecx, byte ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      byte ptr [edx], cl
        sete              dl
        ret

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        movzx             eax, byte ptr [esp + 0x8]
        movzx             ecx, byte ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      byte ptr [edx], cl
        sete              dl
        ret

asm_test::compare_exchange_weak::u8::release_seqcst:
        movzx             eax, byte ptr [esp + 0x8]
        movzx             ecx, byte ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      byte ptr [edx], cl
        sete              dl
        ret

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        movzx             eax, byte ptr [esp + 0x8]
        movzx             ecx, byte ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      byte ptr [edx], cl
        sete              dl
        ret

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        movzx             eax, byte ptr [esp + 0x8]
        movzx             ecx, byte ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      byte ptr [edx], cl
        sete              dl
        ret

asm_test::compare_exchange_weak::u8::acquire_acquire:
        movzx             eax, byte ptr [esp + 0x8]
        movzx             ecx, byte ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      byte ptr [edx], cl
        sete              dl
        ret

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        movzx             eax, byte ptr [esp + 0x8]
        movzx             ecx, byte ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      byte ptr [edx], cl
        sete              dl
        ret

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        movzx             eax, byte ptr [esp + 0x8]
        movzx             ecx, byte ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      byte ptr [edx], cl
        sete              dl
        ret

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        movzx             eax, byte ptr [esp + 0x8]
        movzx             ecx, byte ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      byte ptr [edx], cl
        sete              dl
        ret

asm_test::compare_exchange_weak::u8::release_acquire:
        movzx             eax, byte ptr [esp + 0x8]
        movzx             ecx, byte ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      byte ptr [edx], cl
        sete              dl
        ret

asm_test::compare_exchange_weak::u8::release_relaxed:
        movzx             eax, byte ptr [esp + 0x8]
        movzx             ecx, byte ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      byte ptr [edx], cl
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        movzx             eax, word ptr [esp + 0x8]
        movzx             ecx, word ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      word ptr [edx], cx
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        movzx             eax, word ptr [esp + 0x8]
        movzx             ecx, word ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      word ptr [edx], cx
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        movzx             eax, word ptr [esp + 0x8]
        movzx             ecx, word ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      word ptr [edx], cx
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        movzx             eax, word ptr [esp + 0x8]
        movzx             ecx, word ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      word ptr [edx], cx
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        movzx             eax, word ptr [esp + 0x8]
        movzx             ecx, word ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      word ptr [edx], cx
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        movzx             eax, word ptr [esp + 0x8]
        movzx             ecx, word ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      word ptr [edx], cx
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::release_seqcst:
        movzx             eax, word ptr [esp + 0x8]
        movzx             ecx, word ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      word ptr [edx], cx
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        movzx             eax, word ptr [esp + 0x8]
        movzx             ecx, word ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      word ptr [edx], cx
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        movzx             eax, word ptr [esp + 0x8]
        movzx             ecx, word ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      word ptr [edx], cx
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::acquire_acquire:
        movzx             eax, word ptr [esp + 0x8]
        movzx             ecx, word ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      word ptr [edx], cx
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        movzx             eax, word ptr [esp + 0x8]
        movzx             ecx, word ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      word ptr [edx], cx
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        movzx             eax, word ptr [esp + 0x8]
        movzx             ecx, word ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      word ptr [edx], cx
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        movzx             eax, word ptr [esp + 0x8]
        movzx             ecx, word ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      word ptr [edx], cx
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::release_acquire:
        movzx             eax, word ptr [esp + 0x8]
        movzx             ecx, word ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      word ptr [edx], cx
        sete              dl
        ret

asm_test::compare_exchange_weak::u16::release_relaxed:
        movzx             eax, word ptr [esp + 0x8]
        movzx             ecx, word ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      word ptr [edx], cx
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        mov               eax, dword ptr [esp + 0x8]
        mov               ecx, dword ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      dword ptr [edx], ecx
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        mov               eax, dword ptr [esp + 0x8]
        mov               ecx, dword ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      dword ptr [edx], ecx
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        mov               eax, dword ptr [esp + 0x8]
        mov               ecx, dword ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      dword ptr [edx], ecx
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        mov               eax, dword ptr [esp + 0x8]
        mov               ecx, dword ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      dword ptr [edx], ecx
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        mov               eax, dword ptr [esp + 0x8]
        mov               ecx, dword ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      dword ptr [edx], ecx
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        mov               eax, dword ptr [esp + 0x8]
        mov               ecx, dword ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      dword ptr [edx], ecx
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::release_seqcst:
        mov               eax, dword ptr [esp + 0x8]
        mov               ecx, dword ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      dword ptr [edx], ecx
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        mov               eax, dword ptr [esp + 0x8]
        mov               ecx, dword ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      dword ptr [edx], ecx
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        mov               eax, dword ptr [esp + 0x8]
        mov               ecx, dword ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      dword ptr [edx], ecx
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::acquire_acquire:
        mov               eax, dword ptr [esp + 0x8]
        mov               ecx, dword ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      dword ptr [edx], ecx
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        mov               eax, dword ptr [esp + 0x8]
        mov               ecx, dword ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      dword ptr [edx], ecx
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        mov               eax, dword ptr [esp + 0x8]
        mov               ecx, dword ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      dword ptr [edx], ecx
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        mov               eax, dword ptr [esp + 0x8]
        mov               ecx, dword ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      dword ptr [edx], ecx
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::release_acquire:
        mov               eax, dword ptr [esp + 0x8]
        mov               ecx, dword ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      dword ptr [edx], ecx
        sete              dl
        ret

asm_test::compare_exchange_weak::u32::release_relaxed:
        mov               eax, dword ptr [esp + 0x8]
        mov               ecx, dword ptr [esp + 0xc]
        mov               edx, dword ptr [esp + 0x4]
        lock cmpxchg      dword ptr [edx], ecx
        sete              dl
        ret

asm_test::compare_exchange_weak::u64::acqrel_seqcst:
        push              ebx
        push              edi
        push              esi
        mov               esi, dword ptr [esp + 0x10]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        sete              byte ptr [esi + 0x8]
        mov               eax, esi
        pop               esi
        pop               edi
        pop               ebx
        ret               0x4

asm_test::compare_exchange_weak::u64::seqcst_seqcst:
        push              ebx
        push              edi
        push              esi
        mov               esi, dword ptr [esp + 0x10]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        sete              byte ptr [esi + 0x8]
        mov               eax, esi
        pop               esi
        pop               edi
        pop               ebx
        ret               0x4

asm_test::compare_exchange_weak::u64::acqrel_acquire:
        push              ebx
        push              edi
        push              esi
        mov               esi, dword ptr [esp + 0x10]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        sete              byte ptr [esi + 0x8]
        mov               eax, esi
        pop               esi
        pop               edi
        pop               ebx
        ret               0x4

asm_test::compare_exchange_weak::u64::acqrel_relaxed:
        push              ebx
        push              edi
        push              esi
        mov               esi, dword ptr [esp + 0x10]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        sete              byte ptr [esi + 0x8]
        mov               eax, esi
        pop               esi
        pop               edi
        pop               ebx
        ret               0x4

asm_test::compare_exchange_weak::u64::acquire_seqcst:
        push              ebx
        push              edi
        push              esi
        mov               esi, dword ptr [esp + 0x10]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        sete              byte ptr [esi + 0x8]
        mov               eax, esi
        pop               esi
        pop               edi
        pop               ebx
        ret               0x4

asm_test::compare_exchange_weak::u64::relaxed_seqcst:
        push              ebx
        push              edi
        push              esi
        mov               esi, dword ptr [esp + 0x10]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        sete              byte ptr [esi + 0x8]
        mov               eax, esi
        pop               esi
        pop               edi
        pop               ebx
        ret               0x4

asm_test::compare_exchange_weak::u64::release_seqcst:
        push              ebx
        push              edi
        push              esi
        mov               esi, dword ptr [esp + 0x10]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        sete              byte ptr [esi + 0x8]
        mov               eax, esi
        pop               esi
        pop               edi
        pop               ebx
        ret               0x4

asm_test::compare_exchange_weak::u64::seqcst_acquire:
        push              ebx
        push              edi
        push              esi
        mov               esi, dword ptr [esp + 0x10]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        sete              byte ptr [esi + 0x8]
        mov               eax, esi
        pop               esi
        pop               edi
        pop               ebx
        ret               0x4

asm_test::compare_exchange_weak::u64::seqcst_relaxed:
        push              ebx
        push              edi
        push              esi
        mov               esi, dword ptr [esp + 0x10]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        sete              byte ptr [esi + 0x8]
        mov               eax, esi
        pop               esi
        pop               edi
        pop               ebx
        ret               0x4

asm_test::compare_exchange_weak::u64::acquire_acquire:
        push              ebx
        push              edi
        push              esi
        mov               esi, dword ptr [esp + 0x10]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        sete              byte ptr [esi + 0x8]
        mov               eax, esi
        pop               esi
        pop               edi
        pop               ebx
        ret               0x4

asm_test::compare_exchange_weak::u64::acquire_relaxed:
        push              ebx
        push              edi
        push              esi
        mov               esi, dword ptr [esp + 0x10]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        sete              byte ptr [esi + 0x8]
        mov               eax, esi
        pop               esi
        pop               edi
        pop               ebx
        ret               0x4

asm_test::compare_exchange_weak::u64::relaxed_acquire:
        push              ebx
        push              edi
        push              esi
        mov               esi, dword ptr [esp + 0x10]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        sete              byte ptr [esi + 0x8]
        mov               eax, esi
        pop               esi
        pop               edi
        pop               ebx
        ret               0x4

asm_test::compare_exchange_weak::u64::relaxed_relaxed:
        push              ebx
        push              edi
        push              esi
        mov               esi, dword ptr [esp + 0x10]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        sete              byte ptr [esi + 0x8]
        mov               eax, esi
        pop               esi
        pop               edi
        pop               ebx
        ret               0x4

asm_test::compare_exchange_weak::u64::release_acquire:
        push              ebx
        push              edi
        push              esi
        mov               esi, dword ptr [esp + 0x10]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        sete              byte ptr [esi + 0x8]
        mov               eax, esi
        pop               esi
        pop               edi
        pop               ebx
        ret               0x4

asm_test::compare_exchange_weak::u64::release_relaxed:
        push              ebx
        push              edi
        push              esi
        mov               esi, dword ptr [esp + 0x10]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        sete              byte ptr [esi + 0x8]
        mov               eax, esi
        pop               esi
        pop               edi
        pop               ebx
        ret               0x4

asm_test::load::u8::seqcst:
        mov               eax, dword ptr [esp + 0x4]
        movzx             eax, byte ptr [eax]
        ret

asm_test::load::u8::acquire:
        mov               eax, dword ptr [esp + 0x4]
        movzx             eax, byte ptr [eax]
        ret

asm_test::load::u8::relaxed:
        mov               eax, dword ptr [esp + 0x4]
        movzx             eax, byte ptr [eax]
        ret

asm_test::load::u16::seqcst:
        mov               eax, dword ptr [esp + 0x4]
        movzx             eax, word ptr [eax]
        ret

asm_test::load::u16::acquire:
        mov               eax, dword ptr [esp + 0x4]
        movzx             eax, word ptr [eax]
        ret

asm_test::load::u16::relaxed:
        mov               eax, dword ptr [esp + 0x4]
        movzx             eax, word ptr [eax]
        ret

asm_test::load::u32::seqcst:
        mov               eax, dword ptr [esp + 0x4]
        mov               eax, dword ptr [eax]
        ret

asm_test::load::u32::acquire:
        mov               eax, dword ptr [esp + 0x4]
        mov               eax, dword ptr [eax]
        ret

asm_test::load::u32::relaxed:
        mov               eax, dword ptr [esp + 0x4]
        mov               eax, dword ptr [eax]
        ret

asm_test::load::u64::seqcst:
        sub               esp, 0xc
        mov               eax, dword ptr [esp + 0x10]
        fild              qword ptr [eax]
        fistp             qword ptr [esp]
        mov               eax, dword ptr [esp]
        mov               edx, dword ptr [esp + 0x4]
        add               esp, 0xc
        ret

asm_test::load::u64::acquire:
        sub               esp, 0xc
        mov               eax, dword ptr [esp + 0x10]
        fild              qword ptr [eax]
        fistp             qword ptr [esp]
        mov               eax, dword ptr [esp]
        mov               edx, dword ptr [esp + 0x4]
        add               esp, 0xc
        ret

asm_test::load::u64::relaxed:
        sub               esp, 0xc
        mov               eax, dword ptr [esp + 0x10]
        fild              qword ptr [eax]
        fistp             qword ptr [esp]
        mov               eax, dword ptr [esp]
        mov               edx, dword ptr [esp + 0x4]
        add               esp, 0xc
        ret

asm_test::swap::u8::acqrel:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             eax, byte ptr [esp + 0x8]
        xchg              byte ptr [ecx], al
        ret

asm_test::swap::u8::seqcst:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             eax, byte ptr [esp + 0x8]
        xchg              byte ptr [ecx], al
        ret

asm_test::swap::u8::acquire:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             eax, byte ptr [esp + 0x8]
        xchg              byte ptr [ecx], al
        ret

asm_test::swap::u8::relaxed:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             eax, byte ptr [esp + 0x8]
        xchg              byte ptr [ecx], al
        ret

asm_test::swap::u8::release:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             eax, byte ptr [esp + 0x8]
        xchg              byte ptr [ecx], al
        ret

asm_test::swap::u16::acqrel:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             eax, word ptr [esp + 0x8]
        xchg              word ptr [ecx], ax
        ret

asm_test::swap::u16::seqcst:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             eax, word ptr [esp + 0x8]
        xchg              word ptr [ecx], ax
        ret

asm_test::swap::u16::acquire:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             eax, word ptr [esp + 0x8]
        xchg              word ptr [ecx], ax
        ret

asm_test::swap::u16::relaxed:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             eax, word ptr [esp + 0x8]
        xchg              word ptr [ecx], ax
        ret

asm_test::swap::u16::release:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             eax, word ptr [esp + 0x8]
        xchg              word ptr [ecx], ax
        ret

asm_test::swap::u32::acqrel:
        mov               ecx, dword ptr [esp + 0x4]
        mov               eax, dword ptr [esp + 0x8]
        xchg              dword ptr [ecx], eax
        ret

asm_test::swap::u32::seqcst:
        mov               ecx, dword ptr [esp + 0x4]
        mov               eax, dword ptr [esp + 0x8]
        xchg              dword ptr [ecx], eax
        ret

asm_test::swap::u32::acquire:
        mov               ecx, dword ptr [esp + 0x4]
        mov               eax, dword ptr [esp + 0x8]
        xchg              dword ptr [ecx], eax
        ret

asm_test::swap::u32::relaxed:
        mov               ecx, dword ptr [esp + 0x4]
        mov               eax, dword ptr [esp + 0x8]
        xchg              dword ptr [ecx], eax
        ret

asm_test::swap::u32::release:
        mov               ecx, dword ptr [esp + 0x4]
        mov               eax, dword ptr [esp + 0x8]
        xchg              dword ptr [ecx], eax
        ret

asm_test::swap::u64::acqrel:
        push              ebx
        push              esi
        mov               ecx, dword ptr [esp + 0x14]
        mov               ebx, dword ptr [esp + 0x10]
        mov               esi, dword ptr [esp + 0xc]
        mov               eax, dword ptr [esi]
        mov               edx, dword ptr [esi + 0x4]
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
0:
        lock cmpxchg8b    qword ptr [esi]
        jne               0b
        pop               esi
        pop               ebx
        ret

asm_test::swap::u64::seqcst:
        push              ebx
        push              esi
        mov               ecx, dword ptr [esp + 0x14]
        mov               ebx, dword ptr [esp + 0x10]
        mov               esi, dword ptr [esp + 0xc]
        mov               eax, dword ptr [esi]
        mov               edx, dword ptr [esi + 0x4]
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
0:
        lock cmpxchg8b    qword ptr [esi]
        jne               0b
        pop               esi
        pop               ebx
        ret

asm_test::swap::u64::acquire:
        push              ebx
        push              esi
        mov               ecx, dword ptr [esp + 0x14]
        mov               ebx, dword ptr [esp + 0x10]
        mov               esi, dword ptr [esp + 0xc]
        mov               eax, dword ptr [esi]
        mov               edx, dword ptr [esi + 0x4]
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
0:
        lock cmpxchg8b    qword ptr [esi]
        jne               0b
        pop               esi
        pop               ebx
        ret

asm_test::swap::u64::relaxed:
        push              ebx
        push              esi
        mov               ecx, dword ptr [esp + 0x14]
        mov               ebx, dword ptr [esp + 0x10]
        mov               esi, dword ptr [esp + 0xc]
        mov               eax, dword ptr [esi]
        mov               edx, dword ptr [esi + 0x4]
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
0:
        lock cmpxchg8b    qword ptr [esi]
        jne               0b
        pop               esi
        pop               ebx
        ret

asm_test::swap::u64::release:
        push              ebx
        push              esi
        mov               ecx, dword ptr [esp + 0x14]
        mov               ebx, dword ptr [esp + 0x10]
        mov               esi, dword ptr [esp + 0xc]
        mov               eax, dword ptr [esi]
        mov               edx, dword ptr [esi + 0x4]
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
0:
        lock cmpxchg8b    qword ptr [esi]
        jne               0b
        pop               esi
        pop               ebx
        ret

asm_test::store::u8::seqcst:
        mov               eax, dword ptr [esp + 0x4]
        movzx             ecx, byte ptr [esp + 0x8]
        xchg              byte ptr [eax], cl
        ret

asm_test::store::u8::relaxed:
        movzx             eax, byte ptr [esp + 0x8]
        mov               ecx, dword ptr [esp + 0x4]
        mov               byte ptr [ecx], al
        ret

asm_test::store::u8::release:
        movzx             eax, byte ptr [esp + 0x8]
        mov               ecx, dword ptr [esp + 0x4]
        mov               byte ptr [ecx], al
        ret

asm_test::store::u16::seqcst:
        mov               eax, dword ptr [esp + 0x4]
        movzx             ecx, word ptr [esp + 0x8]
        xchg              word ptr [eax], cx
        ret

asm_test::store::u16::relaxed:
        movzx             eax, word ptr [esp + 0x8]
        mov               ecx, dword ptr [esp + 0x4]
        mov               word ptr [ecx], ax
        ret

asm_test::store::u16::release:
        movzx             eax, word ptr [esp + 0x8]
        mov               ecx, dword ptr [esp + 0x4]
        mov               word ptr [ecx], ax
        ret

asm_test::store::u32::seqcst:
        mov               eax, dword ptr [esp + 0x4]
        mov               ecx, dword ptr [esp + 0x8]
        xchg              dword ptr [eax], ecx
        ret

asm_test::store::u32::relaxed:
        mov               eax, dword ptr [esp + 0x8]
        mov               ecx, dword ptr [esp + 0x4]
        mov               dword ptr [ecx], eax
        ret

asm_test::store::u32::release:
        mov               eax, dword ptr [esp + 0x8]
        mov               ecx, dword ptr [esp + 0x4]
        mov               dword ptr [ecx], eax
        ret

asm_test::store::u64::seqcst:
        sub               esp, 0xc
        mov               eax, dword ptr [esp + 0x10]
        mov               ecx, dword ptr [esp + 0x14]
        mov               edx, dword ptr [esp + 0x18]
        mov               dword ptr [esp + 0x4], edx
        mov               dword ptr [esp], ecx
        fild              qword ptr [esp]
        fistp             qword ptr [eax]
        lock or           dword ptr [esp], 0x0
        add               esp, 0xc
        ret

asm_test::store::u64::relaxed:
        sub               esp, 0xc
        mov               eax, dword ptr [esp + 0x10]
        mov               ecx, dword ptr [esp + 0x14]
        mov               edx, dword ptr [esp + 0x18]
        mov               dword ptr [esp + 0x4], edx
        mov               dword ptr [esp], ecx
        fild              qword ptr [esp]
        fistp             qword ptr [eax]
        add               esp, 0xc
        ret

asm_test::store::u64::release:
        sub               esp, 0xc
        mov               eax, dword ptr [esp + 0x10]
        mov               ecx, dword ptr [esp + 0x14]
        mov               edx, dword ptr [esp + 0x18]
        mov               dword ptr [esp + 0x4], edx
        mov               dword ptr [esp], ecx
        fild              qword ptr [esp]
        fistp             qword ptr [eax]
        add               esp, 0xc
        ret

