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
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Add kernel build user
[ -z $(grep "CONFIG_KERNEL_BUILD_USER=" .config) ] &&
    echo 'CONFIG_KERNEL_BUILD_USER="William"' >>.config ||
    sed -i 's@\(CONFIG_KERNEL_BUILD_USER=\).*@\1$"William"@' .config

# Add kernel build domain
[ -z $(grep "CONFIG_KERNEL_BUILD_DOMAIN=" .config) ] &&
    echo 'CONFIG_KERNEL_BUILD_DOMAIN="GitHub Actions"' >>.config ||
    sed -i 's@\(CONFIG_KERNEL_BUILD_DOMAIN=\).*@\1$"GitHub Actions"@' .config


# 删除默认argon主题，并下载新argon主题
rm -rf ./package/lean/luci-theme-argon

git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon

git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config


#git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git  package/lean/luci-theme-argon
#git lua-maxminddb 依赖
#git clone https://github.com/jerrykuku/lua-maxminddb.git  package/lean/lua-maxminddb
# Modify default IP
sed -i 's/192.168.1.1/10.10.10.201/g' package/base-files/files/bin/config_generate
# Modify default wireless name
sed -i 's/OpenWrt/N1/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh



#add luci-app-dockerman
rm -rf ../lean/luci-app-docker
git clone https://github.com/lisaac/luci-in-docker.git package/luci-in-docker
git clone https://github.com/lisaac/luci-app-dockerman.git package/luci-app-dockerman
