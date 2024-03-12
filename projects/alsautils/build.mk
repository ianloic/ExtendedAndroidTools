
$(eval $(call project-define,alsautils))

ALSAUTILS_ANDROID_DEPS = alsalib

$(ALSAUTILS_ANDROID): $(ANDROID_CONFIG_SITE)
	cd $(ALSAUTILS_ANDROID_BUILD_DIR) && make -j $(THREADS) install

$(ALSAUTILS_ANDROID_BUILD_DIR): $(ANDROID_CONFIG_SITE)
	mkdir -p $@
	cd $@ && $(ALSAUTILS_SRCS)/configure \
		--disable-bat \
		--disable-alsamixer \
		--with-systemdsystemunitdir=/tmp/alsa$$ \
		--with-udev-rules-dir=/tmp/alsa$$ \
		$(ANDROID_EXTRA_CONFIGURE_FLAGS)



ALSAUTILS_VERSION=alsa-utils-1.2.11
ALSAUTILS_DOWNLOAD_URL=http://www.alsa-project.org/files/pub/utils/$(ALSAUTILS_VERSION).tar.bz2

projects/alsautils/sources:
	wget -O - $(ALSAUTILS_DOWNLOAD_URL) | tar xjf - --transform s,$(ALSAUTILS_VERSION),$@,
	# hack configure script
	sed -i -e 's/ -lpthread"/"/' $@/configure
