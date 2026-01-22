# openwrt-strongDNS2

使用方法

下载`openwrt-sdk`或者`openwrt`仓库，解压后进入子目录

```sh
cd package
git clone https://github.com/hrimfaxi/openwrt-strongDNS2 strongDNS2
cd ..
./scripts/feeds update -a
scripts/feeds install libnfnetlink libnetfilter-queue libmnl
make menuconfig # 进入menuconfig选中strongDNS2
make package/strongDNS2/compile V=s

find . -name "*strongDNS2*.ipk" # 找到ipk上传路由器
```
