import Support

/// .bss 開始アドレス
@_silgen_name("__bss")
nonisolated(unsafe) var _bss: UInt8

/// .bss 終了アドレス
@_silgen_name("__bss_end")
nonisolated(unsafe) var _bss_end: UInt8

// 受け取ったポインタに対して、指定したサイズで 0 埋めで初期化する
func memSet(buffer: UnsafeMutableRawPointer, value: UInt8) {
}

@_silgen_name("kernel_main")
func kernel_main() { 

    StaticString("\n\nHello, World!\n").withUTF8Buffer { buffer in
        for i in 0..<buffer.count {
            putChar(character: buffer[i])
        }
    }

    infinite_loop()
}