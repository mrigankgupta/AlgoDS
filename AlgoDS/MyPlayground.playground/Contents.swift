//: Playground - noun: a place where people can play

import UIKit
import Foundation
import DataStructSet

/*
var bt = BinarySearchTree()
var root:Node<Int>?
//1,8,7,4,6,3,5,2
for i in [1,3,5,4,12,15,9,10] {
    root = bt.insertRec(root: root, value: i)
}
//bt.inorderTraversalRec(root: root)
//bt.inorderTraversal(root: root)
//bt.preorderTraversal(root: root)
//bt.height(root)
//bt.levelOrderTraversal(root: root)

let sl = SinglyLinkedList<Int>()
var sroot:SNode<Int>!
for i in 1...10 {
    sroot = sl.insert(root: sroot, value: i)
}
// Making iterator
sl.head = sroot
for i in sl {
    print(i)
}
sl.print(root: sroot)


var ht = HashTable<Dict<String, Int>>(count: 10)

ht.update(value: Dict(k:"I", v: 1))
ht.update(value: Dict(k:"am", v: 2))
ht.update(value: Dict(k:"programmer", v: 3))
ht.update(value: Dict(k:"artist", v: 4))
ht.update(value: Dict(k:"swift", v: 7))
ht.update(value: Dict(k:"mrigank", v: 8))
ht.update(value: Dict(k:"java", v: 5))
ht.update(value: Dict(k:"c++", v: 6))
ht.update(value: Dict(k:"python", v: 7))
ht.update(value: Dict(k:"haskel", v: 11))
ht.update(value: Dict(k:"objc", v: 20))

ht.update(value: Dict(k:"mrigank", v: 9))
ht.update(value: Dict(k:"mrigank", v: 10))

print(ht.value(key: "java"))
print(ht.value(key: "swift"))
print(ht.value(key: "objc"))
print(ht.value(key: "c++"))
ht.remove(key: "c++")
print(ht.value(key: "c++"))


var preOrder = ["a","b","c","d","e","f","h","i","g"]
var inOrder = ["c","b","d","a","h","f","i","e","g"]

var r = bt.buildBinaryTree(preOr: preOrder, inOr: inOrder)
bt.inorderTraversal(root: r)
bt.height(r)



//print(find(root: root, value: 2))
//print(predesecessor(root: root, value: 4).0?.data,predesecessor(root: root, value: 4).1?.data)
bt.deletion(root: &root, value: 1)
bt.inorderTraversal(root: root)
bt.deletion(root: &root, value: 2)
bt.inorderTraversal(root: root)

print(DataStructSet.binarySearch(arr: [1,2,3,4,5,6,7,8], value: 1))
print(DataStructSet.binarySearchRec(arr: [1,2,3,4,5,6,7,8], value: 0))

var a = [9,1,8,7,4,6,3,5,2,10]
print(quickSort(arr: &a, start: 0, end: a.count-1))
print(a)
a = [9,1,8,7,4,6,3,5,2,10]
insertionSort(arr: &a)
print(a)
a = [9,1,8,7,4,6,3,5,2,10]
selectionSort(arr: &a)
print(a)


a = [9,1,8,7,4,6,3,5,2,10]
var c = [5,6,8,10,7,6,4,3,2]
merge(arr: &c,l:0,m:5,r:c.count-1)
print(c)
mergeSort(arr: &a, left: 0, right: a.count-1)
print(a)
 */
var noHeap = [10,12,15,4,1,5,9,3]
buildHeap(arr: &noHeap)
noHeap = [7,1,2]
heapSort(arr: &noHeap, count: noHeap.count)
print(noHeap)
heapify(arr: &noHeap, index: 0, count:noHeap.count)

var rt : Node<Int>?
let tre = BinaryTree()
for i in [5,2,4,3,6,7,1,9,8] {
    rt = tre.levelOrderInsert(root: rt, data: i)
}

tre.levelOrderTraversal(root: rt)


let str = ["abc","abgl","cdf","abcd","lmn"]
var tRoot: TrieNode<Character>?
let trie = Trie()
for s in str {
    let chAr:[Character] = [Character](s) //TODO:Remind yourself
    tRoot = trie.insert(root: tRoot, elements:chAr)
}
for k in (tRoot?.dict.keys)! {
    print(k)
}


trie.search(root: tRoot, val: ["a","b"], fullType: false)
trie.search(root: tRoot, val: ["a","b"], fullType: true)

trie.search(root: tRoot, val: ["a","b","d"], fullType: true)
trie.search(root: tRoot, val: ["a","b","g"], fullType: true)
trie.search(root: tRoot, val: ["a","b","g"], fullType: false)


var a = [3,4,1,2,6,7,9,8,10]

func heapifyMax(arr:inout [Int], index:Int) {

    let left = 2*index + 1
    let right = 2*index + 2
    if right > arr.count-1 {
        return
    }
    var max = left
    if arr[left] < arr[right] {
        max = right
    }
    if arr[max] > arr[index] {
        arr.swapAt(max, index)
        heapifyMax(arr: &arr, index: max)
    }
}

func buildHeapMax(arr: inout [Int]) {
    for i in (0...arr.count/2).reversed() {
        heapifyMax(arr: &arr, index: i)
    }
}

buildHeapMax(arr: &a)

func insertInHeap(arr:inout [Int], new:Int) {
    arr.append(new)
    var index = arr.count - 1
    var parent = index/2
    while index > 0 && arr[parent] < arr[index] {
        arr.swapAt(parent, index)
        index = parent
        parent = index/2
    }
}
insertInHeap(arr: &a, new: 20)
insertInHeap(arr: &a, new: 5)

func firstCommonAncestorBST<T:Comparable>(root:Node<T>?, item1:T, item2:T) -> Node<T>? {
    if root == nil {
        return nil
    }else if (root!.data < item1 && root!.data > item2) || (root!.data < item1 && root!.data > item2) {
        return root
    }else if root!.data < item1 && root!.data < item2 {
       return firstCommonAncestorBST(root: root?.left, item1: item1, item2: item2)
    }else {
       return firstCommonAncestorBST(root: root?.right, item1: item1, item2: item2)
    }
}

func quickPractice(arr:inout [Int], left: Int, right: Int) {
    if left < right {
        let m = right
        let p = pivot(arr: &arr, s: left, e: right, p: m)
        quickPractice(arr: &arr, left: left, right: p-1)
        quickPractice(arr: &arr, left: p, right: right)
    }
}

func pivot(arr:inout [Int], s:Int, e:Int, p:Int) -> Int {
    let pivot = arr[p]
    var i = s
    var j = e
    while i < j {
        if pivot >= arr[i] {
            i += 1
        }else if pivot < arr[j] {
            j -= 1
        }else {
            print("\(i) \(j)")
            arr.swapAt(i, j)
        }
    }
    return i
}
var s = [1,2,0,3,4,1,5,3,1,9]
//pivot(arr: &s, s: 0, e: s.count-1, p: 3)
quickPractice(arr: &s, left: 0, right: s.count-1)
print(s)


func merge(arr:inout [Int], l:Int, m:Int, r:Int) {
    
    var arr1 = arr[l...m]
    var arr2 = arr[m+1...r]
    var i = l
    var j = m+1
    var index = l
    while (i <= m && j <= r) {
        if arr1[i] < arr2[j] {
            arr[index] = arr1[i]
            i += 1
            index += 1
        }else{
            arr[index] = arr2[j]
            j += 1
            print(j)
            index += 1
        }
    }
    print(i,j)
    while j <= r {
        arr[index] = arr2[j]
        j += 1
        index += 1
    }
    while i <= m {
        arr[index] = arr1[i]
        i += 1
        index += 1
    }
}


func mergeSort(arr:inout [Int], lft:Int, rgt: Int) {
    
    if lft < rgt {
        let m = (lft+rgt)/2
        mergeSort(arr: &arr, lft: lft, rgt: m)
        mergeSort(arr: &arr, lft: m+1, rgt: rgt)
        merge(arr:&arr, l:lft, m:m, r:rgt)
    }
}
var ae = [1,2,6,8,3,4,5,7,9,10]

//merge(arr: &ae, l: 0, m: 3, r: ae.count - 1)
mergeSort(arr: &ae, lft: 0, rgt: ae.count-1)
print(ae)

//q1

func reverseSortedMerge(sml:[Int], scnt:Int, big:inout [Int], bcnt:Int) {
    var se = scnt
    var be = bcnt
    var indx = big.count-1
    while se >= 0 && be >= 0 {
        if sml[se] < big[be] {
            print("big \(be)")
            big[indx] = big[be]
            be -= 1
            indx -= 1
        }else{
            big[indx] = sml[se]
            se -= 1
            indx -= 1
        }
//        print("index \(indx)")
    }
    while se >= 0 {
        big[indx] = sml[se]
        se -= 1
        indx -= 1
    }
    while be >= 0 {
        big[indx] = big[be]
        be -= 1
        indx -= 1
    }
}
var sml = [1,2,6,8]
var big = [3,4,5,0,0,0,0]
reverseSortedMerge(sml: sml, scnt: sml.count-1, big: &big, bcnt: 2)
print(big)


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
