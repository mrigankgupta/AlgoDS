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
    var sorted = hours.sorted { $0.0 < $1.0}
    var first = sorted[0]
    var final = [(Int,Int)]()
    var start = 1
    while start < sorted.count {
        if first.1 >= sorted[start].0 {
            first = (first.0,max(first.1, sorted[start].1))
        }else {
            final.append(first)
            first = sorted[start]
        }
        start+=1
    }
    final.append(first)
    return final
}

mergeHours(hours: [(900, 1500),(1400, 1800),(1800, 2000),(1800, 2200)])
mergeHours(hours: [(900, 1500),(1530, 1800),(1800, 2000),(1800, 2200)])
mergeHours(hours: [(900, 1500),(1530, 1800),(1800, 2000),(1800, 2200)])
mergeHours(hours: [(900, 1500),(1430, 1480),(1800, 2000),(1800, 2200)])
mergeHours(hours: [(0, 30),(5, 10),(15, 20)])
mergeHours(hours: [(0, 30),(5, 100)])

mergeHours(hours: [(1, 5), (3, 14), (6, 10), (9, 12)])


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
//Zolando

public func zolandoFirstSolution(_ A : inout [Int]) -> Int {
    if A.count <= 0 {
        return 0
    }
    var shine = 0

    for index in 0..<A.count {
        let current = A[index]
        shine += 1
        for j in index..<A.count {
            if current > A[j] {
                shine -= 1
                break
            }
        }
    }
    return shine
}
var A = [2,1,3,5,4]
A = [2,3,4,1,5]
zolandoFirstSolution(&A)

struct Info {
    var pos: Int
    var count: Int
    var time: TimeInterval
    var ext: String
    var final: String = ""
}

public func zolandoSecondSolution(_ S : inout String) -> String {
    var dict = [ String : [Info]]()
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let newlineChars = NSCharacterSet.newlines
    let arr = S.components(separatedBy: newlineChars).filter{!$0.isEmpty}
    for (index, item) in arr.enumerated() {
        let comp = item.components(separatedBy: ",")
        if dict[comp[1]] == nil {
            let date = formatter.date(from: comp[2])
            let time = date?.timeIntervalSinceReferenceDate
            dict[comp[1]] = [Info(pos: index, count: 1, time: time!, ext: comp[0].components(separatedBy: ".").last!, final: "")]
        }else {
            var infoArr = dict[comp[1]]!
            let count = infoArr[0].count + 1
            let date = formatter.date(from: comp[2])
            let time = date?.timeIntervalSinceReferenceDate
            infoArr.append(Info(pos: index, count: count, time: time!, ext: comp[0].components(separatedBy: ".").last!, final: ""))
            dict[comp[1]] = infoArr
        }
    }
    for key in dict.keys {
        var infoArr = dict[key]
        infoArr?.sort(by: { (fir, sec) -> Bool in
            fir.time < sec.time
        })
        dict[key] = infoArr
    }

    var finalArr = [String](repeating: "", count: arr.count)
    for key in dict.keys {
        var infoArr = dict[key]!
        for i in 0..<infoArr.count {
            infoArr[i].final = key +  String(format: "%0"+String(String(infoArr.count).count)+"d", i+1) + "." + infoArr[i].ext
            finalArr[infoArr[i].pos] = infoArr[i].final
        }
    }
    var final = ""
    for str in finalArr {
        final.append(str+"\r\n")
    }
    return final
}

var zolando = """
photo.jpg, Warsaw, 2013-09-05 14:08:15
john.png, London, 2015-06-20 15:13:22
myFriends.png, Warsaw, 2013-09-05 14:07:13
Eiffel.jpg, Paris, 2015-07-23 08:03:02
pisatower.jpg, Paris, 2015-07-22 23:59:59
BOB.jpg, London, 2015-08-05 00:02:03
notredame.png, Paris, 2015-09-01 12:00:00
me.jpg, Warsaw, 2013-09-06 15:40:22
a.png, Warsaw, 2016-02-13 13:33:50
b.jpg, Warsaw, 2016-01-02 15:12:22
c.jpg, Warsaw, 2016-01-02 14:34:30
d.jpg, Warsaw, 2016-01-02 15:15:01
e.png, Warsaw, 2016-01-02 09:49:09
f.png, Warsaw, 2016-01-02 10:55:32
g.jpg, Warsaw, 2016-02-29 22:13:11
"""
zolandoSecondSolution(&zolando)
/*
 photo.jpg, Warsaw, 2013-09-05 14:08:15
 john.png, London, 2015-06-20 15:13:22
 myFriends.png, Warsaw, 2013-09-05 14:07:13
 Eiffel.jpg, Paris, 2015-07-23 08:03:02
 pisatower.jpg, Paris, 2015-07-22 23:59:59
 BOB.jpg, London, 2015-08-05 00:02:03
 notredame.png, Paris, 2015-09-01 12:00:00
 me.jpg, Warsaw, 2013-09-06 15:40:22
 a.png, Warsaw, 2016-02-13 13:33:50
 b.jpg, Warsaw, 2016-01-02 15:12:22
 c.jpg, Warsaw, 2016-01-02 14:34:30
 d.jpg, Warsaw, 2016-01-02 15:15:01
 e.png, Warsaw, 2016-01-02 09:49:09
 f.png, Warsaw, 2016-01-02 10:55:32
 g.jpg, Warsaw, 2016-02-29 22:13:11
 Warsaw02.jpg
 London1.png
 Warsaw01.png
 Paris2.jpg
 Paris1.jpg
 London2.jpg
 Paris3.png
 Warsaw03.jpg
 Warsaw09.png
 Warsaw07.jpg
 Warsaw06.jpg
 Warsaw08.jpg
 Warsaw04.png
 Warsaw05.png
 Warsaw10.jpg
 */

//InterviewBit
//Find the intersection of two sorted arrays.
//OR in other words,
//Given 2 sorted arrays, find all the elements which occur in both the arrays.
//
//Example :
//
//Input :
//A : [1 2 3 3 4 5 6]
//B : [3 3 5]
//
//Output : [3 3 5]
//
//Input :
//A : [1 2 3 3 4 5 6]
//B : [3 5]
//
//Output : [3 5]

func intersect(_ A: [Int], _ B: [Int]) -> [Int] {
    
    var large: [Int] = A
    var small: [Int] = B
    if A.count < B.count {
        large = B
        small = A
    }
    var l = 0
    var s = 0
    var common = [Int]()
    while l < large.count && s < small.count {
        if large[l] > small[s] {
            s += 1
        }else if large[l] < small[s] {
            l += 1
        }else {
            common.append(large[l])
            l += 1
            s += 1
        }
    }
    return common
}


/*
 Given nested arrays, write an enumerator class such that next() returns the elements in sequential order, e.g.:
[1,[4,3],6,[5,[1,0]]]  1, 4, 3, 6, 5, 1, 0
also implement allObjects for this class.
*/

//class Enumerator {
//
//    private var arr: [[Int]]]
//    private index = 0
//
//    init(_ arr: [[Int]]) {
//        self.arr = arr
//    }
//
//    func next() {
//
//    }
//}


var nestedArray: [Any] = [1,[4,3],6,[5,[1,0]]]



 /*
 Consider a list of heights of buildings.
 The buildings overlook the ocean like so: [2, 3, 4, 2, 3, 1, 1] ~~ ocean ~~~.
 Return back, in order, the list of indexes of the buildings that can see the ocean.
*/

func watchOcean(_ arr: [Int]) -> [Int] {
    if arr.isEmpty {
        return []
    }
    var max = arr.last!
    var watch = [Int]()
    watch.append(arr.count-1)
    for (index, item) in arr.reversed().enumerated() {
        if item > max {
            watch.append(index)
            max = item
        }
    }
    return watch
}

watchOcean([2, 3, 4, 2, 3, 1, 1])
