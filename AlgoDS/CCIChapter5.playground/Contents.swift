//
//  CCIChapter5.swift
//  AlgoDS
//
//  Created by Gupta, Mrigank on 24/05/18.
//  Copyright © 2018 Gupta, Mrigank. All rights reserved.
//

import Foundation
//Chapter 5 Bit manipulation
//1
func mergeBitWise(big:UInt16, small:UInt16, s:Int, e:Int) -> UInt16 {
    let allOne : UInt16 = ~0
    
    let left = allOne << e
    //    print(String(left, radix:2))
    let right:UInt16 = (1 << s) - 1
    //    print(String(right, radix:2))
    
    let mask = left | right
    //    print(String(mask, radix:2))
    
    let shiftSmall = small << s
    let bigMasked = big & mask
    //    print(String(bigMasked, radix:2))
    
    return bigMasked | shiftSmall
}

var merged = mergeBitWise(big: 0b0100000000, small: 0b10011, s: 2, e: 7)
print(String(merged, radix:2))

//2
func binaryToString(num:Double) -> String {
    var bs = "."
    var fract = num
    var i = 0
    while fract > 0.0 {
        fract = fract*2.0
        i += 1
        if i > 31 {
            return "error"
        }
        if fract >= 1.0 {
            bs.append("1")
            fract = fract - 1.0
        }else {
            bs.append("0")
        }
        print(fract)
    }
    return bs
}

print(binaryToString(num: 0.8))

//3
func flipBitToWin(num:UInt64) -> Int {
    var ones = 0
    var max = 0
    var i = 0
    var zeros = 0
    var lastOnes = 0
    while  i < 64 {
        let mask: UInt64 = 1 << i
        let bit = (num & mask)
        //print(bit, i, mask)
        if bit != 0 {
            ones += 1
            zeros = 0
        }else {
            zeros += 1
            if (ones+lastOnes) > max {
                max = ones+lastOnes
            }
            lastOnes = ones
            ones = 0
            if zeros > 1 {
                lastOnes = 0
            }
        }
        i += 1
    }
    return max
}

print("tough",flipBitToWin(num: 0b1111011111101111101111000111111))


//11011101111

//4

func nextMax(num:UInt32) -> UInt32 {
    let set:UInt32 = 1
    var i = 0
    var flag = false
    while i < 32 {
        let mask = set << i
        let bit = mask & num
        if bit != 0 {
            flag = true
        }else {
            if flag == true {
                break
            }
            flag = false
        }
        i += 1
    }
    let mask = set << (i - 1)
    return num + mask
}

print(String(nextMax(num: 0b1110111), radix:2))
print(String(nextMax(num: 0b11011011111100), radix:2))

func nextMin(num:UInt32) -> UInt32 {
    let set:UInt32 = 1
    var i = 0
    var flag = false
    
    while i < 32 {
        let mask = set << i
        let bit = mask & num
        if bit == 0 {
            flag = true
        }else {
            if flag == true {
                break
            }
            flag = false
        }
        i += 1
    }
    let mask = set << (i - 1)
    return num - mask
}
print(String(nextMin(num: 0b1110111), radix:2))
print(String(nextMin(num: 0b11011011111100), radix:2))

//5

//((n & (n-1)) == 0)

//6

func conversionInteger(a:Int32, b:Int32) -> Int {
    let result = a ^ b
    print("odd bit"+String(result, radix:2))
    let set:Int32 = 1
    var i = 0
    var count = 0
    while i < 32 {
        let mask = set << i
        let bit = mask & result
        if bit != 0 {
            count += 1
        }
        i += 1
    }
    return count
}

print(conversionInteger(a: 29, b: 15))
print(conversionInteger(a: 19, b: 15))
//8

func pairSwap(num:Int32) -> Int32 {
    let alter = num << 1
    let set:Int32 = 1
    var copy = num
    for i in stride(from: 1, to: 32, by: 2) {
        let mask = set << (i)
        let alterbit = alter & mask
        let bit = num & mask
        let result = bit ^ alterbit
        if result != 0 {
            copy = copy ^ mask
            copy = copy ^ (mask >> 1)
        }
    }
    return copy
}

print(String(pairSwap(num: 0b01011101), radix:2))


//9

func drawline(screen: inout [UInt8], width:Int, x1:Int, x2:Int, y:Int) {
    let h = screen.count/width
    if y < 0 || y > h {
        return
    }
    let prevLine = (y)*(8*width)
    let start = prevLine + x1
    let end = start + (x2-x1)
    let blockStart = start/8
    let blockEnd = end/8
    
    for i in blockStart+1..<blockEnd {
        screen[i] = 0b11111111
        print("index",i)
    }
    
    let initial = start%8
    let allOne:UInt8 = ~0
    let imask = allOne >> initial
    screen[blockStart] =  imask | screen[blockStart]
    
    let closer = end%8
    let cmask = allOne << abs(closer - 8)
    screen[blockEnd] =  cmask | screen[blockEnd]
}
var screen = [UInt8](repeating: 0, count: 3*3)


drawline(screen: &screen, width: 3, x1: 0, x2: 8, y: 0)
print("screen")
for i in 0..<(3*3) {
    print(String(screen[i],radix:2))
}
