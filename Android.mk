# This is the Android makefile for libyuv for NDK.
LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
    source/compare.c           \
    source/compare_common.c    \
    source/compare_gcc.c       \
    source/compare_msa.c       \
    source/compare_neon.c      \
    source/compare_neon64.c    \
    source/compare_win.c       \
    source/convert.c           \
    source/convert_argb.c      \
    source/convert_from.c      \
    source/convert_from_argb.c \
    source/convert_to_argb.c   \
    source/convert_to_i420.c   \
    source/cpu_id.c            \
    source/planar_functions.c  \
    source/rotate.c            \
    source/rotate_any.c        \
    source/rotate_argb.c       \
    source/rotate_common.c     \
    source/rotate_gcc.c        \
    source/rotate_msa.c        \
    source/rotate_neon.c       \
    source/rotate_neon64.c     \
    source/rotate_win.c        \
    source/row_any.c           \
    source/row_common.c        \
    source/row_gcc.c           \
    source/row_msa.c           \
    source/row_neon.c          \
    source/row_neon64.c        \
    source/row_win.c           \
    source/scale.c             \
    source/scale_any.c         \
    source/scale_argb.c        \
    source/scale_common.c      \
    source/scale_gcc.c         \
    source/scale_msa.c         \
    source/scale_neon.c        \
    source/scale_neon64.c      \
    source/scale_rgb.c         \
    source/scale_uv.c          \
    source/scale_win.c         \
    source/video_common.c

common_CFLAGS := -Wall -fexceptions -std=gnu99

LOCAL_CFLAGS += $(common_CFLAGS)
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/include
LOCAL_C_INCLUDES += $(LOCAL_PATH)/include
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/include

LOCAL_MODULE := libyuv_static
LOCAL_MODULE_TAGS := optional

include $(BUILD_STATIC_LIBRARY)

include $(CLEAR_VARS)

LOCAL_WHOLE_STATIC_LIBRARIES := libyuv_static
LOCAL_MODULE := libyuv

include $(BUILD_SHARED_LIBRARY)
