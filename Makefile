NAME = box-monitor
BUILDDIR=/dev/shm/${NAME}
TARGET = $(BUILDDIR)/box_monitor

CORESRC:=$(BUILDDIR)/src/box_monitor.nim
BUILDSRC:=$(BUILDDIR)/box_monitor.nimble

all: $(TARGET)

$(TARGET): $(CORESRC) $(BUILDSRC) $(PROTOSRC)
	cd $(BUILDDIR); nimble build; cd -

$(CORESRC): src/core.org | prebuild
	org-tangle $<

$(BUILDSRC): src/build.org | prebuild
	org-tangle $<

prebuild:
ifeq "$(wildcard $(BUILDDIR))" ""
	@mkdir -p $(BUILDDIR)/src
endif

clean:
	rm -rf $(BUILDDIR)

.PHONY: all clean prebuild
