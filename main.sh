#!/bin/sh
## patchを順番に当てていってコンフリクトが発生したら解消手順もpatchにすることで
## コンフリクト解消方法を記憶する
carton exec perl pp.pl a.csv >a.out
carton exec perl pp.pl b.csv >b.out
carton exec perl pp.pl o.csv >o.out

diff -u o.out a.out >a.patch
diff -u o.out b.out >b.patch
rm {a,b}.out

patch --merge o.out a.patch
patch --merge o.out b.patch
rm {a,b}.patch
cp o.out{,.bak}

if [ ! -f o.out.patch ]; then
	## 1周目
	echo "o.outを編集してコンフリクトを解消してから以下を実行"
	echo "$ diff -u o.out.bak o.out >o.out.patch"
	echo "$ rm o.out.bak o.out.orig"
	exit
else
	## 2周目以降は o.out.patch を使用
	patch --merge o.out o.out.patch
	rm o.out.bak o.out.orig
fi


