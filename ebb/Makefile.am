## Process this file with automake to produce Makefile.in
AM_CFLAGS = -Wall -Werror -rdynamic
AM_CPPFLAGS = -I$(top_srcdir)/common -I$(top_srcdir)/ebb

noinst_PROGRAMS =
check_SCRIPTS =
check_PROGRAMS =

nobase_include_HEADERS = paf/ebb.h
noinst_HEADERS = tests/test_ebb_common.h
EXTRA_DIST = tests/test_ebb-skeleton.c $(check_SCRIPTS)

LIBPPCEBB_PRIVATE_INCLUDE = ebb-callback.h \
                            ebb-common.h \
                            ebb-hwcap.h \
                            ebb-init.h \
                            ebb-priv.h \
                            ebb-sysdep.h
lib_LTLIBRARIES = libpaf-ebb.la
libpaf_ebb_la_SOURCES = ebb.c \
                        ebb-init.c \
                        ebb-hwcap.c \
                        ebb-hook.c \
                        ebb-version.c \
                        $(include_HEADERS) \
                        $(LIBPPCEBB_PRIVATE_INCLUDE) \
                        ebb-callback.S

libpaf_ebb_la_CFLAGS = -Wl,-entry=__paflib_ebb_main -fpic
libpaf_ebb_la_LIBADD = ../common/libpaf-common.la
libpaf_ebb_la_LDFLAGS = -version-info $(LIBPAF_SO_VERSION) \
  -e __paflib_ebb_main

dist_man3_MANS = doc/libpaf-ebb.3

# Test programs invoked with 'make check'
TESTS =

TESTS            += test_ebb
test_ebb_SOURCES  = tests/test_ebb.c
test_ebb_LDADD    = libpaf-ebb.la
check_PROGRAMS  += test_ebb

TESTS                             += test_ebb_save_area_env.sh$(EXEEXT)
test_ebb_save_area_env_sh_SOURCES  = tests/test_ebb_save_area_env.sh
test_ebb_save_area_env.sh$(EXEEXT): $(top_srcdir)/ebb/$(test_ebb_save_area_env_sh_SOURCES)
	rm -rf $@
	cp -p  $(top_srcdir)/ebb/$(test_ebb_save_area_env_sh_SOURCES) $@
check_SCRIPTS                    += $(test_ebb_save_area_env_sh_SOURCES)

TESTS                += test_ebb_pmu
test_ebb_pmu_SOURCES  = tests/test_ebb_pmu.c \
                        tests/test_ebb_common.c
test_ebb_pmu_LDADD    = libpaf-ebb.la
check_PROGRAMS      += test_ebb_pmu

TESTS                      += test_ebb_pmu_reset
test_ebb_pmu_reset_SOURCES  = tests/test_ebb_pmu_reset.c \
                              tests/test_ebb_common.c
test_ebb_pmu_reset_LDADD    = libpaf-ebb.la
check_PROGRAMS            += test_ebb_pmu_reset

TESTS                      += test_ebb_backtrace
test_ebb_backtrace_SOURCES  = tests/test_ebb_backtrace.c \
                              tests/test_ebb_common.c
test_ebb_backtrace_LDADD    = libpaf-ebb.la
check_PROGRAMS            += test_ebb_backtrace

TESTS                      += test_ebb_pmu_multi
test_ebb_pmu_multi_SOURCES  = tests/test_ebb_pmu_multi.c \
                              tests/test_ebb_common.c
test_ebb_pmu_multi_LDADD    = libpaf-ebb.la
check_PROGRAMS            += test_ebb_pmu_multi

TESTS                        += test_ebb_pmu_clobber
test_ebb_pmu_clobber_SOURCES  = tests/test_ebb_pmu_clobber.c \
                                tests/test_ebb_pmu_clobber_hooks.S \
                                tests/test_ebb_common.c
test_ebb_pmu_clobber_LDADD    = libpaf-ebb.la
check_PROGRAMS              += test_ebb_pmu_clobber

TESTS                  += test_ebb_child
test_ebb_child_SOURCES  = tests/test_ebb_child.c \
                          tests/test_ebb_common.c
test_ebb_child_LDADD    = libpaf-ebb.la
check_PROGRAMS        += test_ebb_child

TESTS                           += test_ebb_clear_on_close
test_ebb_clear_on_close_SOURCES  = tests/test_ebb_clear_on_close.c \
                                   tests/test_ebb_common.c
test_ebb_clear_on_close_LDADD    = libpaf-ebb.la
check_PROGRAMS                 += test_ebb_clear_on_close

TESTS                      += test_ebb_nohandler
test_ebb_nohandler_SOURCES  = tests/test_ebb_nohandler.c \
                              tests/test_ebb_common.c
test_ebb_nohandler_LDADD    = libpaf-ebb.la
check_PROGRAMS            += test_ebb_nohandler

TESTS                += test_ebb_cpu
test_ebb_cpu_SOURCES  = tests/test_ebb_cpu.c \
                        tests/test_ebb_common.c
test_ebb_cpu_LDADD    = libpaf-ebb.la
check_PROGRAMS      += test_ebb_cpu
