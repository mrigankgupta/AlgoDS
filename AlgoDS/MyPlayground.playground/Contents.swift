//: Playground - noun: a place where people can play

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
//q2


//q3

func searchRotated(arr:[Int], item: Int, start: Int, end: Int) -> Int? {
    if start > end {
        return nil
    }
    let m = start + (end - start)/2
    
    if arr[m] == item {
        return m
    } else if arr[start] < arr[end] {
        // normal binary
        if item < arr[m] {
            return searchRotated(arr: arr, item: item, start: start, end: m-1)
        } else {
            return searchRotated(arr: arr, item: item, start: m+1, end: end)
        }
    }else {
        // middle point to the right
        if arr[m] > arr[end] {
            if arr[m] > item && item > arr[start] {
                //search left
                return searchRotated(arr: arr, item: item, start: start, end: m-1)
            }else{
                return searchRotated(arr: arr, item: item, start: m+1, end: end)
            }
        }else {// middle point to the left, middle < end
            if arr[m] < item && item > arr[end] {
                //search Left
                return searchRotated(arr: arr, item: item, start: start, end: m-1)
            }else{
                return searchRotated(arr: arr, item: item, start: m+1, end: end)
            }
        }
    }
}


searchRotated(arr: [7, 10, 14, 15, 16, 19, 20, 25, 1, 3, 4, 5, ], item: 19, start: 0, end: 11)
