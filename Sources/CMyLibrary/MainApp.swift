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
  let bssStart = UnsafeRawPointer(&_bss)
  let bssMutableStart = UnsafeMutableRawPointer(mutating: bssStart)
  let bytePtr = bssMutableStart.bindMemory(to: UInt8.self, capacity: Int(_bss_end - _bss))
  let buf = UnsafeMutableBufferPointer(start: bytePtr, count: Int(_bss_end - _bss))
  memSet(buffer: bssMutableStart, value: 0)
}

// struct kernel_main {
//   static func main() {
//     /// .bss セクションの開始ポインタ
//     let bssStart = UnsafeRawPointer(&_bss)
//     let bssMutableStart = UnsafeMutableRawPointer(mutating: bssStart)

//     /// .bss セクションの終了ポインタ
//     let bssEnd = UnsafeRawPointer(&_bss_end)

//     /// セクションサイズ（バイト数）
//     let bssSize = bssEnd - bssStart  // UnsafeRawPointer 同士の差分で Int が得られる

//     let bytePtr =

//     memSet(buf: bssEnd, value: 0, size: bssSize)

//     while true {}
//   }
// }
