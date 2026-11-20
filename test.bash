#!/bin/bash -xv
# SPDX-FileCopyrightText: 2026 Sota Ito
# SPDX-License-Identifier: BSD-3-Clause

ng () {
	echo "${1}行目が違うよ"
	res=1
}

res=0

out=$(printf "数学,2.0,S\n英語,2.0,A\n初年次教育,1.0,合\n物理,2.0,※\n" | ./gpa_sim)
[ "${out}" = "3.50" ] || ng "$LINENO"

out=$(printf "数学,2.0,S\n英語,2.0,A\n初年次教育,1.0,合\n体育,1.0,F\n物理,2.0,※\n" | ./gpa_sim --credits)
[ "${out}" = "5.0" ] || ng "$LINENO"

out=$(printf "数学,2.0,S\n英語,2.0,A\n科目1,2.0,※\n科目2,2.0,※\n" | ./gpa_sim --target 3.50 --base A)
[ "${out}" = "1" ] || ng "$LINENO"

out=$(printf "数学,2.0,C\n科目1,2.0,※\n" | ./gpa_sim --target 3.50)
[ "${out}" = "-1" ] || ng "$LINENO"

out=$(printf "数学,2.0,A\n" | ./gpa_sim --target 3.50)
[ "${out}" = "2" ] || ng "$LINENO"

out=$(printf "日本語表現法   1.0   Ａ   ○   -   2025   前期   布施 \n英語理解   1.0   Ｓ   ○   -   2025   前期   原田 \n" | ./gpa_sim)
[ "${out}" = "3.50" ] || ng "$LINENO"

out=$(echo "" | ./gpa_sim 2>/dev/null)
[ "$?" = 1 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

out=$(echo "あいうえお" | ./gpa_sim 2>/dev/null)
[ "$?" = 1 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

out=$(printf "数学,2.0,A\n" | ./gpa_sim --target 4.5 2>/dev/null)
[ "$?" = 1 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

[ "$res" = 0 ] && echo OK
exit $res
