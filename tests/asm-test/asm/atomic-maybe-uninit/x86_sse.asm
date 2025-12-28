asm_test::compare_exchange::u8::acqrel_seqcst:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, byte ptr [esp + 0xc]
        movzx             eax, byte ptr [esp + 0x8]
        lock cmpxchg      byte ptr [ecx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u8::seqcst_seqcst:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, byte ptr [esp + 0xc]
        movzx             eax, byte ptr [esp + 0x8]
        lock cmpxchg      byte ptr [ecx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u8::acqrel_acquire:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, byte ptr [esp + 0xc]
        movzx             eax, byte ptr [esp + 0x8]
        lock cmpxchg      byte ptr [ecx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u8::acqrel_relaxed:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, byte ptr [esp + 0xc]
        movzx             eax, byte ptr [esp + 0x8]
        lock cmpxchg      byte ptr [ecx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u8::acquire_seqcst:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, byte ptr [esp + 0xc]
        movzx             eax, byte ptr [esp + 0x8]
        lock cmpxchg      byte ptr [ecx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u8::relaxed_seqcst:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, byte ptr [esp + 0xc]
        movzx             eax, byte ptr [esp + 0x8]
        lock cmpxchg      byte ptr [ecx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u8::release_seqcst:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, byte ptr [esp + 0xc]
        movzx             eax, byte ptr [esp + 0x8]
        lock cmpxchg      byte ptr [ecx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u8::seqcst_acquire:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, byte ptr [esp + 0xc]
        movzx             eax, byte ptr [esp + 0x8]
        lock cmpxchg      byte ptr [ecx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u8::seqcst_relaxed:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, byte ptr [esp + 0xc]
        movzx             eax, byte ptr [esp + 0x8]
        lock cmpxchg      byte ptr [ecx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u8::acquire_acquire:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, byte ptr [esp + 0xc]
        movzx             eax, byte ptr [esp + 0x8]
        lock cmpxchg      byte ptr [ecx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u8::acquire_relaxed:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, byte ptr [esp + 0xc]
        movzx             eax, byte ptr [esp + 0x8]
        lock cmpxchg      byte ptr [ecx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u8::relaxed_acquire:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, byte ptr [esp + 0xc]
        movzx             eax, byte ptr [esp + 0x8]
        lock cmpxchg      byte ptr [ecx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u8::relaxed_relaxed:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, byte ptr [esp + 0xc]
        movzx             eax, byte ptr [esp + 0x8]
        lock cmpxchg      byte ptr [ecx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u8::release_acquire:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, byte ptr [esp + 0xc]
        movzx             eax, byte ptr [esp + 0x8]
        lock cmpxchg      byte ptr [ecx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u8::release_relaxed:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, byte ptr [esp + 0xc]
        movzx             eax, byte ptr [esp + 0x8]
        lock cmpxchg      byte ptr [ecx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::acqrel_seqcst:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, word ptr [esp + 0xc]
        movzx             eax, word ptr [esp + 0x8]
        lock cmpxchg      word ptr [ecx], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::seqcst_seqcst:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, word ptr [esp + 0xc]
        movzx             eax, word ptr [esp + 0x8]
        lock cmpxchg      word ptr [ecx], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::acqrel_acquire:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, word ptr [esp + 0xc]
        movzx             eax, word ptr [esp + 0x8]
        lock cmpxchg      word ptr [ecx], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::acqrel_relaxed:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, word ptr [esp + 0xc]
        movzx             eax, word ptr [esp + 0x8]
        lock cmpxchg      word ptr [ecx], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::acquire_seqcst:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, word ptr [esp + 0xc]
        movzx             eax, word ptr [esp + 0x8]
        lock cmpxchg      word ptr [ecx], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::relaxed_seqcst:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, word ptr [esp + 0xc]
        movzx             eax, word ptr [esp + 0x8]
        lock cmpxchg      word ptr [ecx], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::release_seqcst:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, word ptr [esp + 0xc]
        movzx             eax, word ptr [esp + 0x8]
        lock cmpxchg      word ptr [ecx], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::seqcst_acquire:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, word ptr [esp + 0xc]
        movzx             eax, word ptr [esp + 0x8]
        lock cmpxchg      word ptr [ecx], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::seqcst_relaxed:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, word ptr [esp + 0xc]
        movzx             eax, word ptr [esp + 0x8]
        lock cmpxchg      word ptr [ecx], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::acquire_acquire:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, word ptr [esp + 0xc]
        movzx             eax, word ptr [esp + 0x8]
        lock cmpxchg      word ptr [ecx], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::acquire_relaxed:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, word ptr [esp + 0xc]
        movzx             eax, word ptr [esp + 0x8]
        lock cmpxchg      word ptr [ecx], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::relaxed_acquire:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, word ptr [esp + 0xc]
        movzx             eax, word ptr [esp + 0x8]
        lock cmpxchg      word ptr [ecx], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::relaxed_relaxed:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, word ptr [esp + 0xc]
        movzx             eax, word ptr [esp + 0x8]
        lock cmpxchg      word ptr [ecx], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::release_acquire:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, word ptr [esp + 0xc]
        movzx             eax, word ptr [esp + 0x8]
        lock cmpxchg      word ptr [ecx], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u16::release_relaxed:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, word ptr [esp + 0xc]
        movzx             eax, word ptr [esp + 0x8]
        lock cmpxchg      word ptr [ecx], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::acqrel_seqcst:
        mov               ecx, dword ptr [esp + 0x4]
        mov               edx, dword ptr [esp + 0xc]
        mov               eax, dword ptr [esp + 0x8]
        lock cmpxchg      dword ptr [ecx], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::seqcst_seqcst:
        mov               ecx, dword ptr [esp + 0x4]
        mov               edx, dword ptr [esp + 0xc]
        mov               eax, dword ptr [esp + 0x8]
        lock cmpxchg      dword ptr [ecx], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::acqrel_acquire:
        mov               ecx, dword ptr [esp + 0x4]
        mov               edx, dword ptr [esp + 0xc]
        mov               eax, dword ptr [esp + 0x8]
        lock cmpxchg      dword ptr [ecx], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::acqrel_relaxed:
        mov               ecx, dword ptr [esp + 0x4]
        mov               edx, dword ptr [esp + 0xc]
        mov               eax, dword ptr [esp + 0x8]
        lock cmpxchg      dword ptr [ecx], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::acquire_seqcst:
        mov               ecx, dword ptr [esp + 0x4]
        mov               edx, dword ptr [esp + 0xc]
        mov               eax, dword ptr [esp + 0x8]
        lock cmpxchg      dword ptr [ecx], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::relaxed_seqcst:
        mov               ecx, dword ptr [esp + 0x4]
        mov               edx, dword ptr [esp + 0xc]
        mov               eax, dword ptr [esp + 0x8]
        lock cmpxchg      dword ptr [ecx], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::release_seqcst:
        mov               ecx, dword ptr [esp + 0x4]
        mov               edx, dword ptr [esp + 0xc]
        mov               eax, dword ptr [esp + 0x8]
        lock cmpxchg      dword ptr [ecx], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::seqcst_acquire:
        mov               ecx, dword ptr [esp + 0x4]
        mov               edx, dword ptr [esp + 0xc]
        mov               eax, dword ptr [esp + 0x8]
        lock cmpxchg      dword ptr [ecx], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::seqcst_relaxed:
        mov               ecx, dword ptr [esp + 0x4]
        mov               edx, dword ptr [esp + 0xc]
        mov               eax, dword ptr [esp + 0x8]
        lock cmpxchg      dword ptr [ecx], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::acquire_acquire:
        mov               ecx, dword ptr [esp + 0x4]
        mov               edx, dword ptr [esp + 0xc]
        mov               eax, dword ptr [esp + 0x8]
        lock cmpxchg      dword ptr [ecx], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::acquire_relaxed:
        mov               ecx, dword ptr [esp + 0x4]
        mov               edx, dword ptr [esp + 0xc]
        mov               eax, dword ptr [esp + 0x8]
        lock cmpxchg      dword ptr [ecx], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::relaxed_acquire:
        mov               ecx, dword ptr [esp + 0x4]
        mov               edx, dword ptr [esp + 0xc]
        mov               eax, dword ptr [esp + 0x8]
        lock cmpxchg      dword ptr [ecx], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::relaxed_relaxed:
        mov               ecx, dword ptr [esp + 0x4]
        mov               edx, dword ptr [esp + 0xc]
        mov               eax, dword ptr [esp + 0x8]
        lock cmpxchg      dword ptr [ecx], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::release_acquire:
        mov               ecx, dword ptr [esp + 0x4]
        mov               edx, dword ptr [esp + 0xc]
        mov               eax, dword ptr [esp + 0x8]
        lock cmpxchg      dword ptr [ecx], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u32::release_relaxed:
        mov               ecx, dword ptr [esp + 0x4]
        mov               edx, dword ptr [esp + 0xc]
        mov               eax, dword ptr [esp + 0x8]
        lock cmpxchg      dword ptr [ecx], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange::u64::acqrel_seqcst:
        push              ebx
        push              edi
        push              esi
        mov               esi, dword ptr [esp + 0x10]
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        sete              cl
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        mov               byte ptr [esi + 0x8], cl
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
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        sete              cl
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        mov               byte ptr [esi + 0x8], cl
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
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        sete              cl
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        mov               byte ptr [esi + 0x8], cl
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
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        sete              cl
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        mov               byte ptr [esi + 0x8], cl
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
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        sete              cl
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        mov               byte ptr [esi + 0x8], cl
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
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        sete              cl
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        mov               byte ptr [esi + 0x8], cl
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
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        sete              cl
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        mov               byte ptr [esi + 0x8], cl
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
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        sete              cl
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        mov               byte ptr [esi + 0x8], cl
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
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        sete              cl
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        mov               byte ptr [esi + 0x8], cl
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
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        sete              cl
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        mov               byte ptr [esi + 0x8], cl
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
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        sete              cl
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        mov               byte ptr [esi + 0x8], cl
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
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        sete              cl
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        mov               byte ptr [esi + 0x8], cl
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
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        sete              cl
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        mov               byte ptr [esi + 0x8], cl
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
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        sete              cl
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        mov               byte ptr [esi + 0x8], cl
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
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        sete              cl
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        mov               byte ptr [esi + 0x8], cl
        mov               eax, esi
        pop               esi
        pop               edi
        pop               ebx
        ret               0x4

asm_test::compare_exchange_weak::u8::acqrel_seqcst:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, byte ptr [esp + 0xc]
        movzx             eax, byte ptr [esp + 0x8]
        lock cmpxchg      byte ptr [ecx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u8::seqcst_seqcst:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, byte ptr [esp + 0xc]
        movzx             eax, byte ptr [esp + 0x8]
        lock cmpxchg      byte ptr [ecx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u8::acqrel_acquire:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, byte ptr [esp + 0xc]
        movzx             eax, byte ptr [esp + 0x8]
        lock cmpxchg      byte ptr [ecx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u8::acqrel_relaxed:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, byte ptr [esp + 0xc]
        movzx             eax, byte ptr [esp + 0x8]
        lock cmpxchg      byte ptr [ecx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u8::acquire_seqcst:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, byte ptr [esp + 0xc]
        movzx             eax, byte ptr [esp + 0x8]
        lock cmpxchg      byte ptr [ecx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u8::relaxed_seqcst:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, byte ptr [esp + 0xc]
        movzx             eax, byte ptr [esp + 0x8]
        lock cmpxchg      byte ptr [ecx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u8::release_seqcst:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, byte ptr [esp + 0xc]
        movzx             eax, byte ptr [esp + 0x8]
        lock cmpxchg      byte ptr [ecx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u8::seqcst_acquire:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, byte ptr [esp + 0xc]
        movzx             eax, byte ptr [esp + 0x8]
        lock cmpxchg      byte ptr [ecx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u8::seqcst_relaxed:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, byte ptr [esp + 0xc]
        movzx             eax, byte ptr [esp + 0x8]
        lock cmpxchg      byte ptr [ecx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u8::acquire_acquire:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, byte ptr [esp + 0xc]
        movzx             eax, byte ptr [esp + 0x8]
        lock cmpxchg      byte ptr [ecx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u8::acquire_relaxed:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, byte ptr [esp + 0xc]
        movzx             eax, byte ptr [esp + 0x8]
        lock cmpxchg      byte ptr [ecx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u8::relaxed_acquire:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, byte ptr [esp + 0xc]
        movzx             eax, byte ptr [esp + 0x8]
        lock cmpxchg      byte ptr [ecx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u8::relaxed_relaxed:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, byte ptr [esp + 0xc]
        movzx             eax, byte ptr [esp + 0x8]
        lock cmpxchg      byte ptr [ecx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u8::release_acquire:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, byte ptr [esp + 0xc]
        movzx             eax, byte ptr [esp + 0x8]
        lock cmpxchg      byte ptr [ecx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u8::release_relaxed:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, byte ptr [esp + 0xc]
        movzx             eax, byte ptr [esp + 0x8]
        lock cmpxchg      byte ptr [ecx], dl
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::acqrel_seqcst:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, word ptr [esp + 0xc]
        movzx             eax, word ptr [esp + 0x8]
        lock cmpxchg      word ptr [ecx], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::seqcst_seqcst:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, word ptr [esp + 0xc]
        movzx             eax, word ptr [esp + 0x8]
        lock cmpxchg      word ptr [ecx], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::acqrel_acquire:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, word ptr [esp + 0xc]
        movzx             eax, word ptr [esp + 0x8]
        lock cmpxchg      word ptr [ecx], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::acqrel_relaxed:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, word ptr [esp + 0xc]
        movzx             eax, word ptr [esp + 0x8]
        lock cmpxchg      word ptr [ecx], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::acquire_seqcst:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, word ptr [esp + 0xc]
        movzx             eax, word ptr [esp + 0x8]
        lock cmpxchg      word ptr [ecx], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::relaxed_seqcst:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, word ptr [esp + 0xc]
        movzx             eax, word ptr [esp + 0x8]
        lock cmpxchg      word ptr [ecx], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::release_seqcst:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, word ptr [esp + 0xc]
        movzx             eax, word ptr [esp + 0x8]
        lock cmpxchg      word ptr [ecx], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::seqcst_acquire:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, word ptr [esp + 0xc]
        movzx             eax, word ptr [esp + 0x8]
        lock cmpxchg      word ptr [ecx], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::seqcst_relaxed:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, word ptr [esp + 0xc]
        movzx             eax, word ptr [esp + 0x8]
        lock cmpxchg      word ptr [ecx], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::acquire_acquire:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, word ptr [esp + 0xc]
        movzx             eax, word ptr [esp + 0x8]
        lock cmpxchg      word ptr [ecx], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::acquire_relaxed:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, word ptr [esp + 0xc]
        movzx             eax, word ptr [esp + 0x8]
        lock cmpxchg      word ptr [ecx], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::relaxed_acquire:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, word ptr [esp + 0xc]
        movzx             eax, word ptr [esp + 0x8]
        lock cmpxchg      word ptr [ecx], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::relaxed_relaxed:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, word ptr [esp + 0xc]
        movzx             eax, word ptr [esp + 0x8]
        lock cmpxchg      word ptr [ecx], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::release_acquire:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, word ptr [esp + 0xc]
        movzx             eax, word ptr [esp + 0x8]
        lock cmpxchg      word ptr [ecx], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u16::release_relaxed:
        mov               ecx, dword ptr [esp + 0x4]
        movzx             edx, word ptr [esp + 0xc]
        movzx             eax, word ptr [esp + 0x8]
        lock cmpxchg      word ptr [ecx], dx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::acqrel_seqcst:
        mov               ecx, dword ptr [esp + 0x4]
        mov               edx, dword ptr [esp + 0xc]
        mov               eax, dword ptr [esp + 0x8]
        lock cmpxchg      dword ptr [ecx], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::seqcst_seqcst:
        mov               ecx, dword ptr [esp + 0x4]
        mov               edx, dword ptr [esp + 0xc]
        mov               eax, dword ptr [esp + 0x8]
        lock cmpxchg      dword ptr [ecx], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::acqrel_acquire:
        mov               ecx, dword ptr [esp + 0x4]
        mov               edx, dword ptr [esp + 0xc]
        mov               eax, dword ptr [esp + 0x8]
        lock cmpxchg      dword ptr [ecx], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::acqrel_relaxed:
        mov               ecx, dword ptr [esp + 0x4]
        mov               edx, dword ptr [esp + 0xc]
        mov               eax, dword ptr [esp + 0x8]
        lock cmpxchg      dword ptr [ecx], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::acquire_seqcst:
        mov               ecx, dword ptr [esp + 0x4]
        mov               edx, dword ptr [esp + 0xc]
        mov               eax, dword ptr [esp + 0x8]
        lock cmpxchg      dword ptr [ecx], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::relaxed_seqcst:
        mov               ecx, dword ptr [esp + 0x4]
        mov               edx, dword ptr [esp + 0xc]
        mov               eax, dword ptr [esp + 0x8]
        lock cmpxchg      dword ptr [ecx], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::release_seqcst:
        mov               ecx, dword ptr [esp + 0x4]
        mov               edx, dword ptr [esp + 0xc]
        mov               eax, dword ptr [esp + 0x8]
        lock cmpxchg      dword ptr [ecx], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::seqcst_acquire:
        mov               ecx, dword ptr [esp + 0x4]
        mov               edx, dword ptr [esp + 0xc]
        mov               eax, dword ptr [esp + 0x8]
        lock cmpxchg      dword ptr [ecx], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::seqcst_relaxed:
        mov               ecx, dword ptr [esp + 0x4]
        mov               edx, dword ptr [esp + 0xc]
        mov               eax, dword ptr [esp + 0x8]
        lock cmpxchg      dword ptr [ecx], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::acquire_acquire:
        mov               ecx, dword ptr [esp + 0x4]
        mov               edx, dword ptr [esp + 0xc]
        mov               eax, dword ptr [esp + 0x8]
        lock cmpxchg      dword ptr [ecx], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::acquire_relaxed:
        mov               ecx, dword ptr [esp + 0x4]
        mov               edx, dword ptr [esp + 0xc]
        mov               eax, dword ptr [esp + 0x8]
        lock cmpxchg      dword ptr [ecx], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::relaxed_acquire:
        mov               ecx, dword ptr [esp + 0x4]
        mov               edx, dword ptr [esp + 0xc]
        mov               eax, dword ptr [esp + 0x8]
        lock cmpxchg      dword ptr [ecx], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::relaxed_relaxed:
        mov               ecx, dword ptr [esp + 0x4]
        mov               edx, dword ptr [esp + 0xc]
        mov               eax, dword ptr [esp + 0x8]
        lock cmpxchg      dword ptr [ecx], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::release_acquire:
        mov               ecx, dword ptr [esp + 0x4]
        mov               edx, dword ptr [esp + 0xc]
        mov               eax, dword ptr [esp + 0x8]
        lock cmpxchg      dword ptr [ecx], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u32::release_relaxed:
        mov               ecx, dword ptr [esp + 0x4]
        mov               edx, dword ptr [esp + 0xc]
        mov               eax, dword ptr [esp + 0x8]
        lock cmpxchg      dword ptr [ecx], edx
        sete              cl
        test              cl, cl
        setne             dl
        ret

asm_test::compare_exchange_weak::u64::acqrel_seqcst:
        push              ebx
        push              edi
        push              esi
        mov               esi, dword ptr [esp + 0x10]
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        sete              cl
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        mov               byte ptr [esi + 0x8], cl
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
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        sete              cl
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        mov               byte ptr [esi + 0x8], cl
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
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        sete              cl
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        mov               byte ptr [esi + 0x8], cl
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
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        sete              cl
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        mov               byte ptr [esi + 0x8], cl
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
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        sete              cl
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        mov               byte ptr [esi + 0x8], cl
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
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        sete              cl
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        mov               byte ptr [esi + 0x8], cl
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
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        sete              cl
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        mov               byte ptr [esi + 0x8], cl
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
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        sete              cl
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        mov               byte ptr [esi + 0x8], cl
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
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        sete              cl
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        mov               byte ptr [esi + 0x8], cl
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
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        sete              cl
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        mov               byte ptr [esi + 0x8], cl
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
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        sete              cl
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        mov               byte ptr [esi + 0x8], cl
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
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        sete              cl
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        mov               byte ptr [esi + 0x8], cl
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
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        sete              cl
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        mov               byte ptr [esi + 0x8], cl
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
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        sete              cl
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        mov               byte ptr [esi + 0x8], cl
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
        mov               ebx, dword ptr [esp + 0x20]
        mov               ecx, dword ptr [esp + 0x24]
        mov               eax, dword ptr [esp + 0x18]
        mov               edx, dword ptr [esp + 0x1c]
        mov               edi, dword ptr [esp + 0x14]
        lock cmpxchg8b    qword ptr [edi]
        sete              cl
        mov               dword ptr [esi], eax
        mov               dword ptr [esi + 0x4], edx
        mov               byte ptr [esi + 0x8], cl
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
        sub               esp, 0x1c
        mov               eax, dword ptr [esp + 0x20]
        movlps            xmm0, qword ptr [eax]   # xmm0 = mem[0,1],xmm0[2,3]
        movaps            xmmword ptr [esp], xmm0
        mov               eax, dword ptr [esp]
        mov               edx, dword ptr [esp + 0x4]
        add               esp, 0x1c
        ret

asm_test::load::u64::acquire:
        sub               esp, 0x1c
        mov               eax, dword ptr [esp + 0x20]
        movlps            xmm0, qword ptr [eax]   # xmm0 = mem[0,1],xmm0[2,3]
        movaps            xmmword ptr [esp], xmm0
        mov               eax, dword ptr [esp]
        mov               edx, dword ptr [esp + 0x4]
        add               esp, 0x1c
        ret

asm_test::load::u64::relaxed:
        sub               esp, 0x1c
        mov               eax, dword ptr [esp + 0x20]
        movlps            xmm0, qword ptr [eax]   # xmm0 = mem[0,1],xmm0[2,3]
        movaps            xmmword ptr [esp], xmm0
        mov               eax, dword ptr [esp]
        mov               edx, dword ptr [esp + 0x4]
        add               esp, 0x1c
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
        push              edi
        mov               ebx, dword ptr [esp + 0x10]
        mov               ecx, dword ptr [esp + 0x14]
        mov               edi, dword ptr [esp + 0xc]
        mov               eax, dword ptr [edi]
        mov               edx, dword ptr [edi + 0x4]
0:
        lock cmpxchg8b    qword ptr [edi]
        jne               0b
        pop               edi
        pop               ebx
        ret

asm_test::swap::u64::seqcst:
        push              ebx
        push              edi
        mov               ebx, dword ptr [esp + 0x10]
        mov               ecx, dword ptr [esp + 0x14]
        mov               edi, dword ptr [esp + 0xc]
        mov               eax, dword ptr [edi]
        mov               edx, dword ptr [edi + 0x4]
0:
        lock cmpxchg8b    qword ptr [edi]
        jne               0b
        pop               edi
        pop               ebx
        ret

asm_test::swap::u64::acquire:
        push              ebx
        push              edi
        mov               ebx, dword ptr [esp + 0x10]
        mov               ecx, dword ptr [esp + 0x14]
        mov               edi, dword ptr [esp + 0xc]
        mov               eax, dword ptr [edi]
        mov               edx, dword ptr [edi + 0x4]
0:
        lock cmpxchg8b    qword ptr [edi]
        jne               0b
        pop               edi
        pop               ebx
        ret

asm_test::swap::u64::relaxed:
        push              ebx
        push              edi
        mov               ebx, dword ptr [esp + 0x10]
        mov               ecx, dword ptr [esp + 0x14]
        mov               edi, dword ptr [esp + 0xc]
        mov               eax, dword ptr [edi]
        mov               edx, dword ptr [edi + 0x4]
0:
        lock cmpxchg8b    qword ptr [edi]
        jne               0b
        pop               edi
        pop               ebx
        ret

asm_test::swap::u64::release:
        push              ebx
        push              edi
        mov               ebx, dword ptr [esp + 0x10]
        mov               ecx, dword ptr [esp + 0x14]
        mov               edi, dword ptr [esp + 0xc]
        mov               eax, dword ptr [edi]
        mov               edx, dword ptr [edi + 0x4]
0:
        lock cmpxchg8b    qword ptr [edi]
        jne               0b
        pop               edi
        pop               ebx
        ret

asm_test::store::u8::seqcst:
        mov               eax, dword ptr [esp + 0x4]
        movzx             ecx, byte ptr [esp + 0x8]
        xchg              byte ptr [eax], cl
        ret

asm_test::store::u8::relaxed:
        mov               eax, dword ptr [esp + 0x4]
        movzx             ecx, byte ptr [esp + 0x8]
        mov               byte ptr [eax], cl
        ret

asm_test::store::u8::release:
        mov               eax, dword ptr [esp + 0x4]
        movzx             ecx, byte ptr [esp + 0x8]
        mov               byte ptr [eax], cl
        ret

asm_test::store::u16::seqcst:
        mov               eax, dword ptr [esp + 0x4]
        movzx             ecx, word ptr [esp + 0x8]
        xchg              word ptr [eax], cx
        ret

asm_test::store::u16::relaxed:
        mov               eax, dword ptr [esp + 0x4]
        movzx             ecx, word ptr [esp + 0x8]
        mov               word ptr [eax], cx
        ret

asm_test::store::u16::release:
        mov               eax, dword ptr [esp + 0x4]
        movzx             ecx, word ptr [esp + 0x8]
        mov               word ptr [eax], cx
        ret

asm_test::store::u32::seqcst:
        mov               eax, dword ptr [esp + 0x4]
        mov               ecx, dword ptr [esp + 0x8]
        xchg              dword ptr [eax], ecx
        ret

asm_test::store::u32::relaxed:
        mov               eax, dword ptr [esp + 0x4]
        mov               ecx, dword ptr [esp + 0x8]
        mov               dword ptr [eax], ecx
        ret

asm_test::store::u32::release:
        mov               eax, dword ptr [esp + 0x4]
        mov               ecx, dword ptr [esp + 0x8]
        mov               dword ptr [eax], ecx
        ret

asm_test::store::u64::seqcst:
        push              eax
        xorps             xmm0, xmm0
        mov               eax, dword ptr [esp + 0x8]
        mov               ecx, esp
        movlps            xmm0, qword ptr [esp + 0xc] # xmm0 = mem[0,1],xmm0[2,3]
        movlps            qword ptr [eax], xmm0
        xchg              dword ptr [ecx], eax
        pop               eax
        ret

asm_test::store::u64::relaxed:
        xorps             xmm0, xmm0
        mov               eax, dword ptr [esp + 0x4]
        movlps            xmm0, qword ptr [esp + 0x8] # xmm0 = mem[0,1],xmm0[2,3]
        movlps            qword ptr [eax], xmm0
        ret

asm_test::store::u64::release:
        xorps             xmm0, xmm0
        mov               eax, dword ptr [esp + 0x4]
        movlps            xmm0, qword ptr [esp + 0x8] # xmm0 = mem[0,1],xmm0[2,3]
        movlps            qword ptr [eax], xmm0
        ret

