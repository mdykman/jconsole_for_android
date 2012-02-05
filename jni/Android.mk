LOCAL_PATH:=(call my-dir)

TARGET_PLATFORM := android-8

# LOCAL_CPP_FLAGS := -O0 -fno-strict-aliasing

LOCAL_CPP_FLAG :=  -fPIC

# -MMD -MP -MF ./obj/local/x86/objs/j/a.o.d -ffunction-sections -funwind-tables -O2 \
#  -fomit-frame-pointer -fstrict-aliasing -funswitch-loops -finline-limit=300 -Ijni/jgplsrc \
#  -DANDROID  -Wa,--noexecstack -O2 -DNDEBUG -g -I/home/michael/projects/android-ndk-r7/platforms/android-9/arch-x86/usr/include \
#  -c  jni/jgplsrc/a.c -o ./obj/local/x86/objs/j/a.o



include $(call all-subdir-makefiles)

