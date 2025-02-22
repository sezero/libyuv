# Introduction

For test purposes, environment variables can be set to control libyuv behavior.  These should only be used for testing, to narrow down bugs or to test performance.

# CPU

By default the cpu is detected and the most advanced form of SIMD is used.  But you can disable instruction sets selectively, or completely, falling back on C code.  Set the variable to 1 to disable the specified instruction set.

## All CPUs

    LIBYUV_DISABLE_ASM

## Intel CPUs

    LIBYUV_DISABLE_X86
    LIBYUV_DISABLE_SSE2
    LIBYUV_DISABLE_SSSE3
    LIBYUV_DISABLE_SSE41
    LIBYUV_DISABLE_SSE42
    LIBYUV_DISABLE_AVX
    LIBYUV_DISABLE_AVX2
    LIBYUV_DISABLE_ERMS
    LIBYUV_DISABLE_FMA3
    LIBYUV_DISABLE_F16C
    LIBYUV_DISABLE_AVX512BW
    LIBYUV_DISABLE_AVX512VL
    LIBYUV_DISABLE_AVX512VNNI
    LIBYUV_DISABLE_AVX512VBMI
    LIBYUV_DISABLE_AVX512VBMI2
    LIBYUV_DISABLE_AVX512VBITALG
    LIBYUV_DISABLE_AVX10
    LIBYUV_DISABLE_AVX10_2
    LIBYUV_DISABLE_AVXVNNI
    LIBYUV_DISABLE_AVXVNNIINT8
    LIBYUV_DISABLE_AMXINT8

## Arm CPUs

    LIBYUV_DISABLE_NEON
    LIBYUV_DISABLE_NEON_DOTPROD
    LIBYUV_DISABLE_NEON_I8MM
    LIBYUV_DISABLE_SVE
    LIBYUV_DISABLE_SVE2
    LIBYUV_DISABLE_SME

## MIPS CPUs

    LIBYUV_DISABLE_MSA

## LOONGARCH CPUs

    LIBYUV_DISABLE_LSX
    LIBYUV_DISABLE_LASX

## RISCV CPUs

    LIBYUV_DISABLE_RVV

# Test Width/Height/Repeat

The unittests default to a small image (128x72) to run fast.  This can be set by environment variable to test a specific resolutions.
You can also repeat the test a specified number of iterations, allowing benchmarking and profiling.

    set LIBYUV_WIDTH=1280
    set LIBYUV_HEIGHT=720
    set LIBYUV_REPEAT=999
    set LIBYUV_FLAGS=-1
    set LIBYUV_CPU_INFO=-1
