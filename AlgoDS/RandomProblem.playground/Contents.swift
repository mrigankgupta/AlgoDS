//
//  RandomProblem.swift
//  AlgoDS
//
//  Created by Gupta, Mrigank on 15/02/18.
//  Copyright © 2018 Gupta, Mrigank. All rights reserved.
//

import Foundation
import DataStructSet
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
var c = [5,6,8,10,7,6,4,3,2]

print(peekFind(arr: c))
var i = peekFindBinary(arr: c, l: 0, r: c.count-1)
//3
func greatestCommonDivisor(num1:Int,num2:Int) -> Int {
    var min = num1
    var max = num2
    if num2 < num1 {
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
func powBaseTen(num:Int) -> Int {
    var remainder = num
    var pow = 0
    while remainder > 0 {
        pow += 1
        remainder = remainder/10
    }
    return pow
}

powBaseTen(num: 96208)

func largestSumByArranging(arr:[Int]) -> Int {
    let sorted = arr.sorted { (a, b) -> Bool in
        let pa = powBaseTen(num: a)
        let pb = powBaseTen(num: b)
        let acom = (a*Int(pow(10.0,Double(pb))) + b)
        let bcom = (b*Int(pow(10.0,Double(pa))) + a)
        print("shit",acom,bcom)
        return acom > bcom
    }
    let sum = sorted.reduce("") { (r, a) -> String in
        return r + String(a)
    }
    return Int(sum)!
}

largestSumByArranging(arr: [9,10,5,89,53,999,92])
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


//6
func pairCubeCount(num: Int) -> [(Int,Int)] {
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
fibnachi(10)
//top down - memoization
func fibnachiMemo(_ n: Int) -> Int {
    var memo = [Int](repeating: 0, count: n+1)
//    for i in 0...n {
//        fibFromMemo(i, memo: &memo)
//    }
    return fibFromMemo(n, memo: &memo)
}
func fibFromMemo(_ n: Int, memo: inout [Int]) -> Int {
    if n <= 0 {return 0}
    if n == 1 {
        return 1
    }else if n == 0 {
        return 0
    }
    if memo[n] > 0 {
        return memo[n]
    }else {
        memo[n] = fibFromMemo(n-1, memo: &memo) + fibFromMemo(n-2, memo: &memo)
    }
    return memo[n]
}
//func fibFromMemo(_ n: Int, memo: inout [Int:Int]) -> Int {
//    if n == 1 {
//        return 1
//    }else if n == 0 {
//        return 0
//    }
//    if let val = memo[n] {
//        return val
//    }
//    var nMinusOne = memo[n-1]
//    if nMinusOne == nil {
//        nMinusOne = fibFromMemo(n-1, memo: &memo)
//        memo[n-1] = nMinusOne
//    }
//    var nMinusTwo = memo[n-2]
//    if nMinusTwo == nil {
//        nMinusTwo = fibFromMemo(n-2, memo: &memo)
//        memo[n-2] = nMinusTwo
//    }
//    memo[n] = nMinusOne! + nMinusTwo!
//    return memo[n]!
//}
fibnachiMemo(10)
//dp version- bottom up
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

func secretLanguageEncoding(enc:String) {
    let rev = enc.reversed()
    let revArr = rev.split(separator: " ")
    for str in revArr {
        var fst = [Int]()
        var cnt = 0
        for (idx, ch) in str.enumerated() {
            if isVowel(ch: ch) {
                fst.append(idx)
                cnt += 1
            }
        }
        let s = String(str)
        if cnt == 0 {
            print("."+s, terminator:" ")
        }else if cnt == 1 {
            let indx = fst.first!
            print(s.prefix(indx+1).reversed()+"."+s.suffix(s.count-indx-1),terminator:" ")
        }else {
            let indx = fst[fst.count-1-1]
            print(s.prefix(indx+1).reversed()+"."+s.suffix(s.count-indx-1),terminator:" ")
        }
    }
}

func isVowel(ch: Character) -> Bool {
    if ch == "a" || ch == "e" || ch == "i" || ch == "o" || ch == "u" {
        return true
    }
    return false
}


let fcukamz = "my worlds most customer centric company"
secretLanguageEncoding(enc: fcukamz)

// Store deepest left leaf nodes in a list
func traverse<T>(root: Node<T>?, level: Int, max: inout Int, arr: inout [T]?, isLeft: Bool) {
    if root == nil { return }
    
    if isLeft, root!.left == nil, root!.right == nil {
        if level > max {
            max = level
            if arr == nil {
                arr = [T]()
            }else{
                arr?.removeAll()
            }
            arr?.append(root!.data)
        } else if level == max {
            arr?.append(root!.data)
        }
    }
    
    traverse(root: root?.left, level: level+1, max: &max, arr: &arr, isLeft: true)
    traverse(root: root?.right, level: level+1, max: &max, arr: &arr, isLeft: false)
}
var bst = BinarySearchTree()
var broot: Node<Int>?

for i in [11,7,3,2,4,9,8,10,18,17,20,16] {
    broot = bst.insert(root: broot, value: i)
}

var mx = 0
var leftlist: [Int]?

traverse(root: broot, level: 0, max: &mx, arr: &leftlist, isLeft: false)
leftlist

//find kth largest element in binary search tree
func kthBST(root:Node<Int>?, item: Int, count: inout Int) {
    if root == nil {
        return
    }
    
    kthBST(root: root?.right, item: item, count: &count)
    count += 1
    if item == count {
        print(root?.data)
        return
    }
    kthBST(root: root?.left, item: item, count: &count)
}
var count = 0

kthBST(root: broot, item: 5, count: &count)

// printing all possible combination of given n items
// for example abc string, possible cobinations are
// "bac", "acb", "cab", "abc", "cba", "bca"
func heapPermutation(arr: String, chCount: Int) -> [String] {
    if chCount == 1 {
        return [String(arr.first!)]
    }
    let arrCh = Array(arr)
    let comb = heapPermutation(arr: arr, chCount: chCount - 1)
    var new = [String]()
    let last = arrCh[chCount-1]
    for item in comb {
        new.append(String(item+String(last)))
    }

    for each in new {
        let eachCharArr = Array(each)
        for i in 0..<eachCharArr.count-1 {
            var copy = eachCharArr
            copy.swapAt(i, eachCharArr.count-1)
            new.append(String(copy))
        }
    }
    return new
}

var unique = Set(heapPermutation(arr: "abcd", chCount: 4))
unique.count
print(unique)
// all can be solved with same approach = half stable partion (slow and fast pointer)
//26. Remove Duplicates from Sorted Array -Leetcode (almost same)
//283. Move Zeroes -Leetcode
// move all positive number at the begining of array

func halfStablePartion(arr: inout [Int]) {
    if arr.count <= 0 {
        return
    }
    var firstNegative = 0
    for (index, item) in arr.enumerated() {
        if item < 0 {
            firstNegative = index
            break
        }
    }
    //first negative
    var lastNegative = firstNegative
    var index = firstNegative
    while index < arr.count {
        if arr[index] < 0 {
            index += 1
        }else {
            arr.swapAt(index, lastNegative)
            print("swaped", arr[lastNegative], arr[index], arr)
            lastNegative += 1
            index += 1
        }
    }
}
var half = [-3,-2,1,7,9,-5,-12,15,1,-7,8,78]
halfStablePartion(arr: &half)
half = [1,2,3,4,-2,1,-7,-9,5,-12,-15,78]
halfStablePartion(arr: &half)

func moveAllNegative(_ nums: inout [Int]) {
    var lastPositive = 0
    for current in 0...nums.count-1 {
        if nums[current] > 0 {
            nums.swapAt(current, lastPositive)
            lastPositive += 1
        }
    }
}
var half1 = [-3,-2,1,7,9,-5,-12,15,1,-7,8,78]
moveAllNegative(&half1)
half1 = [1,2,3,4,-2,1,-7,-9,5,-12,-15,78]
moveAllNegative(&half1)


// for sequence of numbers, print fizz if number is divisible by 3
// buzz if divisible by 5 and fizzbuzz if divisible by both

func fizzBuzz() {
    for i in 1...100 {
        if i%3 == 0 {
            if i%5 == 0 {
                print("FizzBuzz")
            }else {
                print("Fizz")
            }
        }else if i%5 == 0 {
            print("Buzz")
        }else {
            print(i)
        }
    }
}
fizzBuzz()

func fizzBuzzSmart() {
    for i in 1...100 {
        var str = ""
        if i%3 == 0 { str.append("fizz") }
        if i%5 == 0 { str.append("buzz") }

        if str.count <= 0 {
            print(i)
        }else {
            print(str)
        }
    }
}
fizzBuzzSmart()

func mergeHours(hours:[(Int,Int)]) -> [(Int,Int)] {
    if hours.count <= 1 {
        return hours
    }
    var first = hours[0]
    var final = [(Int,Int)]()
    var start = 1
    while start < hours.count {
        if first.1 >= hours[start].0 {
            first = (first.0,hours[start].1)
        }else {
            final.append(first)
            first = hours[start]
        }
        start+=1
    }
    final.append(first)
    return final
}

mergeHours(hours: [(900, 1500),(1400, 1800),(1800, 2000),(1800, 2200)])
mergeHours(hours: [(900, 1500),(1530, 1800),(1800, 2000),(1800, 2200)])
mergeHours(hours: [(900, 1500),(1530, 1800),(1800, 2000),(1800, 2200)])

// fill grid with k random spot
func fillGrid(grid:inout [[Int]], row: Int, col: Int, places: Int) {
    let spot = row*col
    var next = Int(arc4random())%spot
    var r = next/row
    var c = next%col
    for _ in 1...places {
        while grid[r][c] == 1 {
            next = Int(arc4random())%spot
            r = next/row
            c = next%col
        }
        grid[r][c] = 1
    }
}
var arr: [[Int]] = [[Int]](repeating: [Int](repeating: 0, count: 4), count: 3)
fillGrid(grid: &arr, row: 4, col: 3, places: 5)

func favoriteRestaurant(_ restaurants1: [String], _ restaurants2: [String]) -> String {
    let first = NSMutableOrderedSet(array: restaurants1)
    let sec = NSOrderedSet(array: restaurants2)
    first.intersect(sec)
    if let first = first[0] as? String {
        return first
    }
    return "Yelpwich"
}

favoriteRestaurant(["absv", "dbs"], ["abs", "dbs"])

