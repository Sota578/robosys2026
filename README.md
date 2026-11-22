# robosys2026
## このリポジトリはロボットシステム学の授業で利用するためのものです
# gpa_sim

![test](https://github.com/Sota578/robosys2026/actions/workflows/test.yml/badge.svg)

標準入力から受け取った成績表のテキストデータまたは CSV データをもとに、通算 GPA や修得済み単位数の計算、目標 GPA 達成に必要な S 評価の科目数シミュレーションを行うコマンドです。

## インストール方法

以下のコマンドを実行してリポジトリをクローンし、ディレクトリへ移動します。
```bash
$ git clone [https://github.com/Sota578/robosys2026.git]
$ cd robosys2026
```
## 使い方
## 1 CSV 形式のデータを入力する場合
科目名,単位数,評価 の形式で標準入力に渡します。評価には S, A, B, C, F のほか、GPA 計算から除外される 合, P, および履修中を示す※ を指定できます。

通算 GPA の計算
```
$ printf "数学,2.0,S\n英語,2.0,A\n初年次教育,1.0,合\n物理,2.0,※\n" | ./gpa_sim
```
3.50

修得済み単位数の計算（-c / --credits）
```
$ printf "数学,2.0,S\n英語,2.0,A\n初年次教育,1.0,合\n体育,1.0,F\n" | ./gpa_sim --credits
```
5.0

目標 GPA 達成に必要な S 評価の最小科目数のシミュレーション（-t / --target, -b / --base）
履修中科目がある場合、目標 GPA を達成するために S 評価を取る必要がある最小科目数を出力します。-b オプションで、S 以外の履修中科目で取る前提の評価（A, B, C, F、デフォルトは B）を指定できます。全科目で S 評価を取っても目標に届かない場合は -1 を出力します。
```
$ printf "数学,2.0,S\n英語,2.0,A\n科目1,2.0,※\n科目2,2.0,※\n" | ./gpa_sim --target 3.50 --base A
```
1

## 2 成績一覧表 PDF から直接計算する場合
poppler-utils の pdftotext -layout とパイプでつなぐことで、成績一覧表 PDF から直接計算できます。
```
$ pdftotext -layout 成績一覧表.pdf - | ./gpa_sim
```
## テストの実行方法
以下のコマンドでテストを実行できます。
```
$ ./test.bash
```
OK

## 必要なソフトウェア
- Python
  - テスト済みバージョン: 3.10〜3.14
- poppler-utils（PDF ファイルを直接読み込む場合のみ）
## テスト環境
- Ubuntu 24.04 LTS

## 著作権とライセンス
- © 2026 Sota Ito
