# This is a generic makefile for libyuv for gcc.

CC?=gcc
CFLAGS?=-O2 -fomit-frame-pointer -std=gnu99 -Wall
CFLAGS+=-Iinclude/

LOCAL_OBJ_FILES := \
	source/compare.o           \
	source/compare_common.o    \
	source/compare_gcc.o       \
	source/compare_msa.o       \
	source/compare_neon.o      \
	source/compare_neon64.o    \
	source/compare_win.o       \
	source/convert.o           \
	source/convert_argb.o      \
	source/convert_from.o      \
	source/convert_from_argb.o \
	source/convert_to_argb.o   \
	source/convert_to_i420.o   \
	source/cpu_id.o            \
	source/planar_functions.o  \
	source/rotate.o            \
	source/rotate_any.o        \
	source/rotate_argb.o       \
	source/rotate_common.o     \
	source/rotate_gcc.o        \
	source/rotate_lsx.o        \
	source/rotate_msa.o        \
	source/rotate_neon.o       \
	source/rotate_neon64.o     \
	source/rotate_win.o        \
	source/row_any.o           \
	source/row_common.o        \
	source/row_gcc.o           \
	source/row_lasx.o          \
	source/row_lsx.o           \
	source/row_msa.o           \
	source/row_neon.o          \
	source/row_neon64.o        \
	source/row_rvv.o           \
	source/row_win.o           \
	source/scale.o             \
	source/scale_any.o         \
	source/scale_argb.o        \
	source/scale_common.o      \
	source/scale_gcc.o         \
	source/scale_lsx.o         \
	source/scale_msa.o         \
	source/scale_neon.o        \
	source/scale_neon64.o      \
	source/scale_rgb.o         \
	source/scale_rvv.o         \
	source/scale_uv.o          \
	source/scale_win.o         \
	source/video_common.o

.c.o:
	$(CC) -c $(CFLAGS) $*.c -o $*.o

all: libyuv.a

libyuv.a: $(LOCAL_OBJ_FILES)
	$(AR) $(ARFLAGS) $@ $(LOCAL_OBJ_FILES)

clean:
	/bin/rm -f source/*.o *.ii *.s libyuv.a
