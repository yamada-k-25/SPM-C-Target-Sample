// // SBI の仕様にしたがって定義
import Support

struct SBIRet {
    var error: Int
    var value: Int
}

func sbiCall(arg0: Int, arg1: Int, arg2: Int, arg3: Int, arg4: Int, arg5: Int, fID: Int, eID: Int) -> SBIRet { 
    // 指定したレジスタに値をセットするようにする
    let sbiRet = sbi_call(arg0, arg1, arg2, arg3, arg4, arg5, fID, eID)
    
    return SBIRet(error: sbiRet.error, value: sbiRet.value)
}

func putChar(character: UInt8) {
    // 文字を出力する
    let sbiRet = sbi_call(Int(character), 0, 0, 0, 0, 0, 0, 1)
    
    if sbiRet.error != 0 {
        print("Error: \(sbiRet.error)")
    }
}