#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

#Modify the kernel to 5.4:
#sed -i 's/KERNEL_PATCHVER:=4.19/KERNEL_PATCHVER:=5.4/g' target/linux/ipq40xx/Makefile

# Modify hostname
sed -i 's/OpenWrt/William_N1/g' package/base-files/files/bin/config_generate

# Modify the version number
sed -i 's/OpenWrt/William build $(date "+%Y.%m.%d") @ OpenWrt/g' package/lean/default-settings/files/zzz-default-settings

# 修改 argon 为默认主题,可根据你喜欢的修改成其他的（不选择那些会自动改变为默认主题的主题才有效果）
sed -i 's/luci-theme-bootstrap/luci-theme-argon-18.06/g' feeds/luci/collections/luci/Makefile

# Add kernel build user
[ -z $(grep "CONFIG_KERNEL_BUILD_USER=" .config) ] &&
    echo 'CONFIG_KERNEL_BUILD_USER="William"' >>.config ||
    sed -i 's@\(CONFIG_KERNEL_BUILD_USER=\).*@\1$"William"@' .config

# Add kernel build domain
[ -z $(grep "CONFIG_KERNEL_BUILD_DOMAIN=" .config) ] &&
    echo 'CONFIG_KERNEL_BUILD_DOMAIN="GitHub Actions"' >>.config ||
    sed -i 's@\(CONFIG_KERNEL_BUILD_DOMAIN=\).*@\1$"GitHub Actions"@' .config

#删除luci-app-smartdns
rm -rf ./package/lean/luci-app-smartdns
rm -rf ./feeds/kenzo/luci-app-smartdns
rm -rf package/litte/luci-app-smartdns && rm -rf package/litte/smartdns

# 删除默认argon主题，并下载新argon主题
rm -rf ./package/lean/luci-theme-argon

#git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon

#git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config


#git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git  package/lean/luci-theme-argon
#git lua-maxminddb 依赖
#git clone https://github.com/jerrykuku/lua-maxminddb.git  package/lean/lua-maxminddb
# Modify default IP
sed -i 's/192.168.1.1/10.10.10.201/g' package/base-files/files/bin/config_generate
# Modify default wireless name
sed -i 's/OpenWrt/N1/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh


sed -i 's/LUCI_DEPENDS.*/LUCI_DEPENDS:=\@\(arm\|\|aarch64\)/g' package/lean/luci-app-cpufreq/Makefile



#add luci-app-dockerman
#rm -rf ../lean/luci-app-docker
#git clone https://github.com/lisaac/luci-in-docker.git package/luci-in-docker
#git clone https://github.com/lisaac/luci-app-dockerman.git package/luci-app-dockerman


#add bypass
git clone https://github.com/garypang13/luci-app-bypass package/luci-app-bypass
git clone https://github.com/garypang13/luci-app-dnsfilter package/luci-app-dnsfilter
git clone https://github.com/project-lede/luci-app-godproxy package/luci-app-godproxy
git clone https://github.com/garypang13/smartdns-le package/smartdns-le

#svn co https://github.com/garypang13/openwrt-packages/tree/master/luci-app-smartdns
svn co https://github.com/garypang13/openwrt-packages/tree/master/tcping
svn co https://github.com/garypang13/openwrt-packages/tree/master/lua-maxminddb

#修改bypass的makefile
#find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-ssr-redir/shadowsocksr-libev-alt/g' {}
#find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-ssr-server/shadowsocksr-libev-server/g' {}
