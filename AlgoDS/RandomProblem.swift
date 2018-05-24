//
//  RandomProblem.swift
//  AlgoDS
//
//  Created by Gupta, Mrigank on 15/02/18.
//  Copyright © 2018 Gupta, Mrigank. All rights reserved.
//

import Foundation
//1
func addBitwise(a:Int,b:Int) -> Int {
    
    var sum: Int = a ^ b
    var carry: Int = a & b
    while carry != 0 {
        sum = sum ^ carry
        carry = sum & carry
    }
    return sum
}


print(addBitwise(a: 329, b: 546))

//2
func peekFind<T>(arr:[T]) -> T? where T : Equatable & Comparable {
    var peek: T?
    if arr.count > 0 {
        var i = 0
        while i < arr.count && (peek == nil || peek! <= arr[i]) {
            peek = arr[i]
            i+=1
        }
    }
    
    return peek
}

func peekFindBinary<T>(arr:[T], l:Int, r:Int) -> T? where T : Equatable & Comparable {
    
    let index: Int = (l+r) / 2
    if arr[index] < arr[index+1] {
        return peekFindBinary(arr: arr, l: index+1, r: r)
    }else if arr[index] < arr[index-1] {
        return peekFindBinary(arr: arr, l: l, r: index-1)
    }else {
        print(arr[index])
        return arr[index]
    }
}
print(peekFind(arr: c))
var i = peekFindBinary(arr: c, l: 0, r: c.count-1)
//3
func greatestCommonDivisor(num1:Int,num2:Int) -> Int {
    var min = num1
    var max = num2
    if num2 < num1{
        min = num2
        max = num1
    }
    if max % min == 0 {
        return min
    }
    for i in (2..<min).reversed() {
        if max%i==0 && min%i == 0 {
            return i
        }
    }
    return 1
}

func rotationJuggling(arr: inout [Int], rotate:Int) {
    let count = arr.count
    let rot:Int = rotate%count
    let gcd = greatestCommonDivisor(num1: count, num2: rot)
    for k in 0..<gcd {
        var j = k
        var current = arr[j]
        while true {
            j = j - rot
            if j < 0 {
                j = count + j
            }
            
            let temp = arr[j]
            arr[j] = current
            current = temp
            if j == k {
                break
            }
        }
    }
}
var s = [1,2,3,4,5,6,7,8,9,10]
rotationJuggling(arr:&s,rotate: 5)


func rotationReverse(arr:inout [Int], rotate:Int) {
    let count = arr.count
    let rot:Int = rotate%count
    reverse(arr: &arr, start: 0, end: count-1)
    reverse(arr: &arr, start: 0, end: (count-rot)-1)
    reverse(arr: &arr, start: count-rot, end: count-1)
}

func reverse(arr:inout [Int],start:Int, end:Int) {
    let mid:Int = (end-start)/2
    print(mid)
    for i in 0...mid {
        let temp = arr[end - i]
        arr[end - i] = arr[start+i]
        arr[start+i] = temp
    }
}
var s2 = [0,1,2,3,4,5,6]
rotationReverse(arr: &s2, rotate: 2)
//4
func msb(num:Int) -> Int {
    var remainder = num
    var prev = remainder
    while remainder > 0 {
        prev = remainder
        remainder = remainder/10
    }
    return prev
}

msb(num: 96208)

func largestSumByArranging(arr:[Int]) -> Int {
    let sorted = arr.sorted { (a, b) -> Bool in
        let ma = msb(num: a)
        let mb = msb(num: b)
        return ma == mb ? a < b: ma > mb
    }
    let sum = sorted.reduce("") { (r, a) -> String in
        return r + String(a)
    }
    return Int(sum)!
}

largestSumByArranging(arr: [9,10,5,89,53,919,92])
//5
func findDuplicates<T:Hashable>(arr:[T]) -> [T] {
    var dup = [T]()
    let count = arr.count
    for fstIdx in  0..<count {
        for secIdx in 0..<count {
            if fstIdx != secIdx, arr[fstIdx] == arr[secIdx] {
                dup.append(arr[fstIdx])
            }
        }
    }
    return dup
}

findDuplicates(arr: [1,2,4,5,6,2,3,4,1])

func findDuplicatesEfficient<T:Hashable>(arr:[T]) -> [T] {
    var dup = [T]()
    var dict = [T:[Int]]()
    let count = arr.count
    for fstIdx in  0..<count {
        let val = arr[fstIdx]
        if dict[val] == nil {
            dict[val] = [fstIdx]
        }else {
            dict[val]?.append(fstIdx)
        }
    }
    for (_,indecs) in dict {
        if indecs.count > 1 {
            for index in indecs {
                dup.append(arr[index])
            }
        }
    }
    return dup
}
findDuplicatesEfficient(arr: [1,2,4,5,6,2,3,4,1])


//6func pairCubeCount(num: Int) -> [(Int,Int)] {
let cubeRoot = Int(pow(Double(num), 1.0/3.0))
var pairs = [(Int,Int)]()
for i in 1...cubeRoot {
    let pairCube = num - Int(pow(Double(i), Double(3)))
    let pair = pow(Double(pairCube), 1.0/3.0)
    if pair.truncatingRemainder(dividingBy: 1.0) == 0 { //TODO:Remind yourself
        pairs.append((i, Int(pair)))
    }
}
print(pairs)
return pairs
}

pairCubeCount(num: 9)
pairCubeCount(num: 28)

//Fibnachi
func fibnachi(_ n:Int) -> Int {
    if n == 1 {
        return 1
    }else if n == 0 {
        return 0
    }
    return fibnachi(n-1) + fibnachi(n-2)
}

fibnachi(4)

func fibnachiIterative(_ n:Int) -> Int {
    var fn = 0
    var fn1 = 1
    var fn0 = 0
    for _ in 2...n {
        fn = fn1 + fn0
        fn0 = fn1
        fn1 = fn
    }
    return fn
}
fibnachi(4)
