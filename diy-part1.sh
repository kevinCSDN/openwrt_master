#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)

#删除feeds自带mosdns、v2ray-geodata
rm -rf ./feeds/packages/net/mosdns
rm -rf feeds/packages/net/v2ray-geodata
rm -rf feeds/luci/themes/luci-theme-argon

git clone --depth=1 -b master https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon
git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config

git clone https://github.com/kiddin9/openwrt-packages
shopt -s extglob
rm -rf openwrt-packages/!(luci-app-netdata|luci-app-smartdns|luci-app-upnp)
cp -r openwrt-packages/{luci-app-netdata,luci-app-smartdns,luci-app-upnp} package/
rm -rf openwrt-packages

cd package
git clone https://github.com/f8q8/luci-app-autoreboot.git 
cd ..

#克隆passwall环境插件
git clone https://github.com/xiaorouji/openwrt-passwall-packages.git package/pwpage

#克隆的源码放在small文件夹,预先建立small文件夹
mkdir package/small
pushd package/small

#克隆源码
#passwall2 & passwall
git clone -b main --depth 1 https://github.com/xiaorouji/openwrt-passwall2.git
git clone -b main --depth 1 https://github.com/xiaorouji/openwrt-passwall.git

popd
