KERNEL_SRC ?= /lib/modules/$(shell uname -r)/build
M ?= $(shell pwd)

ifeq ($(O),)
out_dir := .
else
out_dir := $(O)
endif

# The driver is built out of a subdirectory, the same way the Amlogic wifi
# build framework does it: w2_build_path = aml_drv; obj-m lives in aml_drv/fullmac, so that is
# where the modules are left.
# That Makefile already provides "modules", "modules_install" and "clean", so
# the goal is forwarded unchanged.
DRIVER_DIR := aml_drv
DRIVER_KO_DIR := aml_drv/fullmac
DRIVER_KOS := w2.ko w2_comm.ko
DRIVER_ARGS := CONFIG_ANDROID_GKI=y CONFIG_AML_ANDROID=14 CONFIG_MAGIC_PACKET_EN=y CONFIG_GOOGLE_CAST_EN=y CONFIG_AML_WOW_GOOGLE_CAST_EN=y

modules modules_install clean:
	$(MAKE) -C $(KERNEL_SRC)/$(M)/$(DRIVER_DIR) M=$(M)/$(DRIVER_DIR) KERNEL_SRC=$(KERNEL_SRC) \
		$(DRIVER_ARGS) $(@)
	if [ -e $(out_dir)/$(M)/$(DRIVER_DIR)/Module.symvers ]; then \
		ln -sf $(out_dir)/$(M)/$(DRIVER_DIR)/Module.symvers $(out_dir)/$(M)/Module.symvers; \
	fi
	for ko in $(DRIVER_KOS); do \
		if [ -e $(out_dir)/$(M)/$(DRIVER_KO_DIR)/$$ko ]; then \
			ln -sf $(out_dir)/$(M)/$(DRIVER_KO_DIR)/$$ko $(out_dir)/$(M)/$$ko; \
		fi; \
	done
