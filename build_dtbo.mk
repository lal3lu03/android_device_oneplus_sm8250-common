# Ensure dtbo.img is built for target-files-package
# This is needed because the automatic dtbo build isn't triggered in ap2a variant

DTBO_SOURCE_DIR := $(PRODUCT_OUT)/obj/DTB_OBJ/arch/arm64/boot/dts/vendor/oplus
MKDTBOIMG := $(HOST_OUT_EXECUTABLES)/mkdtboimg

# Create dtbo.img from compiled .dtbo files
.PHONY: dtbo_custom
dtbo_custom: $(MKDTBOIMG)
	@echo "Creating dtbo.img from device tree overlays..."
	$(hide) if [ -d "$(DTBO_SOURCE_DIR)" ] && [ -n "$$(find $(DTBO_SOURCE_DIR) -name '*.dtbo' 2>/dev/null)" ]; then \
		$(MKDTBOIMG) create $(PRODUCT_OUT)/dtbo.img --page_size=4096 $$(find $(DTBO_SOURCE_DIR) -name "*.dtbo" | sort); \
		echo "✅ dtbo.img created: $(PRODUCT_OUT)/dtbo.img"; \
	else \
		echo "⚠️  No .dtbo files found, skipping dtbo.img creation"; \
	fi
