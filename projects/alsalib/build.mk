$(eval $(call project-define,alsalib))

$(ALSALIB_ANDROID): $(ANDROID_CONFIG_SITE)
	cd $(ALSALIB_ANDROID_BUILD_DIR) && make -j $(THREADS)
	cd $(ALSALIB_ANDROID_BUILD_DIR)/alsactl && make -j $(THREADS) install
	cd $(ALSALIB_ANDROID_BUILD_DIR)/alsa-info && make -j $(THREADS) install
	cd $(ALSALIB_ANDROID_BUILD_DIR)/amixer && make -j $(THREADS) install

$(ALSALIB_ANDROID_BUILD_DIR): $(ANDROID_CONFIG_SITE)
	mkdir -p $@
	cd $@ && $(ALSALIB_SRCS)/configure --without-versioned $(ANDROID_EXTRA_CONFIGURE_FLAGS)


ALSALIB_VERSION=alsa-lib-1.2.11
ALSALIB_DOWNLOAD_URL=http://www.alsa-project.org/files/pub/lib/$(ALSALIB_VERSION).tar.bz2

projects/alsalib/sources:
	wget -O - $(ALSALIB_DOWNLOAD_URL) | tar xjf - --transform s,$(ALSALIB_VERSION),$@,
