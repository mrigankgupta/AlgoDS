//: Playground - noun: a place where people can play

import UIKit
import DataStructSet
import Foundation
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


//class NodeD<T> {
//    var data : T!
//    var left : NodeD?
//    var right: NodeD?
//    
//    init(data:T) {
//        self.data = data
//        self.left = nil
//        self.right = nil
//    }
//}
//
//
//func find<T>(root:NodeD<T>?,value:T) -> NodeD<T>? where T: Comparable & Equatable {
//    if root == nil {
//        return nil
//    }
//    if root!.data > value {
//        return find(root: root?.left, value: value)
//    }else if root!.data < value {
//        return find(root: root?.right, value: value)
//    }else if root!.data == value {
//        return root
//    }
//    return nil
//}
//
//func max<T>(root:NodeD<T>?) -> NodeD<T>? where T: Comparable & Equatable {
//    if root == nil {
//        return nil
//    }
//    var next = root
//    var prev : NodeD<T>?
//    while next != nil {
//        prev = next
//        next = next!.right
//    }
//    return prev
//}
//
//func prede<T>(root:NodeD<T>?, value:T) -> NodeD<T>? where T: Comparable & Equatable {
//    if root == nil {
//        return nil
//    }
//    let element = find(root: root, value: value)
//    if element?.left != nil {
//        return max(root:element!.left)
//    }else {
//        var next = root
//        var lastRight: NodeD<T>?
//        while next != nil {
//            if next!.data > value {
//                next = next?.left
//            }else if next!.data < value {
//                lastRight = next
//                next = next?.right
//            }else if next!.data == value {
//                break
//            }
//        }
//        return lastRight
//    }
//}
//
//func build<T>(root:NodeD<T>?, value:T) -> NodeD<T> where T: Comparable & Equatable {
//    let node = NodeD(data: value)
//    if root == nil {
//        return node
//    }
//    var next = root
//    var prev : NodeD<T>?
//    while next != nil {
//        if next!.data > value {
//            prev = next
//            next = next?.left
//        }else if next!.data < value {
//            prev = next
//            next = next?.right
//        }
//    }
//    if prev!.data > value {
//        prev?.left = node
//    }else {
//        prev?.right = node
//    }
//    return root!
//}
//
//func inorder<T>(root:NodeD<T>?) {
//    if root == nil {
//        return
//    }
//    inorder(root: root!.left)
//    print(root!.data)
//    inorder(root: root!.right)
//}
//print("hi")
//let arr = [20, 9, 8, 10, 13, 16, 29, 4, 12]
//var rr : NodeD<Int>?
//for item in arr {
//    rr = build(root: rr, value: item)
//}
//
//inorder(root: rr)
//find(root: rr, value: 4)?.data
//max(root: rr)?.data
//
//prede(root: rr, value: 12)?.data


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
/* TODO:
func path(arr:[[Int]],row:Int, col:Int, i: Int, j:Int) -> Bool {
    if arr[i][j] == 2 {
        return true
    }else if arr[i][j] == 0 || i < 0 || i > row || j < 0 || j > col {
        return false
    }
    print("still in")
    if path(arr: arr, row: row, col: col, i: i-1, j: j) || path(arr: arr, row: row, col: col, i: i+1, j: j)
        || path(arr: arr, row: row, col: col, i: i, j: j-1) || path(arr: arr, row: row, col: col, i: i, j: j+1) {
        return true
    }
    return false
}

let mat = [[ 0 , 3 , 2 ],[ 3 , 3 , 0 ],[ 1 , 3 , 0 ]]

path(arr: mat, row: 3, col: 3, i: 2, j: 0)
*/


