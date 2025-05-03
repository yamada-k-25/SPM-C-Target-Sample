    .section .text.boot, "ax"      # .text.boot セクションに配置。実行可能かつ読み書き可能
    .align  2                     # 4 バイト境界にアライン
    .global boot                  # シンボル “boot” をエクスポート
    .type   boot, @function       # 関数シンボルであることを宣言

boot:
    la    sp, __stack_top
    # カーネル本体へジャンプ
    j      kernel_main

    .size  boot, .-boot           # シンボルサイズを定義
