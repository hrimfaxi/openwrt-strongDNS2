include $(TOPDIR)/rules.mk

PKG_NAME:=strongDNS2
PKG_VERSION:=git
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/hrimfaxi/strongDNS2.git
PKG_SOURCE_VERSION:=HEAD
PKG_HASH:=skip

include $(INCLUDE_DIR)/package.mk

define Build/Configure
	cd $(PKG_BUILD_DIR) && \
	cmake . \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_SYSTEM_NAME=Linux \
		-DCMAKE_C_COMPILER="$(TARGET_CC)"
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR)
endef

define Build/Clean
	-$(MAKE) -C "$(PKG_BUILD_DIR)" clean
endef

define Package/strongDNS2
	SECTION:=net
	CATEGORY:=Network
	TITLE:=strongDNS2 GFW dns protector
	DEPENDS:=+libmnl +libnetfilter-queue +libnfnetlink +kmod-nft-queue
endef

define Package/strongDNS2/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_DIR) $(1)/usr/share/strongDNS2
	$(INSTALL_DIR) $(1)/usr/share/strongDNS2/hooks.d
	$(INSTALL_DIR) $(1)/etc/capabilities
	$(INSTALL_DIR) $(1)/etc/config

	$(INSTALL_BIN) $(PKG_BUILD_DIR)/strongDNS2 $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/openwrt-contrib/etc/init.d/strongDNS2 $(1)/etc/init.d/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/openwrt-contrib/etc/config/strongDNS2 $(1)/etc/config/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/mark_sites-nft.sh $(1)/usr/share/strongDNS2/hooks.d/

	$(INSTALL_DATA) $(PKG_BUILD_DIR)/openwrt-contrib/etc/capabilities/strongDNS2.json $(1)/etc/capabilities
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/ipv4.txt $(1)/usr/share/strongDNS2/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/ipv6.txt $(1)/usr/share/strongDNS2/
	$(CP) -r $(PKG_BUILD_DIR)/mark_sites $(1)/usr/share/strongDNS2/
endef

$(eval $(call BuildPackage,strongDNS2))
